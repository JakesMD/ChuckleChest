ALTER TABLE ONLY "public"."invitations"
    ADD CONSTRAINT "invitations_chest_id_fkey" FOREIGN KEY ("chest_id") REFERENCES "public"."chests"("id") ON UPDATE CASCADE ON DELETE CASCADE;
