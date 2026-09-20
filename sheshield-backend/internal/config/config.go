package config

import (
	"os"
)

// Config holds everything the app reads from the environment. Nothing here
// has a hardcoded secret default — JWTSecret must be set or the app refuses
// to start (see cmd/api/main.go).
type Config struct {
	Port        string
	DBPath      string
	JWTSecret   string
	JWTTTLHours int
	CORSOrigin  string
}

func Load() Config {
	loadDotEnv(".env")
	return Config{
		Port:        getEnv("PORT", "8080"),
		DBPath:      getEnv("DB_PATH", "./data/sheshield.db"),
		JWTSecret:   os.Getenv("JWT_SECRET"),
		JWTTTLHours: 24 * 7, // 7 days, matches a typical "stay signed in" mobile app
		CORSOrigin:  getEnv("CORS_ORIGIN", "*"),
	}
}

func getEnv(key, fallback string) string {
	if v := os.Getenv(key); v != "" {
		return v
	}
	return fallback
}
