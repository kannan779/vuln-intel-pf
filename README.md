# Vulnerability Intelligence and Exploitation Risk Prioritization Platform

An explainable cybersecurity platform that combines NVD vulnerability records, CISA Known Exploited Vulnerabilities evidence, CVSS severity, statistical uncertainty and time-aware urgency to prioritize remediation.

## Current capabilities

- Import NVD 2024 CVE data
- Import CISA KEV data
- Search vulnerabilities by CVE ID
- Calculate CVSS bands and exploitation probability
- Calculate historical exploitation probability by severity
- Report a 95% confidence interval
- Detect CVSS and KEV mismatches
- Calculate time-aware urgency
- Rank vulnerabilities using P1-P4 remediation priorities
- Export a CSV report
- Serve a dashboard through Spring Boot

## Repository layout

```text
backend/vulnerability-predictor/   Spring Boot application
Data/Raw/                          Local data files, excluded from Git
documentation/                     Project documents and diagrams
docker-compose.yml                 Local database and backend deployment
.github/workflows/build.yml        Automated build and test
```

## Run with Docker

1. Copy `.env.example` to `.env` and set `DB_PASSWORD`.
2. Start the application:

   ```powershell
   docker compose up --build
   ```

3. Open `http://localhost:8080/index.html`.

The MySQL data is stored in the Docker volume `vulnerability_db_data`, so the database survives container restarts.

## Run the backend directly

Set the database variables in the terminal before starting Spring Boot:

```powershell
$env:DB_URL="jdbc:mysql://localhost:3306/vulnerability_db?createDatabaseIfNotExist=true&serverTimezone=UTC"
$env:DB_USERNAME="root"
$env:DB_PASSWORD="your-local-mysql-password"
.\mvnw.cmd spring-boot:run
```

## Data import

Download the NVD and CISA KEV files into `Data/Raw/`, then import them through the dashboard or REST endpoints. Raw feeds are intentionally not committed to Git because they are large and change over time.

## Security notes

- Never commit `.env`, database passwords or API keys.
- Use environment variables for deployment credentials.
- Use trusted source URLs and display provenance for enriched vulnerability information.
- Keep the application focused on defensive analysis, prioritization and remediation guidance.

## Roadmap

- Universal keyword, CVE, CWE, vendor and product search
- CWE-to-CVE mapping
- Scheduled source synchronization
- Analyst accounts and role-based access
- Source-cited AI explanations using a retrieval-based local model
- Deployment with GitHub-backed CI and a cloud database
