--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.1

-- Started on 2023-05-15 12:38:24 MSK

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
-- TOC entry 2 (class 3079 OID 16678)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3775 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- TOC entry 866 (class 1247 OID 16689)
-- Name: assessment_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.assessment_type_enum AS ENUM (
    'Credit',
    'Exam',
    'DifferentialCredit',
    'Coursework',
    'CourseworkProject'
);


ALTER TYPE public.assessment_type_enum OWNER TO postgres;

--
-- TOC entry 869 (class 1247 OID 16698)
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
-- TOC entry 872 (class 1247 OID 16708)
-- Name: scholarship_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.scholarship_type_enum AS ENUM (
    'Basic',
    'Increased'
);


ALTER TYPE public.scholarship_type_enum OWNER TO postgres;

--
-- TOC entry 929 (class 1247 OID 16960)
-- Name: student_group_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.student_group_status_enum AS ENUM (
    'Formed',
    'Studying',
    'Disbanded',
    'Released'
);


ALTER TYPE public.student_group_status_enum OWNER TO postgres;

--
-- TOC entry 875 (class 1247 OID 16714)
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
-- TOC entry 878 (class 1247 OID 16724)
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
-- TOC entry 215 (class 1259 OID 16729)
-- Name: assessment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.assessment (
    id integer NOT NULL,
    teacher_id integer NOT NULL,
    edu_program_discipline_id integer NOT NULL,
    classroom_id integer NOT NULL,
    date date NOT NULL
);


ALTER TABLE public.assessment OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16732)
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
-- TOC entry 217 (class 1259 OID 16738)
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
-- TOC entry 218 (class 1259 OID 16739)
-- Name: course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course (
    id integer NOT NULL,
    name text NOT NULL,
    code text NOT NULL
);


ALTER TABLE public.course OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16744)
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
-- TOC entry 220 (class 1259 OID 16745)
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
-- TOC entry 221 (class 1259 OID 16749)
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
-- TOC entry 222 (class 1259 OID 16750)
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    id integer NOT NULL,
    name text NOT NULL,
    university_site_id integer NOT NULL
);


ALTER TABLE public.department OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16755)
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
-- TOC entry 224 (class 1259 OID 16756)
-- Name: discipline; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discipline (
    id integer NOT NULL,
    name text NOT NULL,
    lecture_hours_amount integer NOT NULL,
    labs_hours_amount integer NOT NULL,
    points_amount integer NOT NULL,
    assessment_type public.assessment_type_enum NOT NULL,
    practice_hours_amount integer,
    consultation_hours_amount integer,
    total_hours_amount integer
);


ALTER TABLE public.discipline OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16761)
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
-- TOC entry 226 (class 1259 OID 16762)
-- Name: edu_program_discipline; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.edu_program_discipline (
    id integer NOT NULL,
    educational_program_id integer NOT NULL,
    discipline_id integer NOT NULL,
    semesters "char"
);


ALTER TABLE public.edu_program_discipline OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16765)
-- Name: educational_program; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.educational_program (
    id integer NOT NULL,
    course_id integer NOT NULL,
    name text NOT NULL,
    department_id integer
);


ALTER TABLE public.educational_program OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16770)
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
-- TOC entry 229 (class 1259 OID 16771)
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
-- TOC entry 230 (class 1259 OID 16777)
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
-- TOC entry 231 (class 1259 OID 16778)
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
-- TOC entry 232 (class 1259 OID 16782)
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
-- TOC entry 233 (class 1259 OID 16786)
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
-- TOC entry 234 (class 1259 OID 16787)
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
-- TOC entry 235 (class 1259 OID 16788)
-- Name: score; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.score (
    id integer NOT NULL,
    student_id integer NOT NULL,
    teacher_id integer NOT NULL,
    edu_program_discipline_id integer NOT NULL,
    score integer NOT NULL,
    attempt integer DEFAULT 1 NOT NULL,
    date date,
    CONSTRAINT chk_attempt CHECK (((attempt >= 1) AND (attempt <= 4))),
    CONSTRAINT chk_score CHECK (((score >= 0) AND (score <= 5)))
);


