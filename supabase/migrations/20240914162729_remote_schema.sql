alter table "public"."gems" alter column "number" drop not null;

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.handle_gem_insert()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$BEGIN
  IF NEW.number is NULL THEN
    NEW.number :=(
      SELECT
        COALESCE(MAX(number), 0)
      FROM
        public.gems
      WHERE
        chest_id = NEW.chest_id) + 1;
  END IF;
  RETURN NEW;
END;$function$
;


