ALTER TABLE "public"."user_roles" OWNER TO "postgres";

GRANT ALL ON TABLE "public"."user_roles" TO "anon";

GRANT ALL ON TABLE "public"."user_roles" TO "authenticated";

GRANT ALL ON TABLE "public"."user_roles" TO "service_role";

GRANT ALL ON TABLE "public"."user_roles" TO "supabase_auth_admin";
