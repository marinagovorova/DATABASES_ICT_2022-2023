--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-05-18 13:25:57

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
-- TOC entry 223 (class 1259 OID 16491)
-- Name: classrooms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.classrooms (
    classroom_id integer NOT NULL,
    building integer NOT NULL,
    number character varying(6) NOT NULL,
    capacity numeric NOT NULL,
    type character varying(20) NOT NULL,
    CONSTRAINT chk_type CHECK (((type)::text = ANY (ARRAY[('lection'::character varying)::text, ('lab'::character varying)::text, ('computer'::character varying)::text, ('lesson'::character varying)::text])))
);


ALTER TABLE public.classrooms OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 16679)
-- Name: classrooms_classroom_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.classrooms ALTER COLUMN classroom_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.classrooms_classroom_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 225 (class 1259 OID 16512)
-- Name: curriculum_discipline; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.curriculum_discipline (
    cur_id integer NOT NULL,
    discipline_id integer NOT NULL,
    curriculum_id integer NOT NULL
);


ALTER TABLE public.curriculum_discipline OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 16681)
-- Name: curriculum_discipline_cur_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.curriculum_discipline ALTER COLUMN cur_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.curriculum_discipline_cur_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 217 (class 1259 OID 16433)
-- Name: curriculums; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.curriculums (
    curriculum_id integer NOT NULL,
    educational_program integer NOT NULL,
    year date NOT NULL
);


ALTER TABLE public.curriculums OWNER TO postgres;

--
-- TOC entry 3532 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE curriculums; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.curriculums IS 'Учебный план';


--
-- TOC entry 240 (class 1259 OID 16677)
-- Name: curriculums_curriculum_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.curriculums ALTER COLUMN curriculum_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.curriculums_curriculum_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 216 (class 1259 OID 16418)
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    department_id integer NOT NULL,
    name character varying(80) NOT NULL,
    university_building integer NOT NULL
);


ALTER TABLE public.department OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16674)
-- Name: department_department_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.department ALTER COLUMN department_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.department_department_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 214 (class 1259 OID 16402)
-- Name: direction_of_preparation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.direction_of_preparation (
    direction_id integer NOT NULL,
    name character varying(120) NOT NULL,
    level_of_education character varying(20) NOT NULL
);


ALTER TABLE public.direction_of_preparation OWNER TO postgres;

--
-- TOC entry 3533 (class 0 OID 0)
-- Dependencies: 214
-- Name: TABLE direction_of_preparation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.direction_of_preparation IS 'Направление подготовки';


--
-- TOC entry 238 (class 1259 OID 16675)
-- Name: direction_of_preparation_direction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.direction_of_preparation ALTER COLUMN direction_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.direction_of_preparation_direction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 16503)
-- Name: disciplines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.disciplines (
    discipline_id integer NOT NULL,
    name character varying(120) NOT NULL,
    "study_hours_ALL" smallint DEFAULT '0'::smallint NOT NULL,
    study_hours_lectures smallint DEFAULT '0'::smallint NOT NULL,
    study_hours_pactices smallint DEFAULT '0'::smallint NOT NULL,
    study_hours_labs smallint DEFAULT '0'::smallint,
    practice character varying(80),
    control_type character varying(10) NOT NULL
);


ALTER TABLE public.disciplines OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16676)
-- Name: disciplines_discipline_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.disciplines ALTER COLUMN discipline_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.disciplines_discipline_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 215 (class 1259 OID 16407)
-- Name: educational_program; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.educational_program (
    program_id integer NOT NULL,
    name character varying(120) NOT NULL,
    department integer NOT NULL,
    direction_of_preparation integer NOT NULL
);


ALTER TABLE public.educational_program OWNER TO postgres;

--
-- TOC entry 3534 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE educational_program; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.educational_program IS 'Образовательная программа';


--
-- TOC entry 241 (class 1259 OID 16678)
-- Name: educational_program_program_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.educational_program ALTER COLUMN program_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.educational_program_program_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 227 (class 1259 OID 16540)
-- Name: group_distribution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_distribution (
    distribution_id integer NOT NULL,
    "group" integer NOT NULL,
    student integer NOT NULL,
    basis character varying(20) NOT NULL
);


ALTER TABLE public.group_distribution OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16680)
-- Name: group_distribution_distribution_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.group_distribution ALTER COLUMN distribution_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.group_distribution_distribution_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 226 (class 1259 OID 16529)
-- Name: groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groups (
    group_id integer NOT NULL,
    number character varying(8) NOT NULL,
    curriculum integer NOT NULL,
    date_on date NOT NULL,
    date_off date
);


ALTER TABLE public.groups OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16673)
-- Name: groups_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.groups ALTER COLUMN group_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.groups_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 229 (class 1259 OID 16585)
-- Name: midterm_examination; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.midterm_examination (
    examination_id integer NOT NULL,
    curriculum_discipline integer NOT NULL,
    student integer NOT NULL,
    teacher integer NOT NULL,
    classroom integer NOT NULL,
    date date NOT NULL,
    number_try smallint NOT NULL,
    "grade " smallint NOT NULL
);


ALTER TABLE public.midterm_examination OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 16682)
-- Name: midterm_examination_examination_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.midterm_examination ALTER COLUMN examination_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.midterm_examination_examination_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 16474)
-- Name: scholarship; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scholarship (
    scholarship_id integer NOT NULL,
    student integer NOT NULL,
    scholarship_type integer NOT NULL,
    date_on date NOT NULL,
    date_off date NOT NULL
);


ALTER TABLE public.scholarship OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16672)
-- Name: scholarship_scholarship_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.scholarship ALTER COLUMN scholarship_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.scholarship_scholarship_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 221 (class 1259 OID 16469)
-- Name: scholarship_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scholarship_types (
    type_id integer NOT NULL,
    name character varying(120) NOT NULL,
    financing character varying(120) NOT NULL,
    distribution_type character varying(120) NOT NULL,
    budget integer NOT NULL
);


ALTER TABLE public.scholarship_types OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16671)
-- Name: scholarship_types_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.scholarship_types ALTER COLUMN type_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.scholarship_types_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 16557)
-- Name: session_schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.session_schedule (
    schedule_id integer NOT NULL,
    classroom integer NOT NULL,
    "group" integer NOT NULL,
    curriculum_discipline integer NOT NULL,
    teacher integer NOT NULL,
    meeting_type character varying(15) NOT NULL,
    date date NOT NULL,
    "time" time without time zone NOT NULL
);


