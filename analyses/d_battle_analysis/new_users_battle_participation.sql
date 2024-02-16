-- New users participation in battles with days days since registration
CREATE VIEW new_users_battle_participation AS
SELECT
    USER_ID,
    COUNT(CASE WHEN ACTIVITY_NAME LIKE '%MULTIPLAYER_BATTLE%' THEN 1 END) AS battles_participated,
    DATEDIFF('day', FIRST_ACTIVITY_DATE, TO_DATE(EVENT_TIMESTAMP)) AS days_since_registration,
    TO_DATE(EVENT_TIMESTAMP) AS TRANSACTION_DATE
FROM
    (SELECT
        USER_ID,
        MIN(TO_DATE(EVENT_TIMESTAMP)) AS FIRST_ACTIVITY_DATE
    FROM
        dim_user_activity
    GROUP BY
        USER_ID) AS first_activity
JOIN
    dim_user_activity USING (USER_ID)
GROUP BY
    USER_ID, days_since_registration, TRANSACTION_DATE;