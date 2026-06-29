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
