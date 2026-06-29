# Testing

## Testing Strategy

ChuckleChest uses a layered testing approach:

| Layer      | Location              | What's Tested                      |
| ---------- | --------------------- | ---------------------------------- |
| Unit tests | `packages/*/test/`    | Repositories, clients in isolation |
| E2E tests  | `app/test/pages/*/`   | Full app flows with mocked clients |

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
