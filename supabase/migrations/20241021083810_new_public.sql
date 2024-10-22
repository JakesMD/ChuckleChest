CREATE TABLE "public"."collection_share_tokens"(
    "chest_id" uuid NOT NULL,
    "collection_id" uuid NOT NULL,
    "token" uuid NOT NULL DEFAULT gen_random_uuid()
);

ALTER TABLE "public"."collection_share_tokens" ENABLE ROW LEVEL SECURITY;

CREATE TABLE "public"."gem_share_tokens"(
    "chest_id" uuid NOT NULL,
    "gem_id" uuid NOT NULL,
    "token" uuid NOT NULL DEFAULT gen_random_uuid()
);

ALTER TABLE "public"."gem_share_tokens" ENABLE ROW LEVEL SECURITY;

CREATE UNIQUE INDEX collection_share_tokens_token_key ON public.collection_share_tokens USING btree(token);

CREATE UNIQUE INDEX collection_share_tokens_pkey ON public.collection_share_tokens USING btree(collection_id);

CREATE UNIQUE INDEX gem_share_tokens_pkey ON public.gem_share_tokens USING btree(gem_id);

CREATE UNIQUE INDEX gem_share_tokens_token_key ON public.gem_share_tokens USING btree(token);

ALTER TABLE "public"."collection_share_tokens"
    ADD CONSTRAINT "collection_share_tokens_pkey" PRIMARY KEY USING INDEX "collection_share_tokens_pkey";

ALTER TABLE "public"."gem_share_tokens"
    ADD CONSTRAINT "gem_share_tokens_pkey" PRIMARY KEY USING INDEX "gem_share_tokens_pkey";

ALTER TABLE "public"."collection_share_tokens"
    ADD CONSTRAINT "collection_share_tokens_collection_id_fkey" FOREIGN KEY (collection_id) REFERENCES collections(id) ON UPDATE CASCADE ON DELETE CASCADE NOT valid;

ALTER TABLE "public"."collection_share_tokens" validate CONSTRAINT "collection_share_tokens_collection_id_fkey";

ALTER TABLE "public"."collection_share_tokens"
    ADD CONSTRAINT "collection_share_tokens_token_key" UNIQUE USING INDEX "collection_share_tokens_token_key";

ALTER TABLE "public"."gem_share_tokens"
    ADD CONSTRAINT "gem_share_tokens_gem_id_fkey" FOREIGN KEY (gem_id) REFERENCES gems(id) ON UPDATE CASCADE ON DELETE CASCADE NOT valid;

ALTER TABLE "public"."gem_share_tokens" validate CONSTRAINT "gem_share_tokens_gem_id_fkey";

ALTER TABLE "public"."gem_share_tokens"
    ADD CONSTRAINT "gem_share_tokens_token_key" UNIQUE USING INDEX "gem_share_tokens_token_key";

SET check_function_bodies = OFF;

GRANT DELETE ON TABLE "public"."collection_share_tokens" TO "anon";

GRANT INSERT ON TABLE "public"."collection_share_tokens" TO "anon";

GRANT REFERENCES ON TABLE "public"."collection_share_tokens" TO "anon";

GRANT SELECT ON TABLE "public"."collection_share_tokens" TO "anon";

GRANT TRIGGER ON TABLE "public"."collection_share_tokens" TO "anon";

GRANT TRUNCATE ON TABLE "public"."collection_share_tokens" TO "anon";

GRANT UPDATE ON TABLE "public"."collection_share_tokens" TO "anon";

GRANT DELETE ON TABLE "public"."collection_share_tokens" TO "authenticated";

GRANT INSERT ON TABLE "public"."collection_share_tokens" TO "authenticated";

GRANT REFERENCES ON TABLE "public"."collection_share_tokens" TO "authenticated";

GRANT SELECT ON TABLE "public"."collection_share_tokens" TO "authenticated";

GRANT TRIGGER ON TABLE "public"."collection_share_tokens" TO "authenticated";

GRANT TRUNCATE ON TABLE "public"."collection_share_tokens" TO "authenticated";

GRANT UPDATE ON TABLE "public"."collection_share_tokens" TO "authenticated";

GRANT DELETE ON TABLE "public"."collection_share_tokens" TO "service_role";

GRANT INSERT ON TABLE "public"."collection_share_tokens" TO "service_role";

GRANT REFERENCES ON TABLE "public"."collection_share_tokens" TO "service_role";

