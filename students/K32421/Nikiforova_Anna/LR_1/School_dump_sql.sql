--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7
-- Dumped by pg_dump version 14.7

-- Started on 2023-02-23 14:43:16

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
-- TOC entry 3521 (class 1262 OID 37335)
-- Name: School; Type: DATABASE; Schema: -; Owner: sonya
--

CREATE DATABASE "School" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';


ALTER DATABASE "School" OWNER TO sonya;

\connect "School"

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
-- TOC entry 3522 (class 0 OID 0)
-- Dependencies: 3521
-- Name: DATABASE "School"; Type: COMMENT; Schema: -; Owner: sonya
--

COMMENT ON DATABASE "School" IS 'Восстановленная БД';


--
-- TOC entry 4 (class 2615 OID 37336)
-- Name: School_schema; Type: SCHEMA; Schema: -; Owner: sonya
--

CREATE SCHEMA "School_schema";


ALTER SCHEMA "School_schema" OWNER TO sonya;

--
-- TOC entry 3523 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA "School_schema"; Type: COMMENT; Schema: -; Owner: sonya
--

COMMENT ON SCHEMA "School_schema" IS 'Схема, в рамках которой создаются необходимые таблицы.';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 241 (class 1259 OID 37907)
-- Name: Attendance; Type: TABLE; Schema: School_schema; Owner: sonya
--

CREATE TABLE "School_schema"."Attendance" (
    attendance_id integer NOT NULL,
    attendance boolean NOT NULL,
    note text,
    student_in_class_id integer NOT NULL,
    lesson_id integer NOT NULL
);


ALTER TABLE "School_schema"."Attendance" OWNER TO sonya;

--
-- TOC entry 3524 (class 0 OID 0)
-- Dependencies: 241
-- Name: TABLE "Attendance"; Type: COMMENT; Schema: School_schema; Owner: sonya
--

COMMENT ON TABLE "School_schema"."Attendance" IS 'Таблица "Присутствие на уроке"';


--
-- TOC entry 240 (class 1259 OID 37906)
-- Name: Attendance_attendance_id_seq; Type: SEQUENCE; Schema: School_schema; Owner: sonya
--

ALTER TABLE "School_schema"."Attendance" ALTER COLUMN attendance_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "School_schema"."Attendance_attendance_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 223 (class 1259 OID 37757)
-- Name: Class; Type: TABLE; Schema: School_schema; Owner: sonya
--

CREATE TABLE "School_schema"."Class" (
    class_id integer NOT NULL,
    class_letter character varying(3) NOT NULL,
    status character varying(20) NOT NULL,
    curriculum_id integer NOT NULL,
    CONSTRAINT class_letter_check CHECK (((class_letter)::text ~ similar_to_escape('[А-ЯЁ]{1}'::text))),
    CONSTRAINT status_check CHECK (((status)::text = ANY ((ARRAY['Действует'::character varying, 'Формируется'::character varying, 'Расформирован'::character varying])::text[])))
);


ALTER TABLE "School_schema"."Class" OWNER TO sonya;

--
-- TOC entry 3525 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE "Class"; Type: COMMENT; Schema: School_schema; Owner: sonya
--

COMMENT ON TABLE "School_schema"."Class" IS 'Таблица "Класс"';


--
-- TOC entry 222 (class 1259 OID 37756)
-- Name: Class_class_id_seq; Type: SEQUENCE; Schema: School_schema; Owner: sonya
--

ALTER TABLE "School_schema"."Class" ALTER COLUMN class_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "School_schema"."Class_class_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 217 (class 1259 OID 37717)
-- Name: Classroom; Type: TABLE; Schema: School_schema; Owner: sonya
--

CREATE TABLE "School_schema"."Classroom" (
    classroom_number integer NOT NULL,
    classroom_specialization character varying(250),
    having_projector boolean,
    number_of_seats integer,
    CONSTRAINT number_of_seats_check CHECK ((number_of_seats >= 0))
);


ALTER TABLE "School_schema"."Classroom" OWNER TO sonya;

--
-- TOC entry 3526 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE "Classroom"; Type: COMMENT; Schema: School_schema; Owner: sonya
--

COMMENT ON TABLE "School_schema"."Classroom" IS 'Таблица "Кабинет"';


--
-- TOC entry 216 (class 1259 OID 37716)
-- Name: Classroom_classroom_number_seq; Type: SEQUENCE; Schema: School_schema; Owner: sonya
--

CREATE SEQUENCE "School_schema"."Classroom_classroom_number_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "School_schema"."Classroom_classroom_number_seq" OWNER TO sonya;

--
-- TOC entry 3527 (class 0 OID 0)
-- Dependencies: 216
-- Name: Classroom_classroom_number_seq; Type: SEQUENCE OWNED BY; Schema: School_schema; Owner: sonya
--

ALTER SEQUENCE "School_schema"."Classroom_classroom_number_seq" OWNED BY "School_schema"."Classroom".classroom_number;


--
-- TOC entry 211 (class 1259 OID 37682)
-- Name: Curriculum; Type: TABLE; Schema: School_schema; Owner: sonya
--

CREATE TABLE "School_schema"."Curriculum" (
    curriculum_id integer NOT NULL,
    year_start_date date NOT NULL,
    year_end_date date NOT NULL,
    link_to_the_original text NOT NULL,
    class_number integer NOT NULL,
    class_specialization character varying(250),
    CONSTRAINT class_number_check CHECK (((5 <= class_number) AND (class_number <= 11))),
    CONSTRAINT years_start_and_end_check CHECK ((year_start_date < year_end_date)),
    CONSTRAINT years_start_check CHECK (('1900-01-01'::date <= year_start_date))
);


ALTER TABLE "School_schema"."Curriculum" OWNER TO sonya;

--
-- TOC entry 3528 (class 0 OID 0)
-- Dependencies: 211
-- Name: TABLE "Curriculum"; Type: COMMENT; Schema: School_schema; Owner: sonya
--

COMMENT ON TABLE "School_schema"."Curriculum" IS 'Таблица "Учебный план"';


--
-- TOC entry 210 (class 1259 OID 37681)
-- Name: Curriculum_curriculum_id_seq; Type: SEQUENCE; Schema: School_schema; Owner: sonya
--

ALTER TABLE "School_schema"."Curriculum" ALTER COLUMN curriculum_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "School_schema"."Curriculum_curriculum_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 219 (class 1259 OID 37725)
-- Name: Discipline; Type: TABLE; Schema: School_schema; Owner: sonya
--

CREATE TABLE "School_schema"."Discipline" (
    discipline_id integer NOT NULL,
    curriculum_id integer NOT NULL,
    discipline_code integer NOT NULL,
    hours integer NOT NULL,
    subject_area character varying(250) NOT NULL,
    subject_name character varying(250) NOT NULL,
    CONSTRAINT hours_check CHECK ((hours >= 0))
);


ALTER TABLE "School_schema"."Discipline" OWNER TO sonya;

--
-- TOC entry 3529 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE "Discipline"; Type: COMMENT; Schema: School_schema; Owner: sonya
--

COMMENT ON TABLE "School_schema"."Discipline" IS 'Таблица "Дисциплина"';


--
-- TOC entry 218 (class 1259 OID 37724)
-- Name: Discipline_discipline_id_seq; Type: SEQUENCE; Schema: School_schema; Owner: sonya
--

ALTER TABLE "School_schema"."Discipline" ALTER COLUMN discipline_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "School_schema"."Discipline_discipline_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 221 (class 1259 OID 37739)
-- Name: Education; Type: TABLE; Schema: School_schema; Owner: sonya
--

CREATE TABLE "School_schema"."Education" (
    education_id integer NOT NULL,
    teacher_personnel_number integer NOT NULL,
    diploma character varying(50) NOT NULL,
    received date NOT NULL,
    education_level character varying(50) NOT NULL,
    qualifications character varying(200) NOT NULL,
    specialization character varying(200) NOT NULL,
    CONSTRAINT diploma_check CHECK (((diploma)::text ~ similar_to_escape('\d+'::text))),
    CONSTRAINT education_level_check CHECK (((education_level)::text = ANY ((ARRAY['Среднее профессиональное образование'::character varying, 'Бакалавриат'::character varying, 'Магистратура'::character varying, 'Специалитет'::character varying, 'Аспирантура'::character varying, 'Докторантура'::character varying])::text[]))),
    CONSTRAINT received_diploma_date_check CHECK ((('1900-01-01'::date <= received) AND (received < now())))
);


ALTER TABLE "School_schema"."Education" OWNER TO sonya;

--
-- TOC entry 3530 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE "Education"; Type: COMMENT; Schema: School_schema; Owner: sonya
--

COMMENT ON TABLE "School_schema"."Education" IS 'Таблица "Образование"';


--
-- TOC entry 220 (class 1259 OID 37738)
-- Name: Education_education_id_seq; Type: SEQUENCE; Schema: School_schema; Owner: sonya
--

