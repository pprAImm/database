INSERT INTO categories (name, slug) VALUES
    ('Аниме', 'anime'),
    ('Документальное', 'docs'),
    ('Комедия', 'comedy');

INSERT INTO series (title, description, category_id, cover_url, year, rating) VALUES
    ('фруктовый хаус', 'школа соцсеть', 1, 'https://picsum.photos/300/400?random=1', 2024, 8.5),
    ('перерождение императрицы', 'я клубника ты клубника как мог родиться банан', 1, 'https://picsum.photos/300/400?random=2', 2024, 7.9),
    ('тун тун тун сахур', 'сикас севен', 2, 'https://picsum.photos/300/400?random=3', 2024, 9.1);

INSERT INTO episodes (series_id, title, tiktok_url, episode_num) VALUES
    (1, 'Пробуждение', 'https://www.tiktok.com/@example/video/1', 1),
    (1, 'Первая битва', 'https://www.tiktok.com/@example/video/2', 2),
    (2, 'Сон первый', 'https://www.tiktok.com/@example/video/3', 1);