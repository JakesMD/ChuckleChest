CREATE TABLE IF NOT EXISTS "public"."role_permissions"(
    "role" "public"."app_role" NOT NULL,
    "permission" "public"."app_permission" NOT NULL
);

ALTER TABLE ONLY "public"."role_permissions"
    ADD CONSTRAINT "role_permissions_pkey" PRIMARY KEY ("role", "permission");
