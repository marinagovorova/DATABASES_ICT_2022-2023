--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

-- Started on 2023-06-05 00:45:56

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
-- TOC entry 5 (class 2615 OID 2200)
-- Name: lab; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA lab;


ALTER SCHEMA lab OWNER TO pg_database_owner;

--
-- TOC entry 6 (class 2615 OID 16632)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3457 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 221 (class 1259 OID 16429)
-- Name: attestation; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab.attestation (
    att_date date NOT NULL,
    grade real NOT NULL,
    number_attempt integer NOT NULL,
    id_program_disc character varying(16) NOT NULL,
    id_is_studying character varying(32) NOT NULL,
    id_teacher integer NOT NULL
);


ALTER TABLE lab.attestation OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16447)
-- Name: building; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab.building (
    c_short_name character varying(8) NOT NULL,
    type character varying(20) NOT NULL
);


ALTER TABLE lab.building OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16517)
-- Name: classroom; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab.classroom (
    id_classroom character varying(20) NOT NULL,
    capacity integer NOT NULL,
    name_classr character varying(20),
    address_classr character varying(255) NOT NULL,
    short_name character varying(8)
);


ALTER TABLE lab.classroom OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16414)
-- Name: department; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab.department (
    id_dep character varying(8) NOT NULL,
    s_name_dep character varying(8) NOT NULL,
    name_dep character varying(255) NOT NULL
);


ALTER TABLE lab.department OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16424)
-- Name: discipline; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab.discipline (
    id_disc character varying(16) NOT NULL,
    lectures_hours integer,
    practice_hours integer,
    labs_hours integer,
    name_disc character varying(255) NOT NULL,
    type_att character varying(25) NOT NULL,
    amount_hours integer NOT NULL
);


ALTER TABLE lab.discipline OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16457)
-- Name: is_studying; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab.is_studying (
    date_end date,
    date_start date NOT NULL,
    status character varying(30) NOT NULL,
    payment_form character varying(10) NOT NULL,
    id_group character varying(32) NOT NULL,
    id_student integer NOT NULL,
    sch_from date,
    id_is_studying character varying(32) NOT NULL
);


ALTER TABLE lab.is_studying OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16442)
-- Name: l_group; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab.l_group (
    id_group character varying(32) NOT NULL,
    "from" date NOT NULL,
    "to" date,
    amount_students integer NOT NULL,
    year integer NOT NULL,
    group_number character varying(6) NOT NULL,
    id_plan character varying(10) NOT NULL
);


ALTER TABLE lab.l_group OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16409)
-- Name: plan; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab.plan (
    id_plan character varying(10) NOT NULL,
    year date,
    id_program character varying(20) NOT NULL
);


ALTER TABLE lab.plan OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16419)
-- Name: plan_disc; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab.plan_disc (
    id_program_disc character varying(16) NOT NULL,
    semester integer NOT NULL,
    id_disc character varying(16) NOT NULL,
    id_plan character varying(20) NOT NULL
);


ALTER TABLE lab.plan_disc OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16404)
-- Name: program; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab.program (
    id_program character varying(20) NOT NULL,
    budget integer,
    name_prog character varying(255) NOT NULL,
    short_name_prog character varying(50) NOT NULL,
    contract integer,
    international integer,
    id_dep character varying(8) NOT NULL,
    id_spec character varying(20) NOT NULL
);


ALTER TABLE lab.program OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16460)
-- Name: scholarship; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab.scholarship (
    sch_from date NOT NULL,
    "to" date,
    id_sch character varying(10)
);


ALTER TABLE lab.scholarship OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16439)
-- Name: session_tt; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab.session_tt (
    time_start date NOT NULL,
    time_end date NOT NULL,
    id_group character varying(32) NOT NULL,
    id_program_disc character varying(16) NOT NULL,
    id_teacher integer NOT NULL,
    id_classroom character varying(20) NOT NULL
);


ALTER TABLE lab.session_tt OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16399)
-- Name: specs; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab.specs (
    id_spec character varying(20) NOT NULL,
    level character varying(15) NOT NULL,
    name_spec character varying(255) NOT NULL
);


