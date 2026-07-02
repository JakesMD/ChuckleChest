CREATE OR REPLACE FUNCTION public.fetch_distinct_gem_years(chest_id_param uuid)
  RETURNS SETOF smallint
  LANGUAGE plpgsql
  AS $function$
BEGIN
  RETURN QUERY SELECT DISTINCT
    EXTRACT(YEAR FROM occurred_at)::int2
  FROM
    public.gems
  WHERE
    chest_id = chest_id_param;
END;
$function$;
