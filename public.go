package database

import (
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/pprAImm/database/internal/db"
)

// NewQueries создаёт публичный доступ к db.Queries
func NewQueries(pool *pgxpool.Pool) *db.Queries {
	return db.New(pool)
}
