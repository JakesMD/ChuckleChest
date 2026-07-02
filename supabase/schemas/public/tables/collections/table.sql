CREATE TABLE IF NOT EXISTS "public"."collections"(
    "id" "uuid" NOT NULL DEFAULT gen_random_uuid(),
    "name" "text" NOT NULL DEFAULT ''::text,
    "chest_id" "uuid" NOT NULL
);

ALTER TABLE ONLY "public"."collections"
    ADD CONSTRAINT "collections_pkey" PRIMARY KEY ("id");
