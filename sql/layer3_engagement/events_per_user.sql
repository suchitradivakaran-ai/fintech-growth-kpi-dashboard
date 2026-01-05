-- Purpose:
-- Calculate the average number of events per user.
-- This indicates how actively users interact with the platform.

WITH user_events AS (
  SELECT
    fullVisitorId,
    COUNT(*) AS event_count
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
       UNNEST(hits) AS h
  WHERE _TABLE_SUFFIX BETWEEN '20170701' AND '20170707'
  GROUP BY fullVisitorId
)
SELECT
  AVG(event_count) AS avg_events_per_user
FROM user_events;
