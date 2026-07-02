CREATE POLICY "Allow select access for authenticated users from the same chest" ON "public"."users" AS permissive
    FOR SELECT TO authenticated
        USING ((EXISTS (
            SELECT
                1
            FROM
                user_roles ur
            WHERE (EXISTS (
                SELECT
                    1
                FROM
                    jsonb_object_keys(((auth.jwt() ->> 'chests'::text))::jsonb) chest_key(chest_key)
                WHERE (chest_key.chest_key =(ur.chest_id)::text))))));

CREATE POLICY "Allow users to insert their own profiles" ON "public"."users" AS permissive
    FOR INSERT TO authenticated
        WITH CHECK ((auth.uid() = id));

CREATE POLICY "Allow users to update their own profiles" ON "public"."users" AS permissive
    FOR UPDATE TO authenticated
        USING ((auth.uid() = id));

ALTER TABLE "public"."users" ENABLE ROW LEVEL SECURITY;
