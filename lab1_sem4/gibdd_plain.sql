--
-- PostgreSQL database dump
--

-- Dumped from database version 11.20
-- Dumped by pg_dump version 11.20

-- Started on 2023-10-02 16:47:23

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
-- TOC entry 8 (class 2615 OID 16429)
-- Name: GIBDD; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "GIBDD";


ALTER SCHEMA "GIBDD" OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 199 (class 1259 OID 16445)
-- Name: CAR; Type: TABLE; Schema: GIBDD; Owner: postgres
--

CREATE TABLE "GIBDD"."CAR" (
    "VIN" character varying(17) NOT NULL,
    id_model_car integer NOT NULL,
    year_made integer NOT NULL,
    color character varying(20),
    id_car integer NOT NULL
);


ALTER TABLE "GIBDD"."CAR" OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 16460)
-- Name: CAR_OWNER; Type: TABLE; Schema: GIBDD; Owner: postgres
--

CREATE TABLE "GIBDD"."CAR_OWNER" (
    id_citizen_owner integer NOT NULL,
    license_number character(10) NOT NULL
);


ALTER TABLE "GIBDD"."CAR_OWNER" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 24788)
-- Name: CAR_id_car_seq; Type: SEQUENCE; Schema: GIBDD; Owner: postgres
--

ALTER TABLE "GIBDD"."CAR" ALTER COLUMN id_car ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "GIBDD"."CAR_id_car_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 211 (class 1259 OID 16607)
-- Name: CITIZEN; Type: TABLE; Schema: GIBDD; Owner: postgres
--

CREATE TABLE "GIBDD"."CITIZEN" (
    id_citizen integer NOT NULL,
    full_name character varying(100) NOT NULL,
    phone character varying(12) NOT NULL,
    adress character varying(100) NOT NULL,
    passport character(10) NOT NULL
);


ALTER TABLE "GIBDD"."CITIZEN" OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16750)
-- Name: CITIZEN_id_citizen_seq; Type: SEQUENCE; Schema: GIBDD; Owner: postgres
--

ALTER TABLE "GIBDD"."CITIZEN" ALTER COLUMN id_citizen ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "GIBDD"."CITIZEN_id_citizen_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 203 (class 1259 OID 16467)
-- Name: DEPARTMENT; Type: TABLE; Schema: GIBDD; Owner: postgres
--

CREATE TABLE "GIBDD"."DEPARTMENT" (
    id_dep integer NOT NULL,
    dep_name character varying(80) NOT NULL,
    dep_adress character varying(100) NOT NULL
);


ALTER TABLE "GIBDD"."DEPARTMENT" OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16465)
-- Name: DEPARTMENTS_id_dep_seq; Type: SEQUENCE; Schema: GIBDD; Owner: postgres
--

ALTER TABLE "GIBDD"."DEPARTMENT" ALTER COLUMN id_dep ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "GIBDD"."DEPARTMENTS_id_dep_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 207 (class 1259 OID 16481)
-- Name: DTP; Type: TABLE; Schema: GIBDD; Owner: postgres
--

CREATE TABLE "GIBDD"."DTP" (
    id_dtp integer NOT NULL,
    id_officer_dtp integer NOT NULL,
    dtp_description text NOT NULL
);


ALTER TABLE "GIBDD"."DTP" OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16614)
-- Name: DTP_PARTICIPANT; Type: TABLE; Schema: GIBDD; Owner: postgres
--

CREATE TABLE "GIBDD"."DTP_PARTICIPANT" (
    participant_id integer NOT NULL,
    status character varying(20),
    id_reg_participant integer,
    id_dtp_participant integer
);


ALTER TABLE "GIBDD"."DTP_PARTICIPANT" OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16612)
-- Name: DTP_PARTICIPANT_participant_id_seq; Type: SEQUENCE; Schema: GIBDD; Owner: postgres
--

ALTER TABLE "GIBDD"."DTP_PARTICIPANT" ALTER COLUMN participant_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "GIBDD"."DTP_PARTICIPANT_participant_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 206 (class 1259 OID 16479)
-- Name: DTP_id_dtp_seq; Type: SEQUENCE; Schema: GIBDD; Owner: postgres
--

