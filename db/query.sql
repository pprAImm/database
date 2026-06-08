-- name: GetAllCategories :many
SELECT id, name, slug FROM categories;

-- name: GetCategoryBySlug :one
SELECT id, name, slug FROM categories
WHERE slug = $1;

-- name: GetSeriesByCategory :many
SELECT id, title, description, cover_url, rating
FROM series
WHERE category_id = $1;

-- name: GetSeriesByID :one
SELECT id, title, description, cover_url, rating
FROM series
WHERE id = $1;

-- name: GetEpisodesBySeries :many
SELECT id, series_id, title, tiktok_url, episode_num
FROM episodes
WHERE series_id = $1
ORDER BY episode_num;

-- name: SearchSeries :many
SELECT id, title, description, cover_url, rating
FROM series
WHERE title ILIKE '%' || $1 || '%';

-- name: CreateCategory :one
INSERT INTO categories (name, slug)
VALUES ($1, $2)
RETURNING *;

-- name: CreateSeries :one
INSERT INTO series (title, description, category_id, cover_url, rating)
VALUES ($1, $2, $3, $4, $5)
RETURNING *;

-- name: CreateEpisode :one
INSERT INTO episodes (series_id, title, tiktok_url, episode_num)
VALUES ($1, $2, $3, $4)
RETURNING *;