-- Purpose:
-- Check transaction presence and basic transaction metrics
-- during the analysis period.

SELECT
  COUNT(DISTINCT fullVisitorId) AS transacting_users,
  COUNT(*) AS total_transactions,
  SUM(totals.totalTransactionRevenue) / 1000000 AS total_revenue
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
WHERE _TABLE_SUFFIX BETWEEN '20170701' AND '20170707'
  AND totals.transactions IS NOT NULL;
