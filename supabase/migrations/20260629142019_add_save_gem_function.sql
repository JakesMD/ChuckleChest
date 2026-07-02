set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.save_gem(gem_id_param uuid, occurred_at_param date, chest_id_param uuid, deleted_line_ids_param bigint[], lines_param jsonb)
 RETURNS uuid
 LANGUAGE plpgsql
AS $function$
DECLARE
  result_id_var uuid;
  line_var jsonb;
BEGIN
  -- Upsert gem
  INSERT INTO public.gems (id, occurred_at, chest_id)
  VALUES (COALESCE(gem_id_param, gen_random_uuid()), occurred_at_param, chest_id_param)
  ON CONFLICT (id) DO UPDATE SET occurred_at = EXCLUDED.occurred_at
  RETURNING id INTO result_id_var;

  -- Delete removed lines
  IF array_length(deleted_line_ids_param, 1) > 0 THEN
    DELETE FROM public.lines WHERE id = ANY(deleted_line_ids_param);
  END IF;

  -- Upsert all lines
  FOR line_var IN SELECT * FROM jsonb_array_elements(lines_param)
  LOOP
    IF line_var ->> 'id' IS NOT NULL THEN
      UPDATE public.lines
      SET text = line_var ->> 'text',
          person_id = (line_var ->> 'person_id')::bigint
      WHERE id = (line_var ->> 'id')::bigint;
    ELSE
      INSERT INTO public.lines (text, person_id, gem_id, chest_id)
      VALUES (
        line_var ->> 'text',
        (line_var ->> 'person_id')::bigint,
        result_id_var,
        chest_id_param
      );
    END IF;
  END LOOP;

  RETURN result_id_var;
END;
$function$
;


