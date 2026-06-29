CREATE POLICY "Allow authorized delete access" ON "public"."invitations" AS permissive
    FOR DELETE TO authenticated
        USING (authorize('invitations.delete'::app_permission, chest_id));

CREATE POLICY "Allow authorized insert access" ON "public"."invitations" AS permissive
    FOR INSERT TO authenticated
        WITH CHECK (authorize('invitations.insert'::app_permission, chest_id));

CREATE POLICY "Allow authorized select access" ON "public"."invitations" AS permissive
    FOR SELECT TO authenticated
        USING ((authorize('invitations.select'::app_permission, chest_id) OR (email = auth.email())));

CREATE POLICY "Allow authorized update access" ON "public"."invitations" AS permissive
    FOR UPDATE TO authenticated
        USING (authorize('invitations.update'::app_permission, chest_id));

CREATE POLICY "Restrict access if assigned_role is owner" ON "public"."invitations" AS restrictive
    FOR ALL TO authenticated
        USING ((assigned_role <> 'owner'::app_role));

ALTER TABLE "public"."invitations" ENABLE ROW LEVEL SECURITY;