ALTER TABLE "School_schema"."Education" ALTER COLUMN education_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "School_schema"."Education_education_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 239 (class 1259 OID 37893)
-- Name: EvaluationTool; Type: TABLE; Schema: School_schema; Owner: sonya
--

CREATE TABLE "School_schema"."EvaluationTool" (
    evaluation_tool_id integer NOT NULL,
    name character varying(200),
    type character varying(20) NOT NULL,
    description text,
    plan_id integer NOT NULL,
    CONSTRAINT type_check CHECK (((type)::text = ANY ((ARRAY['К/р'::character varying, 'С/р'::character varying, 'Д/з'::character varying, 'Ведение тетради'::character varying, 'Работа на уроке'::character varying, 'Иное'::character varying])::text[])))
);


ALTER TABLE "School_schema"."EvaluationTool" OWNER TO sonya;

--
-- TOC entry 3531 (class 0 OID 0)
-- Dependencies: 239
-- Name: TABLE "EvaluationTool"; Type: COMMENT; Schema: School_schema; Owner: sonya
--

COMMENT ON TABLE "School_schema"."EvaluationTool" IS 'Таблица "Оценочное средство"';


--
-- TOC entry 238 (class 1259 OID 37892)
-- Name: EvaluationTool_evaluation_tool_id_seq; Type: SEQUENCE; Schema: School_schema; Owner: sonya
--

ALTER TABLE "School_schema"."EvaluationTool" ALTER COLUMN evaluation_tool_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "School_schema"."EvaluationTool_evaluation_tool_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 243 (class 1259 OID 37925)
-- Name: Grade; Type: TABLE; Schema: School_schema; Owner: sonya
--

CREATE TABLE "School_schema"."Grade" (
    grade_id integer NOT NULL,
    grade integer,
    note text,
    attendance_id integer NOT NULL,
    evaluation_tool_id integer NOT NULL,
    CONSTRAINT grade_check CHECK (((2 <= grade) AND (grade <= 5)))
);


ALTER TABLE "School_schema"."Grade" OWNER TO sonya;

--
-- TOC entry 3532 (class 0 OID 0)
-- Dependencies: 243
-- Name: TABLE "Grade"; Type: COMMENT; Schema: School_schema; Owner: sonya
--

COMMENT ON TABLE "School_schema"."Grade" IS 'Таблица "Оценка"';


--
-- TOC entry 242 (class 1259 OID 37924)
-- Name: Grade_grade_id_seq; Type: SEQUENCE; Schema: School_schema; Owner: sonya
--

ALTER TABLE "School_schema"."Grade" ALTER COLUMN grade_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "School_schema"."Grade_grade_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 231 (class 1259 OID 37831)
-- Name: Headstudent; Type: TABLE; Schema: School_schema; Owner: sonya
--

CREATE TABLE "School_schema"."Headstudent" (
    headstudent_id integer NOT NULL,
    date_from date NOT NULL,
    date_to date,
    student_in_class_id integer NOT NULL,
    CONSTRAINT date_from_check CHECK (('1900-01-01'::date <= date_from)),
    CONSTRAINT date_to_check CHECK ((date_from < date_to))
);


ALTER TABLE "School_schema"."Headstudent" OWNER TO sonya;

--
-- TOC entry 3533 (class 0 OID 0)
-- Dependencies: 231
-- Name: TABLE "Headstudent"; Type: COMMENT; Schema: School_schema; Owner: sonya
--

COMMENT ON TABLE "School_schema"."Headstudent" IS 'Таблица "Староста"';


--
-- TOC entry 230 (class 1259 OID 37830)
-- Name: Headstudent_headstudent_id_seq; Type: SEQUENCE; Schema: School_schema; Owner: sonya
--

ALTER TABLE "School_schema"."Headstudent" ALTER COLUMN headstudent_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "School_schema"."Headstudent_headstudent_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 227 (class 1259 OID 37789)
-- Name: Headteacher; Type: TABLE; Schema: School_schema; Owner: sonya
--

CREATE TABLE "School_schema"."Headteacher" (
    headteacher_id integer NOT NULL,
    date_from date NOT NULL,
    date_to date,
    teacher_personnel_number integer NOT NULL,
    class_id integer NOT NULL,
    CONSTRAINT date_from_check CHECK (('1900-01-01'::date <= date_from)),
    CONSTRAINT date_to_check CHECK ((date_from < date_to))
);


ALTER TABLE "School_schema"."Headteacher" OWNER TO sonya;

--
-- TOC entry 3534 (class 0 OID 0)
-- Dependencies: 227
-- Name: TABLE "Headteacher"; Type: COMMENT; Schema: School_schema; Owner: sonya
--

COMMENT ON TABLE "School_schema"."Headteacher" IS 'Таблица "Классное руководство"';


--
-- TOC entry 226 (class 1259 OID 37788)
-- Name: Headteacher_headteacher_id_seq; Type: SEQUENCE; Schema: School_schema; Owner: sonya
--

ALTER TABLE "School_schema"."Headteacher" ALTER COLUMN headteacher_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "School_schema"."Headteacher_headteacher_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 237 (class 1259 OID 37881)
-- Name: Lesson; Type: TABLE; Schema: School_schema; Owner: sonya
--

CREATE TABLE "School_schema"."Lesson" (
    lesson_id integer NOT NULL,
    lesson_date date NOT NULL,
    schedule_id integer NOT NULL,
    CONSTRAINT lesson_date_check CHECK (('1900-01-01'::date <= lesson_date))
);


ALTER TABLE "School_schema"."Lesson" OWNER TO sonya;

--
-- TOC entry 3535 (class 0 OID 0)
-- Dependencies: 237
-- Name: TABLE "Lesson"; Type: COMMENT; Schema: School_schema; Owner: sonya
--

COMMENT ON TABLE "School_schema"."Lesson" IS 'Таблица "Урок"';


--
-- TOC entry 236 (class 1259 OID 37880)
-- Name: Lesson_lesson_id_seq; Type: SEQUENCE; Schema: School_schema; Owner: sonya
--

ALTER TABLE "School_schema"."Lesson" ALTER COLUMN lesson_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "School_schema"."Lesson_lesson_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 235 (class 1259 OID 37866)
-- Name: Plan; Type: TABLE; Schema: School_schema; Owner: sonya
--

CREATE TABLE "School_schema"."Plan" (
    plan_id integer NOT NULL,
    topic_name character varying(200) NOT NULL,
    topic_number integer NOT NULL,
    hours_per_topic integer NOT NULL,
    workload_id integer NOT NULL,
    CONSTRAINT hours_check CHECK ((hours_per_topic > 0)),
    CONSTRAINT topic_number_check CHECK ((topic_number > 0))
);


ALTER TABLE "School_schema"."Plan" OWNER TO sonya;

--
-- TOC entry 3536 (class 0 OID 0)
-- Dependencies: 235
-- Name: TABLE "Plan"; Type: COMMENT; Schema: School_schema; Owner: sonya
--

COMMENT ON TABLE "School_schema"."Plan" IS 'Таблица "Календарно-тематический план"';


--
-- TOC entry 234 (class 1259 OID 37865)
-- Name: Plan_plan_id_seq; Type: SEQUENCE; Schema: School_schema; Owner: sonya
--

ALTER TABLE "School_schema"."Plan" ALTER COLUMN plan_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "School_schema"."Plan_plan_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 233 (class 1259 OID 37844)
-- Name: Schedule; Type: TABLE; Schema: School_schema; Owner: sonya
--

CREATE TABLE "School_schema"."Schedule" (
    schedule_id integer NOT NULL,
    weekday character varying(11) NOT NULL,
    lesson_type character varying(20) NOT NULL,
    date_from date NOT NULL,
    date_to date,
    time_from time without time zone NOT NULL,
    time_to time without time zone NOT NULL,
    classroom_number integer NOT NULL,
    workload_id integer NOT NULL,
    CONSTRAINT date_from_check CHECK (('1900-01-01'::date <= date_from)),
    CONSTRAINT date_to_check CHECK ((date_from < date_to)),
    CONSTRAINT lesson_type_check CHECK (((lesson_type)::text = ANY ((ARRAY['Основное'::character varying, 'Дополнительное'::character varying, 'Факультатив'::character varying, 'Секция'::character varying, 'Иное'::character varying])::text[]))),
    CONSTRAINT time_from_check CHECK ((('06:00:00'::time without time zone <= time_from) AND (time_from <= '22:00:00'::time without time zone))),
    CONSTRAINT time_to_check CHECK (((time_from <= time_to) AND (time_to <= '22:00:00'::time without time zone))),
    CONSTRAINT weekday_check CHECK (((weekday)::text = ANY ((ARRAY['Понедельник'::character varying, 'Вторник'::character varying, 'Среда'::character varying, 'Четверг'::character varying, 'Пятница'::character varying, 'Суббота'::character varying])::text[])))
);


