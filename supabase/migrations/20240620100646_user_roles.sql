CREATE TYPE "public"."app_permission" AS enum(
  'chests.insert',
  'chests.select',
  'chests.update',
  'chests.delete',
  'collections.insert',
  'collections.select',
  'collections.update',
  'collections.delete',
  'people.insert',
  'people.select',
  'people.update',
  'people.delete',
  'person_avatar_urls.insert',
  'person_avatar_urls.select',
  'person_avatar_urls.update',
  'person_avatar_urls.delete',
  'gems.insert',
  'gems.select',
  'gems.update',
  'gems.delete',
  'lines.insert',
  'lines.select',
  'lines.update',
  'lines.delete',
  'invitations.insert',
  'invitations.select',
  'invitations.update',
  'invitations.delete'
);

CREATE TYPE "public"."app_role" AS enum(
  'owner',
  'collaborator',
  'viewer'
);

DROP POLICY "Enable read access for all users" ON "public"."connection_avatar_urls";

DROP POLICY "Enable read access for all users" ON "public"."connections";

DROP POLICY "Enable read access for all users" ON "public"."gems";

DROP POLICY "Enable read access for all users" ON "public"."lines";

REVOKE DELETE ON TABLE "public"."connection_avatar_urls" FROM "anon";

REVOKE INSERT ON TABLE "public"."connection_avatar_urls" FROM "anon";

REVOKE REFERENCES ON TABLE "public"."connection_avatar_urls" FROM "anon";

REVOKE SELECT ON TABLE "public"."connection_avatar_urls" FROM "anon";

REVOKE TRIGGER ON TABLE "public"."connection_avatar_urls" FROM "anon";

REVOKE TRUNCATE ON TABLE "public"."connection_avatar_urls" FROM "anon";

REVOKE UPDATE ON TABLE "public"."connection_avatar_urls" FROM "anon";

REVOKE DELETE ON TABLE "public"."connection_avatar_urls" FROM "authenticated";

REVOKE INSERT ON TABLE "public"."connection_avatar_urls" FROM "authenticated";

REVOKE REFERENCES ON TABLE "public"."connection_avatar_urls" FROM "authenticated";

REVOKE SELECT ON TABLE "public"."connection_avatar_urls" FROM "authenticated";

REVOKE TRIGGER ON TABLE "public"."connection_avatar_urls" FROM "authenticated";

REVOKE TRUNCATE ON TABLE "public"."connection_avatar_urls" FROM "authenticated";

REVOKE UPDATE ON TABLE "public"."connection_avatar_urls" FROM "authenticated";

REVOKE DELETE ON TABLE "public"."connection_avatar_urls" FROM "service_role";

REVOKE INSERT ON TABLE "public"."connection_avatar_urls" FROM "service_role";

REVOKE REFERENCES ON TABLE "public"."connection_avatar_urls" FROM "service_role";

REVOKE SELECT ON TABLE "public"."connection_avatar_urls" FROM "service_role";

REVOKE TRIGGER ON TABLE "public"."connection_avatar_urls" FROM "service_role";

REVOKE TRUNCATE ON TABLE "public"."connection_avatar_urls" FROM "service_role";

REVOKE UPDATE ON TABLE "public"."connection_avatar_urls" FROM "service_role";

REVOKE DELETE ON TABLE "public"."connections" FROM "anon";

REVOKE INSERT ON TABLE "public"."connections" FROM "anon";

REVOKE REFERENCES ON TABLE "public"."connections" FROM "anon";

REVOKE SELECT ON TABLE "public"."connections" FROM "anon";

REVOKE TRIGGER ON TABLE "public"."connections" FROM "anon";

REVOKE TRUNCATE ON TABLE "public"."connections" FROM "anon";

REVOKE UPDATE ON TABLE "public"."connections" FROM "anon";

REVOKE DELETE ON TABLE "public"."connections" FROM "authenticated";

REVOKE INSERT ON TABLE "public"."connections" FROM "authenticated";

