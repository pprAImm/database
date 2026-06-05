package database

import (
	"context"
	"log"
	"os"

	"database/internal/db"
	"database/store"

	"github.com/jackc/pgx/v5/pgxpool"
)

var Pool *pgxpool.Pool
var Store store.Store

func Init() {
	connStr := os.Getenv("DATABASE_URL")
	if connStr == "" {
		log.Fatal("DATABASE_URL не задан")
	}

	var err error
	Pool, err = pgxpool.New(context.Background(), connStr)
	if err != nil {
		log.Fatal("Ошибка подключения:", err)
	}

	if err = Pool.Ping(context.Background()); err != nil {
		log.Fatal("БД недоступна:", err)
	}

	queries := db.New(Pool)
	Store = store.NewStore(queries)

	log.Println("БД подключена")
}
