ALTER TABLE "public"."avatars" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."chests" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."collection_gems" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."collections" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."gems" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."invitations" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."lines" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."people" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."role_permissions" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."user_roles" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."users" ENABLE ROW LEVEL SECURITY;

SET check_function_bodies = OFF;

CREATE OR REPLACE FUNCTION public.accept_invitation(chest_id_param uuid)
  RETURNS void
  LANGUAGE plpgsql
  SECURITY DEFINER
  AS $function$
DECLARE
  ROLE app_role;
BEGIN
  -- Select the role assigned in the invitation
  SELECT
    assigned_role INTO ROLE
  FROM
    public.invitations
  WHERE
    chest_id = chest_id_param
    AND email = auth.email();
  -- Insert the role into user_roles table
  INSERT INTO public.user_roles(chest_id, user_id, ROLE)
    VALUES (chest_id_param, auth.uid(), ROLE);
  -- Delete the processed invitation
  DELETE FROM public.invitations
  WHERE chest_id = chest_id_param
    AND email = auth.email();
END;
$function$;

CREATE OR REPLACE FUNCTION public.authorize(requested_permission app_permission, chest_id uuid)
  RETURNS boolean
  LANGUAGE plpgsql
  STABLE
  SECURITY DEFINER
  SET search_path TO ''
  AS $function$
DECLARE
  bind_permissions int;
  user_role public.app_role;
BEGIN
  SELECT
    (((auth.jwt() ->> 'chests')::jsonb ->> chest_id::text)::jsonb ->> 'role')::public.app_role INTO user_role;
  SELECT
    count(*) INTO bind_permissions
  FROM
    public.role_permissions
  WHERE
    role_permissions.permission = requested_permission
    AND role_permissions.role = user_role;
  RETURN bind_permissions > 0;
END;
$function$;

CREATE OR REPLACE FUNCTION public.custom_access_token_hook(event jsonb)
  RETURNS jsonb
  LANGUAGE plpgsql
  STABLE
  AS $function$
DECLARE
  claims jsonb;
  chest_roles RECORD;
  chests_json jsonb := '{}'::jsonb;
BEGIN
  claims := event -> 'claims';
  FOR chest_roles IN
  SELECT
    ur.role,
    c.id,
    c.name
  FROM
    public.user_roles ur
    JOIN public.chests c ON ur.chest_id = c.id
  WHERE
    ur.user_id =(event ->> 'user_id')::uuid LOOP
      chests_json := jsonb_set(chests_json,('{' || chest_roles.id::text || '}')::text[], jsonb_build_object('name', chest_roles.name, 'role', chest_roles.role));
    END LOOP;
  claims := jsonb_set(claims, '{chests}', chests_json);
  event := jsonb_set(event, '{claims}', claims);
  RETURN event;
END;
$function$;

CREATE OR REPLACE FUNCTION public.fetch_distinct_gem_years(chest_id_param uuid)
  RETURNS SETOF smallint
  LANGUAGE plpgsql
  AS $function$
BEGIN
  RETURN QUERY SELECT DISTINCT
    EXTRACT(YEAR FROM occurred_at)::int2
  FROM
    public.gems
  WHERE
    chest_id = chest_id_param;
END;
$function$;

CREATE OR REPLACE FUNCTION public.fetch_random_gem_ids(chest_id_param uuid, limit_param integer)
  RETURNS SETOF uuid
  LANGUAGE plpgsql
  AS $function$
BEGIN
  RETURN QUERY
  SELECT
    id
  FROM
    public.gems
  WHERE
    chest_id = chest_id_param
  ORDER BY
    random()
  LIMIT limit_param;
END;
$function$;

CREATE OR REPLACE FUNCTION public.handle_auth_user_insert()
  RETURNS TRIGGER
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path TO ''
  AS $function$
BEGIN
  INSERT INTO public.users(id, username)
    VALUES(NEW.id, NEW.raw_user_meta_data ->> 'display_name');
  RETURN new;
END;
$function$;

CREATE OR REPLACE FUNCTION public.handle_auth_user_update()
  RETURNS TRIGGER
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path TO ''
  AS $function$
BEGIN
  UPDATE
    public.users
  SET
    username = NEW.raw_user_meta_data ->> 'display_name'
  WHERE
    id = NEW.id
    AND username != NULL;
  RETURN new;
END;
$function$;

CREATE OR REPLACE FUNCTION public.handle_chest_insert()
  RETURNS TRIGGER
  LANGUAGE plpgsql
  SECURITY DEFINER
  AS $function$
DECLARE
  personID int;
  gemID uuid;
BEGIN
  INSERT INTO public.user_roles(user_id, chest_id, ROLE)
    VALUES (auth.uid(), NEW.id, 'owner');
  INSERT INTO public.people(nickname, date_of_birth, chest_id)
    VALUES ('Jacob from ChuckleChest', '2003-03-10', NEW.id)
  RETURNING
    id INTO personID;
  INSERT INTO public.gems(chest_id)
    VALUES (NEW.id)
  RETURNING
    id INTO gemID;
  INSERT INTO public.lines(chest_id, gem_id, person_id, text)
    VALUES (NEW.id, gemID, personID, 'Hi there! Doing ok?'),
