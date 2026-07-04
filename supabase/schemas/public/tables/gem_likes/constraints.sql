ALTER TABLE ONLY "public"."gem_likes"
    ADD CONSTRAINT "gem_likes_gem_id_fkey" FOREIGN KEY ("gem_id") REFERENCES "public"."gems"("id") ON UPDATE CASCADE ON DELETE CASCADE;
