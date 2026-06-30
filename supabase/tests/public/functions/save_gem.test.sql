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
    SELECT tests.authenticate_with_claims_as('owner');

    -- Act
    SELECT public.save_gem(
        gem_id_param => NULL,
        occurred_at_param => '2024-06-15'::date,
        chest_id_param => :'chest_id',
        deleted_line_ids_param => '{}'::bigint[],
        lines_param => jsonb_build_array(
            jsonb_build_object('id', NULL, 'text', 'Once upon a time...', 'person_id', NULL),
            jsonb_build_object('id', NULL, 'text', 'Hello!', 'person_id', :person_id),
            jsonb_build_object('id', NULL, 'text', 'The end.', 'person_id', NULL)
        )
    ) AS gem_id \gset

    -- Assert
    SELECT is(
        (SELECT count(*)::int FROM public.gems WHERE id = :'gem_id'),
        1,
        'Given: no existing gem. When: save_gem called with null id. Then: gem created.'
    );

    SELECT is(
        (SELECT occurred_at FROM public.gems WHERE id = :'gem_id'),
        '2024-06-15'::date,
        'Given: no existing gem. When: save_gem called. Then: occurred_at matches input.'
    );

    SELECT is(
        (SELECT count(*)::int FROM public.lines WHERE gem_id = :'gem_id'),
        3,
        'Given: no existing gem. When: save_gem called with 3 lines. Then: 3 lines created.'
    );

    SELECT is(
        (SELECT person_id FROM public.lines WHERE gem_id = :'gem_id' AND text = 'Hello!'),
        :person_id::bigint,
        'Given: line with person_id. When: save_gem called. Then: person_id stored correctly.'
    );


ROLLBACK TO arrange_all;


    -- Arrange
    SELECT tests.authenticate_with_claims_as('owner');

    SELECT public.save_gem(
        gem_id_param => NULL,
        occurred_at_param => '2024-06-15'::date,
        chest_id_param => :'chest_id',
        deleted_line_ids_param => '{}'::bigint[],
        lines_param => jsonb_build_array(
            jsonb_build_object('id', NULL, 'text', 'Line A', 'person_id', NULL),
            jsonb_build_object('id', NULL, 'text', 'Line B', 'person_id', :person_id),
            jsonb_build_object('id', NULL, 'text', 'Line C', 'person_id', NULL)
        )
    ) AS gem_id \gset

    SELECT
        ids[1] AS line_a_id,
        ids[2] AS line_b_id,
        ids[3] AS line_c_id
    FROM (
        SELECT array_agg(id ORDER BY id) AS ids
        FROM public.lines WHERE gem_id = :'gem_id'
    ) sub \gset

    -- Act
    SELECT public.save_gem(
        gem_id_param => :'gem_id',
        occurred_at_param => '2024-07-20'::date,
        chest_id_param => :'chest_id',
        deleted_line_ids_param => '{}'::bigint[],
        lines_param => jsonb_build_array(
            jsonb_build_object('id', :line_a_id, 'text', 'Line A', 'person_id', NULL),
            jsonb_build_object('id', :line_b_id, 'text', 'Line B updated', 'person_id', :person_id),
            jsonb_build_object('id', :line_c_id, 'text', 'Line C', 'person_id', NULL)
        )
    );

    -- Assert
    SELECT is(
        (SELECT occurred_at FROM public.gems WHERE id = :'gem_id'),
        '2024-07-20'::date,
        'Given: existing gem. When: save_gem called with new date. Then: date updated.'
    );

    SELECT is(
        (SELECT text FROM public.lines WHERE id = :line_b_id),
        'Line B updated',
        'Given: existing line. When: save_gem called with new text. Then: text updated.'
    );


ROLLBACK TO arrange_all;


    -- Arrange
    SELECT tests.authenticate_with_claims_as('owner');

    SELECT public.save_gem(
        gem_id_param => NULL,
        occurred_at_param => '2024-06-15'::date,
        chest_id_param => :'chest_id',
        deleted_line_ids_param => '{}'::bigint[],
        lines_param => jsonb_build_array(
            jsonb_build_object('id', NULL, 'text', 'Line A', 'person_id', NULL),
            jsonb_build_object('id', NULL, 'text', 'Line B', 'person_id', :person_id),
            jsonb_build_object('id', NULL, 'text', 'Line C', 'person_id', NULL)
        )
    ) AS gem_id \gset

    SELECT
        ids[1] AS line_a_id,
        ids[2] AS line_b_id,
        ids[3] AS line_c_id
    FROM (
        SELECT array_agg(id ORDER BY id) AS ids
        FROM public.lines WHERE gem_id = :'gem_id'
    ) sub \gset

    -- Act
    SELECT public.save_gem(
        gem_id_param => :'gem_id',
        occurred_at_param => '2024-06-15'::date,
        chest_id_param => :'chest_id',
        deleted_line_ids_param => ARRAY[:line_b_id]::bigint[],
        lines_param => jsonb_build_array(
            jsonb_build_object('id', :line_a_id, 'text', 'Line A', 'person_id', NULL),
            jsonb_build_object('id', :line_c_id, 'text', 'Line C', 'person_id', NULL)
        )
    );

    -- Assert
    SELECT is(
        (SELECT count(*)::int FROM public.lines WHERE gem_id = :'gem_id'),
        2,
        'Given: gem with 3 lines. When: middle line deleted. Then: 2 lines remain.'
    );

    SELECT is(
        (SELECT count(*)::int FROM public.lines WHERE id = :line_b_id),
        0,
        'Given: gem with 3 lines. When: middle line deleted. Then: deleted line gone from DB.'
    );


ROLLBACK TO arrange_all;


    -- Arrange
    SELECT tests.authenticate_with_claims_as('owner');

    SELECT public.save_gem(
        gem_id_param => NULL,
        occurred_at_param => '2024-06-15'::date,
        chest_id_param => :'chest_id',
        deleted_line_ids_param => '{}'::bigint[],
        lines_param => jsonb_build_array(
            jsonb_build_object('id', NULL, 'text', 'Line A', 'person_id', NULL),
            jsonb_build_object('id', NULL, 'text', 'Line B', 'person_id', NULL)
        )
    ) AS gem_id \gset

    SELECT
        ids[1] AS line_a_id,
        ids[2] AS line_b_id
    FROM (
        SELECT array_agg(id ORDER BY id) AS ids
        FROM public.lines WHERE gem_id = :'gem_id'
    ) sub \gset

    -- Act
    SELECT public.save_gem(
        gem_id_param => :'gem_id',
        occurred_at_param => '2024-06-15'::date,
        chest_id_param => :'chest_id',
        deleted_line_ids_param => ARRAY[:line_b_id]::bigint[],
        lines_param => jsonb_build_array(
            jsonb_build_object('id', :line_a_id, 'text', 'Line A', 'person_id', NULL),
            jsonb_build_object('id', NULL, 'text', 'New line', 'person_id', :person_id)
        )
    );

    -- Assert
    SELECT is(
        (SELECT count(*)::int FROM public.lines WHERE gem_id = :'gem_id'),
        2,
        'Given: gem with deleted line. When: new line added in same save. Then: count stays 2.'
    );

    SELECT ok(
        (SELECT EXISTS(SELECT 1 FROM public.lines WHERE gem_id = :'gem_id' AND text = 'New line')),
        'Given: gem with deleted line. When: new line added in same save. Then: new line exists.'
    );


SELECT * FROM finish();
ROLLBACK;
