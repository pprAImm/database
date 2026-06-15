package database

import (
	"context"
	"log"
	"os"

	//"database/internal/db"
	//"database/store"

	"github.com/jackc/pgx/v5/pgxpool"
)

func Init() (*pgxpool.Pool, error) {
	connStr := os.Getenv("DATABASE_URL")
	if connStr == "" {
		log.Fatal("DATABASE_URL не задан")
	}

	// Парсим конфиг для настройки пула соединений
	config, err := pgxpool.ParseConfig(connStr)
	if err != nil {
		log.Fatal("Ошибка парсинга конфига:", err)
		return nil, err
	}

	// Ограничиваем количество соединений
	//На серверной БД лимит 10 активных подключений на команду
	//Если каждый сервис откроет по 10 подключений, лимит будет превышен
	//Ограничиваем до 5, оставляя запас для других сервисов (gateway, streaming-service)

	config.MaxConns = 5

	// Создаём пул с настройками
	pool, err := pgxpool.NewWithConfig(context.Background(), config)
	if err != nil {
		log.Fatal("Ошибка подключения:", err)
		return nil, err
	}

	// Проверяем подключение
	if err = pool.Ping(context.Background()); err != nil {
		log.Fatal("БД недоступна:", err)
	}

	log.Println("БД подключена (пул соединений ограничен 5)")
	return pool, nil
}

func main() {
	pool, err := Init()
	if err != nil {
		log.Fatal(err)
	}
	defer pool.Close()

	//queries := db.New(pool)
	//передача queries в хэндлеры
}
