-- THE SUPABASE CLI DOES NOT KNOW HOW TO DIFF THESE STATEMENTS
-- DO NOT DELETE!!!
GRANT EXECUTE ON FUNCTION "public"."custom_access_token_hook" TO "supabase_auth_admin";

GRANT usage ON SCHEMA "public" TO "supabase_auth_admin";

REVOKE EXECUTE ON FUNCTION "public"."custom_access_token_hook" FROM authenticated, anon;

CREATE TRIGGER on_auth_user_inserted
    AFTER INSERT ON auth.users
    FOR EACH ROW
    EXECUTE FUNCTION handle_auth_user_insert();

CREATE TRIGGER on_auth_user_updated
    AFTER UPDATE ON auth.users
    FOR EACH ROW
    EXECUTE FUNCTION handle_auth_user_update();

