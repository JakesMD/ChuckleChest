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
