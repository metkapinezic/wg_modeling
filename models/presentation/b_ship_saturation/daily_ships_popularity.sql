-- ship purchases made each day
CREATE VIEW daily_ship_popularity AS
SELECT 
    DATE_TRUNC('day', EVENT_TIMESTAMP) AS TRANSACTION_DATE,
    SHIP_ID,
    COUNT(*) AS purchase_count
FROM 
    user_activity
WHERE 
    ACTIVITY_NAME = 'SHIP_TRANSACTION' AND
    SC_AMOUNT < 0 -- Only consider ship purchases
GROUP BY 
    DATE_TRUNC('day', ua.EVENT_TIMESTAMP), st.SHIP_ID
ORDER BY 
    DATE_TRUNC('day', ua.EVENT_TIMESTAMP), purchase_count DESC;