(NEW.id, gemID, personID, 'Great! Then let me show you how to use ChuckleChest.');
  RETURN NEW;
END;
$function$;

CREATE OR REPLACE FUNCTION public.handle_gem_insert()
  RETURNS TRIGGER
  LANGUAGE plpgsql
  AS $function$
DECLARE
  colID bigint;
BEGIN
  NEW.number :=(
    SELECT
      COALESCE(MAX(number), 0)
    FROM
      public.gems
    WHERE
      chest_id = NEW.chest_id) + 1;
  RETURN NEW;
END;
$function$;

CREATE OR REPLACE FUNCTION public.fetch_collection_gem_from_share_token(share_token_param uuid, gem_id_param uuid)
  RETURNS jsonb
  LANGUAGE plpgsql
  SECURITY DEFINER
  AS $function$
DECLARE
  collection_id_var uuid;
  result_var jsonb;
BEGIN
  SELECT
    collection_id INTO collection_id_var
  FROM
    public.collection_share_tokens
  WHERE
    token = share_token_param
  LIMIT 1;
  IF EXISTS (
    SELECT
      1
    FROM
      public.collection_gems
    WHERE
      collection_id = collection_id_var
      AND gem_id = gem_id_param) THEN
  result_var := fetch_gem_with_people(gem_id_param);
  RETURN result_var;
END IF;
  RAISE 'Permission denied. Share token not associated with the gem ID.';
END;
$function$;

CREATE OR REPLACE FUNCTION public.fetch_collection_gem_ids_from_share_token(share_token_param uuid)
  RETURNS SETOF uuid
  LANGUAGE plpgsql
  SECURITY DEFINER
  AS $function$
DECLARE
  collection_id_var uuid;
BEGIN
  SELECT
    collection_id INTO collection_id_var
  FROM
    public.collection_share_tokens
  WHERE
    token = share_token_param;
  RETURN QUERY
  SELECT
    gem_id
  FROM
    public.collection_gems
  WHERE
    collection_id = collection_id_var;
END;
$function$;

CREATE OR REPLACE FUNCTION public.fetch_gem_from_share_token(share_token_param uuid)
  RETURNS jsonb
  LANGUAGE plpgsql
  SECURITY DEFINER
  AS $function$
DECLARE
  gem_id_var uuid;
  result_var jsonb;
BEGIN
  SELECT
    gem_id INTO gem_id_var
  FROM
    public.gem_share_tokens
  WHERE
    token = share_token_param
  LIMIT 1;
  result_var := fetch_gem_with_people(gem_id_var);
  RETURN result_var;
END;
$function$;

CREATE OR REPLACE FUNCTION public.fetch_gem_with_people(gem_id_param uuid)
  RETURNS jsonb
  LANGUAGE plpgsql
  AS $function$
DECLARE
  gem_data_var jsonb;
  lines_data_var jsonb;
  people_data_var jsonb;
BEGIN
  SELECT
    row_to_json(g) INTO gem_data_var
  FROM
    public.gems g
  WHERE
    g.id = gem_id_param
  LIMIT 1;
  -- Fetch the lines associated with the gem
  SELECT
    jsonb_agg(DISTINCT l) FILTER (WHERE l.id IS NOT NULL) INTO lines_data_var
  FROM
    public.lines l
  WHERE
    l.gem_id = gem_id_param;
  -- Fetch the people associated with the lines
  SELECT
    jsonb_agg(DISTINCT p) FILTER (WHERE p.id IS NOT NULL) INTO people_data_var
  FROM
    public.people p
  WHERE
    p.id IN (
      SELECT
        l.person_id
      FROM
        public.lines l
      WHERE
        l.gem_id = gem_id_param);
  -- Combine gem_data, lines_data, and people_data into a single JSONB object
  RETURN jsonb_build_object('gem', jsonb_set(gem_data_var, '{lines}', lines_data_var, TRUE), 'people', people_data_var);
END;
$function$;

GRANT DELETE ON TABLE "public"."avatars" TO "anon";

GRANT INSERT ON TABLE "public"."avatars" TO "anon";

GRANT REFERENCES ON TABLE "public"."avatars" TO "anon";

GRANT SELECT ON TABLE "public"."avatars" TO "anon";

GRANT TRIGGER ON TABLE "public"."avatars" TO "anon";

GRANT TRUNCATE ON TABLE "public"."avatars" TO "anon";

GRANT UPDATE ON TABLE "public"."avatars" TO "anon";

GRANT DELETE ON TABLE "public"."avatars" TO "authenticated";

GRANT INSERT ON TABLE "public"."avatars" TO "authenticated";

GRANT REFERENCES ON TABLE "public"."avatars" TO "authenticated";

GRANT SELECT ON TABLE "public"."avatars" TO "authenticated";

GRANT TRIGGER ON TABLE "public"."avatars" TO "authenticated";

