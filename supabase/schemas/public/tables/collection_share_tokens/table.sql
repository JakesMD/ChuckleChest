CREATE TABLE IF NOT EXISTS "public"."collection_share_tokens"(
    "chest_id" "uuid" NOT NULL,
    "collection_id" "uuid" NOT NULL,
    "token" "uuid" NOT NULL DEFAULT gen_random_uuid()
);

ALTER TABLE ONLY "public"."collection_share_tokens"
    ADD CONSTRAINT "collection_share_tokens_pkey" PRIMARY KEY ("collection_id");
