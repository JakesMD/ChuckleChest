ALTER TABLE ONLY "public"."gem_share_tokens"
    ADD CONSTRAINT "gem_share_tokens_gem_id_fkey" FOREIGN KEY ("gem_id") REFERENCES "public"."gems"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."gem_share_tokens"
    ADD CONSTRAINT "gem_share_tokens_token_key" UNIQUE ("token");
