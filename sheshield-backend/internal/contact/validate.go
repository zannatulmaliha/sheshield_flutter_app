package contact

import (
	"regexp"
	"strings"
	"unicode/utf8"
)

// MaxContacts caps how many trusted contacts one account can have. An SOS
// alert will notify all of them, so an unbounded list is both a spam vector
// and (once SMS is wired up) an unbounded bill.
const MaxContacts = 10

var (
	countryCodeRe = regexp.MustCompile(`^\+[0-9]{1,4}$`)
	phoneRe       = regexp.MustCompile(`^[0-9]{6,15}$`)
	separators    = strings.NewReplacer(" ", "", "-", "", "(", "", ")", "")
)

// normalize cleans and validates a create request. It returns the cleaned
// request, or a user-facing message (shown as-is in the app) if it's invalid.
func normalize(req CreateContactRequest) (CreateContactRequest, string) {
	req.Name = strings.TrimSpace(req.Name)
	req.Relation = strings.TrimSpace(req.Relation)
	req.CountryCode = strings.TrimSpace(req.CountryCode)
	req.Phone = separators.Replace(strings.TrimSpace(req.Phone))

	switch {
	case req.Name == "":
		return req, "Name is required."
	case utf8.RuneCountInString(req.Name) > 60:
		return req, "Name is too long (60 characters max)."
	case utf8.RuneCountInString(req.Relation) > 30:
		return req, "Relation is too long (30 characters max)."
	case !countryCodeRe.MatchString(req.CountryCode):
		return req, "Country code must look like +880."
	case !phoneRe.MatchString(req.Phone):
		return req, "Enter a valid phone number (6-15 digits)."
	}

	// People type local numbers with a leading 0 (01712345678). In
	// international format the 0 is dropped (+880 1712345678), which is the
	// form an SMS gateway will need later, so store it that way.
	req.Phone = strings.TrimPrefix(req.Phone, "0")
	return req, ""
}
