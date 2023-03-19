--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.1

-- Started on 2023-03-20 01:17:38 MSK

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
-- TOC entry 2 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3768 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- TOC entry 908 (class 1247 OID 16577)
-- Name: assessment_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.assessment_type_enum AS ENUM (
    'Credit',
    'Exam',
    'DifferentialCredit',
    'Coursework'
);


ALTER TYPE public.assessment_type_enum OWNER TO postgres;

--
-- TOC entry 875 (class 1247 OID 16444)
-- Name: classroom_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.classroom_type_enum AS ENUM (
    'LectureHall',
    'Classroom',
    'Laboratory',
    'ComputerLab'
);


ALTER TYPE public.classroom_type_enum OWNER TO postgres;

--
-- TOC entry 923 (class 1247 OID 16652)
-- Name: scholarship_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.scholarship_type_enum AS ENUM (
    'Basic',
    'Increased'
);


ALTER TYPE public.scholarship_type_enum OWNER TO postgres;

--
-- TOC entry 899 (class 1247 OID 16548)
-- Name: student_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.student_status_enum AS ENUM (
    'Studying',
    'Graduated',
    'Transferred',
    'AcademicLeave'
);


ALTER TYPE public.student_status_enum OWNER TO postgres;

--
-- TOC entry 890 (class 1247 OID 16509)
-- Name: study_form_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.study_form_enum AS ENUM (
    'Extramural',
    'FullTime'
);


ALTER TYPE public.study_form_enum OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 235 (class 1259 OID 16585)
-- Name: assessment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.assessment (
    id integer NOT NULL,
    teacher_id integer NOT NULL,
    edu_program_discipline_id integer NOT NULL,
    classroom_id integer NOT NULL,
    date date NOT NULL,
    assessment_type public.assessment_type_enum NOT NULL
);


ALTER TABLE public.assessment OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16454)
-- Name: classroom; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.classroom (
    id integer NOT NULL,
    university_site_id integer NOT NULL,
    capacity integer NOT NULL,
    room_number text NOT NULL,
    type public.classroom_type_enum NOT NULL,
    CONSTRAINT chk_capacity CHECK (((capacity >= 0) AND (capacity <= 2000)))
);


ALTER TABLE public.classroom OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16453)
-- Name: classroom_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.classroom ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.classroom_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 16468)
-- Name: course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course (
    id integer NOT NULL,
    name text NOT NULL,
    code text NOT NULL,
    department_id integer NOT NULL
);


ALTER TABLE public.course OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16467)
-- Name: course_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.course ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.course_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 16494)
-- Name: curriculum; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.curriculum (
    id integer NOT NULL,
    educational_program_id integer NOT NULL,
    students_recruitment_year integer NOT NULL,
    study_form public.study_form_enum NOT NULL,
    CONSTRAINT chk_students_recruitment_year CHECK (((students_recruitment_year >= 1900) AND (students_recruitment_year <= 2100)))
);


ALTER TABLE public.curriculum OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16493)
-- Name: curriculum_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.curriculum ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.curriculum_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 16431)
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    id integer NOT NULL,
    name text NOT NULL,
    university_site_id integer NOT NULL
);


ALTER TABLE public.department OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16430)
-- Name: department_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.department ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.department_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 234 (class 1259 OID 16569)
-- Name: discipline; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discipline (
    id integer NOT NULL,
    name text NOT NULL,
    hours_amount integer NOT NULL,
    labs_amount integer NOT NULL,
    points_amount integer NOT NULL,
    assessment_type public.assessment_type_enum NOT NULL
);


ALTER TABLE public.discipline OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16676)
-- Name: discipline_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.discipline ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.discipline_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 236 (class 1259 OID 16600)
-- Name: edu_program_discipline; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.edu_program_discipline (
    id integer NOT NULL,
    educational_program_id integer NOT NULL,
    discipline_id integer NOT NULL
);


ALTER TABLE public.edu_program_discipline OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16481)
-- Name: educational_program; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.educational_program (
    id integer NOT NULL,
    course_id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.educational_program OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16480)
