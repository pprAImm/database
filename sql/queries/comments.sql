-- name: AddComment :one
INSERT INTO comments (user_id, series_id, body)
VALUES ($1, $2, $3)
RETURNING *;

-- name: GetCommentsBySeries :many
SELECT c.id, u.username, c.body, c.created_at
FROM comments c
JOIN users u ON u.id = c.user_id
WHERE c.series_id = $1
ORDER BY c.created_at DESC;