ALTER TABLE public.score OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16794)
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
-- TOC entry 237 (class 1259 OID 16798)
-- Name: student_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_group (
    id integer NOT NULL,
    curriculum_id integer NOT NULL,
    code text NOT NULL,
    year_start integer DEFAULT 1 NOT NULL,
    year_end integer DEFAULT 2 NOT NULL,
    status public.student_group_status_enum DEFAULT 'Formed'::public.student_group_status_enum NOT NULL,
    CONSTRAINT chk_year CHECK (((year_start >= 1) AND (year_start <= 4)))
);


ALTER TABLE public.student_group OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16807)
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
-- TOC entry 239 (class 1259 OID 16808)
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
-- TOC entry 240 (class 1259 OID 16809)
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
-- TOC entry 241 (class 1259 OID 16814)
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
-- TOC entry 242 (class 1259 OID 16815)
-- Name: university_site; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.university_site (
    id integer NOT NULL,
    address text NOT NULL,
    short_name text NOT NULL
);


ALTER TABLE public.university_site OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16820)
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
-- TOC entry 3740 (class 0 OID 16729)
-- Dependencies: 215
-- Data for Name: assessment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.assessment (id, teacher_id, edu_program_discipline_id, classroom_id, date) FROM stdin;
1	2	3	4	2023-07-28
2	2	4	4	2023-07-29
3	2	5	4	2023-07-30
4	2	6	4	2023-07-02
5	2	7	4	2023-07-04
6	2	8	4	2023-07-12
7	2	9	4	2023-07-17
8	6	13	4	2023-06-30
9	4	11	2	2023-07-19
10	5	10	2	2023-07-21
\.


--
-- TOC entry 3741 (class 0 OID 16732)
-- Dependencies: 216
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
-- TOC entry 3743 (class 0 OID 16739)
-- Dependencies: 218
-- Data for Name: course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course (id, name, code) FROM stdin;
1	Прикладная информатика	09.03.03
2	Инфокоммуникационные технологии и системы связи	11.03.02
3	Интеллектуальные системы в гуманитарной сфере	45.03.04
4	Фотоника и оптоинформатика	12.03.03
5	Прикладная математика и информатика	01.03.02
6	Информационные системы и технологии	09.03.02
7	Информатика и вычислительная техника	09.03.01
8	Программная инженерия	09.03.04
\.


--
-- TOC entry 3745 (class 0 OID 16745)
-- Dependencies: 220
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
-- TOC entry 3747 (class 0 OID 16750)
-- Dependencies: 222
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.department (id, name, university_site_id) FROM stdin;
1	Факультет инфокоммуникационных технологий	1
3	Факультет лазерной и световой инженерии	1
4	Факультет информационных технологий и программирования	2
5	Факультет программной инженерии и компьютерной техники	2
\.


--
-- TOC entry 3749 (class 0 OID 16756)
-- Dependencies: 224
-- Data for Name: discipline; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discipline (id, name, lecture_hours_amount, labs_hours_amount, points_amount, assessment_type, practice_hours_amount, consultation_hours_amount, total_hours_amount) FROM stdin;
1	Проектирование и реализация баз данных	140	5	10	Exam	\N	\N	\N
2	Проектирование баз данных	80	2	12	Credit	\N	\N	\N
3	Физика	148	5	12	Exam	\N	\N	\N
4	Экология	90	5	8	Credit	\N	\N	\N
5	Инновационная экономика и технологическое предпринимательство	78	5	7	Credit	\N	\N	\N
6	Машинное обучение	90	10	10	Credit	\N	\N	\N
\.


--
-- TOC entry 3751 (class 0 OID 16762)
-- Dependencies: 226
-- Data for Name: edu_program_discipline; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.edu_program_discipline (id, educational_program_id, discipline_id, semesters) FROM stdin;
1	1	1	\N
2	1	2	\N
3	1	3	\N
4	2	3	\N
5	6	3	\N
6	7	3	\N
7	8	3	\N
8	9	3	\N
9	11	3	\N
10	1	4	\N
11	4	5	\N
12	1	5	\N
13	1	6	\N
\.


