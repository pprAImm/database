FROM postgres:15-alpine

# Копируем миграции
COPY sql/migrations/*.sql /docker-entrypoint-initdb.d/

# Устанавливаем переменные окружения
ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=1
ENV POSTGRES_DB=series