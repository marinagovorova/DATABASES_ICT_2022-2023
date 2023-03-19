--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7
-- Dumped by pg_dump version 14.7

-- Started on 2023-03-19 17:01:45

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
-- TOC entry 6 (class 2615 OID 16396)
-- Name: timetable_courses; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA timetable_courses;


ALTER SCHEMA timetable_courses OWNER TO postgres;

--
-- TOC entry 874 (class 1247 OID 16659)
-- Name: Attestation_type; Type: TYPE; Schema: timetable_courses; Owner: postgres
--

CREATE TYPE timetable_courses."Attestation_type" AS ENUM (
    'экзамен',
    'зачет',
    'диф. зачет'
);


ALTER TYPE timetable_courses."Attestation_type" OWNER TO postgres;

--
-- TOC entry 862 (class 1247 OID 16620)
-- Name: Capacity; Type: TYPE; Schema: timetable_courses; Owner: postgres
--

CREATE TYPE timetable_courses."Capacity" AS ENUM (
    'до  20 человек',
    'до 50  человек',
    'до 100 человек',
    'до 150 человек'
);


ALTER TYPE timetable_courses."Capacity" OWNER TO postgres;

--
-- TOC entry 892 (class 1247 OID 16706)
-- Name: Cause_of_absence; Type: TYPE; Schema: timetable_courses; Owner: postgres
--

CREATE TYPE timetable_courses."Cause_of_absence" AS ENUM (
    'больничный',
    'отпуск'
);


ALTER TYPE timetable_courses."Cause_of_absence" OWNER TO postgres;

--
-- TOC entry 859 (class 1247 OID 16611)
-- Name: Class_type; Type: TYPE; Schema: timetable_courses; Owner: postgres
--

CREATE TYPE timetable_courses."Class_type" AS ENUM (
    'лаборатория',
    'лекционная',
    'учебная',
    'компьютерный класс'
);


ALTER TYPE timetable_courses."Class_type" OWNER TO postgres;

--
-- TOC entry 880 (class 1247 OID 16690)
-- Name: Document_type; Type: TYPE; Schema: timetable_courses; Owner: postgres
--

CREATE TYPE timetable_courses."Document_type" AS ENUM (
    'диплом',
    'сертификат',
    'справка об обучении'
);


ALTER TYPE timetable_courses."Document_type" OWNER TO postgres;

--
-- TOC entry 883 (class 1247 OID 16698)
-- Name: Group_status; Type: TYPE; Schema: timetable_courses; Owner: postgres
--

CREATE TYPE timetable_courses."Group_status" AS ENUM (
    'обучается',
    'окончила обучение',
    'расформирована'
);


ALTER TYPE timetable_courses."Group_status" OWNER TO postgres;

--
-- TOC entry 919 (class 1247 OID 16802)
-- Name: Lesson_type; Type: TYPE; Schema: timetable_courses; Owner: postgres
--

CREATE TYPE timetable_courses."Lesson_type" AS ENUM (
    'практика',
    'лекция',
    'лабораторная'
);


ALTER TYPE timetable_courses."Lesson_type" OWNER TO postgres;

--
-- TOC entry 865 (class 1247 OID 16639)
-- Name: Position; Type: TYPE; Schema: timetable_courses; Owner: postgres
--

CREATE TYPE timetable_courses."Position" AS ENUM (
    'преподаватель',
    'старший преподаватель',
    'ассистент',
    'лаборант'
);


ALTER TYPE timetable_courses."Position" OWNER TO postgres;

--
-- TOC entry 877 (class 1247 OID 16666)
-- Name: Programme_type; Type: TYPE; Schema: timetable_courses; Owner: postgres
--

CREATE TYPE timetable_courses."Programme_type" AS ENUM (
    'бакалавриат',
    'магистратура',
    'аспирантура',
    'специалитет',
    'профессия',
    'специальность',
    'ДПО'
);


ALTER TYPE timetable_courses."Programme_type" OWNER TO postgres;

--
-- TOC entry 910 (class 1247 OID 16775)
-- Name: St_status; Type: TYPE; Schema: timetable_courses; Owner: postgres
--

CREATE TYPE timetable_courses."St_status" AS ENUM (
    'учитcя',
    'отчислен',
    'выпускник'
);


ALTER TYPE timetable_courses."St_status" OWNER TO postgres;

--
-- TOC entry 887 (class 1247 OID 16682)
-- Name: Students_status; Type: TYPE; Schema: timetable_courses; Owner: postgres
--

CREATE TYPE timetable_courses."Students_status" AS ENUM (
    'обучается',
    'окончил  обучение',
    'расформирован'
);


ALTER TYPE timetable_courses."Students_status" OWNER TO postgres;

--
-- TOC entry 901 (class 1247 OID 16737)
-- Name: Teacher_status; Type: TYPE; Schema: timetable_courses; Owner: postgres
--

CREATE TYPE timetable_courses."Teacher_status" AS ENUM (
    'в  отпуске',
    'работает',
    'уволен'
);


