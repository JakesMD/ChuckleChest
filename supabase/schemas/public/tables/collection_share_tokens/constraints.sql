ALTER TABLE ONLY "public"."collection_share_tokens"
    ADD CONSTRAINT "collection_share_tokens_collection_id_fkey" FOREIGN KEY ("collection_id") REFERENCES "public"."collections"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."collection_share_tokens"
    ADD CONSTRAINT "collection_share_tokens_token_key" UNIQUE ("token");
