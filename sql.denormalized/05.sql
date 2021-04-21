/*
 * Calculates the hashtags that are commonly used for English tweets containing the word "coronavirus"
 */

SELECT '#' || t.tag as tag,
       count(*) as count
FROM (

SELECT DISTINCT data ->> 'id' as id_tweet,
       jsonb_array_elements(COALESCE((tweets_jsonb.data -> 'entities'::text) -> 'hashtags'::text, '[]'::jsonb) || COALESCE(((tweets_jsonb.data -> 'extended_tweet'::text) -> 'entities'::text) -> 'hashtags'::text, '[]'::jsonb)) ->> 'text' as tag
FROM tweets_jsonb
WHERE to_tsvector('english', COALESCE((data -> 'extended_tweet') ->> 'full_text', data ->> 'text') )@@to_tsquery('english','coronavirus') and data ->> 'lang' = 'en'

) t
GROUP BY t.tag
ORDER BY count DESC, t.tag
LIMIT 1000;

