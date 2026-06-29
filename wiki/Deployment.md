# Deployment

Deployments are fully automated via GitHub Actions. Merging a PR into `main`
triggers a release — no manual steps needed.

## What Happens on Release

1. App version is bumped automatically
2. Tests and checks run one final time
3. Website and app deploy to GitHub Pages
4. Database migrations push to Supabase
5. Wiki syncs from `wiki/*.md`
6. If the release came from `develop`, the `develop` branch is recreated from
   `main` (clean slate)

---

**See also:** [GitHub Flow](GitHub-Flow) · [Hobnob](Hobnob)
