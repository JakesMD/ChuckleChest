CREATE POLICY "Allow authorized delete access" ON "public"."collection_gems" AS permissive
    FOR DELETE TO authenticated
        USING (authorize('collections.delete'::app_permission,(
            SELECT
                collections.chest_id
            FROM
                collections
            WHERE (collections.id = collection_gems.collection_id))));

CREATE POLICY "Allow authorized insert access" ON "public"."collection_gems" AS permissive
    FOR INSERT TO authenticated
        WITH CHECK (authorize('collections.insert'::app_permission,(
            SELECT
                collections.chest_id
            FROM
                collections
            WHERE (collections.id = collection_gems.collection_id))));

CREATE POLICY "Allow authorized select access" ON "public"."collection_gems" AS permissive
    FOR SELECT TO authenticated
        USING (authorize('collections.select'::app_permission,(
            SELECT
                collections.chest_id
            FROM
                collections
            WHERE (collections.id = collection_gems.collection_id))));

CREATE POLICY "Allow authorized update access" ON "public"."collection_gems" AS permissive
    FOR UPDATE TO authenticated
        USING (authorize('collections.update'::app_permission,(
            SELECT
                collections.chest_id
            FROM
                collections
            WHERE (collections.id = collection_gems.collection_id))));

ALTER TABLE "public"."collection_gems" ENABLE ROW LEVEL SECURITY;
