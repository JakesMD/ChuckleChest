ALTER TABLE ONLY "public"."people"
    ADD CONSTRAINT "connections_id_key" UNIQUE ("id");

ALTER TABLE ONLY "public"."people"
    ADD CONSTRAINT "people_chest_id_fkey" FOREIGN KEY ("chest_id") REFERENCES "public"."chests"("id") ON UPDATE CASCADE ON DELETE CASCADE;
