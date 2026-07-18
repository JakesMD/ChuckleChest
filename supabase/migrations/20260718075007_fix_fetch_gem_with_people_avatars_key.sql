set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.fetch_gem_with_people(gem_id_param uuid)
 RETURNS jsonb
 LANGUAGE plpgsql
AS $function$
DECLARE
  gem_data_var jsonb;
  lines_data_var jsonb;
  people_data_var jsonb;
BEGIN
  SELECT
    row_to_json(g) INTO gem_data_var
  FROM
    public.gems g
  WHERE
    g.id = gem_id_param
  LIMIT 1;
  -- The client model requires the `gem_share_tokens` key to be present, even
  -- though it's not needed here.
  gem_data_var := jsonb_set(gem_data_var, '{gem_share_tokens}', 'null'::jsonb, TRUE);
  -- Fetch the lines associated with the gem
  SELECT
    jsonb_agg(DISTINCT l) FILTER (WHERE l.id IS NOT NULL) INTO lines_data_var
  FROM
    public.lines l
  WHERE
    l.gem_id = gem_id_param;
  -- Fetch the people associated with the lines
  -- The client model requires the `avatars` key to be present on each
  -- person, even though it's not needed here.
  SELECT
    jsonb_agg(DISTINCT jsonb_set(to_jsonb(p), '{avatars}', 'null'::jsonb, TRUE)) FILTER (WHERE p.id IS NOT NULL) INTO people_data_var
  FROM
    public.people p
  WHERE
    p.id IN (
      SELECT
        l.person_id
      FROM
        public.lines l
      WHERE
        l.gem_id = gem_id_param);
  -- Combine gem_data, lines_data, and people_data into a single JSONB object
  RETURN jsonb_build_object('gem', jsonb_set(gem_data_var, '{lines}', coalesce(lines_data_var, '[]'::jsonb), TRUE), 'people', people_data_var);
END;
$function$
;


