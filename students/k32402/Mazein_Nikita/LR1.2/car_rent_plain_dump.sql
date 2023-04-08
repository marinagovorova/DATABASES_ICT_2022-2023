--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-04-08 16:56:20

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
--SET Устанавливают таймауты для запросов, время ожидания блокировки и время бездействия для сессии в транзакции соответственно.
-- Значения 0 означают, что эти таймауты не будут использоваться
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
--Эти 2 SET устанавливают кодировку клиента и форматирование строк на стандартное,
-- что предотвращает некоторые проблемы с безопасностью при работе с данными.
SELECT pg_catalog.set_config('search_path', '', false);
--SELECT pg_catalog.set_config устанавливает значение параметра поиска search_path в пустую строку, что означает,
-- что будут использоваться все схемы в базе данных при поиске объектов
SET check_function_bodies = false;
--Запрос SET check_function_bodies устанавливает значение false, что отключает проверку функций на синтаксические ошибки,
-- что может повысить производительность при выполнении запросов.
SET xmloption = content;
--SET xmloption устанавливает форматирование для работы с XML-документами
SET client_min_messages = warning;
--SET client_min_messages устанавливает минимальный уровень сообщений, которые будут отправляться клиенту.
SET row_security = off;
--SET row_security устанавливает значение false, что отключает проверку прав доступа для строк в таблицах.

DROP DATABASE postgres;
--
-- TOC entry 3444 (class 1262 OID 5)
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1251';
--CREATE DATABASE создает новую базу данных с указанным именем, шаблоном, кодировкой, провайдером локали и локалью.

ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3445 (class 0 OID 0)
-- Dependencies: 3444
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- TOC entry 7 (class 2615 OID 24692)
-- Name: lab; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA lab;


ALTER SCHEMA lab OWNER TO postgres;

--
-- TOC entry 2 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
--CREATE EXTENSION создает расширение с указанным именем, схемой и владельцем.


--
-- TOC entry 3446 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- TOC entry 891 (class 1247 OID 33205)
-- Name: non_neg_money; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.non_neg_money AS real
	CONSTRAINT non_neg_money_check CHECK ((VALUE >= (0)::double precision));
--Создание домена non_neg_money, который является подтипом real и имеет ограничение, что значение должно быть больше или равно 0


ALTER DOMAIN public.non_neg_money OWNER TO postgres;

--
-- TOC entry 898 (class 1247 OID 33400)
-- Name: non_negative_bigint; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.non_negative_bigint AS bigint
	CONSTRAINT non_negative_bigint_check CHECK ((VALUE >= 0));
--Создание домена non_negative_bigint, который является подтипом bigint и имеет ограничение, что значение должно быть больше или равно 0


ALTER DOMAIN public.non_negative_bigint OWNER TO postgres;

--
-- TOC entry 887 (class 1247 OID 33202)
-- Name: non_negative_integer; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.non_negative_integer AS integer
	CONSTRAINT non_negative_integer_check CHECK ((VALUE >= 0));
--Создание домена non_negative_integer, который является подтипом integer и имеет ограничение, что значение должно быть больше или равно 0


ALTER DOMAIN public.non_negative_integer OWNER TO postgres;

SET default_tablespace = '';
--SET default_tablespace устанавливает таблицу по умолчанию для всех таблиц, созданных в базе данных.

SET default_table_access_method = heap;
--SET default_table_access_method устанавливает метод доступа по умолчанию для всех таблиц, созданных в базе данных.

--
-- TOC entry 216 (class 1259 OID 24693)
-- Name: Accidents; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab."Accidents" (
    "Accident_DT" timestamp(2) without time zone NOT NULL,
    "Contr_Code" public.non_negative_integer NOT NULL,
    "Place" character varying(100),
    "Damage" character varying(300) NOT NULL,
    "Cl_Is_Guilty" boolean NOT NULL
);
--Создание таблицы Accidents
--"Accident_DT" - дата и время происшествия
--"Contr_Code" - код договора
--"Place" - место происшествия
--"Damage" - ущерб
--"Cl_Is_Guilty" - виновен ли клиент
--Все поля обязательны для заполнения, кроме "Place"

ALTER TABLE lab."Accidents" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 24696)
-- Name: Auto; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab."Auto" (
    "Auto_Code" public.non_negative_integer NOT NULL,
    "Mod_Code" public.non_negative_integer NOT NULL,
    "Engine_Num" character varying(30) NOT NULL,
    "Date_Last_TS" timestamp(2) without time zone,
    "Mileage" public.non_negative_integer NOT NULL,
    "Body_Num" character varying(30) NOT NULL,
    "Release_Year" public.non_negative_integer NOT NULL,
    reg_plate character varying(9) NOT NULL,
    CONSTRAINT chk_rel_year CHECK ((("Release_Year")::integer > 1980))
    --Ограничение, что год выпуска автомобиля не может быть меньше 1980
);
--Создание таблицы Auto
--"Auto_Code" - код автомобиля
--"Mod_Code" - код модели
--"Engine_Num" - номер двигателя
--"Date_Last_TS" - дата последнего ТО
--"Mileage" - пробег
--"Body_Num" - номер кузова
--"Release_Year" - год выпуска
--reg_plate - регистрационный номер
--Все поля обязательны для заполнения, кроме "Date_Last_TS"


ALTER TABLE lab."Auto" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 24699)
-- Name: Bonus_Card; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab."Bonus_Card" (
    "BC_Code" public.non_negative_bigint NOT NULL,
    "Cl_Code" public.non_negative_integer NOT NULL,
    "Bonus_Sum" public.non_negative_integer NOT NULL,
    CONSTRAINT chk_bonsum CHECK ((length((("Bonus_Sum")::character varying(7))::text) <= 6))
    --Ограничение, что сумма бонусов не может быть больше 999999
);
--Создание таблицы Bonus_Card
--"BC_Code" - код бонусной карты
--"Cl_Code" - код клиента
--"Bonus_Sum" - сумма бонусов
--Все поля обязательны для заполнения



ALTER TABLE lab."Bonus_Card" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24702)
-- Name: Client; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab."Client" (
    "Cl_Code" public.non_negative_integer NOT NULL,
    "Email" character varying(256),
    "Address" character varying(100) NOT NULL,
    "Full_Name" character varying(50) NOT NULL,
    "Passport_Data" public.non_negative_bigint NOT NULL,
    "Tel_Num" public.non_negative_bigint NOT NULL,
    CONSTRAINT chk_email CHECK ((("Email")::text ~~ '_%@_%._%'::text)),
    --Ограничение, что email должен соответствовать шаблону _%@_%._%
    CONSTRAINT chk_passport CHECK (((("Passport_Data")::bigint > 1000000000) AND (("Passport_Data")::bigint <= '9999999999'::bigint))),
    --Ограничение, что паспортные данные должны быть больше 1000000000 и меньше 10000000000
    CONSTRAINT chk_phone CHECK (((("Tel_Num")::bigint > '70000000000'::bigint) AND (("Tel_Num")::bigint <= '79999999999'::bigint)))
    --Ограничение, что номер телефона должен быть больше 70000000000 и меньше 79999999999
);
--Создание таблицы Client
--"Cl_Code" - код клиента
--"Email" - email
--"Address" - адрес
--"Full_Name" - полное имя
--"Passport_Data" - паспортные данные
--"Tel_Num" - номер телефона
--Все поля обязательны для заполнения, кроме "Email" (его у клиента может не быть)


ALTER TABLE lab."Client" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 24705)
-- Name: Contract; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab."Contract" (
    "Contr_Code" public.non_negative_integer NOT NULL,
    "Act_Transf_Client" public.non_negative_integer,
    "Act_Transf_Company" public.non_negative_integer,
    "Rent_Price" public.non_neg_money NOT NULL,
    "DT_Contract" timestamp(2) without time zone NOT NULL,
    "DT_Car_Transf_To_Cl" timestamp(2) without time zone,
    "Factual_DT_Ret" timestamp(2) without time zone,
    "Late_Fee" public.non_neg_money,
    "Ret_Mark" boolean NOT NULL,
    "Cl_Code" public.non_negative_integer NOT NULL,
    "Stf_Code" public.non_negative_integer NOT NULL,
    "Auto_Code" public.non_negative_integer NOT NULL,
    rent_time public.non_negative_integer NOT NULL
);
--Создание таблицы Contract
--"Contr_Code" - код договора
--Act_Transf_Client - акт передачи автомобиля клиенту
--Act_Transf_Company - акт передачи автомобиля компании
--Rent_Price - стоимость аренды
--DT_Contract - дата заключения договора
--DT_Car_Transf_To_Cl - дата передачи автомобиля клиенту
--Factual_DT_Ret - фактическая дата возврата автомобиля
--Late_Fee - штраф за просрочку
--Ret_Mark - метка возврата
--Cl_Code - код клиента
--Stf_Code - код сотрудника
--Auto_Code - код автомобиля
--rent_time - время аренды
--Все поля обязательны для заполнения, кроме "Act_Transf_Client", "Act_Transf_Company", "DT_Car_Transf_To_Cl", "Factual_DT_Ret", "Late_Fee"


ALTER TABLE lab."Contract" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24708)
-- Name: Extension; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab."Extension" (
    "Extension_Id" public.non_negative_integer NOT NULL,
    "Contr_Code" integer NOT NULL,
    "New_DT_Ret" timestamp without time zone NOT NULL,
    "Ext_Hours" public.non_negative_integer NOT NULL,
    "Sequence_Num" public.non_negative_integer NOT NULL
);
--Cоздание таблицы Extension
--"Extension_Id" - код продления
--"Contr_Code" - код договора
--"New_DT_Ret" - новая дата возврата
--"Ext_Hours" - продленное время
--"Sequence_Num" - номер в последовательности продлений
--Все поля обязательны для заполнения

ALTER TABLE lab."Extension" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 24711)
-- Name: Model; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab."Model" (
    "Mod_Code" public.non_negative_integer NOT NULL,
    "Name" character varying(40) NOT NULL,
    "Characteristics" character varying(300) NOT NULL,
    "Description" character varying(1500) NOT NULL,
    "Market_Price" public.non_negative_integer,
    "Bail_Sum" public.non_negative_integer NOT NULL
);
--Создание таблицы Model
--"Mod_Code" - код модели
--"Name" - название
--"Characteristics" - характеристики
--"Description" - описание
--"Market_Price" - рыночная цена
--"Bail_Sum" - сумма залога
--Все поля обязательны для заполнения, кроме "Market_Price" (например, модели уже нет в продаже)

ALTER TABLE lab."Model" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24716)
-- Name: Penalties; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab."Penalties" (
    "Penalty_Code" public.non_negative_integer NOT NULL,
    "Accident_DT" timestamp(2) without time zone NOT NULL,
    "Who_Pays" character varying(2) NOT NULL,
    "Payment_Status" boolean NOT NULL,
    "Penalty_Sum" public.non_neg_money NOT NULL,
    CONSTRAINT check_who_pays CHECK ((("Who_Pays")::text = ANY ((ARRAY['Cl'::character varying, 'Co'::character varying, 'Ot'::character varying])::text[])))
    --Constraint для поля "Who_Pays" - может принимать значения "Cl", "Co", "Ot" (клиент, компания, другой человек)
);
--Создание таблицы Penalties
--"Penalty_Code" - код штрафа
--"Accident_DT" - дата происшествия
--"Who_Pays" - кто платит
--"Payment_Status" - статус оплаты
--"Penalty_Sum" - сумма штрафа
--Все поля обязательны для заполнения


ALTER TABLE lab."Penalties" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 24719)
-- Name: Price; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab."Price" (
    "Mod_Code" integer NOT NULL,
    "DT_Inter_Start" timestamp(2) without time zone NOT NULL,
    "DT_Inter_End" timestamp(2) without time zone,
    "Price_One_H" public.non_negative_integer NOT NULL,
    "Price_Long_Inter" public.non_negative_integer NOT NULL,
    "Price_Code" public.non_negative_integer NOT NULL
);
--Создание таблицы Price
--"Mod_Code" - код модели
--"DT_Inter_Start" - начало интервала
--"DT_Inter_End" - конец интервала
--"Price_One_H" - цена за час
--"Price_Long_Inter" - цена за долгий интервал (24 часа)
--"Price_Code" - код цены
--Все поля обязательны для заполнения, кроме "DT_Inter_End" (например, цена действует до сих пор)


ALTER TABLE lab."Price" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24722)
-- Name: Staff; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab."Staff" (
    "Stf_Code" public.non_negative_integer NOT NULL,
    "Position" character varying(30) NOT NULL,
    "Resps" character varying(200) NOT NULL,
    "Salary" public.non_negative_integer,
    stf_name character varying NOT NULL
);
--Создание таблицы Staff
--"Stf_Code" - код сотрудника
--"Position" - должность
--"Resps" - обязанности
--"Salary" - зарплата
--"stf_name" - имя сотрудника
--Все поля обязательны для заполнения, кроме "Salary" (например, сотрудник еще не получил зарплату или уволен)

ALTER TABLE lab."Staff" OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 24725)
-- Name: Violation; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab."Violation" (
    "Violation_Code" public.non_negative_integer NOT NULL,
    "Penalty_Code" integer,
    rtr_viol_code integer NOT NULL
);
--Создание таблицы Violation
--"Violation_Code" - код нарушения
--"Penalty_Code" - код штрафа
--"rtr_viol_code" - код нарушения в таблице rtr_dict
--Все поля обязательны для заполнения, кроме "Penalty_Code" (например, нарушение не привело к штрафу)


ALTER TABLE lab."Violation" OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 33369)
-- Name: insurance_dict; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab.insurance_dict (
    insur_code public.non_negative_integer NOT NULL,
    insur_price public.non_negative_integer NOT NULL,
    insure_name character varying(40) NOT NULL,
    insure_desc character varying(200) NOT NULL,
    "Mod_Code" integer NOT NULL
);
--Создание таблицы insurance_dict
--"insur_code" - код страховки
--"insur_price" - цена страховки
--"insure_name" - название страховки
--"insure_desc" - описание страховки
--"Mod_Code" - код модели
--Все поля обязательны для заполнения


ALTER TABLE lab.insurance_dict OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 24812)
-- Name: rtr_dict; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab.rtr_dict (
    rtr_viol_code public.non_negative_integer NOT NULL,
    viol_fee public.non_neg_money NOT NULL,
    viol_type character varying(100) NOT NULL,
    viol_descript character varying(200) NOT NULL
);
--Создание таблицы rtr_dict
--"rtr_viol_code" - код нарушения
--"viol_fee" - штраф за нарушение
--"viol_type" - тип нарушения
--"viol_descript" - описание нарушения
--Все поля обязательны для заполнения


ALTER TABLE lab.rtr_dict OWNER TO postgres;

--
-- TOC entry 3426 (class 0 OID 24693)
-- Dependencies: 216
-- Data for Name: Accidents; Type: TABLE DATA; Schema: lab; Owner: postgres
--

INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-07-30 18:04:26', 100007, '46 Fifth Avenue Lane', 'A minor damage from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-12-05 22:43:06', 100006, '35 Cedar Lane Street', 'A severe dents from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-07-11 09:39:59', 100007, '68 First Avenue Road', 'A cosmetic damage from a collision with a truck', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-01-09 02:15:01', 100006, '10 Main Street Road', 'A major scuffs from a collision with a truck', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-02-02 21:56:45', 100002, '29 Fifth Avenue Road', 'A minor bumps from a collision with a truck', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-05-18 10:46:53', 100018, '34 Maple Avenue Road', 'A severe bumps from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-09-03 07:39:11', 100004, '53 Fourth Street Lane', 'A severe bumps from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-11-11 07:13:46', 100008, '18 Cedar Lane Avenue', 'A severe dents from a collision with a car', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-07-05 12:42:25', 100013, '76 First Avenue Road', 'A severe bumps from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-06-20 18:38:22', 100014, '97 Fourth Street Road', 'A minor scratches from a collision with a bike', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-12-03 02:41:32', 100013, '74 Maple Avenue Road', 'A minor dents from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-07-15 08:04:04', 100001, '77 Main Street Road', 'A minor dents from a collision with a truck', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-06-26 10:01:46', 100012, '1 First Avenue Street', 'A major dents from a collision with a truck', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-03-02 10:55:19', 100010, '28 First Avenue Road', 'A minor damage from a collision with a bike', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-04-16 01:09:58', 100003, '56 Fifth Avenue Street', 'A severe scratches from a collision with a car', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-02-07 12:47:30', 100001, '45 Park Avenue Road', 'A severe dents from a collision with a truck', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-12-30 23:46:03', 100015, '38 First Avenue Street', 'A severe dents from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-02-19 10:43:08', 100012, '65 Main Street Road', 'A extensive scratches from a collision with a truck', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-04-03 00:31:54', 100014, '2 Fourth Street Avenue', 'A major scuffs from a collision with a truck', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-06-03 21:08:00', 100019, '61 First Avenue Street', 'A extensive bumps from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-04-04 22:42:09', 100013, '8 Main Street Avenue', 'A cosmetic bumps from a collision with a truck', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-06-15 00:21:27', 100015, '53 Elm Street Road', 'A minor scuffs from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-08-03 01:38:50', 100020, '92 Cedar Lane Street', 'A cosmetic scuffs from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-09-18 13:24:41', 100004, '45 Second Avenue Street', 'A extensive damage from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-09-07 23:50:08', 100019, '8 Main Street Avenue', 'A severe dents from a collision with a bike', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-11-18 17:35:34', 100002, '48 Main Street Lane', 'A minor dents from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-10-07 10:59:26', 100018, '68 Second Avenue Avenue', 'A cosmetic damage from a collision with a truck', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-03-14 14:42:14', 100013, '93 Main Street Road', 'A minor scratches from a collision with a truck', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-11-01 06:58:08', 100018, '5 Maple Avenue Road', 'A cosmetic scratches from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-11-03 16:32:21', 100017, '36 Fifth Avenue Road', 'A extensive bumps from a collision with a bike', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-09-15 20:29:29', 100003, '39 Second Avenue Road', 'A cosmetic bumps from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-07-02 01:45:52', 100015, '70 Fifth Avenue Avenue', 'A severe scratches from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-12-11 07:47:56', 100007, '62 Elm Street Lane', 'A severe dents from a collision with a truck', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-08-14 10:40:44', 100008, '51 Fifth Avenue Street', 'A extensive dents from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-11-04 02:56:17', 100012, '52 Third Street Lane', 'A extensive scuffs from a collision with a car', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-04-07 23:01:37', 100010, '86 Park Avenue Avenue', 'A cosmetic scratches from a collision with a truck', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-12-19 19:14:05', 100003, '2 Park Avenue Road', 'A major scratches from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-01-08 04:46:25', 100015, '57 Third Street Road', 'A cosmetic scuffs from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-06-01 18:56:42', 100005, '51 Cedar Lane Avenue', 'A severe damage from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-06-21 16:36:56', 100003, '29 Third Street Avenue', 'A minor dents from a collision with a truck', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-10-15 06:44:41', 100019, '74 First Avenue Avenue', 'A minor damage from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-09-30 09:05:51', 100011, '31 Cedar Lane Road', 'A extensive scuffs from a collision with a truck', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-05-12 05:45:24', 100015, '42 First Avenue Lane', 'A extensive dents from a collision with a car', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-01-14 04:42:57', 100020, '43 Third Street Road', 'A major scuffs from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-12-05 10:33:49', 100019, '65 Second Avenue Lane', 'A minor bumps from a collision with a truck', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-02-19 11:53:58', 100014, '78 Main Street Street', 'A severe bumps from a collision with a car', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-04-11 23:22:26', 100017, '13 Third Street Lane', 'A extensive dents from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-08-10 00:30:08', 100016, '97 Fourth Street Avenue', 'A major scratches from a collision with a car', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-07-01 07:58:23', 100016, '46 Elm Street Road', 'A minor scuffs from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-11-16 10:01:32', 100017, '61 Second Avenue Avenue', 'A severe damage from a collision with a truck', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-02-24 01:27:08', 100013, '70 Park Avenue Lane', 'A minor bumps from a collision with a bike', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-09-30 22:29:37', 100012, '43 First Avenue Avenue', 'A major bumps from a collision with a car', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-07-12 19:16:31', 100012, '61 Third Street Street', 'A major scuffs from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-09-23 05:42:30', 100004, '43 Third Street Street', 'A cosmetic bumps from a collision with a car', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-11-20 14:38:40', 100014, '33 Park Avenue Lane', 'A major dents from a collision with a truck', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-06-22 10:40:30', 100002, '53 Third Street Road', 'A major scratches from a collision with a truck', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-05-30 03:47:15', 100001, '1 Cedar Lane Road', 'A major damage from a collision with a truck', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-05-29 01:19:14', 100007, '83 Maple Avenue Street', 'A severe scratches from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-05-06 10:43:21', 100014, '3 Main Street Lane', 'A severe scratches from a collision with a car', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-09-10 11:03:07', 100004, '62 Cedar Lane Lane', 'A minor damage from a collision with a car', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-10-17 16:58:38', 100014, '95 Elm Street Street', 'A major scratches from a collision with a car', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-04-08 13:07:54', 100002, '16 Fifth Avenue Lane', 'A major scratches from a collision with a car', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-11-29 02:39:40', 100017, '44 Fourth Street Road', 'A severe scratches from a collision with a car', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-01-17 11:40:00', 100012, '54 Fifth Avenue Street', 'A severe bumps from a collision with a car', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-04-23 18:47:16', 100017, '62 Maple Avenue Road', 'A severe bumps from a collision with a car', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-11-10 12:41:37', 100019, '97 Cedar Lane Street', 'A cosmetic bumps from a collision with a truck', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-07-09 06:52:58', 100018, '11 First Avenue Road', 'A cosmetic bumps from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-05-09 09:46:31', 100012, '60 Third Street Lane', 'A severe scuffs from a collision with a truck', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-06-04 11:26:51', 100017, '10 Elm Street Avenue', 'A severe scratches from a collision with a car', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-11-04 22:05:37', 100016, '12 Fifth Avenue Road', 'A severe scuffs from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-06-05 01:00:42', 100013, '41 Cedar Lane Lane', 'A severe scratches from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-05-23 09:17:58', 100006, '68 Maple Avenue Street', 'A cosmetic scuffs from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-11-06 16:45:26', 100007, '10 Second Avenue Street', 'A severe dents from a collision with a truck', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-10-12 11:07:25', 100007, '30 Second Avenue Lane', 'A cosmetic bumps from a collision with a bike', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-10-28 00:53:47', 100007, '70 Fifth Avenue Road', 'A severe damage from a collision with a car', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-05-06 18:46:02', 100003, '70 Main Street Road', 'A major scratches from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-10-12 13:51:47', 100012, '86 Fourth Street Road', 'A cosmetic scuffs from a collision with a car', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-03-13 04:05:11', 100014, '27 Main Street Avenue', 'A minor scratches from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-03-23 16:54:36', 100001, '6 Main Street Lane', 'A minor dents from a collision with a truck', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-07-27 17:01:20', 100002, '81 Fourth Street Road', 'A cosmetic bumps from a collision with a car', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-12-10 00:15:10', 100010, '28 Second Avenue Lane', 'A major bumps from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-05-11 00:09:57', 100012, '90 Park Avenue Road', 'A cosmetic scuffs from a collision with a truck', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-04-20 05:55:15', 100019, '41 Fourth Street Street', 'A minor scratches from a collision with a bike', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-01-26 17:52:45', 100008, '28 Fifth Avenue Street', 'A cosmetic scratches from a collision with a car', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-07-17 12:17:38', 100001, '81 Fourth Street Street', 'A extensive scuffs from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-02-17 00:35:31', 100014, '96 Cedar Lane Road', 'A minor scuffs from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-10-22 10:50:12', 100011, '3 Third Street Road', 'A cosmetic damage from a collision with a car', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-01-25 07:42:05', 100014, '43 Third Street Lane', 'A extensive dents from a collision with a truck', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-12-25 22:47:21', 100012, '48 Fourth Street Lane', 'A minor scuffs from a collision with a truck', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-05-22 01:15:37', 100008, '89 Elm Street Road', 'A major scuffs from a collision with a car', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-10-14 05:47:08', 100018, '88 First Avenue Street', 'A major scuffs from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-11-24 06:40:39', 100011, '51 Third Street Road', 'A severe scuffs from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-04-12 14:53:55', 100004, '73 Cedar Lane Lane', 'A cosmetic scratches from a collision with a truck', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-11-01 22:31:53', 100013, '68 Park Avenue Street', 'A major dents from a collision with a car', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-01-30 19:37:08', 100018, '69 Cedar Lane Lane', 'A cosmetic scratches from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-06-22 01:03:39', 100011, '73 First Avenue Avenue', 'A minor scuffs from a collision with a bike', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-03-18 02:12:37', 100015, '44 First Avenue Avenue', 'A minor scratches from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-12-06 09:47:56', 100020, '46 Park Avenue Road', 'A minor dents from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-08-20 23:14:01', 100005, '38 Park Avenue Road', 'A severe scratches from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-10-22 20:00:57', 100001, '32 Maple Avenue Street', 'A severe bumps from a collision with a car', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-09-27 02:29:55', 100005, '71 Maple Avenue Lane', 'A cosmetic dents from a collision with a truck', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-01-31 09:36:03', 100015, '74 Park Avenue Road', 'A minor damage from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-08-11 04:07:35', 100012, '14 Cedar Lane Avenue', 'A cosmetic damage from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-05-28 23:57:26', 100002, '45 Second Avenue Avenue', 'A severe scratches from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-02-06 02:10:46', 100006, '61 Third Street Avenue', 'A major dents from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-10-31 03:57:51', 100012, '49 Fourth Street Avenue', 'A cosmetic dents from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-02-28 01:54:23', 100008, '10 Fourth Street Road', 'A severe dents from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-11-29 08:16:47', 100007, '63 Second Avenue Lane', 'A severe bumps from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-10-06 05:19:53', 100003, '78 Fourth Street Lane', 'A minor scratches from a collision with a car', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-06-01 13:21:27', 100012, '11 Main Street Street', 'A severe damage from a collision with a truck', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-10-24 05:22:02', 100017, '94 Elm Street Lane', 'A extensive damage from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-02-09 08:18:47', 100017, '69 Third Street Road', 'A cosmetic damage from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-02-03 10:17:09', 100004, '90 Park Avenue Lane', 'A cosmetic scratches from a collision with a truck', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-11-24 16:49:24', 100006, '23 Elm Street Avenue', 'A severe bumps from a collision with a bike', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-11-07 06:17:21', 100003, '68 Fifth Avenue Street', 'A extensive dents from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-12-15 04:16:18', 100010, '63 Third Street Avenue', 'A major scuffs from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-07-17 03:34:27', 100001, '24 Third Street Avenue', 'A cosmetic scratches from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-09-02 14:09:40', 100005, '25 Fifth Avenue Street', 'A extensive dents from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-08-25 11:34:20', 100016, '92 Cedar Lane Road', 'A severe dents from a collision with a truck', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-04-03 12:25:41', 100017, '70 First Avenue Lane', 'A minor dents from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-01-26 06:07:37', 100020, '15 Park Avenue Street', 'A cosmetic dents from a collision with a car', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-02-18 00:30:46', 100008, '78 Third Street Avenue', 'A severe damage from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-09-13 22:21:31', 100007, '68 Second Avenue Avenue', 'A extensive scuffs from a collision with a bike', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-01-31 12:43:09', 100016, '72 Fifth Avenue Avenue', 'A cosmetic damage from a collision with a bike', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-02-01 07:17:42', 100004, '93 Fourth Street Street', 'A extensive damage from a collision with a car', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-09-24 23:31:48', 100017, '97 Third Street Avenue', 'A severe dents from a collision with a bike', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-03-16 06:25:15', 100007, '69 Cedar Lane Road', 'A extensive bumps from a collision with a car', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-11-27 12:10:15', 100008, '15 Second Avenue Lane', 'A cosmetic scuffs from a collision with a car', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-09-22 15:20:49', 100002, '18 Elm Street Road', 'A cosmetic dents from a collision with a bike', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-12-17 08:26:22', 100004, '62 Elm Street Lane', 'A cosmetic scuffs from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-02-16 05:49:57', 100007, '88 Elm Street Road', 'A cosmetic dents from a collision with a truck', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-01-24 17:14:11', 100020, '64 Second Avenue Lane', 'A minor dents from a collision with a truck', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-08-19 07:45:12', 100005, '37 Elm Street Avenue', 'A minor scratches from a collision with a truck', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-10-05 04:43:56', 100001, '86 Main Street Road', 'A minor damage from a collision with a car', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-05-15 20:41:11', 100019, '14 Cedar Lane Lane', 'A severe damage from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-02-16 17:22:55', 100020, '55 First Avenue Avenue', 'A minor dents from a collision with a car', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-04-30 03:46:08', 100018, '36 Fifth Avenue Street', 'A extensive scratches from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-12-25 15:28:37', 100014, '19 Third Street Lane', 'A extensive scratches from a collision with a truck', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-11-18 12:07:05', 100020, '59 Third Street Road', 'A extensive scuffs from a collision with a car', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-09-17 17:43:45', 100011, '68 Fifth Avenue Lane', 'A extensive damage from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-12-31 14:54:37', 100011, '77 Park Avenue Lane', 'A minor scuffs from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-10-16 11:35:17', 100005, '62 Main Street Road', 'A major scratches from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-02-24 16:35:55', 100004, '59 Fourth Street Lane', 'A major scratches from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-03-02 00:01:42', 100017, '47 Second Avenue Avenue', 'A severe scuffs from a collision with a truck', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-06-25 10:39:29', 100010, '49 Cedar Lane Road', 'A minor bumps from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-01-17 22:50:18', 100008, '49 Park Avenue Avenue', 'A cosmetic scuffs from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-06-16 17:53:04', 100016, '24 Maple Avenue Road', 'A minor scratches from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-11-02 12:42:36', 100015, '37 Main Street Road', 'A minor damage from a collision with a car', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-06-30 10:18:21', 100011, '86 Elm Street Avenue', 'A cosmetic scuffs from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-09-10 11:22:33', 100010, '12 Park Avenue Road', 'A extensive damage from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-02-14 03:33:06', 100019, '85 First Avenue Lane', 'A minor damage from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-06-29 21:09:17', 100020, '8 Fourth Street Lane', 'A minor scuffs from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-02-24 09:13:20', 100002, '24 Third Street Lane', 'A major bumps from a collision with a car', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-05-01 13:28:56', 100017, '96 Cedar Lane Lane', 'A extensive scuffs from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-10-17 14:04:28', 100011, '67 Second Avenue Street', 'A severe dents from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-12-09 05:19:01', 100016, '30 Cedar Lane Avenue', 'A cosmetic dents from a collision with a bike', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-08-25 15:17:30', 100010, '52 Park Avenue Street', 'A major scratches from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-03-17 06:07:51', 100001, '74 First Avenue Road', 'A extensive damage from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-11-18 23:45:14', 100007, '25 Second Avenue Road', 'A major dents from a collision with a bike', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-12-18 05:12:31', 100002, '37 Third Street Avenue', 'A cosmetic bumps from a collision with a car', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-07-15 19:47:33', 100010, '61 Main Street Street', 'A minor scuffs from a collision with a car', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-07-20 22:27:19', 100019, '11 Park Avenue Lane', 'A extensive scratches from a collision with a car', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-04-01 01:19:21', 100002, '17 First Avenue Lane', 'A minor bumps from a collision with a car', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-03-16 16:03:26', 100001, '12 Elm Street Avenue', 'A severe scratches from a collision with a car', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-06-26 04:30:55', 100002, '92 Fourth Street Street', 'A cosmetic damage from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-07-16 13:31:40', 100013, '4 Third Street Lane', 'A major scuffs from a collision with a bike', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-09-21 14:54:44', 100002, '32 First Avenue Avenue', 'A minor scratches from a collision with a truck', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-04-07 17:31:45', 100010, '90 Elm Street Street', 'A major bumps from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-05-19 19:07:27', 100004, '10 Second Avenue Road', 'A severe scuffs from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-08-09 19:20:24', 100018, '40 Maple Avenue Road', 'A extensive damage from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-03-05 14:01:06', 100007, '68 Second Avenue Street', 'A major damage from a collision with a car', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-02-12 03:51:18', 100015, '41 Third Street Lane', 'A severe damage from a collision with a car', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-03-14 03:37:27', 100019, '85 Fifth Avenue Road', 'A cosmetic dents from a collision with a car', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-09-10 09:02:07', 100003, '92 First Avenue Road', 'A extensive dents from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-04-17 11:25:02', 100019, '45 Park Avenue Avenue', 'A extensive damage from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-07-25 20:05:22', 100012, '28 First Avenue Road', 'A minor dents from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-05-03 05:55:26', 100016, '52 Park Avenue Avenue', 'A major dents from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-06-09 07:31:57', 100003, '35 Third Street Avenue', 'A cosmetic scuffs from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-08-26 18:02:54', 100014, '37 Cedar Lane Lane', 'A extensive scuffs from a collision with a truck', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-06-04 05:41:17', 100017, '5 Maple Avenue Street', 'A severe dents from a collision with a car', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-05-14 07:33:39', 100010, '30 Cedar Lane Street', 'A extensive scuffs from a collision with a bike', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-09-16 20:58:34', 100007, '96 Fourth Street Avenue', 'A major damage from a collision with a car', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-11-06 17:57:23', 100015, '18 Elm Street Street', 'A severe damage from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-11-02 00:57:57', 100006, '23 Fifth Avenue Lane', 'A extensive scratches from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-01-20 14:31:51', 100011, '35 Fifth Avenue Street', 'A cosmetic damage from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-03-05 20:35:59', 100011, '8 Second Avenue Avenue', 'A cosmetic damage from a collision with a truck', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2018-04-23 17:55:37', 100015, '50 Maple Avenue Lane', 'A minor damage from a collision with a car', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2022-01-31 16:25:54', 100003, '26 Maple Avenue Avenue', 'A extensive scuffs from a collision with a car', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-07-06 19:14:16', 100002, '84 Fifth Avenue Lane', 'A minor scuffs from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-11-18 04:49:43', 100006, '15 First Avenue Road', 'A cosmetic scuffs from a collision with a car', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-09-05 12:06:02', 100018, '74 Second Avenue Avenue', 'A extensive scuffs from a collision with a truck', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-10-23 04:08:48', 100006, '98 Fifth Avenue Lane', 'A major bumps from a collision with a motorcycle', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-08-31 23:21:50', 100008, '32 Main Street Street', 'A severe bumps from a collision with a bike', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-12-04 03:15:04', 100008, '2 First Avenue Lane', 'A major damage from a collision with a truck', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2020-10-24 14:37:35', 100019, '9 Fifth Avenue Lane', 'A severe scratches from a collision with a car', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-04-25 02:38:44', 100017, '4 First Avenue Street', 'A major bumps from a collision with a bike', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-08-18 19:30:18', 100002, '84 Maple Avenue Avenue', 'A major scratches from a collision with a car', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2023-05-19 02:20:05', 100002, '37 Park Avenue Road', 'A major scuffs from a collision with a motorcycle', true);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2021-10-07 04:12:06', 100014, '54 Cedar Lane Avenue', 'A major scuffs from a collision with a bike', false);
INSERT INTO lab."Accidents" ("Accident_DT", "Contr_Code", "Place", "Damage", "Cl_Is_Guilty") VALUES ('2019-10-02 15:43:18', 100019, '34 Elm Street Avenue', 'A severe dents from a collision with a motorcycle', false);
-- Вставка данных в таблицу "lab"."Accidents"

--
-- TOC entry 3427 (class 0 OID 24696)
-- Dependencies: 217
-- Data for Name: Auto; Type: TABLE DATA; Schema: lab; Owner: postgres
--

INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (938227, 345678, '2DFCJ13421', '2021-03-15 00:00:00', 2098, 'WBABC1234567', 2020, 'MH445K09');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (582891, 456789, '84GFDV8732', '2019-09-22 00:00:00', 4067, 'WDD123456789', 2017, 'MK647A72');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (186549, 567890, '13ABCX9999', '2022-01-05 00:00:00', 739, 'JTJGZ8BC4G2000019', 2020, 'HO912E72');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (375648, 678901, '89HFDK7924', '2020-07-10 00:00:00', 2815, 'SAJEA6AT3H8K37538', 2021, 'HA867B18');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (802189, 789012, '62FDGA2973', '2022-02-27 00:00:00', 558, 'WP0AA2A7XGL108484', 2017, 'MH114E90');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (205635, 890123, '25GFBC2891', '2021-05-21 00:00:00', 1392, '5YJSA1E11HF185161', 2019, 'HO438O54');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (759321, 901234, '91CVFD8385', '2018-11-17 00:00:00', 5910, 'WA1LAAF77JD007402', 2018, 'MK172B06');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (324516, 294832, '22GFDK7311', '2021-06-28 00:00:00', 2785, 'WAUZZZ8VXDB107360', 2015, 'MH329O91');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (437892, 345678, '32VFDK6749', '2017-09-03 00:00:00', 8053, 'WBA3D5C53EKX98023', 2014, 'MH523E83');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (903284, 456789, '59GHJL9384', '2020-02-14 00:00:00', 3528, 'WDD1240422A222157', 2016, 'MK321B68');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (632489, 567890, '40DFCV1287', '2022-03-10 00:00:00', 1689, 'JTHKD5BHXD2161306', 2021, 'HO790A41');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (482949, 456789, '43XEC92813', '2021-01-21 00:00:00', 2650, 'WDB12345678901234', 2019, 'BA992H77');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (685726, 345678, '59CCG21125', '2020-08-12 00:00:00', 8500, 'WBAX1234567890123', 2020, 'MO312K89');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (129303, 678901, '24WQA31411', '2021-03-09 00:00:00', 4920, 'SAJ12345678901234', 2018, 'PA521B79');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (573083, 345678, '99XBS98732', '2019-06-18 00:00:00', 12300, 'WBAN123456789012', 2019, 'BM938H87');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (362718, 456789, '21BFD84117', '2018-11-27 00:00:00', 15600, 'WDB12345678901235', 2017, 'BB042E34');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (237389, 789012, '03TRQ28657', '2022-02-05 00:00:00', 3100, 'WP0AB123456789012', 2021, 'MP115S85');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (184729, 678901, '55LNU73305', '2019-10-22 00:00:00', 9720, 'SAJ12345678901235', 2017, 'XA362M41');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (490100, 567890, '12SLW22980', '2021-02-17 00:00:00', 1870, 'JTH12345678901234', 2022, 'MO992F48');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (776363, 901234, '38KPU98329', '2018-07-31 00:00:00', 13750, 'WA1L1234567890123', 2020, 'PB776J39');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (837287, 345678, '78NTH43920', '2019-04-29 00:00:00', 8600, 'WBA12345678901234', 2017, 'XM215H51');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (276172, 345678, '63QSF38120', '2022-01-09 00:00:00', 4600, 'WBA12345678901235', 2021, 'BA573C49');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (881990, 456789, '87XNS46720', '2020-12-02 00:00:00', 9800, 'WDD12345678901234', 2019, 'KA111R86');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (367932, 890123, '92BVA73328', '2020-05-14 00:00:00', 6300, '5YJ12345678901234', 2018, 'BM702F34');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (452145, 294832, '7JVJL38380', '2021-01-21 00:00:00', 5623, 'WBAYF4C54ED123456', 2020, 'ХУ159Р11');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (872364, 567890, '5TGXX24323', '2018-07-03 00:00:00', 10856, 'JTJHY7AX4B4041234', 2017, 'В369АМ199');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (693246, 890123, 'K6U2315266', '2016-09-28 00:00:00', 4789, '5YJSA1DN8CFP12345', 2013, 'ЕХ437Х77');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (539481, 901234, 'KAA4427606', '2015-05-12 00:00:00', 29750, 'WA1CVAFP5AA098765', 2011, 'У007УХ36');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (287461, 345678, 'D7FN908392', '2017-02-08 00:00:00', 15678, '5UXXW5C56H0U12345', 2016, 'К951КН19');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (721930, 789012, '6UJTT54253', '2019-11-15 00:00:00', 7409, 'WP0AB2A74BL123456', 2011, 'М392ХМ123');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (972841, 456789, 'N97F30E433', '2016-08-01 00:00:00', 8935, 'WDDKK5GF5BF123456', 2014, 'А717АР26');
INSERT INTO lab."Auto" ("Auto_Code", "Mod_Code", "Engine_Num", "Date_Last_TS", "Mileage", "Body_Num", "Release_Year", reg_plate) VALUES (312532, 294832, '52WVC10338', '2020-12-12 00:00:00', 1344, 'WAUZZZ8VXCA123456', 2018, 'XO337P196');
--вставка данных в таблицу lab."Auto"

--
-- TOC entry 3428 (class 0 OID 24699)
-- Dependencies: 218
-- Data for Name: Bonus_Card; Type: TABLE DATA; Schema: lab; Owner: postgres
--

INSERT INTO lab."Bonus_Card" ("BC_Code", "Cl_Code", "Bonus_Sum") VALUES (1234567890123456, 23456, 10000);
INSERT INTO lab."Bonus_Card" ("BC_Code", "Cl_Code", "Bonus_Sum") VALUES (2345678901234567, 34567, 5000);
INSERT INTO lab."Bonus_Card" ("BC_Code", "Cl_Code", "Bonus_Sum") VALUES (3456789012345678, 45678, 7500);
INSERT INTO lab."Bonus_Card" ("BC_Code", "Cl_Code", "Bonus_Sum") VALUES (4567890123456789, 56789, 20000);
INSERT INTO lab."Bonus_Card" ("BC_Code", "Cl_Code", "Bonus_Sum") VALUES (5678901234567890, 67890, 15000);
INSERT INTO lab."Bonus_Card" ("BC_Code", "Cl_Code", "Bonus_Sum") VALUES (6789012345678901, 78901, 30000);
INSERT INTO lab."Bonus_Card" ("BC_Code", "Cl_Code", "Bonus_Sum") VALUES (7890123456789012, 69690, 7500);
INSERT INTO lab."Bonus_Card" ("BC_Code", "Cl_Code", "Bonus_Sum") VALUES (8901234567890123, 22130, 12500);
INSERT INTO lab."Bonus_Card" ("BC_Code", "Cl_Code", "Bonus_Sum") VALUES (9012345678901234, 11223, 5000);
INSERT INTO lab."Bonus_Card" ("BC_Code", "Cl_Code", "Bonus_Sum") VALUES (123456789012345, 22334, 2500);
--вставка данных в таблицу lab."Bonus_Card"

--
-- TOC entry 3429 (class 0 OID 24702)
-- Dependencies: 219
-- Data for Name: Client; Type: TABLE DATA; Schema: lab; Owner: postgres
--

