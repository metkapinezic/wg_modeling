-- summary of user activity, including the number of battles, logins, and the number of days since registration before the first purchase, 
-- aggregated by date and user ID

CREATE VIEW user_activity_summary AS
WITH FIRST purchase AS (
    SELECT
        USER_ID,
        MIN(EVENT_TIMESTAMP) AS FIRST_PURCHASE_TIMESTAMP
    FROM
        user_activity
    WHERE
        ACTIVITY_NAME = 'IN_APP_PURCHASE'
    GROUP BY
        USER_ID
),
registration_day AS (
    SELECT
        USER_ID,
        MIN(EVENT_TIMESTAMP) AS REGISTRATION_TIMESTAMP
    FROM
        user_activity
    WHERE
        ACTIVITY_NAME = 'NEW_USER'
    GROUP BY
        USER_ID
)
SELECT
    u.USER_ID,
    DATE_TRUNC('day', u.EVENT_TIMESTAMP) AS DAY,
    COUNT(DISTINCT CASE WHEN u.ACTIVITY_NAME = 'MULTIPLAYER_BATTLE' THEN u.USER_ACTIVITY_ID END) AS num_battles,
    COUNT(DISTINCT CASE WHEN u.ACTIVITY_NAME = 'LOG_IN' THEN u.USER_ACTIVITY_ID END) AS num_logins,
    EXTRACT(DAY FROM (fp.FIRST_PURCHASE_TIMESTAMP - r.REGISTRATION_TIMESTAMP)) AS days_before_first_purchase
FROM
    user_activity u
LEFT JOIN
    first_purchase fp ON u.USER_ID = fp.USER_ID
LEFT JOIN
    registration_day r ON u.USER_ID = r.USER_ID
GROUP BY
    u.USER_ID,
    DATE_TRUNC('day', u.EVENT_TIMESTAMP);


    


 

