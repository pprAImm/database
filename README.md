# database

Модуль отвечает за хранение данных платформы AI-сериалов.
Содержит схему БД, SQL-запросы и подключение к PostgreSQL.

## Кратко

Модуль предоставляет функции для подключения к PostgreSQL, выполнения запросов и управления транзакциями.
Управляет метаданными: пользователи, контент, подписки.  

## Стек

- PostgreSQL 17 (в Docker)
- [sqlc](https://sqlc.dev/) — генерация Go-кода из SQL
- [goose](https://github.com/pressly/goose) — миграции
- [pgx/v5](https://github.com/jackc/pgx) — драйвер PostgreSQL для Go

## Локальный запуск

### 1. Установить зависимости

```bash
go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest
go install github.com/pressly/goose/v3/cmd/goose@latest
```

### 2. Заполнить .env

```bash
cp .env.example .env
# открыть .env и заполнить значения
```

### 3. Запустить PostgreSQL

```bash
docker compose up -d
```

### 4. Применить миграции

```bash
goose -dir sql/migrations postgres "$DATABASE_URL" up
```

### 5. Загрузить тестовые данные

```bash
docker exec -i database-praim-1 psql -U admin -d series < sql/seed.sql
```

### 6. Сгенерировать Go-код из SQL

```bash
sqlc generate
```

## Как использовать в другом модуле

```go
package main

import (
    "context"
    "log"
    
    "github.com/pprAImm/database"
    "github.com/pprAImm/database/store"
)

func main() {
    // 1. Подключение к БД
    pool, err := database.Init()
    if err != nil {
        log.Fatal(err)
    }
    defer pool.Close()
    
    ctx := context.Background()
    
    // 2. Создаём Queries через публичную фабрику
    queries := database.NewQueries(pool)
    
    // 3. Создаём Store (бизнес-слой)
    storeInstance := store.NewStore(queries)
    
    // 4. Используем методы Store
    categories, err := storeInstance.GetAllCategories(ctx)
    if err != nil {
        log.Fatal(err)
    }
    
    for _, cat := range categories {
        log.Printf("Категория: %s (slug: %s)\n", cat.Name, cat.Slug)
    }
}```

## Переменные окружения

| Переменная | Описание | Пример |
|---|---|---|
| `DB_USER` | Пользователь БД | `admin` |
| `DB_PASSWORD` | Пароль | `1` |
| `DB_NAME` | Имя базы данных | `series` |
| `DATABASE_URL` | Полный URL подключения | `postgres://admin:1@localhost:5432/series` |Sonnet 4.6 LowClaude is 