ALTER TYPE timetable_courses."Teacher_status" OWNER TO postgres;

--
-- TOC entry 904 (class 1247 OID 16744)
-- Name: Work_status; Type: TYPE; Schema: timetable_courses; Owner: postgres
--

CREATE TYPE timetable_courses."Work_status" AS ENUM (
    'основное место работы',
    'внешнее совмещение'
);


ALTER TYPE timetable_courses."Work_status" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 214 (class 1259 OID 16445)
-- Name: Admission_year; Type: TABLE; Schema: timetable_courses; Owner: postgres
--

CREATE TABLE timetable_courses."Admission_year" (
    "ID_year_admission" integer NOT NULL,
    "From" date NOT NULL,
    "To" date NOT NULL,
    "Number_of_admission_year" integer NOT NULL,
    "a_ID_programme" integer NOT NULL,
    "Students_status" timetable_courses."Students_status" NOT NULL,
    "Document_type" timetable_courses."Document_type" NOT NULL
);


ALTER TABLE timetable_courses."Admission_year" OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16853)
-- Name: Admission_year_ID_year_admission_seq; Type: SEQUENCE; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE timetable_courses."Admission_year" ALTER COLUMN "ID_year_admission" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME timetable_courses."Admission_year_ID_year_admission_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 16759)
-- Name: Can_teach; Type: TABLE; Schema: timetable_courses; Owner: postgres
--

CREATE TABLE timetable_courses."Can_teach" (
    "ID_can_teach" integer NOT NULL,
    "c_ID_passport" character varying(10) NOT NULL,
    "c_ID_discipline" integer NOT NULL
);


ALTER TABLE timetable_courses."Can_teach" OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16407)
-- Name: Class; Type: TABLE; Schema: timetable_courses; Owner: postgres
--

CREATE TABLE timetable_courses."Class" (
    "ID_class" integer NOT NULL,
    "Number_class" integer NOT NULL,
    "c_ID_division" integer NOT NULL,
    "Class_type" timetable_courses."Class_type" NOT NULL,
    "Capacity" timetable_courses."Capacity" NOT NULL
);


ALTER TABLE timetable_courses."Class" OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16433)
-- Name: Discipline; Type: TABLE; Schema: timetable_courses; Owner: postgres
--

CREATE TABLE timetable_courses."Discipline" (
    "ID_discipline" integer NOT NULL,
    "Hours_of_lectures" integer NOT NULL,
    "Hours_of_practice" integer NOT NULL,
    "Hours_of_laboratory" integer NOT NULL,
    "Sum_hours" integer NOT NULL,
    "Name_of_discipline" character varying(50) NOT NULL,
    "Attestation_type" timetable_courses."Attestation_type" NOT NULL
);


ALTER TABLE timetable_courses."Discipline" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16844)
-- Name: Discipline_ID_discipline_seq; Type: SEQUENCE; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE timetable_courses."Discipline" ALTER COLUMN "ID_discipline" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME timetable_courses."Discipline_ID_discipline_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 16716)
-- Name: Discipline_of_programme; Type: TABLE; Schema: timetable_courses; Owner: postgres
--

CREATE TABLE timetable_courses."Discipline_of_programme" (
    "ID_discipline_of_pr" integer NOT NULL,
    "d_ID_programme" integer NOT NULL,
    "d_ID_discipline" integer NOT NULL
);


ALTER TABLE timetable_courses."Discipline_of_programme" OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16400)
-- Name: Division; Type: TABLE; Schema: timetable_courses; Owner: postgres
--

CREATE TABLE timetable_courses."Division" (
    "ID_division" integer NOT NULL,
    "Name_of_division" character varying(40),
    "Address" character varying(100) NOT NULL
);


ALTER TABLE timetable_courses."Division" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16598)
-- Name: Division_ID_division_seq; Type: SEQUENCE; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE timetable_courses."Division" ALTER COLUMN "ID_division" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME timetable_courses."Division_ID_division_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 215 (class 1259 OID 16459)
-- Name: Group; Type: TABLE; Schema: timetable_courses; Owner: postgres
--

CREATE TABLE timetable_courses."Group" (
    "Group_number" integer NOT NULL,
    "g_ID_year_admission" integer NOT NULL,
    "Group_status" timetable_courses."Group_status" NOT NULL
);


ALTER TABLE timetable_courses."Group" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16731)
-- Name: Is_in_division; Type: TABLE; Schema: timetable_courses; Owner: postgres
--

CREATE TABLE timetable_courses."Is_in_division" (
    "ID_in_division" integer NOT NULL,
    "Teacher_status" timetable_courses."Teacher_status" NOT NULL,
    "Work_status" timetable_courses."Work_status" NOT NULL,
    "IS_ID_division" integer NOT NULL,
    "IS_ID_passport" character varying(10) NOT NULL
);


ALTER TABLE timetable_courses."Is_in_division" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16781)
-- Name: Is_in_group; Type: TABLE; Schema: timetable_courses; Owner: postgres
--