ALTER TABLE "School_schema"."Schedule" OWNER TO sonya;

--
-- TOC entry 3537 (class 0 OID 0)
-- Dependencies: 233
-- Name: TABLE "Schedule"; Type: COMMENT; Schema: School_schema; Owner: sonya
--

COMMENT ON TABLE "School_schema"."Schedule" IS 'Таблица "Расписание"';


--
-- TOC entry 232 (class 1259 OID 37843)
-- Name: Schedule_schedule_id_seq; Type: SEQUENCE; Schema: School_schema; Owner: sonya
--

ALTER TABLE "School_schema"."Schedule" ALTER COLUMN schedule_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "School_schema"."Schedule_schedule_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 215 (class 1259 OID 37707)
-- Name: Student; Type: TABLE; Schema: School_schema; Owner: sonya
--

CREATE TABLE "School_schema"."Student" (
    student_code integer NOT NULL,
    full_name character varying(250) NOT NULL,
    birth_date date NOT NULL,
    address character varying(250),
    phone character varying(18),
    email character varying(100),
    CONSTRAINT birth_date_check CHECK ((('1990-01-01'::date <= birth_date) AND (birth_date < now())))
);


ALTER TABLE "School_schema"."Student" OWNER TO sonya;

--
-- TOC entry 3538 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE "Student"; Type: COMMENT; Schema: School_schema; Owner: sonya
--

COMMENT ON TABLE "School_schema"."Student" IS 'Таблица "Ученик"';


--
-- TOC entry 225 (class 1259 OID 37770)
-- Name: Student_in_class; Type: TABLE; Schema: School_schema; Owner: sonya
--

CREATE TABLE "School_schema"."Student_in_class" (
    student_in_class_id integer NOT NULL,
    date_from date NOT NULL,
    date_to date,
    status character varying(20) NOT NULL,
    class_id integer NOT NULL,
    student_code integer NOT NULL,
    CONSTRAINT date_from_check CHECK (('1900-01-01'::date <= date_from)),
    CONSTRAINT date_to_check CHECK ((date_from < date_to)),
    CONSTRAINT status_check CHECK (((status)::text = ANY ((ARRAY['Числится'::character varying, 'Числился'::character varying, 'Отчислен'::character varying, 'В академ. отпуске'::character varying])::text[])))
);


ALTER TABLE "School_schema"."Student_in_class" OWNER TO sonya;

--
-- TOC entry 3539 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE "Student_in_class"; Type: COMMENT; Schema: School_schema; Owner: sonya
--

COMMENT ON TABLE "School_schema"."Student_in_class" IS 'Таблица "Обучающийся"';


--
-- TOC entry 224 (class 1259 OID 37769)
-- Name: Student_in_class_student_in_class_id_seq; Type: SEQUENCE; Schema: School_schema; Owner: sonya
--

ALTER TABLE "School_schema"."Student_in_class" ALTER COLUMN student_in_class_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "School_schema"."Student_in_class_student_in_class_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 214 (class 1259 OID 37706)
-- Name: Student_student_code_seq; Type: SEQUENCE; Schema: School_schema; Owner: sonya
--

CREATE SEQUENCE "School_schema"."Student_student_code_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "School_schema"."Student_student_code_seq" OWNER TO sonya;

--
-- TOC entry 3540 (class 0 OID 0)
-- Dependencies: 214
-- Name: Student_student_code_seq; Type: SEQUENCE OWNED BY; Schema: School_schema; Owner: sonya
--

ALTER SEQUENCE "School_schema"."Student_student_code_seq" OWNED BY "School_schema"."Student".student_code;


--
-- TOC entry 213 (class 1259 OID 37693)
-- Name: Teacher; Type: TABLE; Schema: School_schema; Owner: sonya
--

CREATE TABLE "School_schema"."Teacher" (
    teacher_personnel_number integer NOT NULL,
    full_name character varying(250) NOT NULL,
    birth_date date NOT NULL,
    passport character varying(11) NOT NULL,
    address character varying(250),
    phone character varying(18),
    email character varying(100),
    CONSTRAINT birth_date_check CHECK ((('1900-01-01'::date <= birth_date) AND (birth_date < (now() - '16 years'::interval)))),
    CONSTRAINT passport_check CHECK (((passport)::text ~ similar_to_escape('\d{4}(| )\d{6}'::text))),
    CONSTRAINT phone_check CHECK (((phone)::text ~ similar_to_escape('(\+7|8) \(\d{3}\) \d{3}-\d{2}-\d{2}'::text)))
);


ALTER TABLE "School_schema"."Teacher" OWNER TO sonya;

--
-- TOC entry 3541 (class 0 OID 0)
-- Dependencies: 213
-- Name: TABLE "Teacher"; Type: COMMENT; Schema: School_schema; Owner: sonya
--

COMMENT ON TABLE "School_schema"."Teacher" IS 'Таблица "Преподаватель"';


--
-- TOC entry 212 (class 1259 OID 37692)
-- Name: Teacher_teacher_personnel_number_seq; Type: SEQUENCE; Schema: School_schema; Owner: sonya
--

CREATE SEQUENCE "School_schema"."Teacher_teacher_personnel_number_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "School_schema"."Teacher_teacher_personnel_number_seq" OWNER TO sonya;

--
-- TOC entry 3542 (class 0 OID 0)
-- Dependencies: 212
-- Name: Teacher_teacher_personnel_number_seq; Type: SEQUENCE OWNED BY; Schema: School_schema; Owner: sonya
--

ALTER SEQUENCE "School_schema"."Teacher_teacher_personnel_number_seq" OWNED BY "School_schema"."Teacher".teacher_personnel_number;


--
-- TOC entry 229 (class 1259 OID 37807)
-- Name: Workload; Type: TABLE; Schema: School_schema; Owner: sonya
--

CREATE TABLE "School_schema"."Workload" (
    workload_id integer NOT NULL,
    hours integer NOT NULL,
    date_from date NOT NULL,
    date_to date,
    teacher_personnel_number integer NOT NULL,
    class_id integer NOT NULL,
    discipline_id integer NOT NULL,
    CONSTRAINT date_from_check CHECK (('1900-01-01'::date <= date_from)),
    CONSTRAINT date_to_check CHECK ((date_from < date_to)),
    CONSTRAINT hours_check CHECK ((hours >= 0))
);


ALTER TABLE "School_schema"."Workload" OWNER TO sonya;

--
-- TOC entry 3543 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE "Workload"; Type: COMMENT; Schema: School_schema; Owner: sonya
--

COMMENT ON TABLE "School_schema"."Workload" IS 'Таблица "Нагрузка"';


--
-- TOC entry 228 (class 1259 OID 37806)
-- Name: Workload_workload_id_seq; Type: SEQUENCE; Schema: School_schema; Owner: sonya
--

ALTER TABLE "School_schema"."Workload" ALTER COLUMN workload_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "School_schema"."Workload_workload_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3254 (class 2604 OID 37720)
-- Name: Classroom classroom_number; Type: DEFAULT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Classroom" ALTER COLUMN classroom_number SET DEFAULT nextval('"School_schema"."Classroom_classroom_number_seq"'::regclass);


--
-- TOC entry 3252 (class 2604 OID 37710)
-- Name: Student student_code; Type: DEFAULT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Student" ALTER COLUMN student_code SET DEFAULT nextval('"School_schema"."Student_student_code_seq"'::regclass);


--
-- TOC entry 3248 (class 2604 OID 37696)
-- Name: Teacher teacher_personnel_number; Type: DEFAULT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Teacher" ALTER COLUMN teacher_personnel_number SET DEFAULT nextval('"School_schema"."Teacher_teacher_personnel_number_seq"'::regclass);


--
-- TOC entry 3513 (class 0 OID 37907)
-- Dependencies: 241
-- Data for Name: Attendance; Type: TABLE DATA; Schema: School_schema; Owner: sonya
--

INSERT INTO "School_schema"."Attendance" OVERRIDING SYSTEM VALUE VALUES (1, false, 'Ув.пр.', 3, 1);
INSERT INTO "School_schema"."Attendance" OVERRIDING SYSTEM VALUE VALUES (2, true, 'Перевернул горшок с цветком', 3, 2);
INSERT INTO "School_schema"."Attendance" OVERRIDING SYSTEM VALUE VALUES (3, true, NULL, 1, 5);
INSERT INTO "School_schema"."Attendance" OVERRIDING SYSTEM VALUE VALUES (4, true, NULL, 2, 4);
INSERT INTO "School_schema"."Attendance" OVERRIDING SYSTEM VALUE VALUES (5, true, NULL, 2, 5);


--
-- TOC entry 3495 (class 0 OID 37757)
-- Dependencies: 223
-- Data for Name: Class; Type: TABLE DATA; Schema: School_schema; Owner: sonya
--

