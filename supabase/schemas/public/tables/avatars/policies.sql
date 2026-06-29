CREATE POLICY "Allow authorized delete access" ON "public"."avatars" AS permissive
    FOR DELETE TO authenticated
        USING (authorize('person_avatar_urls.delete'::app_permission, chest_id));

CREATE POLICY "Allow authorized insert access" ON "public"."avatars" AS permissive
    FOR INSERT TO authenticated
        WITH CHECK (authorize('person_avatar_urls.insert'::app_permission, chest_id));

CREATE POLICY "Allow authorized select access" ON "public"."avatars" AS permissive
    FOR SELECT TO authenticated
        USING (authorize('person_avatar_urls.select'::app_permission, chest_id));

CREATE POLICY "Allow authorized update access" ON "public"."avatars" AS permissive
    FOR UPDATE TO authenticated
        USING (authorize('person_avatar_urls.update'::app_permission, chest_id));

ALTER TABLE "public"."avatars" ENABLE ROW LEVEL SECURITY;