CREATE TABLE timetable_courses."Is_in_group" (
    "ID_in_group" integer NOT NULL,
    "Document_number" integer,
    "Student_status" timetable_courses."St_status" NOT NULL,
    "I_group_number" integer NOT NULL,
    "I_ID_passport" character varying(10) NOT NULL
);


ALTER TABLE timetable_courses."Is_in_group" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16796)
-- Name: Lesson; Type: TABLE; Schema: timetable_courses; Owner: postgres
--

CREATE TABLE timetable_courses."Lesson" (
    "ID_lesson" integer NOT NULL,
    "L_group_number" integer NOT NULL,
    "L_ID_class" integer NOT NULL,
    "L_ID_passport" character varying(10) NOT NULL,
    "L_ID_discipline_of_pr" integer NOT NULL,
    "Lesson_type" timetable_courses."Lesson_type" NOT NULL,
    "Lesson_number" integer NOT NULL,
    "Date_of_lessons" date NOT NULL
);


ALTER TABLE timetable_courses."Lesson" OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16440)
-- Name: Programme; Type: TABLE; Schema: timetable_courses; Owner: postgres
--

CREATE TABLE timetable_courses."Programme" (
    "Cost" integer,
    "ID_programme" integer NOT NULL,
    "Programme_type" timetable_courses."Programme_type" NOT NULL,
    "Name_of_programme" character varying(50) NOT NULL
);


ALTER TABLE timetable_courses."Programme" OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16847)
-- Name: Programme_ID_programme_seq; Type: SEQUENCE; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE timetable_courses."Programme" ALTER COLUMN "ID_programme" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME timetable_courses."Programme_ID_programme_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 216 (class 1259 OID 16471)
-- Name: Sick_and_vacation_leaves; Type: TABLE; Schema: timetable_courses; Owner: postgres
--

CREATE TABLE timetable_courses."Sick_and_vacation_leaves" (
    "ID_absense" integer NOT NULL,
    "From" date NOT NULL,
    "To" date NOT NULL,
    "Cause_of_absence" timetable_courses."Cause_of_absence" NOT NULL,
    "s_ID_passport" character varying(10) NOT NULL
);


ALTER TABLE timetable_courses."Sick_and_vacation_leaves" OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16858)
-- Name: Sick_and_vacation_leaves_ID_absense_seq; Type: SEQUENCE; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE timetable_courses."Sick_and_vacation_leaves" ALTER COLUMN "ID_absense" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME timetable_courses."Sick_and_vacation_leaves_ID_absense_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 219 (class 1259 OID 16653)
-- Name: Student; Type: TABLE; Schema: timetable_courses; Owner: postgres
--

CREATE TABLE timetable_courses."Student" (
    "ID_passport" character varying(10) NOT NULL,
    "Full_name" character varying(50) NOT NULL,
    "Contacts" character varying(50) NOT NULL
);


ALTER TABLE timetable_courses."Student" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16647)
-- Name: Teacher; Type: TABLE; Schema: timetable_courses; Owner: postgres
--

CREATE TABLE timetable_courses."Teacher" (
    "ID_passport" character varying(10) NOT NULL,
    "Full_name" character varying(50) NOT NULL,
    "Position" timetable_courses."Position" NOT NULL
);


ALTER TABLE timetable_courses."Teacher" OWNER TO postgres;

--
-- TOC entry 3482 (class 0 OID 16445)
-- Dependencies: 214
-- Data for Name: Admission_year; Type: TABLE DATA; Schema: timetable_courses; Owner: postgres
--

COPY timetable_courses."Admission_year" ("ID_year_admission", "From", "To", "Number_of_admission_year", "a_ID_programme", "Students_status", "Document_type") FROM stdin;
102018	2018-09-01	2023-08-31	60	4003	обучается	диплом
102019	2019-09-01	2021-08-31	55	4002	окончил  обучение	диплом
102022	2022-01-01	2022-09-01	25	4004	окончил  обучение	сертификат
102021	2021-09-01	2025-01-01	30	4005	обучается	диплом
102020	2020-09-01	2024-01-08	35	4001	обучается	диплом
\.


--
-- TOC entry 3490 (class 0 OID 16759)
-- Dependencies: 222
-- Data for Name: Can_teach; Type: TABLE DATA; Schema: timetable_courses; Owner: postgres
--

COPY timetable_courses."Can_teach" ("ID_can_teach", "c_ID_passport", "c_ID_discipline") FROM stdin;
10027	4018775180	3005
10026	3018485570	3004
10025	4012783672	3003
10024	4017783319	3002
10023	4018785670	3001
\.


--
-- TOC entry 3479 (class 0 OID 16407)
-- Dependencies: 211
-- Data for Name: Class; Type: TABLE DATA; Schema: timetable_courses; Owner: postgres
--

