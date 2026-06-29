CREATE OR REPLACE FUNCTION public.fetch_collection_gem_ids_from_share_token(share_token_param uuid)
  RETURNS SETOF uuid
  LANGUAGE plpgsql
  SECURITY DEFINER
  AS $function$
DECLARE
  collection_id_var uuid;
BEGIN
  SELECT
    collection_id INTO collection_id_var
  FROM
    public.collection_share_tokens
  WHERE
    token = share_token_param;
  RETURN QUERY
  SELECT
    gem_id
  FROM
    public.collection_gems
  WHERE
    collection_id = collection_id_var;
END;
$function$;
