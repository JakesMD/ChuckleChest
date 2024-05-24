alter table "public"."connection_avatar_urls" enable row level security;

alter table "public"."connections" enable row level security;

alter table "public"."gems" enable row level security;

alter table "public"."lines" enable row level security;

create policy "Enable read access for all users"
on "public"."connection_avatar_urls"
as permissive
for select
to public
using (true);


create policy "Enable read access for all users"
on "public"."connections"
as permissive
for select
to public
using (true);


create policy "Enable read access for all users"
on "public"."gems"
as permissive
for select
to public
using (true);


create policy "Enable read access for all users"
on "public"."lines"
as permissive
for select
to public
using (true);



