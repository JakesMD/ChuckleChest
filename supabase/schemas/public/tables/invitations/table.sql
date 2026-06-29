CREATE TABLE IF NOT EXISTS "public"."invitations"(
    "chest_id" "uuid" NOT NULL,
    "email" "text" NOT NULL,
    "assigned_role" "public"."app_role" NOT NULL DEFAULT 'viewer'::"public"."app_role"
);

ALTER TABLE ONLY "public"."invitations"
    ADD CONSTRAINT "invitations_pkey" PRIMARY KEY ("chest_id", "email");
