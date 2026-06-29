CREATE TABLE IF NOT EXISTS "public"."gem_share_tokens"(
    "chest_id" "uuid" NOT NULL,
    "gem_id" "uuid" NOT NULL,
    "token" "uuid" NOT NULL DEFAULT gen_random_uuid()
);

ALTER TABLE ONLY "public"."gem_share_tokens"
    ADD CONSTRAINT "gem_share_tokens_pkey" PRIMARY KEY ("gem_id");
