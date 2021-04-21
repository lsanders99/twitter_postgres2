/*
 * Calculates the languages that commonly use the hashtag #coronavirus
 */

SELECT t.lang, count(*) as count
FROM (
   SELECT distinct data ->> 'id' as id_tweet,
          data ->> 'lang' as lang
   FROM tweets_jsonb
   WHERE (data -> 'entities' -> 'hashtags') @@ '$[*].text == "coronavirus"' or (data ->'extended_tweet' -> 'entities' -> 'hashtags') @@ '$[*].text == "coronavirus"'
) as t
GROUP BY (t.lang)
ORDER BY count DESC, t.lang;

