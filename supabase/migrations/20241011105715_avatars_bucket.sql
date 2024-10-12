alter table "storage"."objects" drop column "user_metadata";

alter table "storage"."s3_multipart_uploads" drop column "user_metadata";

create policy "Enable insert for authenticated users only"
on "storage"."objects"
as permissive
for all
to authenticated
using (true)
with check (true);