ALTER TABLE "GIBDD"."DTP" ALTER COLUMN id_dtp ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "GIBDD"."DTP_id_dtp_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 198 (class 1259 OID 16432)
-- Name: MODEL; Type: TABLE; Schema: GIBDD; Owner: postgres
--

CREATE TABLE "GIBDD"."MODEL" (
    id_model integer NOT NULL,
    model_name character varying(80) NOT NULL,
    brand character varying(30) NOT NULL,
    country character varying(80) NOT NULL,
    specifications text NOT NULL
);


ALTER TABLE "GIBDD"."MODEL" OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16474)
-- Name: OFFICER; Type: TABLE; Schema: GIBDD; Owner: postgres
--

CREATE TABLE "GIBDD"."OFFICER" (
    id_officer integer NOT NULL,
    id_dep_officer integer NOT NULL,
    role character varying(80) NOT NULL,
    id_citizen_officer integer NOT NULL
);


ALTER TABLE "GIBDD"."OFFICER" OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16472)
-- Name: OFFICERS_id_officer_seq; Type: SEQUENCE; Schema: GIBDD; Owner: postgres
--

ALTER TABLE "GIBDD"."OFFICER" ALTER COLUMN id_officer ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "GIBDD"."OFFICERS_id_officer_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 200 (class 1259 OID 16455)
-- Name: REG_CAR; Type: TABLE; Schema: GIBDD; Owner: postgres
--

CREATE TABLE "GIBDD"."REG_CAR" (
    id_reg integer NOT NULL,
    id_department_reg integer NOT NULL,
    reg_start_date date NOT NULL,
    license_plate_reg character varying(10) NOT NULL,
    license_number_reg character(10),
    id_car_reg integer,
    reg_end_date date
);


ALTER TABLE "GIBDD"."REG_CAR" OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16745)
-- Name: REG_CAR_id_reg_seq; Type: SEQUENCE; Schema: GIBDD; Owner: postgres
--

ALTER TABLE "GIBDD"."REG_CAR" ALTER COLUMN id_reg ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "GIBDD"."REG_CAR_id_reg_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 208 (class 1259 OID 16490)
-- Name: VIOLATION; Type: TABLE; Schema: GIBDD; Owner: postgres
--

CREATE TABLE "GIBDD"."VIOLATION" (
    id_violation integer NOT NULL,
    payment_status boolean NOT NULL,
    violation_code integer NOT NULL,
    type character varying(20) NOT NULL,
    vio_date date NOT NULL,
    vio_district character varying(40) NOT NULL,
    vio_street character varying(40) NOT NULL,
    id_dtp_vio integer,
    vio_time time without time zone
);


ALTER TABLE "GIBDD"."VIOLATION" OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16497)
-- Name: VIOLATIONS_CATALOG; Type: TABLE; Schema: GIBDD; Owner: postgres
--

CREATE TABLE "GIBDD"."VIOLATIONS_CATALOG" (
    violation_id_code integer NOT NULL,
    violation_description text NOT NULL,
    basic_fine numeric(100,2) NOT NULL,
    second_time_fine numeric(100,2) NOT NULL,
    license_suspension_time interval
);


ALTER TABLE "GIBDD"."VIOLATIONS_CATALOG" OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16826)
-- Name: VIOLATION_id_violation_seq; Type: SEQUENCE; Schema: GIBDD; Owner: postgres
--

ALTER TABLE "GIBDD"."VIOLATION" ALTER COLUMN id_violation ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "GIBDD"."VIOLATION_id_violation_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 209 (class 1259 OID 16495)
-- Name: violations_catalog_violation_id_code_seq; Type: SEQUENCE; Schema: GIBDD; Owner: postgres
--

ALTER TABLE "GIBDD"."VIOLATIONS_CATALOG" ALTER COLUMN violation_id_code ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "GIBDD".violations_catalog_violation_id_code_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 197 (class 1259 OID 16430)
-- Name: Модель_ID модели_seq; Type: SEQUENCE; Schema: GIBDD; Owner: postgres
--

