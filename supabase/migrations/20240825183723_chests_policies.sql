SET check_function_bodies = OFF;

CREATE OR REPLACE FUNCTION public.handle_chest_insert()
  RETURNS TRIGGER
  LANGUAGE plpgsql
  SECURITY DEFINER
  AS $function$
BEGIN
  INSERT INTO public.user_roles(user_id, chest_id, ROLE)
    VALUES(auth.uid(), NEW.id, 'owner');
  RETURN NEW;
END;
$function$;

CREATE TRIGGER on_chest_inserted
  AFTER INSERT ON public.chests
  FOR EACH ROW
  EXECUTE FUNCTION handle_chest_insert();

DROP POLICY "Allow authorized insert access" ON "public"."chests";

ALTER TABLE "public"."chests"
  ADD COLUMN "created_by" uuid NOT NULL DEFAULT auth.uid();

ALTER TABLE "public"."chests"
  ADD CONSTRAINT "chests_created_by_fkey" FOREIGN KEY (created_by) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT valid;

ALTER TABLE "public"."chests" validate CONSTRAINT "chests_created_by_fkey";

CREATE POLICY "Allow insert access for authenticated" ON "public"."chests" AS permissive
  FOR INSERT TO authenticated
    WITH CHECK (TRUE);

CREATE POLICY "Allow select access for new creators" ON "public"."chests" AS permissive
  FOR SELECT TO authenticated
    USING ((auth.uid() = created_by));

CREATE POLICY "Allow all access for supabase admin" ON "public"."user_roles" AS permissive
  FOR ALL TO supabase_admin
    USING (TRUE);

