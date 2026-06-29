ALTER TABLE "public"."role_permissions" OWNER TO "postgres";

GRANT ALL ON TABLE "public"."role_permissions" TO "anon";

GRANT ALL ON TABLE "public"."role_permissions" TO "authenticated";

GRANT ALL ON TABLE "public"."role_permissions" TO "service_role";