GRANT TRUNCATE ON TABLE "public"."avatars" TO "authenticated";

GRANT UPDATE ON TABLE "public"."avatars" TO "authenticated";

GRANT DELETE ON TABLE "public"."avatars" TO "service_role";

GRANT INSERT ON TABLE "public"."avatars" TO "service_role";

GRANT REFERENCES ON TABLE "public"."avatars" TO "service_role";

GRANT SELECT ON TABLE "public"."avatars" TO "service_role";

GRANT TRIGGER ON TABLE "public"."avatars" TO "service_role";

GRANT TRUNCATE ON TABLE "public"."avatars" TO "service_role";

GRANT UPDATE ON TABLE "public"."avatars" TO "service_role";

GRANT DELETE ON TABLE "public"."chests" TO "anon";

GRANT INSERT ON TABLE "public"."chests" TO "anon";

GRANT REFERENCES ON TABLE "public"."chests" TO "anon";

GRANT SELECT ON TABLE "public"."chests" TO "anon";

GRANT TRIGGER ON TABLE "public"."chests" TO "anon";

GRANT TRUNCATE ON TABLE "public"."chests" TO "anon";

GRANT UPDATE ON TABLE "public"."chests" TO "anon";

GRANT DELETE ON TABLE "public"."chests" TO "authenticated";

GRANT INSERT ON TABLE "public"."chests" TO "authenticated";

GRANT REFERENCES ON TABLE "public"."chests" TO "authenticated";

GRANT SELECT ON TABLE "public"."chests" TO "authenticated";

GRANT TRIGGER ON TABLE "public"."chests" TO "authenticated";

GRANT TRUNCATE ON TABLE "public"."chests" TO "authenticated";

GRANT UPDATE ON TABLE "public"."chests" TO "authenticated";

GRANT DELETE ON TABLE "public"."chests" TO "service_role";

GRANT INSERT ON TABLE "public"."chests" TO "service_role";

GRANT REFERENCES ON TABLE "public"."chests" TO "service_role";

GRANT SELECT ON TABLE "public"."chests" TO "service_role";

GRANT TRIGGER ON TABLE "public"."chests" TO "service_role";

GRANT TRUNCATE ON TABLE "public"."chests" TO "service_role";

GRANT UPDATE ON TABLE "public"."chests" TO "service_role";

GRANT DELETE ON TABLE "public"."chests" TO "supabase_auth_admin";

GRANT INSERT ON TABLE "public"."chests" TO "supabase_auth_admin";

GRANT REFERENCES ON TABLE "public"."chests" TO "supabase_auth_admin";

GRANT SELECT ON TABLE "public"."chests" TO "supabase_auth_admin";

GRANT TRIGGER ON TABLE "public"."chests" TO "supabase_auth_admin";

GRANT TRUNCATE ON TABLE "public"."chests" TO "supabase_auth_admin";

GRANT UPDATE ON TABLE "public"."chests" TO "supabase_auth_admin";

GRANT DELETE ON TABLE "public"."collection_gems" TO "anon";

GRANT INSERT ON TABLE "public"."collection_gems" TO "anon";

GRANT REFERENCES ON TABLE "public"."collection_gems" TO "anon";

GRANT SELECT ON TABLE "public"."collection_gems" TO "anon";

GRANT TRIGGER ON TABLE "public"."collection_gems" TO "anon";

GRANT TRUNCATE ON TABLE "public"."collection_gems" TO "anon";

GRANT UPDATE ON TABLE "public"."collection_gems" TO "anon";

GRANT DELETE ON TABLE "public"."collection_gems" TO "authenticated";

GRANT INSERT ON TABLE "public"."collection_gems" TO "authenticated";

GRANT REFERENCES ON TABLE "public"."collection_gems" TO "authenticated";

GRANT SELECT ON TABLE "public"."collection_gems" TO "authenticated";

GRANT TRIGGER ON TABLE "public"."collection_gems" TO "authenticated";

GRANT TRUNCATE ON TABLE "public"."collection_gems" TO "authenticated";

GRANT UPDATE ON TABLE "public"."collection_gems" TO "authenticated";

GRANT DELETE ON TABLE "public"."collection_gems" TO "service_role";

GRANT INSERT ON TABLE "public"."collection_gems" TO "service_role";

GRANT REFERENCES ON TABLE "public"."collection_gems" TO "service_role";

GRANT SELECT ON TABLE "public"."collection_gems" TO "service_role";

GRANT TRIGGER ON TABLE "public"."collection_gems" TO "service_role";

GRANT TRUNCATE ON TABLE "public"."collection_gems" TO "service_role";

GRANT UPDATE ON TABLE "public"."collection_gems" TO "service_role";

GRANT DELETE ON TABLE "public"."collections" TO "anon";

GRANT INSERT ON TABLE "public"."collections" TO "anon";

GRANT REFERENCES ON TABLE "public"."collections" TO "anon";

GRANT SELECT ON TABLE "public"."collections" TO "anon";

GRANT TRIGGER ON TABLE "public"."collections" TO "anon";

