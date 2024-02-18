CREATE VIEW weekly_kpis AS
SELECT
    DATE_TRUNC('week', DAY) AS WEEK_START,
    COUNT(COUNT_ACTIVE_USERS) AS COUNT_ACTIVE_USERS,
    COUNT(COUNT_NEW_USERS) AS COUNT_NEW_USERS,
    SUM(DAILY_REVENUE) AS WEEKLY_REVENUE,
    SUM(COUNT_SPENDERS) AS WEEKLY_COUNT_SPENDERS,
    SUM(DAILY_REVENUE) / COUNT(COUNT_ACTIVE_USERS) AS WEEKLY_ARPU,
    SUM(DAILY_REVENUE) / NULLIF(SUM(COUNT_SPENDERS), 0) AS WEEKLY_ARPPU,
    AVG(1_day_retention_rate) AS AVG_1_DAY_RETENTION_RATE,
    AVG(3_day_retention_rate) AS AVG_3_DAY_RETENTION_RATE,
    AVG(7_day_retention_rate) AS AVG_7_DAY_RETENTION_RATE,
    AVG(CHURN_RATE) AS AVG_CHURN_RATE,
    AVG(AVG_LTV) AS AVG_LTV
FROM
    daily_kpis
GROUP BY
    DATE_TRUNC('week', DAY);