COPY timetable_courses."Class" ("ID_class", "Number_class", "c_ID_division", "Class_type", "Capacity") FROM stdin;
1001	327	1	компьютерный класс	до  20 человек
1002	328	2	учебная	до 50  человек
1003	329	3	лекционная	до 100 человек
1004	330	4	лаборатория	до  20 человек
1005	331	5	учебная	до 50  человек
\.


--
-- TOC entry 3480 (class 0 OID 16433)
-- Dependencies: 212
-- Data for Name: Discipline; Type: TABLE DATA; Schema: timetable_courses; Owner: postgres
--

COPY timetable_courses."Discipline" ("ID_discipline", "Hours_of_lectures", "Hours_of_practice", "Hours_of_laboratory", "Sum_hours", "Name_of_discipline", "Attestation_type") FROM stdin;
3005	64	64	70	216	Математика	экзамен
3004	20	10	16	72	Основы права	зачет
3002	48	30	36	144	Теория организации и управления	экзамен
3003	32	32	42	180	Основы бизнеса	диф. зачет
3001	40	42	16	108	Управление ресурсами	экзамен
\.


--
-- TOC entry 3488 (class 0 OID 16716)
-- Dependencies: 220
-- Data for Name: Discipline_of_programme; Type: TABLE DATA; Schema: timetable_courses; Owner: postgres
--

COPY timetable_courses."Discipline_of_programme" ("ID_discipline_of_pr", "d_ID_programme", "d_ID_discipline") FROM stdin;
86004	4001	3002
86003	4001	3001
86002	4005	3005
86001	4001	3005
\.


--
-- TOC entry 3478 (class 0 OID 16400)
-- Dependencies: 210
-- Data for Name: Division; Type: TABLE DATA; Schema: timetable_courses; Owner: postgres
--

COPY timetable_courses."Division" ("ID_division", "Name_of_division", "Address") FROM stdin;
1	ГК	Кронверский пр. 1
2	Ломоносова	ул.Ломоносова д.8
3	Биржевая	Биржевая линия д.14
4	Чайковского	ул.Чайковского д.11
5	Гривцова	пер. Гривцова д.14
\.


--
-- TOC entry 3483 (class 0 OID 16459)
-- Dependencies: 215
-- Data for Name: Group; Type: TABLE DATA; Schema: timetable_courses; Owner: postgres
--

COPY timetable_courses."Group" ("Group_number", "g_ID_year_admission", "Group_status") FROM stdin;
1262018	102018	обучается
1212019	102019	окончила обучение
1522022	102022	окончила обучение
1312021	102021	обучается
1112020	102020	обучается
\.


--
-- TOC entry 3489 (class 0 OID 16731)
-- Dependencies: 221
-- Data for Name: Is_in_division; Type: TABLE DATA; Schema: timetable_courses; Owner: postgres
--

COPY timetable_courses."Is_in_division" ("ID_in_division", "Teacher_status", "Work_status", "IS_ID_division", "IS_ID_passport") FROM stdin;
10034	работает	основное место работы	1	4018775180
20021	работает	основное место работы	2	4018785670
30042	работает	основное место работы	3	3018485570
40067	работает	внешнее совмещение	4	4012783672
50012	работает	внешнее совмещение	5	4017783319
\.


--
-- TOC entry 3491 (class 0 OID 16781)
-- Dependencies: 223
-- Data for Name: Is_in_group; Type: TABLE DATA; Schema: timetable_courses; Owner: postgres
--

COPY timetable_courses."Is_in_group" ("ID_in_group", "Document_number", "Student_status", "I_group_number", "I_ID_passport") FROM stdin;
206640	11100238	учитcя	1112020	4016984518
206639	11100237	учитcя	1112020	4014984518
206638	11100236	учитcя	1312021	4012682518
206637	11100235	учитcя	1262018	4011984520
206636	11100234	учитcя	1112020	4016989999
\.


--
-- TOC entry 3492 (class 0 OID 16796)
-- Dependencies: 224
-- Data for Name: Lesson; Type: TABLE DATA; Schema: timetable_courses; Owner: postgres
--

COPY timetable_courses."Lesson" ("ID_lesson", "L_group_number", "L_ID_class", "L_ID_passport", "L_ID_discipline_of_pr", "Lesson_type", "Lesson_number", "Date_of_lessons") FROM stdin;
140031	1112020	1002	4018785670	86003	практика	1	2023-02-02
140032	1262018	1002	4018775180	86002	лекция	2	2023-03-02
140033	1312021	1005	4018775180	86001	лабораторная	3	2023-01-02
\.


--
-- TOC entry 3481 (class 0 OID 16440)
-- Dependencies: 213
-- Data for Name: Programme; Type: TABLE DATA; Schema: timetable_courses; Owner: postgres
--

COPY timetable_courses."Programme" ("Cost", "ID_programme", "Programme_type", "Name_of_programme") FROM stdin;
32000	4005	бакалавриат	Бизнес-информатика
56000	4004	ДПО	Аналитик данных
250000	4003	специалитет	Астрономия
140000	4002	магистратура	Инноватика
120000	4001	бакалавриат	Филология
\.