ALTER TABLE "GIBDD"."MODEL" ALTER COLUMN id_model ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "GIBDD"."Модель_ID модели_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 2925 (class 0 OID 16445)
-- Dependencies: 199
-- Data for Name: CAR; Type: TABLE DATA; Schema: GIBDD; Owner: postgres
--

COPY "GIBDD"."CAR" ("VIN", id_model_car, year_made, color, id_car) FROM stdin;
1FABP64R2KH157796	6	2019	Red	4
1ZVFT80N475211367	2	2015	Gray	2
5N3ZA0NE6AN906847	1	2010	Black	1
5UXFE4C53AL800509	5	2022	White	3
ZHWGC6AU8BLA10474	7	2023	Green	5
\.


--
-- TOC entry 2927 (class 0 OID 16460)
-- Dependencies: 201
-- Data for Name: CAR_OWNER; Type: TABLE DATA; Schema: GIBDD; Owner: postgres
--

COPY "GIBDD"."CAR_OWNER" (id_citizen_owner, license_number) FROM stdin;
2	5008185092
3	6219270314
4	9875634029
6	7771326912
\.


--
-- TOC entry 2937 (class 0 OID 16607)
-- Dependencies: 211
-- Data for Name: CITIZEN; Type: TABLE DATA; Schema: GIBDD; Owner: postgres
--

COPY "GIBDD"."CITIZEN" (id_citizen, full_name, phone, adress, passport) FROM stdin;
2	Маратов Марат Маратович	+79962369879	ул. Ломоносова 9б, кв.1	9214948532
3	Иванов Иван Иванович	+79091325679	Кронверский пр. 14, кв.1	7688337632
4	Алексеев Алексей Алексеевич	+79968286424	ул. Кузнецовская 10, кв.27	4515744201
6	Хосе Рауль Капабланка	+79092346523	ул. Гаванская 4, кв.8	9432455527
7	Джон Гаджет	+79999364491	ул. Якорная 6, кв.13	8717287992
8	Степанов Степан Степанович	+79031698156	ул. Бассейная 37, кв.7	9810466213
\.


--
-- TOC entry 2929 (class 0 OID 16467)
-- Dependencies: 203
-- Data for Name: DEPARTMENT; Type: TABLE DATA; Schema: GIBDD; Owner: postgres
--

COPY "GIBDD"."DEPARTMENT" (id_dep, dep_name, dep_adress) FROM stdin;
4	Центральный	ул. Маяковского 37
5	Московский	ул. Рыбинская 7
\.


--
-- TOC entry 2933 (class 0 OID 16481)
-- Dependencies: 207
-- Data for Name: DTP; Type: TABLE DATA; Schema: GIBDD; Owner: postgres
--

COPY "GIBDD"."DTP" (id_dtp, id_officer_dtp, dtp_description) FROM stdin;
2	1	Водитель нарушил скоростной режим
3	1	Водитель нарушил скоростной режим
4	1	Водитель нарушил скоростной режим
5	2	Водитель в состоянии алкогольного опьянения сбил человека на пешеходном переходе, пострадавший получил ущерб здоровью средней тяжести
6	2	Водитель припарковал автомобиль в неположенном месте
7	1	Водитель проехал перекресток на красный свет
\.


--
-- TOC entry 2939 (class 0 OID 16614)
-- Dependencies: 213
-- Data for Name: DTP_PARTICIPANT; Type: TABLE DATA; Schema: GIBDD; Owner: postgres
--

COPY "GIBDD"."DTP_PARTICIPANT" (participant_id, status, id_reg_participant, id_dtp_participant) FROM stdin;
1	Виновник	5	4
2	Виновник	5	3
3	Виновник	5	2
4	Виновник	1	5
5	Потерпевший	5	5
6	Виновник	11	6
7	Виновник	7	7
\.


--
-- TOC entry 2924 (class 0 OID 16432)
-- Dependencies: 198
-- Data for Name: MODEL; Type: TABLE DATA; Schema: GIBDD; Owner: postgres
--

