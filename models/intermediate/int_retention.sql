CREATE VIEW retention AS 
WITH retention_summary AS (
    SELECT
        DATE_TRUNC('day', EVENT_TIMESTAMP) AS DAY,
        USER_ID
    FROM  {{ ref('int_user_activity') }} 
),
one AS (
    SELECT 
        DATE_TRUNC('day', DAY) AS DAY,
        COUNT(DISTINCT USER_ID) AS 1_day_retention_count
    FROM retention_summary
    WHERE DAY >= DATE_TRUNC('day', DAY) - INTERVAL '1 DAY'
      AND DAY < DATE_TRUNC('day', DAY)
    GROUP BY DATE_TRUNC('day', DAY)
), 
three AS (
    SELECT 
        DATE_TRUNC('day', DAY) AS DAY,
        COUNT(DISTINCT USER_ID) AS 3_day_retention_count
    FROM retention_summary
    WHERE DAY >= DATE_TRUNC('day', DAY) - INTERVAL '3 DAY'
      AND DAY < DATE_TRUNC('day', DAY)
    GROUP BY DATE_TRUNC('day', DAY)
),
seven AS (
    SELECT 
        DATE_TRUNC('day', DAY) AS DAY,
        COUNT(DISTINCT USER_ID) AS 7_day_retention_count
    FROM retention_summary
    WHERE DAY >= DATE_TRUNC('day', DAY) - INTERVAL '7 DAY'
      AND DAY < DATE_TRUNC('day', DAY)
    GROUP BY DATE_TRUNC('day', DAY)
)
SELECT
    rs.DAY,
    one.1_day_retention_count,
    three.3_day_retention_count,
    seven.7_day_retention_count,
    (one.1_day_retention_count / COUNT(DISTINCT rs.USER_ID)) * 100.0 AS 1_day_retention_rate,
    (three.3_day_retention_count / COUNT(DISTINCT rs.USER_ID)) * 100.0 AS 3_day_retention_rate,
    (seven.7_day_retention_count / COUNT(DISTINCT rs.USER_ID)) * 100.0 AS 7_day_retention_rate
FROM 
    retention_summary rs
LEFT JOIN 
    one ON rs.DAY = one.DAY
LEFT JOIN 
    three ON rs.DAY = three.DAY
LEFT JOIN 
    seven ON rs.DAY = seven.DAY;

