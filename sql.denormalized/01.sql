/*
 * Count the number of tweets that use #coronavirus
 */

SELECT count(distinct data ->> 'id')
FROM tweets_jsonb
WHERE (data -> 'entities' -> 'hashtags') @@ '$[*].text == "coronavirus"'
      or (data ->'extended_tweet' -> 'entities' -> 'hashtags') @@ '$[*].text == "coronavirus"';