COPY "GIBDD"."MODEL" (id_model, model_name, brand, country, specifications) FROM stdin;
1	Solaris	Hyundai	Южная Корея	Объем бака 50 л. Мощность двигателя 123 л.с. Клиренс 160 мм. 5 мест.\n
2	Vesta	Lada	Россия	Объем бака 55 л. Мощность двигателя 145 л.с. Клиренс 130 мм. 5 мест. 
3	Logan	Renault	Франция	Объем бака 50 л. Мощность двигателя 113 л.с. Клиренс 172 мм. 5 мест. 
4	Polo	Volkswagen	Германия	Объем бака 55 л. Мощность двигателя 125 л.с. Клиренс 163 мм. 5 мест. 
5	X6	BMW	Германия	Объем бака 85 л. Мощность двигателя 400 л.с. Клиренс 221 мм. 5 мест. 
6	Mustang	Ford	США	Объем бака 59 л. Мощность двигателя 314 л.с. Клиренс 145 мм. 4 мест. 
7	Huracan	Lamborghini	Италия	Объем бака 80 л. Мощность двигателя 610 л.с. Клиренс 135 мм. 2 мест. 
\.


--
-- TOC entry 2931 (class 0 OID 16474)
-- Dependencies: 205
-- Data for Name: OFFICER; Type: TABLE DATA; Schema: GIBDD; Owner: postgres
--

COPY "GIBDD"."OFFICER" (id_officer, id_dep_officer, role, id_citizen_officer) FROM stdin;
1	4	Старший инспектор	7
2	5	Старший инспектор	8
\.


--
-- TOC entry 2926 (class 0 OID 16455)
-- Dependencies: 200
-- Data for Name: REG_CAR; Type: TABLE DATA; Schema: GIBDD; Owner: postgres
--

COPY "GIBDD"."REG_CAR" (id_reg, id_department_reg, reg_start_date, license_plate_reg, license_number_reg, id_car_reg, reg_end_date) FROM stdin;
1	4	2021-09-22	Е592ТС78	5008185092	4	\N
4	4	2016-02-14	Е324ТР78	6219270314	2	\N
5	4	2011-07-03	В814СЕ78	7771326912	1	\N
7	5	2022-11-18	У498МН78	9875634029	3	\N
11	5	2023-08-12	О777ОО77	6219270314	5	\N
\.


--
-- TOC entry 2934 (class 0 OID 16490)
-- Dependencies: 208
-- Data for Name: VIOLATION; Type: TABLE DATA; Schema: GIBDD; Owner: postgres
--

COPY "GIBDD"."VIOLATION" (id_violation, payment_status, violation_code, type, vio_date, vio_district, vio_street, id_dtp_vio, vio_time) FROM stdin;
2	t	1	Первое	2023-01-10	Центральный	ул. Чайковского	2	10:54:02
3	t	1	Повторное	2023-01-15	Центральный	ул. Шпалерная	3	13:27:54
4	t	1	Повторное	2023-01-25	Центральный	ул. Пестеля	4	18:39:22
5	f	5	Первое	2023-08-09	Московский	ул. Алтайская	5	19:32:10
6	f	3	Первое	2023-08-09	Московский	ул. Алтайская	5	19:32:10
8	t	4	Первое	2023-08-08	Приморский	ул. Оптиков	6	23:55:14
9	t	2	Первое	2023-08-04	Центральный	ул. Восстания	7	03:47:48
\.


--
-- TOC entry 2936 (class 0 OID 16497)
-- Dependencies: 210
-- Data for Name: VIOLATIONS_CATALOG; Type: TABLE DATA; Schema: GIBDD; Owner: postgres
--

COPY "GIBDD"."VIOLATIONS_CATALOG" (violation_id_code, violation_description, basic_fine, second_time_fine, license_suspension_time) FROM stdin;
1	Превышение скорости	500.00	1000.00	\N
2	Проезд на запрещающий сигнал светофора	1000.00	5000.00	\N
3	Управление транспортным средством водителем, находящимся в состоянии опьянения	30000.00	30000.00	2 years
4	Нарушение правил стоянки	500.00	1500.00	\N
5	Нарушение пдд, повлекшее причинение легкого или средней тяжести вреда здоровью потерпевшего	5000.00	10000.00	2 years
\.


--
-- TOC entry 2949 (class 0 OID 0)
-- Dependencies: 217
-- Name: CAR_id_car_seq; Type: SEQUENCE SET; Schema: GIBDD; Owner: postgres
--

