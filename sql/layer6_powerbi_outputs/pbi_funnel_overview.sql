-- Final Power BI output: Intent-Based User Journey Funnel
-- Provides user counts and conversion rates by funnel stage

WITH funnel_flags AS (
  SELECT
    fullVisitorId,

    1 AS visited,

    MAX(CASE 
        WHEN h.eventInfo.eventAction IN ('Product Click', 'Quickview Click')
        THEN 1 ELSE 0 END) AS product_interaction,

    MAX(CASE 
        WHEN h.eventInfo.eventAction = 'Add to Cart'
        THEN 1 ELSE 0 END) AS add_to_cart,

    MAX(CASE 
        WHEN h.eventInfo.eventAction = 'Remove from Cart'
        THEN 1 ELSE 0 END) AS checkout_friction,

    MAX(CASE 
        WHEN h.type = 'TRANSACTION'
        THEN 1 ELSE 0 END) AS transacted

  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
       UNNEST(hits) AS h
  WHERE _TABLE_SUFFIX BETWEEN '20170701' AND '20170707'
  GROUP BY fullVisitorId
),

stage_counts AS (
  SELECT 'Visit' AS stage, COUNT(*) AS users FROM funnel_flags
  UNION ALL
  SELECT 'Product Interaction', COUNT(*) FROM funnel_flags WHERE product_interaction = 1
  UNION ALL
  SELECT 'Add to Cart', COUNT(*) FROM funnel_flags WHERE add_to_cart = 1
  UNION ALL
  SELECT 'Checkout Friction', COUNT(*) FROM funnel_flags WHERE checkout_friction = 1
  UNION ALL
  SELECT 'Transaction', COUNT(*) FROM funnel_flags WHERE transacted = 1
)

SELECT
  stage,
  users,
  ROUND(
    users * 100.0 /
    LAG(users) OVER (ORDER BY
      CASE stage
        WHEN 'Visit' THEN 1
        WHEN 'Product Interaction' THEN 2
        WHEN 'Add to Cart' THEN 3
        WHEN 'Checkout Friction' THEN 4
        WHEN 'Transaction' THEN 5
      END
    ),
    2
  ) AS conversion_rate_from_previous_stage
FROM stage_counts
ORDER BY
  CASE stage
    WHEN 'Visit' THEN 1
    WHEN 'Product Interaction' THEN 2
    WHEN 'Add to Cart' THEN 3
    WHEN 'Checkout Friction' THEN 4
    WHEN 'Transaction' THEN 5
  END;
