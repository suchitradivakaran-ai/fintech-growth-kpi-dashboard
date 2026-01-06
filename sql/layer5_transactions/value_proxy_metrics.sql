-- Purpose:
-- Use intent-based actions as proxies for potential value creation.

SELECT
  COUNT(DISTINCT fullVisitorId) AS users_with_product_interaction,
  COUNTIF(h.eventInfo.eventAction = 'Add to Cart') AS add_to_cart_events,
  COUNTIF(h.eventInfo.eventAction = 'Remove from Cart') AS checkout_friction_events
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
     UNNEST(hits) AS h
WHERE _TABLE_SUFFIX BETWEEN '20170701' AND '20170707';