SELECT pg_catalog.setval('"GIBDD"."CAR_id_car_seq"', 5, true);


--
-- TOC entry 2950 (class 0 OID 0)
-- Dependencies: 215
-- Name: CITIZEN_id_citizen_seq; Type: SEQUENCE SET; Schema: GIBDD; Owner: postgres
--

SELECT pg_catalog.setval('"GIBDD"."CITIZEN_id_citizen_seq"', 11, true);


--
-- TOC entry 2951 (class 0 OID 0)
-- Dependencies: 202
-- Name: DEPARTMENTS_id_dep_seq; Type: SEQUENCE SET; Schema: GIBDD; Owner: postgres
--

SELECT pg_catalog.setval('"GIBDD"."DEPARTMENTS_id_dep_seq"', 5, true);


--
-- TOC entry 2952 (class 0 OID 0)
-- Dependencies: 212
-- Name: DTP_PARTICIPANT_participant_id_seq; Type: SEQUENCE SET; Schema: GIBDD; Owner: postgres
--

SELECT pg_catalog.setval('"GIBDD"."DTP_PARTICIPANT_participant_id_seq"', 7, true);


--
-- TOC entry 2953 (class 0 OID 0)
-- Dependencies: 206
-- Name: DTP_id_dtp_seq; Type: SEQUENCE SET; Schema: GIBDD; Owner: postgres
--

SELECT pg_catalog.setval('"GIBDD"."DTP_id_dtp_seq"', 7, true);


--
-- TOC entry 2954 (class 0 OID 0)
-- Dependencies: 204
-- Name: OFFICERS_id_officer_seq; Type: SEQUENCE SET; Schema: GIBDD; Owner: postgres
--

SELECT pg_catalog.setval('"GIBDD"."OFFICERS_id_officer_seq"', 4, true);


--
-- TOC entry 2955 (class 0 OID 0)
-- Dependencies: 214
-- Name: REG_CAR_id_reg_seq; Type: SEQUENCE SET; Schema: GIBDD; Owner: postgres
--

SELECT pg_catalog.setval('"GIBDD"."REG_CAR_id_reg_seq"', 11, true);


--
-- TOC entry 2956 (class 0 OID 0)
-- Dependencies: 216
-- Name: VIOLATION_id_violation_seq; Type: SEQUENCE SET; Schema: GIBDD; Owner: postgres
--

SELECT pg_catalog.setval('"GIBDD"."VIOLATION_id_violation_seq"', 9, true);


--
-- TOC entry 2957 (class 0 OID 0)
-- Dependencies: 209
-- Name: violations_catalog_violation_id_code_seq; Type: SEQUENCE SET; Schema: GIBDD; Owner: postgres
--

SELECT pg_catalog.setval('"GIBDD".violations_catalog_violation_id_code_seq', 5, true);


--
-- TOC entry 2958 (class 0 OID 0)
-- Dependencies: 197
-- Name: Модель_ID модели_seq; Type: SEQUENCE SET; Schema: GIBDD; Owner: postgres
--

SELECT pg_catalog.setval('"GIBDD"."Модель_ID модели_seq"', 7, true);


--
-- TOC entry 2770 (class 2606 OID 16804)
-- Name: CAR_OWNER CAR_OWNER_pkey; Type: CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE ONLY "GIBDD"."CAR_OWNER"
    ADD CONSTRAINT "CAR_OWNER_pkey" PRIMARY KEY (license_number);


--
-- TOC entry 2772 (class 2606 OID 16471)
-- Name: DEPARTMENT DEPARTMENTS_pkey; Type: CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE ONLY "GIBDD"."DEPARTMENT"
    ADD CONSTRAINT "DEPARTMENTS_pkey" PRIMARY KEY (id_dep);


--
-- TOC entry 2789 (class 2606 OID 16618)
-- Name: DTP_PARTICIPANT DTP_PARTICIPANT_pkey; Type: CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE ONLY "GIBDD"."DTP_PARTICIPANT"
    ADD CONSTRAINT "DTP_PARTICIPANT_pkey" PRIMARY KEY (participant_id);


