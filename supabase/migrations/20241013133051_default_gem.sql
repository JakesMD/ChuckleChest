CREATE OR REPLACE FUNCTION public.handle_chest_insert()
  RETURNS TRIGGER
  LANGUAGE plpgsql
  SECURITY DEFINER
  AS $function$
DECLARE
  personID int;
  gemID uuid;
BEGIN
  INSERT INTO public.user_roles(user_id, chest_id, ROLE)
    VALUES (auth.uid(), NEW.id, 'owner');
  INSERT INTO public.people(nickname, date_of_birth, chest_id)
    VALUES ('Jacob from ChuckleChest', '2003-03-10', NEW.id)
  RETURNING
    id INTO personID;
  INSERT INTO public.gems(chest_id)
    VALUES (NEW.id)
  RETURNING
    id INTO gemID;
  INSERT INTO public.lines(chest_id, gem_id, person_id, text)
    VALUES (NEW.id, gemID, personID, 'Hi there! Doing ok?'),
(NEW.id, gemID, personID, 'Great! Then let me show you how to use ChuckleChest.');
  RETURN NEW;
END;
$function$;

