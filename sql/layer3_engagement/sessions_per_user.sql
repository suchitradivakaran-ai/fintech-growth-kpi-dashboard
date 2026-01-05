-- Purpose:
-- Calculate the average number of sessions per user.
-- This metric helps assess how frequently users return to the platform.

WITH user_sessions AS (
  SELECT
    fullVisitorId,
    COUNT(DISTINCT visitId) AS session_count
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
  WHERE _TABLE_SUFFIX BETWEEN '20170701' AND '20170707'
  GROUP BY fullVisitorId
)
SELECT
  AVG(session_count) AS avg_sessions_per_user
FROM user_sessions;
