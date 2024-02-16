-- Battle participation by active users
CREATE VIEW active_users_battle_participation AS
SELECT
    USER_ID,
    COUNT(CASE WHEN ACTIVITY_NAME LIKE '%MULTIPLAYER_BATTLE%' THEN 1 END) AS battles_participated,
    TO_DATE(EVENT_TIMESTAMP) AS TRANSACTION_DATE
FROM
    dim_user_activity
WHERE
    USER_ID IN (SELECT DISTINCT USER_ID FROM dim_user_activity WHERE ACTIVITY_NAME LIKE '%LOG_IN%')
GROUP BY
    USER_ID, TRANSACTION_DATE;