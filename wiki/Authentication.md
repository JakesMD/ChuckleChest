# Authentication

ChuckleChest uses Supabase Auth with passwordless email OTP. No passwords are
stored — users sign in by entering a one-time code sent to their email.

## Auth Flow

### Sign Up

```
User enters email + username
    │
    ▼
signUpWithOTP() ──► Supabase sends OTP email
    │
    ▼
User enters 6-digit pin
    │
    ▼
verifyOTP() ──► Session created
    │
    ▼
Trigger: handle_auth_user_insert()
    └── Inserts row into public.users (mirrors auth.users)
```

### Log In

```
User enters email
    │
    ▼
logInWithOTP(shouldCreateUser: false) ──► Supabase sends OTP email
    │
    ▼
User enters 6-digit pin
    │
    ▼
verifyOTP() ──► Session created
```

### Invitation Acceptance

```
Invited user signs up/logs in
    │
    ▼
App shows pending invitations (fetched by email)
    │
    ▼
User accepts ──► accept_invitation(chest_id)
    │
    ├── Looks up assigned_role from invitations table
    ├── Inserts user_role for that chest
    └── Deletes the invitation
    │
    ▼
Session refresh ──► JWT now includes the new chest
```

## JWT Custom Claims

Every JWT is enriched by `custom_access_token_hook` before issuance. It adds a
`chests` claim containing all chests the user belongs to and their role in each:

```json
{
    "chests": {
        "chest-uuid-1": { "name": "The Smiths", "role": "owner" },
        "chest-uuid-2": { "name": "Grandma's House", "role": "viewer" }
    }
}
```

This claim is the foundation of the entire authorization system — RLS policies
read it to determine access. See [Database](Database) for how `authorize()` uses
it.

The app decodes the JWT client-side to build the `CAuthUser` model with the
user's chest list and roles.

## Session Refresh

After actions that change a user's chest membership (accepting an invitation,
role change), the app calls `refreshSession()` to get an updated JWT with
current claims.

## Database Triggers

| Trigger                     | Event                    | Action                                      |
| --------------------------- | ------------------------ | ------------------------------------------- |
| `handle_auth_user_insert()` | New user in `auth.users` | Mirrors row to `public.users`               |
| `handle_auth_user_update()` | User metadata update     | Syncs `display_name` to `public.users`      |
| `handle_chest_insert()`     | New chest created        | Assigns creator as `owner`, seeds demo data |

## Route Guards

The app uses `auto_route` guards to enforce auth state:

| Guard                | Allows                            |
| -------------------- | --------------------------------- |
| `CSignedInGuard`     | Only authenticated users          |
| `CSignedOutGuard`    | Only unauthenticated users        |
| `COwnerGuard`        | Only chest owners                 |
| `CCollaboratorGuard` | Owners and collaborators          |
| `CChestsGuard`       | Users with at least one chest     |
| `CNoChestsGuard`     | Users with no chests (onboarding) |

Guards redirect automatically — e.g. unauthenticated users land on the sign-in
page, users with no chests see the "Get Started" flow.

## Roles

Three roles exist per chest (`app_role` enum):

| Role           | Access Level                    |
| -------------- | ------------------------------- |
| `owner`        | Full control, can manage chest  |
| `collaborator` | Can add/edit content and people |
| `viewer`       | Read-only access                |

Roles are assigned via the `user_roles` table and embedded in the JWT. Specific
permissions are defined in `role_permissions` (seeded, not user-editable). See
[Database](Database) for details.

## Code Layers

| Layer  | Package             | Responsibility                           |
| ------ | ------------------- | ---------------------------------------- |
| Data   | `cauth_client`      | Supabase GoTrue calls, JWT decoding      |
| Domain | `cauth_repository`  | Clean API for sign up/in/out, OTP, state |
| App    | `CCurrentUserCubit` | Streams auth state to the UI             |

## Pages

| Page           | Purpose                              |
| -------------- | ------------------------------------ |
| `signin/`      | Login and signup tabs                |
| `verify_otp/`  | Enter OTP pin after email is sent    |
| `invited/`     | View and accept pending invitations  |
| `get_started/` | Create first chest (no-chests state) |

---

**See also:** [Database](Database) · [Architecture](Architecture)
