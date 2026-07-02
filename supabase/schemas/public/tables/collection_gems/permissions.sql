ALTER TABLE "public"."collection_gems" OWNER TO "postgres";

GRANT ALL ON TABLE "public"."collection_gems" TO "anon";

GRANT ALL ON TABLE "public"."collection_gems" TO "authenticated";

GRANT ALL ON TABLE "public"."collection_gems" TO "service_role";
