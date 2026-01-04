-- Purpose:
-- Flatten nested hit-level data to inspect individual events within sessions.
-- Helps understand event types, event categories, and transaction fields.

SELECT
  fullVisitorId,
  date,
  h.type,
  h.eventInfo.eventCategory,
  h.eventInfo.eventAction,
  h.transaction.transactionRevenue
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
UNNEST(hits) AS h
LIMIT 20;
