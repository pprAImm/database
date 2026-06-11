-- name: UpsertRating :one
INSERT INTO ratings (user_id, series_id, rating)
VALUES ($1, $2, $3)
ON CONFLICT (user_id, series_id)
DO UPDATE SET rating = $3
RETURNING *;

-- name: GetAverageRating :one
SELECT ROUND(AVG(rating)::numeric, 1) as average
FROM ratings WHERE series_id = $1;