--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-04-03 20:08:21

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
-- TOC entry 3402 (class 1262 OID 18240)
-- Name: lab1_sem4; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE lab1_sem4 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';


ALTER DATABASE lab1_sem4 OWNER TO postgres;

\connect lab1_sem4

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 214 (class 1259 OID 18241)
-- Name: Accidents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Accidents" (
    "Contract code" integer NOT NULL,
    "Date and time of the accident" date NOT NULL,
    "Accident data" text NOT NULL,
    "Address" text NOT NULL,
    "Guilty" boolean NOT NULL
);


ALTER TABLE public."Accidents" OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 18248)
-- Name: Car; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Car" (
    "Car code" integer NOT NULL,
    "Car model" text NOT NULL,
    "Description" text NOT NULL,
    "Year of release" date NOT NULL,
    "Engine num" integer NOT NULL,
    "Body number" integer NOT NULL,
    "Rent price" money NOT NULL,
    "Mileage" integer NOT NULL,
    "Date of last maintenance" date NOT NULL,
    "A note about the refund" boolean NOT NULL,
    "Registration number" text NOT NULL,
    "Special marks" text,
    CONSTRAINT "Car_Date of last maintenance_check" CHECK (("Date of last maintenance" <= CURRENT_DATE)),
    CONSTRAINT "Car_Mileage_check" CHECK (("Mileage" > '-1'::integer)),
    CONSTRAINT "Car_Rent price_check" CHECK (("Rent price" > '0,00 ?'::money))
);


ALTER TABLE public."Car" OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 18260)
-- Name: Client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Client" (
    "Client code" integer NOT NULL,
    "Full name" text NOT NULL,
    "Passport data" text NOT NULL,
    "Adress" text NOT NULL,
    "Phone number" text NOT NULL
);


ALTER TABLE public."Client" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 18270)
-- Name: Contract; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Contract" (
    "Contract code" integer NOT NULL,
    "Date and time of the end of the lease" timestamp without time zone NOT NULL,
    "Date and time of issue" timestamp without time zone NOT NULL,
    "Date and time of return" timestamp without time zone NOT NULL,
    "Employee code" integer NOT NULL,
    "Client code" integer NOT NULL,
    "Car code" integer NOT NULL,
    CONSTRAINT "Contract_Date and time of issue_check" CHECK (("Date and time of issue" <= CURRENT_DATE)),
    CONSTRAINT "Contract_check" CHECK (("Date and time of the end of the lease" > "Date and time of issue")),
    CONSTRAINT "Contract_check1" CHECK (("Date and time of return" > "Date and time of issue"))
);


ALTER TABLE public."Contract" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 18269)
-- Name: Contract_Contract code_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."Contract" ALTER COLUMN "Contract code" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Contract_Contract code_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 219 (class 1259 OID 18278)
-- Name: Employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Employee" (
    "Employee code" integer NOT NULL,
    "Full name" text NOT NULL,
    "Passport data" text NOT NULL,
    "Salary" money NOT NULL,
    "Post code" integer NOT NULL,
    CONSTRAINT "Employee_Salary_check" CHECK (("Salary" > '0,00 ?'::money))
);


ALTER TABLE public."Employee" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 18288)
-- Name: Extension; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Extension" (
    "Contract code" integer NOT NULL,
    "Renewal date" date NOT NULL,
    "Extension time" integer NOT NULL
);


ALTER TABLE public."Extension" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 18291)
-- Name: Post; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Post" (
    "Post code" integer NOT NULL,
    "Post name" text NOT NULL,
    "Duties" text NOT NULL
);


ALTER TABLE public."Post" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 18298)
-- Name: Technical specifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Technical specifications" (
    "Car model" text NOT NULL,
    "Сar brand" text NOT NULL,
    "Car price" money NOT NULL,
    "Engine capacity" integer NOT NULL,
    "Fuel consumption" integer NOT NULL,
    CONSTRAINT "Technical specifications_Car price_check" CHECK (("Car price" > '0,00 ?'::money)),
    CONSTRAINT "Technical specifications_Engine capacity_check" CHECK (("Engine capacity" > 0)),
    CONSTRAINT "Technical specifications_Fuel consumption_check" CHECK (("Fuel consumption" > 0))
);


ALTER TABLE public."Technical specifications" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 18308)
-- Name: Violation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Violation" (
    "Contract code" integer NOT NULL,
    "Date and time of the violation" timestamp without time zone NOT NULL,
    "Violation data" text NOT NULL,
    "Address" text NOT NULL,
    "Fine" money NOT NULL
);