REVOKE REFERENCES ON TABLE "public"."connections" FROM "authenticated";

REVOKE SELECT ON TABLE "public"."connections" FROM "authenticated";

REVOKE TRIGGER ON TABLE "public"."connections" FROM "authenticated";

REVOKE TRUNCATE ON TABLE "public"."connections" FROM "authenticated";

REVOKE UPDATE ON TABLE "public"."connections" FROM "authenticated";

REVOKE DELETE ON TABLE "public"."connections" FROM "service_role";

REVOKE INSERT ON TABLE "public"."connections" FROM "service_role";

REVOKE REFERENCES ON TABLE "public"."connections" FROM "service_role";

REVOKE SELECT ON TABLE "public"."connections" FROM "service_role";

REVOKE TRIGGER ON TABLE "public"."connections" FROM "service_role";

REVOKE TRUNCATE ON TABLE "public"."connections" FROM "service_role";

REVOKE UPDATE ON TABLE "public"."connections" FROM "service_role";

ALTER TABLE "public"."connection_avatar_urls"
  DROP CONSTRAINT "connection_avatar_urls_connection_id_fkey";

ALTER TABLE "public"."lines"
  DROP CONSTRAINT "lines_connection_id_fkey";

ALTER TABLE "public"."connection_avatar_urls"
  DROP CONSTRAINT "connection_avatar_urls_pkey";

ALTER TABLE "public"."connections"
  DROP CONSTRAINT "connections_pkey";

ALTER TABLE "public"."connections"
  DROP CONSTRAINT "connections_id_key";

DROP INDEX IF EXISTS "public"."connection_avatar_urls_pkey";

DROP INDEX IF EXISTS "public"."connections_id_key";

DROP INDEX IF EXISTS "public"."connections_pkey";

DROP TABLE "public"."connection_avatar_urls";

DROP TABLE "public"."connections";

CREATE TABLE "public"."chests"(
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "name" text NOT NULL DEFAULT ''::text
);

ALTER TABLE "public"."chests" ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."collection_gems"(
  "collection_id" uuid NOT NULL,
  "gem_id" uuid NOT NULL
);

ALTER TABLE "public"."collection_gems" ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."collections"(
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "name" text NOT NULL DEFAULT ''::text,
  "chest_id" uuid NOT NULL
);

ALTER TABLE "public"."collections" ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."invitations"(
  "chest_id" uuid NOT NULL,
  "email" text NOT NULL,
  "assigned_role" app_role NOT NULL DEFAULT 'viewer' ::app_role
);

ALTER TABLE "public"."invitations" ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."people"(
  "id" bigint GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  "nickname" text NOT NULL,
  "date_of_birth" date NOT NULL,
  "chest_id" uuid NOT NULL
);

ALTER TABLE "public"."people" ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."person_avatar_urls"(
  "person_id" bigint NOT NULL,
  "age" smallint NOT NULL,
  "avatar_url" text NOT NULL,
  "chest_id" uuid NOT NULL
);

ALTER TABLE "public"."person_avatar_urls" ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."role_permissions"(
  "role" app_role NOT NULL,
  "permission" app_permission NOT NULL
);

ALTER TABLE "public"."role_permissions" ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."user_roles"(
  "user_id" uuid NOT NULL,
  "role" app_role NOT NULL DEFAULT 'viewer' ::app_role,
  "chest_id" uuid NOT NULL
);

ALTER TABLE "public"."user_roles" ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."users"(
  "id" uuid NOT NULL,
  "username" text DEFAULT ''::text
);

ALTER TABLE "public"."users" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."gems"
  ADD COLUMN "chest_id" uuid NOT NULL;

ALTER TABLE "public"."gems"
  ALTER COLUMN "occurred_at" SET DEFAULT now();

ALTER TABLE "public"."lines"
  DROP COLUMN "connection_id";

ALTER TABLE "public"."lines"
  ADD COLUMN "chest_id" uuid NOT NULL;

ALTER TABLE "public"."lines"
  ADD COLUMN "person_id" bigint;