--
-- TOC entry 3484 (class 0 OID 16471)
-- Dependencies: 216
-- Data for Name: Sick_and_vacation_leaves; Type: TABLE DATA; Schema: timetable_courses; Owner: postgres
--

COPY timetable_courses."Sick_and_vacation_leaves" ("ID_absense", "From", "To", "Cause_of_absence", "s_ID_passport") FROM stdin;
68863	2023-02-20	2023-03-01	отпуск	4017783319
68862	2023-02-01	2023-02-15	больничный	4012783672
68861	2023-01-02	2023-01-16	больничный	3018485570
\.


--
-- TOC entry 3487 (class 0 OID 16653)
-- Dependencies: 219
-- Data for Name: Student; Type: TABLE DATA; Schema: timetable_courses; Owner: postgres
--

COPY timetable_courses."Student" ("ID_passport", "Full_name", "Contacts") FROM stdin;
4011984520	Сахаров Дмитрий Иванович	8-962-789-67-52
4012682518	Николаева Алла Викторовна	8-981-666-65-35
4016989999	Левина Ольга Александровна	8-955-997-45-90
4014984518	Антонов Николай Петрович	8-911-837-45-33
4016984518	Максимова Ирина Владимировна	8-921-837-45-68
\.


--
-- TOC entry 3486 (class 0 OID 16647)
-- Dependencies: 218
-- Data for Name: Teacher; Type: TABLE DATA; Schema: timetable_courses; Owner: postgres
--

COPY timetable_courses."Teacher" ("ID_passport", "Full_name", "Position") FROM stdin;
4012783672	Анисимов Денис Петрович	лаборант
4018775180	Петров Николай Владимирович	старший преподаватель
3018485570	Егорова Анастасия Антоновна	преподаватель
4018785670	Смирнова Елена Васильевна	ассистент
4017783319	Иванов Иван Петрович	преподаватель
\.


--
-- TOC entry 3502 (class 0 OID 0)
-- Dependencies: 227
-- Name: Admission_year_ID_year_admission_seq; Type: SEQUENCE SET; Schema: timetable_courses; Owner: postgres
--

SELECT pg_catalog.setval('timetable_courses."Admission_year_ID_year_admission_seq"', 1, false);


--
-- TOC entry 3503 (class 0 OID 0)
-- Dependencies: 225
-- Name: Discipline_ID_discipline_seq; Type: SEQUENCE SET; Schema: timetable_courses; Owner: postgres
--

SELECT pg_catalog.setval('timetable_courses."Discipline_ID_discipline_seq"', 1, false);


--
-- TOC entry 3504 (class 0 OID 0)
-- Dependencies: 217
-- Name: Division_ID_division_seq; Type: SEQUENCE SET; Schema: timetable_courses; Owner: postgres
--

SELECT pg_catalog.setval('timetable_courses."Division_ID_division_seq"', 1, true);


--
-- TOC entry 3505 (class 0 OID 0)
-- Dependencies: 226
-- Name: Programme_ID_programme_seq; Type: SEQUENCE SET; Schema: timetable_courses; Owner: postgres
--

SELECT pg_catalog.setval('timetable_courses."Programme_ID_programme_seq"', 1, false);


--
-- TOC entry 3506 (class 0 OID 0)
-- Dependencies: 228
-- Name: Sick_and_vacation_leaves_ID_absense_seq; Type: SEQUENCE SET; Schema: timetable_courses; Owner: postgres
--

SELECT pg_catalog.setval('timetable_courses."Sick_and_vacation_leaves_ID_absense_seq"', 1, false);


--
-- TOC entry 3269 (class 2606 OID 16637)
-- Name: Admission_year Admission_year_check; Type: CHECK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE timetable_courses."Admission_year"
    ADD CONSTRAINT "Admission_year_check" CHECK (("From" < "To")) NOT VALID;


--
-- TOC entry 3316 (class 2606 OID 16763)
-- Name: Can_teach Can_teach_pkey1; Type: CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Can_teach"
    ADD CONSTRAINT "Can_teach_pkey1" PRIMARY KEY ("ID_can_teach");


--
-- TOC entry 3282 (class 2606 OID 16413)
-- Name: Class Class_pkey; Type: CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Class"
    ADD CONSTRAINT "Class_pkey" PRIMARY KEY ("ID_class");


--
-- TOC entry 3267 (class 2606 OID 16850)
-- Name: Programme Cost; Type: CHECK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE timetable_courses."Programme"
    ADD CONSTRAINT "Cost" CHECK (("Cost" >= 0)) NOT VALID;


--
-- TOC entry 3261 (class 2606 OID 16631)
-- Name: Discipline Discipline_Name_of_discipline_check; Type: CHECK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE timetable_courses."Discipline"
    ADD CONSTRAINT "Discipline_Name_of_discipline_check" CHECK ((length(("Name_of_discipline")::text) > 5)) NOT VALID;


