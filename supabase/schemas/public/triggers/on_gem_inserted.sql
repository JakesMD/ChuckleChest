CREATE TRIGGER on_gem_inserted
    BEFORE INSERT ON public.gems
    FOR EACH ROW
    EXECUTE FUNCTION handle_gem_insert();
