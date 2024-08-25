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
    ur.user_id =(event ->> 'sub')::uuid LOOP
      chests_json := jsonb_set(chests_json,('{' || chest_roles.id::text || '}')::text[], jsonb_build_object('name', chest_roles.name, 'role', chest_roles.role));
    END LOOP;
  claims := jsonb_set(claims, '{chests}', chests_json);
  event := jsonb_set(event, '{claims}', claims);
  RETURN event;
END;
$function$;

