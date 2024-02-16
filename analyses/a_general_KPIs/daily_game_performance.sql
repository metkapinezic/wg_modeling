CREATE VIEW game_performance 
(
    DAY                     DATE,
    COUNT_ACTIVE_USERS      NUMBER, -- those who have logged in that day
    COUNT_NEW_USERS         NUMBER, -- those who have registered that day
    DAILY_REVENUE           NUMBER, -- in-app purchases
    COUNT_SPENDERS          NUMBER, -- who have made at least one purchase that day
    ARPU                    NUMBER, -- average revenue per user generated on that day
    ARPPU                   NUMBER, -- average revenue per paying user generated on that day
    1_DAY_RETENTION_RATE    NUMBER, -- comparing the count of distinct users on the previous day with the count of distinct users on the current day
    3_DAY_RETENTION_RATE    NUMBER, -- comparing the count of distinct USER_IDs three days ago with the count of distinct USER_IDs for the current day
    7_DAY_CONVERSION_RATE   NUMBER, -- comparing the count of distinct USER_IDs seven days ago with the count of distinct USER_IDs for the current day
)

AS
SELECT
    DATE_TRUNC('day', EVENT_TIMESTAMP) AS DAY,
    COUNT(DISTINCT CASE WHEN EVENT_NAME = 'SESSION_STARTED' THEN USER_ID END) AS COUNT_ACTIVE_USERS, 
    COUNT(DISTINCT CASE WHEN EVENT_NAME = 'NEW_USER' THEN USER_ID END) AS COUNT_NEW_USERS,
    SUM(REAL_CURRENCY_AMOUNT) AS DAILY_REVENUE,
    COUNT(DISTINCT CASE WHEN ACTIVITY_NAME = 'IN-APP_PURCHASE' THEN USER_ID END) AS COUNT_SPENDERS,
    SUM(REAL_CURRENCY_AMOUNT) / COUNT(DISTINCT USER_ID) AS ARPU,
    SUM(REAL_CURRENCY_AMOUNT) / NULLIF(COUNT(DISTINCT CASE WHEN ACTIVITY_NAME = 'IN-APP_PURCHASE' THEN USER_ID END), 0) AS ARPPU,
    (SELECT COUNT(DISTINCT USER_ID) * 100.0 /
        (SELECT COUNT(DISTINCT USER_ID)
         FROM user_activity
         WHERE EVENT_TIMESTAMP >= DATE_TRUNC('day', ua.EVENT_TIMESTAMP) - INTERVAL '1 DAY'
           AND EVENT_TIMESTAMP < DATE_TRUNC('day', ua.EVENT_TIMESTAMP)
        )
     FROM user_activity ua
     WHERE EVENT_TIMESTAMP >= DATE_TRUNC('day', ua.EVENT_TIMESTAMP) - INTERVAL '1 DAY'
       AND EVENT_TIMESTAMP < DATE_TRUNC('day', ua.EVENT_TIMESTAMP)
    ) AS 1_DAY_RETENTION_RATE,
    (SELECT COUNT(DISTINCT USER_ID) * 100.0 /
        (SELECT COUNT(DISTINCT USER_ID)
         FROM user_activity
         WHERE EVENT_TIMESTAMP >= DATE_TRUNC('day', ua.EVENT_TIMESTAMP) - INTERVAL '3 DAY'
           AND EVENT_TIMESTAMP < DATE_TRUNC('day', ua.EVENT_TIMESTAMP)
        )
     FROM user_activity ua
     WHERE EVENT_TIMESTAMP >= DATE_TRUNC('day', ua.EVENT_TIMESTAMP) - INTERVAL '3 DAY'
       AND EVENT_TIMESTAMP < DATE_TRUNC('day', ua.EVENT_TIMESTAMP)
    ) AS 3_DAY_RETENTION_RATE,
    (SELECT COUNT(DISTINCT USER_ID) * 100.0 /
        (SELECT COUNT(DISTINCT USER_ID)
         FROM user_activity
         WHERE EVENT_TIMESTAMP >= DATE_TRUNC('day', ua.EVENT_TIMESTAMP) - INTERVAL '7 DAY'
           AND EVENT_TIMESTAMP < DATE_TRUNC('day', ua.EVENT_TIMESTAMP)
        )
     FROM user_activity ua
     WHERE EVENT_TIMESTAMP >= DATE_TRUNC('day', ua.EVENT_TIMESTAMP) - INTERVAL '7 DAY'
       AND EVENT_TIMESTAMP < DATE_TRUNC('day', ua.EVENT_TIMESTAMP)
    ) AS 7_DAY_RETENTION_RATE,
    (SELECT COUNT(DISTINCT USER_ID) * 100.0 /
        (SELECT COUNT(DISTINCT USER_ID)
         FROM user_activity
         WHERE EVENT_TIMESTAMP >= DATE_TRUNC('day', ua.EVENT_TIMESTAMP)
           AND EVENT_TIMESTAMP < DATE_TRUNC('day', ua.EVENT_TIMESTAMP) + INTERVAL '1 DAY'
        )
     FROM user_activity ua
     WHERE EVENT_TIMESTAMP >= DATE_TRUNC('day', ua.EVENT_TIMESTAMP)
       AND EVENT_TIMESTAMP < DATE_TRUNC('day', ua.EVENT_TIMESTAMP) + INTERVAL '7 DAY'
    ) AS 7_DAY_CONVERSION_RATE
FROM
    user_activity
GROUP BY
    DATE_TRUNC('day', EVENT_TIMESTAMP);