ALTER TABLE public."Violation" OWNER TO postgres;

--
-- TOC entry 3387 (class 0 OID 18241)
-- Dependencies: 214
-- Data for Name: Accidents; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Accidents" ("Contract code", "Date and time of the accident", "Accident data", "Address", "Guilty") VALUES (3, '2019-01-23', 'Помяьый бампер, сломанная фара, пострадавших нет', 'Россия, г. Хабаровск, Октябрьская ул., д. 14 кв.104', false);


--
-- TOC entry 3388 (class 0 OID 18248)
-- Dependencies: 215
-- Data for Name: Car; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Car" ("Car code", "Car model", "Description", "Year of release", "Engine num", "Body number", "Rent price", "Mileage", "Date of last maintenance", "A note about the refund", "Registration number", "Special marks") VALUES (1, 'Aveo', 'Тёмно-зелёный, быстрый, старый', '1989-03-25', 17493571, 44263998, '50,00 ?', 20000, '2023-03-14', false, 'В679УТ32', NULL);
INSERT INTO public."Car" ("Car code", "Car model", "Description", "Year of release", "Engine num", "Body number", "Rent price", "Mileage", "Date of last maintenance", "A note about the refund", "Registration number", "Special marks") VALUES (2, 'A4 Allroad Quattro', 'Светло-голубой, медленный, новый', '2011-03-25', 77870528, 70221027, '120,00 ?', 3000, '2023-02-17', true, 'А920ВМ56', NULL);
INSERT INTO public."Car" ("Car code", "Car model", "Description", "Year of release", "Engine num", "Body number", "Rent price", "Mileage", "Date of last maintenance", "A note about the refund", "Registration number", "Special marks") VALUES (3, 'M2', 'Серо-бежевый, быстрый, элитный', '2015-03-25', 35666883, 70854080, '150,00 ?', 5500, '2023-02-24', true, 'Т228ЕК67', NULL);
INSERT INTO public."Car" ("Car code", "Car model", "Description", "Year of release", "Engine num", "Body number", "Rent price", "Mileage", "Date of last maintenance", "A note about the refund", "Registration number", "Special marks") VALUES (4, 'Nexia', 'Серебристо-зелёный, скоростной, не новый', '2003-03-14', 98562424, 21718001, '67,00 ?', 7800, '2023-02-13', false, 'Е979УС45', NULL);
INSERT INTO public."Car" ("Car code", "Car model", "Description", "Year of release", "Engine num", "Body number", "Rent price", "Mileage", "Date of last maintenance", "A note about the refund", "Registration number", "Special marks") VALUES (5, 'Emgrand 7', 'Тёмно-бордовый, быстрый, с автопилотом', '2021-03-25', 86226869, 18754839, '125,00 ?', 1000, '2023-01-24', false, 'Е449СХ17', NULL);
INSERT INTO public."Car" ("Car code", "Car model", "Description", "Year of release", "Engine num", "Body number", "Rent price", "Mileage", "Date of last maintenance", "A note about the refund", "Registration number", "Special marks") VALUES (6, 'Lacetti', 'Сине-зелёный', '2011-07-02', 14847224, 53192890, '370,00 ?', 21282, '2023-02-17', false, 'I601EH47', NULL);
INSERT INTO public."Car" ("Car code", "Car model", "Description", "Year of release", "Engine num", "Body number", "Rent price", "Mileage", "Date of last maintenance", "A note about the refund", "Registration number", "Special marks") VALUES (7, 'Nexia', 'Желто-золотой', '2000-12-08', 90581365, 57343634, '377,00 ?', 32277, '2023-01-18', false, 'M648HT91', NULL);
INSERT INTO public."Car" ("Car code", "Car model", "Description", "Year of release", "Engine num", "Body number", "Rent price", "Mileage", "Date of last maintenance", "A note about the refund", "Registration number", "Special marks") VALUES (8, 'Lacetti', 'Ярко-красный', '2008-07-30', 36007059, 89002374, '279,00 ?', 9634, '2023-03-11', true, 'U208NP55', NULL);
INSERT INTO public."Car" ("Car code", "Car model", "Description", "Year of release", "Engine num", "Body number", "Rent price", "Mileage", "Date of last maintenance", "A note about the refund", "Registration number", "Special marks") VALUES (9, 'M2', 'Серебристо-серо-графитовый', '2010-03-28', 71518142, 43794816, '269,00 ?', 22908, '2023-02-15', true, 'Y315FT44', NULL);
INSERT INTO public."Car" ("Car code", "Car model", "Description", "Year of release", "Engine num", "Body number", "Rent price", "Mileage", "Date of last maintenance", "A note about the refund", "Registration number", "Special marks") VALUES (10, 'Aveo', 'Тёмно-бежевый', '1990-11-18', 83749148, 91108688, '371,00 ?', 8636, '2023-02-23', true, 'Z972FO11', NULL);