ALTER TABLE public.session_schedule OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16670)
-- Name: session_schedule_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.session_schedule ALTER COLUMN schedule_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.session_schedule_schedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 16462)
-- Name: students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.students (
    student_id integer NOT NULL,
    name character varying(120) NOT NULL,
    surname character varying(120) NOT NULL,
    patronymic character varying(120),
    year_of_admission date NOT NULL,
    dob date NOT NULL,
    citizenship character varying(120) NOT NULL,
    passport bigint NOT NULL,
    additional_passport_data character varying(120),
    status character varying(80) NOT NULL
);


ALTER TABLE public.students OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16669)
-- Name: students_student_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.students ALTER COLUMN student_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.students_student_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 219 (class 1259 OID 16455)
-- Name: teachers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teachers (
    teacher_id integer NOT NULL,
    name character varying(120) NOT NULL,
    surname character varying(120) NOT NULL,
    patronymic character varying(120),
    post character varying(80) NOT NULL,
    academic_degree character varying(80),
    year_of_employment date NOT NULL,
    citizenship character varying(120) NOT NULL,
    passport bigint NOT NULL,
    additional_passport_data character varying(120)
);


ALTER TABLE public.teachers OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16666)
-- Name: teachers_teacher_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.teachers ALTER COLUMN teacher_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.teachers_teacher_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 16444)
-- Name: university_buildings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.university_buildings (
    building_id integer NOT NULL,
    name character varying(120) NOT NULL,
    region character varying(80) NOT NULL,
    city character varying(80) NOT NULL,
    adress character varying(120) NOT NULL,
    time_open time without time zone NOT NULL,
    time_close time without time zone NOT NULL
);


ALTER TABLE public.university_buildings OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16658)
-- Name: university_buildings_building_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.university_buildings ALTER COLUMN building_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.university_buildings_building_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3504 (class 0 OID 16491)
-- Dependencies: 223
-- Data for Name: classrooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.classrooms OVERRIDING SYSTEM VALUE VALUES (1, 10, '103a', 210, 'lection');
INSERT INTO public.classrooms OVERRIDING SYSTEM VALUE VALUES (2, 11, '1123', 210, 'lection');
INSERT INTO public.classrooms OVERRIDING SYSTEM VALUE VALUES (3, 12, '356b', 50, 'lab');
INSERT INTO public.classrooms OVERRIDING SYSTEM VALUE VALUES (4, 11, '1342', 20, 'lab');
INSERT INTO public.classrooms OVERRIDING SYSTEM VALUE VALUES (5, 13, '112', 40, 'lab');


--
-- TOC entry 3506 (class 0 OID 16512)
-- Dependencies: 225
-- Data for Name: curriculum_discipline; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.curriculum_discipline OVERRIDING SYSTEM VALUE VALUES (1, 2, 16);
INSERT INTO public.curriculum_discipline OVERRIDING SYSTEM VALUE VALUES (2, 1, 17);
INSERT INTO public.curriculum_discipline OVERRIDING SYSTEM VALUE VALUES (3, 1, 18);
INSERT INTO public.curriculum_discipline OVERRIDING SYSTEM VALUE VALUES (4, 3, 19);
INSERT INTO public.curriculum_discipline OVERRIDING SYSTEM VALUE VALUES (5, 4, 20);
INSERT INTO public.curriculum_discipline OVERRIDING SYSTEM VALUE VALUES (6, 4, 21);
INSERT INTO public.curriculum_discipline OVERRIDING SYSTEM VALUE VALUES (7, 2, 22);


--
-- TOC entry 3498 (class 0 OID 16433)
-- Dependencies: 217
-- Data for Name: curriculums; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.curriculums OVERRIDING SYSTEM VALUE VALUES (16, 15, '2022-09-01');
INSERT INTO public.curriculums OVERRIDING SYSTEM VALUE VALUES (17, 2, '2022-09-01');
INSERT INTO public.curriculums OVERRIDING SYSTEM VALUE VALUES (18, 16, '2020-09-01');
INSERT INTO public.curriculums OVERRIDING SYSTEM VALUE VALUES (19, 18, '2021-09-01');
INSERT INTO public.curriculums OVERRIDING SYSTEM VALUE VALUES (20, 20, '2021-09-01');
INSERT INTO public.curriculums OVERRIDING SYSTEM VALUE VALUES (21, 21, '2021-09-01');
INSERT INTO public.curriculums OVERRIDING SYSTEM VALUE VALUES (22, 25, '2021-09-01');


--
-- TOC entry 3497 (class 0 OID 16418)
-- Dependencies: 216
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.department OVERRIDING SYSTEM VALUE VALUES (9, 'ИКТ', 10);
INSERT INTO public.department OVERRIDING SYSTEM VALUE VALUES (10, 'СУИР', 12);
INSERT INTO public.department OVERRIDING SYSTEM VALUE VALUES (11, 'КТ', 13);
INSERT INTO public.department OVERRIDING SYSTEM VALUE VALUES (12, 'РСМ', 11);


--
-- TOC entry 3495 (class 0 OID 16402)
-- Dependencies: 214
-- Data for Name: direction_of_preparation; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.direction_of_preparation OVERRIDING SYSTEM VALUE VALUES (1, 'ваыолаолара', 'бакалавриат');
INSERT INTO public.direction_of_preparation OVERRIDING SYSTEM VALUE VALUES (2, 'Мвыавав', 'бакалавриат');
INSERT INTO public.direction_of_preparation OVERRIDING SYSTEM VALUE VALUES (3, 'укеукук', 'магистратура');
INSERT INTO public.direction_of_preparation OVERRIDING SYSTEM VALUE VALUES (4, 'лутыцй', 'аспирантура');


--
-- TOC entry 3505 (class 0 OID 16503)
-- Dependencies: 224
-- Data for Name: disciplines; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.disciplines OVERRIDING SYSTEM VALUE VALUES (1, 'БД', 140, 40, 50, 0, NULL, 'экзамен');
INSERT INTO public.disciplines OVERRIDING SYSTEM VALUE VALUES (2, 'Матаматика', 140, 40, 50, 0, NULL, 'экзамен');
INSERT INTO public.disciplines OVERRIDING SYSTEM VALUE VALUES (3, 'Физика', 140, 40, 50, 0, NULL, 'экзамен');
INSERT INTO public.disciplines OVERRIDING SYSTEM VALUE VALUES (4, 'ООП', 140, 40, 50, 0, NULL, 'экзамен');
INSERT INTO public.disciplines OVERRIDING SYSTEM VALUE VALUES (5, 'Программирование', 140, 40, 50, 0, NULL, 'зачёт');


