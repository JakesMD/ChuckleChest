ALTER TABLE ONLY "public"."lines"
    ADD CONSTRAINT "lines_chest_id_fkey" FOREIGN KEY ("chest_id") REFERENCES "public"."chests"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."lines"
    ADD CONSTRAINT "lines_gem_id_fkey" FOREIGN KEY ("gem_id") REFERENCES "public"."gems"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."lines"
    ADD CONSTRAINT "lines_id_key" UNIQUE ("id");

ALTER TABLE ONLY "public"."lines"
    ADD CONSTRAINT "lines_person_id_fkey" FOREIGN KEY ("person_id") REFERENCES "public"."people"("id") ON UPDATE CASCADE ON DELETE CASCADE;