--
-- TOC entry 3312 (class 2606 OID 16720)
-- Name: Discipline_of_programme Discipline_of_programme_pkey1; Type: CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Discipline_of_programme"
    ADD CONSTRAINT "Discipline_of_programme_pkey1" PRIMARY KEY ("ID_discipline_of_pr");


--
-- TOC entry 3288 (class 2606 OID 16439)
-- Name: Discipline Discipline_pkey; Type: CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Discipline"
    ADD CONSTRAINT "Discipline_pkey" PRIMARY KEY ("ID_discipline");


--
-- TOC entry 3278 (class 2606 OID 16406)
-- Name: Division Division_pkey; Type: CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Division"
    ADD CONSTRAINT "Division_pkey" PRIMARY KEY ("ID_division");


--
-- TOC entry 3318 (class 2606 OID 16873)
-- Name: Is_in_group Document_number; Type: CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Is_in_group"
    ADD CONSTRAINT "Document_number" UNIQUE ("Document_number");


--
-- TOC entry 3298 (class 2606 OID 16857)
-- Name: Group Group_number; Type: CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Group"
    ADD CONSTRAINT "Group_number" UNIQUE ("Group_number");


--
-- TOC entry 3300 (class 2606 OID 16465)
-- Name: Group Group_pkey; Type: CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Group"
    ADD CONSTRAINT "Group_pkey" PRIMARY KEY ("Group_number");


--
-- TOC entry 3262 (class 2606 OID 16634)
-- Name: Discipline Hours_of_laboratory; Type: CHECK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE timetable_courses."Discipline"
    ADD CONSTRAINT "Hours_of_laboratory" CHECK (("Hours_of_laboratory" > 0)) NOT VALID;


--
-- TOC entry 3263 (class 2606 OID 16632)
-- Name: Discipline Hours_of_lectures; Type: CHECK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE timetable_courses."Discipline"
    ADD CONSTRAINT "Hours_of_lectures" CHECK (("Hours_of_lectures" > 0)) NOT VALID;


--
-- TOC entry 3264 (class 2606 OID 16633)
-- Name: Discipline Hours_of_practice; Type: CHECK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE timetable_courses."Discipline"
    ADD CONSTRAINT "Hours_of_practice" CHECK (("Hours_of_practice" > 0)) NOT VALID;


--
-- TOC entry 3302 (class 2606 OID 16860)
-- Name: Sick_and_vacation_leaves ID_absense; Type: CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Sick_and_vacation_leaves"
    ADD CONSTRAINT "ID_absense" UNIQUE ("ID_absense");


--
-- TOC entry 3284 (class 2606 OID 16609)
-- Name: Class ID_class; Type: CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Class"
    ADD CONSTRAINT "ID_class" UNIQUE ("ID_class");


--
-- TOC entry 3290 (class 2606 OID 16846)
-- Name: Discipline ID_discipline; Type: CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Discipline"
    ADD CONSTRAINT "ID_discipline" UNIQUE ("ID_discipline");


--
-- TOC entry 3280 (class 2606 OID 16600)
-- Name: Division ID_division; Type: CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Division"
    ADD CONSTRAINT "ID_division" UNIQUE ("ID_division");


--
-- TOC entry 3306 (class 2606 OID 16839)
-- Name: Teacher ID_passport; Type: CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Teacher"
    ADD CONSTRAINT "ID_passport" UNIQUE ("ID_passport");


--
-- TOC entry 3292 (class 2606 OID 16849)
-- Name: Programme ID_programme; Type: CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Programme"
    ADD CONSTRAINT "ID_programme" UNIQUE ("ID_programme");


--
-- TOC entry 3296 (class 2606 OID 16451)
-- Name: Admission_year ID_year_admission; Type: CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Admission_year"
    ADD CONSTRAINT "ID_year_admission" PRIMARY KEY ("ID_year_admission");


--
-- TOC entry 3314 (class 2606 OID 16735)
-- Name: Is_in_division Is_in_division_pkey1; Type: CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Is_in_division"
    ADD CONSTRAINT "Is_in_division_pkey1" PRIMARY KEY ("ID_in_division");


--
-- TOC entry 3320 (class 2606 OID 16785)
-- Name: Is_in_group Is_in_group_pkey1; Type: CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Is_in_group"
    ADD CONSTRAINT "Is_in_group_pkey1" PRIMARY KEY ("ID_in_group");


--
-- TOC entry 3268 (class 2606 OID 16851)
-- Name: Programme Len_Name_of_programme; Type: CHECK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE timetable_courses."Programme"
    ADD CONSTRAINT "Len_Name_of_programme" CHECK ((length(("Name_of_programme")::text) > 5)) NOT VALID;


--
-- TOC entry 3322 (class 2606 OID 16800)
-- Name: Lesson Lesson_pkey1; Type: CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Lesson"
    ADD CONSTRAINT "Lesson_pkey1" PRIMARY KEY ("ID_lesson");