--
-- TOC entry 3496 (class 0 OID 16407)
-- Dependencies: 215
-- Data for Name: educational_program; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.educational_program OVERRIDING SYSTEM VALUE VALUES (2, 'мобилки', 10, 2);
INSERT INTO public.educational_program OVERRIDING SYSTEM VALUE VALUES (15, 'оарыловарылрыа', 11, 4);
INSERT INTO public.educational_program OVERRIDING SYSTEM VALUE VALUES (16, 'ааыра', 10, 4);
INSERT INTO public.educational_program OVERRIDING SYSTEM VALUE VALUES (17, 'аааааа', 11, 3);
INSERT INTO public.educational_program OVERRIDING SYSTEM VALUE VALUES (18, 'ммммм', 12, 2);
INSERT INTO public.educational_program OVERRIDING SYSTEM VALUE VALUES (19, 'ррррррр', 10, 1);
INSERT INTO public.educational_program OVERRIDING SYSTEM VALUE VALUES (20, 'аварыврвавлоаыло', 10, 1);
INSERT INTO public.educational_program OVERRIDING SYSTEM VALUE VALUES (21, 'авававава', 11, 2);
INSERT INTO public.educational_program OVERRIDING SYSTEM VALUE VALUES (22, 'мвмвмвм', 12, 4);
INSERT INTO public.educational_program OVERRIDING SYSTEM VALUE VALUES (23, 'чаыып', 10, 4);
INSERT INTO public.educational_program OVERRIDING SYSTEM VALUE VALUES (24, 'авац', 11, 3);
INSERT INTO public.educational_program OVERRIDING SYSTEM VALUE VALUES (25, 'итмем', 12, 2);
INSERT INTO public.educational_program OVERRIDING SYSTEM VALUE VALUES (26, 'мемомо', 10, 1);


--
-- TOC entry 3508 (class 0 OID 16540)
-- Dependencies: 227
-- Data for Name: group_distribution; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.group_distribution OVERRIDING SYSTEM VALUE VALUES (1, 9, 1, 'бюджет');
INSERT INTO public.group_distribution OVERRIDING SYSTEM VALUE VALUES (2, 9, 2, 'бюджет');
INSERT INTO public.group_distribution OVERRIDING SYSTEM VALUE VALUES (3, 9, 3, 'бюджет');
INSERT INTO public.group_distribution OVERRIDING SYSTEM VALUE VALUES (4, 9, 4, 'бюджет');
INSERT INTO public.group_distribution OVERRIDING SYSTEM VALUE VALUES (5, 9, 5, 'бюджет');
INSERT INTO public.group_distribution OVERRIDING SYSTEM VALUE VALUES (6, 9, 6, 'бюджет');
INSERT INTO public.group_distribution OVERRIDING SYSTEM VALUE VALUES (7, 9, 7, 'бюджет');
INSERT INTO public.group_distribution OVERRIDING SYSTEM VALUE VALUES (8, 9, 1, 'бюджет');
INSERT INTO public.group_distribution OVERRIDING SYSTEM VALUE VALUES (9, 9, 1, 'бюджет');
INSERT INTO public.group_distribution OVERRIDING SYSTEM VALUE VALUES (10, 9, 1, 'бюджет');
INSERT INTO public.group_distribution OVERRIDING SYSTEM VALUE VALUES (11, 9, 1, 'бюджет');
INSERT INTO public.group_distribution OVERRIDING SYSTEM VALUE VALUES (12, 11, 9, 'контракт');
INSERT INTO public.group_distribution OVERRIDING SYSTEM VALUE VALUES (13, 10, 10, 'коммерция');
INSERT INTO public.group_distribution OVERRIDING SYSTEM VALUE VALUES (14, 12, 8, 'коммерция');


--
-- TOC entry 3507 (class 0 OID 16529)
-- Dependencies: 226
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.groups OVERRIDING SYSTEM VALUE VALUES (9, 'ИУ522', 16, '2020-09-01', '2024-06-30');
INSERT INTO public.groups OVERRIDING SYSTEM VALUE VALUES (10, 'ИУ721', 17, '2021-09-01', '2025-06-30');
INSERT INTO public.groups OVERRIDING SYSTEM VALUE VALUES (11, 'ПМ420', 18, '2020-09-01', '2024-06-30');
INSERT INTO public.groups OVERRIDING SYSTEM VALUE VALUES (12, 'БИ123', 19, '2021-09-01', '2025-06-30');


--
-- TOC entry 3510 (class 0 OID 16585)
-- Dependencies: 229
-- Data for Name: midterm_examination; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.midterm_examination OVERRIDING SYSTEM VALUE VALUES (1, 1, 1, 8, 1, '2023-05-25', 1, 85);
INSERT INTO public.midterm_examination OVERRIDING SYSTEM VALUE VALUES (2, 2, 2, 9, 2, '2023-05-26', 1, 92);
INSERT INTO public.midterm_examination OVERRIDING SYSTEM VALUE VALUES (3, 3, 3, 10, 3, '2023-05-27', 1, 78);
INSERT INTO public.midterm_examination OVERRIDING SYSTEM VALUE VALUES (4, 4, 4, 11, 4, '2023-05-28', 1, 88);
INSERT INTO public.midterm_examination OVERRIDING SYSTEM VALUE VALUES (5, 5, 5, 8, 5, '2023-05-29', 1, 95);
INSERT INTO public.midterm_examination OVERRIDING SYSTEM VALUE VALUES (6, 6, 6, 9, 1, '2023-05-30', 1, 83);
INSERT INTO public.midterm_examination OVERRIDING SYSTEM VALUE VALUES (7, 7, 7, 10, 2, '2023-05-31', 1, 90);
INSERT INTO public.midterm_examination OVERRIDING SYSTEM VALUE VALUES (8, 1, 8, 11, 3, '2023-06-01', 1, 87);
INSERT INTO public.midterm_examination OVERRIDING SYSTEM VALUE VALUES (9, 2, 9, 8, 4, '2023-06-02', 1, 91);
INSERT INTO public.midterm_examination OVERRIDING SYSTEM VALUE VALUES (10, 3, 10, 9, 5, '2023-06-03', 1, 79);


