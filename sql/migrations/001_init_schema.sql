-- +goose Up
CREATE TABLE categories (
    id   BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    slug TEXT NOT NULL UNIQUE
);

CREATE TABLE series (
    id          BIGSERIAL PRIMARY KEY,
    title       TEXT NOT NULL,
    description TEXT,
    category_id BIGINT REFERENCES categories(id),
    cover_url   TEXT,
    rating      NUMERIC(3,1)
);

CREATE TABLE episodes (
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