ALTER TABLE lab.specs OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16452)
-- Name: student; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab.student (
    id_student integer NOT NULL,
    full_name character varying(255) NOT NULL
);


ALTER TABLE lab.student OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16434)
-- Name: teacher; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab.teacher (
    id_teacher integer NOT NULL,
    name_teacher character varying(255) NOT NULL,
    "position" character varying(80) NOT NULL
);


ALTER TABLE lab.teacher OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16465)
-- Name: type_scholarship; Type: TABLE; Schema: lab; Owner: postgres
--

CREATE TABLE lab.type_scholarship (
    id_sch character varying(10) NOT NULL,
    type character varying(20) NOT NULL,
    amount_sch integer NOT NULL,
    sch_descr character varying(255) NOT NULL
);


ALTER TABLE lab.type_scholarship OWNER TO postgres;

--
-- TOC entry 3442 (class 0 OID 16429)
-- Dependencies: 221
-- Data for Name: attestation; Type: TABLE DATA; Schema: lab; Owner: postgres
--

COPY lab.attestation (att_date, grade, number_attempt, id_program_disc, id_is_studying, id_teacher) FROM stdin;
\.


--
-- TOC entry 3446 (class 0 OID 16447)
-- Dependencies: 225
-- Data for Name: building; Type: TABLE DATA; Schema: lab; Owner: postgres
--

COPY lab.building (c_short_name, type) FROM stdin;
АЛЕК	Жилой
ЯССК	Библиотека
ФОЧШ	Учебный
АРАД	Учебно-лаб.
ТАРГ	Научно-иссл.
САТУ	Жилой
БРАШ	Спортивный
ОРАШ	Кафетерий
КРАЙ	Учебный
САГУ	Учебно-лаб.
\.


--
-- TOC entry 3451 (class 0 OID 16517)
-- Dependencies: 230
-- Data for Name: classroom; Type: TABLE DATA; Schema: lab; Owner: postgres
--

COPY lab.classroom (id_classroom, capacity, name_classr, address_classr, short_name) FROM stdin;
lear335	260	D340	Оранжево-Бухарестская, дом 12, корпус 2	АЛЕК
room002	170	Z2	Фиолетово-Клужская, дом 8, корпус 1	ТАРГ
lear331	125	A336	Зелено-Констанцская, дом 15, корпус 3	ОРАШ
room003	220	329	Синьо-Ясская, дом 10, корпус 5	ЯССК
\.


--
-- TOC entry 3439 (class 0 OID 16414)
-- Dependencies: 218
-- Data for Name: department; Type: TABLE DATA; Schema: lab; Owner: postgres
--

COPY lab.department (id_dep, s_name_dep, name_dep) FROM stdin;
l91\n	ИЦТ	Инновационный центр технологий\n
I1Y	ФКН	Факультет компьютерных наук
66K	ЭМФ	Экономический и математический факультет
CMO	МИЭМ	Механико-математический факультет
KNM	ГФ	Гуманитарный факультет
LKZ	ИНЭЛ	Инженерно-экономический факультет
AD7	ФПУ	Факультет педагогики и управления
\.


--
-- TOC entry 3441 (class 0 OID 16424)
-- Dependencies: 220
-- Data for Name: discipline; Type: TABLE DATA; Schema: lab; Owner: postgres
--

COPY lab.discipline (id_disc, lectures_hours, practice_hours, labs_hours, name_disc, type_att, amount_hours) FROM stdin;
FMWVLK4Z4NLO20SV	41	22	7	Математика	Зачёт	70
22ZKR3NS6T1B7JOT	45	19	16	Физика	Экзамен	80
GBQS924NAHFEJCSQ	25	25	23	Информатика	Зачёт	73
JEX6VRVC2P54D0BH	43	17	17	Химия	Зачёт	77
KY2WUC7UA16TUFCK	33	28	8	Биология	Зачёт	69
MM3ZW4RVZ45X69E3	18	30	23	История	Зачёт	71
R4018QE7RSJJFX3V	37	28	15	География	Экзамен	80
\.


--
-- TOC entry 3448 (class 0 OID 16457)
-- Dependencies: 227
-- Data for Name: is_studying; Type: TABLE DATA; Schema: lab; Owner: postgres
--

