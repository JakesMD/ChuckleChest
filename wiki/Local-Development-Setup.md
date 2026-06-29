# Local Development Setup

## Prerequisites

| Tool           | Purpose                  | Install                                                                              |
| -------------- | ------------------------ | ------------------------------------------------------------------------------------ |
| Flutter SDK    | Build and run the app    | [flutter.dev/get-started](https://flutter.dev/docs/get-started/install)              |
| Supabase CLI   | Local database and auth  | [supabase.com/docs/guides/cli](https://supabase.com/docs/guides/cli/getting-started) |
| Docker Desktop | Required by Supabase CLI | [docker.com](https://www.docker.com/products/docker-desktop)                         |
| Hobnob         | Task runner              | See [Hobnob](Hobnob)                                                                 |
| Chrome         | Web app testing          | Required for `flutter run -d chrome`                                                 |

## First-Time Setup

### 1. Clone and install dependencies

```sh
git clone https://github.com/<org>/ChuckleChest.git
cd ChuckleChest
hobnob dart:setup
```

This upgrades Flutter, activates global tools (Melos, coverage utilities), and
runs `dart pub get` across the workspace.

### 2. Start local Supabase

Make sure Docker Desktop is running, then:

```sh
hobnob db:start
```

First run pulls Docker images and takes a few minutes. Subsequent starts are
fast. This starts:

| Service  | URL                      | Purpose                   |
| -------- | ------------------------ | ------------------------- |
| API      | `http://localhost:54321` | PostgREST + GoTrue        |
| Studio   | `http://localhost:54323` | Database admin UI         |
| Inbucket | `http://localhost:54324` | Local email inbox for OTP |
| Database | `localhost:54322`        | Postgres                  |

### 3. Secrets

Development secrets are committed to the repo (`secrets.development.json`) since
they only point to the local Supabase instance with the default anon key. No
setup needed.

Staging and production secrets are gitignored. You only need them if deploying.

### 4. Run the app

In VS Code just press F5.

## Local Email (OTP)

Supabase runs Inbucket locally for capturing OTP emails. When you sign up or log
in during development:

1. Enter any email address in the app
2. Open `http://localhost:54324` in your browser
3. Find the OTP email and copy the 6-digit code
4. Enter the code in the app

---

**See also:** [Hobnob](Hobnob) · [Authentication](Authentication) ·
[Database](Database)