INSERT INTO lab."Client" ("Cl_Code", "Email", "Address", "Full_Name", "Passport_Data", "Tel_Num") VALUES (12345, 'john.doe@gmail.com', '123 Main St, Anytown, USA', 'John Doe', 1234567890, 71234567890);
INSERT INTO lab."Client" ("Cl_Code", "Email", "Address", "Full_Name", "Passport_Data", "Tel_Num") VALUES (23456, 'jane.smith@yahoo.com', '456 Elm St, Anytown, USA', 'Jane Smith', 2345678901, 71234567891);
INSERT INTO lab."Client" ("Cl_Code", "Email", "Address", "Full_Name", "Passport_Data", "Tel_Num") VALUES (34567, 'bob.jones@hotmail.com', '789 Maple Ave, Anytown, USA', 'Bob Jones', 3456789012, 71234567892);
INSERT INTO lab."Client" ("Cl_Code", "Email", "Address", "Full_Name", "Passport_Data", "Tel_Num") VALUES (45678, 'ligma.johnson@aol.com', '321 Oak St, Oklahoma, USA', 'Ligma Johnson', 4567890123, 71234567893);
INSERT INTO lab."Client" ("Cl_Code", "Email", "Address", "Full_Name", "Passport_Data", "Tel_Num") VALUES (56789, 'jim.smith@gmail.com', '456 Cedar Ave, Anytown, USA', 'Jim Smith', 5678901234, 71234567894);
INSERT INTO lab."Client" ("Cl_Code", "Email", "Address", "Full_Name", "Passport_Data", "Tel_Num") VALUES (67890, 'sara.doe@yahoo.com', '789 Oak St, Anytown, USA', 'Sara Doe', 6789012345, 71234567895);
INSERT INTO lab."Client" ("Cl_Code", "Email", "Address", "Full_Name", "Passport_Data", "Tel_Num") VALUES (78901, 'mike.jones@hotmail.com', '123 Elm St, Anytown, USA', 'Mike Jones', 7890123456, 71234567896);
INSERT INTO lab."Client" ("Cl_Code", "Email", "Address", "Full_Name", "Passport_Data", "Tel_Num") VALUES (89012, 'jane.doe@aol.com', '321 Maple Ave, Anytown, USA', 'Jane Doe', 8901234567, 71234567897);
INSERT INTO lab."Client" ("Cl_Code", "Email", "Address", "Full_Name", "Passport_Data", "Tel_Num") VALUES (69690, 'daniel.walker@gmail.com', '555 Oak St, Anytown, USA', 'Daniel Walker', 4352999666, 72201002958);
INSERT INTO lab."Client" ("Cl_Code", "Email", "Address", "Full_Name", "Passport_Data", "Tel_Num") VALUES (22130, 'tommie.hilfigger@yahoo.com', '777 Elm St, Anytown, USA', 'Tommy Hilfigger', 5782374837, 79992131230);
INSERT INTO lab."Client" ("Cl_Code", "Email", "Address", "Full_Name", "Passport_Data", "Tel_Num") VALUES (11223, 'bruce.wayne@hotmail.com', '444 Main St, Gotham City', 'Bruce Wayne', 1122334455, 71234567900);
INSERT INTO lab."Client" ("Cl_Code", "Email", "Address", "Full_Name", "Passport_Data", "Tel_Num") VALUES (22334, 'clark.kent@aol.com', '555 Elm St, Metropolis', 'Clark Kent', 2233445566, 71234567901);
INSERT INTO lab."Client" ("Cl_Code", "Email", "Address", "Full_Name", "Passport_Data", "Tel_Num") VALUES (12346, 'jessica.johnson@gmail.com', '456 Main St, Anytown, USA', 'Jessica Johnson', 4444444444, 71234567899);
INSERT INTO lab."Client" ("Cl_Code", "Email", "Address", "Full_Name", "Passport_Data", "Tel_Num") VALUES (23457, 'david.lee@yahoo.com', '789 Elm St, Anytown, USA', 'David Lee', 5555555555, 71234567908);
INSERT INTO lab."Client" ("Cl_Code", "Email", "Address", "Full_Name", "Passport_Data", "Tel_Num") VALUES (34568, 'amy.brown@hotmail.com', '321 Maple Ave, Anytown, USA', 'Amy Brown', 6666666666, 71234567917);
INSERT INTO lab."Client" ("Cl_Code", "Email", "Address", "Full_Name", "Passport_Data", "Tel_Num") VALUES (45679, 'michael.chang@gmail.com', '555 Cedar Ave, Anytown, USA', 'Michael Chang', 7777777777, 71234567926);
INSERT INTO lab."Client" ("Cl_Code", "Email", "Address", "Full_Name", "Passport_Data", "Tel_Num") VALUES (56790, 'mary.smith@yahoo.com', '789 Oak St, Anytown, USA', 'Mary Smith', 8888888888, 71234567935);
INSERT INTO lab."Client" ("Cl_Code", "Email", "Address", "Full_Name", "Passport_Data", "Tel_Num") VALUES (67891, 'timothy.jones@hotmail.com', '123 Main St, Anytown, USA', 'Timothy Jones', 9999999999, 71234567944);
INSERT INTO lab."Client" ("Cl_Code", "Email", "Address", "Full_Name", "Passport_Data", "Tel_Num") VALUES (78902, 'lisa.doe@aol.com', '321 Maple Ave, Anytown, USA', 'Lisa Doe', 1234432156, 71234567953);
INSERT INTO lab."Client" ("Cl_Code", "Email", "Address", "Full_Name", "Passport_Data", "Tel_Num") VALUES (89013, 'william.walker@gmail.com', '555 Oak St, Anytown, USA', 'William Walker', 6789067890, 71234567962);
INSERT INTO lab."Client" ("Cl_Code", "Email", "Address", "Full_Name", "Passport_Data", "Tel_Num") VALUES (90124, 'emma.hilfigger@yahoo.com', '777 Elm St, Anytown, USA', 'Emma Hilfigger', 5555444444, 72201002959);
INSERT INTO lab."Client" ("Cl_Code", "Email", "Address", "Full_Name", "Passport_Data", "Tel_Num") VALUES (11234, 'peter.parker@hotmail.com', '444 Main St, New York City', 'Peter Parker', 6789678967, 71234567971);
INSERT INTO lab."Client" ("Cl_Code", "Email", "Address", "Full_Name", "Passport_Data", "Tel_Num") VALUES (22345, 'tony.stark@aol.com', '555 Elm St, Malibu', 'Tony Stark', 1234237890, 71234567980);
INSERT INTO lab."Client" ("Cl_Code", "Email", "Address", "Full_Name", "Passport_Data", "Tel_Num") VALUES (33456, 'bruce.banner@gmail.com', '789 Maple Ave, Anytown, USA', 'Bruce Banner', 2333678901, 71234567999);
INSERT INTO lab."Client" ("Cl_Code", "Email", "Address", "Full_Name", "Passport_Data", "Tel_Num") VALUES (44567, 'steve.rogers@yahoo.com', '123 Oak St, Brooklyn', 'Steve Rogers', 3451569012, 71234568006);
INSERT INTO lab."Client" ("Cl_Code", "Email", "Address", "Full_Name", "Passport_Data", "Tel_Num") VALUES (55678, 'natasha.romanoff@hotmail.com', '321 Cedar Ave, Moscow', 'Natasha Romanoff', 4567824123, 71234568015);
INSERT INTO lab."Client" ("Cl_Code", "Email", "Address", "Full_Name", "Passport_Data", "Tel_Num") VALUES (66789, 'thor.odinson@gmail.com', '789 Maple Ave, Asgard', 'Thor Odinson', 5653901234, 71234568024);
-- Вставка данных в таблицу lab."Client"

--
-- TOC entry 3430 (class 0 OID 24705)
-- Dependencies: 220
-- Data for Name: Contract; Type: TABLE DATA; Schema: lab; Owner: postgres
--

INSERT INTO lab."Contract" ("Contr_Code", "Act_Transf_Client", "Act_Transf_Company", "Rent_Price", "DT_Contract", "DT_Car_Transf_To_Cl", "Factual_DT_Ret", "Late_Fee", "Ret_Mark", "Cl_Code", "Stf_Code", "Auto_Code", rent_time) VALUES (100001, 128132, 128133, 25, '2019-01-12 12:31:52', '2019-01-12 13:52:16', '2019-01-13 12:00:21', NULL, true, 45678, 123123, 312532, 24);
INSERT INTO lab."Contract" ("Contr_Code", "Act_Transf_Client", "Act_Transf_Company", "Rent_Price", "DT_Contract", "DT_Car_Transf_To_Cl", "Factual_DT_Ret", "Late_Fee", "Ret_Mark", "Cl_Code", "Stf_Code", "Auto_Code", rent_time) VALUES (100002, 128133, 128134, 30, '2019-02-14 09:45:31', '2019-02-14 11:15:22', '2019-02-15 09:50:13', NULL, true, 23456, 456789, 938227, 48);
INSERT INTO lab."Contract" ("Contr_Code", "Act_Transf_Client", "Act_Transf_Company", "Rent_Price", "DT_Contract", "DT_Car_Transf_To_Cl", "Factual_DT_Ret", "Late_Fee", "Ret_Mark", "Cl_Code", "Stf_Code", "Auto_Code", rent_time) VALUES (100003, 128135, 128136, 35, '2019-03-20 15:22:11', '2019-03-23 16:45:39', '2019-03-22 14:17:55', 25, true, 34567, 134523, 186549, 72);
INSERT INTO lab."Contract" ("Contr_Code", "Act_Transf_Client", "Act_Transf_Company", "Rent_Price", "DT_Contract", "DT_Car_Transf_To_Cl", "Factual_DT_Ret", "Late_Fee", "Ret_Mark", "Cl_Code", "Stf_Code", "Auto_Code", rent_time) VALUES (100004, 128136, 128137, 45, '2019-04-25 10:10:00', '2019-04-25 11:45:22', '2019-04-26 09:55:00', NULL, true, 45678, 456789, 375648, 24);
INSERT INTO lab."Contract" ("Contr_Code", "Act_Transf_Client", "Act_Transf_Company", "Rent_Price", "DT_Contract", "DT_Car_Transf_To_Cl", "Factual_DT_Ret", "Late_Fee", "Ret_Mark", "Cl_Code", "Stf_Code", "Auto_Code", rent_time) VALUES (100005, 128137, 128138, 50, '2019-05-16 14:30:00', '2019-05-16 16:00:00', '2019-05-18 14:30:00', 10, true, 56789, 113322, 573083, 48);
INSERT INTO lab."Contract" ("Contr_Code", "Act_Transf_Client", "Act_Transf_Company", "Rent_Price", "DT_Contract", "DT_Car_Transf_To_Cl", "Factual_DT_Ret", "Late_Fee", "Ret_Mark", "Cl_Code", "Stf_Code", "Auto_Code", rent_time) VALUES (100006, 128139, 128140, 20, '2019-06-22 09:00:00', '2019-06-22 11:00:00', '2019-06-23 12:00:00', NULL, true, 67890, 123123, 632489, 24);
INSERT INTO lab."Contract" ("Contr_Code", "Act_Transf_Client", "Act_Transf_Company", "Rent_Price", "DT_Contract", "DT_Car_Transf_To_Cl", "Factual_DT_Ret", "Late_Fee", "Ret_Mark", "Cl_Code", "Stf_Code", "Auto_Code", rent_time) VALUES (100007, 128141, 128142, 25, '2019-07-14 12:00:00', '2019-07-14 14:00:00', '2019-07-15 12:00:00', 5, true, 78901, 134523, 482949, 24);
INSERT INTO lab."Contract" ("Contr_Code", "Act_Transf_Client", "Act_Transf_Company", "Rent_Price", "DT_Contract", "DT_Car_Transf_To_Cl", "Factual_DT_Ret", "Late_Fee", "Ret_Mark", "Cl_Code", "Stf_Code", "Auto_Code", rent_time) VALUES (100008, 128143, 128144, 40, '2019-08-28 16:00:00', '2019-08-28 17:30:00', '2019-08-29 16:00:00', NULL, true, 89012, 456789, 685726, 48);
INSERT INTO lab."Contract" ("Contr_Code", "Act_Transf_Client", "Act_Transf_Company", "Rent_Price", "DT_Contract", "DT_Car_Transf_To_Cl", "Factual_DT_Ret", "Late_Fee", "Ret_Mark", "Cl_Code", "Stf_Code", "Auto_Code", rent_time) VALUES (100010, 128154, 128155, 40, '2019-10-18 14:10:22', '2019-10-18 15:30:45', '2019-10-20 14:45:20', NULL, true, 78901, 113322, 903284, 48);
INSERT INTO lab."Contract" ("Contr_Code", "Act_Transf_Client", "Act_Transf_Company", "Rent_Price", "DT_Contract", "DT_Car_Transf_To_Cl", "Factual_DT_Ret", "Late_Fee", "Ret_Mark", "Cl_Code", "Stf_Code", "Auto_Code", rent_time) VALUES (100011, 128155, 128156, 30, '2019-11-22 11:45:10', '2019-11-22 12:50:20', '2019-11-25 11:20:10', NULL, true, 11223, 134523, 776363, 72);
INSERT INTO lab."Contract" ("Contr_Code", "Act_Transf_Client", "Act_Transf_Company", "Rent_Price", "DT_Contract", "DT_Car_Transf_To_Cl", "Factual_DT_Ret", "Late_Fee", "Ret_Mark", "Cl_Code", "Stf_Code", "Auto_Code", rent_time) VALUES (100012, 128156, 128157, 25, '2019-12-25 09:00:00', '2019-12-25 10:30:15', '2019-12-26 09:15:00', NULL, true, 22334, 123123, 129303, 24);
INSERT INTO lab."Contract" ("Contr_Code", "Act_Transf_Client", "Act_Transf_Company", "Rent_Price", "DT_Contract", "DT_Car_Transf_To_Cl", "Factual_DT_Ret", "Late_Fee", "Ret_Mark", "Cl_Code", "Stf_Code", "Auto_Code", rent_time) VALUES (100013, 128157, 128158, 35, '2020-01-31 13:20:45', '2020-01-31 14:45:30', '2020-02-01 13:30:00', NULL, true, 45679, 134523, 573083, 24);
INSERT INTO lab."Contract" ("Contr_Code", "Act_Transf_Client", "Act_Transf_Company", "Rent_Price", "DT_Contract", "DT_Car_Transf_To_Cl", "Factual_DT_Ret", "Late_Fee", "Ret_Mark", "Cl_Code", "Stf_Code", "Auto_Code", rent_time) VALUES (100014, 128158, 128159, 40, '2020-03-10 16:55:00', '2020-03-10 18:15:25', '2020-03-11 16:40:00', 5, true, 34568, 456789, 129303, 48);
INSERT INTO lab."Contract" ("Contr_Code", "Act_Transf_Client", "Act_Transf_Company", "Rent_Price", "DT_Contract", "DT_Car_Transf_To_Cl", "Factual_DT_Ret", "Late_Fee", "Ret_Mark", "Cl_Code", "Stf_Code", "Auto_Code", rent_time) VALUES (100015, 128160, 128161, 30, '2020-04-15 11:20:00', '2020-04-15 12:30:45', '2020-04-16 12:30:00', NULL, true, 12345, 123123, 938227, 24);
INSERT INTO lab."Contract" ("Contr_Code", "Act_Transf_Client", "Act_Transf_Company", "Rent_Price", "DT_Contract", "DT_Car_Transf_To_Cl", "Factual_DT_Ret", "Late_Fee", "Ret_Mark", "Cl_Code", "Stf_Code", "Auto_Code", rent_time) VALUES (100016, 128161, 128162, 35, '2020-05-20 09:10:00', '2020-05-20 10:40:20', '2020-05-21 09:50:00', NULL, true, 34567, 134523, 186549, 48);
INSERT INTO lab."Contract" ("Contr_Code", "Act_Transf_Client", "Act_Transf_Company", "Rent_Price", "DT_Contract", "DT_Car_Transf_To_Cl", "Factual_DT_Ret", "Late_Fee", "Ret_Mark", "Cl_Code", "Stf_Code", "Auto_Code", rent_time) VALUES (100017, 128163, 128164, 25, '2020-06-25 14:30:00', '2020-06-25 16:00:15', '2020-06-26 13:45:00', NULL, true, 45678, 456789, 375648, 24);
INSERT INTO lab."Contract" ("Contr_Code", "Act_Transf_Client", "Act_Transf_Company", "Rent_Price", "DT_Contract", "DT_Car_Transf_To_Cl", "Factual_DT_Ret", "Late_Fee", "Ret_Mark", "Cl_Code", "Stf_Code", "Auto_Code", rent_time) VALUES (100018, 128162, 128163, 40, '2020-05-20 11:30:00', '2020-05-20 12:45:00', '2020-05-21 11:20:00', 10, true, 23456, 123123, 312532, 24);
INSERT INTO lab."Contract" ("Contr_Code", "Act_Transf_Client", "Act_Transf_Company", "Rent_Price", "DT_Contract", "DT_Car_Transf_To_Cl", "Factual_DT_Ret", "Late_Fee", "Ret_Mark", "Cl_Code", "Stf_Code", "Auto_Code", rent_time) VALUES (100019, 128164, 128165, 35, '2020-06-18 09:00:00', '2020-06-18 10:15:00', '2020-06-20 08:45:00', NULL, false, 34567, 134523, 186549, 48);
INSERT INTO lab."Contract" ("Contr_Code", "Act_Transf_Client", "Act_Transf_Company", "Rent_Price", "DT_Contract", "DT_Car_Transf_To_Cl", "Factual_DT_Ret", "Late_Fee", "Ret_Mark", "Cl_Code", "Stf_Code", "Auto_Code", rent_time) VALUES (100020, 128166, 128167, 45, '2020-07-25 14:00:00', '2020-07-25 15:30:00', '2020-07-26 14:15:00', NULL, true, 45678, 456789, 375648, 24);
--Вставка данных в таблицу lab."Contract"
--Цена аренды автомобиля вставлена как заглушка, в дальнейшем будет вычисляться по формуле (rent_time<24): rent_time * Price_One_H; (rent_time>=24): rent_time/24 * Price_Long_Inter 

--
-- TOC entry 3431 (class 0 OID 24708)
-- Dependencies: 221
-- Data for Name: Extension; Type: TABLE DATA; Schema: lab; Owner: postgres
--

INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (1, 100001, '2019-01-13 14:52:16', 1, 1);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (2, 100001, '2019-01-13 15:52:16', 2, 2);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (3, 100001, '2019-01-13 16:52:16', 3, 3);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (4, 100001, '2019-01-13 17:52:16', 4, 4);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (5, 100001, '2019-01-13 18:52:16', 5, 5);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (6, 100001, '2019-01-13 19:52:16', 6, 6);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (7, 100001, '2019-01-13 20:52:16', 7, 7);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (8, 100001, '2019-01-13 21:52:16', 8, 8);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (9, 100001, '2019-01-13 22:52:16', 9, 9);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (10, 100001, '2019-01-13 23:52:16', 10, 10);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (11, 100002, '2019-02-16 12:15:22', 1, 1);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (12, 100002, '2019-02-16 13:15:22', 2, 2);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (13, 100002, '2019-02-16 14:15:22', 3, 3);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (14, 100002, '2019-02-16 15:15:22', 4, 4);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (21, 100003, '2019-03-26 17:45:39', 1, 1);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (22, 100003, '2019-03-26 18:45:39', 2, 2);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (23, 100003, '2019-03-26 19:45:39', 3, 3);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (24, 100003, '2019-03-26 20:45:39', 4, 4);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (25, 100003, '2019-03-26 21:45:39', 5, 5);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (26, 100003, '2019-03-26 22:45:39', 6, 6);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (27, 100003, '2019-03-26 23:45:39', 7, 7);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (28, 100003, '2019-03-27 00:45:39', 8, 8);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (29, 100003, '2019-03-27 01:45:39', 9, 9);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (30, 100003, '2019-03-27 02:45:39', 10, 10);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (31, 100004, '2019-04-26 12:45:22', 1, 1);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (32, 100004, '2019-04-26 13:45:22', 2, 2);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (33, 100004, '2019-04-26 14:45:22', 3, 3);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (34, 100004, '2019-04-26 15:45:22', 4, 4);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (35, 100004, '2019-04-26 16:45:22', 5, 5);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (36, 100004, '2019-04-26 17:45:22', 6, 6);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (37, 100004, '2019-04-26 18:45:22', 7, 7);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (38, 100004, '2019-04-26 19:45:22', 8, 8);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (39, 100004, '2019-04-26 20:45:22', 9, 9);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (40, 100004, '2019-04-26 21:45:22', 10, 10);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (41, 100005, '2019-05-18 17:00:00', 1, 1);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (42, 100005, '2019-05-18 18:00:00', 2, 2);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (43, 100005, '2019-05-18 19:00:00', 3, 3);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (44, 100005, '2019-05-18 20:00:00', 4, 4);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (45, 100005, '2019-05-18 21:00:00', 5, 5);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (46, 100005, '2019-05-18 22:00:00', 6, 6);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (47, 100005, '2019-05-18 23:00:00', 7, 7);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (48, 100005, '2019-05-19 00:00:00', 8, 8);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (49, 100005, '2019-05-19 01:00:00', 9, 9);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (50, 100005, '2019-05-19 02:00:00', 10, 10);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (51, 100006, '2019-06-23 12:00:00', 1, 1);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (52, 100006, '2019-06-23 13:00:00', 2, 2);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (53, 100006, '2019-06-23 14:00:00', 3, 3);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (54, 100006, '2019-06-23 15:00:00', 4, 4);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (55, 100006, '2019-06-23 16:00:00', 5, 5);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (56, 100006, '2019-06-23 17:00:00', 6, 6);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (57, 100006, '2019-06-23 18:00:00', 7, 7);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (58, 100006, '2019-06-23 19:00:00', 8, 8);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (59, 100006, '2019-06-23 20:00:00', 9, 9);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (60, 100006, '2019-06-23 21:00:00', 10, 10);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (61, 100007, '2019-07-15 15:00:00', 1, 1);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (62, 100007, '2019-07-15 16:00:00', 2, 2);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (63, 100007, '2019-07-15 17:00:00', 3, 3);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (64, 100007, '2019-07-15 18:00:00', 4, 4);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (65, 100007, '2019-07-15 19:00:00', 5, 5);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (66, 100007, '2019-07-15 20:00:00', 6, 6);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (67, 100007, '2019-07-15 21:00:00', 7, 7);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (68, 100007, '2019-07-15 22:00:00', 8, 8);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (69, 100007, '2019-07-15 23:00:00', 9, 9);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (70, 100007, '2019-07-16 00:00:00', 10, 10);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (71, 100008, '2019-08-30 18:30:00', 1, 1);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (72, 100008, '2019-08-30 19:30:00', 2, 2);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (73, 100008, '2019-08-30 20:30:00', 3, 3);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (74, 100008, '2019-08-30 21:30:00', 4, 4);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (75, 100008, '2019-08-30 22:30:00', 5, 5);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (76, 100008, '2019-08-30 23:30:00', 6, 6);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (77, 100008, '2019-08-31 00:30:00', 7, 7);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (78, 100008, '2019-08-31 01:30:00', 8, 8);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (79, 100008, '2019-08-31 02:30:00', 9, 9);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (80, 100008, '2019-08-31 03:30:00', 10, 10);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (81, 100010, '2019-10-20 16:30:45', 1, 1);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (82, 100010, '2019-10-20 17:30:45', 2, 2);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (83, 100010, '2019-10-20 18:30:45', 3, 3);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (84, 100010, '2019-10-20 19:30:45', 4, 4);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (85, 100010, '2019-10-20 20:30:45', 5, 5);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (86, 100010, '2019-10-20 21:30:45', 6, 6);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (87, 100010, '2019-10-20 22:30:45', 7, 7);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (88, 100010, '2019-10-20 23:30:45', 8, 8);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (89, 100010, '2019-10-21 00:30:45', 9, 9);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (90, 100010, '2019-10-21 01:30:45', 10, 10);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (91, 100011, '2019-11-25 13:50:20', 1, 1);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (92, 100011, '2019-11-25 14:50:20', 2, 2);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (93, 100011, '2019-11-25 15:50:20', 3, 3);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (94, 100011, '2019-11-25 16:50:20', 4, 4);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (95, 100011, '2019-11-25 17:50:20', 5, 5);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (96, 100011, '2019-11-25 18:50:20', 6, 6);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (97, 100011, '2019-11-25 19:50:20', 7, 7);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (98, 100011, '2019-11-25 20:50:20', 8, 8);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (99, 100011, '2019-11-25 21:50:20', 9, 9);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (100, 100011, '2019-11-25 22:50:20', 10, 10);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (101, 100012, '2019-12-26 11:30:15', 1, 1);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (102, 100012, '2019-12-26 12:30:15', 2, 2);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (103, 100012, '2019-12-26 13:30:15', 3, 3);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (104, 100012, '2019-12-26 14:30:15', 4, 4);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (105, 100012, '2019-12-26 15:30:15', 5, 5);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (106, 100012, '2019-12-26 16:30:15', 6, 6);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (107, 100012, '2019-12-26 17:30:15', 7, 7);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (108, 100012, '2019-12-26 18:30:15', 8, 8);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (109, 100012, '2019-12-26 19:30:15', 9, 9);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (110, 100012, '2019-12-26 20:30:15', 10, 10);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (111, 100013, '2020-02-01 15:45:30', 1, 1);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (112, 100013, '2020-02-01 16:45:30', 2, 2);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (113, 100013, '2020-02-01 17:45:30', 3, 3);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (114, 100013, '2020-02-01 18:45:30', 4, 4);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (115, 100013, '2020-02-01 19:45:30', 5, 5);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (116, 100013, '2020-02-01 20:45:30', 6, 6);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (117, 100013, '2020-02-01 21:45:30', 7, 7);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (118, 100013, '2020-02-01 22:45:30', 8, 8);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (119, 100013, '2020-02-01 23:45:30', 9, 9);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (120, 100013, '2020-02-02 00:45:30', 10, 10);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (121, 100014, '2020-03-12 19:15:25', 1, 1);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (122, 100014, '2020-03-12 20:15:25', 2, 2);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (123, 100014, '2020-03-12 21:15:25', 3, 3);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (124, 100014, '2020-03-12 22:15:25', 4, 4);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (125, 100014, '2020-03-12 23:15:25', 5, 5);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (126, 100014, '2020-03-13 00:15:25', 6, 6);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (127, 100014, '2020-03-13 01:15:25', 7, 7);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (128, 100014, '2020-03-13 02:15:25', 8, 8);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (129, 100014, '2020-03-13 03:15:25', 9, 9);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (130, 100014, '2020-03-13 04:15:25', 10, 10);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (131, 100015, '2020-04-16 13:30:45', 1, 1);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (132, 100015, '2020-04-16 14:30:45', 2, 2);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (133, 100015, '2020-04-16 15:30:45', 3, 3);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (134, 100015, '2020-04-16 16:30:45', 4, 4);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (135, 100015, '2020-04-16 17:30:45', 5, 5);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (136, 100015, '2020-04-16 18:30:45', 6, 6);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (137, 100015, '2020-04-16 19:30:45', 7, 7);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (138, 100015, '2020-04-16 20:30:45', 8, 8);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (139, 100015, '2020-04-16 21:30:45', 9, 9);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (140, 100015, '2020-04-16 22:30:45', 10, 10);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (141, 100016, '2020-05-22 11:40:20', 1, 1);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (142, 100016, '2020-05-22 12:40:20', 2, 2);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (143, 100016, '2020-05-22 13:40:20', 3, 3);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (144, 100016, '2020-05-22 14:40:20', 4, 4);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (145, 100016, '2020-05-22 15:40:20', 5, 5);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (146, 100016, '2020-05-22 16:40:20', 6, 6);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (147, 100016, '2020-05-22 17:40:20', 7, 7);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (148, 100016, '2020-05-22 18:40:20', 8, 8);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (149, 100016, '2020-05-22 19:40:20', 9, 9);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (150, 100016, '2020-05-22 20:40:20', 10, 10);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (151, 100017, '2020-06-26 17:00:15', 1, 1);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (152, 100017, '2020-06-26 18:00:15', 2, 2);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (153, 100017, '2020-06-26 19:00:15', 3, 3);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (154, 100017, '2020-06-26 20:00:15', 4, 4);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (155, 100017, '2020-06-26 21:00:15', 5, 5);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (156, 100017, '2020-06-26 22:00:15', 6, 6);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (157, 100017, '2020-06-26 23:00:15', 7, 7);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (158, 100017, '2020-06-27 00:00:15', 8, 8);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (159, 100017, '2020-06-27 01:00:15', 9, 9);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (160, 100017, '2020-06-27 02:00:15', 10, 10);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (161, 100018, '2020-05-21 13:45:00', 1, 1);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (162, 100018, '2020-05-21 14:45:00', 2, 2);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (163, 100018, '2020-05-21 15:45:00', 3, 3);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (164, 100018, '2020-05-21 16:45:00', 4, 4);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (165, 100018, '2020-05-21 17:45:00', 5, 5);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (166, 100018, '2020-05-21 18:45:00', 6, 6);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (167, 100018, '2020-05-21 19:45:00', 7, 7);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (168, 100018, '2020-05-21 20:45:00', 8, 8);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (169, 100018, '2020-05-21 21:45:00', 9, 9);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (170, 100018, '2020-05-21 22:45:00', 10, 10);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (171, 100019, '2020-06-20 11:15:00', 1, 1);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (172, 100019, '2020-06-20 12:15:00', 2, 2);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (173, 100019, '2020-06-20 13:15:00', 3, 3);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (174, 100019, '2020-06-20 14:15:00', 4, 4);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (175, 100019, '2020-06-20 15:15:00', 5, 5);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (176, 100019, '2020-06-20 16:15:00', 6, 6);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (177, 100019, '2020-06-20 17:15:00', 7, 7);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (178, 100019, '2020-06-20 18:15:00', 8, 8);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (179, 100019, '2020-06-20 19:15:00', 9, 9);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (180, 100019, '2020-06-20 20:15:00', 10, 10);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (181, 100020, '2020-07-26 16:30:00', 1, 1);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (182, 100020, '2020-07-26 17:30:00', 2, 2);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (183, 100020, '2020-07-26 18:30:00', 3, 3);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (184, 100020, '2020-07-26 19:30:00', 4, 4);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (185, 100020, '2020-07-26 20:30:00', 5, 5);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (186, 100020, '2020-07-26 21:30:00', 6, 6);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (187, 100020, '2020-07-26 22:30:00', 7, 7);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (188, 100020, '2020-07-26 23:30:00', 8, 8);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (189, 100020, '2020-07-27 00:30:00', 9, 9);
INSERT INTO lab."Extension" ("Extension_Id", "Contr_Code", "New_DT_Ret", "Ext_Hours", "Sequence_Num") VALUES (190, 100020, '2020-07-27 01:30:00', 10, 10);
--Вставка данных в таблицу lab."Extension"
--Новая дата возврата вставлена как заглушка и в будущем будет вычисляться в триггере

