-- name: GetAllCategories :many
SELECT id, name, slug FROM categories;

-- name: GetCategoryBySlug :one
SELECT id, name, slug FROM categories
WHERE slug = $1;

-- name: CreateCategory :one
INSERT INTO categories (name, slug)
VALUES ($1, $2)
RETURNING *;