GRANT TRUNCATE ON TABLE "public"."collections" TO "anon";

GRANT UPDATE ON TABLE "public"."collections" TO "anon";

GRANT DELETE ON TABLE "public"."collections" TO "authenticated";

GRANT INSERT ON TABLE "public"."collections" TO "authenticated";

GRANT REFERENCES ON TABLE "public"."collections" TO "authenticated";

GRANT SELECT ON TABLE "public"."collections" TO "authenticated";

GRANT TRIGGER ON TABLE "public"."collections" TO "authenticated";

GRANT TRUNCATE ON TABLE "public"."collections" TO "authenticated";

GRANT UPDATE ON TABLE "public"."collections" TO "authenticated";

GRANT DELETE ON TABLE "public"."collections" TO "service_role";

GRANT INSERT ON TABLE "public"."collections" TO "service_role";

GRANT REFERENCES ON TABLE "public"."collections" TO "service_role";

GRANT SELECT ON TABLE "public"."collections" TO "service_role";

GRANT TRIGGER ON TABLE "public"."collections" TO "service_role";

GRANT TRUNCATE ON TABLE "public"."collections" TO "service_role";

GRANT UPDATE ON TABLE "public"."collections" TO "service_role";

GRANT DELETE ON TABLE "public"."gems" TO "anon";

GRANT INSERT ON TABLE "public"."gems" TO "anon";

GRANT REFERENCES ON TABLE "public"."gems" TO "anon";

GRANT SELECT ON TABLE "public"."gems" TO "anon";

GRANT TRIGGER ON TABLE "public"."gems" TO "anon";

GRANT TRUNCATE ON TABLE "public"."gems" TO "anon";

GRANT UPDATE ON TABLE "public"."gems" TO "anon";

GRANT DELETE ON TABLE "public"."gems" TO "authenticated";

GRANT INSERT ON TABLE "public"."gems" TO "authenticated";

GRANT REFERENCES ON TABLE "public"."gems" TO "authenticated";

GRANT SELECT ON TABLE "public"."gems" TO "authenticated";

GRANT TRIGGER ON TABLE "public"."gems" TO "authenticated";

GRANT TRUNCATE ON TABLE "public"."gems" TO "authenticated";

GRANT UPDATE ON TABLE "public"."gems" TO "authenticated";

GRANT DELETE ON TABLE "public"."gems" TO "service_role";

GRANT INSERT ON TABLE "public"."gems" TO "service_role";

GRANT REFERENCES ON TABLE "public"."gems" TO "service_role";

GRANT SELECT ON TABLE "public"."gems" TO "service_role";

GRANT TRIGGER ON TABLE "public"."gems" TO "service_role";

GRANT TRUNCATE ON TABLE "public"."gems" TO "service_role";

GRANT UPDATE ON TABLE "public"."gems" TO "service_role";

GRANT DELETE ON TABLE "public"."invitations" TO "anon";

GRANT INSERT ON TABLE "public"."invitations" TO "anon";

GRANT REFERENCES ON TABLE "public"."invitations" TO "anon";

GRANT SELECT ON TABLE "public"."invitations" TO "anon";

GRANT TRIGGER ON TABLE "public"."invitations" TO "anon";

GRANT TRUNCATE ON TABLE "public"."invitations" TO "anon";

GRANT UPDATE ON TABLE "public"."invitations" TO "anon";

GRANT DELETE ON TABLE "public"."invitations" TO "authenticated";

GRANT INSERT ON TABLE "public"."invitations" TO "authenticated";

GRANT REFERENCES ON TABLE "public"."invitations" TO "authenticated";

GRANT SELECT ON TABLE "public"."invitations" TO "authenticated";

GRANT TRIGGER ON TABLE "public"."invitations" TO "authenticated";

GRANT TRUNCATE ON TABLE "public"."invitations" TO "authenticated";

GRANT UPDATE ON TABLE "public"."invitations" TO "authenticated";

GRANT DELETE ON TABLE "public"."invitations" TO "service_role";

GRANT INSERT ON TABLE "public"."invitations" TO "service_role";

GRANT REFERENCES ON TABLE "public"."invitations" TO "service_role";

GRANT SELECT ON TABLE "public"."invitations" TO "service_role";

GRANT TRIGGER ON TABLE "public"."invitations" TO "service_role";

GRANT TRUNCATE ON TABLE "public"."invitations" TO "service_role";

GRANT UPDATE ON TABLE "public"."invitations" TO "service_role";

GRANT DELETE ON TABLE "public"."lines" TO "anon";

GRANT INSERT ON TABLE "public"."lines" TO "anon";

GRANT REFERENCES ON TABLE "public"."lines" TO "anon";

GRANT SELECT ON TABLE "public"."lines" TO "anon";

GRANT TRIGGER ON TABLE "public"."lines" TO "anon";

GRANT TRUNCATE ON TABLE "public"."lines" TO "anon";

GRANT UPDATE ON TABLE "public"."lines" TO "anon";

GRANT DELETE ON TABLE "public"."lines" TO "authenticated";

GRANT INSERT ON TABLE "public"."lines" TO "authenticated";

