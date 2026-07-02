CREATE POLICY "Allow all access for supabase admin" ON "public"."user_roles" AS permissive
    FOR ALL TO supabase_admin
        USING (TRUE);

CREATE POLICY "Allow select access for auth admin" ON "public"."user_roles" AS permissive
    FOR SELECT TO supabase_auth_admin
        USING (TRUE);

CREATE POLICY "Allow authorized select access" ON "public"."user_roles" AS permissive
    FOR SELECT TO authenticated
        USING ((authorize('user_roles.select'::app_permission, chest_id) AND (user_id <> auth.uid())));

CREATE POLICY "Allow authorized update access" ON "public"."user_roles" AS permissive
    FOR UPDATE TO authenticated
        USING ((authorize('user_roles.update'::app_permission, chest_id) AND (user_id <> auth.uid())));

ALTER TABLE "public"."user_roles" ENABLE ROW LEVEL SECURITY;
