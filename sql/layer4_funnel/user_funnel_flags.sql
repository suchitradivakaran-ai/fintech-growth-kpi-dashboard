-- Purpose:
-- Create user-level intent-based funnel flags.
-- Each row represents one user and indicates whether they reached
-- each simulated funnel stage during the analysis window.

WITH funnel_flags AS (
  SELECT
    fullVisitorId,

    1 AS visited,

    MAX(
      CASE 
        WHEN h.eventInfo.eventAction IN ('Product Click', 'Quickview Click')
        THEN 1 ELSE 0 
      END
    ) AS product_interaction,

    MAX(
      CASE 
        WHEN h.eventInfo.eventAction = 'Add to Cart'
        THEN 1 ELSE 0 
      END
    ) AS add_to_cart,

    MAX(
      CASE 
        WHEN h.eventInfo.eventAction = 'Remove from Cart'
        THEN 1 ELSE 0 
      END
    ) AS checkout_friction,

    MAX(
      CASE 
        WHEN h.type = 'TRANSACTION'
        THEN 1 ELSE 0 
      END
    ) AS transacted

  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
       UNNEST(hits) AS h
  WHERE _TABLE_SUFFIX BETWEEN '20170701' AND '20170707'
  GROUP BY fullVisitorId
)

SELECT *
FROM funnel_flags;