--
-- TOC entry 2776 (class 2606 OID 16485)
-- Name: DTP DTP_pkey; Type: CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE ONLY "GIBDD"."DTP"
    ADD CONSTRAINT "DTP_pkey" PRIMARY KEY (id_dtp);


--
-- TOC entry 2774 (class 2606 OID 16478)
-- Name: OFFICER OFFICERS_pkey; Type: CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE ONLY "GIBDD"."OFFICER"
    ADD CONSTRAINT "OFFICERS_pkey" PRIMARY KEY (id_officer);


--
-- TOC entry 2768 (class 2606 OID 16459)
-- Name: REG_CAR REG_AUTO_pkey; Type: CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE ONLY "GIBDD"."REG_CAR"
    ADD CONSTRAINT "REG_AUTO_pkey" PRIMARY KEY (id_reg);


--
-- TOC entry 2778 (class 2606 OID 16494)
-- Name: VIOLATION VIOLATIONS_pkey; Type: CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE ONLY "GIBDD"."VIOLATION"
    ADD CONSTRAINT "VIOLATIONS_pkey" PRIMARY KEY (id_violation);


--
-- TOC entry 2756 (class 2606 OID 16564)
-- Name: VIOLATIONS_CATALOG basic_fine_not_negative; Type: CHECK CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE "GIBDD"."VIOLATIONS_CATALOG"
    ADD CONSTRAINT basic_fine_not_negative CHECK ((basic_fine > (0)::numeric)) NOT VALID;


--
-- TOC entry 2766 (class 2606 OID 24795)
-- Name: CAR car_pc; Type: CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE ONLY "GIBDD"."CAR"
    ADD CONSTRAINT car_pc PRIMARY KEY (id_car);


--
-- TOC entry 2747 (class 2606 OID 16747)
-- Name: MODEL country_chk; Type: CHECK CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE "GIBDD"."MODEL"
    ADD CONSTRAINT country_chk CHECK (((country)::text ~ '[А-Я][А-Я а-я]+'::text)) NOT VALID;


--
-- TOC entry 2782 (class 2606 OID 16625)
-- Name: CITIZEN id_citizen; Type: CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE ONLY "GIBDD"."CITIZEN"
    ADD CONSTRAINT id_citizen PRIMARY KEY (id_citizen);


--
-- TOC entry 2753 (class 2606 OID 16569)
-- Name: OFFICER id_dep; Type: CHECK CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE "GIBDD"."OFFICER"
    ADD CONSTRAINT id_dep CHECK ((id_dep_officer > 0)) NOT VALID;


--
-- TOC entry 2752 (class 2606 OID 16805)
-- Name: CAR_OWNER license_chk; Type: CHECK CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE "GIBDD"."CAR_OWNER"
    ADD CONSTRAINT license_chk CHECK ((license_number ~ similar_escape('[0-9]{10}'::text, NULL::text))) NOT VALID;


--
-- TOC entry 2758 (class 2606 OID 16754)
-- Name: CITIZEN name_chk; Type: CHECK CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE "GIBDD"."CITIZEN"
    ADD CONSTRAINT name_chk CHECK (((full_name)::text !~ similar_escape('%[0-9]%'::text, NULL::text))) NOT VALID;


--
-- TOC entry 2785 (class 2606 OID 16659)
-- Name: CITIZEN passport; Type: CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE ONLY "GIBDD"."CITIZEN"
    ADD CONSTRAINT passport UNIQUE (passport);


--
-- TOC entry 2759 (class 2606 OID 16756)
-- Name: CITIZEN passport_chk; Type: CHECK CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE "GIBDD"."CITIZEN"
    ADD CONSTRAINT passport_chk CHECK ((passport ~ similar_escape('[0-9]{10}'::text, NULL::text))) NOT VALID;


--
-- TOC entry 2787 (class 2606 OID 16657)
-- Name: CITIZEN phone; Type: CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE ONLY "GIBDD"."CITIZEN"
    ADD CONSTRAINT phone UNIQUE (phone);


--
-- TOC entry 2760 (class 2606 OID 16753)
-- Name: CITIZEN phone_chk; Type: CHECK CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE "GIBDD"."CITIZEN"
    ADD CONSTRAINT phone_chk CHECK (((phone)::text ~ similar_escape('\+[0-9]{11}'::text, NULL::text))) NOT VALID;


