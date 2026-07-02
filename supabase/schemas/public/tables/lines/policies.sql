CREATE POLICY "Allow authorized delete access" ON "public"."lines" AS permissive
    FOR DELETE TO authenticated
        USING (authorize('lines.delete'::app_permission, chest_id));

CREATE POLICY "Allow authorized insert access" ON "public"."lines" AS permissive
    FOR INSERT TO authenticated
        WITH CHECK (authorize('lines.insert'::app_permission, chest_id));

CREATE POLICY "Allow authorized select access" ON "public"."lines" AS permissive
    FOR SELECT TO authenticated
        USING (authorize('lines.select'::app_permission, chest_id));

CREATE POLICY "Allow authorized update access" ON "public"."lines" AS permissive
    FOR UPDATE TO authenticated
        USING (authorize('lines.update'::app_permission, chest_id));

ALTER TABLE "public"."lines" ENABLE ROW LEVEL SECURITY;
