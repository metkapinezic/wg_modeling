-- profile the data to identify patterns, anomalies, or outliers
-- distinct activity names should not be larger than 6
SELECT COUNT(DISTINCT ACTIVITY_NAME) AS distinct_activity_count
FROM {{model}}
HAVING COUNT(DISTINCT ACTIVITY_NAME) > 6
