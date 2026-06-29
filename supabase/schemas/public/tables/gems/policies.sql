CREATE POLICY "Allow authorized delete access" ON "public"."gems" AS permissive
    FOR DELETE TO authenticated
        USING (authorize('gems.delete'::app_permission, chest_id));

CREATE POLICY "Allow authorized insert access" ON "public"."gems" AS permissive
    FOR INSERT TO authenticated
        WITH CHECK (authorize('gems.insert'::app_permission, chest_id));

CREATE POLICY "Allow authorized select access" ON "public"."gems" AS permissive
    FOR SELECT TO authenticated
        USING (authorize('gems.select'::app_permission, chest_id));

CREATE POLICY "Allow authorized update access" ON "public"."gems" AS permissive
    FOR UPDATE TO authenticated
        USING (authorize('gems.update'::app_permission, chest_id));

ALTER TABLE "public"."gems" ENABLE ROW LEVEL SECURITY;
