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
