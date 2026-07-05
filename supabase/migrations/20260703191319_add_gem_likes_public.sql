alter type "public"."app_permission" add value if not exists 'gem_likes.insert';

alter type "public"."app_permission" add value if not exists 'gem_likes.select';

alter type "public"."app_permission" add value if not exists 'gem_likes.delete';
