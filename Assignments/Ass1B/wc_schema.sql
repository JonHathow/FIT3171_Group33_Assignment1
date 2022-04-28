-- Generated by Oracle SQL Developer Data Modeler 21.4.1.349.1605
--   at:        2022-04-28 12:41:46 SGT
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g
--   group number: Group 33
--   group members: How Yu Chern, Marcus Zheng Fung Mah , Kang Zhuang Wong  

-- Capture run of script in file called wc_schema_output.txt
set echo on
SPOOL  wc_schema_output.txt


DROP TABLE address CASCADE CONSTRAINTS;

DROP TABLE cabin CASCADE CONSTRAINTS;

DROP TABLE country CASCADE CONSTRAINTS;

DROP TABLE cruise CASCADE CONSTRAINTS;

DROP TABLE cruise_port CASCADE CONSTRAINTS;

DROP TABLE language CASCADE CONSTRAINTS;

DROP TABLE manifest CASCADE CONSTRAINTS;

DROP TABLE operator CASCADE CONSTRAINTS;

DROP TABLE passenger CASCADE CONSTRAINTS;

DROP TABLE port CASCADE CONSTRAINTS;

DROP TABLE port_temp CASCADE CONSTRAINTS;

DROP TABLE ship CASCADE CONSTRAINTS;

DROP TABLE tour CASCADE CONSTRAINTS;

DROP TABLE tour_language CASCADE CONSTRAINTS;