--
-- TOC entry 3432 (class 0 OID 24711)
-- Dependencies: 222
-- Data for Name: Model; Type: TABLE DATA; Schema: lab; Owner: postgres
--

INSERT INTO lab."Model" ("Mod_Code", "Name", "Characteristics", "Description", "Market_Price", "Bail_Sum") VALUES (294832, 'Audi A6', 'Engine: 3.0L V6, Transmission: 8-speed automatic, Horsepower: 335, Torque: 369 lb-ft, Fuel Economy: 22 mpg city / 29 mpg hwy, Drive Type: All Wheel Drive', 'The Audi A6 is a mid-size luxury sedan that features cutting-edge technology and sleek design. With its powerful engine, smooth ride, and spacious interior, its the perfect car for those who want a balance of comfort and performance.', 110000, 1000);
INSERT INTO lab."Model" ("Mod_Code", "Name", "Characteristics", "Description", "Market_Price", "Bail_Sum") VALUES (345678, 'BMW X5', 'Engine: 3.0L 6-cylinder, 300 hp. Transmission: 8-speed automatic. Drivetrain: All-wheel drive. Fuel economy: 20/27 mpg. Seating: 5. Cargo volume: 72.3 cubic feet.', 'The BMW X5 is a luxury midsize SUV that offers a sporty and dynamic driving experience, premium interior, and advanced technology features.', 95900, 960);
INSERT INTO lab."Model" ("Mod_Code", "Name", "Characteristics", "Description", "Market_Price", "Bail_Sum") VALUES (456789, 'Mercedes-Benz E-Class', 'Engine: 2.0L 4-cylinder, 255 hp. Transmission: 9-speed automatic. Drivetrain: Rear-wheel drive. Fuel economy: 21/30 mpg. Seating: 5. Cargo volume: 13.1 cubic feet.', 'The Mercedes-Benz E-Class is a luxury midsize car that offers a comfortable and high-tech interior, refined ride, and a wide range of engine options.', 56750, 570);
INSERT INTO lab."Model" ("Mod_Code", "Name", "Characteristics", "Description", "Market_Price", "Bail_Sum") VALUES (567890, 'Lexus LS', 'Engine: 3.5L V6, 416 hp. Transmission: 10-speed automatic. Drivetrain: Rear-wheel drive. Fuel economy: 19/30 mpg. Seating: 5. Cargo volume: 16.95 cubic feet.', 'The Lexus LS is a luxury large car that offers a spacious and well-crafted interior, comfortable ride, and advanced safety features.', 70000, 700);
INSERT INTO lab."Model" ("Mod_Code", "Name", "Characteristics", "Description", "Market_Price", "Bail_Sum") VALUES (678901, 'Jaguar F-Type', 'Engine: 2.0L 4-cylinder, 296 hp. Transmission: 8-speed automatic. Drivetrain: Rear-wheel drive. Fuel economy: 23/30 mpg. Seating: 2. Cargo volume: 14.4 cubic feet.', 'The Jaguar F-Type is a luxury sports car that offers a sleek and sexy design, lively and agile handling, and a range of powerful engine options.', 68000, 680);
INSERT INTO lab."Model" ("Mod_Code", "Name", "Characteristics", "Description", "Market_Price", "Bail_Sum") VALUES (789012, 'Porsche Panamera', 'Engine: 2.9L V6, 325 hp. Transmission: 8-speed automatic. Drivetrain: Rear-wheel drive. Fuel economy: 19/27 mpg. Seating: 4. Cargo volume: 17.6 cubic feet.', 'The Porsche Panamera is a luxury large car that offers a thrilling and engaging driving experience, top-notch interior, and impressive performance.', 123750, 1240);
INSERT INTO lab."Model" ("Mod_Code", "Name", "Characteristics", "Description", "Market_Price", "Bail_Sum") VALUES (890123, 'Tesla Model S', 'Motor: Electric, 670 hp. Transmission: Single-speed direct drive. Drivetrain: All-wheel drive. Range: 412 miles. Seating: 5. Cargo volume: 28.4 cubic feet.', 'The Tesla Model S is an all-electric luxury sedan that offers a futuristic and minimalist interior, lightning-fast acceleration, and cutting-edge technology features.', 91300, 930);
INSERT INTO lab."Model" ("Mod_Code", "Name", "Characteristics", "Description", "Market_Price", "Bail_Sum") VALUES (901234, 'Audi Q7', 'Engine: 3.0L V6, 335 hp. Transmission: 8-speed automatic. Drivetrain: All-wheel drive. Fuel economy: 18/23 mpg. Seating: 7. Cargo volume: 69.9 cubic feet.', 'The Audi Q7 is a luxury midsize SUV that offers a spacious and versatile interior, smooth and composed ride, and a range of advanced safety and technology features.', 54300, 550);
--Вставка данных в таблицу lab."Model"

--
-- TOC entry 3433 (class 0 OID 24716)
-- Dependencies: 223
-- Data for Name: Penalties; Type: TABLE DATA; Schema: lab; Owner: postgres
--

INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (101, '2023-03-13 04:05:11', 'Cl', true, 775.91);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (102, '2019-07-17 03:34:27', 'Cl', true, 342.56);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (103, '2023-03-18 02:12:37', 'Co', true, 352.16);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (104, '2021-01-26 17:52:45', 'Ot', true, 787.2);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (105, '2018-01-17 11:40:00', 'Ot', true, 50.96);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (106, '2019-05-12 05:45:24', 'Co', true, 240.68);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (107, '2020-07-20 22:27:19', 'Ot', true, 897.62);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (108, '2020-11-10 12:41:37', 'Cl', true, 705.84);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (109, '2019-12-19 19:14:05', 'Cl', true, 978.71);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (110, '2023-05-15 20:41:11', 'Cl', true, 810.03);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (111, '2023-10-12 13:51:47', 'Co', true, 920.81);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (112, '2021-09-15 20:29:29', 'Cl', true, 479.59);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (113, '2020-02-28 01:54:23', 'Cl', true, 162.91);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (114, '2020-11-04 22:05:37', 'Ot', true, 313.58);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (115, '2021-06-26 10:01:46', 'Cl', true, 382.79);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (116, '2018-04-07 23:01:37', 'Ot', true, 844.72);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (117, '2020-04-08 13:07:54', 'Co', true, 31.4);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (118, '2020-09-03 07:39:11', 'Ot', true, 367.41);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (119, '2022-11-02 12:42:36', 'Co', true, 383.78);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (120, '2018-11-18 12:07:05', 'Ot', true, 423.66);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (121, '2021-11-29 02:39:40', 'Co', true, 137.56);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (122, '2019-06-04 05:41:17', 'Ot', true, 984.77);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (123, '2021-08-31 23:21:50', 'Cl', true, 585.26);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (124, '2019-10-16 11:35:17', 'Cl', true, 250.44);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (125, '2020-10-28 00:53:47', 'Co', true, 76.11);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (126, '2022-09-16 20:58:34', 'Co', true, 414.38);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (127, '2021-08-31 23:21:50', 'Cl', true, 58.2);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (128, '2020-10-17 14:04:28', 'Co', true, 354.41);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (129, '2021-09-30 22:29:37', 'Cl', true, 524.87);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (130, '2019-03-17 06:07:51', 'Cl', true, 692.03);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (131, '2019-02-24 09:13:20', 'Cl', true, 692.26);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (132, '2018-02-24 01:27:08', 'Ot', true, 722.66);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (133, '2020-09-23 05:42:30', 'Co', true, 484.34);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (134, '2022-08-03 01:38:50', 'Cl', true, 895.57);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (135, '2020-07-20 22:27:19', 'Co', true, 555.55);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (136, '2023-05-23 09:17:58', 'Co', true, 137.38);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (137, '2020-06-20 18:38:22', 'Ot', true, 20.96);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (138, '2018-10-24 05:22:02', 'Ot', true, 908.04);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (139, '2023-12-05 10:33:49', 'Ot', true, 977.92);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (140, '2019-10-07 10:59:26', 'Cl', true, 117.24);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (141, '2018-03-05 14:01:06', 'Ot', true, 91.65);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (142, '2018-05-22 01:15:37', 'Ot', true, 990.97);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (143, '2018-11-18 12:07:05', 'Co', true, 69.03);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (144, '2023-02-16 05:49:57', 'Ot', true, 478.98);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (145, '2022-07-09 06:52:58', 'Ot', true, 298.16);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (146, '2023-10-05 04:43:56', 'Cl', true, 90.51);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (147, '2021-12-25 22:47:21', 'Co', true, 650.19);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (148, '2020-02-28 01:54:23', 'Ot', true, 967.92);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (149, '2020-03-02 00:01:42', 'Co', true, 338.53);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (150, '2020-01-20 14:31:51', 'Co', true, 635.69);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (151, '2020-02-28 01:54:23', 'Cl', true, 748.36);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (152, '2019-06-04 05:41:17', 'Co', true, 384.64);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (153, '2021-02-06 02:10:46', 'Ot', true, 93.31);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (154, '2022-11-11 07:13:46', 'Cl', true, 371.13);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (155, '2022-06-29 21:09:17', 'Cl', true, 802.83);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (156, '2022-07-09 06:52:58', 'Cl', true, 317.23);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (157, '2020-10-24 14:37:35', 'Cl', true, 764.26);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (158, '2019-10-17 16:58:38', 'Co', true, 997.49);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (159, '2018-01-31 12:43:09', 'Cl', true, 361.39);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (160, '2018-08-10 00:30:08', 'Ot', true, 547.05);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (161, '2021-08-18 19:30:18', 'Ot', true, 435.8);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (162, '2020-09-03 07:39:11', 'Ot', true, 589.17);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (163, '2020-06-26 04:30:55', 'Cl', true, 265.95);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (164, '2018-08-10 00:30:08', 'Ot', true, 246.03);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (165, '2018-11-01 22:31:53', 'Ot', true, 341.04);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (166, '2022-08-03 01:38:50', 'Co', true, 376.71);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (167, '2021-01-09 02:15:01', 'Cl', true, 845.15);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (168, '2018-07-05 12:42:25', 'Ot', true, 193.76);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (169, '2022-06-01 13:21:27', 'Ot', true, 974.44);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (170, '2021-01-09 02:15:01', 'Cl', true, 183.08);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (171, '2023-06-04 11:26:51', 'Ot', true, 986.47);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (172, '2023-01-26 06:07:37', 'Ot', true, 611.45);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (173, '2023-06-30 10:18:21', 'Co', true, 451.14);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (174, '2019-08-14 10:40:44', 'Ot', true, 715.44);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (175, '2019-07-15 08:04:04', 'Co', true, 493.3);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (176, '2020-06-26 04:30:55', 'Cl', true, 259.51);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (177, '2019-11-18 04:49:43', 'Cl', true, 292.48);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (178, '2019-09-10 09:02:07', 'Co', true, 341.71);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (179, '2021-12-10 00:15:10', 'Cl', true, 987.49);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (180, '2021-09-15 20:29:29', 'Ot', true, 58.19);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (181, '2019-08-11 04:07:35', 'Cl', true, 814.88);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (182, '2020-12-06 09:47:56', 'Co', true, 250.28);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (183, '2018-04-23 17:55:37', 'Ot', true, 379.48);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (184, '2019-10-14 05:47:08', 'Cl', true, 396.42);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (185, '2023-05-14 07:33:39', 'Ot', true, 439.74);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (186, '2021-04-25 02:38:44', 'Cl', true, 953.25);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (187, '2019-02-24 09:13:20', 'Ot', true, 765.14);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (188, '2021-12-09 05:19:01', 'Ot', true, 564.64);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (189, '2020-09-03 07:39:11', 'Ot', true, 407.34);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (190, '2022-06-22 01:03:39', 'Co', true, 738.8);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (191, '2019-07-17 03:34:27', 'Co', true, 320.53);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (192, '2022-01-31 16:25:54', 'Cl', true, 113.75);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (193, '2023-10-12 13:51:47', 'Ot', true, 252);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (194, '2023-01-24 17:14:11', 'Ot', true, 723.44);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (195, '2018-11-18 12:07:05', 'Ot', true, 411.69);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (196, '2019-05-19 19:07:27', 'Cl', true, 891.16);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (197, '2021-05-06 18:46:02', 'Ot', true, 24.09);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (198, '2022-10-31 03:57:51', 'Ot', true, 985.05);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (199, '2022-06-01 13:21:27', 'Ot', true, 542.6);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (200, '2020-03-02 00:01:42', 'Co', true, 598.14);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (201, '2023-03-14 03:37:27', 'Cl', true, 567.28);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (202, '2023-09-22 15:20:49', 'Ot', true, 288.76);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (203, '2021-06-26 10:01:46', 'Ot', true, 531.7);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (204, '2018-07-15 19:47:33', 'Co', true, 317.25);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (205, '2020-11-10 12:41:37', 'Co', true, 732.06);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (206, '2021-09-05 12:06:02', 'Ot', true, 225.35);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (207, '2021-11-01 06:58:08', 'Cl', true, 161.76);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (208, '2020-05-29 01:19:14', 'Cl', true, 618.85);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (209, '2019-07-15 08:04:04', 'Ot', true, 213.64);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (210, '2018-04-07 23:01:37', 'Co', true, 367.78);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (211, '2022-06-16 17:53:04', 'Co', true, 918.53);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (212, '2022-09-24 23:31:48', 'Cl', true, 873.09);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (213, '2018-09-27 02:29:55', 'Co', true, 455.55);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (214, '2019-12-04 03:15:04', 'Ot', true, 170.62);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (215, '2018-12-11 07:47:56', 'Cl', true, 620.89);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (216, '2021-09-02 14:09:40', 'Co', true, 594.98);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (217, '2023-05-19 02:20:05', 'Cl', true, 992.12);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (218, '2018-03-05 14:01:06', 'Cl', true, 934.91);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (219, '2023-12-05 10:33:49', 'Ot', true, 403.35);
INSERT INTO lab."Penalties" ("Penalty_Code", "Accident_DT", "Who_Pays", "Payment_Status", "Penalty_Sum") VALUES (220, '2021-10-23 04:08:48', 'Cl', false, 338.82);
--Вставка данных в таблицу lab."Penalties"
--Penalty_Sum - сумма штрафа вставлена как заглушка, в будущем будет вычисляться по формуле SUM(rtr_viol_fee) where Violation.Penalty_Code = Penalties.Penalty_Code

--
-- TOC entry 3434 (class 0 OID 24719)
-- Dependencies: 224
-- Data for Name: Price; Type: TABLE DATA; Schema: lab; Owner: postgres
--

INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 88, 2112, 4860);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 54, 1296, 4861);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 97, 2328, 4862);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 68, 1632, 4863);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 80, 1920, 4864);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 83, 1992, 4865);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 51, 1224, 4866);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 80, 1920, 4867);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 82, 1968, 4868);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 79, 1896, 4869);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 50, 1200, 4870);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 53, 1272, 4871);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 68, 1632, 4872);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 86, 2064, 4873);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 90, 2160, 4874);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 59, 1416, 4875);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 51, 1224, 4876);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 96, 2304, 4877);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 51, 1224, 4878);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 88, 2112, 4879);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 97, 2328, 4880);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 68, 1632, 4881);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 74, 1776, 4882);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 93, 2232, 4883);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 64, 1536, 4884);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 89, 2136, 4885);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 58, 1392, 4886);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 95, 2280, 4887);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 67, 1608, 4888);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 55, 1320, 4889);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 84, 2016, 4890);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 75, 1800, 4891);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 68, 1632, 4892);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 53, 1272, 4893);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 77, 1848, 4894);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 96, 2304, 4895);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 63, 1512, 4896);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 76, 1824, 4897);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 89, 2136, 4898);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 86, 2064, 4899);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 55, 1320, 4900);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 63, 1512, 4901);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 51, 1224, 4902);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 69, 1656, 4903);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 65, 1560, 4904);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 92, 2208, 4905);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 72, 1728, 4906);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 96, 2304, 4907);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 74, 1776, 4908);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 70, 1680, 4909);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 91, 2184, 4910);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 60, 1440, 4911);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 97, 2328, 4912);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 69, 1656, 4913);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 62, 1488, 4914);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 64, 1536, 4915);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 85, 2040, 4916);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 69, 1656, 4917);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 79, 1896, 4918);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 56, 1344, 4919);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 94, 2256, 4920);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 79, 1896, 4921);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 98, 2352, 4922);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 56, 1344, 4923);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 96, 2304, 4924);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 51, 1224, 4925);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 92, 2208, 4926);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 99, 2376, 4927);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 64, 1536, 4928);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 75, 1800, 4929);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 51, 1224, 4930);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 80, 1920, 4931);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 77, 1848, 4932);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 95, 2280, 4933);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 75, 1800, 4934);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 52, 1248, 4935);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 55, 1320, 4936);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 65, 1560, 4937);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 82, 1968, 4938);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 62, 1488, 4939);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 78, 1872, 4940);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 61, 1464, 4941);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 92, 2208, 4942);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 84, 2016, 4943);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 55, 1320, 4944);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 59, 1416, 4945);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 53, 1272, 4946);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 78, 1872, 4947);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 61, 1464, 4948);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 84, 2016, 4949);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 93, 2232, 4950);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 56, 1344, 4951);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 88, 2112, 4952);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 77, 1848, 4953);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 75, 1800, 4954);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 98, 2352, 4955);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 62, 1488, 4956);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 80, 1920, 4957);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 53, 1272, 4958);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 98, 2352, 4959);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 71, 1704, 4960);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 94, 2256, 4961);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 66, 1584, 4962);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 52, 1248, 4963);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 81, 1944, 4964);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 88, 2112, 4965);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 100, 2400, 4966);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 61, 1464, 4967);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 88, 2112, 4968);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 70, 1680, 4969);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 63, 1512, 4970);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 78, 1872, 4971);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 94, 2256, 4972);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 86, 2064, 4973);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 73, 1752, 4974);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 63, 1512, 4975);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 70, 1680, 4976);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 85, 2040, 4977);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 50, 1200, 4978);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 85, 2040, 4979);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 97, 2328, 4980);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 87, 2088, 4981);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 74, 1776, 4982);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 69, 1656, 4983);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 82, 1968, 4984);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 99, 2376, 4985);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 67, 1608, 4986);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 92, 2208, 4987);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 97, 2328, 4988);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 61, 1464, 4989);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 74, 1776, 4990);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 68, 1632, 4991);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 93, 2232, 4992);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 58, 1392, 4993);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 81, 1944, 4994);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 58, 1392, 4995);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 54, 1296, 4996);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 100, 2400, 4997);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 97, 2328, 4998);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 79, 1896, 4999);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 68, 1632, 5000);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 80, 1920, 5001);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 89, 2136, 5002);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 57, 1368, 5003);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 79, 1896, 5004);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 73, 1752, 5005);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 58, 1392, 5006);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 79, 1896, 5007);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 69, 1656, 5008);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 87, 2088, 5009);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 83, 1992, 5010);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 58, 1392, 5011);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 68, 1632, 5012);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 89, 2136, 5013);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 69, 1656, 5014);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 52, 1248, 5015);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 95, 2280, 5016);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 69, 1656, 5017);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 94, 2256, 5018);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 80, 1920, 5019);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 61, 1464, 5020);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 86, 2064, 5021);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 55, 1320, 5022);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 79, 1896, 5023);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 67, 1608, 5024);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 97, 2328, 5025);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 90, 2160, 5026);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 60, 1440, 5027);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 80, 1920, 5028);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 63, 1512, 5029);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 90, 2160, 5030);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 85, 2040, 5031);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 66, 1584, 5032);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 82, 1968, 5033);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 62, 1488, 5034);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 64, 1536, 5035);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 68, 1632, 5036);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 94, 2256, 5037);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 64, 1536, 5038);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 59, 1416, 5039);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 78, 1872, 5040);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 66, 1584, 5041);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 55, 1320, 5042);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 60, 1440, 5043);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 76, 1824, 5044);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 95, 2280, 5045);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 68, 1632, 5046);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 83, 1992, 5047);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 95, 2280, 5048);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 66, 1584, 5049);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 94, 2256, 5050);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 69, 1656, 5051);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 96, 2304, 5052);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 70, 1680, 5053);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 59, 1416, 5054);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 96, 2304, 5055);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 62, 1488, 5056);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 78, 1872, 5057);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 89, 2136, 5058);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 76, 1824, 5059);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 82, 1968, 5060);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 93, 2232, 5061);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 51, 1224, 5062);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 76, 1824, 5063);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 96, 2304, 5064);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 65, 1560, 5065);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 58, 1392, 5066);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 86, 2064, 5067);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 99, 2376, 5068);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 94, 2256, 5069);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 51, 1224, 5070);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 62, 1488, 5071);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 51, 1224, 5072);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 87, 2088, 5073);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 91, 2184, 5074);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 94, 2256, 5075);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 100, 2400, 5076);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 93, 2232, 5077);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 73, 1752, 5078);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 91, 2184, 5079);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 91, 2184, 5080);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 76, 1824, 5081);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 88, 2112, 5082);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 75, 1800, 5083);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 52, 1248, 5084);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 63, 1512, 5085);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 97, 2328, 5086);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 54, 1296, 5087);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 91, 2184, 5088);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 59, 1416, 5089);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 85, 2040, 5090);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 86, 2064, 5091);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 71, 1704, 5092);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 62, 1488, 5093);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 63, 1512, 5094);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 94, 2256, 5095);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 67, 1608, 5096);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 59, 1416, 5097);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 78, 1872, 5098);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 66, 1584, 5099);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 80, 1920, 5100);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 63, 1512, 5101);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 74, 1776, 5102);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 57, 1368, 5103);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 65, 1560, 5104);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 91, 2184, 5105);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 72, 1728, 5106);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 68, 1632, 5107);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 68, 1632, 5108);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 61, 1464, 5109);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 78, 1872, 5110);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 67, 1608, 5111);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 92, 2208, 5112);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 69, 1656, 5113);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 64, 1536, 5114);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 73, 1752, 5115);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 80, 1920, 5116);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 57, 1368, 5117);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 85, 2040, 5118);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 93, 2232, 5119);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 65, 1560, 5120);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 98, 2352, 5121);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 55, 1320, 5122);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 55, 1320, 5123);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 62, 1488, 5124);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 61, 1464, 5125);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 95, 2280, 5126);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 86, 2064, 5127);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 94, 2256, 5128);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 88, 2112, 5129);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 61, 1464, 5130);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 73, 1752, 5131);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 73, 1752, 5132);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 84, 2016, 5133);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 98, 2352, 5134);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 96, 2304, 5135);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 85, 2040, 5136);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 72, 1728, 5137);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 97, 2328, 5138);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 52, 1248, 5139);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 69, 1656, 5140);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 61, 1464, 5141);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 66, 1584, 5142);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 83, 1992, 5143);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 53, 1272, 5144);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 81, 1944, 5145);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 88, 2112, 5146);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 75, 1800, 5147);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 85, 2040, 5148);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 65, 1560, 5149);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 90, 2160, 5150);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 68, 1632, 5151);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 87, 2088, 5152);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 85, 2040, 5153);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 84, 2016, 5154);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 66, 1584, 5155);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 60, 1440, 5156);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 54, 1296, 5157);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 73, 1752, 5158);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 52, 1248, 5159);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 95, 2280, 5160);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 91, 2184, 5161);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 94, 2256, 5162);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 53, 1272, 5163);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 77, 1848, 5164);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 90, 2160, 5165);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 83, 1992, 5166);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 97, 2328, 5167);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 79, 1896, 5168);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 51, 1224, 5169);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 76, 1824, 5170);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 80, 1920, 5171);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 50, 1200, 5172);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 67, 1608, 5173);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 61, 1464, 5174);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 97, 2328, 5175);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 60, 1440, 5176);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 91, 2184, 5177);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 61, 1464, 5178);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 71, 1704, 5179);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 51, 1224, 5180);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 99, 2376, 5181);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 89, 2136, 5182);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 72, 1728, 5183);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 50, 1200, 5184);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 92, 2208, 5185);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 70, 1680, 5186);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 56, 1344, 5187);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 86, 2064, 5188);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 63, 1512, 5189);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 55, 1320, 5190);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 58, 1392, 5191);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 72, 1728, 5192);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 87, 2088, 5193);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 63, 1512, 5194);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 92, 2208, 5195);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 96, 2304, 5196);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 98, 2352, 5197);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 82, 1968, 5198);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 66, 1584, 5199);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 82, 1968, 5200);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 80, 1920, 5201);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 78, 1872, 5202);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 73, 1752, 5203);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 62, 1488, 5204);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 83, 1992, 5205);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 83, 1992, 5206);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 67, 1608, 5207);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 72, 1728, 5208);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 92, 2208, 5209);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 96, 2304, 5210);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 51, 1224, 5211);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 52, 1248, 5212);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 56, 1344, 5213);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 88, 2112, 5214);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 83, 1992, 5215);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 62, 1488, 5216);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 78, 1872, 5217);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 86, 2064, 5218);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 91, 2184, 5219);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 85, 2040, 5220);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 77, 1848, 5221);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 66, 1584, 5222);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 71, 1704, 5223);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 53, 1272, 5224);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 95, 2280, 5225);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 100, 2400, 5226);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 60, 1440, 5227);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 92, 2208, 5228);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 61, 1464, 5229);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 82, 1968, 5230);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 94, 2256, 5231);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 89, 2136, 5232);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 74, 1776, 5233);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 60, 1440, 5234);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 79, 1896, 5235);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 86, 2064, 5236);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 70, 1680, 5237);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 96, 2304, 5238);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 89, 2136, 5239);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 94, 2256, 5240);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 82, 1968, 5241);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 83, 1992, 5242);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 81, 1944, 5243);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 65, 1560, 5244);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 99, 2376, 5245);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 99, 2376, 5246);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 98, 2352, 5247);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 99, 2376, 5248);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 71, 1704, 5249);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 75, 1800, 5250);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 90, 2160, 5251);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 63, 1512, 5252);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 56, 1344, 5253);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 57, 1368, 5254);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 57, 1368, 5255);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 89, 2136, 5256);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 81, 1944, 5257);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 55, 1320, 5258);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 68, 1632, 5259);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 89, 2136, 5260);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 100, 2400, 5261);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 92, 2208, 5262);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 70, 1680, 5263);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 89, 2136, 5264);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 75, 1800, 5265);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 74, 1776, 5266);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 72, 1728, 5267);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 67, 1608, 5268);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 68, 1632, 5269);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 82, 1968, 5270);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 64, 1536, 5271);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 50, 1200, 5272);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 85, 2040, 5273);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 67, 1608, 5274);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 95, 2280, 5275);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 78, 1872, 5276);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 83, 1992, 5277);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 55, 1320, 5278);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 83, 1992, 5279);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 98, 2352, 5280);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 79, 1896, 5281);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 71, 1704, 5282);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 69, 1656, 5283);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 62, 1488, 5284);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 86, 2064, 5285);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 65, 1560, 5286);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 97, 2328, 5287);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 61, 1464, 5288);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 93, 2232, 5289);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 64, 1536, 5290);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 98, 2352, 5291);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 56, 1344, 5292);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 70, 1680, 5293);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 75, 1800, 5294);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 57, 1368, 5295);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 87, 2088, 5296);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 56, 1344, 5297);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 89, 2136, 5298);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 53, 1272, 5299);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 94, 2256, 5300);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 67, 1608, 5301);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 80, 1920, 5302);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 82, 1968, 5303);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 90, 2160, 5304);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 60, 1440, 5305);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 66, 1584, 5306);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 50, 1200, 5307);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 84, 2016, 5308);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 70, 1680, 5309);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 80, 1920, 5310);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 75, 1800, 5311);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 76, 1824, 5312);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 92, 2208, 5313);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 89, 2136, 5314);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 81, 1944, 5315);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 54, 1296, 5316);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 84, 2016, 5317);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 85, 2040, 5318);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 73, 1752, 5319);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 97, 2328, 5320);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 85, 2040, 5321);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 60, 1440, 5322);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 95, 2280, 5323);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 53, 1272, 5324);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 53, 1272, 5325);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 86, 2064, 5326);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 74, 1776, 5327);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 99, 2376, 5328);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 79, 1896, 5329);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 81, 1944, 5330);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 80, 1920, 5331);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 73, 1752, 5332);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 73, 1752, 5333);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 62, 1488, 5334);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 80, 1920, 5335);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 65, 1560, 5336);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 83, 1992, 5337);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 99, 2376, 5338);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 92, 2208, 5339);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 88, 2112, 5340);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 93, 2232, 5341);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 66, 1584, 5342);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 93, 2232, 5343);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 66, 1584, 5344);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 80, 1920, 5345);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 94, 2256, 5346);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 66, 1584, 5347);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 98, 2352, 5348);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 57, 1368, 5349);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 76, 1824, 5350);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 92, 2208, 5351);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 91, 2184, 5352);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 62, 1488, 5353);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 77, 1848, 5354);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 100, 2400, 5355);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 68, 1632, 5356);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 100, 2400, 5357);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 73, 1752, 5358);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 53, 1272, 5359);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 58, 1392, 5360);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 97, 2328, 5361);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 85, 2040, 5362);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 63, 1512, 5363);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 85, 2040, 5364);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 100, 2400, 5365);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 99, 2376, 5366);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 52, 1248, 5367);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 71, 1704, 5368);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 96, 2304, 5369);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 72, 1728, 5370);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 83, 1992, 5371);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 94, 2256, 5372);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 53, 1272, 5373);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 77, 1848, 5374);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 71, 1704, 5375);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 71, 1704, 5376);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 66, 1584, 5377);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 58, 1392, 5378);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 73, 1752, 5379);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 85, 2040, 5380);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 50, 1200, 5381);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 77, 1848, 5382);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 84, 2016, 5383);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 53, 1272, 5384);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 84, 2016, 5385);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 100, 2400, 5386);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 77, 1848, 5387);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 67, 1608, 5388);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 64, 1536, 5389);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 91, 2184, 5390);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 76, 1824, 5391);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 83, 1992, 5392);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 68, 1632, 5393);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 59, 1416, 5394);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 57, 1368, 5395);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 96, 2304, 5396);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 59, 1416, 5397);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 59, 1416, 5398);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 73, 1752, 5399);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 64, 1536, 5400);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 53, 1272, 5401);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 51, 1224, 5402);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 87, 2088, 5403);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 99, 2376, 5404);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 66, 1584, 5405);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 65, 1560, 5406);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 69, 1656, 5407);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 50, 1200, 5408);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 85, 2040, 5409);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 67, 1608, 5410);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 91, 2184, 5411);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 73, 1752, 5412);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 92, 2208, 5413);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 76, 1824, 5414);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 68, 1632, 5415);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 94, 2256, 5416);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 93, 2232, 5417);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 85, 2040, 5418);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 64, 1536, 5419);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 73, 1752, 5420);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 100, 2400, 5421);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 76, 1824, 5422);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 83, 1992, 5423);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 98, 2352, 5424);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 79, 1896, 5425);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 59, 1416, 5426);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 97, 2328, 5427);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 96, 2304, 5428);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 74, 1776, 5429);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 61, 1464, 5430);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 52, 1248, 5431);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 73, 1752, 5432);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 70, 1680, 5433);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 89, 2136, 5434);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 56, 1344, 5435);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 99, 2376, 5436);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 73, 1752, 5437);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 84, 2016, 5438);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 68, 1632, 5439);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 99, 2376, 5440);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 75, 1800, 5441);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 51, 1224, 5442);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 62, 1488, 5443);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 95, 2280, 5444);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 95, 2280, 5445);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 60, 1440, 5446);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 99, 2376, 5447);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 77, 1848, 5448);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 97, 2328, 5449);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 50, 1200, 5450);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 90, 2160, 5451);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 79, 1896, 5452);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 53, 1272, 5453);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 81, 1944, 5454);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 77, 1848, 5455);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 72, 1728, 5456);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 58, 1392, 5457);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 59, 1416, 5458);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 81, 1944, 5459);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 71, 1704, 5460);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 62, 1488, 5461);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 97, 2328, 5462);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 99, 2376, 5463);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 60, 1440, 5464);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 96, 2304, 5465);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 52, 1248, 5466);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 66, 1584, 5467);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 52, 1248, 5468);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 79, 1896, 5469);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 60, 1440, 5470);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 88, 2112, 5471);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 79, 1896, 5472);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 83, 1992, 5473);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 64, 1536, 5474);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 85, 2040, 5475);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 72, 1728, 5476);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 66, 1584, 5477);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 51, 1224, 5478);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 97, 2328, 5479);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 82, 1968, 5480);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 59, 1416, 5481);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 98, 2352, 5482);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 72, 1728, 5483);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 61, 1464, 5484);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 94, 2256, 5485);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 64, 1536, 5486);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 71, 1704, 5487);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 69, 1656, 5488);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 92, 2208, 5489);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 78, 1872, 5490);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 54, 1296, 5491);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 54, 1296, 5492);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 60, 1440, 5493);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 86, 2064, 5494);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 73, 1752, 5495);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 51, 1224, 5496);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 88, 2112, 5497);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 63, 1512, 5498);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 90, 2160, 5499);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 70, 1680, 5500);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 73, 1752, 5501);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 70, 1680, 5502);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 69, 1656, 5503);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 92, 2208, 5504);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 95, 2280, 5505);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 92, 2208, 5506);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 77, 1848, 5507);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 84, 2016, 5508);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 58, 1392, 5509);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 100, 2400, 5510);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 86, 2064, 5511);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 60, 1440, 5512);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 87, 2088, 5513);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 72, 1728, 5514);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 79, 1896, 5515);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 100, 2400, 5516);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 55, 1320, 5517);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 85, 2040, 5518);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 84, 2016, 5519);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 85, 2040, 5520);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 56, 1344, 5521);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 83, 1992, 5522);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 65, 1560, 5523);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 57, 1368, 5524);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 84, 2016, 5525);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 81, 1944, 5526);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 72, 1728, 5527);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 69, 1656, 5528);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 59, 1416, 5529);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 83, 1992, 5530);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 60, 1440, 5531);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 76, 1824, 5532);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 78, 1872, 5533);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 52, 1248, 5534);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 66, 1584, 5535);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 66, 1584, 5536);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 56, 1344, 5537);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 88, 2112, 5538);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 89, 2136, 5539);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 96, 2304, 5540);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 56, 1344, 5541);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 81, 1944, 5542);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 98, 2352, 5543);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 97, 2328, 5544);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 66, 1584, 5545);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 97, 2328, 5546);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 65, 1560, 5547);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 78, 1872, 5548);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 63, 1512, 5549);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 94, 2256, 5550);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 99, 2376, 5551);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 65, 1560, 5552);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 94, 2256, 5553);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 73, 1752, 5554);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 96, 2304, 5555);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 65, 1560, 5556);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 81, 1944, 5557);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 89, 2136, 5558);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 97, 2328, 5559);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 80, 1920, 5560);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 75, 1800, 5561);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 80, 1920, 5562);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 93, 2232, 5563);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 76, 1824, 5564);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 98, 2352, 5565);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 53, 1272, 5566);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 60, 1440, 5567);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 54, 1296, 5568);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 65, 1560, 5569);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 80, 1920, 5570);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 53, 1272, 5571);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 87, 2088, 5572);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 71, 1704, 5573);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 64, 1536, 5574);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 57, 1368, 5575);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 96, 2304, 5576);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 68, 1632, 5577);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 54, 1296, 5578);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 59, 1416, 5579);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 81, 1944, 5580);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 60, 1440, 5581);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 86, 2064, 5582);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 65, 1560, 5583);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 90, 2160, 5584);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 80, 1920, 5585);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 77, 1848, 5586);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 66, 1584, 5587);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 86, 2064, 5588);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 87, 2088, 5589);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 73, 1752, 5590);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 90, 2160, 5591);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 81, 1944, 5592);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 83, 1992, 5593);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 61, 1464, 5594);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 69, 1656, 5595);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 55, 1320, 5596);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 60, 1440, 5597);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 76, 1824, 5598);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 86, 2064, 5599);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 67, 1608, 5600);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 62, 1488, 5601);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 79, 1896, 5602);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 81, 1944, 5603);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 55, 1320, 5604);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 95, 2280, 5605);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 92, 2208, 5606);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 75, 1800, 5607);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 60, 1440, 5608);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 78, 1872, 5609);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 80, 1920, 5610);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 90, 2160, 5611);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 96, 2304, 5612);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 51, 1224, 5613);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 89, 2136, 5614);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 67, 1608, 5615);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 70, 1680, 5616);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 96, 2304, 5617);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 57, 1368, 5618);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 86, 2064, 5619);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 71, 1704, 5620);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 94, 2256, 5621);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 77, 1848, 5622);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 52, 1248, 5623);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 91, 2184, 5624);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 98, 2352, 5625);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 78, 1872, 5626);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 92, 2208, 5627);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 50, 1200, 5628);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 68, 1632, 5629);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 60, 1440, 5630);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 75, 1800, 5631);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 73, 1752, 5632);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 66, 1584, 5633);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 80, 1920, 5634);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 99, 2376, 5635);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 95, 2280, 5636);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 70, 1680, 5637);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 86, 2064, 5638);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 55, 1320, 5639);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 83, 1992, 5640);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 84, 2016, 5641);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 98, 2352, 5642);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 99, 2376, 5643);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 51, 1224, 5644);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 93, 2232, 5645);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 100, 2400, 5646);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 98, 2352, 5647);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 92, 2208, 5648);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 80, 1920, 5649);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 51, 1224, 5650);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 100, 2400, 5651);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 69, 1656, 5652);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 70, 1680, 5653);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 82, 1968, 5654);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 90, 2160, 5655);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 68, 1632, 5656);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 56, 1344, 5657);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 52, 1248, 5658);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 63, 1512, 5659);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 71, 1704, 5660);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 99, 2376, 5661);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 68, 1632, 5662);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 69, 1656, 5663);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 51, 1224, 5664);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 81, 1944, 5665);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 93, 2232, 5666);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 89, 2136, 5667);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 81, 1944, 5668);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 70, 1680, 5669);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 60, 1440, 5670);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 63, 1512, 5671);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 100, 2400, 5672);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 63, 1512, 5673);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 82, 1968, 5674);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 90, 2160, 5675);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 85, 2040, 5676);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 53, 1272, 5677);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 83, 1992, 5678);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 70, 1680, 5679);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 91, 2184, 5680);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 87, 2088, 5681);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 62, 1488, 5682);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 66, 1584, 5683);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 56, 1344, 5684);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 94, 2256, 5685);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 82, 1968, 5686);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 63, 1512, 5687);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 61, 1464, 5688);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 96, 2304, 5689);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 98, 2352, 5690);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 97, 2328, 5691);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 79, 1896, 5692);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 96, 2304, 5693);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 61, 1464, 5694);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 51, 1224, 5695);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 71, 1704, 5696);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 87, 2088, 5697);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 95, 2280, 5698);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 59, 1416, 5699);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 88, 2112, 5700);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 78, 1872, 5701);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 59, 1416, 5702);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 63, 1512, 5703);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 55, 1320, 5704);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 64, 1536, 5705);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 80, 1920, 5706);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 56, 1344, 5707);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 74, 1776, 5708);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 52, 1248, 5709);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 88, 2112, 5710);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 89, 2136, 5711);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 54, 1296, 5712);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 53, 1272, 5713);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 69, 1656, 5714);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 99, 2376, 5715);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 66, 1584, 5716);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 86, 2064, 5717);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 86, 2064, 5718);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 100, 2400, 5719);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 95, 2280, 5720);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 60, 1440, 5721);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 55, 1320, 5722);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 85, 2040, 5723);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 50, 1200, 5724);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 73, 1752, 5725);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 52, 1248, 5726);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 81, 1944, 5727);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 51, 1224, 5728);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 96, 2304, 5729);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 100, 2400, 5730);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 84, 2016, 5731);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 65, 1560, 5732);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 62, 1488, 5733);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 71, 1704, 5734);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 54, 1296, 5735);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 69, 1656, 5736);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 85, 2040, 5737);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 99, 2376, 5738);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 53, 1272, 5739);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 82, 1968, 5740);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 61, 1464, 5741);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 56, 1344, 5742);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 83, 1992, 5743);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 86, 2064, 5744);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 85, 2040, 5745);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 55, 1320, 5746);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 59, 1416, 5747);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 56, 1344, 5748);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 70, 1680, 5749);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 93, 2232, 5750);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 99, 2376, 5751);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 54, 1296, 5752);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 80, 1920, 5753);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 58, 1392, 5754);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 95, 2280, 5755);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 72, 1728, 5756);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 80, 1920, 5757);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 90, 2160, 5758);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 81, 1944, 5759);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 58, 1392, 5760);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 79, 1896, 5761);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 72, 1728, 5762);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 98, 2352, 5763);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 96, 2304, 5764);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 81, 1944, 5765);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 100, 2400, 5766);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 82, 1968, 5767);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 80, 1920, 5768);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 96, 2304, 5769);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 94, 2256, 5770);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 75, 1800, 5771);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 99, 2376, 5772);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 87, 2088, 5773);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 82, 1968, 5774);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 87, 2088, 5775);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 82, 1968, 5776);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 55, 1320, 5777);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 84, 2016, 5778);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 67, 1608, 5779);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 96, 2304, 5780);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 98, 2352, 5781);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 81, 1944, 5782);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 50, 1200, 5783);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 80, 1920, 5784);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 51, 1224, 5785);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 89, 2136, 5786);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 87, 2088, 5787);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 72, 1728, 5788);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 100, 2400, 5789);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 62, 1488, 5790);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 89, 2136, 5791);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 83, 1992, 5792);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 77, 1848, 5793);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 99, 2376, 5794);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 62, 1488, 5795);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 92, 2208, 5796);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 88, 2112, 5797);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 57, 1368, 5798);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 98, 2352, 5799);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 65, 1560, 5800);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 94, 2256, 5801);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 59, 1416, 5802);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 77, 1848, 5803);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 69, 1656, 5804);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 83, 1992, 5805);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 81, 1944, 5806);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 73, 1752, 5807);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 73, 1752, 5808);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 57, 1368, 5809);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 58, 1392, 5810);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 68, 1632, 5811);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 66, 1584, 5812);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 57, 1368, 5813);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 71, 1704, 5814);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 57, 1368, 5815);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 74, 1776, 5816);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 56, 1344, 5817);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 64, 1536, 5818);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 63, 1512, 5819);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 74, 1776, 5820);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 63, 1512, 5821);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 62, 1488, 5822);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 76, 1824, 5823);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 99, 2376, 5824);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 78, 1872, 5825);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 79, 1896, 5826);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 81, 1944, 5827);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 68, 1632, 5828);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 69, 1656, 5829);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 75, 1800, 5830);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 74, 1776, 5831);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 65, 1560, 5832);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 54, 1296, 5833);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 69, 1656, 5834);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 92, 2208, 5835);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 61, 1464, 5836);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 74, 1776, 5837);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 97, 2328, 5838);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 64, 1536, 5839);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 93, 2232, 5840);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 50, 1200, 5841);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 84, 2016, 5842);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 94, 2256, 5843);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 87, 2088, 5844);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 97, 2328, 5845);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 95, 2280, 5846);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 94, 2256, 5847);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 81, 1944, 5848);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 66, 1584, 5849);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 65, 1560, 5850);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 62, 1488, 5851);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 75, 1800, 5852);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 61, 1464, 5853);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 97, 2328, 5854);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 60, 1440, 5855);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 97, 2328, 5856);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 89, 2136, 5857);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 84, 2016, 5858);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 96, 2304, 5859);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 99, 2376, 5860);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 93, 2232, 5861);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 54, 1296, 5862);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 96, 2304, 5863);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 51, 1224, 5864);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 100, 2400, 5865);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 90, 2160, 5866);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 89, 2136, 5867);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 51, 1224, 5868);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 88, 2112, 5869);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 51, 1224, 5870);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 89, 2136, 5871);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 100, 2400, 5872);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 98, 2352, 5873);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 86, 2064, 5874);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 74, 1776, 5875);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 68, 1632, 5876);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 50, 1200, 5877);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 85, 2040, 5878);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 76, 1824, 5879);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 86, 2064, 5880);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 73, 1752, 5881);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 76, 1824, 5882);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 54, 1296, 5883);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 92, 2208, 5884);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 93, 2232, 5885);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 60, 1440, 5886);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 61, 1464, 5887);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 87, 2088, 5888);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 56, 1344, 5889);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 61, 1464, 5890);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 67, 1608, 5891);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 76, 1824, 5892);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 82, 1968, 5893);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 61, 1464, 5894);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 67, 1608, 5895);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 68, 1632, 5896);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 95, 2280, 5897);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 59, 1416, 5898);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 88, 2112, 5899);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 56, 1344, 5900);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 68, 1632, 5901);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 64, 1536, 5902);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 62, 1488, 5903);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 96, 2304, 5904);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 63, 1512, 5905);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 55, 1320, 5906);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 94, 2256, 5907);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 70, 1680, 5908);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 70, 1680, 5909);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 79, 1896, 5910);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 56, 1344, 5911);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 81, 1944, 5912);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 100, 2400, 5913);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 79, 1896, 5914);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 52, 1248, 5915);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 54, 1296, 5916);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 72, 1728, 5917);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 74, 1776, 5918);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 79, 1896, 5919);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 65, 1560, 5920);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 61, 1464, 5921);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 68, 1632, 5922);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 86, 2064, 5923);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 76, 1824, 5924);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 57, 1368, 5925);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 94, 2256, 5926);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 72, 1728, 5927);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 66, 1584, 5928);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 99, 2376, 5929);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 94, 2256, 5930);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 77, 1848, 5931);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 50, 1200, 5932);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 99, 2376, 5933);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 90, 2160, 5934);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 59, 1416, 5935);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 70, 1680, 5936);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 82, 1968, 5937);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 76, 1824, 5938);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 58, 1392, 5939);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 54, 1296, 5940);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 66, 1584, 5941);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 60, 1440, 5942);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 91, 2184, 5943);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 92, 2208, 5944);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 83, 1992, 5945);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 90, 2160, 5946);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 66, 1584, 5947);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 80, 1920, 5948);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 62, 1488, 5949);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 96, 2304, 5950);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 73, 1752, 5951);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 98, 2352, 5952);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 54, 1296, 5953);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 93, 2232, 5954);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 83, 1992, 5955);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 51, 1224, 5956);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 73, 1752, 5957);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 70, 1680, 5958);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 62, 1488, 5959);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 83, 1992, 5960);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 63, 1512, 5961);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 85, 2040, 5962);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 98, 2352, 5963);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 66, 1584, 5964);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 65, 1560, 5965);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 50, 1200, 5966);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 86, 2064, 5967);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 78, 1872, 5968);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 82, 1968, 5969);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 86, 2064, 5970);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 76, 1824, 5971);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 91, 2184, 5972);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 55, 1320, 5973);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 55, 1320, 5974);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 71, 1704, 5975);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 68, 1632, 5976);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 90, 2160, 5977);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 92, 2208, 5978);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 58, 1392, 5979);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 54, 1296, 5980);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 68, 1632, 5981);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 62, 1488, 5982);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 80, 1920, 5983);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 62, 1488, 5984);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 92, 2208, 5985);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 58, 1392, 5986);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 99, 2376, 5987);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 96, 2304, 5988);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 67, 1608, 5989);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 66, 1584, 5990);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 55, 1320, 5991);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 50, 1200, 5992);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 87, 2088, 5993);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 68, 1632, 5994);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 89, 2136, 5995);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 75, 1800, 5996);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 66, 1584, 5997);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 56, 1344, 5998);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 86, 2064, 5999);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 57, 1368, 6000);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 67, 1608, 6001);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 60, 1440, 6002);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 93, 2232, 6003);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 98, 2352, 6004);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 54, 1296, 6005);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 59, 1416, 6006);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 78, 1872, 6007);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 88, 2112, 6008);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 89, 2136, 6009);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 96, 2304, 6010);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 72, 1728, 6011);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 99, 2376, 6012);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 75, 1800, 6013);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 54, 1296, 6014);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 59, 1416, 6015);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 68, 1632, 6016);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 54, 1296, 6017);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 94, 2256, 6018);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 60, 1440, 6019);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 95, 2280, 6020);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 50, 1200, 6021);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 72, 1728, 6022);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 82, 1968, 6023);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 75, 1800, 6024);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 69, 1656, 6025);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 72, 1728, 6026);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 58, 1392, 6027);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 75, 1800, 6028);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 96, 2304, 6029);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 81, 1944, 6030);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 91, 2184, 6031);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 92, 2208, 6032);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 68, 1632, 6033);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 89, 2136, 6034);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 92, 2208, 6035);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 89, 2136, 6036);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 75, 1800, 6037);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 58, 1392, 6038);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 72, 1728, 6039);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 66, 1584, 6040);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 88, 2112, 6041);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 78, 1872, 6042);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 56, 1344, 6043);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 91, 2184, 6044);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 98, 2352, 6045);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 91, 2184, 6046);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 88, 2112, 6047);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 71, 1704, 6048);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 75, 1800, 6049);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 77, 1848, 6050);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 63, 1512, 6051);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 88, 2112, 6052);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 74, 1776, 6053);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 70, 1680, 6054);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 61, 1464, 6055);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 73, 1752, 6056);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 77, 1848, 6057);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 89, 2136, 6058);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 51, 1224, 6059);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 61, 1464, 6060);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 75, 1800, 6061);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 58, 1392, 6062);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 86, 2064, 6063);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 54, 1296, 6064);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 72, 1728, 6065);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 62, 1488, 6066);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 64, 1536, 6067);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 53, 1272, 6068);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 76, 1824, 6069);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 72, 1728, 6070);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 52, 1248, 6071);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 97, 2328, 6072);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 96, 2304, 6073);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 77, 1848, 6074);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 93, 2232, 6075);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 84, 2016, 6076);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 89, 2136, 6077);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 82, 1968, 6078);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 87, 2088, 6079);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 65, 1560, 6080);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 98, 2352, 6081);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 62, 1488, 6082);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 98, 2352, 6083);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 71, 1704, 6084);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 65, 1560, 6085);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 71, 1704, 6086);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 78, 1872, 6087);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 59, 1416, 6088);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 76, 1824, 6089);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 94, 2256, 6090);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 86, 2064, 6091);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 56, 1344, 6092);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 70, 1680, 6093);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 56, 1344, 6094);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 64, 1536, 6095);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 66, 1584, 6096);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 99, 2376, 6097);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 59, 1416, 6098);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 89, 2136, 6099);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 85, 2040, 6100);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 84, 2016, 6101);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 67, 1608, 6102);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 100, 2400, 6103);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 70, 1680, 6104);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 69, 1656, 6105);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 64, 1536, 6106);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 89, 2136, 6107);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 64, 1536, 6108);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 76, 1824, 6109);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 50, 1200, 6110);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 99, 2376, 6111);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 60, 1440, 6112);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 75, 1800, 6113);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 94, 2256, 6114);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 75, 1800, 6115);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 55, 1320, 6116);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 77, 1848, 6117);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 60, 1440, 6118);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 63, 1512, 6119);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 69, 1656, 6120);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 87, 2088, 6121);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 100, 2400, 6122);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 75, 1800, 6123);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 59, 1416, 6124);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 95, 2280, 6125);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 73, 1752, 6126);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 51, 1224, 6127);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 61, 1464, 6128);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 72, 1728, 6129);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 96, 2304, 6130);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 57, 1368, 6131);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 90, 2160, 6132);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 85, 2040, 6133);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 54, 1296, 6134);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 87, 2088, 6135);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 94, 2256, 6136);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 88, 2112, 6137);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 73, 1752, 6138);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 81, 1944, 6139);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 56, 1344, 6140);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 55, 1320, 6141);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 99, 2376, 6142);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 51, 1224, 6143);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 61, 1464, 6144);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 75, 1800, 6145);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 81, 1944, 6146);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 51, 1224, 6147);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 93, 2232, 6148);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 77, 1848, 6149);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 73, 1752, 6150);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 59, 1416, 6151);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 87, 2088, 6152);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 61, 1464, 6153);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 76, 1824, 6154);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 96, 2304, 6155);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 68, 1632, 6156);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 63, 1512, 6157);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 95, 2280, 6158);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 64, 1536, 6159);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 60, 1440, 6160);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 85, 2040, 6161);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 69, 1656, 6162);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 63, 1512, 6163);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 75, 1800, 6164);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 61, 1464, 6165);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 62, 1488, 6166);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 81, 1944, 6167);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 80, 1920, 6168);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 80, 1920, 6169);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 75, 1800, 6170);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 84, 2016, 6171);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 65, 1560, 6172);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 89, 2136, 6173);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 63, 1512, 6174);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 72, 1728, 6175);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 88, 2112, 6176);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 77, 1848, 6177);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 97, 2328, 6178);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 95, 2280, 6179);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 58, 1392, 6180);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 98, 2352, 6181);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 66, 1584, 6182);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 52, 1248, 6183);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 59, 1416, 6184);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 93, 2232, 6185);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 96, 2304, 6186);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 90, 2160, 6187);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 74, 1776, 6188);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 91, 2184, 6189);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 92, 2208, 6190);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 77, 1848, 6191);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 74, 1776, 6192);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 74, 1776, 6193);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 60, 1440, 6194);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 87, 2088, 6195);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 77, 1848, 6196);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 89, 2136, 6197);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 94, 2256, 6198);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 87, 2088, 6199);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 80, 1920, 6200);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 58, 1392, 6201);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 89, 2136, 6202);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 62, 1488, 6203);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 57, 1368, 6204);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 83, 1992, 6205);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 59, 1416, 6206);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 80, 1920, 6207);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 88, 2112, 6208);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 79, 1896, 6209);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 90, 2160, 6210);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 52, 1248, 6211);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 64, 1536, 6212);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 77, 1848, 6213);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 90, 2160, 6214);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 51, 1224, 6215);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 94, 2256, 6216);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 91, 2184, 6217);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 70, 1680, 6218);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 92, 2208, 6219);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 58, 1392, 6220);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 78, 1872, 6221);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 51, 1224, 6222);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 88, 2112, 6223);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 98, 2352, 6224);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 85, 2040, 6225);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 57, 1368, 6226);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 81, 1944, 6227);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 93, 2232, 6228);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 59, 1416, 6229);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 58, 1392, 6230);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 66, 1584, 6231);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 89, 2136, 6232);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 65, 1560, 6233);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 71, 1704, 6234);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 73, 1752, 6235);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 61, 1464, 6236);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 59, 1416, 6237);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 79, 1896, 6238);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 100, 2400, 6239);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 53, 1272, 6240);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 74, 1776, 6241);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 68, 1632, 6242);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 74, 1776, 6243);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 50, 1200, 6244);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 93, 2232, 6245);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 53, 1272, 6246);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 69, 1656, 6247);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 56, 1344, 6248);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 100, 2400, 6249);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 94, 2256, 6250);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 85, 2040, 6251);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 61, 1464, 6252);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 88, 2112, 6253);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 92, 2208, 6254);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 93, 2232, 6255);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 98, 2352, 6256);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 61, 1464, 6257);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 56, 1344, 6258);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 70, 1680, 6259);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 73, 1752, 6260);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 68, 1632, 6261);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 100, 2400, 6262);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 94, 2256, 6263);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 62, 1488, 6264);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 90, 2160, 6265);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 93, 2232, 6266);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 61, 1464, 6267);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 59, 1416, 6268);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 59, 1416, 6269);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 95, 2280, 6270);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 73, 1752, 6271);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 65, 1560, 6272);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 76, 1824, 6273);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 85, 2040, 6274);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 91, 2184, 6275);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 82, 1968, 6276);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 54, 1296, 6277);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 58, 1392, 6278);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 72, 1728, 6279);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 66, 1584, 6280);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 54, 1296, 6281);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 69, 1656, 6282);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 96, 2304, 6283);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 62, 1488, 6284);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 98, 2352, 6285);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 88, 2112, 6286);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 62, 1488, 6287);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 88, 2112, 6288);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 99, 2376, 6289);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 72, 1728, 6290);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 78, 1872, 6291);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 95, 2280, 6292);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 54, 1296, 6293);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 76, 1824, 6294);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 79, 1896, 6295);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 65, 1560, 6296);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 87, 2088, 6297);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 98, 2352, 6298);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 51, 1224, 6299);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 62, 1488, 6300);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 61, 1464, 6301);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 68, 1632, 6302);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 96, 2304, 6303);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 97, 2328, 6304);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 90, 2160, 6305);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 64, 1536, 6306);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 81, 1944, 6307);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 55, 1320, 6308);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 75, 1800, 6309);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 94, 2256, 6310);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 77, 1848, 6311);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 70, 1680, 6312);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 50, 1200, 6313);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 53, 1272, 6314);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 80, 1920, 6315);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 92, 2208, 6316);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 72, 1728, 6317);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 93, 2232, 6318);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 87, 2088, 6319);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 59, 1416, 6320);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 71, 1704, 6321);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 64, 1536, 6322);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 65, 1560, 6323);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 60, 1440, 6324);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 64, 1536, 6325);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 91, 2184, 6326);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 87, 2088, 6327);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 80, 1920, 6328);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 87, 2088, 6329);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 95, 2280, 6330);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 64, 1536, 6331);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 79, 1896, 6332);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 51, 1224, 6333);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 65, 1560, 6334);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 60, 1440, 6335);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 75, 1800, 6336);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 66, 1584, 6337);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 51, 1224, 6338);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 72, 1728, 6339);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 78, 1872, 6340);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 78, 1872, 6341);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 67, 1608, 6342);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 65, 1560, 6343);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 93, 2232, 6344);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 88, 2112, 6345);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 81, 1944, 6346);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 71, 1704, 6347);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 96, 2304, 6348);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 89, 2136, 6349);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 77, 1848, 6350);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 74, 1776, 6351);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 95, 2280, 6352);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 73, 1752, 6353);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 98, 2352, 6354);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 68, 1632, 6355);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 96, 2304, 6356);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 64, 1536, 6357);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 83, 1992, 6358);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 87, 2088, 6359);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 57, 1368, 6360);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 82, 1968, 6361);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 91, 2184, 6362);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 75, 1800, 6363);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 77, 1848, 6364);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 50, 1200, 6365);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 89, 2136, 6366);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 86, 2064, 6367);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 53, 1272, 6368);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 97, 2328, 6369);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 68, 1632, 6370);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 86, 2064, 6371);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 70, 1680, 6372);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 56, 1344, 6373);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 88, 2112, 6374);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 87, 2088, 6375);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 99, 2376, 6376);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 85, 2040, 6377);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 99, 2376, 6378);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 97, 2328, 6379);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 83, 1992, 6380);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 62, 1488, 6381);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 59, 1416, 6382);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 81, 1944, 6383);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 60, 1440, 6384);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 58, 1392, 6385);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 68, 1632, 6386);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 52, 1248, 6387);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 62, 1488, 6388);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 61, 1464, 6389);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 80, 1920, 6390);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 80, 1920, 6391);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 71, 1704, 6392);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 93, 2232, 6393);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 90, 2160, 6394);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 73, 1752, 6395);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 76, 1824, 6396);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 87, 2088, 6397);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 72, 1728, 6398);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 89, 2136, 6399);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 85, 2040, 6400);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 76, 1824, 6401);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 54, 1296, 6402);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 91, 2184, 6403);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 75, 1800, 6404);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 51, 1224, 6405);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 66, 1584, 6406);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 53, 1272, 6407);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 83, 1992, 6408);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 55, 1320, 6409);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 54, 1296, 6410);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 86, 2064, 6411);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 66, 1584, 6412);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 68, 1632, 6413);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 63, 1512, 6414);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 60, 1440, 6415);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 59, 1416, 6416);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 76, 1824, 6417);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 78, 1872, 6418);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 54, 1296, 6419);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 83, 1992, 6420);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 99, 2376, 6421);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 51, 1224, 6422);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 93, 2232, 6423);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 63, 1512, 6424);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 88, 2112, 6425);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 100, 2400, 6426);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 50, 1200, 6427);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 75, 1800, 6428);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 63, 1512, 6429);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 60, 1440, 6430);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 82, 1968, 6431);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 94, 2256, 6432);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 92, 2208, 6433);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 69, 1656, 6434);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 99, 2376, 6435);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 67, 1608, 6436);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 64, 1536, 6437);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 99, 2376, 6438);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 87, 2088, 6439);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 69, 1656, 6440);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 97, 2328, 6441);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 53, 1272, 6442);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 71, 1704, 6443);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 74, 1776, 6444);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 65, 1560, 6445);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 50, 1200, 6446);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 65, 1560, 6447);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 99, 2376, 6448);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 50, 1200, 6449);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 83, 1992, 6450);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 59, 1416, 6451);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 70, 1680, 6452);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 80, 1920, 6453);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 79, 1896, 6454);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 78, 1872, 6455);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 100, 2400, 6456);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 68, 1632, 6457);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 52, 1248, 6458);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 100, 2400, 6459);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 81, 1944, 6460);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 81, 1944, 6461);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 89, 2136, 6462);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 70, 1680, 6463);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 55, 1320, 6464);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 58, 1392, 6465);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 98, 2352, 6466);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 98, 2352, 6467);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 80, 1920, 6468);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 62, 1488, 6469);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 75, 1800, 6470);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 94, 2256, 6471);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 81, 1944, 6472);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 83, 1992, 6473);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 90, 2160, 6474);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 89, 2136, 6475);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 90, 2160, 6476);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 60, 1440, 6477);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 98, 2352, 6478);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 54, 1296, 6479);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 56, 1344, 6480);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 73, 1752, 6481);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 94, 2256, 6482);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 82, 1968, 6483);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 73, 1752, 6484);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 64, 1536, 6485);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 58, 1392, 6486);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 83, 1992, 6487);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 86, 2064, 6488);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 76, 1824, 6489);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 51, 1224, 6490);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 94, 2256, 6491);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 65, 1560, 6492);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 94, 2256, 6493);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 77, 1848, 6494);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 57, 1368, 6495);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 66, 1584, 6496);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 57, 1368, 6497);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 93, 2232, 6498);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 77, 1848, 6499);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 83, 1992, 6500);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 67, 1608, 6501);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 88, 2112, 6502);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 50, 1200, 6503);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 99, 2376, 6504);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 75, 1800, 6505);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 92, 2208, 6506);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 100, 2400, 6507);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 99, 2376, 6508);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 68, 1632, 6509);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 95, 2280, 6510);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 89, 2136, 6511);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 51, 1224, 6512);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 63, 1512, 6513);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 80, 1920, 6514);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 57, 1368, 6515);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 96, 2304, 6516);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 52, 1248, 6517);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 96, 2304, 6518);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 82, 1968, 6519);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 56, 1344, 6520);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 52, 1248, 6521);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 79, 1896, 6522);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 90, 2160, 6523);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 88, 2112, 6524);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 77, 1848, 6525);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 55, 1320, 6526);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 52, 1248, 6527);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 57, 1368, 6528);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 71, 1704, 6529);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 78, 1872, 6530);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 90, 2160, 6531);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 80, 1920, 6532);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 70, 1680, 6533);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 71, 1704, 6534);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 54, 1296, 6535);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 61, 1464, 6536);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 87, 2088, 6537);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 96, 2304, 6538);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 66, 1584, 6539);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 100, 2400, 6540);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 87, 2088, 6541);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 70, 1680, 6542);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 79, 1896, 6543);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 67, 1608, 6544);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 70, 1680, 6545);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 65, 1560, 6546);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 77, 1848, 6547);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 63, 1512, 6548);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 58, 1392, 6549);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 64, 1536, 6550);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 74, 1776, 6551);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 75, 1800, 6552);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 58, 1392, 6553);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 70, 1680, 6554);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 61, 1464, 6555);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 69, 1656, 6556);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 89, 2136, 6557);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 87, 2088, 6558);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 95, 2280, 6559);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 56, 1344, 6560);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 93, 2232, 6561);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 63, 1512, 6562);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 59, 1416, 6563);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 78, 1872, 6564);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 91, 2184, 6565);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 62, 1488, 6566);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 62, 1488, 6567);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 59, 1416, 6568);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 82, 1968, 6569);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 82, 1968, 6570);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 56, 1344, 6571);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 62, 1488, 6572);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 71, 1704, 6573);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 59, 1416, 6574);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 80, 1920, 6575);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 70, 1680, 6576);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 97, 2328, 6577);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 92, 2208, 6578);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 76, 1824, 6579);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 88, 2112, 6580);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 63, 1512, 6581);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 52, 1248, 6582);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 82, 1968, 6583);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 99, 2376, 6584);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 66, 1584, 6585);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 52, 1248, 6586);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 73, 1752, 6587);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 90, 2160, 6588);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 92, 2208, 6589);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 100, 2400, 6590);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 77, 1848, 6591);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 81, 1944, 6592);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 78, 1872, 6593);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 78, 1872, 6594);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 83, 1992, 6595);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 94, 2256, 6596);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 52, 1248, 6597);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 70, 1680, 6598);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 76, 1824, 6599);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 55, 1320, 6600);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 90, 2160, 6601);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 99, 2376, 6602);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 78, 1872, 6603);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 97, 2328, 6604);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 82, 1968, 6605);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 68, 1632, 6606);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 92, 2208, 6607);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 69, 1656, 6608);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 55, 1320, 6609);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 91, 2184, 6610);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 82, 1968, 6611);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 89, 2136, 6612);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 96, 2304, 6613);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 69, 1656, 6614);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 54, 1296, 6615);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 66, 1584, 6616);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 61, 1464, 6617);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 68, 1632, 6618);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 52, 1248, 6619);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 87, 2088, 6620);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 77, 1848, 6621);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 98, 2352, 6622);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 61, 1464, 6623);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 88, 2112, 6624);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 52, 1248, 6625);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 81, 1944, 6626);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 52, 1248, 6627);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 86, 2064, 6628);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 61, 1464, 6629);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 84, 2016, 6630);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 98, 2352, 6631);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 80, 1920, 6632);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 91, 2184, 6633);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 79, 1896, 6634);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 65, 1560, 6635);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 55, 1320, 6636);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 63, 1512, 6637);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 76, 1824, 6638);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 64, 1536, 6639);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 90, 2160, 6640);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 80, 1920, 6641);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 79, 1896, 6642);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 79, 1896, 6643);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 54, 1296, 6644);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 89, 2136, 6645);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 80, 1920, 6646);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 81, 1944, 6647);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 50, 1200, 6648);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 90, 2160, 6649);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 92, 2208, 6650);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 53, 1272, 6651);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 66, 1584, 6652);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 54, 1296, 6653);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 97, 2328, 6654);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 76, 1824, 6655);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 80, 1920, 6656);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 64, 1536, 6657);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 99, 2376, 6658);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 67, 1608, 6659);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 57, 1368, 6660);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 74, 1776, 6661);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 87, 2088, 6662);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 72, 1728, 6663);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 59, 1416, 6664);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 67, 1608, 6665);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 76, 1824, 6666);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 66, 1584, 6667);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 82, 1968, 6668);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 67, 1608, 6669);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 58, 1392, 6670);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 89, 2136, 6671);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 80, 1920, 6672);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 77, 1848, 6673);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 50, 1200, 6674);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 94, 2256, 6675);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 70, 1680, 6676);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 99, 2376, 6677);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 56, 1344, 6678);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 77, 1848, 6679);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 86, 2064, 6680);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 100, 2400, 6681);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 64, 1536, 6682);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 67, 1608, 6683);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 89, 2136, 6684);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 96, 2304, 6685);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 64, 1536, 6686);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 90, 2160, 6687);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 63, 1512, 6688);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 67, 1608, 6689);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 78, 1872, 6690);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 65, 1560, 6691);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 93, 2232, 6692);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 78, 1872, 6693);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 95, 2280, 6694);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 67, 1608, 6695);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 71, 1704, 6696);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 68, 1632, 6697);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 94, 2256, 6698);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 76, 1824, 6699);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 60, 1440, 6700);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 56, 1344, 6701);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 54, 1296, 6702);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 85, 2040, 6703);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 62, 1488, 6704);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 95, 2280, 6705);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 89, 2136, 6706);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 80, 1920, 6707);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 63, 1512, 6708);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 81, 1944, 6709);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 92, 2208, 6710);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 92, 2208, 6711);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 80, 1920, 6712);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 83, 1992, 6713);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 99, 2376, 6714);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 62, 1488, 6715);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 58, 1392, 6716);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 70, 1680, 6717);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 100, 2400, 6718);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 100, 2400, 6719);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 67, 1608, 6720);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 85, 2040, 6721);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 78, 1872, 6722);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 58, 1392, 6723);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 77, 1848, 6724);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 81, 1944, 6725);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 74, 1776, 6726);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 69, 1656, 6727);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 61, 1464, 6728);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 76, 1824, 6729);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 73, 1752, 6730);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 88, 2112, 6731);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 98, 2352, 6732);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 79, 1896, 6733);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 80, 1920, 6734);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 94, 2256, 6735);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 78, 1872, 6736);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 61, 1464, 6737);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 82, 1968, 6738);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 75, 1800, 6739);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 77, 1848, 6740);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 91, 2184, 6741);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 83, 1992, 6742);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 56, 1344, 6743);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 57, 1368, 6744);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 55, 1320, 6745);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 73, 1752, 6746);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 82, 1968, 6747);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 82, 1968, 6748);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 55, 1320, 6749);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 67, 1608, 6750);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 68, 1632, 6751);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 80, 1920, 6752);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 50, 1200, 6753);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 88, 2112, 6754);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 79, 1896, 6755);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 54, 1296, 6756);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 66, 1584, 6757);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 60, 1440, 6758);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 88, 2112, 6759);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 75, 1800, 6760);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 88, 2112, 6761);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 90, 2160, 6762);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 98, 2352, 6763);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 52, 1248, 6764);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 60, 1440, 6765);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 54, 1296, 6766);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 94, 2256, 6767);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 63, 1512, 6768);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 98, 2352, 6769);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 70, 1680, 6770);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 69, 1656, 6771);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 83, 1992, 6772);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 82, 1968, 6773);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 91, 2184, 6774);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 53, 1272, 6775);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 65, 1560, 6776);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 77, 1848, 6777);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 50, 1200, 6778);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 65, 1560, 6779);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 75, 1800, 6780);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 97, 2328, 6781);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 63, 1512, 6782);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 81, 1944, 6783);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 67, 1608, 6784);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 87, 2088, 6785);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 80, 1920, 6786);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 50, 1200, 6787);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 50, 1200, 6788);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 89, 2136, 6789);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 52, 1248, 6790);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 65, 1560, 6791);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 89, 2136, 6792);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 82, 1968, 6793);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 56, 1344, 6794);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 83, 1992, 6795);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 94, 2256, 6796);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 79, 1896, 6797);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 61, 1464, 6798);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 73, 1752, 6799);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 59, 1416, 6800);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 97, 2328, 6801);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 63, 1512, 6802);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 93, 2232, 6803);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 61, 1464, 6804);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 95, 2280, 6805);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 73, 1752, 6806);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 93, 2232, 6807);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 87, 2088, 6808);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 69, 1656, 6809);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 54, 1296, 6810);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 54, 1296, 6811);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 69, 1656, 6812);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 68, 1632, 6813);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 70, 1680, 6814);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 52, 1248, 6815);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 84, 2016, 6816);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 70, 1680, 6817);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 61, 1464, 6818);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 64, 1536, 6819);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 58, 1392, 6820);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 70, 1680, 6821);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 70, 1680, 6822);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 60, 1440, 6823);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 52, 1248, 6824);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 75, 1800, 6825);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 62, 1488, 6826);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 60, 1440, 6827);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 80, 1920, 6828);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 69, 1656, 6829);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 87, 2088, 6830);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 94, 2256, 6831);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 54, 1296, 6832);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 64, 1536, 6833);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 70, 1680, 6834);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 55, 1320, 6835);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 62, 1488, 6836);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 69, 1656, 6837);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 57, 1368, 6838);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 93, 2232, 6839);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 66, 1584, 6840);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 91, 2184, 6841);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 91, 2184, 6842);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 58, 1392, 6843);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 98, 2352, 6844);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 92, 2208, 6845);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 51, 1224, 6846);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 55, 1320, 6847);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 97, 2328, 6848);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 77, 1848, 6849);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 60, 1440, 6850);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 96, 2304, 6851);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 98, 2352, 6852);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 68, 1632, 6853);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 51, 1224, 6854);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 96, 2304, 6855);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 78, 1872, 6856);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 61, 1464, 6857);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 81, 1944, 6858);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 90, 2160, 6859);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 58, 1392, 6860);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 59, 1416, 6861);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 89, 2136, 6862);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 63, 1512, 6863);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 65, 1560, 6864);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 100, 2400, 6865);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 92, 2208, 6866);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 68, 1632, 6867);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 58, 1392, 6868);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 64, 1536, 6869);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 61, 1464, 6870);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 73, 1752, 6871);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 90, 2160, 6872);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 98, 2352, 6873);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 50, 1200, 6874);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 53, 1272, 6875);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 65, 1560, 6876);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 92, 2208, 6877);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 57, 1368, 6878);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 61, 1464, 6879);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 65, 1560, 6880);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 86, 2064, 6881);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 57, 1368, 6882);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 80, 1920, 6883);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 67, 1608, 6884);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 74, 1776, 6885);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 69, 1656, 6886);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 96, 2304, 6887);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 88, 2112, 6888);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 51, 1224, 6889);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 74, 1776, 6890);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 60, 1440, 6891);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 88, 2112, 6892);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 99, 2376, 6893);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 61, 1464, 6894);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 66, 1584, 6895);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 50, 1200, 6896);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 97, 2328, 6897);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 83, 1992, 6898);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 81, 1944, 6899);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 60, 1440, 6900);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 61, 1464, 6901);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 71, 1704, 6902);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 84, 2016, 6903);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 61, 1464, 6904);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 56, 1344, 6905);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 100, 2400, 6906);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 98, 2352, 6907);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 94, 2256, 6908);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 54, 1296, 6909);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 83, 1992, 6910);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 90, 2160, 6911);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 97, 2328, 6912);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 64, 1536, 6913);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 58, 1392, 6914);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 78, 1872, 6915);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 83, 1992, 6916);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 62, 1488, 6917);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 57, 1368, 6918);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 74, 1776, 6919);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 50, 1200, 6920);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 58, 1392, 6921);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 78, 1872, 6922);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 79, 1896, 6923);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 67, 1608, 6924);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 58, 1392, 6925);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 77, 1848, 6926);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 55, 1320, 6927);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 59, 1416, 6928);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 54, 1296, 6929);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 71, 1704, 6930);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 80, 1920, 6931);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 78, 1872, 6932);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 58, 1392, 6933);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 63, 1512, 6934);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 50, 1200, 6935);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 86, 2064, 6936);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 92, 2208, 6937);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 91, 2184, 6938);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 86, 2064, 6939);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 85, 2040, 6940);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 80, 1920, 6941);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 86, 2064, 6942);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 87, 2088, 6943);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 64, 1536, 6944);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 60, 1440, 6945);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 73, 1752, 6946);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 90, 2160, 6947);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 92, 2208, 6948);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 87, 2088, 6949);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 96, 2304, 6950);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 67, 1608, 6951);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 69, 1656, 6952);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 50, 1200, 6953);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 69, 1656, 6954);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 67, 1608, 6955);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 71, 1704, 6956);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 64, 1536, 6957);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 64, 1536, 6958);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 75, 1800, 6959);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 59, 1416, 6960);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 58, 1392, 6961);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 50, 1200, 6962);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 68, 1632, 6963);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 58, 1392, 6964);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 74, 1776, 6965);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 91, 2184, 6966);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 85, 2040, 6967);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 53, 1272, 6968);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 97, 2328, 6969);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 74, 1776, 6970);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 92, 2208, 6971);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 90, 2160, 6972);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 55, 1320, 6973);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 87, 2088, 6974);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 71, 1704, 6975);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 81, 1944, 6976);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 73, 1752, 6977);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 96, 2304, 6978);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 63, 1512, 6979);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 65, 1560, 6980);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 78, 1872, 6981);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 96, 2304, 6982);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 57, 1368, 6983);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 55, 1320, 6984);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 56, 1344, 6985);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 68, 1632, 6986);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 72, 1728, 6987);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 79, 1896, 6988);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 74, 1776, 6989);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 71, 1704, 6990);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 62, 1488, 6991);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 94, 2256, 6992);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 54, 1296, 6993);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 76, 1824, 6994);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 74, 1776, 6995);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 100, 2400, 6996);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 50, 1200, 6997);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 72, 1728, 6998);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 79, 1896, 6999);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 50, 1200, 7000);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 65, 1560, 7001);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 57, 1368, 7002);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 57, 1368, 7003);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 95, 2280, 7004);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 92, 2208, 7005);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 93, 2232, 7006);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 66, 1584, 7007);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 63, 1512, 7008);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 67, 1608, 7009);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 51, 1224, 7010);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 50, 1200, 7011);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 71, 1704, 7012);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 52, 1248, 7013);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 63, 1512, 7014);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 71, 1704, 7015);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 78, 1872, 7016);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 83, 1992, 7017);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 76, 1824, 7018);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 86, 2064, 7019);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 57, 1368, 7020);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 94, 2256, 7021);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 98, 2352, 7022);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 75, 1800, 7023);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 76, 1824, 7024);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 87, 2088, 7025);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 57, 1368, 7026);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 92, 2208, 7027);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 92, 2208, 7028);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 80, 1920, 7029);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 69, 1656, 7030);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 63, 1512, 7031);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 70, 1680, 7032);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 92, 2208, 7033);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 52, 1248, 7034);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 71, 1704, 7035);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 60, 1440, 7036);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 70, 1680, 7037);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 91, 2184, 7038);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 68, 1632, 7039);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 75, 1800, 7040);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 58, 1392, 7041);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 97, 2328, 7042);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 97, 2328, 7043);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 96, 2304, 7044);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 72, 1728, 7045);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 90, 2160, 7046);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 87, 2088, 7047);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 66, 1584, 7048);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 55, 1320, 7049);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 97, 2328, 7050);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 72, 1728, 7051);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 67, 1608, 7052);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 88, 2112, 7053);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 66, 1584, 7054);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 80, 1920, 7055);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 85, 2040, 7056);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 89, 2136, 7057);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 91, 2184, 7058);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 78, 1872, 7059);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 54, 1296, 7060);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 63, 1512, 7061);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 95, 2280, 7062);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 61, 1464, 7063);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 50, 1200, 7064);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 63, 1512, 7065);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 73, 1752, 7066);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 98, 2352, 7067);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 71, 1704, 7068);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 78, 1872, 7069);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 84, 2016, 7070);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 73, 1752, 7071);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 67, 1608, 7072);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 50, 1200, 7073);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 55, 1320, 7074);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 68, 1632, 7075);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 97, 2328, 7076);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 88, 2112, 7077);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 71, 1704, 7078);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 83, 1992, 7079);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 57, 1368, 7080);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 99, 2376, 7081);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 89, 2136, 7082);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 84, 2016, 7083);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 90, 2160, 7084);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 80, 1920, 7085);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 93, 2232, 7086);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 63, 1512, 7087);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 73, 1752, 7088);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 86, 2064, 7089);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 92, 2208, 7090);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 84, 2016, 7091);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 99, 2376, 7092);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 63, 1512, 7093);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 55, 1320, 7094);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 57, 1368, 7095);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 61, 1464, 7096);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 84, 2016, 7097);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 55, 1320, 7098);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 78, 1872, 7099);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 86, 2064, 7100);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 91, 2184, 7101);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 94, 2256, 7102);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 76, 1824, 7103);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 74, 1776, 7104);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 56, 1344, 7105);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 87, 2088, 7106);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 88, 2112, 7107);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 86, 2064, 7108);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 89, 2136, 7109);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 94, 2256, 7110);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 75, 1800, 7111);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 75, 1800, 7112);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 93, 2232, 7113);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 75, 1800, 7114);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 76, 1824, 7115);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 68, 1632, 7116);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 76, 1824, 7117);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 89, 2136, 7118);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 78, 1872, 7119);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 83, 1992, 7120);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 97, 2328, 7121);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 64, 1536, 7122);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 59, 1416, 7123);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 94, 2256, 7124);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 73, 1752, 7125);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 67, 1608, 7126);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 89, 2136, 7127);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 100, 2400, 7128);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 75, 1800, 7129);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 60, 1440, 7130);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 83, 1992, 7131);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 90, 2160, 7132);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 85, 2040, 7133);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 52, 1248, 7134);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 74, 1776, 7135);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 84, 2016, 7136);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 81, 1944, 7137);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 92, 2208, 7138);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 97, 2328, 7139);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 61, 1464, 7140);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 94, 2256, 7141);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 65, 1560, 7142);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 62, 1488, 7143);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 52, 1248, 7144);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 54, 1296, 7145);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 65, 1560, 7146);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 96, 2304, 7147);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 92, 2208, 7148);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 64, 1536, 7149);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 100, 2400, 7150);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 95, 2280, 7151);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 60, 1440, 7152);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 81, 1944, 7153);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 99, 2376, 7154);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 98, 2352, 7155);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 79, 1896, 7156);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 70, 1680, 7157);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 73, 1752, 7158);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (456789, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 84, 2016, 7159);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 52, 1248, 7160);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 66, 1584, 7161);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 82, 1968, 7162);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 98, 2352, 7163);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 60, 1440, 7164);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 72, 1728, 7165);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 67, 1608, 7166);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 71, 1704, 7167);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 55, 1320, 7168);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 93, 2232, 7169);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 74, 1776, 7170);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 99, 2376, 7171);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 56, 1344, 7172);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 52, 1248, 7173);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 83, 1992, 7174);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 56, 1344, 7175);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 71, 1704, 7176);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 100, 2400, 7177);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 55, 1320, 7178);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (567890, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 55, 1320, 7179);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 98, 2352, 7180);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 81, 1944, 7181);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 92, 2208, 7182);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 54, 1296, 7183);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 75, 1800, 7184);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 70, 1680, 7185);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 87, 2088, 7186);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 79, 1896, 7187);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 85, 2040, 7188);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 73, 1752, 7189);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 62, 1488, 7190);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 53, 1272, 7191);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 94, 2256, 7192);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 71, 1704, 7193);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 97, 2328, 7194);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 95, 2280, 7195);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 95, 2280, 7196);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 76, 1824, 7197);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 50, 1200, 7198);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (678901, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 50, 1200, 7199);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 96, 2304, 7200);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 88, 2112, 7201);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 69, 1656, 7202);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 84, 2016, 7203);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 70, 1680, 7204);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 94, 2256, 7205);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 92, 2208, 7206);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 78, 1872, 7207);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 53, 1272, 7208);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 85, 2040, 7209);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 65, 1560, 7210);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 91, 2184, 7211);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 97, 2328, 7212);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 85, 2040, 7213);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 79, 1896, 7214);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 76, 1824, 7215);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 80, 1920, 7216);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 81, 1944, 7217);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 51, 1224, 7218);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (789012, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 65, 1560, 7219);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 88, 2112, 7220);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 88, 2112, 7221);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 72, 1728, 7222);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 87, 2088, 7223);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 65, 1560, 7224);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 84, 2016, 7225);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 84, 2016, 7226);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 98, 2352, 7227);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 55, 1320, 7228);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 95, 2280, 7229);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 58, 1392, 7230);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 67, 1608, 7231);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 79, 1896, 7232);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 53, 1272, 7233);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 88, 2112, 7234);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 91, 2184, 7235);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 57, 1368, 7236);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 61, 1464, 7237);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 89, 2136, 7238);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (890123, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 74, 1776, 7239);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-01-01 00:00:00', '2018-04-02 07:12:00', 87, 2088, 7240);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-04-02 07:12:00', '2018-07-02 14:24:00', 63, 1512, 7241);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-07-02 14:24:00', '2018-10-01 21:36:00', 64, 1536, 7242);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2018-10-01 21:36:00', '2019-01-01 04:48:00', 81, 1944, 7243);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-01-01 04:48:00', '2019-04-02 12:00:00', 93, 2232, 7244);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-04-02 12:00:00', '2019-07-02 19:12:00', 65, 1560, 7245);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-07-02 19:12:00', '2019-10-02 02:24:00', 55, 1320, 7246);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2019-10-02 02:24:00', '2020-01-01 09:36:00', 90, 2160, 7247);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-01-01 09:36:00', '2020-04-01 16:48:00', 55, 1320, 7248);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-04-01 16:48:00', '2020-07-02 00:00:00', 84, 2016, 7249);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-07-02 00:00:00', '2020-10-01 07:12:00', 51, 1224, 7250);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-10-01 07:12:00', '2020-12-31 14:24:00', 89, 2136, 7251);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2020-12-31 14:24:00', '2021-04-01 21:36:00', 97, 2328, 7252);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-04-01 21:36:00', '2021-07-02 04:48:00', 66, 1584, 7253);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-07-02 04:48:00', '2021-10-01 12:00:00', 91, 2184, 7254);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-10-01 12:00:00', '2021-12-31 19:12:00', 60, 1440, 7255);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2021-12-31 19:12:00', '2022-04-02 02:24:00', 100, 2400, 7256);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-04-02 02:24:00', '2022-07-02 09:36:00', 53, 1272, 7257);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-07-02 09:36:00', '2022-10-01 16:48:00', 70, 1680, 7258);
INSERT INTO lab."Price" ("Mod_Code", "DT_Inter_Start", "DT_Inter_End", "Price_One_H", "Price_Long_Inter", "Price_Code") VALUES (901234, '2022-10-01 16:48:00', '2023-01-01 00:00:00', 91, 2184, 7259);
--Вставка данных в таблицу "Price"

