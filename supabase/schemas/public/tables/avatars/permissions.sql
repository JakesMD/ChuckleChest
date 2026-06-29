ALTER TABLE "public"."avatars" OWNER TO "postgres";

GRANT ALL ON TABLE "public"."avatars" TO "anon";

GRANT ALL ON TABLE "public"."avatars" TO "authenticated";

GRANT ALL ON TABLE "public"."avatars" TO "service_role";
