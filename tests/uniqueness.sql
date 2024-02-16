-- Ensure that the primary key USER_ACTIVITY_ID contains unique values
SELECT COUNT(*)
FROM (
    SELECT USER_ACTIVITY_ID, COUNT(*) AS count
    FROM user_activity
    GROUP BY USER_ACTIVITY_ID
    HAVING COUNT(*) > 1
) AS duplicate_keys;