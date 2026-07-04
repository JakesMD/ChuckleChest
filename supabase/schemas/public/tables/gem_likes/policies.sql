CREATE POLICY "Allow authorized delete access" ON "public"."gem_likes" AS permissive
    FOR DELETE TO authenticated
        USING (authorize('gem_likes.delete'::app_permission, chest_id) AND user_id = auth.uid());

CREATE POLICY "Allow authorized insert access" ON "public"."gem_likes" AS permissive
    FOR INSERT TO authenticated
        WITH CHECK (authorize('gem_likes.insert'::app_permission, chest_id) AND user_id = auth.uid());

CREATE POLICY "Allow authorized select access" ON "public"."gem_likes" AS permissive
    FOR SELECT TO authenticated
        USING (authorize('gem_likes.select'::app_permission, chest_id) AND user_id = auth.uid());

ALTER TABLE "public"."gem_likes" ENABLE ROW LEVEL SECURITY;