CREATE UNIQUE INDEX chests_pkey ON public.chests USING btree(id);

CREATE UNIQUE INDEX collection_gems_pkey ON public.collection_gems USING btree(collection_id, gem_id);

CREATE UNIQUE INDEX collections_pkey ON public.collections USING btree(id);

CREATE UNIQUE INDEX invitations_pkey ON public.invitations USING btree(chest_id, email);

CREATE UNIQUE INDEX person_avatar_urls_pkey ON public.person_avatar_urls USING btree(person_id, age);

CREATE UNIQUE INDEX role_permissions_pkey ON public.role_permissions USING btree(ROLE, permission);

CREATE UNIQUE INDEX user_roles_pkey ON public.user_roles USING btree(ROLE, user_id, chest_id);

CREATE UNIQUE INDEX users_pkey ON public.users USING btree(id);

CREATE UNIQUE INDEX connections_id_key ON public.people USING btree(id);

CREATE UNIQUE INDEX connections_pkey ON public.people USING btree(id);

ALTER TABLE "public"."chests"
  ADD CONSTRAINT "chests_pkey" PRIMARY KEY USING INDEX "chests_pkey";

ALTER TABLE "public"."collection_gems"
  ADD CONSTRAINT "collection_gems_pkey" PRIMARY KEY USING INDEX "collection_gems_pkey";

ALTER TABLE "public"."collections"
  ADD CONSTRAINT "collections_pkey" PRIMARY KEY USING INDEX "collections_pkey";

ALTER TABLE "public"."invitations"
  ADD CONSTRAINT "invitations_pkey" PRIMARY KEY USING INDEX "invitations_pkey";

ALTER TABLE "public"."people"
  ADD CONSTRAINT "connections_pkey" PRIMARY KEY USING INDEX "connections_pkey";

ALTER TABLE "public"."person_avatar_urls"
  ADD CONSTRAINT "person_avatar_urls_pkey" PRIMARY KEY USING INDEX "person_avatar_urls_pkey";

ALTER TABLE "public"."role_permissions"
  ADD CONSTRAINT "role_permissions_pkey" PRIMARY KEY USING INDEX "role_permissions_pkey";

ALTER TABLE "public"."user_roles"
  ADD CONSTRAINT "user_roles_pkey" PRIMARY KEY USING INDEX "user_roles_pkey";

ALTER TABLE "public"."users"
  ADD CONSTRAINT "users_pkey" PRIMARY KEY USING INDEX "users_pkey";

ALTER TABLE "public"."collection_gems"
  ADD CONSTRAINT "collection_gems_collection_id_fkey" FOREIGN KEY (collection_id) REFERENCES collections(id) ON UPDATE CASCADE ON DELETE CASCADE NOT valid;

ALTER TABLE "public"."collection_gems" validate CONSTRAINT "collection_gems_collection_id_fkey";

ALTER TABLE "public"."collection_gems"
  ADD CONSTRAINT "collection_gems_gem_id_fkey" FOREIGN KEY (gem_id) REFERENCES gems(id) ON UPDATE CASCADE ON DELETE CASCADE NOT valid;

ALTER TABLE "public"."collection_gems" validate CONSTRAINT "collection_gems_gem_id_fkey";

ALTER TABLE "public"."collections"
  ADD CONSTRAINT "collections_chest_id_fkey" FOREIGN KEY (chest_id) REFERENCES chests(id) ON UPDATE CASCADE ON DELETE CASCADE NOT valid;

ALTER TABLE "public"."collections" validate CONSTRAINT "collections_chest_id_fkey";

ALTER TABLE "public"."gems"
  ADD CONSTRAINT "gems_chest_id_fkey" FOREIGN KEY (chest_id) REFERENCES chests(id) ON UPDATE CASCADE ON DELETE CASCADE NOT valid;

ALTER TABLE "public"."gems" validate CONSTRAINT "gems_chest_id_fkey";

