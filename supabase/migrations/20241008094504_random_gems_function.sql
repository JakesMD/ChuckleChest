CREATE OR REPLACE FUNCTION public.fetch_random_gem_ids(chest_id_param uuid, limit_param integer)
  RETURNS SETOF uuid
  LANGUAGE plpgsql
  AS $function$
BEGIN
  RETURN QUERY
  SELECT
    id
  FROM
    public.gems
  WHERE
    chest_id = chest_id_param
  ORDER BY
    random()
  LIMIT limit_param;
END;
$function$;

