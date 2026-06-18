-- name: CreateUser :one
INSERT INTO users (username, email, password_hash)
VALUES ($1, $2, $3)
RETURNING id, username, email, created_at;

-- name: GetUserByEmail :one
SELECT id, username, email, password_hash
FROM users WHERE email = $1;

-- name: GetUserByID :one
SELECT id, username, email
FROM users WHERE id = $1;

-- name: UpdateUsername :one
UPDATE users SET username = $2 WHERE id = $1 RETURNING id, username, email;

-- name: UpdatePassword :exec
UPDATE users SET password_hash = $2 WHERE id = $1;

-- name: GetUserByIDWithPassword :one
SELECT id, username, email, password_hash
FROM users WHERE id = $1;