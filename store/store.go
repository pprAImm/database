package store

import (
	"context"

	"github.com/pprAImm/database/internal/db"
)

type Store interface {
	GetAllCategories(ctx context.Context) ([]db.Category, error)
	GetCategoryBySlug(ctx context.Context, slug string) (db.Category, error)
	GetSeriesByCategory(ctx context.Context, categoryID *int64) ([]db.GetSeriesByCategoryRow, error)
	GetSeriesByID(ctx context.Context, id int64) (db.GetSeriesByIDRow, error)
	GetEpisodesBySeries(ctx context.Context, seriesID *int64) ([]db.Episode, error)
	SearchSeries(ctx context.Context, query *string) ([]db.SearchSeriesRow, error)
}

type pgxStore struct {
	queries *db.Queries
}

func NewStore(queries *db.Queries) Store {
	return &pgxStore{queries: queries}
}

func (s *pgxStore) GetAllCategories(ctx context.Context) ([]db.Category, error) {
	return s.queries.GetAllCategories(ctx)
}

func (s *pgxStore) GetCategoryBySlug(ctx context.Context, slug string) (db.Category, error) {
	return s.queries.GetCategoryBySlug(ctx, slug)
}

func (s *pgxStore) GetSeriesByCategory(ctx context.Context, categoryID *int64) ([]db.GetSeriesByCategoryRow, error) {
	return s.queries.GetSeriesByCategory(ctx, categoryID)
}

func (s *pgxStore) GetSeriesByID(ctx context.Context, id int64) (db.GetSeriesByIDRow, error) {
	return s.queries.GetSeriesByID(ctx, id)
}

func (s *pgxStore) GetEpisodesBySeries(ctx context.Context, seriesID *int64) ([]db.Episode, error) {
	return s.queries.GetEpisodesBySeries(ctx, seriesID)
}

func (s *pgxStore) SearchSeries(ctx context.Context, query *string) ([]db.SearchSeriesRow, error) {
	return s.queries.SearchSeries(ctx, query)
}