--
-- TOC entry 3435 (class 0 OID 24722)
-- Dependencies: 225
-- Data for Name: Staff; Type: TABLE DATA; Schema: lab; Owner: postgres
--

INSERT INTO lab."Staff" ("Stf_Code", "Position", "Resps", "Salary", stf_name) VALUES (123123, 'Client Manager', 'Keeps track of the clients and communicates with them. Creates client offers.', 45000, 'Jimmy Landers');
INSERT INTO lab."Staff" ("Stf_Code", "Position", "Resps", "Salary", stf_name) VALUES (456789, 'Sales Manager', 'Responsible for creating and executing sales strategies. Manages sales team.', 55000, 'Alice Smith');
INSERT INTO lab."Staff" ("Stf_Code", "Position", "Resps", "Salary", stf_name) VALUES (789012, 'Marketing Coordinator', 'Assists in developing and executing marketing campaigns. Manages social media.', 40000, 'Bob Johnson');
INSERT INTO lab."Staff" ("Stf_Code", "Position", "Resps", "Salary", stf_name) VALUES (890123, 'Financial Analyst', 'Conducts financial analysis and provides recommendations. Prepares financial reports.', 60000, 'Caroline Lee');
INSERT INTO lab."Staff" ("Stf_Code", "Position", "Resps", "Salary", stf_name) VALUES (345678, 'IT Specialist', 'Provides technical support to employees. Manages company network.', 50000, 'David Chen');
INSERT INTO lab."Staff" ("Stf_Code", "Position", "Resps", "Salary", stf_name) VALUES (901234, 'HR Generalist', 'Assists in recruiting, onboarding and training. Manages employee records.', 45000, 'Emily Wong');
INSERT INTO lab."Staff" ("Stf_Code", "Position", "Resps", "Salary", stf_name) VALUES (567890, 'Operations Manager', 'Oversees day-to-day operations. Develops and implements operational policies.', 70000, 'Franklin Rodriguez');
INSERT INTO lab."Staff" ("Stf_Code", "Position", "Resps", "Salary", stf_name) VALUES (678901, 'Customer Serv Representative', 'Assists customers with inquiries and issues. Provides customer support.', 35000, 'Grace Kim');
INSERT INTO lab."Staff" ("Stf_Code", "Position", "Resps", "Salary", stf_name) VALUES (113322, 'Client Manager', 'Keeps track of the clients and communicates with them. Creates client offers.', 55000, 'Sarah Johnson');
INSERT INTO lab."Staff" ("Stf_Code", "Position", "Resps", "Salary", stf_name) VALUES (134523, 'Sales Manager', 'Responsible for creating and executing sales strategies. Manages sales team.', 65000, 'Tom Smith');
--Вставка данных в таблицу "Staff"