--
-- TOC entry 3503 (class 0 OID 16474)
-- Dependencies: 222
-- Data for Name: scholarship; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.scholarship OVERRIDING SYSTEM VALUE VALUES (1, 1, 2, '2022-01-01', '2022-06-30');
INSERT INTO public.scholarship OVERRIDING SYSTEM VALUE VALUES (2, 2, 3, '2022-02-01', '2022-07-31');
INSERT INTO public.scholarship OVERRIDING SYSTEM VALUE VALUES (3, 3, 1, '2022-03-01', '2022-08-31');
INSERT INTO public.scholarship OVERRIDING SYSTEM VALUE VALUES (4, 4, 2, '2022-04-01', '2022-09-30');
INSERT INTO public.scholarship OVERRIDING SYSTEM VALUE VALUES (5, 5, 5, '2022-05-01', '2022-10-31');
INSERT INTO public.scholarship OVERRIDING SYSTEM VALUE VALUES (6, 6, 1, '2022-06-01', '2022-11-30');
INSERT INTO public.scholarship OVERRIDING SYSTEM VALUE VALUES (7, 7, 2, '2022-07-01', '2022-12-31');
INSERT INTO public.scholarship OVERRIDING SYSTEM VALUE VALUES (8, 8, 3, '2023-01-01', '2023-06-30');
INSERT INTO public.scholarship OVERRIDING SYSTEM VALUE VALUES (9, 9, 6, '2023-02-01', '2023-07-31');
INSERT INTO public.scholarship OVERRIDING SYSTEM VALUE VALUES (10, 10, 4, '2023-03-01', '2023-08-31');


--
-- TOC entry 3502 (class 0 OID 16469)
-- Dependencies: 221
-- Data for Name: scholarship_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.scholarship_types OVERRIDING SYSTEM VALUE VALUES (1, 'Социальная', 'Государственное', 'Равномерно', 1000000);
INSERT INTO public.scholarship_types OVERRIDING SYSTEM VALUE VALUES (2, 'Научная', 'Государственное', 'Конкурс', 1000000);
INSERT INTO public.scholarship_types OVERRIDING SYSTEM VALUE VALUES (3, 'Спортивная', 'Государственное', 'Критериально', 1000000);
INSERT INTO public.scholarship_types OVERRIDING SYSTEM VALUE VALUES (4, 'Творческая', 'Государственное', 'Комиссия', 4000000);
INSERT INTO public.scholarship_types OVERRIDING SYSTEM VALUE VALUES (5, 'Стимулирующая', 'Государственное', 'Равномерное', 4000000);
INSERT INTO public.scholarship_types OVERRIDING SYSTEM VALUE VALUES (6, 'Социальная', 'Частное', 'Равномерное', 4000000);
INSERT INTO public.scholarship_types OVERRIDING SYSTEM VALUE VALUES (7, 'Научная', 'Частное', 'Конкурс', 4000000);
INSERT INTO public.scholarship_types OVERRIDING SYSTEM VALUE VALUES (8, 'Спортивная', 'Частное', 'Критериально', 4000000);
INSERT INTO public.scholarship_types OVERRIDING SYSTEM VALUE VALUES (9, 'Творческая', 'Частное', 'Комиссия', 4000000);
INSERT INTO public.scholarship_types OVERRIDING SYSTEM VALUE VALUES (10, 'Стимулирующая', 'Частное', 'Равномерное', 4000000);


--
-- TOC entry 3509 (class 0 OID 16557)
-- Dependencies: 228
-- Data for Name: session_schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.session_schedule OVERRIDING SYSTEM VALUE VALUES (6, 1, 9, 1, 8, 'лекция', '2023-05-20', '09:00:00');
INSERT INTO public.session_schedule OVERRIDING SYSTEM VALUE VALUES (7, 2, 10, 2, 9, 'практика', '2023-05-21', '11:00:00');
INSERT INTO public.session_schedule OVERRIDING SYSTEM VALUE VALUES (8, 3, 11, 3, 10, 'лабораторная', '2023-05-22', '13:00:00');
INSERT INTO public.session_schedule OVERRIDING SYSTEM VALUE VALUES (9, 4, 12, 4, 11, 'консультация', '2023-05-23', '09:00:00');
INSERT INTO public.session_schedule OVERRIDING SYSTEM VALUE VALUES (20, 1, 9, 1, 8, 'лекция', '2023-05-20', '09:00:00');
INSERT INTO public.session_schedule OVERRIDING SYSTEM VALUE VALUES (21, 2, 10, 2, 9, 'практика', '2023-05-21', '11:00:00');
INSERT INTO public.session_schedule OVERRIDING SYSTEM VALUE VALUES (22, 3, 11, 3, 10, 'лабораторная', '2023-05-22', '13:00:00');
INSERT INTO public.session_schedule OVERRIDING SYSTEM VALUE VALUES (23, 4, 12, 4, 11, 'консультация', '2023-05-23', '09:00:00');
INSERT INTO public.session_schedule OVERRIDING SYSTEM VALUE VALUES (24, 2, 10, 2, 9, 'зачет', '2023-05-21', '11:00:00');
INSERT INTO public.session_schedule OVERRIDING SYSTEM VALUE VALUES (25, 3, 11, 3, 10, 'консультация', '2023-05-22', '13:00:00');
INSERT INTO public.session_schedule OVERRIDING SYSTEM VALUE VALUES (26, 4, 12, 4, 11, 'экзамен', '2023-05-23', '09:00:00');


--
-- TOC entry 3501 (class 0 OID 16462)
-- Dependencies: 220
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (1, 'Иван', 'Иванов', 'Иванович', '2020-09-01', '2002-05-15', 'Россия', 1234567890, 'выдан 01.02.2018', 'стулент');
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (2, 'Петр', 'Петров', 'Петрович', '2020-09-01', '2002-01-25', 'Россия', 4321098765, 'выдан 01.02.2018', 'стулент');
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (3, 'Анна', 'Сидорова', 'Ивановна', '2020-09-01', '2001-10-03', 'Россия', 5678123456, 'выдан 01.02.2018', 'стулент');
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (4, 'Максим', 'Козлов', 'Петрович', '2020-09-01', '2003-06-12', 'Россия', 8765432109, 'выдан 01.02.2018', 'стулент');
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (5, 'Дарья', 'Михайлова', 'Олеговна', '2020-09-01', '2002-11-27', 'Россия', 2345678901, 'выдан 01.02.2018', 'стулент');
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (6, 'Сергей', 'Николаев', 'Иванович', '2020-09-01', '2001-02-20', 'Россия', 6789012345, 'выдан 01.02.2018', 'стулент');
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (7, 'Алиса', 'Ковалева', 'Дмитриевна', '2020-09-01', '2001-06-18', 'Россия', 3456789012, 'выдан 01.02.2018', 'стулент');
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (8, 'Георгий', 'Федоров', 'Сергеевич', '2020-09-01', '2002-08-30', 'Россия', 8901234567, 'выдан 01.02.2018', 'стулент');
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (9, 'Алексей', 'Лебедев', 'Максимович', '2020-09-01', '2003-04-05', 'Россия', 4567890123, 'выдан 01.02.2018', 'стулент');
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (10, 'Виктория', 'Егорова', 'Александровна', '2020-09-01', '2002-03-17', 'Россия', 9012345678, 'выдан 01.02.2018', 'стулент');


