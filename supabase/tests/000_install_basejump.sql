-- Disable notices (effectively silences RAISE NOTICE)
SET client_min_messages TO warning;

-- install tests utilities
-- install pgtap extension for testing
CREATE EXTENSION IF NOT EXISTS pgtap WITH SCHEMA extensions;

/*
---------------------
---- install dbdev ----
----------------------
Requires:
- pg_tle: https://github.com/aws/pg_tle
- pgsql-http: https://github.com/pramsey/pgsql-http
*/
CREATE EXTENSION IF NOT EXISTS http WITH SCHEMA extensions;

CREATE EXTENSION IF NOT EXISTS pg_tle;

DROP EXTENSION IF EXISTS "supabase-dbdev";

SELECT
    pgtle.uninstall_extension_if_exists('supabase-dbdev');

SELECT
    pgtle.install_extension(
        'supabase-dbdev',
        resp.contents ->> 'version',
        'PostgreSQL package manager',
        resp.contents ->> 'sql'
    )
FROM
    extensions.http(
        (
            'GET',
            'https://api.database.dev/rest/v1/' || 'package_versions?select=sql,version' || '&package_name=eq.supabase-dbdev' || '&order=version.desc' || '&limit=1',
            ARRAY [('apiKey', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhtdXB0cHBsZnZpaWZyYndtbXR2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODAxMDczNzIsImV4cCI6MTk5NTY4MzM3Mn0.z2CN0mvO2No8wSi46Gw59DFGCTJrzM0AQKsu_5k134s')::extensions.http_header],
            NULL,
            NULL
        )
    ) x,
    LATERAL (
        SELECT
            (
                (row_to_json(x) -> 'content') #>> '{}')::json -> 0) resp(contents);
                CREATE EXTENSION "supabase-dbdev";

SELECT
    dbdev.install('supabase-dbdev');

DROP EXTENSION IF EXISTS "supabase-dbdev";

CREATE EXTENSION "supabase-dbdev";

-- Install test helpers
SELECT
    dbdev.install('basejump-supabase_test_helpers');

CREATE EXTENSION IF NOT EXISTS "basejump-supabase_test_helpers" version '0.0.6';

-- Re-enable notices
SET client_min_messages TO notice;


-- Verify setup with a no-op test
BEGIN;

SELECT
    plan(1);

SELECT
    ok(
        TRUE,
        'Pre-test hook completed successfully'
    );

SELECT
    *
FROM
    finish();

ROLLBACK;
