CREATE OR REPLACE FUNCTION public.fetch_gem_from_share_token(share_token_param uuid)
  RETURNS jsonb
  LANGUAGE plpgsql
  SECURITY DEFINER
  AS $function$
DECLARE
  gem_id_var uuid;
  result_var jsonb;
BEGIN
  SELECT
    gem_id INTO gem_id_var
  FROM
    public.gem_share_tokens
  WHERE
    token = share_token_param
  LIMIT 1;
  result_var := fetch_gem_with_people(gem_id_var);
  RETURN result_var;
END;
$function$;
