--counts the number of ships owned by each user on a specific day

CREATE VIEW ships_owned_by_users AS
SELECT 
    DATE_TRUNC('day', ua.EVENT_TIMESTAMP) AS TRANSACTION_DATE,
    USER_ID,
    SHIP_ID,
    COUNT(*) AS transaction_count
FROM 
    user_activity
WHERE 
    ACTIVITY_NAME = 'SHIP_TRANSACTION' AND
    SC_AMOUNT != 0 -- Consider both purchases and sales
GROUP BY 
    USER_ID, DATE_TRUNC('day', ua.EVENT_TIMESTAMP), SHIP_ID
ORDER BY 
    TRANSACTION_DATE, transaction_count DESC;