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
