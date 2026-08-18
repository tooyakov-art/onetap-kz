# Security policy

## Reporting a vulnerability

Do not open a public issue containing vulnerability details, credentials,
personal data, or customer information. Use a private GitHub security advisory
for this repository or contact the repository owner through an already agreed
private channel.

Include the affected version, reproduction steps, impact, and a minimal proof
of concept without real customer data. Do not access, modify, or retain data
beyond what is necessary to demonstrate the issue.

## Secret handling

Secrets and signing materials must be stored only in approved encrypted secret
stores or GitHub Actions secrets. They must never be committed to Git. If a
secret is exposed, revoke and rotate it immediately; deleting the file from a
later commit is not sufficient.
