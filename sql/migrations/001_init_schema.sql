-- +goose Up
CREATE TABLE IF NOT EXISTS categories (
    id   BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    slug TEXT NOT NULL UNIQUE
) ON CONFLICT (slug) DO NOTHING;

CREATE TABLE IF NOT EXISTS series (
    id          BIGSERIAL PRIMARY KEY,
    title       TEXT NOT NULL,
    description TEXT,
    category_id BIGINT REFERENCES categories(id),
    cover_url   TEXT
);

CREATE TABLE IF NOT EXISTS episodes (
    id          BIGSERIAL PRIMARY KEY,
    series_id   BIGINT REFERENCES series(id),
    title       TEXT,
    tiktok_url  TEXT NOT NULL,
    episode_num INTEGER
);

-- +goose Down
DROP TABLE episodes;
DROP TABLE series;
DROP TABLE categories;