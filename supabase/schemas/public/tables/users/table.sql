CREATE TABLE IF NOT EXISTS "public"."users"(
    "id" "uuid" NOT NULL,
    "username" "text"
);

ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");