-- Name: educational_program_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.educational_program ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.educational_program_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 216 (class 1259 OID 16414)
-- Name: person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person (
    id integer NOT NULL,
    name text NOT NULL,
    surname text NOT NULL,
    middle_name text,
    study_year integer NOT NULL,
    CONSTRAINT check_study_year CHECK (((1 <= study_year) AND (study_year <= 10)))
);


ALTER TABLE public.person OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16413)
-- Name: person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.person ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 238 (class 1259 OID 16643)
-- Name: scholarship; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scholarship (
    id integer NOT NULL,
    amount integer NOT NULL,
    type public.scholarship_type_enum NOT NULL,
    CONSTRAINT chk_amount CHECK (((amount >= 0) AND (amount <= 250000)))
);


ALTER TABLE public.scholarship OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16657)
-- Name: scholarship_assignment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scholarship_assignment (
    id integer NOT NULL,
    person_id integer NOT NULL,
    scholarship_id integer NOT NULL,
    due_from date NOT NULL,
    due_by date NOT NULL,
    CONSTRAINT chk_date CHECK ((due_from < due_by))
);


ALTER TABLE public.scholarship_assignment OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 16675)
-- Name: scholarship_assignment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.scholarship_assignment ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.scholarship_assignment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 241 (class 1259 OID 16674)
-- Name: scholarship_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.scholarship ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.scholarship_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 237 (class 1259 OID 16620)
-- Name: score; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.score (
    id integer NOT NULL,
    student_id integer NOT NULL,
    teacher_id integer NOT NULL,
    edu_program_discipline_id integer NOT NULL,
    score integer NOT NULL,
    attempt integer DEFAULT 1 NOT NULL,
    assessment_type public.assessment_type_enum NOT NULL,
    CONSTRAINT chk_attempt CHECK (((attempt >= 1) AND (attempt <= 4))),
    CONSTRAINT chk_score CHECK (((score >= 0) AND (score <= 5)))
);


ALTER TABLE public.score OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16531)
-- Name: student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student (
    id integer NOT NULL,
    student_group_id integer NOT NULL,
    person_id integer NOT NULL,
    study_start date NOT NULL,
    study_end date NOT NULL,
    status public.student_status_enum NOT NULL,
    CONSTRAINT study_start CHECK ((study_start < study_end))
);


ALTER TABLE public.student OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16514)
-- Name: student_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_group (
    id integer NOT NULL,
    curriculum_id integer NOT NULL,
    code text NOT NULL,
    year integer DEFAULT 1 NOT NULL,
    semester integer DEFAULT 1 NOT NULL,
    CONSTRAINT chk_semester CHECK (((semester >= 1) AND (semester <= 8))),
    CONSTRAINT chk_year CHECK (((year >= 1) AND (year <= 4)))
);


ALTER TABLE public.student_group OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16513)
-- Name: student_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.student_group ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.student_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 231 (class 1259 OID 16530)
-- Name: student_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.student ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.student_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 233 (class 1259 OID 16557)
-- Name: teacher; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teacher (
    id integer NOT NULL,
    name text NOT NULL,
    surname text NOT NULL,
    middle_name text,
    "position" text NOT NULL,
    department_id integer NOT NULL
);


ALTER TABLE public.teacher OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16673)
-- Name: teacher_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.teacher ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.teacher_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 16423)
-- Name: university_site; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.university_site (
    id integer NOT NULL,
    address text NOT NULL,
    short_name text NOT NULL
);


ALTER TABLE public.university_site OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16422)
-- Name: university_site_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.university_site ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.university_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3753 (class 0 OID 16585)
-- Dependencies: 235
-- Data for Name: assessment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.assessment (id, teacher_id, edu_program_discipline_id, classroom_id, date, assessment_type) FROM stdin;
1	2	3	4	2023-07-28	Exam
2	2	4	4	2023-07-29	Exam
3	2	5	4	2023-07-30	Exam
4	2	6	4	2023-07-02	Exam
5	2	7	4	2023-07-04	Exam
6	2	8	4	2023-07-12	Exam
7	2	9	4	2023-07-17	Exam
8	6	13	4	2023-06-30	Credit
9	4	11	2	2023-07-19	Credit
10	5	10	2	2023-07-21	Credit
\.


