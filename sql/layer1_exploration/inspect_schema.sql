-- Purpose:
-- Explore the top-level structure of the Google Analytics session dataset.
-- This query is used during Layer 1 (Data Familiarisation) to understand
-- available fields, nested structures, and data types before analysis.

SELECT *
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
LIMIT 10;

