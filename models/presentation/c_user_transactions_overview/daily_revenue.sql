CREATE VIEW daily_revenue 
AS
SELECT
    USER_ID,
    DATE_TRUNC('day', TO_DATE(EVENT_TIMESTAMP)) AS TRANSACTION_DATE,
    'Daily' AS INTERVAL_TYPE,
    SUM (USD_COST) AS revenue_amount
FROM
    user_activity
WHERE ACTIVITY_NAME = 'IN_APP_PURCHASE'
GROUP BY
    USER_ID, DATE_TRUNC('day', TO_DATE(EVENT_TIMESTAMP))