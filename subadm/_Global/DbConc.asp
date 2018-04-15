
CREATE TABLE A1A1
(
  A0  INT,
  A1  NVARCHAR(1000),
  A2  NVARCHAR(1000),
  A3  NVARCHAR(1000),
  A4  NVARCHAR(1000),
  A5  NVARCHAR(1000),
  A6  NVARCHAR(MAX),
  A8  NVARCHAR(1000),
  A9  NVARCHAR(1000),
  A7  NVARCHAR(MAX)
)
TABLESPACE parao24
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
LOB (A6) STORE AS 
      ( TABLESPACE  parao24 
        ENABLE      STORAGE IN ROW
        CHUNK       8192
        PCTVERSION  10
        NOCACHE
        STORAGE    (
                    INITIAL          64K
                    MINEXTENTS       1
                    MAXEXTENTS       2147483645
                    PCTINCREASE      0
                    FREELISTS        1
                    FREELIST GROUPS  1
                    BUFFER_POOL      DEFAULT
                   )
      )
  LOB (A7) STORE AS 
      ( TABLESPACE  parao24 
        ENABLE      STORAGE IN ROW
        CHUNK       8192
        PCTVERSION  10
        NOCACHE
        STORAGE    (
                    INITIAL          64K
                    MINEXTENTS       1
                    MAXEXTENTS       2147483645
                    PCTINCREASE      0
                    FREELISTS        1
                    FREELIST GROUPS  1
                    BUFFER_POOL      DEFAULT
                   )
      )
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE BLOCK_IP
(
  SEQ        INT                             NOT NULL,
  BLOCKIP    NVARCHAR(20),
  BLOCKDATE  DATE
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE BOARD_ANALYSIS
(
  BA_IDX       INT                           NOT NULL,
  BA_TITLE     NVARCHAR(100),
  BA_CONTENTS  NVARCHAR(MAX),
  BA_WRITER    NVARCHAR(20),
  BA_PW        NVARCHAR(12),
  BA_HITS      INT                           DEFAULT 0                     NOT NULL,
  BA_REGDATE  DATETIME                            DEFAULT (getdate())                NOT NULL,
  BA_STATUS    INT                           DEFAULT 1                     NOT NULL
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE BOARD_ANALYSIS_REPLY
(
  BAR_IDX       INT                          NOT NULL,
  BA_IDX        INT                          NOT NULL,
  BAR_CONTENTS  NVARCHAR(2000)             NOT NULL,
  BAR_WRITER    NVARCHAR(20)               NOT NULL,
  BAR_REGDATE  DATETIME                           DEFAULT (getdate())                NOT NULL
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE BOARD_CUSTOMER
(
  BC_IDX       INT               IDENTITY(1,1)            NOT NULL,
  BC_WRITER    NVARCHAR(20)                NOT NULL,
  BC_ID        NVARCHAR(12),
  BC_TITLE     NVARCHAR(100)               NOT NULL,
  BC_CONTENTS  NVARCHAR(MAX),
  BC_REGDATE  DATETIME                            DEFAULT (getdate())                NOT NULL,
  BC_STATUS    INT                           DEFAULT 1                     NOT NULL,
  BC_REPLY     INT                           DEFAULT 0                     NOT NULL,
  BC_READ      INT                           DEFAULT 0                     NOT NULL,
  BC_SITE      NVARCHAR(20)                DEFAULT 'Eproto'              NOT NULL,
  BC_MANAGER   NVARCHAR(20),
  BC_READYN    INT                           DEFAULT 0,
  BC_DELYN     INT                           DEFAULT 0
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE BOARD_CUSTOMER_REPLY
(
  BCR_IDX       INT       IDENTITY(1,1)                    NOT NULL,
  BCR_REFNUM    INT                          NOT NULL,
  BCR_CONTENTS  NVARCHAR(MAX)             NOT NULL
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE BOARD_FREE
(
  BF_IDX       INT            IDENTITY(1,1)                NOT NULL,
  BF_TITLE     NVARCHAR(1000),
  BF_CONTENTS  NVARCHAR(MAX),
  BF_WRITER    NVARCHAR(20),
  BF_PW        NVARCHAR(12),
  BF_HITS      INT                           DEFAULT 0                     NOT NULL,
  BF_REGDATE  DATETIME                            DEFAULT (getdate())                NOT NULL,
  BF_STATUS    INT                           DEFAULT 1                     NOT NULL,
  BF_REPLYCNT  INT                           DEFAULT 0                     NOT NULL,
  BF_LEVEL     INT                           DEFAULT 0                     NOT NULL,
  BF_SITE      NVARCHAR(20)                DEFAULT 'Eproto'              NOT NULL,
  XLS_NUM      INT,
  BF_TYPE      INT                           DEFAULT 1
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
LOB (BF_CONTENTS) STORE AS 
      ( TABLESPACE  TOTO 
        ENABLE      STORAGE IN ROW
        CHUNK       8192
        PCTVERSION  10
        NOCACHE
        STORAGE    (
                    INITIAL          64K
                    MINEXTENTS       1
                    MAXEXTENTS       2147483645
                    PCTINCREASE      0
                    FREELISTS        1
                    FREELIST GROUPS  1
                    BUFFER_POOL      DEFAULT
                   )
      )
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE BOARD_FREE_ALPHA
(
  BF_IDX       INT                           NOT NULL,
  BF_TITLE     NVARCHAR(1000),
  BF_CONTENTS  NVARCHAR(MAX),
  BF_WRITER    NVARCHAR(20),
  BF_PW        NVARCHAR(12),
  BF_HITS      INT                           NOT NULL,
  BF_REGDATE  DATETIME                            NOT NULL,
  BF_STATUS    INT                           NOT NULL,
  BF_REPLYCNT  INT                           NOT NULL,
  BF_LEVEL     INT                           NOT NULL,
  BF_SITE      NVARCHAR(20)                NOT NULL,
  XLS_NUM      INT,
  BF_TYPE      INT
)
TABLESPACE parao24
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
LOB (BF_CONTENTS) STORE AS 
      ( TABLESPACE  parao24 
        ENABLE      STORAGE IN ROW
        CHUNK       8192
        PCTVERSION  10
        NOCACHE
        STORAGE    (
                    INITIAL          64K
                    MINEXTENTS       1
                    MAXEXTENTS       2147483645
                    PCTINCREASE      0
                    FREELISTS        1
                    FREELIST GROUPS  1
                    BUFFER_POOL      DEFAULT
                   )
      )
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE BOARD_FREE_REPLY
(
  BFR_IDX       INT                          NOT NULL,
  BF_IDX        INT                          NOT NULL,
  BFR_CONTENTS  NVARCHAR(MAX)             NOT NULL,
  BFR_WRITER    NVARCHAR(20)               NOT NULL,
  BFR_REGDATE  DATETIME                           DEFAULT (getdate())                NOT NULL,
  XLS_NUM       INT
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE BOARD_FREE_REPLY_ALPHA
(
  BFR_IDX       INT   IDENTITY(1,1)                       NOT NULL,
  BF_IDX        INT                          NOT NULL,
  BFR_CONTENTS  NVARCHAR(MAX)             NOT NULL,
  BFR_WRITER    NVARCHAR(20)               NOT NULL,
  BFR_REGDATE  DATETIME                           NOT NULL,
  XLS_NUM       INT
)
TABLESPACE parao24
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE BOARD_GATE
(
  BF_IDX       INT        IDENTITY(1,1)                    NOT NULL,
  BF_TITLE     NVARCHAR(1000),
  BF_CONTENTS  NVARCHAR(MAX),
  BF_WRITER    NVARCHAR(20),
  BF_PW        NVARCHAR(12),
  BF_HITS      INT                           DEFAULT 0                     NOT NULL,
  BF_REGDATE  DATETIME                            DEFAULT (getdate())                NOT NULL,
  BF_STATUS    INT                           DEFAULT 1                     NOT NULL,
  BF_REPLYCNT  INT                           DEFAULT 0                     NOT NULL,
  BF_LEVEL     INT                           DEFAULT 0                     NOT NULL,
  BF_SITE      NVARCHAR(20)                DEFAULT 'Eproto'              NOT NULL,
  XLS_NUM      INT,
  BF_TYPE      INT                           DEFAULT 1,
  BF_IP        NVARCHAR(20)
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
LOB (BF_CONTENTS) STORE AS 
      ( TABLESPACE  TOTO 
        ENABLE      STORAGE IN ROW
        CHUNK       8192
        PCTVERSION  10
        NOCACHE
        STORAGE    (
                    INITIAL          64K
                    MINEXTENTS       1
                    MAXEXTENTS       2147483645
                    PCTINCREASE      0
                    FREELISTS        1
                    FREELIST GROUPS  1
                    BUFFER_POOL      DEFAULT
                   )
      )
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE BOARD_GATE_REPLY
(
  BFR_IDX       INT        IDENTITY(1,1)                    NOT NULL,
  BF_IDX        INT                          NOT NULL,
  BFR_CONTENTS  NVARCHAR(MAX)             NOT NULL,
  BFR_WRITER    NVARCHAR(20)               NOT NULL,
  BFR_REGDATE  DATETIME                           DEFAULT (getdate())                NOT NULL,
  XLS_NUM       INT
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE BOARD_HIT
(
  PRODATE  DATE
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE CHECK_IP
(
  CI_IDX     INT       IDENTITY(1,1)                       NOT NULL,
  CI_IP      NVARCHAR(15)                  NOT NULL,
  CI_STATUS  INT                             DEFAULT 0                     NOT NULL,
  CI_SITE    NVARCHAR(20)                  DEFAULT 'Eproto'              NOT NULL
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE CHK_ADMIN
(
  SEQ      INT                               NOT NULL,
  AD_IP    NVARCHAR(20),
  AD_DATE  DATE,
  AD_ID    NVARCHAR(20)                    NOT NULL,
  AD_SITE  NVARCHAR(20)
)
TABLESPACE parao24
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE G_PHONE_CK
(
  GPC_IDX    INT,
  GPC_PHONE  NVARCHAR(100),
  GPC_ID     NVARCHAR(20),
  GPC_SITE   NVARCHAR(20),
  GPC_YN     INT                             DEFAULT 1
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE INFO_ADMIN
(
  IA_ID         NVARCHAR(20)               NOT NULL,
  IA_PW         NVARCHAR(20)               NOT NULL,
  IA_BANKNAME   NVARCHAR(20),
  IA_BANKNUM    NVARCHAR(50),
  IA_BANKOWNER  NVARCHAR(20),
  IA_EMAIL      NVARCHAR(50),
  IA_LEVEL      INT                          DEFAULT 0                     NOT NULL,
  IA_STATUS     INT                          DEFAULT 1                     NOT NULL,
  IA_SITE       NVARCHAR(20)
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE INFO_BETTING
(
  IB_IDX      INT                            NOT NULL,
  IB_ID       NVARCHAR(12)                 NOT NULL,
  IB_TYPE     CHAR(1)                      NOT NULL,
  IG_IDX      NVARCHAR(200)                NOT NULL,
  IB_NUM      NVARCHAR(50)                 NOT NULL,
  IB_BENEFIT  NVARCHAR(100)                NOT NULL,
  IB_AMOUNT   FLOAT                        NOT NULL,
  IB_STATUS   INT                            DEFAULT 0                     NOT NULL,
  IB_REGDATE DATETIME                             DEFAULT (getdate())                NOT NULL,
  IB_SITE     NVARCHAR(20)                 DEFAULT 'Eproto'              NOT NULL,
  IB_DEL      NVARCHAR(20)                 DEFAULT 'N'
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE INFO_CART
(
  ICT_IDX       INT                          NOT NULL,
  ICT_ID        NVARCHAR(12)               NOT NULL,
  ICT_GAMENUM   INT                          NOT NULL,
  ICT_GAMEMEMO  NVARCHAR(100)              NOT NULL,
  ICT_BETNUM    INT                          NOT NULL,
  ICT_GTYPE     NVARCHAR(10),
  ICT_SITE      NVARCHAR(20)               DEFAULT 'Eproto'              NOT NULL,
  ICT_SP        CHAR(10)                   DEFAULT 'N'
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE INFO_CHARGE
(
  IC_IDX      INT                            NOT NULL,
  IC_ID       NVARCHAR(12)                 NOT NULL,
  IC_NAME     NVARCHAR(20)                 NOT NULL,
  IC_AMOUNT   FLOAT                        DEFAULT 0                     NOT NULL,
  IC_REGDATE DATETIME                             DEFAULT (getdate())                NOT NULL,
  IC_SETDATE  DATE,
  IC_STATUS   INT                            DEFAULT 0                     NOT NULL,
  IC_SITE     NVARCHAR(20)                 DEFAULT 'Eproto'              NOT NULL,
  IC_KIND     NVARCHAR(20),
  IC_EVENT    NVARCHAR(20)                 DEFAULT 'N',
  IC_T_MONEY  FLOAT                        DEFAULT 0,
  IC_T_YN     NVARCHAR(20)                 DEFAULT 'N'
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE INFO_EXCHANGE
(
  IE_IDX       INT                           NOT NULL,
  IE_ID        NVARCHAR(12)                NOT NULL,
  IE_NICKNAME  NVARCHAR(20)                NOT NULL,
  IE_AMOUNT    FLOAT                       NOT NULL,
  IE_REGDATE  DATETIME                            DEFAULT (getdate())                NOT NULL,
  IE_SETDATE   DATE,
  IE_STATUS    INT                           DEFAULT 0                     NOT NULL,
  IE_SITE      NVARCHAR(20)                DEFAULT 'Eproto'              NOT NULL,
  IE_KIND      NVARCHAR(20)
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE INFO_GAME
(
  IG_IDX           INT                       NOT NULL,
  RL_IDX           INT                       NOT NULL,
  RL_SPORTS        NVARCHAR(20),
  RL_LEAGUE        NVARCHAR(50),
  RL_IMAGE         NVARCHAR(50),
  IG_STARTTIME     DATE,
  IG_TEAM1         NVARCHAR(50)            NOT NULL,
  IG_TEAM2         NVARCHAR(50)            NOT NULL,
  IG_HANDICAP      FLOAT                   DEFAULT 0                     NOT NULL,
  IG_TEAM1BENEFIT  FLOAT                   DEFAULT 0                     NOT NULL,
  IG_DRAWBENEFIT   FLOAT                   DEFAULT 0                     NOT NULL,
  IG_TEAM2BENEFIT  FLOAT                   DEFAULT 0                     NOT NULL,
  IG_TEAM1BETTING  FLOAT                   DEFAULT 0                     NOT NULL,
  IG_DRAWBETTING   FLOAT                   DEFAULT 0                     NOT NULL,
  IG_TEAM2BETTING  FLOAT                   DEFAULT 0                     NOT NULL,
  IG_SCORE1        INT                       DEFAULT 0                     NOT NULL,
  IG_SCORE2        INT                       DEFAULT 0                     NOT NULL,
  IG_RESULT        CHAR(10),
  IG_STATUS        CHAR(1)                 DEFAULT 'R'                   NOT NULL,
  IG_TYPE          CHAR(1)                 DEFAULT '0'                   NOT NULL,
  IG_VSPOINT       INT                       DEFAULT 0                     NOT NULL,
  IG_MEMO          NVARCHAR(MAX),
  IG_SITE          NVARCHAR(20)            DEFAULT 'All'                 NOT NULL,
  IG_LIMIT         INT,
  IG_SP            NVARCHAR(4)             DEFAULT 'N'
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE INFO_USER
(
  IU_IDX        INT                          NOT NULL,
  IU_LEVEL      INT                          DEFAULT 1                     NOT NULL,
  IU_ID         NVARCHAR(12)               NOT NULL,
  IU_PW         NVARCHAR(20)               NOT NULL,
  IU_NICKNAME   NVARCHAR(20)               NOT NULL,
  IU_CASH       FLOAT                      DEFAULT 0                     NOT NULL,
  IU_MOBILE     NVARCHAR(13),
  IU_EMAIL      NVARCHAR(50),
  IU_BANKNAME   NVARCHAR(20),
  IU_BANKNUM    NVARCHAR(30),
  IU_BANKOWNER  NVARCHAR(20),
  IU_REGDATE   DATETIME                           DEFAULT (getdate())                NOT NULL,
  IU_STATUS     INT                          DEFAULT 1                     NOT NULL,
  IU_SITE       NVARCHAR(20)               DEFAULT 'Truepo'              NOT NULL,
  IU_GRADE      INT                          DEFAULT 1,
  IU_PWCK       INT                          DEFAULT 2,
  IU_SMSCK      INT                          DEFAULT 1,
  IU_T_MONEY    FLOAT                      DEFAULT 0,
  RECOM_ID      NVARCHAR(12),
  RECOM_NUM     INT                          DEFAULT 0,
  IU_CODES      NVARCHAR(20)
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE INFO_USER_CODE
(
  IU_ID    NVARCHAR(20)                    NOT NULL,
  IU_SITE  NVARCHAR(20),
  IU_CODE  NVARCHAR(20)                    NOT NULL
)
TABLESPACE parao24
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE INFO_USER_IN_CHECK
(
  IUIC_IDX       INT,
  IUIC_YN        NVARCHAR(10),
  IUIC_REGDATE  DATETIME                          DEFAULT (getdate()) ,
  IUIC_ID        NVARCHAR(20),
  IUIC_NICKNAME  NVARCHAR(40),
  IUIC_SITE      NVARCHAR(20)
)
TABLESPACE parao24
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE INQ_BOARD
(
  INQ_SEQ      INT                           NOT NULL,
  INQ_NAME     NVARCHAR(20)                NOT NULL,
  INQ_TITLE    NVARCHAR(1000)              NOT NULL,
  INQ_DATE     DATE,
  INQ_CONTENT  NVARCHAR(MAX)                             NOT NULL,
  INQ_PWD      NVARCHAR(12)                NOT NULL,
  INQ_SITE     NVARCHAR(20),
  INQ_REPLY    INT                           DEFAULT 0                     NOT NULL
)
TABLESPACE parao24
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
LOB (INQ_CONTENT) STORE AS 
      ( TABLESPACE  parao24 
        ENABLE      STORAGE IN ROW
        CHUNK       8192
        PCTVERSION  10
        NOCACHE
        STORAGE    (
                    INITIAL          64K
                    MINEXTENTS       1
                    MAXEXTENTS       2147483645
                    PCTINCREASE      0
                    FREELISTS        1
                    FREELIST GROUPS  1
                    BUFFER_POOL      DEFAULT
                   )
      )
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE LOG_CASHINOUT
(
  LC_IDX       INT                           NOT NULL,
  LC_ID        NVARCHAR(12)                NOT NULL,
  LC_CASH      FLOAT                       DEFAULT 0                     NOT NULL,
  LC_GCASH     FLOAT                       DEFAULT 0                     NOT NULL,
  LC_CONTENTS  NVARCHAR(20)                NOT NULL,
  LC_REGDATE  DATETIME                            DEFAULT (getdate())                NOT NULL,
  LC_SITE      NVARCHAR(20)                DEFAULT 'Eproto'              NOT NULL
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE LOG_LOGIN
(
  LL_IDX       INT                           NOT NULL,
  LL_ID        NVARCHAR(12)                NOT NULL,
  LL_NICKNAME  NVARCHAR(20)                NOT NULL,
  LL_IP        NVARCHAR(15),
  LL_REGDATE  DATETIME                            DEFAULT (getdate())                NOT NULL,
  LL_SITE      NVARCHAR(20)                DEFAULT 'Eproto'              NOT NULL
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE POPOP02
(
  P_IDX       INT,
  P_SUB       NVARCHAR(1000),
  P_CONTENTS  NVARCHAR(MAX),
  P_WIDTH     NVARCHAR(200),
  P_HEIGHT    NVARCHAR(200),
  P_TOP       NVARCHAR(200),
  P_LEFT      NVARCHAR(200),
  P_SITE      NVARCHAR(200),
  P_YN        NVARCHAR(10)
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE POPUP
(
  FILENAME   NVARCHAR(50),
  FILESIZEX  INT,
  FILESIZEY  INT,
  MAP1       INT,
  MAP2       INT,
  STATUS     INT                             DEFAULT 0                     NOT NULL,
  PSITE      NVARCHAR(20)                  DEFAULT 'Eproto'              NOT NULL
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE REALTIME_LOG
(
  IU_ID    NVARCHAR(20),
  REGDATE  DATE,
  SITE     NVARCHAR(20)
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE REF_LEAGUE
(
  RL_IDX     INT                             NOT NULL,
  RL_SPORTS  NVARCHAR(20),
  RL_LEAGUE  NVARCHAR(50),
  RL_IMAGE   NVARCHAR(50),
  RL_STATUS  INT                             DEFAULT 1                     NOT NULL,
  RL_CODE    NVARCHAR(30)
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE REF_SPORTS
(
  RS_IDX     INT                             NOT NULL,
  RS_SPORTS  NVARCHAR(20)                  NOT NULL,
  RS_ICON    NVARCHAR(50),
  RS_STATUS  INT                             DEFAULT 1                     NOT NULL
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE SET_BETTING
(
  SB_IDX           INT                       NOT NULL,
  SB_SITE          NVARCHAR(20),
  SB_BETTINGMIN    FLOAT,
  SB_BETTINGMAX01  FLOAT,
  SB_BENEFITMAX01  FLOAT,
  SB_BETTINGMAX02  FLOAT,
  SB_BENEFITMAX02  FLOAT
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE SET_SITE
(
  SEQ     INT,
  SITE01  NVARCHAR(20),
  SITE02  NVARCHAR(50),
  SITE03  NVARCHAR(50),
  SITE04  NVARCHAR(20),
  SITE05  NVARCHAR(30),
  SITE06  NVARCHAR(150)
)
TABLESPACE TOTO
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE INDEX BOARD_FREE_INDEX ON BOARD_FREE
(BF_TITLE, BF_WRITER, BF_PW, BF_HITS, BF_REGDATE, 
BF_STATUS, BF_REPLYCNT, BF_LEVEL, BF_SITE, XLS_NUM, 
BF_TYPE)
LOGGING
TABLESPACE parao24
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE INDEX G_PHONE_CK_INDEX ON G_PHONE_CK
(GPC_PHONE, GPC_ID, GPC_SITE, GPC_YN)
LOGGING
TABLESPACE TOTO
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE INDEX INFO_BETTING_INDEX ON INFO_BETTING
(IB_ID, IB_TYPE, IG_IDX, IB_NUM, IB_BENEFIT, 
IB_AMOUNT, IB_STATUS, IB_REGDATE, IB_SITE, IB_DEL)
LOGGING
TABLESPACE parao24
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE INDEX INFO_GAME_INDEX1 ON INFO_GAME
(IG_STATUS, IG_TYPE, IG_SITE, IG_STARTTIME)
LOGGING
TABLESPACE parao24
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE INDEX INFO_GAME_INDEX ON INFO_GAME
(IG_IDX, RL_IDX, RL_SPORTS, RL_LEAGUE, RL_IMAGE, 
IG_STARTTIME, IG_TEAM1, IG_TEAM2, IG_HANDICAP, IG_TEAM1BENEFIT, 
IG_DRAWBENEFIT, IG_TEAM2BENEFIT, IG_TEAM1BETTING, IG_DRAWBETTING, IG_TEAM2BETTING, 
IG_SCORE1, IG_SCORE2, IG_RESULT, IG_STATUS, IG_TYPE, 
IG_VSPOINT, IG_MEMO, IG_SITE, IG_LIMIT, IG_SP)
LOGGING
TABLESPACE TOTO
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE INDEX INFO_USER_INDEX ON INFO_USER
(IU_IDX, IU_LEVEL, IU_ID, IU_PW, IU_NICKNAME, 
IU_CASH, IU_MOBILE, IU_EMAIL, IU_BANKNAME, IU_BANKNUM, 
IU_BANKOWNER, IU_REGDATE, IU_STATUS, IU_SITE, IU_GRADE, 
IU_PWCK, IU_SMSCK, IU_T_MONEY)
LOGGING
TABLESPACE TOTO
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


ALTER TABLE BOARD_FREE ADD (
  PRIMARY KEY
 (BF_IDX)
    USING INDEX 
    TABLESPACE parao24
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                MINEXTENTS       1
                MAXEXTENTS       2147483645
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
               ));


ALTER TABLE G_PHONE_CK ADD (
  PRIMARY KEY
 (GPC_IDX)
    USING INDEX 
    TABLESPACE TOTO
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                MINEXTENTS       1
                MAXEXTENTS       2147483645
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
               ));


ALTER TABLE INFO_BETTING ADD (
  PRIMARY KEY
 (IB_IDX)
    USING INDEX 
    TABLESPACE parao24
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                MINEXTENTS       1
                MAXEXTENTS       2147483645
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
               ));



