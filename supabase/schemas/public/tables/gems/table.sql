CREATE TABLE IF NOT EXISTS "public"."gems"(
    "id" "uuid" NOT NULL DEFAULT gen_random_uuid(),
    "created_at" timestamp with time zone NOT NULL DEFAULT now(),
    "number" smallint NOT NULL,
    "occurred_at" date NOT NULL DEFAULT now(),
    "chest_id" "uuid" NOT NULL
);

ALTER TABLE ONLY "public"."gems"
    ADD CONSTRAINT "gems_pkey" PRIMARY KEY ("id");
