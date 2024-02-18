-- Check if all required fields are populated

SELECT COUNT(*) AS missing_values_count
FROM {{model}}
WHERE USER_ID IS NULL OR EVENT_TIMESTAMP IS NULL OR ACTIVITY_NAME IS NULL;