GRANT REFERENCES ON TABLE "public"."lines" TO "authenticated";

GRANT SELECT ON TABLE "public"."lines" TO "authenticated";

GRANT TRIGGER ON TABLE "public"."lines" TO "authenticated";

GRANT TRUNCATE ON TABLE "public"."lines" TO "authenticated";

GRANT UPDATE ON TABLE "public"."lines" TO "authenticated";

GRANT DELETE ON TABLE "public"."lines" TO "service_role";

GRANT INSERT ON TABLE "public"."lines" TO "service_role";

GRANT REFERENCES ON TABLE "public"."lines" TO "service_role";

GRANT SELECT ON TABLE "public"."lines" TO "service_role";

GRANT TRIGGER ON TABLE "public"."lines" TO "service_role";

GRANT TRUNCATE ON TABLE "public"."lines" TO "service_role";

GRANT UPDATE ON TABLE "public"."lines" TO "service_role";

GRANT DELETE ON TABLE "public"."people" TO "anon";

GRANT INSERT ON TABLE "public"."people" TO "anon";

GRANT REFERENCES ON TABLE "public"."people" TO "anon";

GRANT SELECT ON TABLE "public"."people" TO "anon";

GRANT TRIGGER ON TABLE "public"."people" TO "anon";

GRANT TRUNCATE ON TABLE "public"."people" TO "anon";

GRANT UPDATE ON TABLE "public"."people" TO "anon";

GRANT DELETE ON TABLE "public"."people" TO "authenticated";

GRANT INSERT ON TABLE "public"."people" TO "authenticated";

GRANT REFERENCES ON TABLE "public"."people" TO "authenticated";

GRANT SELECT ON TABLE "public"."people" TO "authenticated";

GRANT TRIGGER ON TABLE "public"."people" TO "authenticated";

GRANT TRUNCATE ON TABLE "public"."people" TO "authenticated";

GRANT UPDATE ON TABLE "public"."people" TO "authenticated";

GRANT DELETE ON TABLE "public"."people" TO "service_role";

GRANT INSERT ON TABLE "public"."people" TO "service_role";

GRANT REFERENCES ON TABLE "public"."people" TO "service_role";

GRANT SELECT ON TABLE "public"."people" TO "service_role";

GRANT TRIGGER ON TABLE "public"."people" TO "service_role";

GRANT TRUNCATE ON TABLE "public"."people" TO "service_role";

GRANT UPDATE ON TABLE "public"."people" TO "service_role";

GRANT DELETE ON TABLE "public"."role_permissions" TO "anon";

GRANT INSERT ON TABLE "public"."role_permissions" TO "anon";

GRANT REFERENCES ON TABLE "public"."role_permissions" TO "anon";

GRANT SELECT ON TABLE "public"."role_permissions" TO "anon";

GRANT TRIGGER ON TABLE "public"."role_permissions" TO "anon";

GRANT TRUNCATE ON TABLE "public"."role_permissions" TO "anon";

GRANT UPDATE ON TABLE "public"."role_permissions" TO "anon";

GRANT DELETE ON TABLE "public"."role_permissions" TO "authenticated";

GRANT INSERT ON TABLE "public"."role_permissions" TO "authenticated";

GRANT REFERENCES ON TABLE "public"."role_permissions" TO "authenticated";

GRANT SELECT ON TABLE "public"."role_permissions" TO "authenticated";

GRANT TRIGGER ON TABLE "public"."role_permissions" TO "authenticated";

GRANT TRUNCATE ON TABLE "public"."role_permissions" TO "authenticated";

GRANT UPDATE ON TABLE "public"."role_permissions" TO "authenticated";

GRANT DELETE ON TABLE "public"."role_permissions" TO "service_role";

GRANT INSERT ON TABLE "public"."role_permissions" TO "service_role";

GRANT REFERENCES ON TABLE "public"."role_permissions" TO "service_role";

GRANT SELECT ON TABLE "public"."role_permissions" TO "service_role";

GRANT TRIGGER ON TABLE "public"."role_permissions" TO "service_role";

GRANT TRUNCATE ON TABLE "public"."role_permissions" TO "service_role";

GRANT UPDATE ON TABLE "public"."role_permissions" TO "service_role";

GRANT DELETE ON TABLE "public"."user_roles" TO "service_role";

GRANT INSERT ON TABLE "public"."user_roles" TO "service_role";

GRANT REFERENCES ON TABLE "public"."user_roles" TO "service_role";

GRANT SELECT ON TABLE "public"."user_roles" TO "service_role";

GRANT TRIGGER ON TABLE "public"."user_roles" TO "service_role";

GRANT TRUNCATE ON TABLE "public"."user_roles" TO "service_role";

GRANT UPDATE ON TABLE "public"."user_roles" TO "service_role";

GRANT DELETE ON TABLE "public"."user_roles" TO "supabase_auth_admin";

GRANT INSERT ON TABLE "public"."user_roles" TO "supabase_auth_admin";

GRANT REFERENCES ON TABLE "public"."user_roles" TO "supabase_auth_admin";