--
-- TOC entry 3752 (class 0 OID 16765)
-- Dependencies: 227
-- Data for Name: educational_program; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.educational_program (id, course_id, name, department_id) FROM stdin;
1	1	Мобильные и сетевые технологии	\N
2	2	Программирование в инфокоммуникационных системах	\N
3	2	Технологии разработки компьютерных игр	\N
4	3	Интеллектуальные системы в гуманитарной сфере	\N
5	3	Иностранные языки и информационные технологии	\N
6	4	Физика наноструктур	\N
7	4	Фотоника и оптоинформатика	\N
8	4	Лазерные технологии	\N
9	5	Компьютерные технологии: Программирование и искусственный интеллект	\N
10	6	Разработка программного обеспечения / Software engineering	\N
11	7	Компьютерные системы и технологии	\N
12	8	Компьютерные технологии в дизайне	\N
13	8	Системное и прикладное программное обеспечение	\N
\.


--
-- TOC entry 3754 (class 0 OID 16771)
-- Dependencies: 229
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
-- TOC entry 3756 (class 0 OID 16778)
-- Dependencies: 231
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
-- TOC entry 3757 (class 0 OID 16782)
-- Dependencies: 232
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
-- TOC entry 3760 (class 0 OID 16788)
-- Dependencies: 235
-- Data for Name: score; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.score (id, student_id, teacher_id, edu_program_discipline_id, score, attempt, date) FROM stdin;
1	2	2	3	4	1	\N
2	3	2	3	3	1	\N
3	4	2	3	3	2	\N
4	5	2	3	3	1	\N
5	6	4	3	5	1	\N
6	7	5	3	0	1	\N
7	8	5	3	5	1	\N
8	9	6	3	5	1	\N
\.


--
-- TOC entry 3761 (class 0 OID 16794)
-- Dependencies: 236
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
-- TOC entry 3762 (class 0 OID 16798)
-- Dependencies: 237
-- Data for Name: student_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_group (id, curriculum_id, code, year_start, year_end, status) FROM stdin;
2	1	K32402	2	2	Formed
3	1	K32401	2	2	Formed
4	13	F402	3	2	Formed
5	13	F401	3	2	Formed
\.


--
-- TOC entry 3765 (class 0 OID 16809)
-- Dependencies: 240
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
-- TOC entry 3767 (class 0 OID 16815)
-- Dependencies: 242
-- Data for Name: university_site; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.university_site (id, address, short_name) FROM stdin;
1	ул. Ломоносова, 9, Санкт-Петербург, 191002	ИТМО Ломоносова 9
2	Кронверкский пр., 49, Санкт-Петербург, 197101	ИТМО Кронверкский 49
\.


--
-- TOC entry 3776 (class 0 OID 0)
-- Dependencies: 217
-- Name: classroom_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.classroom_id_seq', 7, true);


--
-- TOC entry 3777 (class 0 OID 0)
-- Dependencies: 219
-- Name: course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_id_seq', 8, true);


--
-- TOC entry 3778 (class 0 OID 0)
-- Dependencies: 221
-- Name: curriculum_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.curriculum_id_seq', 14, true);


--
-- TOC entry 3779 (class 0 OID 0)
-- Dependencies: 223
-- Name: department_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.department_id_seq', 6, true);


--
-- TOC entry 3780 (class 0 OID 0)
-- Dependencies: 225
-- Name: discipline_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.discipline_id_seq', 6, true);


--
-- TOC entry 3781 (class 0 OID 0)
-- Dependencies: 228
-- Name: educational_program_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.educational_program_id_seq', 13, true);


--
-- TOC entry 3782 (class 0 OID 0)
-- Dependencies: 230
-- Name: person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.person_id_seq', 15, true);


--
-- TOC entry 3783 (class 0 OID 0)
-- Dependencies: 233
-- Name: scholarship_assignment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.scholarship_assignment_id_seq', 8, true);


--
-- TOC entry 3784 (class 0 OID 0)
-- Dependencies: 234
-- Name: scholarship_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.scholarship_id_seq', 5, true);


