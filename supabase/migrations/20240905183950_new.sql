drop policy "Allow authorized delete access" on "public"."person_avatar_urls";

drop policy "Allow authorized insert access" on "public"."person_avatar_urls";

drop policy "Allow authorized select access" on "public"."person_avatar_urls";

drop policy "Allow authorized update access" on "public"."person_avatar_urls";

revoke delete on table "public"."person_avatar_urls" from "anon";

revoke insert on table "public"."person_avatar_urls" from "anon";

revoke references on table "public"."person_avatar_urls" from "anon";

revoke select on table "public"."person_avatar_urls" from "anon";

revoke trigger on table "public"."person_avatar_urls" from "anon";

revoke truncate on table "public"."person_avatar_urls" from "anon";

revoke update on table "public"."person_avatar_urls" from "anon";

revoke delete on table "public"."person_avatar_urls" from "authenticated";

revoke insert on table "public"."person_avatar_urls" from "authenticated";

revoke references on table "public"."person_avatar_urls" from "authenticated";

revoke select on table "public"."person_avatar_urls" from "authenticated";

revoke trigger on table "public"."person_avatar_urls" from "authenticated";

revoke truncate on table "public"."person_avatar_urls" from "authenticated";

revoke update on table "public"."person_avatar_urls" from "authenticated";

revoke delete on table "public"."person_avatar_urls" from "service_role";

revoke insert on table "public"."person_avatar_urls" from "service_role";

revoke references on table "public"."person_avatar_urls" from "service_role";

revoke select on table "public"."person_avatar_urls" from "service_role";

revoke trigger on table "public"."person_avatar_urls" from "service_role";

revoke truncate on table "public"."person_avatar_urls" from "service_role";

revoke update on table "public"."person_avatar_urls" from "service_role";

alter table "public"."person_avatar_urls" drop constraint "connection_avatar_urls_connection_id_fkey";

alter table "public"."person_avatar_urls" drop constraint "person_avatar_urls_chest_id_fkey";

alter table "public"."person_avatar_urls" drop constraint "person_avatar_urls_pkey";

drop index if exists "public"."person_avatar_urls_pkey";

drop table "public"."person_avatar_urls";

create table "public"."avatars" (
    "person_id" bigint not null,
    "year" smallint not null,
    "image_url" text not null,
    "chest_id" uuid not null
);


alter table "public"."avatars" enable row level security;

CREATE UNIQUE INDEX avatars_pkey ON public.avatars USING btree (person_id, year);

alter table "public"."avatars" add constraint "avatars_pkey" PRIMARY KEY using index "avatars_pkey";

alter table "public"."avatars" add constraint "connection_avatar_urls_connection_id_fkey" FOREIGN KEY (person_id) REFERENCES people(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."avatars" validate constraint "connection_avatar_urls_connection_id_fkey";

alter table "public"."avatars" add constraint "person_avatar_urls_chest_id_fkey" FOREIGN KEY (chest_id) REFERENCES chests(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."avatars" validate constraint "person_avatar_urls_chest_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.fetch_distinct_gem_years(chest_id_param uuid)
 RETURNS SETOF smallint
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT DISTINCT EXTRACT(YEAR FROM occurred_at)::int2
    FROM public.gems
    WHERE chest_id = chest_id_param;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.custom_access_token_hook(event jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 STABLE
AS $function$DECLARE
  claims jsonb;
  chest_roles RECORD;
  chests_json jsonb := '{}'::jsonb;
BEGIN
  claims := event -> 'claims';
  FOR chest_roles IN
  SELECT
    ur.role,
    c.id,
    c.name
  FROM
    public.user_roles ur
    JOIN public.chests c ON ur.chest_id = c.id
  WHERE
    ur.user_id =(event ->> 'user_id')::uuid LOOP
      chests_json := jsonb_set(chests_json,('{' || chest_roles.id::text || '}')::text[], jsonb_build_object('name', chest_roles.name, 'role', chest_roles.role));
    END LOOP;
  claims := jsonb_set(claims, '{chests}', chests_json);
  event := jsonb_set(event, '{claims}', claims);
  RETURN event;
END;$function$
;

grant delete on table "public"."avatars" to "anon";

grant insert on table "public"."avatars" to "anon";

grant references on table "public"."avatars" to "anon";

grant select on table "public"."avatars" to "anon";

grant trigger on table "public"."avatars" to "anon";

grant truncate on table "public"."avatars" to "anon";

grant update on table "public"."avatars" to "anon";

grant delete on table "public"."avatars" to "authenticated";

grant insert on table "public"."avatars" to "authenticated";

grant references on table "public"."avatars" to "authenticated";

grant select on table "public"."avatars" to "authenticated";

grant trigger on table "public"."avatars" to "authenticated";

grant truncate on table "public"."avatars" to "authenticated";

grant update on table "public"."avatars" to "authenticated";

grant delete on table "public"."avatars" to "service_role";

grant insert on table "public"."avatars" to "service_role";

grant references on table "public"."avatars" to "service_role";

grant select on table "public"."avatars" to "service_role";

grant trigger on table "public"."avatars" to "service_role";

grant truncate on table "public"."avatars" to "service_role";

grant update on table "public"."avatars" to "service_role";

create policy "Allow authorized delete access"
on "public"."avatars"
as permissive
for delete
to authenticated
using (authorize('person_avatar_urls.delete'::app_permission, chest_id));


create policy "Allow authorized insert access"
on "public"."avatars"
as permissive
for insert
to authenticated
with check (authorize('person_avatar_urls.insert'::app_permission, chest_id));


create policy "Allow authorized select access"
on "public"."avatars"
as permissive
for select
to authenticated
using (authorize('person_avatar_urls.select'::app_permission, chest_id));


create policy "Allow authorized update access"
on "public"."avatars"
as permissive
for update
to authenticated
using (authorize('person_avatar_urls.update'::app_permission, chest_id));



