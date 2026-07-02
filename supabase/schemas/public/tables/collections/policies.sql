CREATE POLICY "Allow authorized delete access" ON "public"."collections" AS permissive
    FOR DELETE TO authenticated
        USING (authorize('collections.delete'::app_permission, chest_id));

CREATE POLICY "Allow authorized insert access" ON "public"."collections" AS permissive
    FOR INSERT TO authenticated
        WITH CHECK (authorize('collections.insert'::app_permission, chest_id));

CREATE POLICY "Allow authorized select access" ON "public"."collections" AS permissive
    FOR SELECT TO authenticated
        USING (authorize('collections.select'::app_permission, chest_id));

CREATE POLICY "Allow authorized update access" ON "public"."collections" AS permissive
    FOR UPDATE TO authenticated
        USING (authorize('collections.update'::app_permission, chest_id));

ALTER TABLE "public"."collections" ENABLE ROW LEVEL SECURITY;
