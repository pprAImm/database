-- Добавляем индексы для внешних ключей, чтобы ускорить JOIN'ы и WHERE-условия

CREATE INDEX IF NOT EXISTS idx_series_category_id ON series(category_id);
CREATE INDEX IF NOT EXISTS idx_series_uploaded_by ON series(uploaded_by);
CREATE INDEX IF NOT EXISTS idx_episodes_series_id ON episodes(series_id);
CREATE INDEX IF NOT EXISTS idx_ratings_series_id ON ratings(series_id);
CREATE INDEX IF NOT EXISTS idx_ratings_user_id ON ratings(user_id);
CREATE INDEX IF NOT EXISTS idx_comments_series_id ON comments(series_id);
CREATE INDEX IF NOT EXISTS idx_sessions_user_id ON sessions(user_id);
-- Триграмный индекс на title опционален — требует CREATE EXTENSION IF NOT EXISTS pg_trgm;