--
-- TOC entry 2750 (class 2606 OID 16744)
-- Name: REG_CAR plate_chk; Type: CHECK CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE "GIBDD"."REG_CAR"
    ADD CONSTRAINT plate_chk CHECK (((license_plate_reg)::text ~ '[АВЕКМНОРСТУХ][0-9]{3}[АВЕКМНОРСТУХ]{2}[0-9]{2,3}'::text)) NOT VALID;


--
-- TOC entry 2751 (class 2606 OID 16663)
-- Name: REG_CAR reg_time; Type: CHECK CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE "GIBDD"."REG_CAR"
    ADD CONSTRAINT reg_time CHECK ((reg_start_date < now())) NOT VALID;


--
-- TOC entry 2754 (class 2606 OID 16825)
-- Name: OFFICER role_chk; Type: CHECK CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE "GIBDD"."OFFICER"
    ADD CONSTRAINT role_chk CHECK (((role)::text = ANY (ARRAY['Инспектор'::text, 'Старший инспектор'::text]))) NOT VALID;


--
-- TOC entry 2757 (class 2606 OID 16567)
-- Name: VIOLATIONS_CATALOG second_time_not_negative; Type: CHECK CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE "GIBDD"."VIOLATIONS_CATALOG"
    ADD CONSTRAINT second_time_not_negative CHECK ((second_time_fine >= (0)::numeric)) NOT VALID;


--
-- TOC entry 2761 (class 2606 OID 16660)
-- Name: DTP_PARTICIPANT status; Type: CHECK CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE "GIBDD"."DTP_PARTICIPANT"
    ADD CONSTRAINT status CHECK (((status)::text = ANY (ARRAY['Виновник'::text, 'Потерпевший'::text, 'Не установлен'::text]))) NOT VALID;


--
-- TOC entry 2748 (class 2606 OID 16824)
-- Name: CAR vin_chk; Type: CHECK CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE "GIBDD"."CAR"
    ADD CONSTRAINT vin_chk CHECK ((("VIN")::text ~ similar_escape('[A-HJ-NPR-Z0-9]{17}'::text, NULL::text))) NOT VALID;


--
-- TOC entry 2755 (class 2606 OID 16828)
-- Name: VIOLATION vio_date_chk; Type: CHECK CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE "GIBDD"."VIOLATION"
    ADD CONSTRAINT vio_date_chk CHECK ((vio_date < now())) NOT VALID;


--
-- TOC entry 2780 (class 2606 OID 16501)
-- Name: VIOLATIONS_CATALOG violations_catalog_pkey; Type: CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE ONLY "GIBDD"."VIOLATIONS_CATALOG"
    ADD CONSTRAINT violations_catalog_pkey PRIMARY KEY (violation_id_code);


--
-- TOC entry 2749 (class 2606 OID 24787)
-- Name: CAR year_chk; Type: CHECK CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE "GIBDD"."CAR"
    ADD CONSTRAINT year_chk CHECK ((year_made <= 2023)) NOT VALID;


--
-- TOC entry 2764 (class 2606 OID 16439)
-- Name: MODEL Модель_pkey; Type: CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE ONLY "GIBDD"."MODEL"
    ADD CONSTRAINT "Модель_pkey" PRIMARY KEY (id_model);


--
-- TOC entry 2762 (class 1259 OID 24754)
-- Name: index_модель_марка; Type: INDEX; Schema: GIBDD; Owner: postgres
--

CREATE INDEX "index_модель_марка" ON "GIBDD"."MODEL" USING btree (brand);


--
-- TOC entry 2783 (class 1259 OID 24755)
-- Name: index_телефон_адрес_пасспорт; Type: INDEX; Schema: GIBDD; Owner: postgres
--

CREATE INDEX "index_телефон_адрес_пасспорт" ON "GIBDD"."CITIZEN" USING btree (phone, adress, passport);


--
-- TOC entry 2790 (class 2606 OID 16450)
-- Name: CAR ID модели; Type: FK CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE ONLY "GIBDD"."CAR"
    ADD CONSTRAINT "ID модели" FOREIGN KEY (id_model_car) REFERENCES "GIBDD"."MODEL"(id_model) NOT VALID;


