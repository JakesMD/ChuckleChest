CREATE TABLE IF NOT EXISTS "public"."user_roles"(
    "user_id" "uuid" NOT NULL,
    "role" "public"."app_role" NOT NULL DEFAULT 'viewer'::"public"."app_role",
    "chest_id" "uuid" NOT NULL
);

ALTER TABLE ONLY "public"."user_roles"
    ADD CONSTRAINT "user_roles_pkey" PRIMARY KEY ("user_id", "chest_id");
