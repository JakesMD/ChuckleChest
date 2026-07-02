# Storage

ChuckleChest uses Supabase Storage for file uploads. Currently the only use case
is person avatars — profile photos that change over time (one per person per
year).

## Buckets

| Bucket    | Content       | Access  |
| --------- | ------------- | ------- |
| `avatars` | Person photos | Private |

The `avatars` bucket is private. Files are accessed via signed URLs, not public
URLs.

## File Layout

```
avatars/
└── chests/
    └── {chest_id}/
        ├── {person_id}-{year}.jpg
        ├── {person_id}-{year}.jpg
        └── ...
```

The path encodes the chest ID (for RLS), the person ID, and the year. Uploading
to an existing path overwrites the previous avatar (upsert).

## Upload Flow

```
User picks image
    │
    ▼
cperson_repository.updateAvatar()
    │
    ├── 1. Resize to 400×400 (image package, background thread)
    ├── 2. Upload JPG to Supabase Storage (cstorage_client)
    ├── 3. Create signed URL (100-year expiry)
    └── 4. Upsert row in public.avatars table with signed URL
```

The app never reads directly from the bucket after upload. Instead, the signed
URL is stored in the `avatars` table and served from there.

## Database Table

The `public.avatars` table tracks which signed URL belongs to which person/year:

| Column      | Type     | Description                |
| ----------- | -------- | -------------------------- |
| `person_id` | `bigint` | FK → `people.id`           |
| `year`      | `int2`   | Year the photo represents  |
| `image_url` | `text`   | Signed URL from Storage    |
| `chest_id`  | `uuid`   | FK → `chests.id` (for RLS) |

Primary key: `(person_id, year)`. Cascades on delete from `people` or `chests`.

## Authorization

Two layers of RLS protect avatars:

### Storage Bucket Policies (`storage.objects`)

Policies read the user's `chests` claim from the JWT to determine access. The
chest ID is extracted from the file path via `storage.foldername(name)`.

| Operation       | Allowed Roles           |
| --------------- | ----------------------- |
| SELECT          | Any chest member        |
| INSERT / UPDATE | `owner`, `collaborator` |
| DELETE          | `owner`, `collaborator` |

### Database Table Policies (`public.avatars`)

Standard `authorize()` RLS using the `role_permissions` system:

| Operation | Permission                  |
| --------- | --------------------------- |
| SELECT    | `person_avatar_urls.select` |
| INSERT    | `person_avatar_urls.insert` |
| UPDATE    | `person_avatar_urls.update` |
| DELETE    | `person_avatar_urls.delete` |

See [Database](Database) for how `authorize()` and role permissions work.

## Code Layers

| Layer  | Package              | Responsibility                        |
| ------ | -------------------- | ------------------------------------- |
| Data   | `cstorage_client`    | Upload binary, create signed URL      |
| Data   | `cdatabase_client`   | `CAvatarsTable` — typed table schema  |
| Domain | `cperson_repository` | Orchestrates resize → upload → upsert |

## Schema Location

```
supabase/schemas/
├── public/tables/avatars/
│   ├── table.sql           -- Table definition
│   ├── policies.sql        -- RLS policies (authorize())
│   ├── constraints.sql     -- Foreign keys
│   └── permissions.sql     -- Role grants
└── storage/buckets/avatars/
    └── policies.sql        -- Storage bucket RLS policies
```

---

**See also:** [Database](Database) · [Authentication](Authentication) ·
[Architecture](Architecture)