--
-- TOC entry 3740 (class 0 OID 16454)
-- Dependencies: 222
-- Data for Name: classroom; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.classroom (id, university_site_id, capacity, room_number, type) FROM stdin;
1	1	28	1	Classroom
2	1	32	2	Classroom
4	1	64	4	LectureHall
6	1	12	6	ComputerLab
3	2	32	3	Classroom
5	2	96	5	LectureHall
7	2	18	7	Laboratory
\.


--
-- TOC entry 3742 (class 0 OID 16468)
-- Dependencies: 224
-- Data for Name: course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course (id, name, code, department_id) FROM stdin;
1	Прикладная информатика	09.03.03	1
2	Инфокоммуникационные технологии и системы связи	11.03.02	1
3	Интеллектуальные системы в гуманитарной сфере	45.03.04	1
4	Фотоника и оптоинформатика	12.03.03	3
5	Прикладная математика и информатика	01.03.02	4
6	Информационные системы и технологии	09.03.02	4
7	Информатика и вычислительная техника	09.03.01	5
8	Программная инженерия	09.03.04	5
\.


--
-- TOC entry 3746 (class 0 OID 16494)
-- Dependencies: 228
-- Data for Name: curriculum; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.curriculum (id, educational_program_id, students_recruitment_year, study_form) FROM stdin;
1	1	2021	FullTime
2	1	2022	FullTime
3	2	2021	FullTime
4	3	2021	FullTime
5	4	2021	FullTime
6	5	2021	FullTime
7	6	2021	Extramural
8	7	2021	FullTime
9	8	2018	FullTime
10	9	2019	FullTime
11	10	2020	FullTime
12	11	2021	FullTime
13	12	2022	FullTime
14	13	2023	FullTime
\.


--
-- TOC entry 3738 (class 0 OID 16431)
-- Dependencies: 220
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.department (id, name, university_site_id) FROM stdin;
1	Факультет инфокоммуникационных технологий	1
3	Факультет лазерной и световой инженерии	1
4	Факультет информационных технологий и программирования	2
5	Факультет программной инженерии и компьютерной техники	2
\.


--
-- TOC entry 3752 (class 0 OID 16569)
-- Dependencies: 234
-- Data for Name: discipline; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discipline (id, name, hours_amount, labs_amount, points_amount, assessment_type) FROM stdin;
1	Проектирование и реализация баз данных	140	5	10	Exam
2	Проектирование баз данных	80	2	12	Credit
3	Физика	148	5	12	Exam
4	Экология	90	5	8	Credit
5	Инновационная экономика и технологическое предпринимательство	78	5	7	Credit
6	Машинное обучение	90	10	10	Credit
\.


