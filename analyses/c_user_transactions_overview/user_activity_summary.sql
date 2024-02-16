-- summary of user activity, including the number of battles, logins, and the number of days since registration before the first purchase, 
-- aggregated by date and user ID

CREATE VIEW user_activity_summary 
AS
SELECT
    u.USER_ID,
    DATE_TRUNC('day', u.EVENT_TIMESTAMP) AS date,
    COUNT(DISTINCT CASE WHEN u.ACTIVITY_NAME = 'MULTIPLAYER_BATTLE' THEN u.USER_ACTIVITY_ID END) AS num_battles,
    COUNT(DISTINCT CASE WHEN u.ACTIVITY_NAME = 'LOG_IN' THEN u.USER_ACTIVITY_ID END) AS num_logins,
    COALESCE(EXTRACT(DAY FROM (p.EVENT_TIMESTAMP - u.EVENT_TIMESTAMP)), 0) AS days_before_first_purchase
FROM
    user_activity u
LEFT JOIN
    user_activity p ON u.USER_ID = p.USER_ID
    AND u.ACTIVITY_NAME = 'NEW_USER'
    AND p.ACTIVITY_NAME = 'IN_APP_PURCHASE'
    AND p.EVENT_TIMESTAMP > u.EVENT_TIMESTAMP
GROUP BY
    u.USER_ID,
    DATE_TRUNC('day', u.EVENT_TIMESTAMP);


 