--
-- TOC entry 3785 (class 0 OID 0)
-- Dependencies: 238
-- Name: student_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_group_id_seq', 5, true);


--
-- TOC entry 3786 (class 0 OID 0)
-- Dependencies: 239
-- Name: student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_id_seq', 17, true);


--
-- TOC entry 3787 (class 0 OID 0)
-- Dependencies: 241
-- Name: teacher_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teacher_id_seq', 7, true);


--
-- TOC entry 3788 (class 0 OID 0)
-- Dependencies: 243
-- Name: university_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.university_site_id_seq', 2, true);


--
-- TOC entry 3548 (class 2606 OID 16822)
-- Name: assessment assessment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assessment
    ADD CONSTRAINT assessment_pkey PRIMARY KEY (id);


--
-- TOC entry 3542 (class 2606 OID 16956)
-- Name: score chk_date; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.score
    ADD CONSTRAINT chk_date CHECK (((date >= '1900-01-01'::date) AND (date <= '2100-01-01'::date))) NOT VALID;


--
-- TOC entry 3536 (class 2606 OID 16972)
-- Name: discipline chk_hours; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.discipline
    ADD CONSTRAINT chk_hours CHECK (((consultation_hours_amount > 0) AND (practice_hours_amount > 0) AND (lecture_hours_amount > 0) AND (labs_hours_amount > 0))) NOT VALID;


--
-- TOC entry 3537 (class 2606 OID 16971)
-- Name: discipline chk_hours_amount; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.discipline
    ADD CONSTRAINT chk_hours_amount CHECK ((((lecture_hours_amount + practice_hours_amount) + labs_hours_amount) < total_hours_amount)) NOT VALID;


--
-- TOC entry 3546 (class 2606 OID 16958)
-- Name: student_group chk_year_end; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.student_group
    ADD CONSTRAINT chk_year_end CHECK ((year_end > year_start)) NOT VALID;


--
-- TOC entry 3550 (class 2606 OID 16824)
-- Name: classroom classroom_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classroom
    ADD CONSTRAINT classroom_pkey PRIMARY KEY (id);


--
-- TOC entry 3552 (class 2606 OID 16826)
-- Name: course course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_pkey PRIMARY KEY (id);


--
-- TOC entry 3554 (class 2606 OID 16828)
-- Name: curriculum curriculum_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.curriculum
    ADD CONSTRAINT curriculum_pkey PRIMARY KEY (id);


--
-- TOC entry 3556 (class 2606 OID 16830)
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (id);


--
-- TOC entry 3558 (class 2606 OID 16832)
-- Name: discipline discipline_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discipline
    ADD CONSTRAINT discipline_pkey PRIMARY KEY (id);


--
-- TOC entry 3560 (class 2606 OID 16834)
-- Name: edu_program_discipline edu_program_discipline_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edu_program_discipline
    ADD CONSTRAINT edu_program_discipline_pkey PRIMARY KEY (id);


--
-- TOC entry 3562 (class 2606 OID 16836)
-- Name: educational_program educational_program_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educational_program
    ADD CONSTRAINT educational_program_pkey PRIMARY KEY (id);


--
-- TOC entry 3564 (class 2606 OID 16838)
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- TOC entry 3568 (class 2606 OID 16840)
-- Name: scholarship_assignment scholarship_assignment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship_assignment
    ADD CONSTRAINT scholarship_assignment_pkey PRIMARY KEY (id);


--
-- TOC entry 3566 (class 2606 OID 16842)
-- Name: scholarship scholarship_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship
    ADD CONSTRAINT scholarship_pkey PRIMARY KEY (id);


--
-- TOC entry 3570 (class 2606 OID 16844)
-- Name: score score_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.score
    ADD CONSTRAINT score_pkey PRIMARY KEY (id);


--
-- TOC entry 3574 (class 2606 OID 16846)
-- Name: student_group student_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_group
    ADD CONSTRAINT student_group_pkey PRIMARY KEY (id);


--
-- TOC entry 3572 (class 2606 OID 16848)
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (id);


