CREATE POLICY "Restrict all access" ON "public"."role_permissions" AS restrictive
    FOR ALL TO public
        USING (FALSE);

ALTER TABLE "public"."role_permissions" ENABLE ROW LEVEL SECURITY;
