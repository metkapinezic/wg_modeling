CREATE VIEW daily_kpis AS
SELECT
    gp.DAY,
    gp.COUNT_ACTIVE_USERS, 
    gp.COUNT_NEW_USERS,
    gp.DAILY_REVENUE,
    gp.COUNT_SPENDERS,
    gp.ARPU,
    gp.ARPPU,
    r.1_day_retention_rate,
    r.3_day_retention_rate,
    r.7_day_retention_rate,
    gp.CHURN_RATE,
    gp.AVG_LTV
FROM
    game_performance gp
INNER JOIN
    retention r ON gp.DAY = r.DAY;
