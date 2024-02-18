CREATE VIEW game_performance 
AS

    WITH user_activity_summary AS (
    SELECT
        DATE_TRUNC('day', EVENT_TIMESTAMP) AS DAY,
        EVENT_NAME,
        ACTIVITY_NAME,
        USER_ID,
        USD_COST,
        USER_LTV -- additional  metric
    FROM
        {{ ref('int_user_activity') }} 
),

-- additional metic
churn_rate AS (
    SELECT COUNT(DISTINCT USER_ID) * 100.0 /
        (SELECT COUNT(DISTINCT USER_ID)
         FROM user_activity_summary
         WHERE DAY >= DATE_TRUNC('day', ua.DAY) - INTERVAL '90 DAY'
           AND DAY < DATE_TRUNC('day', ua.DAY) - INTERVAL '1 DAY'
        ) AS churn_rate
    FROM user_activity_summary ua
    WHERE DAY >= DATE_TRUNC('day', ua.DAY) - INTERVAL '90 DAY'
       AND DAY < DATE_TRUNC('day', ua.DAY) - INTERVAL '1 DAY'
),

game_performance AS (
    SELECT
        DAY,
        COUNT(DISTINCT CASE WHEN EVENT_NAME = 'SESSION_STARTED' THEN USER_ID END) AS COUNT_ACTIVE_USERS, 
        COUNT(DISTINCT CASE WHEN EVENT_NAME = 'NEW_USER' THEN USER_ID END) AS COUNT_NEW_USERS,
        SUM(CASE WHEN ACTIVITY_NAME = 'IN-APP_PURCHASE' THEN REAL_CURRENCY_AMOUNT ELSE 0 END) AS DAILY_REVENUE,
        COUNT(DISTINCT CASE WHEN ACTIVITY_NAME = 'IN-APP_PURCHASE' THEN USER_ID END) AS COUNT_SPENDERS,
        SUM(USD_COST) / COUNT(DISTINCT USER_ID) AS ARPU,
        SUM(USD_COST) / NULLIF(COUNT(DISTINCT CASE WHEN ACTIVITY_NAME = 'IN-APP_PURCHASE' THEN USER_ID END), 0) AS ARPPU,
        -- added metrics
        (SELECT churn_rate FROM churn_rate) AS CHURN_RATE,
        AVG(USER_LTV) AS AVG_LTV
    FROM
        user_activity_summary
    GROUP BY
        DAY
)

SELECT * FROM game_performance;
