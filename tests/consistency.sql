-- Check if event_timestamp is in timestamp format
SELECT COUNT(*)
FROM user_activity
WHERE TO_TIMESTAMP(EVENT_TIMESTAMP) IS NOT NULL;