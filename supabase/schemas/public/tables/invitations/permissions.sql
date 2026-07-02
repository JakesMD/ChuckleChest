ALTER TABLE "public"."invitations" OWNER TO "postgres";

GRANT ALL ON TABLE "public"."invitations" TO "anon";

GRANT ALL ON TABLE "public"."invitations" TO "authenticated";

GRANT ALL ON TABLE "public"."invitations" TO "service_role";
