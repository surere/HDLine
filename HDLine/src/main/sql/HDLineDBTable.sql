
/* Drop Triggers */

DROP TRIGGER TRI_DesginerAppealBoard_DABno;
DROP TRIGGER TRI_favorite_favoNO;
DROP TRIGGER TRI_FreeBoard_Freeno;
DROP TRIGGER TRI_Members_no;
DROP TRIGGER TRI_Messenger_Messengerno;
DROP TRIGGER TRI_ModelAppealBoard_MABno;



/* Drop Tables */

DROP TABLE favorite CASCADE CONSTRAINTS;
DROP TABLE DesginerAppealBoard CASCADE CONSTRAINTS;
DROP TABLE FreeBoard CASCADE CONSTRAINTS;
DROP TABLE Messenger CASCADE CONSTRAINTS;
DROP TABLE ModelAppealBoard CASCADE CONSTRAINTS;
DROP TABLE Members CASCADE CONSTRAINTS;
DROP TABLE regions CASCADE CONSTRAINTS;



/* Drop Sequences */

DROP SEQUENCE SEQ_DesginerAppealBoard_DABno;
DROP SEQUENCE SEQ_favorite_favoNO;
DROP SEQUENCE SEQ_FreeBoard_Freeno;
DROP SEQUENCE SEQ_Members_no;
DROP SEQUENCE SEQ_Messenger_Messengerno;
DROP SEQUENCE SEQ_ModelAppealBoard_MABno;




/* Create Sequences */

CREATE SEQUENCE SEQ_DesginerAppealBoard_DABno INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_favorite_favoNO INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_FreeBoard_Freeno INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_Members_no INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_Messenger_Messengerno INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_ModelAppealBoard_MABno INCREMENT BY 1 START WITH 1;



/* Create Tables */

CREATE TABLE DesginerAppealBoard
(
	DABno number NOT NULL,
	-- 회원번호
	no number NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(500),
	-- 지역
	region varchar2(40) NOT NULL,
	currentPhoto varchar2(100),
	PRIMARY KEY (DABno)
);


CREATE TABLE favorite
(
	favoNO number NOT NULL,
	-- 회원번호
	no number NOT NULL,
	MABno number,
	DABno number,
	PRIMARY KEY (favoNO)
);


CREATE TABLE FreeBoard
(
	Freeno number NOT NULL,
	-- 회원번호
	no number NOT NULL,
	title varchar2(200) NOT NULL,
	content varchar2(1000) NOT NULL,
	photo varchar2(500),
	PRIMARY KEY (Freeno)
);


CREATE TABLE Members
(
	-- 회원번호
	no number NOT NULL,
	-- 회원 아이디(unique)
	ID varchar2(20) DEFAULT '' NOT NULL UNIQUE,
	-- 암호
	password varchar2(100) NOT NULL,
	phoneNumber varchar2(20),
	-- 주소1
	Adress1 varchar2(120),
	-- 상세주소
	adress2 varchar2(100),
	-- 모델,디자이너,관리자 분류
	classify varchar2(20) NOT NULL,
	profileImage varchar2(200),
	-- 간단한 자기소개(프로필)
	introduction varchar2(600),
	-- 인스타,페북,블로그 등
	LinkUrl varchar2(300),
	-- 지역
	region varchar2(40) NOT NULL,
	PRIMARY KEY (no)
);


CREATE TABLE Messenger
(
	Messengerno number NOT NULL,
	-- 발신자 회원번호
	senderNO number NOT NULL,
	-- 수신자회원번호
	ReciverNO number NOT NULL,
	title varchar2(300),
	content varchar2(500) NOT NULL,
	-- 읽음확인  true or false
	readValue varchar2(10),
	PRIMARY KEY (Messengerno)
);


CREATE TABLE ModelAppealBoard
(
	MABno number NOT NULL,
	-- 회원번호
	no number NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(500),
	-- 지역
	region varchar2(40) NOT NULL,
	currentPhoto varchar2(100),
	PRIMARY KEY (MABno)
);


CREATE TABLE regions
(
	-- 지역
	region varchar2(40) NOT NULL,
	PRIMARY KEY (region)
);



/* Create Foreign Keys */