COPY lab.is_studying (date_end, date_start, status, payment_form, id_group, id_student, sch_from, id_is_studying) FROM stdin;
\.


--
-- TOC entry 3445 (class 0 OID 16442)
-- Dependencies: 224
-- Data for Name: l_group; Type: TABLE DATA; Schema: lab; Owner: postgres
--

COPY lab.l_group (id_group, "from", "to", amount_students, year, group_number, id_plan) FROM stdin;
\.


--
-- TOC entry 3438 (class 0 OID 16409)
-- Dependencies: 217
-- Data for Name: plan; Type: TABLE DATA; Schema: lab; Owner: postgres
--

COPY lab.plan (id_plan, year, id_program) FROM stdin;
\.


--
-- TOC entry 3440 (class 0 OID 16419)
-- Dependencies: 219
-- Data for Name: plan_disc; Type: TABLE DATA; Schema: lab; Owner: postgres
--

COPY lab.plan_disc (id_program_disc, semester, id_disc, id_plan) FROM stdin;
\.


--
-- TOC entry 3437 (class 0 OID 16404)
-- Dependencies: 216
-- Data for Name: program; Type: TABLE DATA; Schema: lab; Owner: postgres
--

COPY lab.program (id_program, budget, name_prog, short_name_prog, contract, international, id_dep, id_spec) FROM stdin;
PROG001	300	Кибернетическая машина	Кибермашина	50	20	I1Y	SPEC001
PROG002	250	Фантастическая инженерия	Фант-инж	40	15	I1Y	SPEC002
PROG003	400	Робототехника и виртуальная реальность	Роботика VR	60	10	66K	SPEC003
PROG004	350	Инновационные технологии искусственного интеллекта	Иннов-ИИ	45	18	CMO	SPEC004
PROG005	200	Устойчивое развитие и энергетика будущего	Устойч-Энергия	30	12	KNM	SPEC005
PROG006	450	Архитектура интеллектуальных городов	Архит-Города	55	25	LKZ	SPEC006
PROG007	400	Мультимедийное искусство и визуальные эффекты	Мультимедиа	50	20	AD7	SPEC007
PROG008	350	Космические исследования и звездные путешествия	Космо-Исслед	40	15	LKZ	SPEC008
PROG009	300	Цифровой маркетинг и виртуальная коммуникация	Цифр-Маркет	60	10	I1Y	SPEC009
PROG010	250	Генетическая инженерия и биотехнологии	Ген-Инжен	45	18	66K	SPEC010
\.


--
-- TOC entry 3449 (class 0 OID 16460)
-- Dependencies: 228
-- Data for Name: scholarship; Type: TABLE DATA; Schema: lab; Owner: postgres
--

COPY lab.scholarship (sch_from, "to", id_sch) FROM stdin;
\.


--
-- TOC entry 3444 (class 0 OID 16439)
-- Dependencies: 223
-- Data for Name: session_tt; Type: TABLE DATA; Schema: lab; Owner: postgres
--

COPY lab.session_tt (time_start, time_end, id_group, id_program_disc, id_teacher, id_classroom) FROM stdin;
\.


--
-- TOC entry 3436 (class 0 OID 16399)
-- Dependencies: 215
-- Data for Name: specs; Type: TABLE DATA; Schema: lab; Owner: postgres
--

COPY lab.specs (id_spec, level, name_spec) FROM stdin;
SPEC001	Бакалавриат	Кибернетический мироздатель
SPEC002	Бакалавриат	Инженерия фантастических технологий
SPEC003	Бакалавриат	Робототехника и виртуальная реальность
SPEC004	Бакалавриат	Инновационное пространство искусственного интеллекта
SPEC005	Магистратура	Экосистема устойчивого развития и энергетики будущего
SPEC006	Магистратура	Архитектура интеллектуальных городов
SPEC007	Бакалавриат	Мультимедийное искусство и визуальные эффекты
SPEC008	Бакалавриат	Технологии космического исследования и звездных путешествий
SPEC009	Бакалавриат	Цифровой маркетинг и виртуальная коммуникация
SPEC010	Бакалавриат	Генетическая инженерия и биотехнологии
\.