--
-- TOC entry 3389 (class 0 OID 18260)
-- Dependencies: 216
-- Data for Name: Client; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Client" ("Client code", "Full name", "Passport data", "Adress", "Phone number") VALUES (4050, 'Горностаев Марк Савванович', '3919 954134', 'Россия, г. Новокуйбышевск, Полесская ул., д. 15 кв.188', '+79193290766');
INSERT INTO public."Client" ("Client code", "Full name", "Passport data", "Adress", "Phone number") VALUES (9539, 'Маринин Игнат Нифонтович', '9967 878648', 'Россия, г. Томск, Светлая ул., д. 6 кв.166', '+79194284293');
INSERT INTO public."Client" ("Client code", "Full name", "Passport data", "Adress", "Phone number") VALUES (7069, 'Щедров Арсений Львович', '9597 430368', 'Россия, г. Подольск, Цветочная ул., д. 16 кв.205', '+79198805493');
INSERT INTO public."Client" ("Client code", "Full name", "Passport data", "Adress", "Phone number") VALUES (2959, 'Махова Валентина Кирилловна', '3922 367927', 'Россия, г. Ноябрьск, Солнечный пер., д. 13 кв.48', '+79155297873');
INSERT INTO public."Client" ("Client code", "Full name", "Passport data", "Adress", "Phone number") VALUES (6413, 'Высоцкий Валерий Всеволодович', '7512 899288', 'Россия, г. Мытищи, Светлая ул., д. 5 кв.206', '+79165210293');
INSERT INTO public."Client" ("Client code", "Full name", "Passport data", "Adress", "Phone number") VALUES (3367, 'Лызлова Валерия Михаиловна', '6042 409406', 'Россия, г. Тюмень, Молодежная ул., д. 12 кв.53', '+79126735509');
INSERT INTO public."Client" ("Client code", "Full name", "Passport data", "Adress", "Phone number") VALUES (8942, 'Каменских Вероника Валериановна', '1505 735159', 'Россия, г. Курск, Советский пер., д. 2 кв.48', '+79103585060');
INSERT INTO public."Client" ("Client code", "Full name", "Passport data", "Adress", "Phone number") VALUES (3315, 'Курнакова Юлиана Гаврннловна', '8798 229274', 'Россия, г. Нефтеюганск, Трудовая ул., д. 7 кв.173', '+79156540588');
INSERT INTO public."Client" ("Client code", "Full name", "Passport data", "Adress", "Phone number") VALUES (8259, 'Эльмпта Алена Александровна', '8110 570533', 'Россия, г. Архангельск, Парковая ул., д. 10 кв.89', '+79129795984');
INSERT INTO public."Client" ("Client code", "Full name", "Passport data", "Adress", "Phone number") VALUES (9881, 'Мяукин Александр Леонидович', '2402 876751', 'Россия, г. Ростов-на-Дону, Сельская ул., д. 24 кв.214', '+79166471275');


