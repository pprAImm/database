-- name: UpsertRating :one
INSERT INTO ratings (user_id, series_id, score)
VALUES ($1, $2, $3)
ON CONFLICT (user_id, series_id)
DO UPDATE SET score = $3
RETURNING *;

-- name: GetAverageRating :one
SELECT ROUND(AVG(score)::numeric, 1) as average
FROM ratings WHERE series_id = $1;