--
-- TOC entry 3500 (class 0 OID 16455)
-- Dependencies: 219
-- Data for Name: teachers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.teachers OVERRIDING SYSTEM VALUE VALUES (8, 'Иван', 'Иванов', 'Иванович', 'Профессор', 'Доктор наук', '2001-09-01', 'Россия', 1111111111, 'Выдан 01.01.2010 г.');
INSERT INTO public.teachers OVERRIDING SYSTEM VALUE VALUES (9, 'Петр', 'Петров', 'Петрович', 'Доцент', 'Кандидат наук', '2010-09-01', 'Россия', 2222222222, 'Выдан 01.01.2015 г.');
INSERT INTO public.teachers OVERRIDING SYSTEM VALUE VALUES (10, 'Анна', 'Сидорова', 'Александровна', 'Старший преподаватель', 'Кандидат наук', '2015-09-01', 'Россия', 3333333333, 'Выдан 01.01.2020 г.');
INSERT INTO public.teachers OVERRIDING SYSTEM VALUE VALUES (11, 'Алексей', 'Козлов', 'Владимирович', 'Ассистент', 'Кандидат наук', '2020-09-01', 'Россия', 4444444444, 'Выдан 01.01.2025 г.');


--
-- TOC entry 3499 (class 0 OID 16444)
-- Dependencies: 218
-- Data for Name: university_buildings; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.university_buildings OVERRIDING SYSTEM VALUE VALUES (10, 'Главный корпус', 'Ленинградская область', 'СанктПетербург', 'Кронверкский проспект, 49', '08:00:00', '23:00:00');
INSERT INTO public.university_buildings OVERRIDING SYSTEM VALUE VALUES (11, 'Корпус на Кронверкском', 'Ленинградская область', 'Санкт-Петербург', 'Кронверкский проспект, 49', '08:00:00', '23:00:00');
INSERT INTO public.university_buildings OVERRIDING SYSTEM VALUE VALUES (12, 'Корпус на Ломоносова', 'Ленинградская область', 'Санкт-Петербург', 'Университетский проспект, 9', '09:00:00', '22:00:00');
INSERT INTO public.university_buildings OVERRIDING SYSTEM VALUE VALUES (13, 'Корпус на Малой Морской', 'Ленинградская область', 'Санкт-Петербург', 'Малая Морская улица, 22', '09:00:00', '22:00:00');


--
-- TOC entry 3535 (class 0 OID 0)
-- Dependencies: 242
-- Name: classrooms_classroom_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.classrooms_classroom_id_seq', 5, true);


--
-- TOC entry 3536 (class 0 OID 0)
-- Dependencies: 244
-- Name: curriculum_discipline_cur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.curriculum_discipline_cur_id_seq', 7, true);


--
-- TOC entry 3537 (class 0 OID 0)
-- Dependencies: 240
-- Name: curriculums_curriculum_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.curriculums_curriculum_id_seq', 22, true);


--
-- TOC entry 3538 (class 0 OID 0)
-- Dependencies: 237
-- Name: department_department_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.department_department_id_seq', 12, true);


--
-- TOC entry 3539 (class 0 OID 0)
-- Dependencies: 238
-- Name: direction_of_preparation_direction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.direction_of_preparation_direction_id_seq', 4, true);


--
-- TOC entry 3540 (class 0 OID 0)
-- Dependencies: 239
-- Name: disciplines_discipline_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.disciplines_discipline_id_seq', 5, true);


--
-- TOC entry 3541 (class 0 OID 0)
-- Dependencies: 241
-- Name: educational_program_program_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.educational_program_program_id_seq', 26, true);


--
-- TOC entry 3542 (class 0 OID 0)
-- Dependencies: 243
-- Name: group_distribution_distribution_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.group_distribution_distribution_id_seq', 14, true);


--
-- TOC entry 3543 (class 0 OID 0)
-- Dependencies: 236
-- Name: groups_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.groups_group_id_seq', 12, true);


--
-- TOC entry 3544 (class 0 OID 0)
-- Dependencies: 245
-- Name: midterm_examination_examination_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.midterm_examination_examination_id_seq', 10, true);


--
-- TOC entry 3545 (class 0 OID 0)
-- Dependencies: 235
-- Name: scholarship_scholarship_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.scholarship_scholarship_id_seq', 10, true);


--
-- TOC entry 3546 (class 0 OID 0)
-- Dependencies: 234
-- Name: scholarship_types_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.scholarship_types_type_id_seq', 10, true);


--
-- TOC entry 3547 (class 0 OID 0)
-- Dependencies: 233
-- Name: session_schedule_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.session_schedule_schedule_id_seq', 26, true);


--
-- TOC entry 3548 (class 0 OID 0)
-- Dependencies: 232
-- Name: students_student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.students_student_id_seq', 10, true);


--
-- TOC entry 3549 (class 0 OID 0)
-- Dependencies: 231
-- Name: teachers_teacher_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teachers_teacher_id_seq', 11, true);


--
-- TOC entry 3550 (class 0 OID 0)
-- Dependencies: 230
-- Name: university_buildings_building_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.university_buildings_building_id_seq', 13, true);


--
-- TOC entry 3312 (class 2606 OID 16497)
-- Name: classrooms Classrooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classrooms
    ADD CONSTRAINT "Classrooms_pkey" PRIMARY KEY (classroom_id);


--
-- TOC entry 3316 (class 2606 OID 16516)
-- Name: curriculum_discipline Curriculum_discipline_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.curriculum_discipline
    ADD CONSTRAINT "Curriculum_discipline_pkey" PRIMARY KEY (cur_id);