--
-- TOC entry 3286 (class 2606 OID 16607)
-- Name: Class Number_class; Type: CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Class"
    ADD CONSTRAINT "Number_class" UNIQUE ("Number_class");


--
-- TOC entry 3270 (class 2606 OID 16854)
-- Name: Admission_year Number_of_admission_year_check; Type: CHECK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE timetable_courses."Admission_year"
    ADD CONSTRAINT "Number_of_admission_year_check" CHECK (("Number_of_admission_year" > 3)) NOT VALID;


--
-- TOC entry 3271 (class 2606 OID 16855)
-- Name: Admission_year Number_of_admission_year_check2; Type: CHECK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE timetable_courses."Admission_year"
    ADD CONSTRAINT "Number_of_admission_year_check2" CHECK (("Number_of_admission_year" < 100)) NOT VALID;


--
-- TOC entry 3294 (class 2606 OID 16453)
-- Name: Programme Programme_pkey; Type: CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Programme"
    ADD CONSTRAINT "Programme_pkey" PRIMARY KEY ("ID_programme");


--
-- TOC entry 3304 (class 2606 OID 16477)
-- Name: Sick_and_vacation_leaves Sick_and_vacation_leaves_pkey; Type: CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Sick_and_vacation_leaves"
    ADD CONSTRAINT "Sick_and_vacation_leaves_pkey" PRIMARY KEY ("ID_absense");


--
-- TOC entry 3310 (class 2606 OID 16657)
-- Name: Student Student_pkey1; Type: CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Student"
    ADD CONSTRAINT "Student_pkey1" PRIMARY KEY ("ID_passport");


--
-- TOC entry 3265 (class 2606 OID 16635)
-- Name: Discipline Sum_hours; Type: CHECK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE timetable_courses."Discipline"
    ADD CONSTRAINT "Sum_hours" CHECK (("Sum_hours" > 0)) NOT VALID;


--
-- TOC entry 3266 (class 2606 OID 16636)
-- Name: Discipline Sum_hours2; Type: CHECK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE timetable_courses."Discipline"
    ADD CONSTRAINT "Sum_hours2" CHECK (("Sum_hours" > (("Hours_of_lectures" + "Hours_of_practice") + "Hours_of_laboratory"))) NOT VALID;


--
-- TOC entry 3308 (class 2606 OID 16651)
-- Name: Teacher Teacher_pkey1; Type: CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Teacher"
    ADD CONSTRAINT "Teacher_pkey1" PRIMARY KEY ("ID_passport");


--
-- TOC entry 3272 (class 2606 OID 16861)
-- Name: Sick_and_vacation_leaves date_from_to; Type: CHECK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE timetable_courses."Sick_and_vacation_leaves"
    ADD CONSTRAINT date_from_to CHECK (("From" < "To")) NOT VALID;


--
-- TOC entry 3260 (class 2606 OID 16603)
-- Name: Division no_symb; Type: CHECK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE timetable_courses."Division"
    ADD CONSTRAINT no_symb CHECK ((("Name_of_division")::text ~ '[a-zA-ZА-Яа-я, -]'::text)) NOT VALID;


--
-- TOC entry 3273 (class 2606 OID 16841)
-- Name: Teacher no_symb; Type: CHECK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE timetable_courses."Teacher"
    ADD CONSTRAINT no_symb CHECK ((("Full_name")::text ~ '[a-zA-Z, -]'::text)) NOT VALID;


--
-- TOC entry 3275 (class 2606 OID 16842)
-- Name: Student no_symb; Type: CHECK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE timetable_courses."Student"
    ADD CONSTRAINT no_symb CHECK ((("Full_name")::text ~ '[a-zA-Z, -]'::text)) NOT VALID;


--
-- TOC entry 3274 (class 2606 OID 16840)
-- Name: Teacher only_num_10; Type: CHECK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE timetable_courses."Teacher"
    ADD CONSTRAINT only_num_10 CHECK ((("ID_passport")::text ~ '[0-9]{10}'::text)) NOT VALID;


--
-- TOC entry 3276 (class 2606 OID 16843)
-- Name: Student only_num_10; Type: CHECK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE timetable_courses."Student"
    ADD CONSTRAINT only_num_10 CHECK ((("ID_passport")::text ~ '[0-9]{10}'::text)) NOT VALID;


--
-- TOC entry 3328 (class 2606 OID 16726)
-- Name: Discipline_of_programme d_ID_discipline; Type: FK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Discipline_of_programme"
    ADD CONSTRAINT "d_ID_discipline" FOREIGN KEY ("d_ID_discipline") REFERENCES timetable_courses."Discipline"("ID_discipline") NOT VALID;


--
-- TOC entry 3327 (class 2606 OID 16721)
-- Name: Discipline_of_programme d_ID_programme; Type: FK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Discipline_of_programme"
    ADD CONSTRAINT "d_ID_programme" FOREIGN KEY ("d_ID_programme") REFERENCES timetable_courses."Programme"("ID_programme") NOT VALID;


