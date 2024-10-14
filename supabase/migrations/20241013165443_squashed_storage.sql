DROP POLICY IF EXISTS "Enable insert for authenticated users only" ON "storage"."objects";

CREATE POLICY "Enable insert for authenticated users only" ON "storage"."objects" AS permissive
    FOR ALL TO authenticated
        USING (TRUE)
        WITH CHECK (TRUE);

