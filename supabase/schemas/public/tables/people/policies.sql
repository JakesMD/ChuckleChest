CREATE POLICY "Allow authorized delete access" ON "public"."people" AS permissive
    FOR DELETE TO authenticated
        USING (authorize('people.delete'::app_permission, chest_id));

CREATE POLICY "Allow authorized insert access" ON "public"."people" AS permissive
    FOR INSERT TO authenticated
        WITH CHECK (authorize('people.insert'::app_permission, chest_id));

CREATE POLICY "Allow authorized select access" ON "public"."people" AS permissive
    FOR SELECT TO authenticated
        USING (authorize('people.select'::app_permission, chest_id));

CREATE POLICY "Allow authorized update access" ON "public"."people" AS permissive
    FOR UPDATE TO authenticated
        USING (authorize('people.update'::app_permission, chest_id));

ALTER TABLE "public"."people" ENABLE ROW LEVEL SECURITY;
