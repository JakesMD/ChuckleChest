CREATE TABLE IF NOT EXISTS "public"."chests"(
    "id" "uuid" NOT NULL DEFAULT gen_random_uuid(),
    "name" "text" NOT NULL DEFAULT ''::text,
    "created_by" "uuid" NOT NULL DEFAULT auth.uid()
);

ALTER TABLE ONLY "public"."chests"
    ADD CONSTRAINT "chests_pkey" PRIMARY KEY ("id");
