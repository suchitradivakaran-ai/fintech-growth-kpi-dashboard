-- Purpose:
-- Calculate the percentage of users who have completed at least one transaction.
-- This serves as a proxy for meaningful engagement or activation.

WITH user_transactions AS (
  SELECT
    fullVisitorId,
    MAX(CASE WHEN h.type = 'TRANSACTION' THEN 1 ELSE 0 END) AS has_transacted
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
       UNNEST(hits) AS h
  WHERE _TABLE_SUFFIX BETWEEN '20170701' AND '20170707'
  GROUP BY fullVisitorId
)
SELECT
  (SUM(has_transacted) / COUNT(fullVisitorId)) * 100 AS pct_transacting_users
FROM user_transactions;
