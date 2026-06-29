ALTER TABLE ONLY "public"."chests"
    ADD CONSTRAINT "chests_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."users"("id") ON UPDATE CASCADE ON DELETE CASCADE;
