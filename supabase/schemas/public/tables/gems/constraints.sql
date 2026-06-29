ALTER TABLE ONLY "public"."gems"
    ADD CONSTRAINT "gems_chest_id_fkey" FOREIGN KEY ("chest_id") REFERENCES "public"."chests"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."gems"
    ADD CONSTRAINT "gems_id_key" UNIQUE ("id");