--
-- TOC entry 3436 (class 0 OID 24725)
-- Dependencies: 226
-- Data for Name: Violation; Type: TABLE DATA; Schema: lab; Owner: postgres
--

INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (1, 201, 152);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (2, 105, 128);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (3, 210, 147);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (4, 104, 160);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (5, 212, 133);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (6, 154, 165);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (7, 101, 152);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (8, 135, 143);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (9, 116, 144);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (10, 189, 160);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (11, 144, 153);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (12, 182, 155);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (13, 143, 133);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (14, 185, 153);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (15, 177, 135);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (16, 178, 155);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (17, 112, 125);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (18, 191, 158);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (19, 110, 162);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (20, 176, 152);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (21, 107, 140);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (22, 104, 125);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (23, 120, 142);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (24, 213, 156);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (25, 154, 142);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (26, 134, 148);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (27, 180, 138);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (28, 109, 139);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (29, 106, 121);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (30, 194, 161);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (31, 134, 138);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (32, 210, 154);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (33, 154, 134);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (34, 130, 157);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (35, 124, 124);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (36, 195, 129);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (37, 132, 126);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (38, 106, 159);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (39, 137, 156);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (40, 108, 160);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (41, 136, 134);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (42, 144, 150);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (43, 135, 137);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (44, 165, 130);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (45, 193, 154);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (46, 209, 162);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (47, 202, 131);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (48, 206, 125);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (49, 114, 142);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (50, 161, 130);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (51, 153, 136);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (52, 211, 154);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (53, 115, 132);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (54, 128, 130);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (55, 122, 127);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (56, 103, 157);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (57, 164, 133);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (58, 187, 142);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (59, 198, 159);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (60, 216, 125);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (61, 210, 142);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (62, 102, 155);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (63, 214, 127);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (64, 186, 125);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (65, 152, 122);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (66, 115, 147);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (67, 163, 148);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (68, 143, 121);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (69, 120, 143);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (70, 179, 141);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (71, 150, 136);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (72, 219, 145);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (73, 142, 157);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (74, 149, 156);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (75, 182, 134);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (76, 189, 123);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (77, 203, 143);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (78, 129, 128);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (79, 128, 135);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (80, 141, 141);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (81, 168, 144);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (82, 147, 158);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (83, 174, 157);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (84, 107, 136);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (85, 148, 153);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (86, 110, 123);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (87, 216, 133);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (88, 205, 140);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (89, 116, 156);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (90, 173, 124);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (91, 152, 131);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (92, 103, 158);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (93, 171, 160);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (94, 147, 155);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (95, 139, 137);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (96, 119, 126);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (97, 114, 141);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (98, 156, 128);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (99, 125, 144);
INSERT INTO lab."Violation" ("Violation_Code", "Penalty_Code", rtr_viol_code) VALUES (100, 203, 145);
--Вставка данных в таблицу "Violation"