GRANT SELECT ON TABLE "public"."user_roles" TO "supabase_auth_admin";

GRANT TRIGGER ON TABLE "public"."user_roles" TO "supabase_auth_admin";

GRANT TRUNCATE ON TABLE "public"."user_roles" TO "supabase_auth_admin";

GRANT UPDATE ON TABLE "public"."user_roles" TO "supabase_auth_admin";

GRANT DELETE ON TABLE "public"."users" TO "anon";

GRANT INSERT ON TABLE "public"."users" TO "anon";

GRANT DELETE ON TABLE "public"."user_roles" TO "anon";

GRANT INSERT ON TABLE "public"."user_roles" TO "anon";

GRANT REFERENCES ON TABLE "public"."user_roles" TO "anon";

GRANT SELECT ON TABLE "public"."user_roles" TO "anon";

GRANT TRIGGER ON TABLE "public"."user_roles" TO "anon";

GRANT TRUNCATE ON TABLE "public"."user_roles" TO "anon";

GRANT UPDATE ON TABLE "public"."user_roles" TO "anon";

GRANT DELETE ON TABLE "public"."user_roles" TO "authenticated";

GRANT INSERT ON TABLE "public"."user_roles" TO "authenticated";

GRANT REFERENCES ON TABLE "public"."user_roles" TO "authenticated";

GRANT SELECT ON TABLE "public"."user_roles" TO "authenticated";

GRANT TRIGGER ON TABLE "public"."user_roles" TO "authenticated";

GRANT TRUNCATE ON TABLE "public"."user_roles" TO "authenticated";

GRANT UPDATE ON TABLE "public"."user_roles" TO "authenticated";

GRANT REFERENCES ON TABLE "public"."users" TO "anon";

GRANT SELECT ON TABLE "public"."users" TO "anon";

GRANT TRIGGER ON TABLE "public"."users" TO "anon";

GRANT TRUNCATE ON TABLE "public"."users" TO "anon";

GRANT UPDATE ON TABLE "public"."users" TO "anon";

GRANT DELETE ON TABLE "public"."users" TO "authenticated";

GRANT INSERT ON TABLE "public"."users" TO "authenticated";

GRANT REFERENCES ON TABLE "public"."users" TO "authenticated";

GRANT SELECT ON TABLE "public"."users" TO "authenticated";

GRANT TRIGGER ON TABLE "public"."users" TO "authenticated";

GRANT TRUNCATE ON TABLE "public"."users" TO "authenticated";

GRANT UPDATE ON TABLE "public"."users" TO "authenticated";

GRANT DELETE ON TABLE "public"."users" TO "service_role";

GRANT INSERT ON TABLE "public"."users" TO "service_role";

GRANT REFERENCES ON TABLE "public"."users" TO "service_role";

GRANT SELECT ON TABLE "public"."users" TO "service_role";

GRANT TRIGGER ON TABLE "public"."users" TO "service_role";

GRANT TRUNCATE ON TABLE "public"."users" TO "service_role";

GRANT UPDATE ON TABLE "public"."users" TO "service_role";

DROP POLICY IF EXISTS "Allow authorized delete access" ON "public"."avatars";

