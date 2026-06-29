ALTER TABLE "public"."gem_share_tokens" OWNER TO "postgres";

GRANT ALL ON TABLE "public"."gem_share_tokens" TO "anon";

GRANT ALL ON TABLE "public"."gem_share_tokens" TO "authenticated";

GRANT ALL ON TABLE "public"."gem_share_tokens" TO "service_role";
