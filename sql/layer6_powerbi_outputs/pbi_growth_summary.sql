-- Final Power BI output: Growth Overview
-- Provides daily active users, new users, and acquisition channel distribution

WITH daily_users AS (
  SELECT
    PARSE_DATE('%Y%m%d', date) AS activity_date,
    COUNT(DISTINCT fullVisitorId) AS daily_active_users,
    COUNT(DISTINCT CASE WHEN totals.newVisits = 1 THEN fullVisitorId END) AS new_users
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
  WHERE _TABLE_SUFFIX BETWEEN '20170701' AND '20170707'
  GROUP BY activity_date
),

channel_users AS (
  SELECT
    channelGrouping AS acquisition_channel,
    COUNT(DISTINCT fullVisitorId) AS users
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
  WHERE _TABLE_SUFFIX BETWEEN '20170701' AND '20170707'
  GROUP BY acquisition_channel
)

SELECT
  d.activity_date,
  d.daily_active_users,
  d.new_users,
  c.acquisition_channel,
  c.users AS users_by_channel
FROM daily_users d
CROSS JOIN channel_users c
ORDER BY d.activity_date;

