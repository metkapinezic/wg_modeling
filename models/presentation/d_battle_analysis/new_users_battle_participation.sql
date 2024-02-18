-- provides information about new users' battle participation, including the number of battles participated in, 
-- the number of days since registration, and the transaction date for each activity.
-- days of participation can be aditionally filtered out in tableau to have a view on 1/3/7/14 days since regisration
CREATE VIEW new_users_battle_participation AS
SELECT
    USER_ID,
    COUNT(CASE WHEN ACTIVITY_NAME = 'MULTIPLAYER_BATTLE' THEN 1 END) AS battles_participated,
    DATEDIFF('day', FIRST_ACTIVITY_DATE, EVENT_TIMESTAMP) AS days_since_registration,
    TO_DATE(EVENT_TIMESTAMP) AS TRANSACTION_DATE
FROM
    (SELECT
        USER_ID,
        MIN(EVENT_TIMESTAMP) AS FIRST_ACTIVITY_DATE
    FROM
        user_activity
    WHERE
        ACTIVITY_NAME = 'NEW_USER'
    GROUP BY
        USER_ID) AS first_activity
JOIN
    user_activity USING (USER_ID)
GROUP BY
    USER_ID, days_since_registration, TRANSACTION_DATE;