/*
 * Calculates the hashtags that are commonly used for English tweets containing the word "coronavirus"
 */

SELECT count(*)
FROM tweets_jsonb
WHERE to_tsvector('english', COALESCE((data -> 'extended_tweet') ->> 'full_text', data ->> 'text') )@@to_tsquery('english','coronavirus') and data ->> 'lang' = 'en';

