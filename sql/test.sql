-- Очистка таблиц (в правильном порядке из-за foreign keys)
TRUNCATE episodes CASCADE;
TRUNCATE series CASCADE;
TRUNCATE categories CASCADE;

-- Вставка категорий
INSERT INTO categories (name, slug) VALUES
    ('Аниме', 'anime'),
    ('Документальное', 'docs'),
    ('Комедия', 'comedy');

-- Вставка сериалов
INSERT INTO series (title, description, category_id, cover_url) VALUES
    ('фруктовый хаус', 'школа соцсеть', (SELECT id FROM categories WHERE slug = 'anime'), 'https://picsum.photos/300/400?random=1'),
    ('перерождение императрицы', 'я клубника ты клубника как мог родиться банан', (SELECT id FROM categories WHERE slug = 'anime'), 'https://picsum.photos/300/400?random=2'),
    ('тун тун тун сахур', 'сикас севен', (SELECT id FROM categories WHERE slug = 'docs'), 'https://picsum.photos/300/400?random=3');

-- Вставка эпизодов
INSERT INTO episodes (series_id, title, tiktok_url, episode_num) VALUES
    ((SELECT id FROM series WHERE title = 'фруктовый хаус'), 'Пробуждение', 'https://www.tiktok.com/@example/video/1', 1),
    ((SELECT id FROM series WHERE title = 'фруктовый хаус'), 'Первая битва', 'https://www.tiktok.com/@example/video/2', 2),
    ((SELECT id FROM series WHERE title = 'перерождение императрицы'), 'Сон первый', 'https://www.tiktok.com/@example/video/3', 1);