-- Final Power BI output: Engagement Overview
-- Provides average sessions per user, events per user, and % transacting users

WITH user_metrics AS (
  SELECT
    fullVisitorId,
    COUNT(DISTINCT visitId) AS sessions,
    COUNT(h.hitNumber) AS events,
    MAX(CASE WHEN totals.transactions IS NOT NULL THEN 1 ELSE 0 END) AS transacted
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
       UNNEST(hits) AS h
  WHERE _TABLE_SUFFIX BETWEEN '20170701' AND '20170707'
  GROUP BY fullVisitorId
)

SELECT
  ROUND(AVG(sessions), 2) AS avg_sessions_per_user,
  ROUND(AVG(events), 2) AS avg_events_per_user,
  ROUND(SUM(transacted) * 100.0 / COUNT(*), 2) AS pct_transacting_users
FROM user_metrics;
