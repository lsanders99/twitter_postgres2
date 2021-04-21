CREATE INDEX tweet_tags_idx1 ON tweet_tags(tag, id_tweets);

CREATE INDEX tweets_idx1 ON tweets(lang);

CREATE INDEX tweets_idx2 ON tweets(id_tweets);

CREATE INDEX tweets_idx_fts ON tweets USING gin(to_tsvector('english', text));
