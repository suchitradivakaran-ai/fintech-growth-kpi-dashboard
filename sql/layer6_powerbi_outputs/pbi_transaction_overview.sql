-- Final Power BI output: Transaction & Value Overview
-- Provides transaction metrics and intent-based value proxies

WITH transaction_summary AS (
  SELECT
    COUNT(DISTINCT fullVisitorId) AS transacting_users,
    COUNT(*) AS total_transactions,
    SUM(totals.totalTransactionRevenue) / 1000000 AS total_revenue
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
  WHERE _TABLE_SUFFIX BETWEEN '20170701' AND '20170707'
    AND totals.transactions IS NOT NULL
),

value_proxies AS (
  SELECT
    COUNT(DISTINCT fullVisitorId) AS users_with_product_interaction,
    COUNTIF(h.eventInfo.eventAction = 'Add to Cart') AS add_to_cart_events,
    COUNTIF(h.eventInfo.eventAction = 'Remove from Cart') AS checkout_friction_events
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
       UNNEST(hits) AS h
  WHERE _TABLE_SUFFIX BETWEEN '20170701' AND '20170707'
)

SELECT *
FROM transaction_summary
CROSS JOIN value_proxies;
