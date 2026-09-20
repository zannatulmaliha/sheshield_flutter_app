# sheshield-backend

Minimal Go REST API replacing Firebase (Auth + Firestore) for the SheShield
app. Standard library `net/http` (Go 1.22+ method/path routing), sqlite
(pure-Go driver, no cgo) for storage, JWT for sessions.

## Run it

```bash
cp .env.example .env      # Windows PowerShell: copy .env.example .env
# open .env and set JWT_SECRET to any long random string (32+ characters)
go mod tidy               # first time only: downloads dependencies, creates go.sum
go run ./cmd/api
```

`.env` is read automatically on startup. Real environment variables take
priority over it, so production can set secrets the normal way instead.

Server listens on `:8080` by default. The DB file is created automatically at
`./data/sheshield.db` on first run -- no manual migration step needed.
Check it's up: open http://localhost:8080/health -- it should say `ok`.

## Endpoints

| Method | Path                  | Auth | Body                                                              |
|--------|-----------------------|------|--------------------------------------------------------------------|
| POST   | `/api/v1/auth/signup` | no   | `{name,email,password,phone,countryCode,gender,userType}` — `userType` is `user`\|`helper`\|`user_helper`; only `gender:"female"` may pick `user`/`user_helper`, everyone else is forced to `helper` (enforced server-side) |
| POST   | `/api/v1/auth/login`  | no   | `{email,password}`                                                 |
| GET    | `/api/v1/auth/me`     | yes  | —                                                                  |
| GET    | `/api/v1/contacts`    | yes  | —                                                                  |
| POST   | `/api/v1/contacts`    | yes  | `{name,relation?,phone,countryCode}` — phone is digits only (6-15), countryCode like `+880`; max 10 per user, no duplicate numbers |
| DELETE | `/api/v1/contacts/{id}` | yes | —                                                                  |
| GET    | `/health`             | no   | —                                                                  |

Auth endpoints return `{"data": {"user": {...}, "token": "<jwt>"}}`.
Authenticated requests send `Authorization: Bearer <jwt>`.
Errors come back as `{"error": "message"}` with a 4xx/5xx status —
the Flutter side can show `error` directly, same as the old
`AuthFailure.message` pattern.

## Why these choices

- **sqlite over Postgres**: zero setup for a student/sprint project —
  swap `internal/db` for a `pgx` connection later without touching
  `auth`/`contact` packages; they only depend on `*sql.DB`.
- **JWT over sessions**: stateless, matches a mobile client that just
  stores a token securely (`flutter_secure_storage` on the Flutter side)
  and attaches it as a header — no server-side session store to run.
- **No framework**: Go 1.22's `net/http.ServeMux` now supports
  `"POST /path/{id}"` patterns directly, so a router library (chi/gin)
  wasn't needed for an API this size.

## Extending

Add a new feature the same way `contact/` is built: `model.go` →
`repository.go` → `service.go` (if there's real business logic beyond
CRUD) → `handler.go` with its own `Register(mux, jwtSecret)`, then one
line in `cmd/api/main.go`.
