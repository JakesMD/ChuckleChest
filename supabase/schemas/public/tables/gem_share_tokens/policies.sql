CREATE POLICY "Allow authorized delete access" ON "public"."gem_share_tokens" AS permissive
    FOR DELETE TO authenticated
        USING (authorize('gem_share_tokens.delete'::app_permission, chest_id));

CREATE POLICY "Allow authorized insert access" ON "public"."gem_share_tokens" AS permissive
    FOR INSERT TO authenticated
        WITH CHECK (authorize('gem_share_tokens.insert'::app_permission, chest_id));

CREATE POLICY "Allow authorized select access" ON "public"."gem_share_tokens" AS permissive
    FOR SELECT TO authenticated
        USING (authorize('gem_share_tokens.select'::app_permission, chest_id));

CREATE POLICY "Allow authorized update access" ON "public"."gem_share_tokens" AS permissive
    FOR UPDATE TO authenticated
        USING (authorize('gem_share_tokens.update'::app_permission, chest_id));

ALTER TABLE "public"."gem_share_tokens" ENABLE ROW LEVEL SECURITY;
