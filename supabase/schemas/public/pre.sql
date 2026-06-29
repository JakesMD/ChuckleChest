GRANT USAGE ON SCHEMA "public" TO "postgres";

GRANT USAGE ON SCHEMA "public" TO "anon";

GRANT USAGE ON SCHEMA "public" TO "authenticated";

GRANT USAGE ON SCHEMA "public" TO "service_role";

CREATE TYPE "public"."app_permission" AS enum(
    'chests.insert',
    'chests.select',
    'chests.update',
    'chests.delete',
    'collections.insert',
    'collections.select',
    'collections.update',
    'collections.delete',
    'people.insert',
    'people.select',
    'people.update',
    'people.delete',
    'person_avatar_urls.insert',
    'person_avatar_urls.select',
    'person_avatar_urls.update',
    'person_avatar_urls.delete',
    'gems.insert',
    'gems.select',
    'gems.update',
    'gems.delete',
    'lines.insert',
    'lines.select',
    'lines.update',
    'lines.delete',
    'invitations.insert',
    'invitations.select',
    'invitations.update',
    'invitations.delete',
    'user_roles.select',
    'user_roles.update',
    'user_roles.delete',
    'gem_share_tokens.insert',
    'gem_share_tokens.select',
    'gem_share_tokens.update',
    'gem_share_tokens.delete',
    'collection_share_tokens.insert',
    'collection_share_tokens.select',
    'collection_share_tokens.update',
    'collection_share_tokens.delete'
);

CREATE TYPE "public"."app_role" AS enum(
    'owner',
    'collaborator',
    'viewer'
);
