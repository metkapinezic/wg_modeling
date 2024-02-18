--counts the number of ships owned by each user on a specific day

CREATE VIEW ships_owned_by_users AS
SELECT 
    DATE_TRUNC('day', EVENT_TIMESTAMP) AS TRANSACTION_DATE,
    USER_ID,
    SHIP_ID,
    SUM(CASE WHEN SC_AMOUNT < 0 THEN 1 ELSE 0 END) AS ships_purchased_by_user,
    SUM(CASE WHEN SC_AMOUNT >= 0 THEN 1 ELSE 0 END) AS ships_sold_by_user,
    SUM(CASE WHEN SC_AMOUNT >= 0 THEN -1 ELSE 1 END) AS ships_owned_by_user,
    COUNT(*) AS transaction_count
FROM 
    user_activity
WHERE 
    ACTIVITY_NAME = 'SHIP_TRANSACTION'
GROUP BY 
    DATE_TRUNC('day', EVENT_TIMESTAMP), USER_ID, SHIP_ID,
ORDER BY 
    TRANSACTION_DATE, transaction_count DESC;