--
-- TOC entry 3391 (class 0 OID 18270)
-- Dependencies: 218
-- Data for Name: Contract; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Contract" ("Contract code", "Date and time of the end of the lease", "Date and time of issue", "Date and time of return", "Employee code", "Client code", "Car code") OVERRIDING SYSTEM VALUE VALUES (1, '2022-09-10 00:00:00', '2022-08-10 00:00:00', '2022-10-11 00:00:00', 5473, 6413, 1);
INSERT INTO public."Contract" ("Contract code", "Date and time of the end of the lease", "Date and time of issue", "Date and time of return", "Employee code", "Client code", "Car code") OVERRIDING SYSTEM VALUE VALUES (2, '2018-06-28 00:00:00', '2018-05-12 00:00:00', '2018-08-21 00:00:00', 5473, 2959, 3);
INSERT INTO public."Contract" ("Contract code", "Date and time of the end of the lease", "Date and time of issue", "Date and time of return", "Employee code", "Client code", "Car code") OVERRIDING SYSTEM VALUE VALUES (3, '2019-01-23 00:00:00', '2018-12-22 00:00:00', '2019-01-26 00:00:00', 3246, 8259, 4);
INSERT INTO public."Contract" ("Contract code", "Date and time of the end of the lease", "Date and time of issue", "Date and time of return", "Employee code", "Client code", "Car code") OVERRIDING SYSTEM VALUE VALUES (4, '2019-08-15 00:00:00', '2019-05-08 00:00:00', '2019-08-21 00:00:00', 3246, 7069, 1);
INSERT INTO public."Contract" ("Contract code", "Date and time of the end of the lease", "Date and time of issue", "Date and time of return", "Employee code", "Client code", "Car code") OVERRIDING SYSTEM VALUE VALUES (5, '2012-10-01 00:00:00', '2012-09-02 00:00:00', '2012-10-22 00:00:00', 5473, 8259, 5);
INSERT INTO public."Contract" ("Contract code", "Date and time of the end of the lease", "Date and time of issue", "Date and time of return", "Employee code", "Client code", "Car code") OVERRIDING SYSTEM VALUE VALUES (6, '2021-08-13 00:00:00', '2021-08-02 00:00:00', '2021-08-30 00:00:00', 8554, 7069, 3);
INSERT INTO public."Contract" ("Contract code", "Date and time of the end of the lease", "Date and time of issue", "Date and time of return", "Employee code", "Client code", "Car code") OVERRIDING SYSTEM VALUE VALUES (7, '2021-10-27 00:00:00', '2021-09-22 00:00:00', '2021-11-01 00:00:00', 5473, 8942, 10);
INSERT INTO public."Contract" ("Contract code", "Date and time of the end of the lease", "Date and time of issue", "Date and time of return", "Employee code", "Client code", "Car code") OVERRIDING SYSTEM VALUE VALUES (8, '2016-06-26 00:00:00', '2016-06-10 00:00:00', '2016-07-13 00:00:00', 8554, 8942, 7);
INSERT INTO public."Contract" ("Contract code", "Date and time of the end of the lease", "Date and time of issue", "Date and time of return", "Employee code", "Client code", "Car code") OVERRIDING SYSTEM VALUE VALUES (9, '20020-06-01 00:00:00', '2020-05-01 00:00:00', '2020-08-19 00:00:00', 5473, 2959, 8);
INSERT INTO public."Contract" ("Contract code", "Date and time of the end of the lease", "Date and time of issue", "Date and time of return", "Employee code", "Client code", "Car code") OVERRIDING SYSTEM VALUE VALUES (10, '2023-05-08 00:00:00', '2023-02-27 00:00:00', '2023-07-16 00:00:00', 5473, 8942, 6);


--
-- TOC entry 3392 (class 0 OID 18278)
-- Dependencies: 219
-- Data for Name: Employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Employee" ("Employee code", "Full name", "Passport data", "Salary", "Post code") VALUES (5342, 'Якунов Афанасий Наумович', '4146 877607', '150 000,00 ?', 1);
INSERT INTO public."Employee" ("Employee code", "Full name", "Passport data", "Salary", "Post code") VALUES (7643, 'Щеглова Варвара Юрьевна', '4979 146309', '80 000,00 ?', 2);
INSERT INTO public."Employee" ("Employee code", "Full name", "Passport data", "Salary", "Post code") VALUES (3246, 'Харламова Лана Аркадьевна', '4191 968499', '58 000,00 ?', 3);
INSERT INTO public."Employee" ("Employee code", "Full name", "Passport data", "Salary", "Post code") VALUES (8554, 'Ивашечкин Ростислав Филиппович', '4373 778601', '63 000,00 ?', 3);
INSERT INTO public."Employee" ("Employee code", "Full name", "Passport data", "Salary", "Post code") VALUES (5753, 'Островерха Арина Никифоровна', '4029 542205', '61 000,00 ?', 3);
INSERT INTO public."Employee" ("Employee code", "Full name", "Passport data", "Salary", "Post code") VALUES (5473, 'Лопатин Валентин Егорович', '4468 321716', '90 000,00 ?', 4);
INSERT INTO public."Employee" ("Employee code", "Full name", "Passport data", "Salary", "Post code") VALUES (3268, 'Фролов Леонтий Георгиевич', '4519 118430', '70 000,00 ?', 5);


--
-- TOC entry 3393 (class 0 OID 18288)
-- Dependencies: 220
-- Data for Name: Extension; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Extension" ("Contract code", "Renewal date", "Extension time") VALUES (1, '2022-10-11', 20);
INSERT INTO public."Extension" ("Contract code", "Renewal date", "Extension time") VALUES (5, '2012-10-22', 90);


