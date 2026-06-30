# Testing

## Testing Strategy

ChuckleChest uses a layered testing approach:

| Layer          | Location              | What's Tested                        |
| -------------- | --------------------- | ------------------------------------ |
| Supabase tests | `supabase/tests/`     | DB functions, triggers, RLS policies |
| Unit tests     | `packages/*/test/`    | Repositories, clients in isolation   |
| E2E tests      | `app/test/pages/*/`   | Full app flows with mocked clients   |

### Supabase Tests

pgTAP tests for every DB function, trigger, and RLS policy change. More
important than Dart tests — if the DB is wrong, the app is wrong.

Run: `hobnob db:test`

Before writing tests, read `supabase/tests/001_helpers.sql` — helpers change
frequently, new ones can be added there (add shared helpers there, not inline).

#### Structure

```sql
BEGIN;
SELECT no_plan();  -- Always no_plan(), never plan(N)

    -- Arrange (one-time setup shared across all scenarios)
    SELECT tests.create_chucklechest_user('owner');
    SELECT tests.create_chest('owner') AS chest_id \gset

SAVEPOINT arrange_all;


    -- Arrange
    SELECT tests.authenticate_with_claims_as('owner');

    -- Act
    SELECT public.some_function(:'chest_id') AS result \gset

    -- Assert (one is() / ok() / throws_ok() per requirement)
    SELECT is(
        (SELECT count(*)::int FROM public.some_table WHERE chest_id = :'chest_id'),
        1,
        'Given: owner authenticated. When: some_function called. Then: record created.'
    );


ROLLBACK TO arrange_all;


    -- (next scenario from same base state)


SELECT * FROM finish();
ROLLBACK;
```

#### Rules

- `no_plan()` always — never `plan(N)`
- `SAVEPOINT arrange_all` + `ROLLBACK TO arrange_all` between scenarios — resets
  to shared base state
- One `is()` / `ok()` / `throws_ok()` per test — one requirement per assertion
- Test descriptions: `'Given: ... When: ... Then: ...'`
- AAA comments on every scenario: `-- Arrange`, `-- Act`, `-- Assert`
- Use `\gset` to capture return values: `SELECT fn() AS var \gset` → `:var`
- Authenticate before every Act: `tests.authenticate_with_claims_as('user')` or
  `tests.authenticate_as_service_role()`

### E2E Tests

End-to-end tests pump the **full app** with real repositories, real cubits, and
real routing — only the **data clients** are mocked. This means tests exercise
the actual state management and navigation without caring whether it's BLoC,
Riverpod, or anything else.

E2E tests verify **user flows** (navigation, interactions, page transitions),
not UI appearance. Widget visibility checks (e.g. finding a
`CircularProgressIndicator`) are used only to confirm the correct page/state is
shown.

## Test Infrastructure

### `app/test/helpers/`

| File                | Purpose                                          |
| ------------------- | ------------------------------------------------ |
| `test_clients.dart` | `CTestClients` — mock clients with defaults      |
| `pump_app.dart`     | `pumpChuckleChestApp()` — WidgetTester extension |
| `mock_storage.dart` | `buildMockStorage()` — HydratedBloc mock         |
| `helpers.dart`      | Barrel export                                    |

### `CTestClients`

Creates mocked versions of all six data clients. The constructor stubs
`authClient.currentUserStream` to emit a signed-out state by default. Override
individual method stubs in your test's `setUp` or inline:

```dart
late CTestClients clients;

setUp(() {
  clients = CTestClients();
  when(
    () => clients.authClient.logInWithOTP(email: any(named: 'email')),
  ).thenReturn(bobsFakeSuccessJob(bobsNothing));
});
```

### `pumpChuckleChestApp()`

Extension on `WidgetTester` that:

1. Sets up mock `HydratedBloc.storage`
2. Wraps the app in `CAppDependenciesProvider` with mock clients
3. Builds `ChuckleChestApp` with the `development` flavor
4. Calls `pumpAndSettle()`

Supports `startAt` parameter for deep linking to a specific route:

```dart
await tester.pumpChuckleChestApp(
  clients: clients,
  startAt: '/signin/login',
);
```

### Testable Dependency Injection

`CAppDependenciesProvider` accepts optional client overrides. In production, it
creates clients from the Supabase instance. In tests, mock clients are injected
directly — no Supabase connection needed.

## Writing E2E Tests

Tests go in `app/test/pages/<page_name>/`. Follow this pattern:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_beautifier/test_beautifier.dart';

import '../helpers/helpers.dart';

void main() {
  group('Feature Tests', () {
    late CTestClients clients;

    setUp(() {
      clients = CTestClients();
    });

    testWidgets(
      requirement(
        given: 'some precondition',
        whenever: 'user does something',
        then: 'expected outcome',
        why: 'reason this matters',
      ),
      (tester) async {
        // Stub client methods as needed
        when(() => clients.authClient.someMethod())
            .thenReturn(bobsFakeSuccessJob(someValue));

        // Pump the app
        await tester.pumpChuckleChestApp(clients: clients);

        // Interact
        await tester.tap(find.byType(SomeButton));
        await tester.pumpAndSettle();

        // Assert
        expect(find.byType(ExpectedPage), findsOneWidget);
      },
    );
  });
}
```

### Guidelines

- **Mock at the client level** — repositories, cubits, and routing stay real
- **Use `find.byType()`** over `find.text()` — avoids coupling to localized
  strings
- **State management agnostic** — tests interact via widgets, not via
  cubits/blocs directly
- **No UI appearance tests** — only verify widget presence and navigation
- Use `test_beautifier`'s `requirement()` for BDD-style test descriptions
- Use `bobsFakeSuccessJob()` / `bobsFakeFailureJob()` from `bobs_jobs` to stub
  client methods

## Running Tests

```bash
hobnob dart:test
```

---

**See also:** [Architecture](Architecture) · [Authentication](Authentication)