INSERT INTO "School_schema"."Class" OVERRIDING SYSTEM VALUE VALUES (1, 'А', 'Расформирован', 1);
INSERT INTO "School_schema"."Class" OVERRIDING SYSTEM VALUE VALUES (2, 'Б', 'Расформирован', 1);
INSERT INTO "School_schema"."Class" OVERRIDING SYSTEM VALUE VALUES (3, 'А', 'Расформирован', 2);
INSERT INTO "School_schema"."Class" OVERRIDING SYSTEM VALUE VALUES (4, 'А', 'Формируется', 5);
INSERT INTO "School_schema"."Class" OVERRIDING SYSTEM VALUE VALUES (5, 'Б', 'Формируется', 5);
INSERT INTO "School_schema"."Class" OVERRIDING SYSTEM VALUE VALUES (6, 'А', 'Действует', 6);
INSERT INTO "School_schema"."Class" OVERRIDING SYSTEM VALUE VALUES (7, 'Б', 'Действует', 6);
INSERT INTO "School_schema"."Class" OVERRIDING SYSTEM VALUE VALUES (8, 'Б', 'Действует', 7);


--
-- TOC entry 3489 (class 0 OID 37717)
-- Dependencies: 217
-- Data for Name: Classroom; Type: TABLE DATA; Schema: School_schema; Owner: sonya
--

INSERT INTO "School_schema"."Classroom" VALUES (1, 'Спортивный зал', false, 0);
INSERT INTO "School_schema"."Classroom" VALUES (14, NULL, false, 30);
INSERT INTO "School_schema"."Classroom" VALUES (22, 'Физика', true, 30);
INSERT INTO "School_schema"."Classroom" VALUES (21, 'Химия', true, 32);
INSERT INTO "School_schema"."Classroom" VALUES (23, NULL, false, 32);
INSERT INTO "School_schema"."Classroom" VALUES (26, NULL, true, 32);
INSERT INTO "School_schema"."Classroom" VALUES (28, NULL, NULL, 32);
INSERT INTO "School_schema"."Classroom" VALUES (32, NULL, false, 18);
INSERT INTO "School_schema"."Classroom" VALUES (35, 'Информатика', true, 20);
INSERT INTO "School_schema"."Classroom" VALUES (42, 'Библиотека', NULL, 4);
INSERT INTO "School_schema"."Classroom" VALUES (43, NULL, false, 32);


--
-- TOC entry 3483 (class 0 OID 37682)
-- Dependencies: 211
-- Data for Name: Curriculum; Type: TABLE DATA; Schema: School_schema; Owner: sonya
--

INSERT INTO "School_schema"."Curriculum" OVERRIDING SYSTEM VALUE VALUES (1, '2018-09-01', '2019-08-30', 'Ссылка', 5, NULL);
INSERT INTO "School_schema"."Curriculum" OVERRIDING SYSTEM VALUE VALUES (2, '2019-09-01', '2020-08-30', 'Ссылка', 8, NULL);
INSERT INTO "School_schema"."Curriculum" OVERRIDING SYSTEM VALUE VALUES (3, '2020-09-01', '2021-08-30', 'Ссылка', 10, 'Физико-математический');
INSERT INTO "School_schema"."Curriculum" OVERRIDING SYSTEM VALUE VALUES (4, '2021-09-01', '2022-08-30', 'Ссылка', 6, NULL);
INSERT INTO "School_schema"."Curriculum" OVERRIDING SYSTEM VALUE VALUES (5, '2023-09-01', '2024-08-30', 'Ссылка', 7, NULL);
INSERT INTO "School_schema"."Curriculum" OVERRIDING SYSTEM VALUE VALUES (6, '2022-09-01', '2023-08-30', 'Ссылка', 10, 'Социально-гуманитарный');
INSERT INTO "School_schema"."Curriculum" OVERRIDING SYSTEM VALUE VALUES (7, '2022-09-01', '2023-08-30', 'Ссылка', 11, 'Физико-математический');


--
-- TOC entry 3491 (class 0 OID 37725)
-- Dependencies: 219
-- Data for Name: Discipline; Type: TABLE DATA; Schema: School_schema; Owner: sonya
--

INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (1, 1, 1, 180, 'Русский язык и литература', 'Русский язык');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (2, 1, 18, 108, 'Русский язык и литература', 'Литература');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (3, 1, 9, 108, 'Иностранный язык', 'Английский язык');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (4, 1, 2, 180, 'Математика и информатика', 'Математика');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (5, 1, 7, 72, 'Общественно-научные предметы', 'История России');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (6, 1, 8, 36, 'Общественно-научные предметы', 'География');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (7, 1, 6, 36, 'Естественно-научные предметы', 'Биология');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (8, 1, 0, 72, 'Физическая культура', 'Физическая культура');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (9, 2, 18, 72, 'Русский язык и литература', 'Литература');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (10, 2, 9, 108, 'Иностранный язык', 'Английский язык');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (11, 2, 2, 108, 'Математика и информатика', 'Алгебра');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (12, 2, 2, 72, 'Математика и информатика', 'Геометрия');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (13, 2, 5, 36, 'Математика и информатика', 'Информатика');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (14, 2, 7, 72, 'Общественно-научные предметы', 'История России');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (15, 2, 12, 72, 'Общественно-научные предметы', 'Обществознание');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (16, 2, 8, 72, 'Общественно-научные предметы', 'География');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (17, 2, 6, 72, 'Естественно-научные предметы', 'Биология');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (18, 2, 3, 72, 'Естественно-научные предметы', 'Физика');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (19, 2, 4, 72, 'Естественно-научные предметы', 'Химия');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (20, 2, 0, 108, 'Физическая культура', 'Физическая культура');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (21, 3, 1, 108, 'Русский язык и литература', 'Русский язык');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (22, 3, 9, 108, 'Иностранный язык', 'Английский язык');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (23, 3, 2, 216, 'Математика и информатика', 'Алгебра');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (24, 3, 2, 144, 'Математика и информатика', 'Геометрия');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (25, 3, 5, 180, 'Математика и информатика', 'Информатика');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (26, 3, 7, 72, 'Общественно-научные предметы', 'История России');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (27, 3, 3, 180, 'Естественно-научные предметы', 'Физика');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (28, 3, 0, 108, 'Физическая культура', 'Физическая культура');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (29, 4, 1, 216, 'Русский язык и литература', 'Русский язык');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (30, 4, 18, 108, 'Русский язык и литература', 'Литература');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (31, 4, 9, 72, 'Иностранный язык', 'Английский язык');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (32, 4, 2, 180, 'Математика и информатика', 'Математика');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (33, 4, 7, 72, 'Общественно-научные предметы', 'История России');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (34, 4, 12, 72, 'Общественно-научные предметы', 'Обществознание');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (35, 4, 8, 36, 'Общественно-научные предметы', 'География');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (36, 4, 6, 36, 'Естественно-научные предметы', 'Биология');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (37, 4, 0, 108, 'Физическая культура', 'Физическая культура');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (38, 5, 1, 144, 'Русский язык и литература', 'Русский язык');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (39, 5, 18, 72, 'Русский язык и литература', 'Литература');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (40, 5, 9, 108, 'Иностранный язык', 'Английский язык');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (41, 5, 2, 108, 'Математика и информатика', 'Алгебра');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (42, 5, 2, 72, 'Математика и информатика', 'Геометрия');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (43, 5, 5, 36, 'Математика и информатика', 'Информатика');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (44, 5, 7, 72, 'Общественно-научные предметы', 'История России');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (45, 5, 12, 72, 'Общественно-научные предметы', 'Обществознание');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (46, 5, 8, 72, 'Общественно-научные предметы', 'География');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (47, 5, 6, 36, 'Естественно-научные предметы', 'Биология');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (48, 5, 3, 72, 'Естественно-научные предметы', 'Физика');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (49, 5, 0, 108, 'Физическая культура', 'Физическая культура');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (50, 6, 1, 216, 'Русский язык и литература', 'Русский язык');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (51, 6, 18, 144, 'Русский язык и литература', 'Литература');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (52, 6, 9, 144, 'Иностранный язык', 'Английский язык');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (53, 6, 2, 108, 'Математика и информатика', 'Алгебра');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (54, 6, 2, 72, 'Математика и информатика', 'Геометрия');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (55, 6, 7, 108, 'Общественно-научные предметы', 'История России');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (56, 6, 12, 144, 'Общественно-научные предметы', 'Обществознание');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (57, 6, 0, 108, 'Физическая культура', 'Физическая культура');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (58, 7, 1, 108, 'Русский язык и литература', 'Русский язык');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (59, 7, 9, 108, 'Иностранный язык', 'Английский язык');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (60, 7, 2, 216, 'Математика и информатика', 'Алгебра');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (61, 7, 2, 144, 'Математика и информатика', 'Геометрия');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (62, 7, 5, 180, 'Математика и информатика', 'Информатика');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (63, 7, 7, 72, 'Общественно-научные предметы', 'История России');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (64, 7, 3, 180, 'Естественно-научные предметы', 'Физика');
INSERT INTO "School_schema"."Discipline" OVERRIDING SYSTEM VALUE VALUES (65, 7, 0, 108, 'Физическая культура', 'Физическая культура');


