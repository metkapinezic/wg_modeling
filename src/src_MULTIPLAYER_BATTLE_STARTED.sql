-- Battle log
CREATE TABLE MULTIPLAYER_BATTLE_STARTED
  (
      CLAN_ID                       VARCHAR,
      CLAN_LEVEL                    NUMBER,
      CLAN_NAME                     VARCHAR,
      CLAN_RANK                     NUMBER,
      COLLECT_INSERTED_TIMESTAMP    TIMESTAMP_TZ,
      EVENT_ID                      NUMBER,
      EVENT_TIMESTAMP               TIMESTAMP_TZ,
      EVENT_UUID                    VARCHAR,
      MAIN_EVENT_ID                 NUMBER,
      MAP_ID                        VARCHAR,
      MAP_NAME                      VARCHAR,
      MS_SINCE_LAST_EVENT           DOUBLE,
      MULTIPLAYER_BATTLE_ID         VARCHAR,
      MULTIPLAYER_BATTLE_MODE       VARCHAR,
      MULTIPLAYER_BATTLE_TEAM       VARCHAR,
      MULTIPLAYER_BATTLE_TYPE       VARCHAR,
      PLATFORM                      VARCHAR,
      SDK_VERSION                   VARCHAR,
      SESSION_ID                    VARCHAR,
      SHIP_AIR_DEFENSE_LEVEL        NUMBER,
      SHIP_ANTI_AIR                 NUMBER,
      SHIP_BOMBER_LEVEL             NUMBER,
      SHIP_CAMOUFLAGE_ID            VARCHAR,
      SHIP_CAMOUFLAGE_NAME          VARCHAR,
      SHIP_CARRIER_AIR_GROUP        NUMBER,
      SHIP_CONCEALMENT              NUMBER,
      SHIP_CONSUMABLE_1             VARCHAR,
      SHIP_CONSUMABLE_2             VARCHAR,
      SHIP_DEFENSE_LEVEL            NUMBER,
      SHIP_ELITE                    BOOLEAN,
      SHIP_ELITE_ATTRIBUTE_ID       VARCHAR,
      SHIP_ELITE_ATTRIBUTE_NAME     VARCHAR,
      SHIP_EQUIPMENT_1              VARCHAR,
      SHIP_EQUIPMENT_2              VARCHAR,
      SHIP_EQUIPMENT_3              VARCHAR,
      SHIP_FIGHTERS_LEVEL           NUMBER,
      SHIP_FIRE_CONTROL_LEVEL       NUMBER,
      SHIP_GUNS                     NUMBER,
      SHIP_HULL_LEVEL               NUMBER,
      SHIP_ID                       VARCHAR,
      SHIP_MAIN_GUNS_LEVEL          NUMBER,
      SHIP_MOBILITY                 NUMBER,
      SHIP_NAME                     VARCHAR,
      SHIP_NATION                   VARCHAR,
      SHIP_PREMIUM                  BOOLEAN,
      SHIP_SECONDARY_GUNS_LEVEL     NUMBER,
      SHIP_SKILL_NAME               VARCHAR,
      SHIP_SUPPLY_1                 VARCHAR,
      SHIP_SUPPLY_2                 VARCHAR,
      SHIP_SUPPLY_3                 VARCHAR,
      SHIP_SURVIVABILITY            NUMBER,
      SHIP_TIER                     NUMBER,
      SHIP_TORPEDO                  NUMBER,
      SHIP_TORPEDOBOMBERS_LEVEL     NUMBER,
      SHIP_TORPEDOES_LEVEL          NUMBER,
      SHIP_TYPE                     VARCHAR,
      USER_ID                       VARCHAR,
      USER_IS_PREMIUM               BOOLEAN,
      USER_IS_SPENDER               BOOLEAN,
      USER_LEVEL                    NUMBER,
      USER_LTV                      NUMBER,
      USER_SCORE                    NUMBER,
      USER_SERVER                   VARCHAR,
      USER_XP                       NUMBER,
      SHIP_TORPEDO_BOMBERS_LEVEL    NUMBER,
      SHIP_HULL__LEVEL              NUMBER,
      SHIP_EQUIPMENT_1_1            NUMBER,
      SHIP_EQUIPMENT_2_1            NUMBER,
      USER_SERVER_1                 NUMBER,
      SHIP_EQUIPMENT_3_1            NUMBER,
      SERVER_VERSION                VARCHAR,
      USER_REGION                   VARCHAR,
      SHIP_SKILL1_NAME              VARCHAR,
      USER_TYPE                     VARCHAR,
      USER_GEO                      VARCHAR,
      SHIP_SKILL2_NAME              VARCHAR,
      CLIENT_VERSION                VARCHAR,
      PLAYER_TYPE                   VARCHAR,
      SHIP_BOOST_1                  VARCHAR,
      SHIP_BOOST_2                  VARCHAR,
      USER_CLAN_ID                  VARCHAR,
      RANKED_DEVISION               VARCHAR,
      RANKED_SEASON_ID              VARCHAR,
      USER_INGAME_ID                VARCHAR,
      SHIP_SKILL3_NAME              VARCHAR,
      TITLE_USED                    VARCHAR,
      USER_CLAN_LEVEL               NUMBER,
      PORTRAIT_NAME                 VARCHAR,
      CHALLENGE_ID_3                VARCHAR,
      SHIP_LIMITED                  NUMBER,
      CHALLENGE_ID_1                VARCHAR,
      CHALLENGE_ID_2                VARCHAR,
      TEAM_ID                       VARCHAR,
      STORE                         VARCHAR
  );