ALTER TABLE "public"."invitations"
  ADD CONSTRAINT "invitations_chest_id_fkey" FOREIGN KEY (chest_id) REFERENCES chests(id) ON UPDATE CASCADE ON DELETE CASCADE NOT valid;

ALTER TABLE "public"."invitations" validate CONSTRAINT "invitations_chest_id_fkey";

ALTER TABLE "public"."lines"
  ADD CONSTRAINT "lines_chest_id_fkey" FOREIGN KEY (chest_id) REFERENCES chests(id) ON UPDATE CASCADE ON DELETE CASCADE NOT valid;

ALTER TABLE "public"."lines" validate CONSTRAINT "lines_chest_id_fkey";

ALTER TABLE "public"."lines"
  ADD CONSTRAINT "lines_person_id_fkey" FOREIGN KEY (person_id) REFERENCES people(id) ON UPDATE CASCADE ON DELETE CASCADE NOT valid;

ALTER TABLE "public"."lines" validate CONSTRAINT "lines_person_id_fkey";

ALTER TABLE "public"."people"
  ADD CONSTRAINT "connections_id_key" UNIQUE USING INDEX "connections_id_key";

ALTER TABLE "public"."people"
  ADD CONSTRAINT "people_chest_id_fkey" FOREIGN KEY (chest_id) REFERENCES chests(id) ON UPDATE CASCADE ON DELETE CASCADE NOT valid;

ALTER TABLE "public"."people" validate CONSTRAINT "people_chest_id_fkey";

ALTER TABLE "public"."person_avatar_urls"
  ADD CONSTRAINT "connection_avatar_urls_connection_id_fkey" FOREIGN KEY (person_id) REFERENCES people(id) ON UPDATE CASCADE ON DELETE CASCADE NOT valid;

ALTER TABLE "public"."person_avatar_urls" validate CONSTRAINT "connection_avatar_urls_connection_id_fkey";

ALTER TABLE "public"."person_avatar_urls"
  ADD CONSTRAINT "person_avatar_urls_chest_id_fkey" FOREIGN KEY (chest_id) REFERENCES chests(id) ON UPDATE CASCADE ON DELETE CASCADE NOT valid;

ALTER TABLE "public"."person_avatar_urls" validate CONSTRAINT "person_avatar_urls_chest_id_fkey";

ALTER TABLE "public"."user_roles"
  ADD CONSTRAINT "user_roles_chest_id_fkey" FOREIGN KEY (chest_id) REFERENCES chests(id) ON UPDATE CASCADE ON DELETE CASCADE NOT valid;

ALTER TABLE "public"."user_roles" validate CONSTRAINT "user_roles_chest_id_fkey";

ALTER TABLE "public"."user_roles"
  ADD CONSTRAINT "user_roles_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT valid;

ALTER TABLE "public"."user_roles" validate CONSTRAINT "user_roles_user_id_fkey";

ALTER TABLE "public"."user_roles"
  ADD CONSTRAINT "user_roles_user_id_fkey1" FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT valid;

ALTER TABLE "public"."user_roles" validate CONSTRAINT "user_roles_user_id_fkey1";

ALTER TABLE "public"."users"
  ADD CONSTRAINT "users_id_fkey" FOREIGN KEY (id) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT valid;

ALTER TABLE "public"."users" validate CONSTRAINT "users_id_fkey";

SET check_function_bodies = OFF;

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
    (((auth.jwt() ->> 'chests')::jsonb ->> chest_id)::jsonb ->> 'role')::role INTO user_role;
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
    ur.user_id =(event ->> 'sub')::uuid LOOP
      chests_json := jsonb_set(chests_json,('{' || chest_roles.id::text || '}')::text[], jsonb_build_object('name', chest_roles.name, 'role', chest_roles.role));
    END LOOP;
  claims := jsonb_set(claims, '{chests}', 'chests_json');
  event := jsonb_set(event, '{claims}', claims);
  RETURN event;
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
    VALUES(NEW.id, NEW.raw_user_meta_data ->> 'username');
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
    username = NEW.raw_user_meta_data ->> 'last_name'
  WHERE
    id = NEW.id;
  RETURN new;
