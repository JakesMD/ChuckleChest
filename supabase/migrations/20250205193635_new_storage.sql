DROP POLICY "Enable insert for authenticated users only" ON "storage"."objects";

CREATE POLICY "Allow authorized delete access 1oj01fe_0" ON "storage"."objects" AS permissive
    FOR DELETE TO authenticated
        USING (((bucket_id = 'avatars'::text) AND ((((((auth.jwt() ->> 'chests'::text))::jsonb ->>(storage.foldername(name))[2]))::jsonb ->> 'role'::text) = ANY (ARRAY['owner'::text, 'collaborator'::text]))));

CREATE POLICY "Allow authorized insert access 1oj01fe_0" ON "storage"."objects" AS permissive
    FOR INSERT TO authenticated
        WITH CHECK (((bucket_id = 'avatars'::text) AND ((((((auth.jwt() ->> 'chests'::text))::jsonb ->>(storage.foldername(name))[2]))::jsonb ->> 'role'::text) = ANY (ARRAY['owner'::text, 'collaborator'::text]))));

CREATE POLICY "Allow authorized select access 1oj01fe_0" ON "storage"."objects" AS permissive
    FOR SELECT TO authenticated
        USING (((bucket_id = 'avatars'::text) AND ((((((auth.jwt() ->> 'chests'::text))::jsonb ->>(storage.foldername(name))[2]))::jsonb ->> 'role'::text) IS NOT NULL)));

CREATE POLICY "Allow authorized update access 1oj01fe_0" ON "storage"."objects" AS permissive
    FOR UPDATE TO authenticated
        USING (((bucket_id = 'avatars'::text) AND ((((((auth.jwt() ->> 'chests'::text))::jsonb ->>(storage.foldername(name))[2]))::jsonb ->> 'role'::text) = ANY (ARRAY['owner'::text, 'collaborator'::text]))));