--
-- TOC entry 3394 (class 0 OID 18291)
-- Dependencies: 221
-- Data for Name: Post; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Post" ("Post code", "Post name", "Duties") VALUES (1, 'Директор', 'Управление компанией');
INSERT INTO public."Post" ("Post code", "Post name", "Duties") VALUES (2, 'Бухгалетр', 'Управление финансами');
INSERT INTO public."Post" ("Post code", "Post name", "Duties") VALUES (3, 'Менеджер продаж', 'Сдача автомобилей в аренду');
INSERT INTO public."Post" ("Post code", "Post name", "Duties") VALUES (4, 'Системный администратор', 'Заведует локальной сетью компании');
INSERT INTO public."Post" ("Post code", "Post name", "Duties") VALUES (5, 'Рекламный менеджер', 'Реклама');


--
-- TOC entry 3395 (class 0 OID 18298)
-- Dependencies: 222
-- Data for Name: Technical specifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Technical specifications" ("Car model", "Сar brand", "Car price", "Engine capacity", "Fuel consumption") VALUES ('A4 Allroad Quattro', 'Audi', '3 000,00 ?', 78, 2);
INSERT INTO public."Technical specifications" ("Car model", "Сar brand", "Car price", "Engine capacity", "Fuel consumption") VALUES ('Lacetti', 'Chevrolet', '5 000,00 ?', 60, 1);
INSERT INTO public."Technical specifications" ("Car model", "Сar brand", "Car price", "Engine capacity", "Fuel consumption") VALUES ('M2', 'BMW', '10 000,00 ?', 73, 2);
INSERT INTO public."Technical specifications" ("Car model", "Сar brand", "Car price", "Engine capacity", "Fuel consumption") VALUES ('Epica', 'Chevrolet', '4 750,00 ?', 57, 1);
INSERT INTO public."Technical specifications" ("Car model", "Сar brand", "Car price", "Engine capacity", "Fuel consumption") VALUES ('Nexia', 'Daewoo', '3 270,00 ?', 120, 3);
INSERT INTO public."Technical specifications" ("Car model", "Сar brand", "Car price", "Engine capacity", "Fuel consumption") VALUES ('Aveo', 'Chevrolet', '4 375,00 ?', 95, 2);
INSERT INTO public."Technical specifications" ("Car model", "Сar brand", "Car price", "Engine capacity", "Fuel consumption") VALUES ('Panda 4x4', 'Fiat', '11 075,00 ?', 92, 1);
INSERT INTO public."Technical specifications" ("Car model", "Сar brand", "Car price", "Engine capacity", "Fuel consumption") VALUES ('Punto', 'Fiat', '7 075,00 ?', 52, 1);
INSERT INTO public."Technical specifications" ("Car model", "Сar brand", "Car price", "Engine capacity", "Fuel consumption") VALUES ('Focus Active', 'Ford', '5 254,00 ?', 85, 2);
INSERT INTO public."Technical specifications" ("Car model", "Сar brand", "Car price", "Engine capacity", "Fuel consumption") VALUES ('X6', 'BMW', '4 678,00 ?', 145, 3);
INSERT INTO public."Technical specifications" ("Car model", "Сar brand", "Car price", "Engine capacity", "Fuel consumption") VALUES ('Emgrand 7', 'Geely', '4 375,00 ?', 64, 1);


--
-- TOC entry 3396 (class 0 OID 18308)
-- Dependencies: 223
-- Data for Name: Violation; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Violation" ("Contract code", "Date and time of the violation", "Violation data", "Address", "Fine") VALUES (4, '2019-08-15 00:00:00', 'Проезд на красный', 'Россия, г. Волгоград, Гагарина ул., д. 8', '100,00 ?');
INSERT INTO public."Violation" ("Contract code", "Date and time of the violation", "Violation data", "Address", "Fine") VALUES (7, '2021-10-27 00:00:00', 'Врезался в фанарный столб', 'Россия, г. Сочи, Первомайский пер., д. 6', '500,00 ?');


--
-- TOC entry 3403 (class 0 OID 0)
-- Dependencies: 217
-- Name: Contract_Contract code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Contract_Contract code_seq"', 10, true);


--
-- TOC entry 3216 (class 2606 OID 18247)
-- Name: Accidents Accidents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Accidents"
    ADD CONSTRAINT "Accidents_pkey" PRIMARY KEY ("Date and time of the accident");