DROP TABLE tour_participant CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE address (
    address_id       NUMBER(7) NOT NULL,
    address_street   VARCHAR2(20) NOT NULL,
    address_town     VARCHAR2(20) NOT NULL,
    address_postcode VARCHAR2(10) NOT NULL,
    address_country  VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN address.address_id IS
    'surrogate key for address table';

COMMENT ON COLUMN address.address_street IS
    'address street name';

COMMENT ON COLUMN address.address_town IS
    'address town name';

COMMENT ON COLUMN address.address_postcode IS
    'address postcode';

COMMENT ON COLUMN address.address_country IS
    'address country';

ALTER TABLE address ADD CONSTRAINT address_pk PRIMARY KEY ( address_id );

ALTER TABLE address
    ADD CONSTRAINT address_nk UNIQUE ( address_street,
                                       address_town,
                                       address_postcode,
                                       address_country );

CREATE TABLE cabin (
    cabin_number   VARCHAR2(5) NOT NULL,
    ship_code      NUMBER(7) NOT NULL,
    cabin_capacity NUMBER(2) NOT NULL,
    cabin_class    CHAR(1) NOT NULL
);

ALTER TABLE cabin
    ADD CONSTRAINT chk_cabin_class CHECK ( cabin_class IN ( 'B', 'I', 'O', 'S' ) );

COMMENT ON COLUMN cabin.cabin_number IS
    'the cabin''s number';

COMMENT ON COLUMN cabin.ship_code IS
    'the ship''s code';

COMMENT ON COLUMN cabin.cabin_capacity IS
    'the cabin''s capacity';

COMMENT ON COLUMN cabin.cabin_class IS
    'the cabin''s class (I=interior, O=ocean view, B= balcony, S=suite)';

ALTER TABLE cabin ADD CONSTRAINT cabin_pk PRIMARY KEY ( cabin_number,
                                                        ship_code );

CREATE TABLE country (
    country_code CHAR(2) NOT NULL,
    country_name VARCHAR2(20)
);

COMMENT ON COLUMN country.country_code IS
    'the country''s code following ISO 3166-1 Alpha-2 codes';

COMMENT ON COLUMN country.country_name IS
    'the country''s name';

ALTER TABLE country ADD CONSTRAINT country_pk PRIMARY KEY ( country_code );

CREATE TABLE cruise (
    cruise_id   NUMBER(7) NOT NULL,
    ship_code   NUMBER(7) NOT NULL,
    cruise_name VARCHAR2(20) NOT NULL,
    cruise_desc VARCHAR2(80) NOT NULL
);

COMMENT ON COLUMN cruise.cruise_id IS
    'the cruise''s ID';

COMMENT ON COLUMN cruise.ship_code IS
    'the ship''s code';

COMMENT ON COLUMN cruise.cruise_name IS
    'the cruise''s name';

COMMENT ON COLUMN cruise.cruise_desc IS
    'the cruise''s description';

ALTER TABLE cruise ADD CONSTRAINT cruise_pk PRIMARY KEY ( cruise_id );

CREATE TABLE cruise_port (
    cruise_port_datetime          DATE NOT NULL,
    cruise_id                     NUMBER(7) NOT NULL,
    port_code                     CHAR(5) NOT NULL,
    cruise_port_arrival_departure CHAR(1) NOT NULL
);

ALTER TABLE cruise_port
    ADD CONSTRAINT chk_arrival_departure CHECK ( cruise_port_arrival_departure IN ( 'A', 'D' ) );

COMMENT ON COLUMN cruise_port.cruise_port_datetime IS
    'the depature or arrival time of a cruise at a particular port';

COMMENT ON COLUMN cruise_port.cruise_id IS
    'the cruise''s ID';

COMMENT ON COLUMN cruise_port.port_code IS
    'the port''s code';

COMMENT ON COLUMN cruise_port.cruise_port_arrival_departure IS
    'identifier for the arrival datetime or departure datetime';

ALTER TABLE cruise_port ADD CONSTRAINT cruise_port_pk PRIMARY KEY ( cruise_port_datetime,
                                                                    cruise_id );

CREATE TABLE language (
    language_code CHAR(2) NOT NULL,
    language_name VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN language.language_code IS
    'language code following ISO 639-1 Alpha-2 codes';

COMMENT ON COLUMN language.language_name IS
    'language name';

ALTER TABLE language ADD CONSTRAINT language_pk PRIMARY KEY ( language_code );

CREATE TABLE manifest (
    manifest_id             NUMBER(7) NOT NULL,
    cruise_id               NUMBER(7) NOT NULL,
    passenger_id            NUMBER(7) NOT NULL,
    cabin_number            VARCHAR2(5) NOT NULL,
    ship_code               NUMBER(7) NOT NULL,
    manifest_board_datetime DATE NOT NULL
);

COMMENT ON COLUMN manifest.manifest_id IS
    'manifest id (surrogate key)';

COMMENT ON COLUMN manifest.cruise_id IS
    'the cruise''s ID';

COMMENT ON COLUMN manifest.passenger_id IS
    'passenger id';

COMMENT ON COLUMN manifest.cabin_number IS
    'the cabin''s number';

COMMENT ON COLUMN manifest.ship_code IS
    'the ship''s code';

COMMENT ON COLUMN manifest.manifest_board_datetime IS
    'manifest board date and time';

ALTER TABLE manifest ADD CONSTRAINT manifest_pk PRIMARY KEY ( manifest_id );

ALTER TABLE manifest ADD CONSTRAINT manifest_nk UNIQUE ( cruise_id,
                                                         passenger_id );

CREATE TABLE operator (
    opt_id           NUMBER(7) NOT NULL,
    opt_company_name VARCHAR2(20) NOT NULL,
    opt_ceo_name     VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN operator.opt_id IS
    'operator''s ID';

COMMENT ON COLUMN operator.opt_company_name IS
    'operator''s company name';

COMMENT ON COLUMN operator.opt_ceo_name IS
    'operator''s ceo name';

ALTER TABLE operator ADD CONSTRAINT operator_pk PRIMARY KEY ( opt_id );

CREATE TABLE passenger (
    passenger_id              NUMBER(7) NOT NULL,
    address_id                NUMBER(7) NOT NULL,
    guaridian_id              NUMBER(7),
    passenger_spoken_language CHAR(2) NOT NULL,
    passenger_fname           VARCHAR2(20) NOT NULL,
    passenger_lname           VARCHAR2(20) NOT NULL,
    passenger_gender          CHAR(1) NOT NULL,
    passenger_dob             DATE NOT NULL,
    passenger_phone_no        VARCHAR2(20)
);

ALTER TABLE passenger
    ADD CHECK ( passenger_gender IN ( 'F', 'M' ) );

COMMENT ON COLUMN passenger.passenger_id IS
    'passenger id';

COMMENT ON COLUMN passenger.address_id IS
    'surrogate key for address table';

COMMENT ON COLUMN passenger.guaridian_id IS
    'passenger id';

COMMENT ON COLUMN passenger.passenger_spoken_language IS
    'language code following ISO 639-1 Alpha-2 codes';

COMMENT ON COLUMN passenger.passenger_fname IS
    'passenger first name';

COMMENT ON COLUMN passenger.passenger_lname IS
    'passenger last name';

COMMENT ON COLUMN passenger.passenger_gender IS
    'passenger gender (M=Male, F=Female)';

COMMENT ON COLUMN passenger.passenger_dob IS
    'passenger date of birth';

COMMENT ON COLUMN passenger.passenger_phone_no IS
    'passenger''s phone number';

ALTER TABLE passenger ADD CONSTRAINT passenger_pk PRIMARY KEY ( passenger_id );

CREATE TABLE port (
    port_code         CHAR(5) NOT NULL,
    port_country_code CHAR(2) NOT NULL,
    port_name         VARCHAR2(20) NOT NULL,
    port_population   NUMBER(5) NOT NULL,
    port_longitude    NUMBER(10, 7) NOT NULL,
    port_latiittude   NUMBER(9, 7) NOT NULL
);

COMMENT ON COLUMN port.port_code IS
    'the port''s code';

COMMENT ON COLUMN port.port_country_code IS
    'the country''s code following ISO 3166-1 Alpha-2 codes';

COMMENT ON COLUMN port.port_name IS
    'the port''s name';

COMMENT ON COLUMN port.port_population IS
    'the port''s population';

COMMENT ON COLUMN port.port_longitude IS
    'the port''s longitude';

COMMENT ON COLUMN port.port_latiittude IS
    'the port''s latitude';

ALTER TABLE port ADD CONSTRAINT port_pk PRIMARY KEY ( port_code );

CREATE TABLE port_temp (
    port_temp_month        VARCHAR2(4) NOT NULL,
    port_code              CHAR(5) NOT NULL,
    port_temp_average_high NUMBER(2) NOT NULL,
    port_temp_average_low  NUMBER(2) NOT NULL
);

ALTER TABLE port_temp
    ADD CONSTRAINT chk_port_temp_month CHECK ( port_temp_month IN ( 'Apr', 'Aug', 'Dec', 'Feb', 'Jan',
                                                                    'July', 'Jun', 'Mar', 'May', 'Nov',
                                                                    'Oct', 'Sep' ) );

COMMENT ON COLUMN port_temp.port_temp_month IS
    'the month of the port''s temperature';

COMMENT ON COLUMN port_temp.port_code IS
    'the port''s code';

COMMENT ON COLUMN port_temp.port_temp_average_high IS
    'the average high temperature of the port';

COMMENT ON COLUMN port_temp.port_temp_average_low IS
    'the average low  temperature of the port';

ALTER TABLE port_temp ADD CONSTRAINT port_temp_pk PRIMARY KEY ( port_temp_month,
                                                                port_code );

CREATE TABLE ship (
    ship_code                    NUMBER(7) NOT NULL,
    opt_id                       NUMBER(7) NOT NULL,
    ship_registered_country_code CHAR(2) NOT NULL,
    ship_name                    VARCHAR2(20) NOT NULL,
    ship_comm_date               DATE NOT NULL,
    ship_tonnage                 NUMBER(6) NOT NULL,
    ship_max_guest_cap           NUMBER(5) NOT NULL
);

COMMENT ON COLUMN ship.ship_code IS
    'the ship''s code';

COMMENT ON COLUMN ship.opt_id IS
    'operator''s ID';

COMMENT ON COLUMN ship.ship_registered_country_code IS
    'the country''s code following ISO 3166-1 Alpha-2 codes';

COMMENT ON COLUMN ship.ship_name IS
    'the ship''s name';

COMMENT ON COLUMN ship.ship_comm_date IS
    'the ship''s commision date';

COMMENT ON COLUMN ship.ship_tonnage IS
    'the ship''s tonnage';

COMMENT ON COLUMN ship.ship_max_guest_cap IS
    'the ship''s maximum guest capacity';

ALTER TABLE ship ADD CONSTRAINT ship_pk PRIMARY KEY ( ship_code );

CREATE TABLE tour (
    tour_id                 NUMBER(7) NOT NULL,
    port_code               CHAR(5) NOT NULL,
    tour_number             NUMBER(2) NOT NULL,
    tour_datetime           DATE NOT NULL,
    tour_name               VARCHAR2(20) NOT NULL,
    tour_description        VARCHAR2(80) NOT NULL,
    tour_hours_required     NUMBER(2) NOT NULL,
    tour_cost_per_person    NUMBER(6, 2) NOT NULL,
    tour_wheel_chair_access CHAR(1) NOT NULL,
    tour_availability       VARCHAR2(10) NOT NULL
);

ALTER TABLE tour
    ADD CONSTRAINT chk_tour_wheel_chair_access CHECK ( tour_wheel_chair_access IN ( 'N', 'Y' ) );

COMMENT ON COLUMN tour.tour_id IS
    'the tour''s id';

COMMENT ON COLUMN tour.port_code IS
    'the port''s code';

COMMENT ON COLUMN tour.tour_number IS
    'the tour''s number';

COMMENT ON COLUMN tour.tour_datetime IS
    'the tour''s date and time';

COMMENT ON COLUMN tour.tour_name IS
    'the tour''s name';

COMMENT ON COLUMN tour.tour_description IS
    'the tour''s description';

COMMENT ON COLUMN tour.tour_hours_required IS
    'the number of hours of the tour';

COMMENT ON COLUMN tour.tour_cost_per_person IS
    'the cost of the tour';

COMMENT ON COLUMN tour.tour_wheel_chair_access IS
    'tour has wheel chair access or not (Y=yes, N=no)';

COMMENT ON COLUMN tour.tour_availability IS
    'the tour''s  availability ';

ALTER TABLE tour ADD CONSTRAINT tour_pk PRIMARY KEY ( tour_id );

ALTER TABLE tour
    ADD CONSTRAINT tour_nk UNIQUE ( port_code,
                                    tour_number,
                                    tour_datetime );

CREATE TABLE tour_language (
    tour_id       NUMBER(7) NOT NULL,
    language_code CHAR(2) NOT NULL
);

COMMENT ON COLUMN tour_language.tour_id IS
    'the tour''s id';

COMMENT ON COLUMN tour_language.language_code IS
    'language code following ISO 639-1 Alpha-2 codes';

ALTER TABLE tour_language ADD CONSTRAINT tour_language_pk PRIMARY KEY ( tour_id,
                                                                        language_code );

CREATE TABLE tour_participant (
    passenger_id          NUMBER(7) NOT NULL,
    tour_id               NUMBER(7) NOT NULL,
    cruise_id             NUMBER(7) NOT NULL,
    tour_participant_paid CHAR(1) NOT NULL
);

ALTER TABLE tour_participant
    ADD CONSTRAINT chk_paid_value CHECK ( tour_participant_paid IN ( 'N', 'Y' ) );

COMMENT ON COLUMN tour_participant.passenger_id IS
    'passenger id';

COMMENT ON COLUMN tour_participant.tour_id IS
    'the tour''s id';

COMMENT ON COLUMN tour_participant.cruise_id IS
    'the cruise''s ID';

COMMENT ON COLUMN tour_participant.tour_participant_paid IS
    'if participant has paid for the tour (Y=yes, N=no)';

ALTER TABLE tour_participant ADD CONSTRAINT port_tour_participant_pk PRIMARY KEY ( tour_id,
                                                                                   passenger_id );

ALTER TABLE manifest
    ADD CONSTRAINT cabin_manifest FOREIGN KEY ( cabin_number,
                                                ship_code )
        REFERENCES cabin ( cabin_number,
                           ship_code );

ALTER TABLE port
    ADD CONSTRAINT country_port FOREIGN KEY ( port_country_code )
        REFERENCES country ( country_code );

ALTER TABLE cruise_port
    ADD CONSTRAINT cruise_cruise_port FOREIGN KEY ( cruise_id )
        REFERENCES cruise ( cruise_id );

ALTER TABLE manifest
    ADD CONSTRAINT cruise_manifestv1 FOREIGN KEY ( cruise_id )
        REFERENCES cruise ( cruise_id );

ALTER TABLE tour_participant
    ADD CONSTRAINT cruise_port_tour_participant FOREIGN KEY ( cruise_id )
        REFERENCES cruise ( cruise_id );

ALTER TABLE tour_language
    ADD CONSTRAINT language_tlanguage FOREIGN KEY ( language_code )
        REFERENCES language ( language_code );

ALTER TABLE manifest
    ADD CONSTRAINT manifest_passenger FOREIGN KEY ( passenger_id )
        REFERENCES passenger ( passenger_id );

ALTER TABLE ship
    ADD CONSTRAINT operator_ship FOREIGN KEY ( opt_id )
        REFERENCES operator ( opt_id );

ALTER TABLE passenger
    ADD CONSTRAINT passenger_address FOREIGN KEY ( address_id )
        REFERENCES address ( address_id );

ALTER TABLE passenger
    ADD CONSTRAINT passenger_guardian FOREIGN KEY ( guaridian_id )
        REFERENCES passenger ( passenger_id );

ALTER TABLE passenger
    ADD CONSTRAINT passenger_language FOREIGN KEY ( passenger_spoken_language )
        REFERENCES language ( language_code );

ALTER TABLE tour_participant
    ADD CONSTRAINT passenger_pt_participant FOREIGN KEY ( passenger_id )
        REFERENCES passenger ( passenger_id );

ALTER TABLE cruise_port
    ADD CONSTRAINT port_cruise_port FOREIGN KEY ( port_code )
        REFERENCES port ( port_code );

ALTER TABLE port_temp
    ADD CONSTRAINT port_port_temp FOREIGN KEY ( port_code )
        REFERENCES port ( port_code );

ALTER TABLE tour
    ADD CONSTRAINT port_port_tour FOREIGN KEY ( port_code )
        REFERENCES port ( port_code );

ALTER TABLE ship
    ADD CONSTRAINT relation_24 FOREIGN KEY ( ship_registered_country_code )
        REFERENCES country ( country_code );

ALTER TABLE cabin
    ADD CONSTRAINT ship_cabin FOREIGN KEY ( ship_code )
        REFERENCES ship ( ship_code );

ALTER TABLE cruise
    ADD CONSTRAINT ship_cruise FOREIGN KEY ( ship_code )
        REFERENCES ship ( ship_code );

ALTER TABLE tour_language
    ADD CONSTRAINT tour_tlanguage FOREIGN KEY ( tour_id )
        REFERENCES tour ( tour_id );

ALTER TABLE tour_participant
    ADD CONSTRAINT tour_tparticipant FOREIGN KEY ( tour_id )
        REFERENCES tour ( tour_id );


-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            15
-- CREATE INDEX                             0
-- ALTER TABLE                             44
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0

-----------------------------------------------------
SPOOL off
set echo off