--
-- TOC entry 3447 (class 0 OID 16452)
-- Dependencies: 226
-- Data for Name: student; Type: TABLE DATA; Schema: lab; Owner: postgres
--

COPY lab.student (id_student, full_name) FROM stdin;
\.


--
-- TOC entry 3443 (class 0 OID 16434)
-- Dependencies: 222
-- Data for Name: teacher; Type: TABLE DATA; Schema: lab; Owner: postgres
--

COPY lab.teacher (id_teacher, name_teacher, "position") FROM stdin;
\.


--
-- TOC entry 3450 (class 0 OID 16465)
-- Dependencies: 229
-- Data for Name: type_scholarship; Type: TABLE DATA; Schema: lab; Owner: postgres
--

COPY lab.type_scholarship (id_sch, type, amount_sch, sch_descr) FROM stdin;
\.


--
-- TOC entry 3236 (class 2606 OID 16622)
-- Name: attestation attestation_att_date_check; Type: CHECK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE lab.attestation
    ADD CONSTRAINT attestation_att_date_check CHECK ((att_date > '2019-01-01'::date)) NOT VALID;


--
-- TOC entry 3237 (class 2606 OID 16631)
-- Name: attestation attestation_number_attempt_check; Type: CHECK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE lab.attestation
    ADD CONSTRAINT attestation_number_attempt_check CHECK (((number_attempt >= 1) AND (number_attempt <= 3))) NOT VALID;


--
-- TOC entry 3263 (class 2606 OID 16451)
-- Name: building building_pkey; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.building
    ADD CONSTRAINT building_pkey PRIMARY KEY (c_short_name);


--
-- TOC entry 3275 (class 2606 OID 16521)
-- Name: classroom classroom_pkey; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.classroom
    ADD CONSTRAINT classroom_pkey PRIMARY KEY (id_classroom);


--
-- TOC entry 3251 (class 2606 OID 16418)
-- Name: department department_pkey; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (id_dep);


--
-- TOC entry 3234 (class 2606 OID 16629)
-- Name: discipline discipline_amount_hours_check; Type: CHECK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE lab.discipline
    ADD CONSTRAINT discipline_amount_hours_check CHECK ((amount_hours > 0)) NOT VALID;


--
-- TOC entry 3255 (class 2606 OID 16428)
-- Name: discipline discipline_pkey; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.discipline
    ADD CONSTRAINT discipline_pkey PRIMARY KEY (id_disc);


--
-- TOC entry 3235 (class 2606 OID 16630)
-- Name: discipline discipline_type_att_check; Type: CHECK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE lab.discipline
    ADD CONSTRAINT discipline_type_att_check CHECK ((((type_att)::text = 'Зачёт'::text) OR ((type_att)::text = 'Дифференцированный зачёт'::text) OR ((type_att)::text = 'Экзамен'::text))) NOT VALID;


--
-- TOC entry 3261 (class 2606 OID 16446)
-- Name: l_group group_pkey; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.l_group
    ADD CONSTRAINT group_pkey PRIMARY KEY (id_group);


--
-- TOC entry 3267 (class 2606 OID 16575)
-- Name: is_studying is_studying_pkey; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.is_studying
    ADD CONSTRAINT is_studying_pkey PRIMARY KEY (id_is_studying);


--
-- TOC entry 3238 (class 2606 OID 16624)
-- Name: l_group l_group_amount_students_check; Type: CHECK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE lab.l_group
    ADD CONSTRAINT l_group_amount_students_check CHECK (((amount_students > 1) AND (amount_students < 40))) NOT VALID;


--
-- TOC entry 3239 (class 2606 OID 16625)
-- Name: l_group l_group_year_check; Type: CHECK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE lab.l_group
    ADD CONSTRAINT l_group_year_check CHECK (((year > 1) AND (year < 6))) NOT VALID;


--
-- TOC entry 3253 (class 2606 OID 16423)
-- Name: plan_disc plan_disc_pkey; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.plan_disc
    ADD CONSTRAINT plan_disc_pkey PRIMARY KEY (id_program_disc);


--
-- TOC entry 3249 (class 2606 OID 16413)
-- Name: plan plan_pkey; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.plan
    ADD CONSTRAINT plan_pkey PRIMARY KEY (id_plan);


