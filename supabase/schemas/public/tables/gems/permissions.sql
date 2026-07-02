ALTER TABLE "public"."gems" OWNER TO "postgres";

GRANT ALL ON TABLE "public"."gems" TO "anon";

GRANT ALL ON TABLE "public"."gems" TO "authenticated";

GRANT ALL ON TABLE "public"."gems" TO "service_role";
