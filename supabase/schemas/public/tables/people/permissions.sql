ALTER TABLE "public"."people" OWNER TO "postgres";

GRANT ALL ON TABLE "public"."people" TO "anon";

GRANT ALL ON TABLE "public"."people" TO "authenticated";

GRANT ALL ON TABLE "public"."people" TO "service_role";
