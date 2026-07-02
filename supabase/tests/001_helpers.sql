CREATE OR REPLACE FUNCTION tests.create_chucklechest_user(username_ text)
RETURNS uuid
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN tests.create_supabase_user(username_, username_ || '@test.com');
END;
$$;

CREATE OR REPLACE FUNCTION tests.authenticate_with_claims_as(username_ text)
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
    _user_id uuid;
    _claims jsonb;
    _original_claims text;
BEGIN
    PERFORM tests.authenticate_as_service_role();

    _user_id := tests.get_supabase_uid(username_);
    _claims := (public.custom_access_token_hook(
        jsonb_build_object('user_id', _user_id, 'claims', '{}'::jsonb)
    ) -> 'claims');

    PERFORM tests.authenticate_as(username_);
    _original_claims := current_setting('request.jwt.claims', true);

    PERFORM set_config(
        'request.jwt.claims',
        (COALESCE(_original_claims, '{}')::jsonb || _claims)::text,
        true
    );
END;
$$;

CREATE OR REPLACE FUNCTION tests.create_chest(owner_username_ text, chest_name_ text = 'Test Chest')
RETURNS uuid
LANGUAGE plpgsql
AS $$
DECLARE
    _chest_id uuid;
BEGIN
    PERFORM tests.authenticate_as(owner_username_);
    INSERT INTO public.chests (name) VALUES (chest_name_)
    RETURNING id INTO _chest_id;
    PERFORM tests.authenticate_as_service_role();
    RETURN _chest_id;
END;
$$;

BEGIN;
SELECT plan(1);

SELECT ok(TRUE, 'helpers completed successfully');

SELECT * FROM finish();
ROLLBACK;
