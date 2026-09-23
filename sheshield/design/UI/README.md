# SheShield UI reference mockups

These files are exported from the live design canvas — reference only, not runnable app code.

Live, clickable version: https://claude.ai/artifact/N1X3eoh9GZR8KTBjSkXcqC

## What's here

18 screens (`.dc.html`) covering the full app flow, plus `canvas.json` (the canvas layout index — positions/order, not needed for implementation).

**Onboarding / auth**
- `Welcome.dc.html`
- `Onboarding.dc.html` — 3-slide feature tour
- `SignUp.dc.html` — gender (Female/Male) + account type. Female can toggle User and/or Helper on the same account; Male is Helper-only.
- `Login.dc.html` — for returning users only, OTP or PIN/password tabs
- `OTPVerify.dc.html` — step 1 of 3
- `CreatePIN.dc.html` — step 2 of 3
- `NIDVerify.dc.html` — step 3 of 3, enter NID number or scan front/back; unlocks the public "NID Verified" badge
- `ContactSetup.dc.html` — add first emergency contact

Flow: Welcome → Onboarding → Sign Up → Verify Code → Create PIN → Verify NID → Add Contact → Home. Every step past Sign Up is skippable.

**Main app**
- `Main.dc.html` — Home (SOS button + quick actions)
- `SOS-Active.dc.html`
- `CheckIn.dc.html` / `CheckIn-Active.dc.html` — timed check-in
- `HelpersNearby.dc.html` — radius slider
- `LiveLocation.dc.html` — "Track My Route"
- `SafetyMap.dc.html` — safety heatmap
- `AIHelp.dc.html` — AI chat companion
- `Contacts.dc.html`
- `Profile.dc.html`

## Why these won't just open in a browser

Each file is a self-contained Design Component (`<x-dc>` custom markup, `{{ }}` template holes, a `support.js` script tag) meant to run inside the design canvas's own renderer. Opening one directly won't work — treat these as annotated HTML/CSS reference for colors, spacing, layout, and copy, not as source to compile into the Flutter app.

## Palette (Rose Sentinel)

| Token | Hex |
|---|---|
| Background | `#2A1B2D` |
| Surface | `#3D2740` |
| Accent | `#C97B84` |
| Text | `#FBF4F5` |
| Muted text | `#B7969E` |
| SOS / danger | `#FF5A5F` |
| Safe (heatmap) | `#4ADE80` |
| Caution (heatmap) | `#FBBF24` |

Phone size: 390×844. Bottom nav: Home · Map · AI Help · Contacts · Profile.