END;
$function$;

CREATE OR REPLACE FUNCTION public.handle_gem_insert()
  RETURNS TRIGGER
  LANGUAGE plpgsql
  AS $function$
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

GRANT DELETE ON TABLE "public"."person_avatar_urls" TO "anon";

GRANT INSERT ON TABLE "public"."person_avatar_urls" TO "anon";

GRANT REFERENCES ON TABLE "public"."person_avatar_urls" TO "anon";

GRANT SELECT ON TABLE "public"."person_avatar_urls" TO "anon";

GRANT TRIGGER ON TABLE "public"."person_avatar_urls" TO "anon";

GRANT TRUNCATE ON TABLE "public"."person_avatar_urls" TO "anon";

GRANT UPDATE ON TABLE "public"."person_avatar_urls" TO "anon";

GRANT DELETE ON TABLE "public"."person_avatar_urls" TO "authenticated";

GRANT INSERT ON TABLE "public"."person_avatar_urls" TO "authenticated";

GRANT REFERENCES ON TABLE "public"."person_avatar_urls" TO "authenticated";

GRANT SELECT ON TABLE "public"."person_avatar_urls" TO "authenticated";

GRANT TRIGGER ON TABLE "public"."person_avatar_urls" TO "authenticated";

GRANT TRUNCATE ON TABLE "public"."person_avatar_urls" TO "authenticated";

GRANT UPDATE ON TABLE "public"."person_avatar_urls" TO "authenticated";

GRANT DELETE ON TABLE "public"."person_avatar_urls" TO "service_role";

GRANT INSERT ON TABLE "public"."person_avatar_urls" TO "service_role";

GRANT REFERENCES ON TABLE "public"."person_avatar_urls" TO "service_role";

GRANT SELECT ON TABLE "public"."person_avatar_urls" TO "service_role";

GRANT TRIGGER ON TABLE "public"."person_avatar_urls" TO "service_role";

GRANT TRUNCATE ON TABLE "public"."person_avatar_urls" TO "service_role";

GRANT UPDATE ON TABLE "public"."person_avatar_urls" TO "service_role";

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

CREATE POLICY "Allow authorized delete access" ON "public"."chests" AS permissive
  FOR DELETE TO authenticated
    USING (authorize('chests.delete'::app_permission, id));

CREATE POLICY "Allow authorized insert access" ON "public"."chests" AS permissive
  FOR INSERT TO authenticated
    WITH CHECK (authorize('chests.insert'::app_permission, id));

CREATE POLICY "Allow authorized select access" ON "public"."chests" AS permissive
  FOR SELECT TO authenticated
    USING (authorize('chests.select'::app_permission, id));

CREATE POLICY "Allow authorized update access" ON "public"."chests" AS permissive
  FOR UPDATE TO authenticated
    USING (authorize('chests.update'::app_permission, id));

CREATE POLICY "Allow authorized delete access" ON "public"."collection_gems" AS permissive
  FOR DELETE TO authenticated
    USING (authorize('collections.delete'::app_permission,(
      SELECT
        collections.chest_id
      FROM
        collections
      WHERE (collections.id = collection_gems.collection_id))));

CREATE POLICY "Allow authorized insert access" ON "public"."collection_gems" AS permissive
  FOR INSERT TO authenticated
    WITH CHECK (authorize('collections.insert'::app_permission,(
      SELECT
        collections.chest_id
      FROM
        collections
      WHERE (collections.id = collection_gems.collection_id))));

CREATE POLICY "Allow authorized select access" ON "public"."collection_gems" AS permissive
  FOR SELECT TO authenticated
    USING (authorize('collections.select'::app_permission,(
      SELECT
        collections.chest_id
      FROM
        collections
      WHERE (collections.id = collection_gems.collection_id))));

