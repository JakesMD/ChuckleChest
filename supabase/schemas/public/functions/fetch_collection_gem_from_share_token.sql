CREATE OR REPLACE FUNCTION public.fetch_collection_gem_from_share_token(share_token_param uuid, gem_id_param uuid)
  RETURNS jsonb
  LANGUAGE plpgsql
  SECURITY DEFINER
  AS $function$
DECLARE
  collection_id_var uuid;
  result_var jsonb;
BEGIN
  SELECT
    collection_id INTO collection_id_var
  FROM
    public.collection_share_tokens
  WHERE
    token = share_token_param
  LIMIT 1;
  IF EXISTS (
    SELECT
      1
    FROM
      public.collection_gems
    WHERE
      collection_id = collection_id_var
      AND gem_id = gem_id_param) THEN
  result_var := fetch_gem_with_people(gem_id_param);
  RETURN result_var;
END IF;
  RAISE 'Permission denied. Share token not associated with the gem ID.';
END;
$function$;
