ALTER TABLE ONLY "public"."avatars"
    ADD CONSTRAINT "connection_avatar_urls_connection_id_fkey" FOREIGN KEY ("person_id") REFERENCES "public"."people"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."avatars"
    ADD CONSTRAINT "person_avatar_urls_chest_id_fkey" FOREIGN KEY ("chest_id") REFERENCES "public"."chests"("id") ON UPDATE CASCADE ON DELETE CASCADE;
