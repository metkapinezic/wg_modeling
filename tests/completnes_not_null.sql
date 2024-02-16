-- Check if all required fields are populated
SELECT COUNT(*) AS missing_values_count
FROM user_activity
WHERE USER_ID IS NULL OR EVENT_TIMESTAMP IS NULL OR ACTIVITY_NAME IS NULL;