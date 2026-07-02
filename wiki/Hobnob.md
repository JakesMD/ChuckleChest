# Hobnob

ChuckleChest uses [Hobnob](https://github.com/JakesMD/hobnob) as its task
runner. It replaces Makefiles and shell scripts with a single `hobnob.yml`
config.

## Usage

Run `hobnob` in the project root to see all available tasks and what they do.
Run a task with:

```sh
hobnob <task>
```

Tasks are organized into modules (`dart:*`, `db:*`) and top-level commands
(`ci`, `website:update`, `version:bump`).

## Installation

```sh
curl -fsSL https://github.com/jakesmd/hobnob/releases/latest/download/install.sh | bash
```

## Config

Task definitions live in:

- `hobnob.yml` — top-level tasks and module imports
- `hobnobs/dart.yml` — Dart/Flutter tasks (setup, analyze, test, build)
- `hobnobs/database.yml` — Supabase database tasks (start, reset, diff, test)

---

**See also:** [Local Development Setup](Local-Development-Setup) ·
[Database](Database)
