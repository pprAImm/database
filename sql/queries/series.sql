-- name: GetSeriesByCategory :many
SELECT id, title, description, cover_url
FROM series
WHERE category_id = $1;

-- name: GetSeriesByID :one
SELECT id, title, description, cover_url
FROM series
WHERE id = $1;

-- name: SearchSeries :many
SELECT id, title, description, cover_url
FROM series
WHERE title ILIKE '%' || $1 || '%';

-- name: CreateSeries :one
INSERT INTO series (title, description, category_id, cover_url)
VALUES ($1, $2, $3, $4)
RETURNING *;

-- name: CreateSeriesWithUploader :one
INSERT INTO series (title, description, category_id, cover_url, uploaded_by)
VALUES ($1, $2, $3, $4, $5)
RETURNING *;

-- name: GetSeriesByUser :many
SELECT id, title, description, cover_url
FROM series
WHERE uploaded_by = $1;
