# Architecture

ChuckleChest is a Flutter web app backed by Supabase. The codebase is organized
as a Dart workspace with clean separation between UI, domain, and data layers.

## Project Structure

```
chuckle_chest/
├── app/                    -- Flutter app (UI + BLoC state management)
├── packages/
│   ├── core/               -- Shared models, helpers, and localization
│   ├── domain/             -- Repository layer (business logic)
│   │   ├── auth_repository/
│   │   ├── chest_repository/
│   │   ├── gem_repository/
│   │   ├── person_repository/
│   │   └── platform_repository/
│   └── data/               -- Client layer (API calls)
│       ├── auth_client/
│       ├── database_client/
│       ├── platform_client/
│       └── storage_client/
├── supabase/               -- Migrations, seed data, config
├── website/                -- GitHub Pages static site
├── wiki/                   -- Synced to GitHub wiki on release
└── hobnob.yml              -- Task runner config
```

## Layered Architecture

```
┌─────────────────────────────────────────┐
│  app/                                   │
│  Flutter UI + BLoC/Cubit state mgmt     │
│  Depends on: domain, core               │
├─────────────────────────────────────────┤
│  packages/domain/                       │
│  Repositories — orchestrate clients,    │
│  expose clean APIs to the app           │
│  Depends on: data, core                 │
├─────────────────────────────────────────┤
│  packages/data/                         │
│  Clients — direct Supabase calls,       │
│  table definitions, storage access      │
│  Depends on: core                       │
├─────────────────────────────────────────┤
│  packages/core/                         │
│  Shared models, helpers, localization   │
│  No internal dependencies               │
└─────────────────────────────────────────┘
```

Dependencies flow **downward only** — the app imports domain, domain imports
data, data imports core. No layer reaches upward.

## App Layer (`app/`)

```
app/lib/
├── app/
│   ├── bootstrap/          -- App initialization and dependency injection
│   ├── guards/             -- Route guards (signed in/out, owner, collaborator)
│   ├── routes.dart         -- auto_route configuration
│   └── theme.dart          -- Material theme
├── pages/                  -- Feature pages (one folder per feature)
├── shared/
│   ├── logic/              -- Shared cubits (current user, app settings, etc.)
│   ├── widgets/            -- Reusable UI components
│   ├── views/              -- Reusable view compositions
│   ├── inputs/             -- Form input models (formz)
│   └── dialogs/            -- Shared dialog widgets
├── localization/           -- ARB files and generated l10n
└── main_*.dart             -- Entrypoints per flavor (dev/staging/prod)
```

### State Management

The app uses **flutter_bloc** throughout:

- **Cubits** handle most state (fetching data, form submissions, settings)
- **hydrated_bloc** persists selected state across sessions (e.g. app settings)
- Cubits live in `shared/logic/` (app-wide) or colocated with their page
- **talker** handles logging and error reporting

### Dependency Injection

`CAppDependenciesProvider` wires everything together in `initState`:

1. Creates Supabase table instances (`CChestsTable`, `CGemsTable`, etc.)
2. Builds **clients** from those tables
3. Builds **repositories** from clients
4. Provides repositories via `MultiRepositoryProvider`
5. Provides app-wide cubits via `MultiBlocProvider`

The provider accepts **optional client overrides** — in production it creates
clients from Supabase, in tests mock clients are injected directly. See
[Testing](Testing) for details.

### Routing

- **auto_route** with code generation (`routes.gr.dart`)
- Route guards enforce auth state and role-based access
- Guards: `CSignedInGuard`, `CSignedOutGuard`, `COwnerGuard`,
  `CCollaboratorGuard`, `CNoChestsGuard`, `CChestsGuard`

## Domain Layer (`packages/domain/`)

Each repository wraps one or more clients and exposes a clean API:

| Repository             | Purpose                                    |
| ---------------------- | ------------------------------------------ |
| `cauth_repository`     | Sign in/out, OTP verification, user state  |
| `cchest_repository`    | Chest CRUD, invitations, member management |
| `cgem_repository`      | Gem CRUD, sharing, lines                   |
| `cperson_repository`   | People CRUD, avatar upload/retrieval       |
| `cplatform_repository` | Platform capabilities (image pick, share)  |

Repositories use **bobs_jobs** for typed result handling (success/failure).

## Data Layer (`packages/data/`)

Clients make direct Supabase calls:

| Client             | Wraps                                           |
| ------------------ | ----------------------------------------------- |
| `cauth_client`     | `supabase.auth` — session, OTP, JWT decoding    |
| `cdatabase_client` | Typed table definitions via `typesafe_supabase` |
| `cplatform_client` | `image_picker`, `share_plus`                    |
| `cstorage_client`  | Supabase Storage bucket operations              |

`cdatabase_client` defines typed table schemas that map directly to Supabase
tables, ensuring type safety for all database operations.

## Core (`packages/core/`)

Minimal shared package:

- **Models** — `CUserRole`, `CImagePickSource`
- **Helpers** — Shared utility functions
- **Localization** — App-wide l10n setup (`cInitializeL10n`)

## App Flavors

Three build flavors configured via `--dart-define`:

| Flavor        | Supabase Target | Entry Point             |
| ------------- | --------------- | ----------------------- |
| `development` | Local           | `main_development.dart` |
| `staging`     | Staging project | `main_staging.dart`     |
| `production`  | Production      | `main_production.dart`  |

Secrets (Supabase URL + anon key) are stored in `secrets.*.json` files and
injected at build time.

## Multi-Tenancy

Chests are the tenant boundary. Every data table has a `chest_id` column.
Authorization is enforced entirely via Supabase RLS — the Dart code never checks
permissions. See [Database](Database) for details.

---

**See also:** [Authentication](Authentication) · [Database](Database) ·
[Storage](Storage) · [Localization](Localization)