CREATE POLICY "Allow authorized update access" ON "public"."collection_gems" AS permissive
  FOR UPDATE TO authenticated
    USING (authorize('collections.update'::app_permission,(
      SELECT
        collections.chest_id
      FROM
        collections
      WHERE (collections.id = collection_gems.collection_id))));

CREATE POLICY "Allow authorized delete access" ON "public"."collections" AS permissive
  FOR DELETE TO authenticated
    USING (authorize('collections.delete'::app_permission, chest_id));

CREATE POLICY "Allow authorized insert access" ON "public"."collections" AS permissive
  FOR INSERT TO authenticated
    WITH CHECK (authorize('collections.insert'::app_permission, chest_id));

CREATE POLICY "Allow authorized select access" ON "public"."collections" AS permissive
  FOR SELECT TO authenticated
    USING (authorize('collections.select'::app_permission, chest_id));

CREATE POLICY "Allow authorized update access" ON "public"."collections" AS permissive
  FOR UPDATE TO authenticated
    USING (authorize('collections.update'::app_permission, chest_id));

CREATE POLICY "Allow authorized delete access" ON "public"."gems" AS permissive
  FOR DELETE TO authenticated
    USING (authorize('gems.delete'::app_permission, chest_id));

CREATE POLICY "Allow authorized insert access" ON "public"."gems" AS permissive
  FOR INSERT TO authenticated
    WITH CHECK (authorize('gems.insert'::app_permission, chest_id));

CREATE POLICY "Allow authorized select access" ON "public"."gems" AS permissive
  FOR SELECT TO authenticated
    USING (authorize('gems.select'::app_permission, chest_id));

CREATE POLICY "Allow authorized update access" ON "public"."gems" AS permissive
  FOR UPDATE TO authenticated
    USING (authorize('gems.update'::app_permission, chest_id));

CREATE POLICY "Allow authorized delete access" ON "public"."invitations" AS permissive
  FOR DELETE TO authenticated
    USING (authorize('invitations.delete'::app_permission, chest_id));

CREATE POLICY "Allow authorized insert access" ON "public"."invitations" AS permissive
  FOR INSERT TO authenticated
    WITH CHECK (authorize('invitations.insert'::app_permission, chest_id));

CREATE POLICY "Allow authorized select access" ON "public"."invitations" AS permissive
  FOR SELECT TO authenticated
    USING (authorize('invitations.select'::app_permission, chest_id));

CREATE POLICY "Allow authorized update access" ON "public"."invitations" AS permissive
  FOR UPDATE TO authenticated
    USING (authorize('invitations.update'::app_permission, chest_id));

CREATE POLICY "Restrict access if assigned_role is owner" ON "public"."invitations" AS restrictive
  FOR ALL TO authenticated
    USING ((assigned_role <> 'owner'::app_role));

CREATE POLICY "Allow authorized delete access" ON "public"."lines" AS permissive
  FOR DELETE TO authenticated
    USING (authorize('lines.delete'::app_permission, chest_id));

CREATE POLICY "Allow authorized insert access" ON "public"."lines" AS permissive
  FOR INSERT TO authenticated
    WITH CHECK (authorize('lines.insert'::app_permission, chest_id));

CREATE POLICY "Allow authorized select access" ON "public"."lines" AS permissive
  FOR SELECT TO authenticated
    USING (authorize('lines.select'::app_permission, chest_id));

CREATE POLICY "Allow authorized update access" ON "public"."lines" AS permissive
  FOR UPDATE TO authenticated
    USING (authorize('lines.update'::app_permission, chest_id));

CREATE POLICY "Allow authorized delete access" ON "public"."people" AS permissive
  FOR DELETE TO authenticated
    USING (authorize('people.delete'::app_permission, chest_id));

CREATE POLICY "Allow authorized insert access" ON "public"."people" AS permissive
  FOR INSERT TO authenticated
    WITH CHECK (authorize('people.insert'::app_permission, chest_id));

CREATE POLICY "Allow authorized select access" ON "public"."people" AS permissive
  FOR SELECT TO authenticated
    USING (authorize('people.select'::app_permission, chest_id));

