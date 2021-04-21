CREATE INDEX tweets_jsonb_idx1 ON tweets_jsonb USING gin((data ->'extended_tweet' -> 'entities' -> 'hashtags'));

CREATE INDEX tweets_jsonb_idx2 ON tweets_jsonb USING gin(to_tsvector('english', COALESCE((data -> 'extended_tweet') ->> 'full_text', data ->> 'text') ));

CREATE INDEX tweets_jsonb_idx3 ON tweets_jsonb USING gin(((data -> 'entities'::text) -> 'hashtags'::text));

