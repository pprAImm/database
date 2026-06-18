-- name: GetEpisodesBySeries :many
SELECT id, series_id, title, tiktok_url, episode_num
FROM episodes
WHERE series_id = $1
ORDER BY episode_num;

-- name: CreateEpisode :one
INSERT INTO episodes (series_id, title, tiktok_url, episode_num)
VALUES ($1, $2, $3, $4)
RETURNING *;

-- name: GetEpisodeByID :one
SELECT id, series_id, title, tiktok_url, episode_num
FROM episodes
WHERE id = $1;

-- name: DeleteEpisode :one
DELETE FROM episodes WHERE id = $1
RETURNING id, series_id, title, tiktok_url, episode_num;