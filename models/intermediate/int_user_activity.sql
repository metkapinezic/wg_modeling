CREATE TABLE user_activity (
    USER_ID                 VARCHAR NOT NULL,
    EVENT_TIMESTAMP         TIMESTAMP WITH TIME ZONE NOT NULL,
    ACTIVITY_NAME           VARCHAR NOT NULL,
    IN_APP_PURCHASE_ID      VARCHAR,
    USD_COST                NUMBER,
    LOG_IN_EVENT_ID         VARCHAR,
    MULTIPLAYER_EVENT_ID    VARCHAR,
    NEW_USER_EVENT_ID       VARCHAR,
    SESSION_STARTED_ID      VARCHAR,
    SHIP_TRANSACTION_ID     VARCHAR,
    SHIP_ID                 VARCHAR,
    SC_AMOUNT               NUMBER,
    SHIP_TRANSACTION_STATUS VARCHAR
);

INSERT INTO user_activity (USER_ID, EVENT_TIMESTAMP, ACTIVITY_NAME, IN_APP_PURCHASE_ID, REAL_CURRENCY_AMOUNT, LOG_IN_EVENT_ID, MULTIPLAYER_EVENT_ID, NEW_USER_EVENT_ID, SESSION_STARTED_ID, SHIP_TRANSACTION_ID, SHIP_ID, SC_AMOUNT, SHIP_TRANSACTION_STATUS)
SELECT 
    USER_ID, 
    EVENT_TIMESTAMP, 
    CASE 
        WHEN IN_APP_PURCHASE_ID IS NOT NULL THEN 'IN-APP_PURCHASE'
        WHEN LOG_IN_EVENT_ID IS NOT NULL THEN 'LOG_IN'
        WHEN MULTIPLAYER_EVENT_ID IS NOT NULL THEN 'MULTIPLAYER_BATTLE'
        WHEN NEW_USER_EVENT_ID IS NOT NULL THEN 'NEW_USER'
        WHEN SESSION_STARTED_ID IS NOT NULL THEN 'SESSION_STARTED'
        WHEN SHIP_TRANSACTION_ID IS NOT NULL THEN 'SHIP_TRANSACTION'
        ELSE NULL 
    END AS ACTIVITY_NAME,
    IN_APP_PURCHASE_ID, 
    USD_COST, 
    LOG_IN_EVENT_ID, 
    MULTIPLAYER_EVENT_ID, 
    NEW_USER_EVENT_ID, 
    SESSION_STARTED_ID, 
    SHIP_TRANSACTION_ID, 
    SHIP_ID, 
    SC_AMOUNT, 
    SHIP_TRANSACTION_STATUS,
    USER_LTV,
FROM (
    SELECT 
        USER_ID, 
        EVENT_TIMESTAMP, 
        IN_APP_PURCHASE_ID, 
        USD_COST, 
        NULL AS LOG_IN_EVENT_ID, 
        NULL AS MULTIPLAYER_EVENT_ID, 
        NULL AS NEW_USER_EVENT_ID, 
        NULL AS SESSION_STARTED_ID, 
        NULL AS SHIP_TRANSACTION_ID, 
        NULL AS SHIP_ID, 
        NULL AS SC_AMOUNT, 
        NULL AS SHIP_TRANSACTION_STATUS,
        NULL AS USER_LTV
    FROM STG_IN_APP_PURCHASE_LOG_SERVER
    
    UNION ALL
    
    SELECT 
        USER_ID, 
        EVENT_TIMESTAMP, 
        NULL AS IN_APP_PURCHASE_ID, 
        NULL AS USD_COST, 
        LOGIN_EVENT_ID AS LOG_IN_EVENT_ID, 
        NULL AS MULTIPLAYER_EVENT_ID, 
        NULL AS NEW_USER_EVENT_ID, 
        NULL AS SESSION_STARTED_ID, 
        NULL AS SHIP_TRANSACTION_ID, 
        NULL AS SHIP_ID, 
        NULL AS SC_AMOUNT, 
        NULL AS SHIP_TRANSACTION_STATUS,
        USER_LTV
    FROM STG_LOGIN
    
    UNION ALL
    
    SELECT 
        USER_ID, 
        EVENT_TIMESTAMP, 
        NULL AS IN_APP_PURCHASE_ID, 
        NULL AS USD_COST, 
        NULL AS LOG_IN_EVENT_ID, 
        MULTIPLAYER_EVENT_ID, 
        NULL AS NEW_USER_EVENT_ID, 
        NULL AS SESSION_STARTED_ID, 
        NULL AS SHIP_TRANSACTION_ID, 
        NULL AS SHIP_ID, 
        NULL AS SC_AMOUNT, 
        NULL AS SHIP_TRANSACTION_STATUS,
        NULL AS USER_LTV
    FROM STG_MULTIPLAYER_BATTLE_STARTED
    
    UNION ALL
    
    SELECT 
        USER_ID, 
        EVENT_TIMESTAMP, 
        NULL AS IN_APP_PURCHASE_ID, 
        NULL AS USD_COST, 
        NULL AS LOG_IN_EVENT_ID, 
        NULL AS MULTIPLAYER_EVENT_ID, 
        NEW_USER_EVENT_ID, 
        NULL AS SESSION_STARTED_ID, 
        NULL AS SHIP_TRANSACTION_ID, 
        NULL AS SHIP_ID, 
        NULL AS SC_AMOUNT, 
        NULL AS SHIP_TRANSACTION_STATUS,
        NULL AS USER_LTV
    FROM STG_NEW_USER
    
    UNION ALL
    
    SELECT 
        USER_ID, 
        EVENT_TIMESTAMP, 
        NULL AS IN_APP_PURCHASE_ID, 
        NULL AS USD_COST, 
        NULL AS LOG_IN_EVENT_ID, 
        NULL AS MULTIPLAYER_EVENT_ID, 
        NULL AS NEW_USER_EVENT_ID, 
        SESSION_STARTED_ID, 
        NULL AS SHIP_TRANSACTION_ID, 
        NULL AS SHIP_ID, 
        NULL AS SC_AMOUNT, 
        NULL AS SHIP_TRANSACTION_STATUS,
        NULL AS USER_LTV
    FROM STG_SESSION_STARTED
    
    UNION ALL
    
    SELECT 
        USER_ID, 
        EVENT_TIMESTAMP, 
        NULL AS IN_APP_PURCHASE_ID, 
        NULL AS USD_COST, 
        NULL AS LOG_IN_EVENT_ID, 
        NULL AS MULTIPLAYER_EVENT_ID, 
        NULL AS NEW_USER_EVENT_ID, 
        NULL AS SESSION_STARTED_ID, 
        SHIP_TRANSACTION_ID, 
        SHIP_ID, 
        SC_AMOUNT, 
        SHIP_TRANSACTION_STATUS,
        NULL AS USER_LTV
    FROM STG_SHIP_TRANSACTION_LOG
) AS merged_data;