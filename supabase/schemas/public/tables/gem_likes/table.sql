CREATE TABLE IF NOT EXISTS "public"."gem_likes"(
    "chest_id" "uuid" NOT NULL,
    "gem_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL DEFAULT auth.uid(),
    "liked_at" timestamp with time zone NOT NULL DEFAULT now()
);

ALTER TABLE ONLY "public"."gem_likes"
    ADD CONSTRAINT "gem_likes_pkey" PRIMARY KEY ("gem_id", "user_id");
