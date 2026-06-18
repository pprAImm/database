-- name: GetSeriesByCategory :many
SELECT id, title, description, cover_url
FROM series
WHERE category_id = $1;

-- name: GetSeriesByID :one
SELECT id, title, description, cover_url, uploaded_by
FROM series
WHERE id = $1;

-- name: UpdateSeries :one
UPDATE series
SET title = $2,
    description = $3,
    category_id = $4,
    cover_url = $5
WHERE id = $1
RETURNING *;

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

-- name: DeleteSeries :one
DELETE FROM series WHERE id = $1
RETURNING *;

-- name: ListPopularSeries :many
SELECT s.id, s.title, s.description, s.cover_url,
       COALESCE(AVG(r.rating), 0)::float8 as average_rating,
       COUNT(r.id)::bigint as vote_count
FROM series s
LEFT JOIN ratings r ON r.series_id = s.id
GROUP BY s.id
ORDER BY
  (COALESCE(AVG(r.rating), 0)::float8 * COUNT(r.id)::float8)
  / (COUNT(r.id)::float8 + 10) DESC
LIMIT $1;

-- name: ListNewSeries :many
SELECT s.id, s.title, s.description, s.cover_url,
       COALESCE(AVG(r.rating), 0)::float8 as average_rating,
       COUNT(r.id)::bigint as vote_count
FROM series s
LEFT JOIN ratings r ON r.series_id = s.id
GROUP BY s.id
ORDER BY s.id DESC
LIMIT $1;
