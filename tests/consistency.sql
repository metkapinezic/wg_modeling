-- Check if event_timestamp is in timestamp format
SELECT COUNT(*)
FROM {{model}}
WHERE TO_TIMESTAMP(EVENT_TIMESTAMP) IS NOT NULL;