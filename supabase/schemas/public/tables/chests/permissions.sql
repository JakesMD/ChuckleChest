ALTER TABLE "public"."chests" OWNER TO "postgres";

GRANT ALL ON TABLE "public"."chests" TO "anon";

GRANT ALL ON TABLE "public"."chests" TO "authenticated";

GRANT ALL ON TABLE "public"."chests" TO "service_role";

GRANT ALL ON TABLE "public"."chests" TO "supabase_auth_admin";
