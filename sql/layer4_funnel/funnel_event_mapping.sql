-- Purpose:
-- Explore event categories and actions to identify which events
-- can be mapped to conceptual onboarding funnel stages.

SELECT
  h.eventInfo.eventCategory,
  h.eventInfo.eventAction,
  COUNT(*) AS event_count
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
     UNNEST(hits) AS h
WHERE _TABLE_SUFFIX BETWEEN '20170701' AND '20170707'
  AND h.type = 'EVENT'
GROUP BY
  h.eventInfo.eventCategory,
  h.eventInfo.eventAction
ORDER BY event_count DESC;