--
-- TOC entry 3754 (class 0 OID 16600)
-- Dependencies: 236
-- Data for Name: edu_program_discipline; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.edu_program_discipline (id, educational_program_id, discipline_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	2	3
5	6	3
6	7	3
7	8	3
8	9	3
9	11	3
10	1	4
11	4	5
12	1	5
13	1	6
\.


--
-- TOC entry 3744 (class 0 OID 16481)
-- Dependencies: 226
-- Data for Name: educational_program; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.educational_program (id, course_id, name) FROM stdin;
1	1	Мобильные и сетевые технологии
2	2	Программирование в инфокоммуникационных системах
3	2	Технологии разработки компьютерных игр
4	3	Интеллектуальные системы в гуманитарной сфере
5	3	Иностранные языки и информационные технологии
6	4	Физика наноструктур
7	4	Фотоника и оптоинформатика
8	4	Лазерные технологии
9	5	Компьютерные технологии: Программирование и искусственный интеллект
10	6	Разработка программного обеспечения / Software engineering
11	7	Компьютерные системы и технологии
12	8	Компьютерные технологии в дизайне
13	8	Системное и прикладное программное обеспечение
\.


--
-- TOC entry 3734 (class 0 OID 16414)
-- Dependencies: 216
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.person (id, name, surname, middle_name, study_year) FROM stdin;
1	Владислав	Екушев	Александрович	2
2	Даниил	Арслан	Абдухалимович	2
9	Иван	Горбов	Андреевич	2
15	Корягина	Александра	Константиновна	3
3	Виктор	Александров	Денисович	2
4	Роман	Рахлин	Александрович	2
5	Мартин	Абдрахманов	Маратович	2
6	Дмитрий	Белый	Васильевич	2
7	Ярослав	Ященко	Константинович	2
8	Станислав	Горбачев	Александрович	2
10	Сорокина	Яна	Александровна	2
11	Курнакова	Ксения	Алексеевна	2
12	Руцкой	Антон	Валерьевич	2
13	Самощенков	Алексей	Алексеевич	2
14	Ускова	Арина	Игоревна	3
\.


--
-- TOC entry 3756 (class 0 OID 16643)
-- Dependencies: 238
-- Data for Name: scholarship; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scholarship (id, amount, type) FROM stdin;
1	3000	Basic
2	4000	Basic
3	15000	Increased
4	100000	Increased
5	200000	Increased
\.


--
-- TOC entry 3757 (class 0 OID 16657)
-- Dependencies: 239
-- Data for Name: scholarship_assignment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scholarship_assignment (id, person_id, scholarship_id, due_from, due_by) FROM stdin;
1	1	3	2023-03-19	2023-04-19
2	3	1	2023-02-01	2023-07-30
3	4	1	2023-02-01	2023-07-30
4	5	1	2023-02-01	2023-07-30
5	5	2	2023-02-01	2023-07-30
6	6	2	2023-02-01	2023-07-30
7	9	2	2023-02-01	2023-07-30
8	13	4	2023-02-01	2023-03-01
\.


--
-- TOC entry 3755 (class 0 OID 16620)
-- Dependencies: 237
-- Data for Name: score; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.score (id, student_id, teacher_id, edu_program_discipline_id, score, attempt, assessment_type) FROM stdin;
1	2	2	3	4	1	Exam
2	3	2	3	3	1	Exam
3	4	2	3	3	2	Exam
4	5	2	3	3	1	Exam
5	6	4	3	5	1	Exam
6	7	5	3	0	1	Credit
7	8	5	3	5	1	Credit
8	9	6	3	5	1	Credit
\.


--
-- TOC entry 3750 (class 0 OID 16531)
-- Dependencies: 232
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student (id, student_group_id, person_id, study_start, study_end, status) FROM stdin;
2	2	1	2021-09-01	2025-07-01	Studying
3	2	2	2021-09-01	2025-07-01	Studying
4	2	3	2021-09-01	2025-07-01	Studying
5	2	4	2021-09-01	2025-07-01	Studying
6	2	5	2021-09-01	2025-07-01	Studying
7	3	6	2021-09-01	2025-07-01	Studying
8	3	7	2021-09-01	2025-07-01	Transferred
9	3	8	2021-09-01	2025-07-01	Studying
10	3	10	2021-09-01	2025-07-01	AcademicLeave
11	4	11	2021-09-01	2025-07-01	Studying
12	4	12	2021-09-01	2025-07-01	Studying
13	4	13	2021-09-01	2025-07-01	Studying
14	5	14	2020-09-01	2024-07-01	Studying
15	5	15	2020-09-01	2024-07-01	Studying
17	2	1	2021-09-01	2025-07-01	Studying
\.


--
-- TOC entry 3748 (class 0 OID 16514)
-- Dependencies: 230
-- Data for Name: student_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_group (id, curriculum_id, code, year, semester) FROM stdin;
2	1	K32402	2	4
3	1	K32401	2	4
4	13	F402	3	5
5	13	F401	3	5
\.


--
-- TOC entry 3751 (class 0 OID 16557)
-- Dependencies: 233
-- Data for Name: teacher; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teacher (id, name, surname, middle_name, "position", department_id) FROM stdin;
1	Николай	Пулькин	Сергеевич	Working	3
2	Сергей	Стафеев	Константинович	Working	3
3	Даниил	Казанцев	Владимирович	Working	4
4	Ирина	Цимбалист	Андреевна	Working	1
5	Мария	Фалеева	Петровна	Working	1
6	Антон	Бойцев	Александрович	Working	5
7	Марина	Говорова	Михайловна	Working	1
\.


--
-- TOC entry 3736 (class 0 OID 16423)
-- Dependencies: 218
-- Data for Name: university_site; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.university_site (id, address, short_name) FROM stdin;
1	ул. Ломоносова, 9, Санкт-Петербург, 191002	ИТМО Ломоносова 9
2	Кронверкский пр., 49, Санкт-Петербург, 197101	ИТМО Кронверкский 49
\.


--
-- TOC entry 3769 (class 0 OID 0)
-- Dependencies: 221
-- Name: classroom_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.classroom_id_seq', 7, true);


--
-- TOC entry 3770 (class 0 OID 0)
-- Dependencies: 223
-- Name: course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_id_seq', 8, true);


--
-- TOC entry 3771 (class 0 OID 0)
-- Dependencies: 227
-- Name: curriculum_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.curriculum_id_seq', 14, true);


--
-- TOC entry 3772 (class 0 OID 0)
-- Dependencies: 219
-- Name: department_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.department_id_seq', 6, true);


--
-- TOC entry 3773 (class 0 OID 0)
-- Dependencies: 243
-- Name: discipline_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.discipline_id_seq', 6, true);


--
-- TOC entry 3774 (class 0 OID 0)
-- Dependencies: 225
-- Name: educational_program_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.educational_program_id_seq', 13, true);


--
-- TOC entry 3775 (class 0 OID 0)
-- Dependencies: 215
-- Name: person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.person_id_seq', 15, true);


--
-- TOC entry 3776 (class 0 OID 0)
-- Dependencies: 242
-- Name: scholarship_assignment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.scholarship_assignment_id_seq', 8, true);


--
-- TOC entry 3777 (class 0 OID 0)
-- Dependencies: 241
-- Name: scholarship_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.scholarship_id_seq', 5, true);


--
-- TOC entry 3778 (class 0 OID 0)
-- Dependencies: 229
-- Name: student_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_group_id_seq', 5, true);


--
-- TOC entry 3779 (class 0 OID 0)
-- Dependencies: 231
-- Name: student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_id_seq', 17, true);


--
-- TOC entry 3780 (class 0 OID 0)
-- Dependencies: 240
-- Name: teacher_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teacher_id_seq', 7, true);


--
-- TOC entry 3781 (class 0 OID 0)
-- Dependencies: 217
-- Name: university_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.university_site_id_seq', 2, true);


--
-- TOC entry 3563 (class 2606 OID 16589)
-- Name: assessment assessment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assessment
    ADD CONSTRAINT assessment_pkey PRIMARY KEY (id);


--
-- TOC entry 3547 (class 2606 OID 16461)
-- Name: classroom classroom_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classroom
    ADD CONSTRAINT classroom_pkey PRIMARY KEY (id);


--
-- TOC entry 3549 (class 2606 OID 16474)
-- Name: course course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_pkey PRIMARY KEY (id);


--
-- TOC entry 3553 (class 2606 OID 16501)
-- Name: curriculum curriculum_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.curriculum
    ADD CONSTRAINT curriculum_pkey PRIMARY KEY (id);


--
-- TOC entry 3545 (class 2606 OID 16437)
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (id);


--
-- TOC entry 3561 (class 2606 OID 16575)
-- Name: discipline discipline_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discipline
    ADD CONSTRAINT discipline_pkey PRIMARY KEY (id);


--
-- TOC entry 3565 (class 2606 OID 16604)
-- Name: edu_program_discipline edu_program_discipline_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edu_program_discipline
    ADD CONSTRAINT edu_program_discipline_pkey PRIMARY KEY (id);


--
-- TOC entry 3551 (class 2606 OID 16487)
-- Name: educational_program educational_program_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educational_program
    ADD CONSTRAINT educational_program_pkey PRIMARY KEY (id);


--
-- TOC entry 3541 (class 2606 OID 16421)
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- TOC entry 3571 (class 2606 OID 16662)
-- Name: scholarship_assignment scholarship_assignment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship_assignment
    ADD CONSTRAINT scholarship_assignment_pkey PRIMARY KEY (id);


--
-- TOC entry 3569 (class 2606 OID 16650)
-- Name: scholarship scholarship_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship
    ADD CONSTRAINT scholarship_pkey PRIMARY KEY (id);


--
-- TOC entry 3567 (class 2606 OID 16627)
-- Name: score score_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.score
    ADD CONSTRAINT score_pkey PRIMARY KEY (id);


--
-- TOC entry 3555 (class 2606 OID 16524)
-- Name: student_group student_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_group
    ADD CONSTRAINT student_group_pkey PRIMARY KEY (id);


--
-- TOC entry 3557 (class 2606 OID 16536)
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (id);


--
-- TOC entry 3559 (class 2606 OID 16563)
-- Name: teacher teacher_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher
    ADD CONSTRAINT teacher_pkey PRIMARY KEY (id);


--
-- TOC entry 3543 (class 2606 OID 16429)
-- Name: university_site university_site_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.university_site
    ADD CONSTRAINT university_site_pkey PRIMARY KEY (id);


--
-- TOC entry 3581 (class 2606 OID 16595)
-- Name: assessment fk_classroom; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assessment
    ADD CONSTRAINT fk_classroom FOREIGN KEY (classroom_id) REFERENCES public.classroom(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3575 (class 2606 OID 16488)
-- Name: educational_program fk_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educational_program
    ADD CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES public.course(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3577 (class 2606 OID 16525)
-- Name: student_group fk_curriculum; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_group
    ADD CONSTRAINT fk_curriculum FOREIGN KEY (curriculum_id) REFERENCES public.curriculum(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3574 (class 2606 OID 16475)
-- Name: course fk_department; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES public.department(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3580 (class 2606 OID 16564)
-- Name: teacher fk_department; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher
    ADD CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES public.department(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3584 (class 2606 OID 16605)
-- Name: edu_program_discipline fk_discipline; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edu_program_discipline
    ADD CONSTRAINT fk_discipline FOREIGN KEY (discipline_id) REFERENCES public.discipline(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3582 (class 2606 OID 16615)
-- Name: assessment fk_edu_program_discipline; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assessment
    ADD CONSTRAINT fk_edu_program_discipline FOREIGN KEY (edu_program_discipline_id) REFERENCES public.edu_program_discipline(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3586 (class 2606 OID 16638)
-- Name: score fk_edu_program_discipline; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.score
    ADD CONSTRAINT fk_edu_program_discipline FOREIGN KEY (edu_program_discipline_id) REFERENCES public.edu_program_discipline(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3576 (class 2606 OID 16502)
-- Name: curriculum fk_educational_program; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.curriculum
    ADD CONSTRAINT fk_educational_program FOREIGN KEY (educational_program_id) REFERENCES public.educational_program(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3585 (class 2606 OID 16610)
-- Name: edu_program_discipline fk_educational_program; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edu_program_discipline
    ADD CONSTRAINT fk_educational_program FOREIGN KEY (educational_program_id) REFERENCES public.educational_program(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3578 (class 2606 OID 16542)
-- Name: student fk_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT fk_person FOREIGN KEY (person_id) REFERENCES public.person(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3589 (class 2606 OID 16663)
-- Name: scholarship_assignment fk_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship_assignment
    ADD CONSTRAINT fk_person FOREIGN KEY (person_id) REFERENCES public.person(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3590 (class 2606 OID 16668)
-- Name: scholarship_assignment fk_scholarship; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship_assignment
    ADD CONSTRAINT fk_scholarship FOREIGN KEY (scholarship_id) REFERENCES public.scholarship(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3587 (class 2606 OID 16633)
-- Name: score fk_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.score
    ADD CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES public.student(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3579 (class 2606 OID 16537)
-- Name: student fk_student_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT fk_student_group FOREIGN KEY (student_group_id) REFERENCES public.student_group(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3583 (class 2606 OID 16590)
-- Name: assessment fk_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assessment
    ADD CONSTRAINT fk_teacher FOREIGN KEY (teacher_id) REFERENCES public.teacher(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3588 (class 2606 OID 16628)
-- Name: score fk_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.score
    ADD CONSTRAINT fk_teacher FOREIGN KEY (teacher_id) REFERENCES public.teacher(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3572 (class 2606 OID 16438)
-- Name: department fk_university_site; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT fk_university_site FOREIGN KEY (university_site_id) REFERENCES public.university_site(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3573 (class 2606 OID 16462)
-- Name: classroom fk_university_site; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classroom
    ADD CONSTRAINT fk_university_site FOREIGN KEY (university_site_id) REFERENCES public.university_site(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3767 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2023-03-20 01:17:38 MSK

--
-- PostgreSQL database dump complete
--

