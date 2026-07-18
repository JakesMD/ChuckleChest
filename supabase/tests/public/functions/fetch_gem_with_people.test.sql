BEGIN;
SELECT no_plan();

    -- Arrange (shared setup)
    SELECT tests.create_chucklechest_user('owner');
    SELECT tests.create_chest('owner') AS chest_id \gset

    SELECT tests.authenticate_as_service_role();
    INSERT INTO public.people (nickname, date_of_birth, chest_id)
    VALUES ('Alice', '1990-01-01', :'chest_id')
    RETURNING id AS person_id \gset

SAVEPOINT arrange_all;


    -- Arrange
    SELECT tests.authenticate_as_service_role();
    INSERT INTO public.gems (number, occurred_at, chest_id)
    VALUES (1, '2024-06-15'::date, :'chest_id')
    RETURNING id AS gem_id \gset

    INSERT INTO public.lines (text, gem_id, chest_id, person_id)
    VALUES ('Hello!', :'gem_id', :'chest_id', :person_id);

    -- Act
    SELECT public.fetch_gem_with_people(:'gem_id') AS result \gset

    -- Assert
    SELECT is(
        (:'result'::jsonb -> 'gem' -> 'gem_share_tokens'),
        'null'::jsonb,
        'Given: gem with no share token. When: fetch_gem_with_people called. Then: gem_share_tokens key is present with a JSON null value (client model requires the key to exist).'
    );

    SELECT is(
        jsonb_array_length(:'result'::jsonb -> 'gem' -> 'lines'),
        1,
        'Given: gem with one line. When: fetch_gem_with_people called. Then: lines array has 1 entry.'
    );

    SELECT is(
        (:'result'::jsonb -> 'gem' -> 'lines' -> 0 ->> 'text'),
        'Hello!',
        'Given: gem with one line. When: fetch_gem_with_people called. Then: lines array contains the line text.'
    );

    SELECT is(
        (:'result'::jsonb -> 'people' -> 0 ->> 'nickname'),
        'Alice',
        'Given: line assigned to a person. When: fetch_gem_with_people called. Then: people array contains that person.'
    );


ROLLBACK TO arrange_all;


    -- Arrange
    SELECT tests.authenticate_as_service_role();
    INSERT INTO public.gems (number, occurred_at, chest_id)
    VALUES (1, '2024-06-15'::date, :'chest_id')
    RETURNING id AS gem_id \gset

    INSERT INTO public.lines (text, gem_id, chest_id, person_id)
    VALUES ('Just narration.', :'gem_id', :'chest_id', NULL);

    -- Act
    SELECT public.fetch_gem_with_people(:'gem_id') AS result \gset

    -- Assert
    SELECT is(
        (:'result'::jsonb -> 'people'),
        'null'::jsonb,
        'Given: gem with no lines assigned to a person. When: fetch_gem_with_people called. Then: people is null.'
    );


ROLLBACK TO arrange_all;


    -- Arrange
    SELECT tests.authenticate_as_service_role();
    INSERT INTO public.gems (number, occurred_at, chest_id)
    VALUES (1, '2024-06-15'::date, :'chest_id')
    RETURNING id AS gem_id \gset

    -- Act
    SELECT public.fetch_gem_with_people(:'gem_id') AS result \gset

    -- Assert
    SELECT is(
        (:'result'::jsonb -> 'gem' ->> 'id')::uuid,
        :'gem_id'::uuid,
        'Given: gem with zero lines. When: fetch_gem_with_people called. Then: gem data is still returned (not nulled out).'
    );


SELECT * FROM finish();
ROLLBACK;
