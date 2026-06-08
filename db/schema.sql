CREATE TABLE IF NOT EXISTS categories (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    slug TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS series (
    id BIGSERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    category_id BIGINT REFERENCES categories(id),
    cover_url TEXT,
    rating NUMERIC(3,1)
);

CREATE TABLE IF NOT EXISTS episodes (
    id BIGSERIAL PRIMARY KEY,
    series_id BIGINT REFERENCES series(id),
    title TEXT,
    tiktok_url TEXT NOT NULL,
    episode_num INTEGER
);

CREATE INDEX IF NOT EXISTS idx_series_category 
    ON series(category_id);

CREATE INDEX IF NOT EXISTS idx_episodes_series 
    ON episodes(series_id);