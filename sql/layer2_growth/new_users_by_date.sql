-- Purpose:
-- Identify new users by determining the first date on which each user appeared.
-- This helps analyse user acquisition trends over time.

WITH first_activity AS (
  SELECT
    fullVisitorId,
    MIN(date) AS first_active_date
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
  WHERE _TABLE_SUFFIX BETWEEN '20170701' AND '20170707'
  GROUP BY fullVisitorId
)
SELECT
  first_active_date AS date,
  COUNT(fullVisitorId) AS new_users
FROM first_activity
GROUP BY first_active_date
ORDER BY date;
