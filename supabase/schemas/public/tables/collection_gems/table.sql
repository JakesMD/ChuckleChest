CREATE TABLE IF NOT EXISTS "public"."collection_gems"(
    "collection_id" "uuid" NOT NULL,
    "gem_id" "uuid" NOT NULL
);

ALTER TABLE ONLY "public"."collection_gems"
    ADD CONSTRAINT "collection_gems_pkey" PRIMARY KEY ("collection_id", "gem_id");
