CREATE POLICY "Allow authorized delete access" ON "public"."chests" AS permissive
    FOR DELETE TO authenticated
        USING (authorize('chests.delete'::app_permission, id));

CREATE POLICY "Allow authorized select access" ON "public"."chests" AS permissive
    FOR SELECT TO authenticated
        USING (authorize('chests.select'::app_permission, id));

CREATE POLICY "Allow authorized update access" ON "public"."chests" AS permissive
    FOR UPDATE TO authenticated
        USING (authorize('chests.update'::app_permission, id));

CREATE POLICY "Allow insert access for authenticated" ON "public"."chests" AS permissive
    FOR INSERT TO authenticated
        WITH CHECK (TRUE);

CREATE POLICY "Allow select access for custom_access_token_hook" ON "public"."chests" AS permissive
    FOR SELECT TO supabase_auth_admin
        USING (TRUE);

CREATE POLICY "Allow select access for invited users" ON "public"."chests" AS permissive
    FOR SELECT TO authenticated
        USING ((EXISTS (
            SELECT
                1
            FROM
                invitations
            WHERE ((invitations.chest_id = chests.id) AND (invitations.email = auth.email())))));

CREATE POLICY "Allow select access for new creators" ON "public"."chests" AS permissive
    FOR SELECT TO authenticated
        USING ((auth.uid() = created_by));

ALTER TABLE "public"."chests" ENABLE ROW LEVEL SECURITY;
