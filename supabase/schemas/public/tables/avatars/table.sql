CREATE TABLE IF NOT EXISTS "public"."avatars"(
    "person_id" bigint NOT NULL,
    "year" smallint NOT NULL,
    "image_url" "text" NOT NULL,
    "chest_id" "uuid" NOT NULL
);

ALTER TABLE ONLY "public"."avatars"
    ADD CONSTRAINT "avatars_pkey" PRIMARY KEY ("person_id", "year");