--
-- TOC entry 3438 (class 0 OID 33369)
-- Dependencies: 228
-- Data for Name: insurance_dict; Type: TABLE DATA; Schema: lab; Owner: postgres
--

INSERT INTO lab.insurance_dict (insur_code, insur_price, insure_name, insure_desc, "Mod_Code") VALUES (100001, 25, 'Basic insurance', 'Covers mild car damage such as scratches.', 294832);
INSERT INTO lab.insurance_dict (insur_code, insur_price, insure_name, insure_desc, "Mod_Code") VALUES (100002, 75, 'Collision insurance', 'Covers damage to your car from an accident.', 294832);
INSERT INTO lab.insurance_dict (insur_code, insur_price, insure_name, insure_desc, "Mod_Code") VALUES (100003, 125, 'Comprehensive insurance', 'Covers damage to your car from events such as theft, vandalism, or natural disasters.', 294832);
INSERT INTO lab.insurance_dict (insur_code, insur_price, insure_name, insure_desc, "Mod_Code") VALUES (100004, 30, 'Basic insurance', 'Covers mild car damage such as scratches.', 345678);
INSERT INTO lab.insurance_dict (insur_code, insur_price, insure_name, insure_desc, "Mod_Code") VALUES (100005, 85, 'Collision insurance', 'Covers damage to your car from an accident.', 345678);
INSERT INTO lab.insurance_dict (insur_code, insur_price, insure_name, insure_desc, "Mod_Code") VALUES (100006, 135, 'Comprehensive insurance', 'Covers damage to your car from events such as theft, vandalism, or natural disasters.', 345678);
INSERT INTO lab.insurance_dict (insur_code, insur_price, insure_name, insure_desc, "Mod_Code") VALUES (100007, 35, 'Basic insurance', 'Covers mild car damage such as scratches.', 456789);
INSERT INTO lab.insurance_dict (insur_code, insur_price, insure_name, insure_desc, "Mod_Code") VALUES (100008, 95, 'Collision insurance', 'Covers damage to your car from an accident.', 456789);
INSERT INTO lab.insurance_dict (insur_code, insur_price, insure_name, insure_desc, "Mod_Code") VALUES (100009, 145, 'Comprehensive insurance', 'Covers damage to your car from events such as theft, vandalism, or natural disasters.', 456789);
INSERT INTO lab.insurance_dict (insur_code, insur_price, insure_name, insure_desc, "Mod_Code") VALUES (100010, 40, 'Basic insurance', 'Covers mild car damage such as scratches.', 567890);
INSERT INTO lab.insurance_dict (insur_code, insur_price, insure_name, insure_desc, "Mod_Code") VALUES (100011, 105, 'Collision insurance', 'Covers damage to your car from an accident.', 567890);
INSERT INTO lab.insurance_dict (insur_code, insur_price, insure_name, insure_desc, "Mod_Code") VALUES (100012, 155, 'Comprehensive insurance', 'Covers damage to your car from events such as theft, vandalism, or natural disasters.', 567890);
INSERT INTO lab.insurance_dict (insur_code, insur_price, insure_name, insure_desc, "Mod_Code") VALUES (100013, 45, 'Basic insurance', 'Covers mild car damage such as scratches.', 678901);
INSERT INTO lab.insurance_dict (insur_code, insur_price, insure_name, insure_desc, "Mod_Code") VALUES (100014, 115, 'Collision insurance', 'Covers damage to your car from an accident.', 678901);
INSERT INTO lab.insurance_dict (insur_code, insur_price, insure_name, insure_desc, "Mod_Code") VALUES (100015, 165, 'Comprehensive insurance', 'Covers damage to your car from events such as theft, vandalism, or natural disasters.', 678901);
INSERT INTO lab.insurance_dict (insur_code, insur_price, insure_name, insure_desc, "Mod_Code") VALUES (100016, 50, 'Basic insurance', 'Covers mild car damage such as scratches.', 789012);
INSERT INTO lab.insurance_dict (insur_code, insur_price, insure_name, insure_desc, "Mod_Code") VALUES (100017, 125, 'Collision insurance', 'Covers damage to your car from an accident.', 789012);
INSERT INTO lab.insurance_dict (insur_code, insur_price, insure_name, insure_desc, "Mod_Code") VALUES (100018, 175, 'Comprehensive insurance', 'Covers damage to your car from events such as theft, vandalism, or natural disasters.', 789012);
INSERT INTO lab.insurance_dict (insur_code, insur_price, insure_name, insure_desc, "Mod_Code") VALUES (100021, 200, 'Comprehensive insurance', 'Covers damage from theft, fire, and weather-related incidents.', 890123);
INSERT INTO lab.insurance_dict (insur_code, insur_price, insure_name, insure_desc, "Mod_Code") VALUES (100022, 150, 'Liability insurance', 'Covers damages to other people or their property caused by the insured vehicle.', 890123);
INSERT INTO lab.insurance_dict (insur_code, insur_price, insure_name, insure_desc, "Mod_Code") VALUES (100023, 100, 'Personal injury protection', 'Covers medical expenses and lost wages for the driver and passengers in the event of an accident.', 890123);
INSERT INTO lab.insurance_dict (insur_code, insur_price, insure_name, insure_desc, "Mod_Code") VALUES (100024, 250, 'Comprehensive insurance', 'Covers damage from theft, fire, and weather-related incidents.', 901234);
INSERT INTO lab.insurance_dict (insur_code, insur_price, insure_name, insure_desc, "Mod_Code") VALUES (100025, 200, 'Liability insurance', 'Covers damages to other people or their property caused by the insured vehicle.', 901234);
INSERT INTO lab.insurance_dict (insur_code, insur_price, insure_name, insure_desc, "Mod_Code") VALUES (100026, 150, 'Personal injury protection', 'Covers medical expenses and lost wages for the driver and passengers in the event of an accident.', 901234);
--Вставка данных в таблицу lab.insurance_dict

--
-- TOC entry 3437 (class 0 OID 24812)
-- Dependencies: 227
-- Data for Name: rtr_dict; Type: TABLE DATA; Schema: lab; Owner: postgres
--

INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (121, 12.34, 'Speeding', 'Exceeding the maximum speed limit by less than 20 km/h.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (122, 25, 'Speeding', 'Exceeding the maximum speed limit by 20-40 km/h.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (123, 49.22, 'Speeding', 'Exceeding the maximum speed limit by 40-60 km/h.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (124, 74.16, 'Speeding', 'Exceeding the maximum speed limit by 60-80 km/h.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (125, 123.61, 'Speeding', 'Exceeding the maximum speed limit by more than 80 km/h.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (126, 12.34, 'Running a red light', 'Driving through a red light or stop sign.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (127, 18.51, 'Driving under influence', 'Driving under the influence of alcohol or drugs.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (128, 12.34, 'Failure to yield', 'Failing to yield to another driver or pedestrian.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (129, 74.16, 'Reckless driving', 'Driving in a manner that endangers other drivers.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (130, 37.08, 'Driving without a license', 'Driving without a valid driver’s license.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (131, 12.34, 'Improper lane change', 'Changing lanes without signaling or cutting off other drivers.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (132, 49.22, 'Following too closely', 'Following another vehicle too closely, also known as tailgating.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (133, 24.61, 'Failure to stop at a stop sign', 'Failing to come to a complete stop at a stop sign.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (134, 49.22, 'Illegal U-turn', 'Making a U-turn where it is prohibited by law.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (135, 123.61, 'Driving in a carpool lane', 'Driving in a carpool lane when not authorized or without the required number of passengers.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (136, 74.16, 'Driving with a suspended license', 'Driving with a suspended or revoked driver’s license.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (137, 123.61, 'Leaving the scene of an accident', 'Failing to stop and exchange information after being involved in an accident.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (138, 74.16, 'Driving too slowly', 'Driving significantly below the speed limit and impeding the flow of traffic.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (139, 111.94, 'Driving in a bike lane', 'Driving in a bike lane when not authorized or without a valid reason.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (140, 18.51, 'Driving with expired registration', 'Driving a vehicle with expired registration tags or without valid registration documentation.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (141, 49.22, 'Distracted driving', 'Driving while distracted by phone, food, or other activities.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (142, 12.34, 'Seatbelt violation', 'Not wearing a seatbelt while driving or riding in a vehicle.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (143, 74.16, 'Hit and run', 'Leaving the scene of an accident without stopping to exchange information.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (144, 37.08, 'Improper passing', 'Passing another vehicle in an unsafe or illegal manner.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (145, 61.44, 'Driving without insurance', 'Driving a vehicle without proper insurance coverage.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (146, 123.61, 'Street racing', 'Participating in a race or speed competition on public roads.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (147, 49.22, 'Driving too slow', 'Driving significantly below the posted speed limit and impeding traffic flow.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (148, 74.16, 'Driving in a bike lane', 'Driving a vehicle in a lane designated for bicycles.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (149, 25, 'Excessive honking', 'Using the vehicle horn excessively or for no reason.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (150, 12.34, 'Blocking an intersection', 'Entering an intersection without enough space to clear it, causing congestion.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (151, 61.44, 'Driving with an open container', 'Having an open container of alcohol in the passenger compartment of a vehicle.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (152, 49.22, 'Failing to signal', 'Failing to signal when turning or changing lanes.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (153, 123.61, 'Driving the wrong way', 'Driving in the opposite direction of traffic on a one-way street or highway.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (154, 74.16, 'Running a stop sign', 'Driving through a stop sign without coming to a complete stop.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (155, 111.94, 'Driving without headlights at night', 'Driving without turning on headlights when required, typically at night or in low visibility conditions.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (156, 37.08, 'Passing a school bus', 'Failing to stop for a school bus when its lights are flashing and its stop sign is extended.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (157, 123.61, 'Drag racing', 'Participating in a race or speed competition on public roads with one or more other vehicles.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (158, 25, 'Driving with a cracked windshield', 'Driving with a windshield that is cracked or otherwise damaged and impairs the drivers vision.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (159, 74.16, 'Failure to use turn signals', 'Failing to use turn signals when required by law, such as when changing lanes or turning.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (160, 49.22, 'Driving with an expired license', 'Driving with a drivers license that has expired and is no longer valid.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (161, 111.94, 'Driving without a seatbelt', 'Driving without wearing a seatbelt or allowing passengers to ride without wearing seatbelts.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (162, 74.16, 'Driving on a suspended license', 'Driving with a drivers license that has been suspended or revoked by the state.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (163, 49.22, 'Driving too fast for conditions', 'Driving faster than is safe or reasonable given the weather, road, or traffic conditions.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (164, 123.61, 'Driving without headlights when required', 'Driving without turning on headlights when required, typically at night or in low visibility conditions.');
INSERT INTO lab.rtr_dict (rtr_viol_code, viol_fee, viol_type, viol_descript) VALUES (165, 61.44, 'Failure to yield to emergency vehicle', 'Failing to yield to an emergency vehicle with its lights and sirens on, such as a police car or ambulance.');
--Вставка данных в таблицу lab.rtr_dict

--
-- TOC entry 3241 (class 2606 OID 24729)
-- Name: Accidents Accidents_pkey; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab."Accidents"
    ADD CONSTRAINT "Accidents_pkey" PRIMARY KEY ("Accident_DT");
--Первичный ключ для таблицы lab.Accidents = Accident_DT


--
-- TOC entry 3243 (class 2606 OID 33247)
-- Name: Auto Auto_pkey; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab."Auto"
    ADD CONSTRAINT "Auto_pkey" PRIMARY KEY ("Auto_Code");
--Первичный ключ для таблицы lab.Auto = Auto_Code

--
-- TOC entry 3245 (class 2606 OID 33415)
-- Name: Bonus_Card Bonus_Card_pkey; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab."Bonus_Card"
    ADD CONSTRAINT "Bonus_Card_pkey" PRIMARY KEY ("BC_Code");
--Первичный ключ для таблицы lab.Bonus_Card = BC_Code

--
-- TOC entry 3247 (class 2606 OID 33208)
-- Name: Client Client_pkey; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab."Client"
    ADD CONSTRAINT "Client_pkey" PRIMARY KEY ("Cl_Code");
--Первичный ключ для таблицы lab.Client = Cl_Code

--
-- TOC entry 3255 (class 2606 OID 33264)
-- Name: Contract Contract_pkey; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab."Contract"
    ADD CONSTRAINT "Contract_pkey" PRIMARY KEY ("Contr_Code");
--Первичный ключ для таблицы lab.Contract = Contr_Code

--
-- TOC entry 3257 (class 2606 OID 33300)
-- Name: Extension Extension_pkey; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab."Extension"
    ADD CONSTRAINT "Extension_pkey" PRIMARY KEY ("Extension_Id");
--Первичный ключ для таблицы lab.Extension = Extension_Id

--
-- TOC entry 3259 (class 2606 OID 33306)
-- Name: Model Model_pkey; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab."Model"
    ADD CONSTRAINT "Model_pkey" PRIMARY KEY ("Mod_Code");
--Первичный ключ для таблицы lab.Model = Mod_Code

--
-- TOC entry 3261 (class 2606 OID 33324)
-- Name: Penalties Penalties_pkey; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab."Penalties"
    ADD CONSTRAINT "Penalties_pkey" PRIMARY KEY ("Penalty_Code");
--Первичный ключ для таблицы lab.Penalties = Penalty_Code

--
-- TOC entry 3263 (class 2606 OID 33335)
-- Name: Price Price_pkey; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab."Price"
    ADD CONSTRAINT "Price_pkey" PRIMARY KEY ("Price_Code");
--Первичный ключ для таблицы lab.Price = Price_Code

--
-- TOC entry 3265 (class 2606 OID 33341)
-- Name: Staff Staff_pkey; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab."Staff"
    ADD CONSTRAINT "Staff_pkey" PRIMARY KEY ("Stf_Code");
--Первичный ключ для таблицы lab.Staff = Stf_Code

--
-- TOC entry 3267 (class 2606 OID 33352)
-- Name: Violation Violation_pkey; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab."Violation"
    ADD CONSTRAINT "Violation_pkey" PRIMARY KEY ("Violation_Code");
--Первичный ключ для таблицы lab.Violation = Violation_Code

--
-- TOC entry 3271 (class 2606 OID 33390)
-- Name: insurance_dict insurance_dict_pkey; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.insurance_dict
    ADD CONSTRAINT insurance_dict_pkey PRIMARY KEY (insur_code);
--Первичный ключ для таблицы lab.insurance_dict = insur_code

--
-- TOC entry 3269 (class 2606 OID 33358)
-- Name: rtr_dict rtr_dict_pkey; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.rtr_dict
    ADD CONSTRAINT rtr_dict_pkey PRIMARY KEY (rtr_viol_code);
--Первичный ключ для таблицы lab.rtr_dict = rtr_viol_code

--
-- TOC entry 3249 (class 2606 OID 33407)
-- Name: Client unq_email; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab."Client"
    ADD CONSTRAINT unq_email UNIQUE ("Email");
--Constraint на уникальность Email


--
-- TOC entry 3251 (class 2606 OID 33409)
-- Name: Client unq_psprt; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab."Client"
    ADD CONSTRAINT unq_psprt UNIQUE ("Passport_Data");
--Constraint на уникальность Passport_Data

--
-- TOC entry 3253 (class 2606 OID 33411)
-- Name: Client unq_telnum; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab."Client"
    ADD CONSTRAINT unq_telnum UNIQUE ("Tel_Num");
--Constraint на уникальность Tel_Num

--
-- TOC entry 3279 (class 2606 OID 24750)
-- Name: Penalties Accident_DT; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab."Penalties"
    ADD CONSTRAINT "Accident_DT" FOREIGN KEY ("Accident_DT") REFERENCES lab."Accidents"("Accident_DT") NOT VALID;
--Внешний ключ для таблицы lab.Penalties = Accident_DT на таблицу lab.Accidents = Accident_DT

--
-- TOC entry 3275 (class 2606 OID 33275)
-- Name: Contract Auto_Code; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab."Contract"
    ADD CONSTRAINT "Auto_Code" FOREIGN KEY ("Auto_Code") REFERENCES lab."Auto"("Auto_Code") NOT VALID;
--Внешний ключ для таблицы lab.Contract = Auto_Code на таблицу lab.Auto = Auto_Code

--
-- TOC entry 3274 (class 2606 OID 33228)
-- Name: Bonus_Card Cl_Code; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab."Bonus_Card"
    ADD CONSTRAINT "Cl_Code" FOREIGN KEY ("Cl_Code") REFERENCES lab."Client"("Cl_Code") NOT VALID;
--Внешний ключ для таблицы lab.Bonus_Card = Cl_Code на таблицу lab.Client = Cl_Code

--
-- TOC entry 3276 (class 2606 OID 33270)
-- Name: Contract Cl_Code; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab."Contract"
    ADD CONSTRAINT "Cl_Code" FOREIGN KEY ("Cl_Code") REFERENCES lab."Client"("Cl_Code") NOT VALID;
--Внешний ключ для таблицы lab.Contract = Cl_Code на таблицу lab.Client = Cl_Code

--
-- TOC entry 3278 (class 2606 OID 33280)
-- Name: Extension Contr_Code; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab."Extension"
    ADD CONSTRAINT "Contr_Code" FOREIGN KEY ("Contr_Code") REFERENCES lab."Contract"("Contr_Code") NOT VALID;
--Внешний ключ для таблицы lab.Extension = Contr_Code на таблицу lab.Contract = Contr_Code

--
-- TOC entry 3272 (class 2606 OID 33290)
-- Name: Accidents Contr_Code; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab."Accidents"
    ADD CONSTRAINT "Contr_Code" FOREIGN KEY ("Contr_Code") REFERENCES lab."Contract"("Contr_Code") NOT VALID;
--Внешний ключ для таблицы lab.Accidents = Contr_Code на таблицу lab.Contract = Contr_Code

--
-- TOC entry 3280 (class 2606 OID 33307)
-- Name: Price Mod_Code; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab."Price"
    ADD CONSTRAINT "Mod_Code" FOREIGN KEY ("Mod_Code") REFERENCES lab."Model"("Mod_Code") NOT VALID;
--Внешний ключ для таблицы lab.Price = Mod_Code на таблицу lab.Model = Mod_Code

--
-- TOC entry 3273 (class 2606 OID 33312)
-- Name: Auto Mod_Code; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab."Auto"
    ADD CONSTRAINT "Mod_Code" FOREIGN KEY ("Mod_Code") REFERENCES lab."Model"("Mod_Code") NOT VALID;
--Внешний ключ для таблицы lab.Auto = Mod_Code на таблицу lab.Model = Mod_Code

--
-- TOC entry 3283 (class 2606 OID 33384)
-- Name: insurance_dict Mod_Code; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.insurance_dict
    ADD CONSTRAINT "Mod_Code" FOREIGN KEY ("Mod_Code") REFERENCES lab."Model"("Mod_Code") NOT VALID;
--Внешний ключ для таблицы lab.insurance_dict = Mod_Code на таблицу lab.Model = Mod_Code

--
-- TOC entry 3281 (class 2606 OID 33325)
-- Name: Violation Penalty_Code; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab."Violation"
    ADD CONSTRAINT "Penalty_Code" FOREIGN KEY ("Penalty_Code") REFERENCES lab."Penalties"("Penalty_Code") NOT VALID;
--Внешний ключ для таблицы lab.Violation = Penalty_Code на таблицу lab.Penalties = Penalty_Code

--
-- TOC entry 3277 (class 2606 OID 33342)
-- Name: Contract Stf_Code; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab."Contract"
    ADD CONSTRAINT "Stf_Code" FOREIGN KEY ("Stf_Code") REFERENCES lab."Staff"("Stf_Code") NOT VALID;
--Внешний ключ для таблицы lab.Contract = Stf_Code на таблицу lab.Staff = Stf_Code

--
-- TOC entry 3282 (class 2606 OID 33359)
-- Name: Violation rtr_viol_code; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab."Violation"
    ADD CONSTRAINT rtr_viol_code FOREIGN KEY (rtr_viol_code) REFERENCES lab.rtr_dict(rtr_viol_code) NOT VALID;
--Внешний ключ для таблицы lab.Violation = rtr_viol_code на таблицу lab.rtr_dict = rtr_viol_code

-- Completed on 2023-04-08 16:56:20

--
-- PostgreSQL database dump complete
--

