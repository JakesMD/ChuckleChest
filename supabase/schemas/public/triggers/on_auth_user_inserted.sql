CREATE TRIGGER on_auth_user_inserted
    AFTER INSERT ON auth.users
    FOR EACH ROW
    EXECUTE FUNCTION handle_auth_user_insert();