--
-- TOC entry 3233 (class 2606 OID 16621)
-- Name: program program_budget_check; Type: CHECK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE lab.program
    ADD CONSTRAINT program_budget_check CHECK ((budget < 500)) NOT VALID;


--
-- TOC entry 3245 (class 2606 OID 16620)
-- Name: program program_id_program_id_program1_key; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.program
    ADD CONSTRAINT program_id_program_id_program1_key UNIQUE (id_program) INCLUDE (id_program);


--
-- TOC entry 3247 (class 2606 OID 16408)
-- Name: program program_pkey; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.program
    ADD CONSTRAINT program_pkey PRIMARY KEY (id_program);


--
-- TOC entry 3269 (class 2606 OID 16464)
-- Name: scholarship scholarship_pkey; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.scholarship
    ADD CONSTRAINT scholarship_pkey PRIMARY KEY (sch_from);


--
-- TOC entry 3240 (class 2606 OID 16623)
-- Name: scholarship scholarship_sch_from_check; Type: CHECK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE lab.scholarship
    ADD CONSTRAINT scholarship_sch_from_check CHECK ((sch_from > '2023-01-01'::date)) NOT VALID;


--
-- TOC entry 3243 (class 2606 OID 16403)
-- Name: specs specs_pkey; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.specs
    ADD CONSTRAINT specs_pkey PRIMARY KEY (id_spec);


--
-- TOC entry 3265 (class 2606 OID 16456)
-- Name: student student_pkey; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (id_student);


--
-- TOC entry 3257 (class 2606 OID 16433)
-- Name: attestation teacher_pkey; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.attestation
    ADD CONSTRAINT teacher_pkey PRIMARY KEY (att_date);


--
-- TOC entry 3259 (class 2606 OID 16438)
-- Name: teacher teacher_pkey1; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.teacher
    ADD CONSTRAINT teacher_pkey1 PRIMARY KEY (id_teacher);


--
-- TOC entry 3241 (class 2606 OID 16618)
-- Name: type_scholarship type_scholarship_amount_sch_check; Type: CHECK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE lab.type_scholarship
    ADD CONSTRAINT type_scholarship_amount_sch_check CHECK ((amount_sch > 0)) NOT VALID;


--
-- TOC entry 3271 (class 2606 OID 16617)
-- Name: type_scholarship type_scholarship_id_sch_id_sch1_key; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.type_scholarship
    ADD CONSTRAINT type_scholarship_id_sch_id_sch1_key UNIQUE (id_sch) INCLUDE (id_sch);


--
-- TOC entry 3273 (class 2606 OID 16469)
-- Name: type_scholarship type_scholarship_pkey; Type: CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.type_scholarship
    ADD CONSTRAINT type_scholarship_pkey PRIMARY KEY (id_sch);


--
-- TOC entry 3281 (class 2606 OID 16576)
-- Name: attestation attestation_id_is_studying_fkey; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.attestation
    ADD CONSTRAINT attestation_id_is_studying_fkey FOREIGN KEY (id_is_studying) REFERENCES lab.is_studying(id_is_studying) NOT VALID;


--
-- TOC entry 3282 (class 2606 OID 16581)
-- Name: attestation attestation_id_program_disc_fkey; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.attestation
    ADD CONSTRAINT attestation_id_program_disc_fkey FOREIGN KEY (id_program_disc) REFERENCES lab.plan_disc(id_program_disc) NOT VALID;


--
-- TOC entry 3283 (class 2606 OID 16586)
-- Name: attestation attestation_id_teacher_fkey; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.attestation
    ADD CONSTRAINT attestation_id_teacher_fkey FOREIGN KEY (id_teacher) REFERENCES lab.teacher(id_teacher) NOT VALID;


--
-- TOC entry 3293 (class 2606 OID 16522)
-- Name: classroom classroom_short_name_fkey; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.classroom
    ADD CONSTRAINT classroom_short_name_fkey FOREIGN KEY (short_name) REFERENCES lab.building(c_short_name);


--
-- TOC entry 3289 (class 2606 OID 16477)
-- Name: is_studying is_studying_id_group_fkey; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.is_studying
    ADD CONSTRAINT is_studying_id_group_fkey FOREIGN KEY (id_group) REFERENCES lab.l_group(id_group) NOT VALID;