--
-- TOC entry 2796 (class 2606 OID 16636)
-- Name: OFFICER citizen_officer; Type: FK CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE ONLY "GIBDD"."OFFICER"
    ADD CONSTRAINT citizen_officer FOREIGN KEY (id_citizen_officer) REFERENCES "GIBDD"."CITIZEN"(id_citizen) NOT VALID;


--
-- TOC entry 2798 (class 2606 OID 16527)
-- Name: VIOLATION code; Type: FK CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE ONLY "GIBDD"."VIOLATION"
    ADD CONSTRAINT code FOREIGN KEY (violation_code) REFERENCES "GIBDD"."VIOLATIONS_CATALOG"(violation_id_code) NOT VALID;


--
-- TOC entry 2791 (class 2606 OID 16512)
-- Name: REG_CAR dep; Type: FK CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE ONLY "GIBDD"."REG_CAR"
    ADD CONSTRAINT dep FOREIGN KEY (id_department_reg) REFERENCES "GIBDD"."DEPARTMENT"(id_dep) NOT VALID;


--
-- TOC entry 2795 (class 2606 OID 16517)
-- Name: OFFICER dep; Type: FK CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE ONLY "GIBDD"."OFFICER"
    ADD CONSTRAINT dep FOREIGN KEY (id_dep_officer) REFERENCES "GIBDD"."DEPARTMENT"(id_dep) NOT VALID;


--
-- TOC entry 2800 (class 2606 OID 16650)
-- Name: DTP_PARTICIPANT dtp_participant; Type: FK CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE ONLY "GIBDD"."DTP_PARTICIPANT"
    ADD CONSTRAINT dtp_participant FOREIGN KEY (id_dtp_participant) REFERENCES "GIBDD"."DTP"(id_dtp) NOT VALID;


--
-- TOC entry 2792 (class 2606 OID 24796)
-- Name: REG_CAR id_car; Type: FK CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE ONLY "GIBDD"."REG_CAR"
    ADD CONSTRAINT id_car FOREIGN KEY (id_car_reg) REFERENCES "GIBDD"."CAR"(id_car) NOT VALID;


--
-- TOC entry 2799 (class 2606 OID 16829)
-- Name: VIOLATION id_dtp_vio; Type: FK CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE ONLY "GIBDD"."VIOLATION"
    ADD CONSTRAINT id_dtp_vio FOREIGN KEY (id_dtp_vio) REFERENCES "GIBDD"."DTP"(id_dtp) NOT VALID;


--
-- TOC entry 2793 (class 2606 OID 16806)
-- Name: REG_CAR license; Type: FK CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE ONLY "GIBDD"."REG_CAR"
    ADD CONSTRAINT license FOREIGN KEY (license_number_reg) REFERENCES "GIBDD"."CAR_OWNER"(license_number) NOT VALID;


--
-- TOC entry 2797 (class 2606 OID 16522)
-- Name: DTP officer; Type: FK CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE ONLY "GIBDD"."DTP"
    ADD CONSTRAINT officer FOREIGN KEY (id_officer_dtp) REFERENCES "GIBDD"."OFFICER"(id_officer) NOT VALID;


--
-- TOC entry 2794 (class 2606 OID 16626)
-- Name: CAR_OWNER owner_citizen; Type: FK CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE ONLY "GIBDD"."CAR_OWNER"
    ADD CONSTRAINT owner_citizen FOREIGN KEY (id_citizen_owner) REFERENCES "GIBDD"."CITIZEN"(id_citizen) NOT VALID;


--
-- TOC entry 2801 (class 2606 OID 24801)
-- Name: DTP_PARTICIPANT reg_car; Type: FK CONSTRAINT; Schema: GIBDD; Owner: postgres
--

ALTER TABLE ONLY "GIBDD"."DTP_PARTICIPANT"
    ADD CONSTRAINT reg_car FOREIGN KEY (id_reg_participant) REFERENCES "GIBDD"."REG_CAR"(id_reg) NOT VALID;


-- Completed on 2023-10-02 16:47:23

--
-- PostgreSQL database dump complete
--