--
-- TOC entry 3576 (class 2606 OID 16850)
-- Name: teacher teacher_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher
    ADD CONSTRAINT teacher_pkey PRIMARY KEY (id);


--
-- TOC entry 3578 (class 2606 OID 16852)
-- Name: university_site university_site_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.university_site
    ADD CONSTRAINT university_site_pkey PRIMARY KEY (id);


--
-- TOC entry 3579 (class 2606 OID 16853)
-- Name: assessment fk_classroom; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assessment
    ADD CONSTRAINT fk_classroom FOREIGN KEY (classroom_id) REFERENCES public.classroom(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3587 (class 2606 OID 16858)
-- Name: educational_program fk_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educational_program
    ADD CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES public.course(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3596 (class 2606 OID 16863)
-- Name: student_group fk_curriculum; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_group
    ADD CONSTRAINT fk_curriculum FOREIGN KEY (curriculum_id) REFERENCES public.curriculum(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3597 (class 2606 OID 16873)
-- Name: teacher fk_department; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher
    ADD CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES public.department(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3588 (class 2606 OID 16951)
-- Name: educational_program fk_department; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educational_program
    ADD CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES public.department(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3585 (class 2606 OID 16878)
-- Name: edu_program_discipline fk_discipline; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edu_program_discipline
    ADD CONSTRAINT fk_discipline FOREIGN KEY (discipline_id) REFERENCES public.discipline(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3580 (class 2606 OID 16883)
-- Name: assessment fk_edu_program_discipline; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assessment
    ADD CONSTRAINT fk_edu_program_discipline FOREIGN KEY (edu_program_discipline_id) REFERENCES public.edu_program_discipline(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3591 (class 2606 OID 16888)
-- Name: score fk_edu_program_discipline; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.score
    ADD CONSTRAINT fk_edu_program_discipline FOREIGN KEY (edu_program_discipline_id) REFERENCES public.edu_program_discipline(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3583 (class 2606 OID 16893)
-- Name: curriculum fk_educational_program; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.curriculum
    ADD CONSTRAINT fk_educational_program FOREIGN KEY (educational_program_id) REFERENCES public.educational_program(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3586 (class 2606 OID 16898)
-- Name: edu_program_discipline fk_educational_program; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edu_program_discipline
    ADD CONSTRAINT fk_educational_program FOREIGN KEY (educational_program_id) REFERENCES public.educational_program(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3594 (class 2606 OID 16903)
-- Name: student fk_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT fk_person FOREIGN KEY (person_id) REFERENCES public.person(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3589 (class 2606 OID 16908)
-- Name: scholarship_assignment fk_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship_assignment
    ADD CONSTRAINT fk_person FOREIGN KEY (person_id) REFERENCES public.person(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3590 (class 2606 OID 16913)
-- Name: scholarship_assignment fk_scholarship; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship_assignment
    ADD CONSTRAINT fk_scholarship FOREIGN KEY (scholarship_id) REFERENCES public.scholarship(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3592 (class 2606 OID 16918)
-- Name: score fk_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.score
    ADD CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES public.student(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3595 (class 2606 OID 16923)
-- Name: student fk_student_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT fk_student_group FOREIGN KEY (student_group_id) REFERENCES public.student_group(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3581 (class 2606 OID 16928)
-- Name: assessment fk_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assessment
    ADD CONSTRAINT fk_teacher FOREIGN KEY (teacher_id) REFERENCES public.teacher(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3593 (class 2606 OID 16933)
-- Name: score fk_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.score
    ADD CONSTRAINT fk_teacher FOREIGN KEY (teacher_id) REFERENCES public.teacher(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3584 (class 2606 OID 16938)
-- Name: department fk_university_site; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT fk_university_site FOREIGN KEY (university_site_id) REFERENCES public.university_site(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3582 (class 2606 OID 16943)
-- Name: classroom fk_university_site; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classroom
    ADD CONSTRAINT fk_university_site FOREIGN KEY (university_site_id) REFERENCES public.university_site(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3774 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2023-05-15 12:38:24 MSK

--
-- PostgreSQL database dump complete
--