ALTER TABLE favorite
	ADD FOREIGN KEY (DABno)
	REFERENCES DesginerAppealBoard (DABno)
;


ALTER TABLE DesginerAppealBoard
	ADD FOREIGN KEY (no)
	REFERENCES Members (no)
;


ALTER TABLE favorite
	ADD FOREIGN KEY (no)
	REFERENCES Members (no)
;


ALTER TABLE FreeBoard
	ADD FOREIGN KEY (no)
	REFERENCES Members (no)
;


ALTER TABLE Messenger
	ADD FOREIGN KEY (senderNO)
	REFERENCES Members (no)
;


ALTER TABLE Messenger
	ADD FOREIGN KEY (ReciverNO)
	REFERENCES Members (no)
;


ALTER TABLE ModelAppealBoard
	ADD FOREIGN KEY (no)
	REFERENCES Members (no)
;


ALTER TABLE favorite
	ADD FOREIGN KEY (MABno)
	REFERENCES ModelAppealBoard (MABno)
;


ALTER TABLE DesginerAppealBoard
	ADD FOREIGN KEY (region)
	REFERENCES regions (region)
;


ALTER TABLE Members
	ADD FOREIGN KEY (region)
	REFERENCES regions (region)
;


ALTER TABLE ModelAppealBoard
	ADD FOREIGN KEY (region)
	REFERENCES regions (region)
;



/* Create Triggers */

CREATE OR REPLACE TRIGGER TRI_DesginerAppealBoard_DABno BEFORE INSERT ON DesginerAppealBoard
FOR EACH ROW
BEGIN
	SELECT SEQ_DesginerAppealBoard_DABno.nextval
	INTO :new.DABno
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_favorite_favoNO BEFORE INSERT ON favorite
FOR EACH ROW
BEGIN
	SELECT SEQ_favorite_favoNO.nextval
	INTO :new.favoNO
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_FreeBoard_Freeno BEFORE INSERT ON FreeBoard
FOR EACH ROW
BEGIN
	SELECT SEQ_FreeBoard_Freeno.nextval
	INTO :new.Freeno
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_Members_no BEFORE INSERT ON Members
FOR EACH ROW
BEGIN
	SELECT SEQ_Members_no.nextval
	INTO :new.no
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_Messenger_Messengerno BEFORE INSERT ON Messenger
FOR EACH ROW
BEGIN
	SELECT SEQ_Messenger_Messengerno.nextval
	INTO :new.Messengerno
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_ModelAppealBoard_MABno BEFORE INSERT ON ModelAppealBoard
FOR EACH ROW
BEGIN
	SELECT SEQ_ModelAppealBoard_MABno.nextval
	INTO :new.MABno
	FROM dual;
END;

/




/* Comments */

COMMENT ON COLUMN DesginerAppealBoard.no IS '회원번호';
COMMENT ON COLUMN DesginerAppealBoard.region IS '지역';
COMMENT ON COLUMN favorite.no IS '회원번호';
COMMENT ON COLUMN FreeBoard.no IS '회원번호';
COMMENT ON COLUMN Members.no IS '회원번호';
COMMENT ON COLUMN Members.ID IS '회원 아이디(unique)';
COMMENT ON COLUMN Members.password IS '암호';
COMMENT ON COLUMN Members.Adress1 IS '주소1';
COMMENT ON COLUMN Members.adress2 IS '상세주소';
COMMENT ON COLUMN Members.classify IS '모델,디자이너,관리자 분류';
COMMENT ON COLUMN Members.introduction IS '간단한 자기소개(프로필)';
COMMENT ON COLUMN Members.LinkUrl IS '인스타,페북,블로그 등';
COMMENT ON COLUMN Members.region IS '지역';
COMMENT ON COLUMN Messenger.senderNO IS '발신자 회원번호';
COMMENT ON COLUMN Messenger.ReciverNO IS '수신자회원번호';
COMMENT ON COLUMN Messenger.readValue IS '읽음확인  true or false';
COMMENT ON COLUMN ModelAppealBoard.no IS '회원번호';
COMMENT ON COLUMN ModelAppealBoard.region IS '지역';
COMMENT ON COLUMN regions.region IS '지역';