--
-- TOC entry 3493 (class 0 OID 37739)
-- Dependencies: 221
-- Data for Name: Education; Type: TABLE DATA; Schema: School_schema; Owner: sonya
--

INSERT INTO "School_schema"."Education" OVERRIDING SYSTEM VALUE VALUES (1, 334, '8950478012833', '1984-08-15', 'Бакалавриат', 'Экономист-аналитик', '38.03.01 Экономика');
INSERT INTO "School_schema"."Education" OVERRIDING SYSTEM VALUE VALUES (2, 121, '5595629962002', '1976-08-15', 'Бакалавриат', 'Робототехник', '02.03.02 Фундаментальная информатика и информационные технологии');
INSERT INTO "School_schema"."Education" OVERRIDING SYSTEM VALUE VALUES (3, 215, '9957538971664', '1979-08-15', 'Магистратура', 'Преподаватель русского языка и литературы', '45.04.01 Филология');
INSERT INTO "School_schema"."Education" OVERRIDING SYSTEM VALUE VALUES (4, 98, '2429203942484', '2018-08-15', 'Среднее профессиональное образование', 'Педагог', '44.00.00 Образование и педагогические науки');
INSERT INTO "School_schema"."Education" OVERRIDING SYSTEM VALUE VALUES (5, 419, '8237475371204', '2017-08-15', 'Бакалавриат', 'Аналитик данных', '45.03.04 Интеллектуальные системы в гуманитарной сфере');
INSERT INTO "School_schema"."Education" OVERRIDING SYSTEM VALUE VALUES (6, 419, '9723201371204', '2019-08-15', 'Магистратура', 'Переводчик', '58.04.01 Востоковедение и африканистика');


--
-- TOC entry 3511 (class 0 OID 37893)
-- Dependencies: 239
-- Data for Name: EvaluationTool; Type: TABLE DATA; Schema: School_schema; Owner: sonya
--

INSERT INTO "School_schema"."EvaluationTool" OVERRIDING SYSTEM VALUE VALUES (1, 'Лабораторная 1', 'С/р', NULL, 1);
INSERT INTO "School_schema"."EvaluationTool" OVERRIDING SYSTEM VALUE VALUES (2, 'Контрольная по 1 разделу', 'К/р', NULL, 8);
INSERT INTO "School_schema"."EvaluationTool" OVERRIDING SYSTEM VALUE VALUES (3, 'Введение', 'Д/з', NULL, 5);
INSERT INTO "School_schema"."EvaluationTool" OVERRIDING SYSTEM VALUE VALUES (4, NULL, 'Иное', 'Олимпиада', 8);


--
-- TOC entry 3515 (class 0 OID 37925)
-- Dependencies: 243
-- Data for Name: Grade; Type: TABLE DATA; Schema: School_schema; Owner: sonya
--

INSERT INTO "School_schema"."Grade" OVERRIDING SYSTEM VALUE VALUES (1, 5, NULL, 2, 3);
INSERT INTO "School_schema"."Grade" OVERRIDING SYSTEM VALUE VALUES (2, 3, NULL, 3, 2);
INSERT INTO "School_schema"."Grade" OVERRIDING SYSTEM VALUE VALUES (3, 4, NULL, 4, 2);
INSERT INTO "School_schema"."Grade" OVERRIDING SYSTEM VALUE VALUES (4, 5, 'Олимпиада', 5, 4);


--
-- TOC entry 3503 (class 0 OID 37831)
-- Dependencies: 231
-- Data for Name: Headstudent; Type: TABLE DATA; Schema: School_schema; Owner: sonya
--

INSERT INTO "School_schema"."Headstudent" OVERRIDING SYSTEM VALUE VALUES (1, '2022-09-01', NULL, 6);
INSERT INTO "School_schema"."Headstudent" OVERRIDING SYSTEM VALUE VALUES (2, '2022-09-30', NULL, 3);
INSERT INTO "School_schema"."Headstudent" OVERRIDING SYSTEM VALUE VALUES (3, '2019-09-01', '2020-05-30', 5);


--
-- TOC entry 3499 (class 0 OID 37789)
-- Dependencies: 227
-- Data for Name: Headteacher; Type: TABLE DATA; Schema: School_schema; Owner: sonya
--

INSERT INTO "School_schema"."Headteacher" OVERRIDING SYSTEM VALUE VALUES (1, '2019-09-01', '2020-08-30', 121, 3);
INSERT INTO "School_schema"."Headteacher" OVERRIDING SYSTEM VALUE VALUES (2, '2022-09-01', NULL, 121, 7);
INSERT INTO "School_schema"."Headteacher" OVERRIDING SYSTEM VALUE VALUES (3, '2022-10-03', NULL, 113, 8);


--
-- TOC entry 3509 (class 0 OID 37881)
-- Dependencies: 237
-- Data for Name: Lesson; Type: TABLE DATA; Schema: School_schema; Owner: sonya
--

INSERT INTO "School_schema"."Lesson" OVERRIDING SYSTEM VALUE VALUES (1, '2022-09-05', 1);
INSERT INTO "School_schema"."Lesson" OVERRIDING SYSTEM VALUE VALUES (2, '2022-09-12', 1);
INSERT INTO "School_schema"."Lesson" OVERRIDING SYSTEM VALUE VALUES (3, '2022-09-19', 1);
INSERT INTO "School_schema"."Lesson" OVERRIDING SYSTEM VALUE VALUES (4, '2022-09-07', 4);
INSERT INTO "School_schema"."Lesson" OVERRIDING SYSTEM VALUE VALUES (5, '2022-09-14', 4);


--
-- TOC entry 3507 (class 0 OID 37866)
-- Dependencies: 235
-- Data for Name: Plan; Type: TABLE DATA; Schema: School_schema; Owner: sonya
--

INSERT INTO "School_schema"."Plan" OVERRIDING SYSTEM VALUE VALUES (1, 'Тема 1', 1, 2, 17);
INSERT INTO "School_schema"."Plan" OVERRIDING SYSTEM VALUE VALUES (2, 'Тема 2', 2, 3, 17);
INSERT INTO "School_schema"."Plan" OVERRIDING SYSTEM VALUE VALUES (3, 'Тема 3', 3, 2, 17);
INSERT INTO "School_schema"."Plan" OVERRIDING SYSTEM VALUE VALUES (4, 'Тема 4', 4, 10, 17);
INSERT INTO "School_schema"."Plan" OVERRIDING SYSTEM VALUE VALUES (5, 'Тема 1', 1, 2, 1);
INSERT INTO "School_schema"."Plan" OVERRIDING SYSTEM VALUE VALUES (6, 'Тема 2', 2, 3, 1);
INSERT INTO "School_schema"."Plan" OVERRIDING SYSTEM VALUE VALUES (7, 'Тема 3', 3, 8, 1);
INSERT INTO "School_schema"."Plan" OVERRIDING SYSTEM VALUE VALUES (8, 'Тема 1', 1, 3, 15);
INSERT INTO "School_schema"."Plan" OVERRIDING SYSTEM VALUE VALUES (9, 'Тема 2', 2, 5, 15);
INSERT INTO "School_schema"."Plan" OVERRIDING SYSTEM VALUE VALUES (10, 'Тема 3', 3, 5, 15);
INSERT INTO "School_schema"."Plan" OVERRIDING SYSTEM VALUE VALUES (11, 'Тема 4', 4, 6, 15);


--
-- TOC entry 3505 (class 0 OID 37844)
-- Dependencies: 233
-- Data for Name: Schedule; Type: TABLE DATA; Schema: School_schema; Owner: sonya
--

INSERT INTO "School_schema"."Schedule" OVERRIDING SYSTEM VALUE VALUES (1, 'Понедельник', 'Основное', '2022-09-01', '2022-12-31', '08:00:00', '08:45:00', 23, 1);
INSERT INTO "School_schema"."Schedule" OVERRIDING SYSTEM VALUE VALUES (2, 'Четверг', 'Основное', '2022-09-01', '2022-12-31', '08:00:00', '08:45:00', 22, 17);
INSERT INTO "School_schema"."Schedule" OVERRIDING SYSTEM VALUE VALUES (3, 'Вторник', 'Основное', '2022-09-01', '2022-12-31', '10:00:00', '10:45:00', 32, 3);
INSERT INTO "School_schema"."Schedule" OVERRIDING SYSTEM VALUE VALUES (4, 'Среда', 'Основное', '2022-09-01', '2022-12-31', '09:00:00', '09:45:00', 35, 15);
INSERT INTO "School_schema"."Schedule" OVERRIDING SYSTEM VALUE VALUES (5, 'Суббота', 'Секция', '2022-09-01', '2022-12-31', '20:00:00', '21:00:00', 1, 18);