--
-- TOC entry 3218 (class 2606 OID 18259)
-- Name: Car Car_Engine num_Body number_Registration number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Car"
    ADD CONSTRAINT "Car_Engine num_Body number_Registration number_key" UNIQUE ("Engine num", "Body number", "Registration number");


--
-- TOC entry 3220 (class 2606 OID 18257)
-- Name: Car Car_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Car"
    ADD CONSTRAINT "Car_pkey" PRIMARY KEY ("Car code");


--
-- TOC entry 3222 (class 2606 OID 18268)
-- Name: Client Client_Passport data_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Client"
    ADD CONSTRAINT "Client_Passport data_key" UNIQUE ("Passport data");


--
-- TOC entry 3224 (class 2606 OID 18266)
-- Name: Client Client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Client"
    ADD CONSTRAINT "Client_pkey" PRIMARY KEY ("Client code");


--
-- TOC entry 3226 (class 2606 OID 18277)
-- Name: Contract Contract_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Contract"
    ADD CONSTRAINT "Contract_pkey" PRIMARY KEY ("Contract code");


--
-- TOC entry 3228 (class 2606 OID 18287)
-- Name: Employee Employee_Passport data_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employee"
    ADD CONSTRAINT "Employee_Passport data_key" UNIQUE ("Passport data");


--
-- TOC entry 3230 (class 2606 OID 18285)
-- Name: Employee Employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employee"
    ADD CONSTRAINT "Employee_pkey" PRIMARY KEY ("Employee code");


--
-- TOC entry 3232 (class 2606 OID 18297)
-- Name: Post Post_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Post"
    ADD CONSTRAINT "Post_pkey" PRIMARY KEY ("Post code");


--
-- TOC entry 3234 (class 2606 OID 18307)
-- Name: Technical specifications Technical specifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Technical specifications"
    ADD CONSTRAINT "Technical specifications_pkey" PRIMARY KEY ("Car model");


--
-- TOC entry 3236 (class 2606 OID 18314)
-- Name: Violation Violation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Violation"
    ADD CONSTRAINT "Violation_pkey" PRIMARY KEY ("Date and time of the violation");


--
-- TOC entry 3239 (class 2606 OID 18325)
-- Name: Contract Client_contract; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Contract"
    ADD CONSTRAINT "Client_contract" FOREIGN KEY ("Client code") REFERENCES public."Client"("Client code") NOT VALID;


--
-- TOC entry 3237 (class 2606 OID 18315)
-- Name: Accidents Contract_accidents; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Accidents"
    ADD CONSTRAINT "Contract_accidents" FOREIGN KEY ("Contract code") REFERENCES public."Contract"("Contract code") NOT VALID;


--
-- TOC entry 3243 (class 2606 OID 18345)
-- Name: Extension Contract_extension; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Extension"
    ADD CONSTRAINT "Contract_extension" FOREIGN KEY ("Contract code") REFERENCES public."Contract"("Contract code") NOT VALID;


--
-- TOC entry 3244 (class 2606 OID 18350)
-- Name: Violation Contract_violation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Violation"
    ADD CONSTRAINT "Contract_violation" FOREIGN KEY ("Contract code") REFERENCES public."Contract"("Contract code") NOT VALID;


--
-- TOC entry 3240 (class 2606 OID 18330)
-- Name: Contract Employee_contract; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Contract"
    ADD CONSTRAINT "Employee_contract" FOREIGN KEY ("Employee code") REFERENCES public."Employee"("Employee code") NOT VALID;


--
-- TOC entry 3242 (class 2606 OID 18340)
-- Name: Employee Post_employee; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employee"
    ADD CONSTRAINT "Post_employee" FOREIGN KEY ("Post code") REFERENCES public."Post"("Post code") NOT VALID;


--
-- TOC entry 3238 (class 2606 OID 18320)
-- Name: Car Technical specifications_car; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Car"
    ADD CONSTRAINT "Technical specifications_car" FOREIGN KEY ("Car model") REFERENCES public."Technical specifications"("Car model") NOT VALID;


--
-- TOC entry 3241 (class 2606 OID 18335)
-- Name: Contract car_contract; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Contract"
    ADD CONSTRAINT car_contract FOREIGN KEY ("Car code") REFERENCES public."Car"("Car code") NOT VALID;


-- Completed on 2023-04-03 20:08:21

--
-- PostgreSQL database dump complete
--

