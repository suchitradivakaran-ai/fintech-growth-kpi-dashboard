-- Purpose:
-- Calculate Daily Active Users (DAU) for the platform.
-- Each user is counted once per day regardless of the number of sessions or events.
-- This query establishes baseline user growth trends.

SELECT
  date,
  COUNT(DISTINCT fullVisitorId) AS active_users
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
WHERE _TABLE_SUFFIX BETWEEN '20170701' AND '20170707'
GROUP BY date
ORDER BY date;
