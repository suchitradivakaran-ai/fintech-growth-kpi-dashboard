-- Purpose:
-- Analyse user distribution by acquisition channel.
-- Helps understand which marketing sources drive platform traffic.

SELECT
  trafficSource.source AS acquisition_channel,
  COUNT(DISTINCT fullVisitorId) AS users
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
WHERE _TABLE_SUFFIX BETWEEN '20170701' AND '20170707'
GROUP BY acquisition_channel
ORDER BY users DESC;
