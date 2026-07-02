ALTER TABLE ONLY "public"."collections"
    ADD CONSTRAINT "collections_chest_id_fkey" FOREIGN KEY ("chest_id") REFERENCES "public"."chests"("id") ON UPDATE CASCADE ON DELETE CASCADE;