--
-- TOC entry 3487 (class 0 OID 37707)
-- Dependencies: 215
-- Data for Name: Student; Type: TABLE DATA; Schema: School_schema; Owner: sonya
--

INSERT INTO "School_schema"."Student" VALUES (12, 'Перова Екатерина Витальевна', '2005-09-13', 'г. Иваново, ул. Смирнова, д. 15', '+7 (932) 325-34-98', 'lololo23@mail.ru');
INSERT INTO "School_schema"."Student" VALUES (16, 'Енотова Ярослава Афанасьевна', '2005-09-25', NULL, '8 (956) 814-12-67', 'saveme@yandex.ru');
INSERT INTO "School_schema"."Student" VALUES (29, 'Хохорин Антон Емельянович', '2005-06-02', NULL, '+7 (968) 707-86-50', 'anton77@mail.ru');
INSERT INTO "School_schema"."Student" VALUES (19, 'Шабалин Александр Васильевич', '2006-08-24', NULL, '+7 (943) 426-33-20', 'aleksandr08111976@rambler.ru');
INSERT INTO "School_schema"."Student" VALUES (36, 'Сигова Александра Аркадьевна', '2006-11-25', NULL, '8 (924) 287-56-69', 'aleksandra4492@gmail.com');
INSERT INTO "School_schema"."Student" VALUES (76, 'Маслюка София Ивановна', '2007-03-05', NULL, '+7 (969) 334-24-85', 'sofiya45@ya.ru');
INSERT INTO "School_schema"."Student" VALUES (6, 'Бородин Игнат Ефимович', '2008-04-14', 'г. Иваново, ул. Смирнова, д. 32', NULL, 'ignat9318@gmail.com');
INSERT INTO "School_schema"."Student" VALUES (42, 'Шульгин Константин Вячеславович', '2009-03-16', NULL, NULL, 'konstantin25@yandex.ru');
INSERT INTO "School_schema"."Student" VALUES (27, 'Колодезева Юлия Романовна', '2010-07-26', NULL, NULL, NULL);
INSERT INTO "School_schema"."Student" VALUES (24, 'Каретникова Наталия Максимовна', '2011-08-01', NULL, NULL, NULL);


--
-- TOC entry 3497 (class 0 OID 37770)
-- Dependencies: 225
-- Data for Name: Student_in_class; Type: TABLE DATA; Schema: School_schema; Owner: sonya
--

INSERT INTO "School_schema"."Student_in_class" OVERRIDING SYSTEM VALUE VALUES (1, '2022-09-01', '2023-08-30', 'В академ. отпуске', 8, 12);
INSERT INTO "School_schema"."Student_in_class" OVERRIDING SYSTEM VALUE VALUES (2, '2022-09-01', '2023-08-30', 'Числится', 8, 29);
INSERT INTO "School_schema"."Student_in_class" OVERRIDING SYSTEM VALUE VALUES (3, '2022-09-01', '2022-10-30', 'Отчислен', 6, 19);
INSERT INTO "School_schema"."Student_in_class" OVERRIDING SYSTEM VALUE VALUES (4, '2022-09-01', '2023-08-30', 'Числится', 7, 16);
INSERT INTO "School_schema"."Student_in_class" OVERRIDING SYSTEM VALUE VALUES (5, '2019-09-01', '2020-08-30', 'Числился', 3, 19);
INSERT INTO "School_schema"."Student_in_class" OVERRIDING SYSTEM VALUE VALUES (6, '2022-09-01', '2023-08-30', 'Числится', 7, 36);
INSERT INTO "School_schema"."Student_in_class" OVERRIDING SYSTEM VALUE VALUES (7, '2019-09-01', '2020-08-30', 'Числился', 3, 76);
INSERT INTO "School_schema"."Student_in_class" OVERRIDING SYSTEM VALUE VALUES (8, '2023-09-01', '2024-08-30', 'Числится', 5, 42);
INSERT INTO "School_schema"."Student_in_class" OVERRIDING SYSTEM VALUE VALUES (9, '2023-09-01', '2024-08-30', 'Числится', 5, 27);


--
-- TOC entry 3485 (class 0 OID 37693)
-- Dependencies: 213
-- Data for Name: Teacher; Type: TABLE DATA; Schema: School_schema; Owner: sonya
--

INSERT INTO "School_schema"."Teacher" VALUES (334, 'Андреева Светлана Ивановна', '1962-04-12', '4689 852504', 'г. Иваново, ул. Фридриха-Энгельса, д. 3', '+7 (932) 799-59-29', 'andreevaaa@yandex.ru');
INSERT INTO "School_schema"."Teacher" VALUES (121, 'Гатальская Наталия Геннадьевна', '1956-08-24', '4850 300601', 'г. Иваново, ул. Бубнова, д. 15', '+7 (905) 426-91-23', 'gatng@gmail.com');
INSERT INTO "School_schema"."Teacher" VALUES (11, 'Старовойтова Ольга Александровна', '1973-09-02', '4837 833234', 'г. Иваново, ул. Комсомольская, д. 1', '+7 (975) 812-52-91', 'phy_oa@gmail.com');
INSERT INTO "School_schema"."Teacher" VALUES (215, 'Жукова Надежда Генриховна', '1955-12-30', '4155 473447', NULL, '+7 (920) 870-26-49', 'zhuck19553@mail.ru');
INSERT INTO "School_schema"."Teacher" VALUES (15, 'Малышкина Анастасия Владимировна', '2001-07-04', '4482 659238', NULL, '+7 (920) 860-26-59', 'kitty7cat@mail.ru');
INSERT INTO "School_schema"."Teacher" VALUES (64, 'Колобков Сергей Валентинович', '1978-10-22', '4339 509873', NULL, NULL, NULL);
INSERT INTO "School_schema"."Teacher" VALUES (336, 'Мышленник Арсений Геннадьевич', '1977-10-06', '2397 393489', NULL, '8 (920) 860-00-50', 'maaaash@mail.ru');
INSERT INTO "School_schema"."Teacher" VALUES (113, 'Родоманова Дарья Андреевна', '1983-12-14', '4416 155721', NULL, NULL, 'dashenka1727@gmail.com');
INSERT INTO "School_schema"."Teacher" VALUES (98, 'Кузнецова Ксения Дмитриевна', '1998-05-01', '4381 862552', NULL, NULL, NULL);
INSERT INTO "School_schema"."Teacher" VALUES (419, 'Чернышева Анастасия Вадимовна', '1996-05-23', '2417 939311', NULL, NULL, NULL);


--
-- TOC entry 3501 (class 0 OID 37807)
-- Dependencies: 229
-- Data for Name: Workload; Type: TABLE DATA; Schema: School_schema; Owner: sonya
--

INSERT INTO "School_schema"."Workload" OVERRIDING SYSTEM VALUE VALUES (1, 216, '2022-09-01', '2023-08-30', 215, 6, 50);
INSERT INTO "School_schema"."Workload" OVERRIDING SYSTEM VALUE VALUES (2, 144, '2022-09-01', '2023-08-30', 215, 6, 51);
INSERT INTO "School_schema"."Workload" OVERRIDING SYSTEM VALUE VALUES (3, 72, '2022-09-01', '2022-12-31', 113, 6, 52);
INSERT INTO "School_schema"."Workload" OVERRIDING SYSTEM VALUE VALUES (4, 72, '2023-01-01', '2023-08-30', 98, 6, 52);
INSERT INTO "School_schema"."Workload" OVERRIDING SYSTEM VALUE VALUES (5, 108, '2022-09-01', '2023-08-30', 334, 6, 53);
INSERT INTO "School_schema"."Workload" OVERRIDING SYSTEM VALUE VALUES (6, 72, '2022-09-01', '2023-08-30', 334, 6, 54);
INSERT INTO "School_schema"."Workload" OVERRIDING SYSTEM VALUE VALUES (7, 108, '2022-09-01', '2023-08-30', 15, 6, 55);
INSERT INTO "School_schema"."Workload" OVERRIDING SYSTEM VALUE VALUES (8, 144, '2022-09-01', '2023-08-30', 15, 6, 56);
INSERT INTO "School_schema"."Workload" OVERRIDING SYSTEM VALUE VALUES (9, 108, '2022-09-01', '2023-08-30', 64, 6, 57);
INSERT INTO "School_schema"."Workload" OVERRIDING SYSTEM VALUE VALUES (10, 108, '2022-09-01', '2023-08-30', 215, 8, 58);
INSERT INTO "School_schema"."Workload" OVERRIDING SYSTEM VALUE VALUES (11, 72, '2022-09-01', '2022-12-31', 98, 8, 59);
INSERT INTO "School_schema"."Workload" OVERRIDING SYSTEM VALUE VALUES (12, 36, '2023-01-01', '2023-08-30', 113, 8, 59);
INSERT INTO "School_schema"."Workload" OVERRIDING SYSTEM VALUE VALUES (13, 216, '2022-09-01', '2023-08-30', 334, 8, 60);
INSERT INTO "School_schema"."Workload" OVERRIDING SYSTEM VALUE VALUES (14, 144, '2022-09-01', '2023-08-30', 334, 8, 61);
INSERT INTO "School_schema"."Workload" OVERRIDING SYSTEM VALUE VALUES (15, 180, '2022-09-01', '2023-08-30', 419, 8, 62);
INSERT INTO "School_schema"."Workload" OVERRIDING SYSTEM VALUE VALUES (16, 72, '2022-09-01', '2023-08-30', 15, 8, 63);
INSERT INTO "School_schema"."Workload" OVERRIDING SYSTEM VALUE VALUES (17, 180, '2022-09-01', '2023-08-30', 11, 8, 64);
INSERT INTO "School_schema"."Workload" OVERRIDING SYSTEM VALUE VALUES (18, 108, '2022-09-01', '2023-08-30', 64, 8, 57);


