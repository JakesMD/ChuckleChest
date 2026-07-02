ALTER TABLE "public"."collections" OWNER TO "postgres";

GRANT ALL ON TABLE "public"."collections" TO "anon";

GRANT ALL ON TABLE "public"."collections" TO "authenticated";

GRANT ALL ON TABLE "public"."collections" TO "service_role";
