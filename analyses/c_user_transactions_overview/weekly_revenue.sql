CREATE VIEW weekly_revenue 
AS
SELECT
    USER_ID,
    DATE_TRUNC('week', TO_DATE(EVENT_TIMESTAMP)) AS TRANSACTION_DATE,
    'Weekly' AS INTERVAL_TYPE,
    SUM(CASE WHEN ACTIVITY_NAME = 'IN_APP_PURCHASE' THEN REAL_CURRENCY_AMOUNT ELSE 0 END) AS revenue_amount
FROM
    user_activity
GROUP BY
    USER_ID, DATE_TRUNC('week', TO_DATE(EVENT_TIMESTAMP))