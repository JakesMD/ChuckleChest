ALTER TABLE "public"."lines" OWNER TO "postgres";

GRANT ALL ON TABLE "public"."lines" TO "anon";

GRANT ALL ON TABLE "public"."lines" TO "authenticated";

GRANT ALL ON TABLE "public"."lines" TO "service_role";
