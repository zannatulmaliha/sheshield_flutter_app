package contact

import (
	"crypto/rand"
	"database/sql"
	"encoding/hex"
	"errors"
	"time"
)

var ErrNotFound = errors.New("contact not found")

type Repository struct {
	db *sql.DB
}

func NewRepository(db *sql.DB) *Repository {
	return &Repository{db: db}
}

func newID() string {
	b := make([]byte, 12)
	_, _ = rand.Read(b)
	return hex.EncodeToString(b)
}

func (r *Repository) ListForUser(userUID string) ([]Contact, error) {
	rows, err := r.db.Query(`
		SELECT id, name, phone, country_code, created_at
		FROM trusted_contacts WHERE user_uid = ? ORDER BY created_at ASC`, userUID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	contacts := []Contact{}
	for rows.Next() {
		var c Contact
		var createdAt string
		if err := rows.Scan(&c.ID, &c.Name, &c.Phone, &c.CountryCode, &createdAt); err != nil {
			return nil, err
		}
		c.CreatedAt, _ = time.Parse(time.RFC3339, createdAt)
		contacts = append(contacts, c)
	}
	return contacts, rows.Err()
}

func (r *Repository) Create(userUID string, req CreateContactRequest) (Contact, error) {
	c := Contact{
		ID:          newID(),
		Name:        req.Name,
		Phone:       req.Phone,
		CountryCode: req.CountryCode,
		CreatedAt:   time.Now().UTC(),
	}
	_, err := r.db.Exec(`
		INSERT INTO trusted_contacts (id, user_uid, name, phone, country_code, created_at)
		VALUES (?, ?, ?, ?, ?, ?)`,
		c.ID, userUID, c.Name, c.Phone, c.CountryCode, c.CreatedAt.Format(time.RFC3339),
	)
	return c, err
}

func (r *Repository) Delete(userUID, id string) error {
	res, err := r.db.Exec(
		`DELETE FROM trusted_contacts WHERE id = ? AND user_uid = ?`, id, userUID,
	)
	if err != nil {
		return err
	}
	n, err := res.RowsAffected()
	if err != nil {
		return err
	}
	if n == 0 {
		return ErrNotFound
	}
	return nil
}
