create table "public"."gem_likes" (
    "chest_id" uuid not null,
    "gem_id" uuid not null,
    "user_id" uuid not null default auth.uid(),
    "liked_at" timestamp with time zone not null default now()
);


alter table "public"."gem_likes" enable row level security;

CREATE UNIQUE INDEX gem_likes_pkey ON public.gem_likes USING btree (gem_id, user_id);

alter table "public"."gem_likes" add constraint "gem_likes_pkey" PRIMARY KEY using index "gem_likes_pkey";

alter table "public"."gem_likes" add constraint "gem_likes_gem_id_fkey" FOREIGN KEY (gem_id) REFERENCES public.gems(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."gem_likes" validate constraint "gem_likes_gem_id_fkey";

grant delete on table "public"."gem_likes" to "anon";

grant insert on table "public"."gem_likes" to "anon";

grant references on table "public"."gem_likes" to "anon";

grant select on table "public"."gem_likes" to "anon";

grant trigger on table "public"."gem_likes" to "anon";

grant truncate on table "public"."gem_likes" to "anon";

grant update on table "public"."gem_likes" to "anon";

grant delete on table "public"."gem_likes" to "authenticated";

grant insert on table "public"."gem_likes" to "authenticated";

grant references on table "public"."gem_likes" to "authenticated";

grant select on table "public"."gem_likes" to "authenticated";

grant trigger on table "public"."gem_likes" to "authenticated";

grant truncate on table "public"."gem_likes" to "authenticated";

grant update on table "public"."gem_likes" to "authenticated";

grant delete on table "public"."gem_likes" to "service_role";

grant insert on table "public"."gem_likes" to "service_role";

grant references on table "public"."gem_likes" to "service_role";

grant select on table "public"."gem_likes" to "service_role";

grant trigger on table "public"."gem_likes" to "service_role";

grant truncate on table "public"."gem_likes" to "service_role";

grant update on table "public"."gem_likes" to "service_role";


  create policy "Allow authorized delete access"
  on "public"."gem_likes"
  as permissive
  for delete
  to authenticated
using ((public.authorize('gem_likes.delete'::public.app_permission, chest_id) AND (user_id = auth.uid())));



  create policy "Allow authorized insert access"
  on "public"."gem_likes"
  as permissive
  for insert
  to authenticated
with check ((public.authorize('gem_likes.insert'::public.app_permission, chest_id) AND (user_id = auth.uid())));



  create policy "Allow authorized select access"
  on "public"."gem_likes"
  as permissive
  for select
  to authenticated
using ((public.authorize('gem_likes.select'::public.app_permission, chest_id) AND (user_id = auth.uid())));

alter table "public"."gem_likes" add constraint "gem_likes_chest_id_fkey" FOREIGN KEY (chest_id) REFERENCES public.chests(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."gem_likes" validate constraint "gem_likes_chest_id_fkey";