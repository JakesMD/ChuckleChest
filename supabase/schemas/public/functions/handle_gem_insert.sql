CREATE OR REPLACE FUNCTION public.handle_gem_insert()
  RETURNS TRIGGER
  LANGUAGE plpgsql
  AS $function$
DECLARE
  colID bigint;
BEGIN
  NEW.number :=(
    SELECT
      COALESCE(MAX(number), 0)
    FROM
      public.gems
    WHERE
      chest_id = NEW.chest_id) + 1;
  RETURN NEW;
END;
$function$;
