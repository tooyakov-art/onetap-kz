# OneClick.kz TestFlight

The app is configured with bundle identifier `kz.oneclick.app` and version
`0.1.0`. Publishing is intentionally manual and fail-closed.

Repository secrets required by `.github/workflows/testflight.yml`:

- `ASC_API_KEY_ID`
- `ASC_API_ISSUER_ID`
- `ASC_API_KEY_BASE64`
- `APPLE_TEAM_ID`
- `MATCH_PASSWORD`

`ASC_API_KEY_BASE64` is the base64 representation of the App Store Connect
`.p8` key. The key must belong to the Apple team that owns OneClick.kz and must
have access to Certificates, Identifiers & Profiles. Never commit the `.p8`
file, certificates, profiles, or passwords to this repository.
