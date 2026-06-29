ALTER TABLE ONLY "public"."collection_gems"
    ADD CONSTRAINT "collection_gems_collection_id_fkey" FOREIGN KEY ("collection_id") REFERENCES "public"."collections"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."collection_gems"
    ADD CONSTRAINT "collection_gems_gem_id_fkey" FOREIGN KEY ("gem_id") REFERENCES "public"."gems"("id") ON UPDATE CASCADE ON DELETE CASCADE;