--
-- TOC entry 3297 (class 2606 OID 16437)
-- Name: curriculums Curriculum_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.curriculums
    ADD CONSTRAINT "Curriculum_pkey" PRIMARY KEY (curriculum_id);


--
-- TOC entry 3294 (class 2606 OID 16422)
-- Name: department Department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT "Department_pkey" PRIMARY KEY (department_id);


--
-- TOC entry 3288 (class 2606 OID 16406)
-- Name: direction_of_preparation Direction_of_preparation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.direction_of_preparation
    ADD CONSTRAINT "Direction_of_preparation_pkey" PRIMARY KEY (direction_id);


--
-- TOC entry 3314 (class 2606 OID 16511)
-- Name: disciplines Disciplines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplines
    ADD CONSTRAINT "Disciplines_pkey" PRIMARY KEY (discipline_id);


--
-- TOC entry 3290 (class 2606 OID 16411)
-- Name: educational_program Educational program_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educational_program
    ADD CONSTRAINT "Educational program_pkey" PRIMARY KEY (program_id);


--
-- TOC entry 3323 (class 2606 OID 16544)
-- Name: group_distribution Group_distribution_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_distribution
    ADD CONSTRAINT "Group_distribution_pkey" PRIMARY KEY (distribution_id);


--
-- TOC entry 3320 (class 2606 OID 16533)
-- Name: groups Groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT "Groups_pkey" PRIMARY KEY (group_id);


--
-- TOC entry 3332 (class 2606 OID 16589)
-- Name: midterm_examination Midterm_examination_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.midterm_examination
    ADD CONSTRAINT "Midterm_examination_pkey" PRIMARY KEY (examination_id);


--
-- TOC entry 3308 (class 2606 OID 16478)
-- Name: scholarship Scholarship_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship
    ADD CONSTRAINT "Scholarship_pkey" PRIMARY KEY (scholarship_id);


--
-- TOC entry 3306 (class 2606 OID 16473)
-- Name: scholarship_types Scholarship_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship_types
    ADD CONSTRAINT "Scholarship_types_pkey" PRIMARY KEY (type_id);


--
-- TOC entry 3327 (class 2606 OID 16561)
-- Name: session_schedule Session_schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session_schedule
    ADD CONSTRAINT "Session_schedule_pkey" PRIMARY KEY (schedule_id);


--
-- TOC entry 3304 (class 2606 OID 16468)
-- Name: students Students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT "Students_pkey" PRIMARY KEY (student_id);


--
-- TOC entry 3302 (class 2606 OID 16461)
-- Name: teachers Teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT "Teachers_pkey" PRIMARY KEY (teacher_id);


--
-- TOC entry 3300 (class 2606 OID 16448)
-- Name: university_buildings University_buildings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.university_buildings
    ADD CONSTRAINT "University_buildings_pkey" PRIMARY KEY (building_id);


--
-- TOC entry 3278 (class 2606 OID 16611)
-- Name: classrooms capacity; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.classrooms
    ADD CONSTRAINT capacity CHECK (((capacity > (0)::numeric) AND (capacity < (3000)::numeric))) NOT VALID;


--
-- TOC entry 3262 (class 2606 OID 16667)
-- Name: teachers chk_academic_degree; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.teachers
    ADD CONSTRAINT chk_academic_degree CHECK (((academic_degree)::text ~ '^[а-яА-Я0-9 -]*$'::text)) NOT VALID;


--
-- TOC entry 3257 (class 2606 OID 16664)
-- Name: university_buildings chk_adress; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.university_buildings
    ADD CONSTRAINT chk_adress CHECK (((adress)::text ~ '^[а-яА-Я0-9,.|\/ -]*$'::text)) NOT VALID;


--
-- TOC entry 3285 (class 2606 OID 16622)
-- Name: group_distribution chk_basis; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.group_distribution
    ADD CONSTRAINT chk_basis CHECK (((basis)::text = ANY (ARRAY[('бюджет'::character varying)::text, ('коммерция'::character varying)::text, ('контракт'::character varying)::text]))) NOT VALID;


--
-- TOC entry 3263 (class 2606 OID 16644)
-- Name: teachers chk_citizenship; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.teachers
    ADD CONSTRAINT chk_citizenship CHECK (((citizenship)::text ~ '^[а-яА-Я0-9]*$'::text)) NOT VALID;


--
-- TOC entry 3258 (class 2606 OID 16665)
-- Name: university_buildings chk_city; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.university_buildings
    ADD CONSTRAINT chk_city CHECK (((city)::text ~ '^[а-яА-Я0-9,.|\/ --_ ]*$'::text)) NOT VALID;


--
-- TOC entry 3280 (class 2606 OID 16620)
-- Name: disciplines chk_control_type; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.disciplines
    ADD CONSTRAINT chk_control_type CHECK (((control_type)::text = ANY (ARRAY[('зачёт'::character varying)::text, ('экзамен'::character varying)::text, ('дифюзачёт'::character varying)::text]))) NOT VALID;


--
-- TOC entry 3283 (class 2606 OID 16627)
-- Name: groups chk_date; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.groups
    ADD CONSTRAINT chk_date CHECK ((date_on <= date_off)) NOT VALID;


--
-- TOC entry 3277 (class 2606 OID 16628)
-- Name: scholarship chk_date; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.scholarship
    ADD CONSTRAINT chk_date CHECK ((date_on <= date_off)) NOT VALID;


--
-- TOC entry 3274 (class 2606 OID 16631)
-- Name: scholarship_types chk_dist_type; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.scholarship_types
    ADD CONSTRAINT chk_dist_type CHECK (((distribution_type)::text ~ '^[а-яА-Я0-9]*$'::text)) NOT VALID;


--
-- TOC entry 3275 (class 2606 OID 16630)
-- Name: scholarship_types chk_fin; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.scholarship_types
    ADD CONSTRAINT chk_fin CHECK (((financing)::text ~ '^[а-яА-Я0-9]*$'::text)) NOT VALID;


--
-- TOC entry 3252 (class 2606 OID 16615)
-- Name: direction_of_preparation chk_level; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.direction_of_preparation
    ADD CONSTRAINT chk_level CHECK (((level_of_education)::text = ANY (ARRAY[('бакалавриат'::character varying)::text, ('магистратура'::character varying)::text, ('аспирантура'::character varying)::text]))) NOT VALID;