--
-- TOC entry 3544 (class 0 OID 0)
-- Dependencies: 240
-- Name: Attendance_attendance_id_seq; Type: SEQUENCE SET; Schema: School_schema; Owner: sonya
--

SELECT pg_catalog.setval('"School_schema"."Attendance_attendance_id_seq"', 5, true);


--
-- TOC entry 3545 (class 0 OID 0)
-- Dependencies: 222
-- Name: Class_class_id_seq; Type: SEQUENCE SET; Schema: School_schema; Owner: sonya
--

SELECT pg_catalog.setval('"School_schema"."Class_class_id_seq"', 8, true);


--
-- TOC entry 3546 (class 0 OID 0)
-- Dependencies: 216
-- Name: Classroom_classroom_number_seq; Type: SEQUENCE SET; Schema: School_schema; Owner: sonya
--

SELECT pg_catalog.setval('"School_schema"."Classroom_classroom_number_seq"', 1, false);


--
-- TOC entry 3547 (class 0 OID 0)
-- Dependencies: 210
-- Name: Curriculum_curriculum_id_seq; Type: SEQUENCE SET; Schema: School_schema; Owner: sonya
--

SELECT pg_catalog.setval('"School_schema"."Curriculum_curriculum_id_seq"', 7, true);


--
-- TOC entry 3548 (class 0 OID 0)
-- Dependencies: 218
-- Name: Discipline_discipline_id_seq; Type: SEQUENCE SET; Schema: School_schema; Owner: sonya
--

SELECT pg_catalog.setval('"School_schema"."Discipline_discipline_id_seq"', 65, true);


--
-- TOC entry 3549 (class 0 OID 0)
-- Dependencies: 220
-- Name: Education_education_id_seq; Type: SEQUENCE SET; Schema: School_schema; Owner: sonya
--

SELECT pg_catalog.setval('"School_schema"."Education_education_id_seq"', 6, true);


--
-- TOC entry 3550 (class 0 OID 0)
-- Dependencies: 238
-- Name: EvaluationTool_evaluation_tool_id_seq; Type: SEQUENCE SET; Schema: School_schema; Owner: sonya
--

SELECT pg_catalog.setval('"School_schema"."EvaluationTool_evaluation_tool_id_seq"', 4, true);


--
-- TOC entry 3551 (class 0 OID 0)
-- Dependencies: 242
-- Name: Grade_grade_id_seq; Type: SEQUENCE SET; Schema: School_schema; Owner: sonya
--

SELECT pg_catalog.setval('"School_schema"."Grade_grade_id_seq"', 4, true);


--
-- TOC entry 3552 (class 0 OID 0)
-- Dependencies: 230
-- Name: Headstudent_headstudent_id_seq; Type: SEQUENCE SET; Schema: School_schema; Owner: sonya
--

SELECT pg_catalog.setval('"School_schema"."Headstudent_headstudent_id_seq"', 3, true);


--
-- TOC entry 3553 (class 0 OID 0)
-- Dependencies: 226
-- Name: Headteacher_headteacher_id_seq; Type: SEQUENCE SET; Schema: School_schema; Owner: sonya
--

SELECT pg_catalog.setval('"School_schema"."Headteacher_headteacher_id_seq"', 3, true);


--
-- TOC entry 3554 (class 0 OID 0)
-- Dependencies: 236
-- Name: Lesson_lesson_id_seq; Type: SEQUENCE SET; Schema: School_schema; Owner: sonya
--

SELECT pg_catalog.setval('"School_schema"."Lesson_lesson_id_seq"', 5, true);


--
-- TOC entry 3555 (class 0 OID 0)
-- Dependencies: 234
-- Name: Plan_plan_id_seq; Type: SEQUENCE SET; Schema: School_schema; Owner: sonya
--

SELECT pg_catalog.setval('"School_schema"."Plan_plan_id_seq"', 11, true);


--
-- TOC entry 3556 (class 0 OID 0)
-- Dependencies: 232
-- Name: Schedule_schedule_id_seq; Type: SEQUENCE SET; Schema: School_schema; Owner: sonya
--

SELECT pg_catalog.setval('"School_schema"."Schedule_schedule_id_seq"', 5, true);


--
-- TOC entry 3557 (class 0 OID 0)
-- Dependencies: 224
-- Name: Student_in_class_student_in_class_id_seq; Type: SEQUENCE SET; Schema: School_schema; Owner: sonya
--

SELECT pg_catalog.setval('"School_schema"."Student_in_class_student_in_class_id_seq"', 9, true);


--
-- TOC entry 3558 (class 0 OID 0)
-- Dependencies: 214
-- Name: Student_student_code_seq; Type: SEQUENCE SET; Schema: School_schema; Owner: sonya
--

SELECT pg_catalog.setval('"School_schema"."Student_student_code_seq"', 1, false);


--
-- TOC entry 3559 (class 0 OID 0)
-- Dependencies: 212
-- Name: Teacher_teacher_personnel_number_seq; Type: SEQUENCE SET; Schema: School_schema; Owner: sonya
--

SELECT pg_catalog.setval('"School_schema"."Teacher_teacher_personnel_number_seq"', 1, false);


--
-- TOC entry 3560 (class 0 OID 0)
-- Dependencies: 228
-- Name: Workload_workload_id_seq; Type: SEQUENCE SET; Schema: School_schema; Owner: sonya
--

SELECT pg_catalog.setval('"School_schema"."Workload_workload_id_seq"', 18, true);


--
-- TOC entry 3320 (class 2606 OID 37913)
-- Name: Attendance Attendance_pkey; Type: CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Attendance"
    ADD CONSTRAINT "Attendance_pkey" PRIMARY KEY (attendance_id);


--
-- TOC entry 3300 (class 2606 OID 37763)
-- Name: Class Class_pkey; Type: CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Class"
    ADD CONSTRAINT "Class_pkey" PRIMARY KEY (class_id);


--
-- TOC entry 3292 (class 2606 OID 37723)
-- Name: Classroom Classroom_pkey; Type: CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Classroom"
    ADD CONSTRAINT "Classroom_pkey" PRIMARY KEY (classroom_number);


--
-- TOC entry 3284 (class 2606 OID 37691)
-- Name: Curriculum Curriculum_pkey; Type: CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Curriculum"
    ADD CONSTRAINT "Curriculum_pkey" PRIMARY KEY (curriculum_id);


--
-- TOC entry 3294 (class 2606 OID 37732)
-- Name: Discipline Discipline_pkey; Type: CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Discipline"
    ADD CONSTRAINT "Discipline_pkey" PRIMARY KEY (discipline_id);


--
-- TOC entry 3296 (class 2606 OID 37748)
-- Name: Education Education_pkey; Type: CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Education"
    ADD CONSTRAINT "Education_pkey" PRIMARY KEY (education_id);


--
-- TOC entry 3318 (class 2606 OID 37900)
-- Name: EvaluationTool EvaluationTool_pkey; Type: CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."EvaluationTool"
    ADD CONSTRAINT "EvaluationTool_pkey" PRIMARY KEY (evaluation_tool_id);


--
-- TOC entry 3322 (class 2606 OID 37932)
-- Name: Grade Grade_pkey; Type: CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Grade"
    ADD CONSTRAINT "Grade_pkey" PRIMARY KEY (grade_id);


--
-- TOC entry 3308 (class 2606 OID 37837)
-- Name: Headstudent Headstudent_pkey; Type: CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Headstudent"
    ADD CONSTRAINT "Headstudent_pkey" PRIMARY KEY (headstudent_id);


--
-- TOC entry 3304 (class 2606 OID 37795)
-- Name: Headteacher Headteacher_pkey; Type: CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Headteacher"
    ADD CONSTRAINT "Headteacher_pkey" PRIMARY KEY (headteacher_id);


--
-- TOC entry 3316 (class 2606 OID 37886)
-- Name: Lesson Lesson_pkey; Type: CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Lesson"
    ADD CONSTRAINT "Lesson_pkey" PRIMARY KEY (lesson_id);


