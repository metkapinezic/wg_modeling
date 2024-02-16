-- Game session log
CREATE TABLE SESSION_STARTED
  (
      ANDROID_REGISTRATION_ID     VARCHAR,
      COLLECT_INSERTED_TIMESTAMP  TIMESTAMP_TZ,
      EVENT_ID                    NUMBER,
      EVENT_TIMESTAMP             TIMESTAMP_TZ,
      EVENT_UUID                  VARCHAR,
      MAIN_EVENT_ID               NUMBER,
      MS_SINCE_LAST_EVENT         DOUBLE,
      PLATFORM                    VARCHAR,
      SDK_VERSION                 VARCHAR,
      SESSION_ID                  VARCHAR,
      USER_GEO_LOCATION           VARCHAR,
      USER_ID                     VARCHAR,
      USER_LEVEL                  NUMBER,
      USER_SCORE                  NUMBER,
      USER_SERVER                 VARCHAR,
      USER_XP                     NUMBER,
      APPS_FLYER_ID               VARCHAR,
      USER_IS_SPENDER             BOOLEAN,
      DEVICE_ID                   VARCHAR,
      USER_IS_PREMIUM             BOOLEAN,
      USER_REGION                 VARCHAR,
      SERVER_VERSION              VARCHAR,
      USER_TYPE                   VARCHAR,
      USER_GEO                    VARCHAR,
      PLAYER_TYPE                 VARCHAR,
      CLIENT_VERSION              VARCHAR,
      USER_CLAN_ID                VARCHAR,
      USER_INGAME_ID              VARCHAR,
      USER_CLAN_LEVEL             NUMBER,
      GDPR_PROCESSED_TS           TIMESTAMP_TZ,
      STORE                       VARCHAR
  );