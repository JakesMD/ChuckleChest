ALTER TABLE "public"."gem_likes" OWNER TO "postgres";

GRANT ALL ON TABLE "public"."gem_likes" TO "anon";

GRANT ALL ON TABLE "public"."gem_likes" TO "authenticated";

GRANT ALL ON TABLE "public"."gem_likes" TO "service_role";
