# Database

ChuckleChest uses Supabase (Postgres) with Row-Level Security (RLS) for all
authorization.

## Commands

| Command           | Description                                |
| ----------------- | ------------------------------------------ |
| `hobnob db:start` | Start local Supabase stack                 |
| `hobnob db:reset` | Reset local DB (applies migrations + seed) |
| `hobnob db:diff`  | Generate migration from schema changes     |
| `hobnob db:test`  | Run pgTAP tests                            |

## Schema Overview

```
chests              -- A family/group container (top-level tenant)
├── gems            -- A funny quote/moment (auto-numbered per chest)
│   ├── lines       -- Individual lines of dialogue in a gem
│   └── gem_share_tokens
├── collections     -- Curated groups of gems
│   └── collection_share_tokens
├── people          -- Family members who say funny things
│   └── person_avatar_urls
├── user_roles      -- Maps auth users to roles within a chest
├── invitations     -- Pending invites to join a chest
└── role_permissions -- Which role can do what (seeded, not user-editable)

users               -- Mirrors auth.users (created by trigger)
```

Every data table has a `chest_id` column. A chest is the multi-tenant boundary —
users only see data in chests they belong to.

## Authorization

Authorization is enforced entirely in Postgres via RLS policies. The app never
checks permissions in Dart code.

### Roles

Three roles exist per chest, defined as `app_role` enum:

| Role           | Purpose                                     |
| -------------- | ------------------------------------------- |
| `owner`        | Full control — manage members, delete chest |
| `collaborator` | Create and edit content, share gems         |
| `viewer`       | Read-only access                            |

### How It Works

1. **JWT claims** — `custom_access_token_hook` runs on every token refresh. It
   reads `user_roles` and embeds a `chests` claim into the JWT:
   ```json
   { "chests": { "<chest-id>": { "name": "Smith Family", "role": "owner" } } }
   ```

2. **`authorize()` function** — Every RLS policy calls
   `authorize(permission, chest_id)`. It extracts the user's role for that chest
   from the JWT claim and checks it against `role_permissions`.

3. **RLS policies** — Each table has policies like:
   ```sql
   CREATE POLICY "Allow authorized select access" ON "public"."gems"
       FOR SELECT TO authenticated
           USING (authorize('gems.select', chest_id));
   ```

4. **`role_permissions` table** — Seeded via `seed.sql`. Maps each role to its
   allowed operations. This table is not editable by users.

### Permission Matrix

| Resource       | Owner | Collaborator | Viewer |
| -------------- | ----- | ------------ | ------ |
| Chests         | CRUD  | CR           | CR     |
| Gems           | CRUD  | CRUD         | R      |
| Lines          | CRUD  | CRUD         | R      |
| People         | CRUD  | CRUD         | R      |
| Person avatars | CRUD  | CRUD         | R      |
| Collections    | CRUD  | CRUD         | R      |
| Share tokens   | CRD   | CRD          | —      |
| Invitations    | CRUD  | —            | —      |
| User roles     | RU    | —            | —      |

Note: owners cannot modify their own `user_roles` row (policy enforces
`user_id <> auth.uid()`).

### User Lifecycle

1. **Sign up** — `on_auth_user_inserted` trigger creates a `users` row
2. **Create chest** — `on_chest_inserted` trigger assigns `owner` role and seeds
   a welcome gem
3. **Invite member** — Owner inserts into `invitations` with email and role
4. **Accept invite** — `accept_invitation()` moves the invitation into
   `user_roles` and deletes it
5. **Share publicly** — Share tokens allow unauthenticated access to individual
   gems or collections via dedicated fetch functions

## Migrations

1. Make schema changes locally
2. Run `hobnob db:diff`
3. Never modify a migration already on `main` — add new
4. Never push to the live database — CI handles on merge

`hobnob db:diff` includes functions you didn't change — investigate before
committing.

## Seed Data

`seed.sql` contains role permissions the app depends on. Do not delete or modify
without understanding the permission system.

---

**See also:** [Authentication](Authentication) · [Storage](Storage) ·
[Architecture](Architecture)