--
-- TOC entry 3286 (class 2606 OID 16632)
-- Name: session_schedule chk_meet; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.session_schedule
    ADD CONSTRAINT chk_meet CHECK (((meeting_type)::text ~ '^[а-яА-Я0-9]*$'::text)) NOT VALID;


--
-- TOC entry 3255 (class 2606 OID 16613)
-- Name: department chk_name; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.department
    ADD CONSTRAINT chk_name CHECK (((name)::text ~ '^[а-яА-Я0-9]*$'::text)) NOT VALID;


--
-- TOC entry 3253 (class 2606 OID 16614)
-- Name: direction_of_preparation chk_name; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.direction_of_preparation
    ADD CONSTRAINT chk_name CHECK (((name)::text ~ '^[а-яА-Я0-9]*$'::text)) NOT VALID;


--
-- TOC entry 3281 (class 2606 OID 16616)
-- Name: disciplines chk_name; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.disciplines
    ADD CONSTRAINT chk_name CHECK (((name)::text ~ '^[а-яА-Я0-9]*$'::text)) NOT VALID;


--
-- TOC entry 3254 (class 2606 OID 16621)
-- Name: educational_program chk_name; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.educational_program
    ADD CONSTRAINT chk_name CHECK (((name)::text ~ '^[а-яА-Я0-9]*$'::text)) NOT VALID;


--
-- TOC entry 3276 (class 2606 OID 16629)
-- Name: scholarship_types chk_name; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.scholarship_types
    ADD CONSTRAINT chk_name CHECK (((name)::text ~ '^[а-яА-Я0-9]*$'::text)) NOT VALID;


--
-- TOC entry 3269 (class 2606 OID 16633)
-- Name: students chk_name; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.students
    ADD CONSTRAINT chk_name CHECK (((name)::text ~ '^[а-яА-Яa-zA-Z]*$'::text)) NOT VALID;


--
-- TOC entry 3264 (class 2606 OID 16638)
-- Name: teachers chk_name; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.teachers
    ADD CONSTRAINT chk_name CHECK (((name)::text ~ '^[а-яА-Яa-zA-Z]*$'::text)) NOT VALID;


--
-- TOC entry 3259 (class 2606 OID 16663)
-- Name: university_buildings chk_name; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.university_buildings
    ADD CONSTRAINT chk_name CHECK (((name)::text ~ '^[а-яА-Я0-9,.|\/  -]*$'::text)) NOT VALID;


--
-- TOC entry 3284 (class 2606 OID 16626)
-- Name: groups chk_number; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.groups
    ADD CONSTRAINT chk_number CHECK (((number)::text ~ '^[а-яА-Я0-9]*$'::text)) NOT VALID;


--
-- TOC entry 3270 (class 2606 OID 16635)
-- Name: students chk_patr; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.students
    ADD CONSTRAINT chk_patr CHECK (((patronymic)::text ~ '^[а-яА-Яa-zA-Z]*$'::text)) NOT VALID;


--
-- TOC entry 3265 (class 2606 OID 16640)
-- Name: teachers chk_patr; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.teachers
    ADD CONSTRAINT chk_patr CHECK (((patronymic)::text ~ '^[а-яА-Яa-zA-Z]*$'::text)) NOT VALID;


--
-- TOC entry 3266 (class 2606 OID 16668)
-- Name: teachers chk_post; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.teachers
    ADD CONSTRAINT chk_post CHECK (((post)::text ~ '^[а-яА-Я0-9 -]*$'::text)) NOT VALID;


--
-- TOC entry 3282 (class 2606 OID 16619)
-- Name: disciplines chk_practice; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.disciplines
    ADD CONSTRAINT chk_practice CHECK (((practice)::text = ANY (ARRAY[('учебная'::character varying)::text, ('производственная'::character varying)::text, ('ознакомительная'::character varying)::text, ('научная'::character varying)::text]))) NOT VALID;


--
-- TOC entry 3260 (class 2606 OID 16662)
-- Name: university_buildings chk_region; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.university_buildings
    ADD CONSTRAINT chk_region CHECK (((region)::text ~ '^[а-яА-Я0-9,.|\/  -]*$'::text)) NOT VALID;


--
-- TOC entry 3271 (class 2606 OID 16637)
-- Name: students chk_status; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.students
    ADD CONSTRAINT chk_status CHECK (((status)::text = ANY (ARRAY[('стулент'::character varying)::text, ('отчислен'::character varying)::text, ('в академическом отпуске'::character varying)::text]))) NOT VALID;


--
-- TOC entry 3272 (class 2606 OID 16634)
-- Name: students chk_surname; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.students
    ADD CONSTRAINT chk_surname CHECK (((surname)::text ~ '^[а-яА-Яa-zA-Z]*$'::text)) NOT VALID;


--
-- TOC entry 3267 (class 2606 OID 16639)
-- Name: teachers chk_surname; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.teachers
    ADD CONSTRAINT chk_surname CHECK (((surname)::text ~ '^[а-яА-Яa-zA-Z]*$'::text)) NOT VALID;


--
-- TOC entry 3261 (class 2606 OID 16657)
-- Name: university_buildings chk_time; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.university_buildings
    ADD CONSTRAINT chk_time CHECK ((time_open <= time_close)) NOT VALID;


--
-- TOC entry 3256 (class 2606 OID 16612)
-- Name: curriculums chk_year; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.curriculums
    ADD CONSTRAINT chk_year CHECK ((year <= CURRENT_DATE)) NOT VALID;


--
-- TOC entry 3273 (class 2606 OID 16636)
-- Name: students chk_year; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.students
    ADD CONSTRAINT chk_year CHECK ((year_of_admission < CURRENT_DATE)) NOT VALID;


--
-- TOC entry 3268 (class 2606 OID 16643)
-- Name: teachers chk_year; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.teachers
    ADD CONSTRAINT chk_year CHECK ((year_of_employment <= CURRENT_DATE)) NOT VALID;


--
-- TOC entry 3295 (class 1259 OID 16454)
-- Name: fki_Building_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Building_key" ON public.department USING btree (university_building);


--
-- TOC entry 3328 (class 1259 OID 16584)
-- Name: fki_Classroom_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Classroom_key" ON public.session_schedule USING btree (classroom);


--
-- TOC entry 3321 (class 1259 OID 16539)
-- Name: fki_Curriculum_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Curriculum_key" ON public.groups USING btree (curriculum);


--
-- TOC entry 3317 (class 1259 OID 16528)
-- Name: fki_Discipline_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Discipline_key" ON public.curriculum_discipline USING btree (discipline_id);


