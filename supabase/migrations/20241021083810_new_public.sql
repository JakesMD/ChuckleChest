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

CREATE UNIQUE INDEX collection_share_links_key_key ON public.collection_share_tokens USING btree(token);

CREATE UNIQUE INDEX collection_share_tokens_pkey ON public.collection_share_tokens USING btree(chest_id, collection_id);

CREATE UNIQUE INDEX gem_share_tokens_pkey ON public.gem_share_tokens USING btree(chest_id, gem_id);

CREATE UNIQUE INDEX gem_share_tokens_token_key ON public.gem_share_tokens USING btree(token);

ALTER TABLE "public"."collection_share_tokens"
    ADD CONSTRAINT "collection_share_tokens_pkey" PRIMARY KEY USING INDEX "collection_share_tokens_pkey";

ALTER TABLE "public"."gem_share_tokens"
    ADD CONSTRAINT "gem_share_tokens_pkey" PRIMARY KEY USING INDEX "gem_share_tokens_pkey";

ALTER TABLE "public"."collection_share_tokens"
    ADD CONSTRAINT "collection_share_links_chest_id_fkey" FOREIGN KEY (chest_id) REFERENCES chests(id) ON UPDATE CASCADE ON DELETE CASCADE NOT valid;

ALTER TABLE "public"."collection_share_tokens" validate CONSTRAINT "collection_share_links_chest_id_fkey";

ALTER TABLE "public"."collection_share_tokens"
    ADD CONSTRAINT "collection_share_links_collection_id_fkey" FOREIGN KEY (collection_id) REFERENCES collections(id) ON UPDATE CASCADE ON DELETE CASCADE NOT valid;

ALTER TABLE "public"."collection_share_tokens" validate CONSTRAINT "collection_share_links_collection_id_fkey";

ALTER TABLE "public"."collection_share_tokens"
    ADD CONSTRAINT "collection_share_links_key_key" UNIQUE USING INDEX "collection_share_links_key_key";

ALTER TABLE "public"."gem_share_tokens"
    ADD CONSTRAINT "gem_share_tokens_chest_id_fkey" FOREIGN KEY (chest_id) REFERENCES chests(id) ON UPDATE CASCADE ON DELETE CASCADE NOT valid;

ALTER TABLE "public"."gem_share_tokens" validate CONSTRAINT "gem_share_tokens_chest_id_fkey";

ALTER TABLE "public"."gem_share_tokens"
    ADD CONSTRAINT "gem_share_tokens_gem_id_fkey" FOREIGN KEY (gem_id) REFERENCES gems(id) ON UPDATE CASCADE ON DELETE CASCADE NOT valid;

ALTER TABLE "public"."gem_share_tokens" validate CONSTRAINT "gem_share_tokens_gem_id_fkey";

ALTER TABLE "public"."gem_share_tokens"
    ADD CONSTRAINT "gem_share_tokens_token_key" UNIQUE USING INDEX "gem_share_tokens_token_key";

SET check_function_bodies = OFF;

CREATE OR REPLACE FUNCTION public.fetch_collection_gem_from_share_token(share_token_param uuid, gem_id_param uuid)
    RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
    AS $function$
DECLARE
    collection_id_var uuid;
    result_var jsonb;
BEGIN
    SELECT
        collection_id INTO collection_id_var
    FROM
        public.collection_share_tokens
    WHERE
        token = share_token_param
    LIMIT 1;
    IF EXISTS (
        SELECT
            1
        FROM
            public.collection_gems
        WHERE
            collection_id = collection_id_var
            AND gem_id = gem_id_param) THEN
    result_var := fetch_gem_with_people(gem_id_param);
    RETURN result_var;
END IF;
    RAISE 'Permission denied. Share token not associated with the gem ID.';
END;
$function$;

CREATE OR REPLACE FUNCTION public.fetch_collection_gem_ids_from_share_token(share_token_param uuid)
    RETURNS SETOF uuid
    LANGUAGE plpgsql
    SECURITY DEFINER
    AS $function$
DECLARE
    collection_id_var uuid;
BEGIN
    SELECT
        collection_id INTO collection_id_var
    FROM
        public.collection_share_tokens
    WHERE
        token = share_token_param;
    RETURN QUERY
    SELECT
        gem_id
    FROM
        public.collection_gems
    WHERE
        collection_id = collection_id_var;
END;
$function$;

CREATE OR REPLACE FUNCTION public.fetch_gem_from_share_token(share_token_param uuid)
    RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
    AS $function$
DECLARE
    gem_id_var uuid;
    result_var jsonb;
BEGIN
    SELECT
        gem_id INTO gem_id_var
    FROM
        public.gem_share_tokens
    WHERE
        token = share_token_param
    LIMIT 1;
    result_var := fetch_gem_with_people(gem_id_var);
    RETURN result_var;
END;
$function$;

CREATE OR REPLACE FUNCTION public.fetch_gem_with_people(gem_id_param uuid)
    RETURNS jsonb
    LANGUAGE plpgsql
    AS $function$
DECLARE
    gem_data_var jsonb;
    lines_data_var jsonb;
    people_data_var jsonb;
BEGIN
    SELECT
        row_to_json(g) INTO gem_data_var
    FROM
        public.gems g
    WHERE
        g.id = gem_id_param
    LIMIT 1;
    -- Fetch the lines associated with the gem
    SELECT
        jsonb_agg(DISTINCT l) FILTER (WHERE l.id IS NOT NULL) INTO lines_data_var
    FROM
        public.lines l
    WHERE
        l.gem_id = gem_id_param;
    -- Fetch the people associated with the lines
    SELECT
        jsonb_agg(DISTINCT p) FILTER (WHERE p.id IS NOT NULL) INTO people_data_var
    FROM
        public.people p
    WHERE
        p.id IN (
            SELECT
                l.person_id
            FROM
                public.lines l
            WHERE
                l.gem_id = gem_id_param);
    -- Combine gem_data, lines_data, and people_data into a single JSONB object
    RETURN jsonb_set(gem_data_var, '{lines}', lines_data_var, TRUE) || jsonb_set(gem_data_var, '{people}', people_data_var, TRUE);
END;
$function$;

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

