-- name: CreateSession :one
INSERT INTO sessions (id, user_id, expires_at)
VALUES ($1, $2, $3)
RETURNING *;

-- name: GetSession :one
SELECT id, user_id, expires_at
FROM sessions WHERE id = $1;

-- name: DeleteSession :exec
DELETE FROM sessions WHERE id = $1;