--
-- TOC entry 3324 (class 1259 OID 16556)
-- Name: fki_Group_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Group_key" ON public.group_distribution USING btree ("group");


--
-- TOC entry 3309 (class 1259 OID 16484)
-- Name: fki_Scholarship_type_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Scholarship_type_key" ON public.scholarship USING btree (scholarship_type);


--
-- TOC entry 3325 (class 1259 OID 16550)
-- Name: fki_Student_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Student_key" ON public.group_distribution USING btree (student);


--
-- TOC entry 3329 (class 1259 OID 16573)
-- Name: fki_Teacher_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Teacher_key" ON public.session_schedule USING btree (teacher);


--
-- TOC entry 3318 (class 1259 OID 16522)
-- Name: fki_curriculum_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_curriculum_key ON public.curriculum_discipline USING btree (curriculum_id);


--
-- TOC entry 3291 (class 1259 OID 16432)
-- Name: fki_department_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_department_key ON public.educational_program USING btree (department);


--
-- TOC entry 3292 (class 1259 OID 16417)
-- Name: fki_direction_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_direction_key ON public.educational_program USING btree (direction_of_preparation);


--
-- TOC entry 3330 (class 1259 OID 16567)
-- Name: fki_discipline_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_discipline_key ON public.session_schedule USING btree (curriculum_discipline);


--
-- TOC entry 3298 (class 1259 OID 16443)
-- Name: fki_program_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_program_key ON public.curriculums USING btree (educational_program);


--
-- TOC entry 3310 (class 1259 OID 16490)
-- Name: fki_student_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_student_key ON public.scholarship USING btree (student);


--
-- TOC entry 3335 (class 2606 OID 16449)
-- Name: department Building_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT "Building_key" FOREIGN KEY (university_building) REFERENCES public.university_buildings(building_id) NOT VALID;


--
-- TOC entry 3339 (class 2606 OID 16498)
-- Name: classrooms Building_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classrooms
    ADD CONSTRAINT "Building_key" FOREIGN KEY (building) REFERENCES public.university_buildings(building_id) NOT VALID;


--
-- TOC entry 3345 (class 2606 OID 16579)
-- Name: session_schedule Classroom_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session_schedule
    ADD CONSTRAINT "Classroom_key" FOREIGN KEY (classroom) REFERENCES public.classrooms(classroom_id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3349 (class 2606 OID 16605)
-- Name: midterm_examination Classroom_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.midterm_examination
    ADD CONSTRAINT "Classroom_key" FOREIGN KEY (classroom) REFERENCES public.classrooms(classroom_id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3340 (class 2606 OID 16517)
-- Name: curriculum_discipline Curriculum_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.curriculum_discipline
    ADD CONSTRAINT "Curriculum_key" FOREIGN KEY (curriculum_id) REFERENCES public.curriculums(curriculum_id) NOT VALID;


--
-- TOC entry 3342 (class 2606 OID 16534)
-- Name: groups Curriculum_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT "Curriculum_key" FOREIGN KEY (curriculum) REFERENCES public.curriculums(curriculum_id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3341 (class 2606 OID 16523)
-- Name: curriculum_discipline Discipline_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.curriculum_discipline
    ADD CONSTRAINT "Discipline_key" FOREIGN KEY (discipline_id) REFERENCES public.disciplines(discipline_id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3346 (class 2606 OID 16562)
-- Name: session_schedule Discipline_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session_schedule
    ADD CONSTRAINT "Discipline_key" FOREIGN KEY (curriculum_discipline) REFERENCES public.curriculum_discipline(cur_id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3350 (class 2606 OID 16590)
-- Name: midterm_examination Discipline_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.midterm_examination
    ADD CONSTRAINT "Discipline_key" FOREIGN KEY (curriculum_discipline) REFERENCES public.curriculum_discipline(cur_id) NOT VALID;


--
-- TOC entry 3343 (class 2606 OID 16551)
-- Name: group_distribution Group_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_distribution
    ADD CONSTRAINT "Group_key" FOREIGN KEY ("group") REFERENCES public.groups(group_id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3347 (class 2606 OID 16574)
-- Name: session_schedule Group_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session_schedule
    ADD CONSTRAINT "Group_key" FOREIGN KEY ("group") REFERENCES public.groups(group_id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3337 (class 2606 OID 16485)
-- Name: scholarship Student_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship
    ADD CONSTRAINT "Student_key" FOREIGN KEY (student) REFERENCES public.students(student_id) NOT VALID;


--
-- TOC entry 3344 (class 2606 OID 16545)
-- Name: group_distribution Student_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_distribution
    ADD CONSTRAINT "Student_key" FOREIGN KEY (student) REFERENCES public.students(student_id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3351 (class 2606 OID 16595)
-- Name: midterm_examination Student_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.midterm_examination
    ADD CONSTRAINT "Student_key" FOREIGN KEY (student) REFERENCES public.group_distribution(distribution_id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3348 (class 2606 OID 16568)
-- Name: session_schedule Teacher_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session_schedule
    ADD CONSTRAINT "Teacher_key" FOREIGN KEY (teacher) REFERENCES public.teachers(teacher_id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3352 (class 2606 OID 16600)
-- Name: midterm_examination Teacher_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.midterm_examination
    ADD CONSTRAINT "Teacher_key" FOREIGN KEY (teacher) REFERENCES public.teachers(teacher_id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3338 (class 2606 OID 16479)
-- Name: scholarship Type_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship
    ADD CONSTRAINT "Type_key" FOREIGN KEY (scholarship_type) REFERENCES public.scholarship_types(type_id) NOT VALID;


--
-- TOC entry 3333 (class 2606 OID 16427)
-- Name: educational_program department_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educational_program
    ADD CONSTRAINT department_key FOREIGN KEY (department) REFERENCES public.department(department_id) NOT VALID;


--
-- TOC entry 3334 (class 2606 OID 16412)
-- Name: educational_program direction_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educational_program
    ADD CONSTRAINT direction_key FOREIGN KEY (direction_of_preparation) REFERENCES public.direction_of_preparation(direction_id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3336 (class 2606 OID 16438)
-- Name: curriculums program_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.curriculums
    ADD CONSTRAINT program_key FOREIGN KEY (educational_program) REFERENCES public.educational_program(program_id) NOT VALID;


-- Completed on 2023-05-18 13:25:58

--
-- PostgreSQL database dump complete
--

