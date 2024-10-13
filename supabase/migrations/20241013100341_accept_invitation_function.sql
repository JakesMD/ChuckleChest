CREATE OR REPLACE FUNCTION public.accept_invitation(chest_id_param uuid)
  RETURNS void
  LANGUAGE plpgsql
  SECURITY DEFINER
  AS $function$
DECLARE
  ROLE app_role;
BEGIN
  SELECT
    assigned_role INTO ROLE
  FROM
    public.invitations
  WHERE
    chest_id = chest_id_param
    AND email = auth.email();
  INSERT INTO public.user_roles(chest_id, user_id, ROLE)
    VALUES (chest_id_param, auth.uid(), ROLE);
  DELETE FROM public.invitations
  WHERE chest_id = chest_id_param
    AND email = auth.email();
END;
$function$;

CREATE POLICY "Allow select access for invited users" ON "public"."chests" AS permissive
  FOR SELECT TO authenticated
    USING ((EXISTS (
      SELECT
        1
      FROM
        invitations
      WHERE ((invitations.chest_id = chests.id) AND (invitations.email = auth.email())))));

CREATE POLICY "Allow authorized select access" ON "public"."invitations" AS permissive
  FOR SELECT TO authenticated
    USING ((authorize('invitations.select'::app_permission, chest_id) OR (email = auth.email())));

