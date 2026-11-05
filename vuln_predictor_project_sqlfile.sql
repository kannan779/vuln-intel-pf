CREATE DATABASE vulnerability_db;
use vulnerability_db;

SELECT
    COUNT(*) AS total_records,
    SUM(known_exploited = 1) AS kev_records,
    SUM(known_exploited = 0) AS nvd_only_records,
    COUNT(cvss_score) AS records_with_cvss
FROM vulnerabilities;
DELETE FROM vulnerabilities
WHERE cve_id = 'CVE-TEST-001';

SELECT
    severity,
    COUNT(*) AS total_records,
    SUM(known_exploited = 1) AS kev_records,
    ROUND(
        100.0 * SUM(known_exploited = 1) / COUNT(*),
        2
    ) AS exploitation_probability_percent
FROM vulnerabilities
WHERE cvss_score IS NOT NULL
GROUP BY severity
ORDER BY exploitation_probability_percent DESC;

SELECT
    CASE
        WHEN cvss_score >= 9.0 THEN 'CRITICAL_SCORE'
        WHEN cvss_score >= 7.0 THEN 'HIGH_SCORE'
        WHEN cvss_score >= 4.0 THEN 'MEDIUM_SCORE'
        ELSE 'LOW_SCORE'
    END AS cvss_band,
    COUNT(*) AS total_records,
    SUM(known_exploited = 1) AS kev_records,
    ROUND(
        100.0 * SUM(known_exploited = 1) / COUNT(*),
        2
    ) AS exploitation_probability_percent
FROM vulnerabilities
WHERE cvss_score IS NOT NULL
GROUP BY cvss_band
ORDER BY exploitation_probability_percent DESC;


SELECT cve_id, cvss_score, severity, known_exploited
FROM vulnerabilities
WHERE cvss_score IS NOT NULL
LIMIT 1;

SELECT cve_id, cvss_score, known_exploited
FROM vulnerabilities
WHERE known_exploited = 1
  AND cvss_score < 7
  AND cvss_score IS NOT NULL
LIMIT 1;
LIMIT 1;
LIMIT 1;