CREATE POLICY "Allow authorized update access" ON "public"."people" AS permissive
  FOR UPDATE TO authenticated
    USING (authorize('people.update'::app_permission, chest_id));

CREATE POLICY "Allow authorized delete access" ON "public"."person_avatar_urls" AS permissive
  FOR DELETE TO authenticated
    USING (authorize('person_avatar_urls.delete'::app_permission, chest_id));

CREATE POLICY "Allow authorized insert access" ON "public"."person_avatar_urls" AS permissive
  FOR INSERT TO authenticated
    WITH CHECK (authorize('person_avatar_urls.insert'::app_permission, chest_id));

CREATE POLICY "Allow authorized select access" ON "public"."person_avatar_urls" AS permissive
  FOR SELECT TO authenticated
    USING (authorize('person_avatar_urls.select'::app_permission, chest_id));

CREATE POLICY "Allow authorized update access" ON "public"."person_avatar_urls" AS permissive
  FOR UPDATE TO authenticated
    USING (authorize('person_avatar_urls.update'::app_permission, chest_id));

CREATE POLICY "Restrict all access" ON "public"."role_permissions" AS restrictive
  FOR ALL TO public
    USING (FALSE);

CREATE POLICY "Allow select access for auth admin" ON "public"."user_roles" AS permissive
  FOR SELECT TO supabase_auth_admin
    USING (TRUE);

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

CREATE POLICY "Allow users to insert their own profiles" ON "public"."users" AS permissive
  FOR INSERT TO authenticated
    WITH CHECK ((auth.uid() = id));

CREATE POLICY "Allow users to update their own profiles" ON "public"."users" AS permissive
  FOR UPDATE TO authenticated
    USING ((auth.uid() = id));

CREATE TRIGGER on_gem_inserted
  BEFORE INSERT ON public.gems
  FOR EACH ROW
  EXECUTE FUNCTION handle_gem_insert();

CREATE TRIGGER on_auth_user_inserted
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE PROCEDURE public.handle_auth_user_insert();

CREATE TRIGGER on_auth_user_updated
  AFTER UPDATE ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_auth_user_update();

CREATE POLICY "Allow select access for custom_access_token_hook" ON "public"."chests" AS permissive
  FOR SELECT TO supabase_auth_admin
    USING (TRUE);

GRANT usage ON SCHEMA public TO supabase_auth_admin;

GRANT ALL ON TABLE public.user_roles TO supabase_auth_admin;

GRANT ALL ON TABLE public.chests TO supabase_auth_admin;

GRANT EXECUTE ON FUNCTION public.custom_access_token_hook TO supabase_auth_admin;

REVOKE EXECUTE ON FUNCTION public.custom_access_token_hook FROM authenticated, anon, public;

REVOKE DELETE ON TABLE "public"."user_roles" FROM "anon";

REVOKE INSERT ON TABLE "public"."user_roles" FROM "anon";

REVOKE REFERENCES ON TABLE "public"."user_roles" FROM "anon";

REVOKE SELECT ON TABLE "public"."user_roles" FROM "anon";

REVOKE TRIGGER ON TABLE "public"."user_roles" FROM "anon";

REVOKE TRUNCATE ON TABLE "public"."user_roles" FROM "anon";

REVOKE UPDATE ON TABLE "public"."user_roles" FROM "anon";

REVOKE DELETE ON TABLE "public"."user_roles" FROM "authenticated";

REVOKE INSERT ON TABLE "public"."user_roles" FROM "authenticated";

REVOKE REFERENCES ON TABLE "public"."user_roles" FROM "authenticated";

REVOKE SELECT ON TABLE "public"."user_roles" FROM "authenticated";

REVOKE TRIGGER ON TABLE "public"."user_roles" FROM "authenticated";

REVOKE TRUNCATE ON TABLE "public"."user_roles" FROM "authenticated";

REVOKE UPDATE ON TABLE "public"."user_roles" FROM "authenticated";

