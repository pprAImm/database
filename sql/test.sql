-- First, delete all data to ensure clean state
DELETE FROM comments;
DELETE FROM ratings;
DELETE FROM sessions;
DELETE FROM episodes;
DELETE FROM series;
DELETE FROM users;
DELETE FROM categories;

-- Truncate sequences to reset IDs
TRUNCATE categories, series, episodes, users, sessions, ratings, comments RESTART IDENTITY CASCADE;

INSERT INTO categories (name, slug) VALUES
    ('Фрукты', 'fruits'),
    ('Азиатское', 'asian'),
    ('Аниме', 'anime'),
    ('Романтика', 'romance'),
    ('Комедия', 'comedy'),
    ('Ужасы', 'horror'),
    ('Драма', 'drama');

INSERT INTO series (title, description, category_id, cover_url) VALUES
    ('фруктовый хаус', 'школа соцсеть', 1, 'https://picsum.photos/300/400?random=1'),
    ('перерождение императрицы', 'я клубника ты клубника как мог родиться банан', 3, 'https://picsum.photos/300/400?random=2'),
    ('тун тун тун сахур', 'сикас севен', 2, 'https://picsum.photos/300/400?random=3');

INSERT INTO episodes (series_id, title, tiktok_url, episode_num) VALUES
    (1, 'Пробуждение', 'https://www.tiktok.com/@example/video/1', 1),
    (1, 'Первая битва', 'https://www.tiktok.com/@example/video/2', 2),
    (2, 'Сон первый', 'https://www.tiktok.com/@example/video/3', 1);

-- Test user (password: password)
INSERT INTO users (username, email, password_hash)
VALUES ('tester', 'tester@example.com', '$2a$10$CwTycUXWue0Thq9StjUM0uJ8pYy0qZqvY7p6aU0y1JiZ0h1/1q1e');
