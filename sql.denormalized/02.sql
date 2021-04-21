/*
 * Calculates the hashtags that are commonly used with the hashtag #coronavirus
 */

SELECT '#' || t.tag  as tag, count(*) as count
FROM (
   SELECT distinct data ->> 'id' as id_tweet,
          jsonb_array_elements(COALESCE((tweets_jsonb.data -> 'entities'::text) -> 'hashtags'::text, '[]'::jsonb) || COALESCE(((tweets_jsonb.data -> 'extended_tweet'::text) -> 'entities'::text) -> 'hashtags'::text, '[]'::jsonb)) ->> 'text' as tag
   FROM tweets_jsonb
   WHERE (data -> 'entities' -> 'hashtags') @@ '$[*].text == "coronavirus"' or (data ->'extended_tweet' -> 'entities' -> 'hashtags') @@ '$[*].text == "coronavirus"'
) as t
GROUP BY (t.tag)
ORDER BY count DESC, t.tag
LIMIT 1000;

