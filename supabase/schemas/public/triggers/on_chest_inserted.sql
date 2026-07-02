CREATE TRIGGER on_chest_inserted
    AFTER INSERT ON public.chests
    FOR EACH ROW
    EXECUTE FUNCTION handle_chest_insert();
