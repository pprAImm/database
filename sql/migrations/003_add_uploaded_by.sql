ALTER TABLE series ADD COLUMN uploaded_by BIGINT REFERENCES users(id);
