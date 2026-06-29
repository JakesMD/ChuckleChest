# ChuckleChest Wiki

ChuckleChest is a Flutter web app for families to collect and share funny quotes.
Backed by Supabase with passwordless auth, multi-tenant chests, and role-based
access.

## Getting Started

- **[Local Development Setup](Local-Development-Setup)** — Prerequisites,
  first-time setup, running the app locally
- **[Hobnob](Hobnob)** — Task runner for builds, database operations, and CI

## Architecture

- **[Architecture](Architecture)** — Project structure, layered design, state
  management, dependency injection, routing
- **[Testing](Testing)** — E2E test setup, mock clients, writing app-level tests
- **[Localization](Localization)** — Multi-language support, ARB files, adding
  translations

## Backend

- **[Database](Database)** — Schema, RLS authorization, migrations, seed data
- **[Authentication](Authentication)** — Passwordless OTP flow, JWT claims,
  roles, route guards
- **[Storage](Storage)** — Supabase Storage for avatars, upload flow, bucket
  policies

## Workflow

- **[GitHub Flow](GitHub-Flow)** — Branching strategy, PR rules, CI automation
- **[Deployment](Deployment)** — Automated releases on merge to `main`
