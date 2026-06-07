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

	Pool, err := pgxpool.New(context.Background(), connStr)
	if err != nil {
		log.Fatal("Ошибка подключения:", err)
		return Pool, err
	}

	if err = Pool.Ping(context.Background()); err != nil {
		log.Fatal("БД недоступна:", err)
	}

	log.Println("БД подключена")
	return Pool, nil
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