--
-- TOC entry 3290 (class 2606 OID 16507)
-- Name: is_studying is_studying_id_student_fkey; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.is_studying
    ADD CONSTRAINT is_studying_id_student_fkey FOREIGN KEY (id_student) REFERENCES lab.student(id_student) NOT VALID;


--
-- TOC entry 3291 (class 2606 OID 16482)
-- Name: is_studying is_studying_sch_from_fkey; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.is_studying
    ADD CONSTRAINT is_studying_sch_from_fkey FOREIGN KEY (sch_from) REFERENCES lab.scholarship(sch_from) NOT VALID;


--
-- TOC entry 3288 (class 2606 OID 16611)
-- Name: l_group l_group_id_plan_fkey; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.l_group
    ADD CONSTRAINT l_group_id_plan_fkey FOREIGN KEY (id_plan) REFERENCES lab.plan(id_plan) NOT VALID;


--
-- TOC entry 3279 (class 2606 OID 16549)
-- Name: plan_disc plan_disc_id_disc_fkey; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.plan_disc
    ADD CONSTRAINT plan_disc_id_disc_fkey FOREIGN KEY (id_disc) REFERENCES lab.discipline(id_disc) NOT VALID;


--
-- TOC entry 3280 (class 2606 OID 16569)
-- Name: plan_disc plan_disc_id_plan_fkey; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.plan_disc
    ADD CONSTRAINT plan_disc_id_plan_fkey FOREIGN KEY (id_plan) REFERENCES lab.plan(id_plan) NOT VALID;


--
-- TOC entry 3278 (class 2606 OID 16564)
-- Name: plan plan_id_program_fkey; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.plan
    ADD CONSTRAINT plan_id_program_fkey FOREIGN KEY (id_program) REFERENCES lab.program(id_program) NOT VALID;


--
-- TOC entry 3276 (class 2606 OID 16554)
-- Name: program program_id_dep_fkey; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.program
    ADD CONSTRAINT program_id_dep_fkey FOREIGN KEY (id_dep) REFERENCES lab.department(id_dep) NOT VALID;


--
-- TOC entry 3277 (class 2606 OID 16559)
-- Name: program program_id_spec_fkey; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.program
    ADD CONSTRAINT program_id_spec_fkey FOREIGN KEY (id_spec) REFERENCES lab.specs(id_spec) NOT VALID;


--
-- TOC entry 3292 (class 2606 OID 16470)
-- Name: scholarship sch_fkey; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.scholarship
    ADD CONSTRAINT sch_fkey FOREIGN KEY (id_sch) REFERENCES lab.type_scholarship(id_sch) NOT VALID;


--
-- TOC entry 3284 (class 2606 OID 16601)
-- Name: session_tt session_tt_id_classroom_fkey; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.session_tt
    ADD CONSTRAINT session_tt_id_classroom_fkey FOREIGN KEY (id_classroom) REFERENCES lab.classroom(id_classroom) NOT VALID;


--
-- TOC entry 3285 (class 2606 OID 16606)
-- Name: session_tt session_tt_id_group_fkey; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.session_tt
    ADD CONSTRAINT session_tt_id_group_fkey FOREIGN KEY (id_group) REFERENCES lab.l_group(id_group) NOT VALID;


--
-- TOC entry 3286 (class 2606 OID 16591)
-- Name: session_tt session_tt_id_program_disc_fkey; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.session_tt
    ADD CONSTRAINT session_tt_id_program_disc_fkey FOREIGN KEY (id_program_disc) REFERENCES lab.plan_disc(id_program_disc) NOT VALID;


--
-- TOC entry 3287 (class 2606 OID 16596)
-- Name: session_tt session_tt_id_teacher_fkey; Type: FK CONSTRAINT; Schema: lab; Owner: postgres
--

ALTER TABLE ONLY lab.session_tt
    ADD CONSTRAINT session_tt_id_teacher_fkey FOREIGN KEY (id_teacher) REFERENCES lab.teacher(id_teacher) NOT VALID;


--
-- TOC entry 3458 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2023-06-05 00:45:57

--
-- PostgreSQL database dump complete
--