CREATE POLICY "Allow authorized delete access" ON "public"."avatars" AS permissive
  FOR DELETE TO authenticated
    USING (authorize('person_avatar_urls.delete'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized insert access" ON "public"."avatars";

CREATE POLICY "Allow authorized insert access" ON "public"."avatars" AS permissive
  FOR INSERT TO authenticated
    WITH CHECK (authorize('person_avatar_urls.insert'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized select access" ON "public"."avatars";

CREATE POLICY "Allow authorized select access" ON "public"."avatars" AS permissive
  FOR SELECT TO authenticated
    USING (authorize('person_avatar_urls.select'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized update access" ON "public"."avatars";

CREATE POLICY "Allow authorized update access" ON "public"."avatars" AS permissive
  FOR UPDATE TO authenticated
    USING (authorize('person_avatar_urls.update'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized delete access" ON "public"."chests";

CREATE POLICY "Allow authorized delete access" ON "public"."chests" AS permissive
  FOR DELETE TO authenticated
    USING (authorize('chests.delete'::app_permission, id));

DROP POLICY IF EXISTS "Allow authorized select access" ON "public"."chests";

CREATE POLICY "Allow authorized select access" ON "public"."chests" AS permissive
  FOR SELECT TO authenticated
    USING (authorize('chests.select'::app_permission, id));

DROP POLICY IF EXISTS "Allow authorized update access" ON "public"."chests";

CREATE POLICY "Allow authorized update access" ON "public"."chests" AS permissive
  FOR UPDATE TO authenticated
    USING (authorize('chests.update'::app_permission, id));

DROP POLICY IF EXISTS "Allow insert access for authenticated" ON "public"."chests";

CREATE POLICY "Allow insert access for authenticated" ON "public"."chests" AS permissive
  FOR INSERT TO authenticated
    WITH CHECK (TRUE);

DROP POLICY IF EXISTS "Allow select access for custom_access_token_hook" ON "public"."chests";

CREATE POLICY "Allow select access for custom_access_token_hook" ON "public"."chests" AS permissive
  FOR SELECT TO supabase_auth_admin
    USING (TRUE);

DROP POLICY IF EXISTS "Allow select access for invited users" ON "public"."chests";

CREATE POLICY "Allow select access for invited users" ON "public"."chests" AS permissive
  FOR SELECT TO authenticated
    USING ((EXISTS (
      SELECT
        1
      FROM
        invitations
      WHERE ((invitations.chest_id = chests.id) AND (invitations.email = auth.email())))));

DROP POLICY IF EXISTS "Allow select access for new creators" ON "public"."chests";

CREATE POLICY "Allow select access for new creators" ON "public"."chests" AS permissive
  FOR SELECT TO authenticated
    USING ((auth.uid() = created_by));

DROP POLICY IF EXISTS "Allow authorized delete access" ON "public"."collection_gems";

CREATE POLICY "Allow authorized delete access" ON "public"."collection_gems" AS permissive
  FOR DELETE TO authenticated
    USING (authorize('collections.delete'::app_permission,(
      SELECT
        collections.chest_id
      FROM
        collections
      WHERE (collections.id = collection_gems.collection_id))));

DROP POLICY IF EXISTS "Allow authorized insert access" ON "public"."collection_gems";

CREATE POLICY "Allow authorized insert access" ON "public"."collection_gems" AS permissive
  FOR INSERT TO authenticated
    WITH CHECK (authorize('collections.insert'::app_permission,(
      SELECT
        collections.chest_id
      FROM
        collections
      WHERE (collections.id = collection_gems.collection_id))));

DROP POLICY IF EXISTS "Allow authorized select access" ON "public"."collection_gems";

CREATE POLICY "Allow authorized select access" ON "public"."collection_gems" AS permissive
  FOR SELECT TO authenticated
    USING (authorize('collections.select'::app_permission,(
      SELECT
        collections.chest_id
      FROM
        collections
      WHERE (collections.id = collection_gems.collection_id))));

DROP POLICY IF EXISTS "Allow authorized update access" ON "public"."collection_gems";

CREATE POLICY "Allow authorized update access" ON "public"."collection_gems" AS permissive
  FOR UPDATE TO authenticated
    USING (authorize('collections.update'::app_permission,(
      SELECT
        collections.chest_id
      FROM
        collections
      WHERE (collections.id = collection_gems.collection_id))));

DROP POLICY IF EXISTS "Allow authorized delete access" ON "public"."collections";

CREATE POLICY "Allow authorized delete access" ON "public"."collections" AS permissive
  FOR DELETE TO authenticated
    USING (authorize('collections.delete'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized insert access" ON "public"."collections";

CREATE POLICY "Allow authorized insert access" ON "public"."collections" AS permissive
  FOR INSERT TO authenticated
    WITH CHECK (authorize('collections.insert'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized select access" ON "public"."collections";

CREATE POLICY "Allow authorized select access" ON "public"."collections" AS permissive
  FOR SELECT TO authenticated
    USING (authorize('collections.select'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized update access" ON "public"."collections";

CREATE POLICY "Allow authorized update access" ON "public"."collections" AS permissive
  FOR UPDATE TO authenticated
    USING (authorize('collections.update'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized delete access" ON "public"."gems";

CREATE POLICY "Allow authorized delete access" ON "public"."gems" AS permissive
  FOR DELETE TO authenticated
    USING (authorize('gems.delete'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized insert access" ON "public"."gems";

CREATE POLICY "Allow authorized insert access" ON "public"."gems" AS permissive
  FOR INSERT TO authenticated
    WITH CHECK (authorize('gems.insert'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized select access" ON "public"."gems";

CREATE POLICY "Allow authorized select access" ON "public"."gems" AS permissive
  FOR SELECT TO authenticated
    USING (authorize('gems.select'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized update access" ON "public"."gems";

CREATE POLICY "Allow authorized update access" ON "public"."gems" AS permissive
  FOR UPDATE TO authenticated
    USING (authorize('gems.update'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized delete access" ON "public"."invitations";

CREATE POLICY "Allow authorized delete access" ON "public"."invitations" AS permissive
  FOR DELETE TO authenticated
    USING (authorize('invitations.delete'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized insert access" ON "public"."invitations";

CREATE POLICY "Allow authorized insert access" ON "public"."invitations" AS permissive
  FOR INSERT TO authenticated
    WITH CHECK (authorize('invitations.insert'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized select access" ON "public"."invitations";

CREATE POLICY "Allow authorized select access" ON "public"."invitations" AS permissive
  FOR SELECT TO authenticated
    USING ((authorize('invitations.select'::app_permission, chest_id) OR (email = auth.email())));

DROP POLICY IF EXISTS "Allow authorized update access" ON "public"."invitations";

CREATE POLICY "Allow authorized update access" ON "public"."invitations" AS permissive
  FOR UPDATE TO authenticated
    USING (authorize('invitations.update'::app_permission, chest_id));

DROP POLICY IF EXISTS "Restrict access if assigned_role is owner" ON "public"."invitations";

CREATE POLICY "Restrict access if assigned_role is owner" ON "public"."invitations" AS restrictive
  FOR ALL TO authenticated
    USING ((assigned_role <> 'owner'::app_role));

DROP POLICY IF EXISTS "Allow authorized delete access" ON "public"."lines";

CREATE POLICY "Allow authorized delete access" ON "public"."lines" AS permissive
  FOR DELETE TO authenticated
    USING (authorize('lines.delete'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized insert access" ON "public"."lines";

CREATE POLICY "Allow authorized insert access" ON "public"."lines" AS permissive
  FOR INSERT TO authenticated
    WITH CHECK (authorize('lines.insert'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized select access" ON "public"."lines";

CREATE POLICY "Allow authorized select access" ON "public"."lines" AS permissive
  FOR SELECT TO authenticated
    USING (authorize('lines.select'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized update access" ON "public"."lines";

CREATE POLICY "Allow authorized update access" ON "public"."lines" AS permissive
  FOR UPDATE TO authenticated
    USING (authorize('lines.update'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized delete access" ON "public"."people";

CREATE POLICY "Allow authorized delete access" ON "public"."people" AS permissive
  FOR DELETE TO authenticated
    USING (authorize('people.delete'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized insert access" ON "public"."people";

CREATE POLICY "Allow authorized insert access" ON "public"."people" AS permissive
  FOR INSERT TO authenticated
    WITH CHECK (authorize('people.insert'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized select access" ON "public"."people";

CREATE POLICY "Allow authorized select access" ON "public"."people" AS permissive
  FOR SELECT TO authenticated
    USING (authorize('people.select'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized update access" ON "public"."people";

CREATE POLICY "Allow authorized update access" ON "public"."people" AS permissive
  FOR UPDATE TO authenticated
    USING (authorize('people.update'::app_permission, chest_id));

DROP POLICY IF EXISTS "Restrict all access" ON "public"."role_permissions";

CREATE POLICY "Restrict all access" ON "public"."role_permissions" AS restrictive
  FOR ALL TO public
    USING (FALSE);

DROP POLICY IF EXISTS "Allow all access for supabase admin" ON "public"."user_roles";

CREATE POLICY "Allow all access for supabase admin" ON "public"."user_roles" AS permissive
  FOR ALL TO supabase_admin
    USING (TRUE);

DROP POLICY IF EXISTS "Allow select access for auth admin" ON "public"."user_roles";

CREATE POLICY "Allow select access for auth admin" ON "public"."user_roles" AS permissive
  FOR SELECT TO supabase_auth_admin
    USING (TRUE);

DROP POLICY IF EXISTS "Allow authorized select access" ON "public"."user_roles";

CREATE POLICY "Allow authorized select access" ON "public"."user_roles" AS permissive
  FOR SELECT TO authenticated
    USING ((authorize('user_roles.select'::app_permission, chest_id) AND (user_id <> auth.uid())));

DROP POLICY IF EXISTS "Allow authorized update access" ON "public"."user_roles";

CREATE POLICY "Allow authorized update access" ON "public"."user_roles" AS permissive
  FOR UPDATE TO authenticated
    USING ((authorize('user_roles.update'::app_permission, chest_id) AND (user_id <> auth.uid())));

DROP POLICY IF EXISTS "Allow select access for authenticated users from the same chest" ON "public"."users";

CREATE POLICY "Allow select access for authenticated users from the same chest" ON "public"."users" AS permissive
  FOR SELECT TO authenticated
    USING ((EXISTS (
      SELECT
        1
      FROM
        user_roles ur
      WHERE (EXISTS (
        SELECT
          1
        FROM
          jsonb_object_keys(((auth.jwt() ->> 'chests'::text))::jsonb) chest_key(chest_key)
        WHERE (chest_key.chest_key =(ur.chest_id)::text))))));

DROP POLICY IF EXISTS "Allow users to insert their own profiles" ON "public"."users";

CREATE POLICY "Allow users to insert their own profiles" ON "public"."users" AS permissive
  FOR INSERT TO authenticated
    WITH CHECK ((auth.uid() = id));

DROP POLICY IF EXISTS "Allow users to update their own profiles" ON "public"."users";

CREATE POLICY "Allow users to update their own profiles" ON "public"."users" AS permissive
  FOR UPDATE TO authenticated
    USING ((auth.uid() = id));

DROP TRIGGER IF EXISTS on_chest_inserted ON public.chests;

CREATE TRIGGER on_chest_inserted
  AFTER INSERT ON public.chests
  FOR EACH ROW
  EXECUTE FUNCTION handle_chest_insert();

DROP TRIGGER IF EXISTS on_gem_inserted ON public.gems;

CREATE TRIGGER on_gem_inserted
  BEFORE INSERT ON public.gems
  FOR EACH ROW
  EXECUTE FUNCTION handle_gem_insert();

