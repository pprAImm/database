-- name: UpsertRating :one
INSERT INTO ratings (user_id, series_id, rating)
VALUES ($1, $2, $3)
ON CONFLICT (user_id, series_id)
DO UPDATE SET rating = $3
RETURNING id, user_id, series_id, rating, created_at;

-- name: GetAverageRating :one
SELECT COALESCE(ROUND(AVG(rating)::numeric, 1), 0)::float as average
FROM ratings WHERE series_id = $1;