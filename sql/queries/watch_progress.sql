-- name: UpsertWatchProgress :one
INSERT INTO watch_progress (user_id, episode_id, progress_seconds, duration_seconds, completed, updated_at)
VALUES ($1, $2, $3, $4, $5, now())
ON CONFLICT (user_id, episode_id)
DO UPDATE SET
    progress_seconds = $3,
    duration_seconds = $4,
    completed = $5,
    updated_at = now()
RETURNING *;

-- name: GetWatchProgress :one
SELECT * FROM watch_progress
WHERE user_id = $1 AND episode_id = $2;

-- name: GetWatchProgressBySeries :many
SELECT wp.* FROM watch_progress wp
JOIN episodes e ON e.id = wp.episode_id
WHERE wp.user_id = $1 AND e.series_id = $2
ORDER BY e.episode_num;
