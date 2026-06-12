package store

import (
	"context"
	"time"

	"github.com/jackc/pgx/v5/pgtype"
	"github.com/pprAImm/database/internal/db"
)

type Store interface {
	GetAllCategories(ctx context.Context) ([]db.Category, error)
	GetCategoryBySlug(ctx context.Context, slug string) (db.Category, error)
	GetSeriesByCategory(ctx context.Context, categoryID *int64) ([]db.GetSeriesByCategoryRow, error)
	GetSeriesByID(ctx context.Context, id int64) (db.GetSeriesByIDRow, error)
	GetEpisodesBySeries(ctx context.Context, seriesID *int64) ([]db.Episode, error)
	SearchSeries(ctx context.Context, query *string) ([]db.SearchSeriesRow, error)
	CreateUser(ctx context.Context, username, email, passwordHash string) (db.CreateUserRow, error)
	GetUserByEmail(ctx context.Context, email string) (db.GetUserByEmailRow, error)
	GetUserByID(ctx context.Context, id int64) (db.GetUserByIDRow, error)
	CreateSession(ctx context.Context, id string, userID *int64, expiresAt time.Time) (db.Session, error)
	GetSession(ctx context.Context, id string) (db.Session, error)
	DeleteSession(ctx context.Context, id string) error
	DeleteSessionByToken(ctx context.Context, tokenID string) error
	UpsertRating(ctx context.Context, userID, seriesID *int64, score *int32) (db.Rating, error)
	GetAverageRating(ctx context.Context, seriesID *int64) (pgtype.Numeric, error)
	AddComment(ctx context.Context, userID, seriesID *int64, body string) (db.Comment, error)
	GetCommentsBySeries(ctx context.Context, seriesID *int64) ([]db.GetCommentsBySeriesRow, error)
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

func (s *pgxStore) CreateUser(ctx context.Context, username, email, passwordHash string) (db.CreateUserRow, error) {
	params := db.CreateUserParams{
		Username:     username,
		Email:        email,
		PasswordHash: passwordHash,
	}
	return s.queries.CreateUser(ctx, params)
}

func (s *pgxStore) GetUserByEmail(ctx context.Context, email string) (db.GetUserByEmailRow, error) {
	return s.queries.GetUserByEmail(ctx, email)
}

func (s *pgxStore) GetUserByID(ctx context.Context, id int64) (db.GetUserByIDRow, error) {
	return s.queries.GetUserByID(ctx, id)
}

func (s *pgxStore) CreateSession(ctx context.Context, id string, userID *int64, expiresAt time.Time) (db.Session, error) {
	params := db.CreateSessionParams{
		ID:        id,
		UserID:    userID,
		ExpiresAt: expiresAt,
	}
	return s.queries.CreateSession(ctx, params)
}

func (s *pgxStore) GetSession(ctx context.Context, id string) (db.Session, error) {
	return s.queries.GetSession(ctx, id)
}

func (s *pgxStore) DeleteSession(ctx context.Context, id string) error {
	return s.queries.DeleteSession(ctx, id)
}

func (s *pgxStore) UpsertRating(ctx context.Context, userID, seriesID *int64, rating *int32) (db.Rating, error) {
	var ratingNumeric pgtype.Numeric
	if rating != nil {
		if err := ratingNumeric.Scan(int64(*rating)); err != nil {
			return db.Rating{}, err
		}
	}

	params := db.UpsertRatingParams{
		UserID:   userID,
		SeriesID: seriesID,
		Rating:   ratingNumeric,
	}
	return s.queries.UpsertRating(ctx, params)
}

func (s *pgxStore) GetAverageRating(ctx context.Context, seriesID *int64) (pgtype.Numeric, error) {
	return s.queries.GetAverageRating(ctx, seriesID)
}

func (s *pgxStore) AddComment(ctx context.Context, userID, seriesID *int64, body string) (db.Comment, error) {
	params := db.AddCommentParams{
		UserID:   userID,
		SeriesID: seriesID,
		Body:     body,
	}
	return s.queries.AddComment(ctx, params)
}

func (s *pgxStore) GetCommentsBySeries(ctx context.Context, seriesID *int64) ([]db.GetCommentsBySeriesRow, error) {
	return s.queries.GetCommentsBySeries(ctx, seriesID)
}

func (s *pgxStore) DeleteSessionByToken(ctx context.Context, tokenID string) error {
	return s.queries.DeleteSession(ctx, tokenID)
}