--
-- TOC entry 3312 (class 2606 OID 37872)
-- Name: Plan Plan_pkey; Type: CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Plan"
    ADD CONSTRAINT "Plan_pkey" PRIMARY KEY (plan_id);


--
-- TOC entry 3310 (class 2606 OID 37854)
-- Name: Schedule Schedule_pkey; Type: CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Schedule"
    ADD CONSTRAINT "Schedule_pkey" PRIMARY KEY (schedule_id);


--
-- TOC entry 3302 (class 2606 OID 37777)
-- Name: Student_in_class Student_in_class_pkey; Type: CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Student_in_class"
    ADD CONSTRAINT "Student_in_class_pkey" PRIMARY KEY (student_in_class_id);


--
-- TOC entry 3290 (class 2606 OID 37715)
-- Name: Student Student_pkey; Type: CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Student"
    ADD CONSTRAINT "Student_pkey" PRIMARY KEY (student_code);


--
-- TOC entry 3286 (class 2606 OID 37703)
-- Name: Teacher Teacher_pkey; Type: CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Teacher"
    ADD CONSTRAINT "Teacher_pkey" PRIMARY KEY (teacher_personnel_number);


--
-- TOC entry 3306 (class 2606 OID 37814)
-- Name: Workload Workload_pkey; Type: CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Workload"
    ADD CONSTRAINT "Workload_pkey" PRIMARY KEY (workload_id);


--
-- TOC entry 3314 (class 2606 OID 37874)
-- Name: Plan unique_combination_of_workload_and_topic_num; Type: CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Plan"
    ADD CONSTRAINT unique_combination_of_workload_and_topic_num UNIQUE (topic_number, workload_id);


--
-- TOC entry 3298 (class 2606 OID 37750)
-- Name: Education unique_diploma; Type: CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Education"
    ADD CONSTRAINT unique_diploma UNIQUE (diploma);


--
-- TOC entry 3288 (class 2606 OID 37705)
-- Name: Teacher unique_passport; Type: CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Teacher"
    ADD CONSTRAINT unique_passport UNIQUE (passport);


--
-- TOC entry 3340 (class 2606 OID 37919)
-- Name: Attendance Attendance_lesson_id_fkey; Type: FK CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Attendance"
    ADD CONSTRAINT "Attendance_lesson_id_fkey" FOREIGN KEY (lesson_id) REFERENCES "School_schema"."Lesson"(lesson_id);


--
-- TOC entry 3339 (class 2606 OID 37914)
-- Name: Attendance Attendance_student_in_class_id_fkey; Type: FK CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Attendance"
    ADD CONSTRAINT "Attendance_student_in_class_id_fkey" FOREIGN KEY (student_in_class_id) REFERENCES "School_schema"."Student_in_class"(student_in_class_id);


--
-- TOC entry 3325 (class 2606 OID 37764)
-- Name: Class Class_curriculum_id_fkey; Type: FK CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Class"
    ADD CONSTRAINT "Class_curriculum_id_fkey" FOREIGN KEY (curriculum_id) REFERENCES "School_schema"."Curriculum"(curriculum_id);


--
-- TOC entry 3323 (class 2606 OID 37733)
-- Name: Discipline Discipline_curriculum_id_fkey; Type: FK CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Discipline"
    ADD CONSTRAINT "Discipline_curriculum_id_fkey" FOREIGN KEY (curriculum_id) REFERENCES "School_schema"."Curriculum"(curriculum_id);


--
-- TOC entry 3324 (class 2606 OID 37751)
-- Name: Education Education_teacher_personnel_number_fkey; Type: FK CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Education"
    ADD CONSTRAINT "Education_teacher_personnel_number_fkey" FOREIGN KEY (teacher_personnel_number) REFERENCES "School_schema"."Teacher"(teacher_personnel_number);


--
-- TOC entry 3338 (class 2606 OID 37901)
-- Name: EvaluationTool EvaluationTool_plan_id_fkey; Type: FK CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."EvaluationTool"
    ADD CONSTRAINT "EvaluationTool_plan_id_fkey" FOREIGN KEY (plan_id) REFERENCES "School_schema"."Plan"(plan_id);


--
-- TOC entry 3341 (class 2606 OID 37933)
-- Name: Grade Grade_attendance_id_fkey; Type: FK CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Grade"
    ADD CONSTRAINT "Grade_attendance_id_fkey" FOREIGN KEY (attendance_id) REFERENCES "School_schema"."Attendance"(attendance_id);


--
-- TOC entry 3342 (class 2606 OID 37938)
-- Name: Grade Grade_evaluation_tool_id_fkey; Type: FK CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Grade"
    ADD CONSTRAINT "Grade_evaluation_tool_id_fkey" FOREIGN KEY (evaluation_tool_id) REFERENCES "School_schema"."EvaluationTool"(evaluation_tool_id);


--
-- TOC entry 3333 (class 2606 OID 37838)
-- Name: Headstudent Headstudent_student_in_class_id_fkey; Type: FK CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Headstudent"
    ADD CONSTRAINT "Headstudent_student_in_class_id_fkey" FOREIGN KEY (student_in_class_id) REFERENCES "School_schema"."Student_in_class"(student_in_class_id);


--
-- TOC entry 3328 (class 2606 OID 37801)
-- Name: Headteacher Headteacher_class_id_fkey; Type: FK CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Headteacher"
    ADD CONSTRAINT "Headteacher_class_id_fkey" FOREIGN KEY (class_id) REFERENCES "School_schema"."Class"(class_id);


--
-- TOC entry 3329 (class 2606 OID 37796)
-- Name: Headteacher Headteacher_teacher_personnel_number_fkey; Type: FK CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Headteacher"
    ADD CONSTRAINT "Headteacher_teacher_personnel_number_fkey" FOREIGN KEY (teacher_personnel_number) REFERENCES "School_schema"."Teacher"(teacher_personnel_number);


--
-- TOC entry 3337 (class 2606 OID 37887)
-- Name: Lesson Lesson_schedule_id_fkey; Type: FK CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Lesson"
    ADD CONSTRAINT "Lesson_schedule_id_fkey" FOREIGN KEY (schedule_id) REFERENCES "School_schema"."Schedule"(schedule_id);


--
-- TOC entry 3336 (class 2606 OID 37875)
-- Name: Plan Plan_workload_id_fkey; Type: FK CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Plan"
    ADD CONSTRAINT "Plan_workload_id_fkey" FOREIGN KEY (workload_id) REFERENCES "School_schema"."Workload"(workload_id);


--
-- TOC entry 3334 (class 2606 OID 37855)
-- Name: Schedule Schedule_classroom_number_fkey; Type: FK CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Schedule"
    ADD CONSTRAINT "Schedule_classroom_number_fkey" FOREIGN KEY (classroom_number) REFERENCES "School_schema"."Classroom"(classroom_number);


--
-- TOC entry 3335 (class 2606 OID 37860)
-- Name: Schedule Schedule_workload_id_fkey; Type: FK CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Schedule"
    ADD CONSTRAINT "Schedule_workload_id_fkey" FOREIGN KEY (workload_id) REFERENCES "School_schema"."Workload"(workload_id);


--
-- TOC entry 3326 (class 2606 OID 37778)
-- Name: Student_in_class Student_in_class_class_id_fkey; Type: FK CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Student_in_class"
    ADD CONSTRAINT "Student_in_class_class_id_fkey" FOREIGN KEY (class_id) REFERENCES "School_schema"."Class"(class_id);


--
-- TOC entry 3327 (class 2606 OID 37783)
-- Name: Student_in_class Student_in_class_student_code_fkey; Type: FK CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Student_in_class"
    ADD CONSTRAINT "Student_in_class_student_code_fkey" FOREIGN KEY (student_code) REFERENCES "School_schema"."Student"(student_code);


--
-- TOC entry 3331 (class 2606 OID 37820)
-- Name: Workload Workload_class_id_fkey; Type: FK CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Workload"
    ADD CONSTRAINT "Workload_class_id_fkey" FOREIGN KEY (class_id) REFERENCES "School_schema"."Class"(class_id);


--
-- TOC entry 3332 (class 2606 OID 37825)
-- Name: Workload Workload_discipline_id_fkey; Type: FK CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Workload"
    ADD CONSTRAINT "Workload_discipline_id_fkey" FOREIGN KEY (discipline_id) REFERENCES "School_schema"."Discipline"(discipline_id);


--
-- TOC entry 3330 (class 2606 OID 37815)
-- Name: Workload Workload_teacher_personnel_number_fkey; Type: FK CONSTRAINT; Schema: School_schema; Owner: sonya
--

ALTER TABLE ONLY "School_schema"."Workload"
    ADD CONSTRAINT "Workload_teacher_personnel_number_fkey" FOREIGN KEY (teacher_personnel_number) REFERENCES "School_schema"."Teacher"(teacher_personnel_number);


-- Completed on 2023-02-23 14:43:17

--
-- PostgreSQL database dump complete
--

