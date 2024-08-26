SET check_function_bodies = OFF;

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

