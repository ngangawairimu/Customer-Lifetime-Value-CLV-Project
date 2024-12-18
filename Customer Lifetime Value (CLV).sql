WITH COHORT AS (
    -- This Common Table Expression (CTE) identifies the first registration week for each user
    SELECT
        user_pseudo_id,  -- The user identifier for each user
        DATE_TRUNC(MIN(PARSE_DATE('%Y%m%d', event_date)), week) AS registration_week  -- Truncates the first registration date to the week level
    FROM
        `turing_data_analytics.raw_events`  -- From the raw events data
    GROUP BY user_pseudo_id  -- Groups by user to get the first registration week for each user
),
Revenue AS (
    -- This CTE extracts the weekly purchase revenue data for each user
    SELECT
        raw.user_pseudo_id,  -- The user identifier for each user
        DATE_TRUNC(PARSE_DATE('%Y%m%d', event_date), WEEK) AS purchase_week,  -- Truncates the purchase date to the week level
        purchase_revenue_in_usd AS revenue  -- The revenue generated in that week
    FROM
        `turing_data_analytics.raw_events` raw  -- From the raw events data
)
-- Main query: joins Cohort and Revenue data and calculates weekly revenue per user
SELECT
    Cohort.registration_week,  -- The registration week for each user (when they first registered)
    
    -- Week 0: Revenue generated in the same week as the user's registration week
    SUM(CASE WHEN revenue.purchase_week = cohort.registration_week THEN (revenue.revenue) END) 
        / COUNT(DISTINCT cohort.user_pseudo_id) AS week_0,
    
    -- Week 1: Revenue generated in the week after the user's registration week
    SUM(CASE WHEN revenue.purchase_week = DATE_ADD(cohort.registration_week, INTERVAL 1 WEEK) THEN (revenue.revenue) END) 
        / COUNT(DISTINCT cohort.user_pseudo_id) AS week_1,

    -- Week 2: Revenue generated 2 weeks after the user's registration week
    SUM(CASE WHEN revenue.purchase_week = DATE_ADD(cohort.registration_week, INTERVAL 2 WEEK) THEN (revenue.revenue) END) 
        / COUNT(DISTINCT cohort.user_pseudo_id) AS week_2,

    -- Week 3: Revenue generated 3 weeks after the user's registration week
    SUM(CASE WHEN revenue.purchase_week = DATE_ADD(cohort.registration_week, INTERVAL 3 WEEK) THEN (revenue.revenue) END) 
        / COUNT(DISTINCT cohort.user_pseudo_id) AS week_3,

    -- Week 4: Revenue generated 4 weeks after the user's registration week
    SUM(CASE WHEN revenue.purchase_week = DATE_ADD(cohort.registration_week, INTERVAL 4 WEEK) THEN (revenue.revenue) END) 
        / COUNT(DISTINCT cohort.user_pseudo_id) AS week_4,

    -- Week 5: Revenue generated 5 weeks after the user's registration week
    SUM(CASE WHEN revenue.purchase_week = DATE_ADD(cohort.registration_week, INTERVAL 5 WEEK) THEN (revenue.revenue) END) 
        / COUNT(DISTINCT cohort.user_pseudo_id) AS week_5,

    -- Week 6: Revenue generated 6 weeks after the user's registration week
    SUM(CASE WHEN revenue.purchase_week = DATE_ADD(cohort.registration_week, INTERVAL 6 WEEK) THEN (revenue.revenue) END) 
        / COUNT(DISTINCT cohort.user_pseudo_id) AS week_6,

    -- Week 7: Revenue generated 7 weeks after the user's registration week
    SUM(CASE WHEN revenue.purchase_week = DATE_ADD(cohort.registration_week, INTERVAL 7 WEEK) THEN (revenue.revenue) END) 
        / COUNT(DISTINCT cohort.user_pseudo_id) AS week_7,

    -- Week 8: Revenue generated 8 weeks after the user's registration week
    SUM(CASE WHEN revenue.purchase_week = DATE_ADD(cohort.registration_week, INTERVAL 8 WEEK) THEN (revenue.revenue) END) 
        / COUNT(DISTINCT cohort.user_pseudo_id) AS week_8,

    -- Week 9: Revenue generated 9 weeks after the user's registration week
    SUM(CASE WHEN revenue.purchase_week = DATE_ADD(cohort.registration_week, INTERVAL 9 WEEK) THEN (revenue.revenue) END) 
        / COUNT(DISTINCT cohort.user_pseudo_id) AS week_9,

    -- Week 10: Revenue generated 10 weeks after the user's registration week
    SUM(CASE WHEN revenue.purchase_week = DATE_ADD(cohort.registration_week, INTERVAL 10 WEEK) THEN (revenue.revenue) END) 
        / COUNT(DISTINCT cohort.user_pseudo_id) AS week_10,

    -- Week 11: Revenue generated 11 weeks after the user's registration week
    SUM(CASE WHEN revenue.purchase_week = DATE_ADD(cohort.registration_week, INTERVAL 11 WEEK) THEN (revenue.revenue) END) 
        / COUNT(DISTINCT cohort.user_pseudo_id) AS week_11,

    -- Week 12: Revenue generated 12 weeks after the user's registration week
    SUM(CASE WHEN revenue.purchase_week = DATE_ADD(cohort.registration_week, INTERVAL 12 WEEK) THEN (revenue.revenue) END) 
        / COUNT(DISTINCT cohort.user_pseudo_id) AS week_12

FROM
    Revenue  -- The revenue data, which contains user purchases by week
LEFT JOIN
    Cohort  -- Join the cohort data to get users' registration weeks
ON
    revenue.user_pseudo_id = cohort.user_pseudo_id  -- Match users by their ID

GROUP BY
    Cohort.registration_week  -- Group by the registration week to see the behavior of different cohorts
ORDER BY
    cohort.registration_week  -- Order by the registration week, so cohorts are sorted chronologically
