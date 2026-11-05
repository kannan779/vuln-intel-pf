# Vulnerability data

Raw NVD and CISA KEV files are intentionally excluded from Git because they are large and are refreshed over time.

Place downloaded files in `Data/Raw/` before importing them through the dashboard or REST endpoints:

- NVD: `nvd.cve.2.0.2024.json.gz`
- CISA KEV: `known_exploited_vulnerabilities.csv`

The application stores imported records in MySQL. Keep the raw files outside the repository when working with a public GitHub repository.