--
-- TOC entry 3323 (class 2606 OID 16428)
-- Name: Class fk_ID_division; Type: FK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Class"
    ADD CONSTRAINT "fk_ID_division" FOREIGN KEY ("c_ID_division") REFERENCES timetable_courses."Division"("ID_division") NOT VALID;


--
-- TOC entry 3324 (class 2606 OID 16454)
-- Name: Admission_year fk_ID_programme; Type: FK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Admission_year"
    ADD CONSTRAINT "fk_ID_programme" FOREIGN KEY ("a_ID_programme") REFERENCES timetable_courses."Programme"("ID_programme") NOT VALID;


--
-- TOC entry 3325 (class 2606 OID 16466)
-- Name: Group fk_ID_year_admission; Type: FK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Group"
    ADD CONSTRAINT "fk_ID_year_admission" FOREIGN KEY ("g_ID_year_admission") REFERENCES timetable_courses."Admission_year"("ID_year_admission");


--
-- TOC entry 3329 (class 2606 OID 16749)
-- Name: Is_in_division fk_IS_ID_division; Type: FK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Is_in_division"
    ADD CONSTRAINT "fk_IS_ID_division" FOREIGN KEY ("IS_ID_division") REFERENCES timetable_courses."Division"("ID_division") NOT VALID;


--
-- TOC entry 3330 (class 2606 OID 16754)
-- Name: Is_in_division fk_IS_ID_passport; Type: FK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Is_in_division"
    ADD CONSTRAINT "fk_IS_ID_passport" FOREIGN KEY ("IS_ID_passport") REFERENCES timetable_courses."Teacher"("ID_passport") NOT VALID;


--
-- TOC entry 3333 (class 2606 OID 16791)
-- Name: Is_in_group fk_I_ID_passport; Type: FK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Is_in_group"
    ADD CONSTRAINT "fk_I_ID_passport" FOREIGN KEY ("I_ID_passport") REFERENCES timetable_courses."Student"("ID_passport");


--
-- TOC entry 3334 (class 2606 OID 16786)
-- Name: Is_in_group fk_I_group_number; Type: FK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Is_in_group"
    ADD CONSTRAINT "fk_I_group_number" FOREIGN KEY ("I_group_number") REFERENCES timetable_courses."Group"("Group_number");


--
-- TOC entry 3335 (class 2606 OID 16814)
-- Name: Lesson fk_L_ID_class; Type: FK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Lesson"
    ADD CONSTRAINT "fk_L_ID_class" FOREIGN KEY ("L_ID_class") REFERENCES timetable_courses."Class"("ID_class") NOT VALID;


--
-- TOC entry 3336 (class 2606 OID 16824)
-- Name: Lesson fk_L_ID_discipline_of_pr; Type: FK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Lesson"
    ADD CONSTRAINT "fk_L_ID_discipline_of_pr" FOREIGN KEY ("L_ID_discipline_of_pr") REFERENCES timetable_courses."Discipline_of_programme"("ID_discipline_of_pr") NOT VALID;


--
-- TOC entry 3337 (class 2606 OID 16819)
-- Name: Lesson fk_L_ID_passport; Type: FK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Lesson"
    ADD CONSTRAINT "fk_L_ID_passport" FOREIGN KEY ("L_ID_passport") REFERENCES timetable_courses."Teacher"("ID_passport") NOT VALID;


--
-- TOC entry 3338 (class 2606 OID 16809)
-- Name: Lesson fk_L_group_number; Type: FK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Lesson"
    ADD CONSTRAINT "fk_L_group_number" FOREIGN KEY ("L_group_number") REFERENCES timetable_courses."Group"("Group_number") NOT VALID;


--
-- TOC entry 3331 (class 2606 OID 16769)
-- Name: Can_teach fk_c_ID_discipline; Type: FK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Can_teach"
    ADD CONSTRAINT "fk_c_ID_discipline" FOREIGN KEY ("c_ID_discipline") REFERENCES timetable_courses."Discipline"("ID_discipline");


--
-- TOC entry 3332 (class 2606 OID 16764)
-- Name: Can_teach fk_c_ID_passport; Type: FK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Can_teach"
    ADD CONSTRAINT "fk_c_ID_passport" FOREIGN KEY ("c_ID_passport") REFERENCES timetable_courses."Teacher"("ID_passport");


--
-- TOC entry 3326 (class 2606 OID 16711)
-- Name: Sick_and_vacation_leaves s_ID_passport; Type: FK CONSTRAINT; Schema: timetable_courses; Owner: postgres
--

ALTER TABLE ONLY timetable_courses."Sick_and_vacation_leaves"
    ADD CONSTRAINT "s_ID_passport" FOREIGN KEY ("s_ID_passport") REFERENCES timetable_courses."Teacher"("ID_passport") NOT VALID;


-- Completed on 2023-03-19 17:01:45

--
-- PostgreSQL database dump complete
--