GRANT SELECT ON TABLE "public"."collection_share_tokens" TO "service_role";

GRANT TRIGGER ON TABLE "public"."collection_share_tokens" TO "service_role";

GRANT TRUNCATE ON TABLE "public"."collection_share_tokens" TO "service_role";

GRANT UPDATE ON TABLE "public"."collection_share_tokens" TO "service_role";

GRANT DELETE ON TABLE "public"."gem_share_tokens" TO "anon";

GRANT INSERT ON TABLE "public"."gem_share_tokens" TO "anon";

GRANT REFERENCES ON TABLE "public"."gem_share_tokens" TO "anon";

GRANT SELECT ON TABLE "public"."gem_share_tokens" TO "anon";

GRANT TRIGGER ON TABLE "public"."gem_share_tokens" TO "anon";

GRANT TRUNCATE ON TABLE "public"."gem_share_tokens" TO "anon";

GRANT UPDATE ON TABLE "public"."gem_share_tokens" TO "anon";

GRANT DELETE ON TABLE "public"."gem_share_tokens" TO "authenticated";

GRANT INSERT ON TABLE "public"."gem_share_tokens" TO "authenticated";

GRANT REFERENCES ON TABLE "public"."gem_share_tokens" TO "authenticated";

GRANT SELECT ON TABLE "public"."gem_share_tokens" TO "authenticated";

GRANT TRIGGER ON TABLE "public"."gem_share_tokens" TO "authenticated";

GRANT TRUNCATE ON TABLE "public"."gem_share_tokens" TO "authenticated";

GRANT UPDATE ON TABLE "public"."gem_share_tokens" TO "authenticated";

GRANT DELETE ON TABLE "public"."gem_share_tokens" TO "service_role";

GRANT INSERT ON TABLE "public"."gem_share_tokens" TO "service_role";

GRANT REFERENCES ON TABLE "public"."gem_share_tokens" TO "service_role";

GRANT SELECT ON TABLE "public"."gem_share_tokens" TO "service_role";

GRANT TRIGGER ON TABLE "public"."gem_share_tokens" TO "service_role";

GRANT TRUNCATE ON TABLE "public"."gem_share_tokens" TO "service_role";

GRANT UPDATE ON TABLE "public"."gem_share_tokens" TO "service_role";

DROP POLICY IF EXISTS "Allow authorized delete access" ON "public"."gem_share_tokens";

CREATE POLICY "Allow authorized delete access" ON "public"."gem_share_tokens" AS permissive
    FOR DELETE TO authenticated
        USING (authorize('gem_share_tokens.delete'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized insert access" ON "public"."gem_share_tokens";

CREATE POLICY "Allow authorized insert access" ON "public"."gem_share_tokens" AS permissive
    FOR INSERT TO authenticated
        WITH CHECK (authorize('gem_share_tokens.insert'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized select access" ON "public"."gem_share_tokens";

CREATE POLICY "Allow authorized select access" ON "public"."gem_share_tokens" AS permissive
    FOR SELECT TO authenticated
        USING (authorize('gem_share_tokens.select'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized update access" ON "public"."gem_share_tokens";

CREATE POLICY "Allow authorized update access" ON "public"."gem_share_tokens" AS permissive
    FOR UPDATE TO authenticated
        USING (authorize('gem_share_tokens.update'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized delete access" ON "public"."collection_share_tokens";

CREATE POLICY "Allow authorized delete access" ON "public"."collection_share_tokens" AS permissive
    FOR DELETE TO authenticated
        USING (authorize('collection_share_tokens.delete'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized insert access" ON "public"."collection_share_tokens";

CREATE POLICY "Allow authorized insert access" ON "public"."collection_share_tokens" AS permissive
    FOR INSERT TO authenticated
        WITH CHECK (authorize('collection_share_tokens.insert'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized select access" ON "public"."collection_share_tokens";

CREATE POLICY "Allow authorized select access" ON "public"."collection_share_tokens" AS permissive
    FOR SELECT TO authenticated
        USING (authorize('collection_share_tokens.select'::app_permission, chest_id));

DROP POLICY IF EXISTS "Allow authorized update access" ON "public"."collection_share_tokens";

CREATE POLICY "Allow authorized update access" ON "public"."collection_share_tokens" AS permissive
    FOR UPDATE TO authenticated
        USING (authorize('collection_share_tokens.update'::app_permission, chest_id));

