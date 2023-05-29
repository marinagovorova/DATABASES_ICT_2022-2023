--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7
-- Dumped by pg_dump version 14.7

-- Started on 2023-03-16 18:32:11

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
-- TOC entry 5 (class 2615 OID 16395)
-- Name: structure; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA structure;


ALTER SCHEMA structure OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 16401)
-- Name: auditory; Type: TABLE; Schema: structure; Owner: postgres
--

CREATE TABLE structure.auditory (
    building_no integer NOT NULL,
    auditory_no integer NOT NULL,
    value_of_seats integer NOT NULL,
    auditory_type character varying(12)
);


ALTER TABLE structure.auditory OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16406)
-- Name: building; Type: TABLE; Schema: structure; Owner: postgres
--

CREATE TABLE structure.building (
    adress character varying(64) NOT NULL,
    city character varying(18) NOT NULL,
    building_no integer NOT NULL,
    name character varying(18)
);


ALTER TABLE structure.building OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17532)
-- Name: direction; Type: TABLE; Schema: structure; Owner: postgres
--

CREATE TABLE structure.direction (
    direction_code character varying(12) NOT NULL,
    direction_name character varying(64) NOT NULL,
    faculty character varying(64) NOT NULL,
    language character varying(12) NOT NULL,
    level character varying(12) NOT NULL
);


ALTER TABLE structure.direction OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17495)
-- Name: discipline; Type: TABLE; Schema: structure; Owner: postgres
--

CREATE TABLE structure.discipline (
    name character varying(64) NOT NULL,
    discipline_code character varying(6) NOT NULL,
    syllabus character varying(128),
    type_of_credit character varying(12) NOT NULL,
    credit_unit integer NOT NULL
);


ALTER TABLE structure.discipline OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 33594)
-- Name: discipline_list; Type: TABLE; Schema: structure; Owner: postgres
--

CREATE TABLE structure.discipline_list (
    edu_plan_no character varying(12) NOT NULL,
    discipline_code character varying(12) NOT NULL,
    semester character varying(1) NOT NULL,
    discipline_type character varying(8) NOT NULL,
    id_discipline integer NOT NULL,
    CONSTRAINT "discipline type" CHECK (((discipline_type)::text = ANY ((ARRAY['main'::character varying, 'elective'::character varying])::text[]))),
    CONSTRAINT semester CHECK (((semester)::text = ANY ((ARRAY['1'::character varying, '2'::character varying, '3'::character varying, '4'::character varying, '5'::character varying, '6'::character varying, '7'::character varying, '8'::character varying, '9'::character varying, '10'::character varying])::text[])))
);


ALTER TABLE structure.discipline_list OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 17513)
-- Name: edu_plan; Type: TABLE; Schema: structure; Owner: postgres
--

CREATE TABLE structure.edu_plan (
    edu_plan_no character varying(12) NOT NULL,
    begin_year integer NOT NULL,
    edu_program_no character varying(12) NOT NULL,
    CONSTRAINT b_year CHECK ((begin_year >= 1900))
);


ALTER TABLE structure.edu_plan OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17523)
-- Name: edu_program; Type: TABLE; Schema: structure; Owner: postgres
--

CREATE TABLE structure.edu_program (
    name character varying(64) NOT NULL,
    edu_program_no character varying(12) NOT NULL,
    direction_code character varying(12) NOT NULL,
    learning_type character varying(12) NOT NULL,
    CONSTRAINT "learning type" CHECK (((learning_type)::text = ANY (ARRAY[('distance'::character varying)::text, ('full-time'::character varying)::text])))
);


ALTER TABLE structure.edu_program OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 17427)
-- Name: group; Type: TABLE; Schema: structure; Owner: postgres
--

CREATE TABLE structure."group" (
    group_no character varying(8) NOT NULL,
    date_of_form date NOT NULL,
    date_of_deform date,
    edu_plan_no character varying(12),
    admin_isu integer,
    discipline_code character varying(6)
);


ALTER TABLE structure."group" OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 17206)
-- Name: schedule; Type: TABLE; Schema: structure; Owner: postgres
--

CREATE TABLE structure.schedule (
    group_no character varying(8) NOT NULL,
    discipline_code character varying(12) NOT NULL,
    auditory_no integer,
    year integer NOT NULL,
    season character varying(6) NOT NULL,
    tutor_isu_no integer NOT NULL,
    week_no integer,
    day_of_week_no integer,
    begin_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    fixed_day date,
    lesson_type character varying(12) NOT NULL,
    lesson_no integer NOT NULL,
    CONSTRAINT day CHECK (((day_of_week_no >= 1) AND (day_of_week_no <= 7))),
    CONSTRAINT "lesson type" CHECK (((lesson_type)::text = ANY (ARRAY[('practice'::character varying)::text, ('lecture'::character varying)::text, ('lab'::character varying)::text, ('educational practice'::character varying)::text]))),
    CONSTRAINT week CHECK (((week_no >= 1) AND (week_no <= 52)))
);


ALTER TABLE structure.schedule OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 17463)
-- Name: student; Type: TABLE; Schema: structure; Owner: postgres
--

CREATE TABLE structure.student (
    phone_no character varying(12) NOT NULL,
    student_isu_no integer NOT NULL,
    enroll_year integer NOT NULL,
    name character varying(60) NOT NULL,
    CONSTRAINT isu_no CHECK (((student_isu_no >= 300001) AND (student_isu_no <= 999999))),
    CONSTRAINT "phone no" CHECK (((phone_no)::text ~~ '+7%'::text))
);


ALTER TABLE structure.student OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 17435)
-- Name: student_status; Type: TABLE; Schema: structure; Owner: postgres
--

CREATE TABLE structure.student_status (
    group_no character varying NOT NULL,
    status character varying NOT NULL,
    start_date date NOT NULL,
    end_date date,
    student_isu_no integer NOT NULL,
    id_status integer NOT NULL,
    CONSTRAINT status CHECK (((status)::text = ANY ((ARRAY['study'::character varying, 'finished'::character varying, 'academic leave'::character varying, 'debt'::character varying])::text[])))
);


ALTER TABLE structure.student_status OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16426)
-- Name: tutor; Type: TABLE; Schema: structure; Owner: postgres
--

CREATE TABLE structure.tutor (
    name character varying(64) NOT NULL,
    tutor_isu_no integer NOT NULL,
    "position" character varying(18) NOT NULL,
    phone character varying(12)
);


ALTER TABLE structure.tutor OWNER TO postgres;

--
-- TOC entry 3437 (class 0 OID 16401)
-- Dependencies: 210
-- Data for Name: auditory; Type: TABLE DATA; Schema: structure; Owner: postgres
--

COPY structure.auditory (building_no, auditory_no, value_of_seats, auditory_type) FROM stdin;
1	11208	105	laboratory
1	11404	120	lecture
1	11410	105	laboratory
1	11420	45	laboratory
1	12110	105	laboratory
1	12122	60	laboratory
1	12210	60	laboratory
1	12306	75	lecture
1	12323	120	laboratory
1	12401	105	laboratory
1	13117	105	laboratory
1	13125	15	laboratory
1	13220	120	laboratory
1	13329	45	lecture
1	13404	15	lecture
1	14204	90	lecture
1	14210	105	lecture
1	14215	15	lecture
1	14306	15	lecture
1	14315	45	laboratory
1	14321	45	lecture
1	14414	30	laboratory
1	14424	105	lecture
1	14426	120	laboratory
2	21129	105	lecture
2	21309	30	laboratory
2	21325	45	laboratory
2	21329	75	laboratory
2	21401	30	laboratory
2	21413	15	lecture
2	21424	75	lecture
2	22105	75	lecture
2	22109	105	lecture
2	22112	120	lecture
2	22120	75	laboratory
2	22207	45	laboratory
2	22326	30	laboratory
2	23109	60	laboratory
2	23112	75	laboratory
2	23310	45	laboratory
2	23409	75	laboratory
2	24102	60	laboratory
2	24116	75	laboratory
2	24121	105	laboratory
2	24124	15	laboratory
2	24203	75	laboratory
2	24307	45	lecture
2	24318	60	laboratory
2	24404	15	laboratory
3	31105	120	laboratory
3	31216	90	laboratory
3	31306	30	laboratory
3	31324	30	laboratory
3	31419	90	lecture
3	31423	90	lecture
3	32109	60	lecture
3	32120	75	lecture
3	32321	90	lecture
3	32401	60	laboratory
3	33104	120	laboratory
3	33108	105	lecture
3	33112	90	lecture
3	33120	60	lecture
3	33227	60	lecture
3	33303	75	lecture
3	33413	60	lecture
3	33421	30	laboratory
3	34105	15	laboratory
3	34108	45	laboratory
3	34121	45	laboratory
3	34303	45	laboratory
3	34315	105	laboratory
3	34327	75	laboratory
3	34406	120	lecture
4	41121	105	lecture
4	41205	60	laboratory
4	41226	120	lecture
4	41406	60	lecture
4	41413	75	lecture
4	42120	105	laboratory
4	42204	105	laboratory
4	42211	45	laboratory
4	42213	75	lecture
4	42215	45	lecture
4	42314	60	laboratory
4	42315	75	laboratory
4	42403	45	laboratory
4	42422	60	lecture
4	43117	60	lecture
4	43225	30	lecture
4	43302	75	lecture
4	43310	120	laboratory
4	43324	90	laboratory
4	43325	90	lecture
4	43328	15	lecture
4	44104	90	lecture
4	44124	45	lecture
4	44224	60	lecture
4	44227	15	lecture
5	51102	120	laboratory
5	51112	75	laboratory
5	51113	45	laboratory
5	51215	60	laboratory
5	51221	90	laboratory
5	51325	30	laboratory
5	51329	90	lecture
5	51411	120	lecture
5	51416	90	laboratory
5	51427	45	lecture
5	52121	30	laboratory
5	52313	105	lecture
5	52315	15	laboratory
5	52326	45	lecture
5	52405	105	lecture
5	53123	105	lecture
5	53224	120	lecture
5	53226	120	laboratory
5	53413	15	lecture
5	54108	30	lecture
5	54204	90	lecture
5	54215	90	laboratory
5	54325	105	laboratory
5	54406	60	laboratory
5	54423	75	laboratory
6	61110	75	laboratory
6	61301	60	laboratory
6	61306	45	laboratory
6	61322	15	laboratory
6	61328	30	laboratory
6	61411	105	laboratory
6	62217	30	laboratory
6	62227	120	lecture
6	62312	105	lecture
6	62326	45	laboratory
6	62422	120	laboratory
6	63220	45	lecture
6	63303	90	laboratory
6	63307	120	lecture
6	63315	120	laboratory
6	63422	15	lecture
6	63424	105	lecture
6	64114	45	laboratory
6	64127	30	lecture
6	64204	120	lecture
6	64308	120	laboratory
6	64316	105	lecture
6	64319	30	lecture
6	64417	15	laboratory
6	64423	15	laboratory
7	71119	105	lecture
7	71203	90	lecture
7	71205	15	laboratory
7	71226	120	lecture
7	71309	90	laboratory
7	71324	15	lecture
7	71328	75	lecture
7	72210	15	lecture
7	72320	120	laboratory
7	72325	75	lecture
7	72412	90	lecture
7	73107	45	lecture
7	73206	45	laboratory
7	73208	60	laboratory
7	73209	105	lecture
7	73228	90	lecture
7	73309	15	laboratory
7	73317	15	lecture
7	73326	30	lecture
7	73414	90	laboratory
7	73421	30	lecture
7	74122	45	lecture
7	74313	75	lecture
7	74318	60	lecture
7	74325	120	lecture
8	81113	45	laboratory
8	81125	75	laboratory
8	81312	15	laboratory
8	81314	120	laboratory
8	82211	75	laboratory
8	82225	60	laboratory
8	82308	75	laboratory
8	82309	105	laboratory
8	82313	15	laboratory
8	82421	90	laboratory
8	83104	105	laboratory
8	83213	45	lecture
8	83318	120	lecture
8	83323	75	laboratory
8	83324	75	lecture
8	83327	90	lecture
8	83421	120	laboratory
8	84127	75	lecture
8	84220	75	lecture
8	84302	105	lecture
8	84401	30	lecture
8	84423	105	lecture
8	84427	105	lecture
\.


--
-- TOC entry 3438 (class 0 OID 16406)
-- Dependencies: 211
-- Data for Name: building; Type: TABLE DATA; Schema: structure; Owner: postgres
--

COPY structure.building (adress, city, building_no, name) FROM stdin;
Ломоносова 9	Санкт-Петербург	1	Ломо
Кронверский проспект 49	Санкт-Петербург	2	ГК
Биржевая линия 14	Санкт-Петербург	3	Биржа
Гривцова 14	Санкт-Петербург	4	Грива
Песочная набережная 14	Санкт-Петербург	5	Песочка
Чайковского 11/2	Санкт-Петербург	6	Чайка
Сиреневый бульвар 2	Москва	7	Сирень
Братская 34	Москва	8	Братская
\.


--
-- TOC entry 3447 (class 0 OID 17532)
-- Dependencies: 220
-- Data for Name: direction; Type: TABLE DATA; Schema: structure; Owner: postgres
--

COPY structure.direction (direction_code, direction_name, faculty, language, level) FROM stdin;
05.03.06	Экология и природопользование	Мегафакультет наук о жизни	russian	bachelor
07.04.04	Градостроительство 	Институт дизайна и урбанистики	russian	master
09.03.03	Прикладная информатика	Мегафакультет трансляционных информационных технологий	russian	bachelor
11.03.02	Инфокоммуникационные технологии и системы связи	Мегафакультет трансляционных информационных технологий	russian	bachelor
12.03.04	Биотехнические системы и технологии	Мегафакультет наук о жизни	russian	bachelor
18.03.01	Химическая технология	Мегафакультет наук о жизни	russian	bachelor
19.03.01	Биотехнология	Мегафакультет наук о жизни	english	bachelor
27.03.05	Инноватика	Факультет технологического менеджмента и инноваций	russian	bachelor
27.04.05	Инноватика	Факультет технологического менеджмента и инноваций	russian	master
45.03.04	Интеллекутальные системы в гуманитарной сфере	Мегафакультет трансляционных информационных технологий	english	bachelor
5.5.2	Политические институты, процессы, технологии	Факультет технологического менеджмента и инноваций	english	PhD
\.


--
-- TOC entry 3444 (class 0 OID 17495)
-- Dependencies: 217
-- Data for Name: discipline; Type: TABLE DATA; Schema: structure; Owner: postgres
--

COPY structure.discipline (name, discipline_code, syllabus, type_of_credit, credit_unit) FROM stdin;
Введение в Art&Science	AS301	https://op.itmo.ru/work-program/6942/general	pass	4
Общая биология	BG101	https://op.itmo.ru/work-program/9124/general	pass	2
Микробиология	BG102	https://op.itmo.ru/work-program/4548/general	exam	2
Сенсорные системы	BG103	https://op.itmo.ru/work-program/6817/general	exam	5
Инженерная реология	BG104	https://op.itmo.ru/work-program/4084/general	pass	5
Основы хемометрики	BG105	https://op.itmo.ru/work-program/1767/general	pass	5
Бизнес-модели основных секторов инновационной экономики	BM101	https://op.itmo.ru/work-program/4986/general	exam	2
Предпринимательская культура	BM102	https://op.itmo.ru/work-program/4759/general	exam	4
Основы экологического менеджмента	BM103	https://op.itmo.ru/work-program/9986/general	exam	2
Неорганическая химия	CH101	https://op.itmo.ru/work-program/1092/general	exam	4
Органическая химия	CH102	https://op.itmo.ru/work-program/4016/general	exam	5
Электрохимия	CH103	https://op.itmo.ru/work-program/2379/general	exam	5
Химические сенсоры	CH104	https://op.itmo.ru/work-program/6385/general	exam	4
Инфохимия	CH105	https://op.itmo.ru/work-program/1556/general	exam	5
Информатика	CS101	https://op.itmo.ru/work-program/8395/general	exam	3
Программирование	CS102	https://op.itmo.ru/work-program/5751/general	exam	4
Алгоритмы и структуры данных	CS103	https://op.itmo.ru/work-program/4606/general	exam	4
Базы данных	CS104	https://op.itmo.ru/work-program/9204/general	exam	4
Информационная безопасность	CS105	https://op.itmo.ru/work-program/6827/general	exam	3
Компьютерная лингвистика	CS106	https://op.itmo.ru/work-program/7661/general	pass	3
Методы оптимизации	CS107	https://op.itmo.ru/work-program/3020/general	exam	3
Проектирование информационных систем	CS108	https://op.itmo.ru/work-program/9637/general	exam	2
Проектная документация	CS109	https://op.itmo.ru/work-program/2075/general	pass	4
Прикладные интеллектуальные системы	CS110	https://op.itmo.ru/work-program/2692/general	exam	2
Фронтэнд-разработка	CS111	https://op.itmo.ru/work-program/4627/general	exam	5
Бекэнд-разработка	CS112	https://op.itmo.ru/work-program/5908/general	exam	2
Мобильная разработка	CS113	https://op.itmo.ru/work-program/7453/general	exam	2
Анализ культурных данных	CS114	https://op.itmo.ru/work-program/3310/general	exam	2
3D-моделирование	CS115	https://op.itmo.ru/work-program/3813/general	pass	2
Тестирование ПО	CS116	https://op.itmo.ru/work-program/4582/general	pass	5
Информационная безопасность	CS117	https://op.itmo.ru/work-program/8258/general	exam	3
Управление программными проектами	CS118	https://op.itmo.ru/work-program/5498/general	pass	2
Web-разработка	CS119	https://op.itmo.ru/work-program/9331/general	pass	4
 Технологии управления данными	CS120	https://op.itmo.ru/work-program/5475/general	pass	5
Дискретная математика	DM101	https://op.itmo.ru/work-program/1462/general	pass	5
Экология 	EC101	https://op.itmo.ru/work-program/7674/general	pass	3
Гэоэкология	EC102	https://op.itmo.ru/work-program/6525/general	pass	2
Рациональное использование природных ресурсов	EC103	https://op.itmo.ru/work-program/4889/general	exam	2
Экологическое право	EC104	https://op.itmo.ru/work-program/2834/general	exam	2
Экологическая сертификация	EC105	https://op.itmo.ru/work-program/1837/general	pass	5
Испанский язык	EL101	https://op.itmo.ru/work-program/3463/general	pass	5
Иностранный язык	EN101	https://op.itmo.ru/work-program/6670/general	pass	4
Иностранный язык в профессиональной деятельности	EN102	https://op.itmo.ru/work-program/8443/general	pass	3
Основы инженерного проектирования	EP101	https://op.itmo.ru/work-program/8382/general	pass	2
Немецкий язык	GL101	https://op.itmo.ru/work-program/2238/general	pass	2
История	HS101	https://op.itmo.ru/work-program/8742/general	exam	3
Линейная алгебра	LA101	https://op.itmo.ru/work-program/7812/general	exam	3
Безопасность жизнедеятельности	LS101	https://op.itmo.ru/work-program/8161/general	pass	4
Мультимедийная научная журналистика	MC301	https://op.itmo.ru/work-program/8678/general	pass	2
Теория коммуникаций	MC302	https://op.itmo.ru/work-program/5272/general	pass	4
Наукометрия и анализ данных	MC303	https://op.itmo.ru/work-program/8685/general	pass	2
Корпоративная коммуникация	MC304	https://op.itmo.ru/work-program/1804/general	pass	3
Социология науки и научной коммуникации	MC305	https://op.itmo.ru/work-program/5862/general	pass	4
Введение в визуализацию и моделирование в научной коммуникации	MC306	https://op.itmo.ru/work-program/4124/general	exam	2
Дата-журналистика и визуализация данных	MC307	https://op.itmo.ru/work-program/3468/general	exam	4
Машинное обучение	ML101	https://op.itmo.ru/work-program/8663/general	pass	4
Глубокое обучение	ML102	https://op.itmo.ru/work-program/9190/general	exam	3
Рекомендательные системы	ML103	https://op.itmo.ru/work-program/5366/general	exam	5
Первичная обработка данных и Элементы статистики	ML301	https://op.itmo.ru/work-program/9006/general	pass	3
Введение в МО	ML302	https://op.itmo.ru/work-program/5528/general	exam	3
Первичная обработка данных и Хранение больших данных	ML303	https://op.itmo.ru/work-program/4938/general	exam	5
Статистика на R и Введение в МО	ML304	https://op.itmo.ru/work-program/2048/general	pass	3
Математика	MT101	https://op.itmo.ru/work-program/6845/general	exam	2
Учебная практика	PC101	https://op.itmo.ru/work-program/2371/general	pass	2
Производственная практика	PC102	https://op.itmo.ru/work-program/9161/general	pass	3
Преддипломная практика	PC103	https://op.itmo.ru/work-program/2416/general	pass	3
Защита ВКР	PC104	https://op.itmo.ru/work-program/1557/general	pass	3
Физическая культура	PE101	https://op.itmo.ru/work-program/6911/general	pass	5
Физика	PH101	https://op.itmo.ru/work-program/6363/general	pass	2
Мышление	PH301	https://op.itmo.ru/work-program/6178/general	pass	4
Основы концептуального мышления	PH302	https://op.itmo.ru/work-program/3087/general	pass	5
Философия	PL101	https://op.itmo.ru/work-program/6299/general	exam	2
Концепция устойчивого развития	PS101	https://op.itmo.ru/work-program/5014/general	pass	4
Психология пользователя	PS102	https://op.itmo.ru/work-program/9110/general	exam	5
Критика цифровизации	PS103	https://op.itmo.ru/work-program/3061/general	exam	3
Визуальная культура	PS104	https://op.itmo.ru/work-program/3592/general	pass	3
Теория вероятностей	PT101	https://op.itmo.ru/work-program/9066/general	exam	5
Коммуникации и командообразование	SS101	https://op.itmo.ru/work-program/2012/general	pass	3
Техники публичных выступлений и презентаций	SS102	https://op.itmo.ru/work-program/7009/general	pass	4
Эмоциональный интеллект	SS201	https://op.itmo.ru/work-program/1376/general	pass	3
Автостопом по антиутопиям	SS202	https://op.itmo.ru/work-program/9798/general	pass	5
Практики креативности	SS203	https://op.itmo.ru/work-program/5563/general	pass	5
Сложная коммуникация	SS204	https://op.itmo.ru/work-program/8271/general	pass	4
Теория игр	SS205	https://op.itmo.ru/work-program/8350/general	pass	4
Дизайн в культуре	SS206	https://op.itmo.ru/work-program/8504/general	pass	3
Введение в урбанистику	UB301	https://op.itmo.ru/work-program/3202/general	pass	3
Основы территориального планирования	UB302	https://op.itmo.ru/work-program/9822/general	exam	5
Зелёная экономика в городском планировании	UB303	https://op.itmo.ru/work-program/3858/general	pass	3
Системный анализ в урбанистике и градостроительстве	UB304	https://op.itmo.ru/work-program/8589/general	exam	2
Социология городского киберпространства	UB305	https://op.itmo.ru/work-program/8128/general	pass	5
Системы управления освещением	UB306	https://op.itmo.ru/work-program/6672/general	pass	4
\.


--
-- TOC entry 3448 (class 0 OID 33594)
-- Dependencies: 221
-- Data for Name: discipline_list; Type: TABLE DATA; Schema: structure; Owner: postgres
--

COPY structure.discipline_list (edu_plan_no, discipline_code, semester, discipline_type, id_discipline) FROM stdin;
2019.1	AS301	2	main	1
2019.1	EN101	2	main	2
2019.1	EN101	3	main	3
2019.1	MC301	1	main	4
2019.1	MC302	2	main	5
2019.1	MC303	2	main	6
2019.1	MC304	3	main	7
2019.1	MC305	3	main	8
2019.1	MC306	4	main	9
2019.1	MC307	4	main	10
2019.1	ML301	2	main	11
2019.1	ML302	2	main	12
2019.1	ML303	3	main	13
2019.1	ML304	3	main	14
2019.1	PC103	3	main	15
2019.1	PC104	4	main	16
2019.1	PH301	1	main	17
2019.1	PH302	2	main	18
2019.1	SS201	2	elective	19
2019.1	SS203	3	elective	20
2019.1	SS204	1	elective	21
2019.2	EN101	2	main	22
2019.2	EN101	3	main	23
2019.2	ML301	2	main	24
2019.2	ML302	2	main	25
2019.2	ML303	3	main	26
2019.2	ML304	3	main	27
2019.2	PC103	3	main	28
2019.2	PC104	4	main	29
2019.2	PH301	1	main	30
2019.2	PH302	2	main	31
2019.2	SS203	2	elective	32
2019.2	SS204	2	elective	33
2019.2	SS205	3	elective	34
2019.2	UB301	1	main	35
2019.2	UB302	2	main	36
2019.2	UB303	2	main	37
2019.2	UB304	3	main	38
2019.2	UB305	4	main	39
2019.2	UB306	4	main	40
2019.5	AS301	3	main	41
2019.5	BG101	1	main	42
2019.5	BG101	2	main	43
2019.5	BG102	7	main	44
2019.5	BG103	3	main	45
2019.5	BG104	4	main	46
2019.5	BM101	3	main	47
2019.5	BM102	4	main	48
2019.5	CH101	5	main	49
2019.5	CH102	6	main	50
2019.5	CS120	7	main	51
2019.5	DM101	1	main	52
2019.5	EC101	3	main	53
2019.5	EC103	5	main	54
2019.5	EC104	4	main	55
2019.5	EC105	1	main	56
2019.5	EL101	3	elective	57
2019.5	EL101	4	elective	58
2019.5	EN101	1	main	59
2019.5	EN101	2	main	60
2019.5	EN101	3	main	61
2019.5	EN101	4	main	62
2019.5	EN102	5	main	63
2019.5	EN102	6	main	64
2019.5	HS101	2	main	65
2019.5	LS101	3	main	66
2019.5	PC101	5	main	67
2019.5	PC102	6	main	68
2019.5	PC103	8	main	69
2019.5	PC104	8	main	70
2019.5	PE101	1	main	71
2019.5	PE101	2	main	72
2019.5	PE101	3	main	73
2019.5	PE101	4	main	74
2019.5	PE101	5	main	75
2019.5	PE101	6	main	76
2019.5	PE101	7	main	77
2019.5	PE101	8	main	78
2019.5	PH101	7	main	79
2019.5	PH101	8	main	80
2019.5	PL101	5	main	81
2019.5	PS101	3	main	82
2019.5	SS101	2	main	83
2019.5	SS102	4	main	84
2019.5	SS203	6	elective	85
2019.5	SS204	7	elective	86
2020.1	AS301	2	main	87
2020.1	BG101	1	main	88
2020.1	BG101	2	main	89
2020.1	BG102	7	main	90
2020.1	BG103	3	main	91
2020.1	BG104	4	main	92
2020.1	BM101	3	main	93
2020.1	BM102	4	main	94
2020.1	CH101	5	main	95
2020.1	CH102	6	main	96
2020.1	DM101	1	main	97
2020.1	EC101	3	main	98
2020.1	EC103	5	main	99
2020.1	EC104	2	main	100
2020.1	EC105	1	main	101
2020.1	EN101	1	main	102
2020.1	EN101	2	main	103
2020.1	EN101	3	main	104
2020.1	EN101	4	main	105
2020.1	EN102	5	main	106
2020.1	EN102	6	main	107
2020.1	EP101	7	main	108
2020.1	GL101	3	elective	109
2020.1	GL101	4	elective	110
2020.1	HS101	2	main	111
2020.1	LS101	3	main	112
2020.1	PC101	5	main	113
2020.1	PC102	6	main	114
2020.1	PC103	8	main	115
2020.1	PC104	8	main	116
2020.1	PE101	1	main	117
2020.1	PE101	2	main	118
2020.1	PE101	3	main	119
2020.1	PE101	4	main	120
2020.1	PE101	5	main	121
2020.1	PE101	6	main	122
2020.1	PE101	7	main	123
2020.1	PE101	8	main	124
2020.1	PH101	7	main	125
2020.1	PH101	8	main	126
2020.1	PL101	5	main	127
2020.1	PS101	3	main	128
2020.1	SS101	2	main	129
2020.1	SS102	4	main	130
2020.1	SS201	5	elective	131
2020.1	SS202	5	elective	132
2021.1	BM101	3	main	133
2021.1	BM102	4	main	134
2021.1	CS101	1	main	135
2021.1	CS102	1	main	136
2021.1	CS102	2	main	137
2021.1	CS103	2	main	138
2021.1	CS103	3	main	139
2021.1	CS104	6	main	140
2021.1	CS105	6	main	141
2021.1	CS106	5	main	142
2021.1	CS107	6	main	143
2021.1	CS110	5	main	144
2021.1	CS111	7	main	145
2021.1	CS112	8	main	146
2021.1	DM101	1	main	147
2021.1	EC101	4	main	148
2021.1	EN101	1	main	149
2021.1	EN101	2	main	150
2021.1	EN101	3	main	151
2021.1	EN101	4	main	152
2021.1	EN102	5	main	153
2021.1	EN102	6	main	154
2021.1	GL101	5	elective	155
2021.1	GL101	6	elective	156
2021.1	HS101	1	main	157
2021.1	LA101	1	main	158
2021.1	LA101	2	main	159
2021.1	LA101	3	main	160
2021.1	LS101	3	main	161
2021.1	ML101	4	main	162
2021.1	PC101	5	main	163
2021.1	PC102	6	main	164
2021.1	PC103	8	main	165
2021.1	PC104	8	main	166
2021.1	PE101	1	main	167
2021.1	PE101	2	main	168
2021.1	PE101	3	main	169
2021.1	PE101	4	main	170
2021.1	PE101	5	main	171
2021.1	PE101	6	main	172
2021.1	PE101	7	main	173
2021.1	PE101	8	main	174
2021.1	PL101	2	main	175
2021.1	SS101	2	main	176
2021.1	SS102	4	main	177
2021.1	SS205	7	elective	178
2021.2	AS301	6	main	179
2021.2	BG101	2	main	180
2021.2	BG102	6	main	181
2021.2	BM101	3	main	182
2021.2	BM102	4	main	183
2021.2	BM103	8	main	184
2021.2	CH101	5	main	185
2021.2	CH102	6	main	186
2021.2	CS115	6	main	187
2021.2	DM101	1	main	188
2021.2	EC101	3	main	189
2021.2	EC102	7	main	190
2021.2	EC103	4	main	191
2021.2	EC104	6	main	192
2021.2	EN101	1	main	193
2021.2	EN101	2	main	194
2021.2	EN101	3	main	195
2021.2	EN101	4	main	196
2021.2	EN102	5	main	197
2021.2	EN102	6	main	198
2021.2	HS101	2	main	199
2021.2	LA101	1	main	200
2021.2	LA101	2	main	201
2021.2	LA101	3	main	202
2021.2	LS101	3	main	203
2021.2	PC101	5	main	204
2021.2	PC102	6	main	205
2021.2	PC103	8	main	206
2021.2	PC104	8	main	207
2021.2	PE101	1	main	208
2021.2	PE101	2	main	209
2021.2	PE101	3	main	210
2021.2	PE101	4	main	211
2021.2	PE101	5	main	212
2021.2	PE101	6	main	213
2021.2	PE101	7	main	214
2021.2	PE101	8	main	215
2021.2	PL101	5	main	216
2021.2	PS101	3	main	217
2021.2	PS101	4	main	218
2021.2	PS102	7	main	219
2021.2	PS103	8	main	220
2021.2	PS104	8	main	221
2021.2	PT101	4	main	222
2021.2	SS101	2	main	223
2021.2	SS102	4	main	224
2021.3	AS301	3	main	225
2021.3	EN101	2	main	226
2021.3	EN101	3	main	227
2021.3	MC301	1	main	228
2021.3	MC302	1	main	229
2021.3	MC303	2	main	230
2021.3	MC304	3	main	231
2021.3	MC305	3	main	232
2021.3	MC306	4	main	233
2021.3	MC307	4	main	234
2021.3	ML301	2	main	235
2021.3	ML302	2	main	236
2021.3	ML303	3	main	237
2021.3	ML304	3	main	238
2021.3	PC103	3	main	239
2021.3	PC104	4	main	240
2021.3	PH301	1	main	241
2021.3	PH302	2	main	242
2021.3	SS202	2	elective	243
2021.3	SS203	3	elective	244
2021.3	SS204	1	elective	245
2022.1	BM101	3	main	246
2022.1	BM102	4	main	247
2022.1	CS101	1	main	248
2022.1	CS102	1	main	249
2022.1	CS102	2	main	250
2022.1	CS103	2	main	251
2022.1	CS103	3	main	252
2022.1	CS104	6	main	253
2022.1	CS105	4	main	254
2022.1	CS106	5	main	255
2022.1	CS107	6	main	256
2022.1	CS108	7	main	257
2022.1	CS109	8	main	258
2022.1	CS110	5	main	259
2022.1	DM101	1	main	260
2022.1	EC101	4	main	261
2022.1	EL101	5	elective	262
2022.1	EL101	6	elective	263
2022.1	EN101	1	main	264
2022.1	EN101	2	main	265
2022.1	EN101	3	main	266
2022.1	EN101	4	main	267
2022.1	EN102	5	main	268
2022.1	EN102	6	main	269
2022.1	HS101	1	main	270
2022.1	LS101	3	main	271
2022.1	ML101	4	main	272
2022.1	PC101	5	main	273
2022.1	PC102	6	main	274
2022.1	PC103	8	main	275
2022.1	PC104	8	main	276
2022.1	PE101	1	main	277
2022.1	PE101	2	main	278
2022.1	PE101	3	main	279
2022.1	PE101	4	main	280
2022.1	PE101	5	main	281
2022.1	PE101	6	main	282
2022.1	PE101	7	main	283
2022.1	PE101	8	main	284
2022.1	PL101	2	main	285
2022.1	SS101	2	main	286
2022.1	SS102	4	main	287
2022.1	SS201	7	elective	288
2022.1	SS202	8	elective	289
2022.2	BG101	2	main	290
2022.2	BG102	5	main	291
2022.2	BM101	3	main	292
2022.2	BM102	4	main	293
2022.2	BM103	8	main	294
2022.2	CH101	5	main	295
2022.2	CH102	5	main	296
2022.2	CS115	6	main	297
2022.2	DM101	1	main	298
2022.2	EC101	3	main	299
2022.2	EC102	7	main	300
2022.2	EC103	4	main	301
2022.2	EN101	1	main	302
2022.2	EN101	2	main	303
2022.2	EN101	3	main	304
2022.2	EN101	4	main	305
2022.2	EN102	5	main	306
2022.2	EN102	6	main	307
2022.2	EP101	6	main	308
2022.2	HS101	2	main	309
2022.2	LA101	1	main	310
2022.2	LA101	2	main	311
2022.2	LA101	3	main	312
2022.2	LS101	3	main	313
2022.2	PC101	5	main	314
2022.2	PC102	6	main	315
2022.2	PC103	8	main	316
2022.2	PC104	8	main	317
2022.2	PE101	1	main	318
2022.2	PE101	2	main	319
2022.2	PE101	3	main	320
2022.2	PE101	4	main	321
2022.2	PE101	5	main	322
2022.2	PE101	6	main	323
2022.2	PE101	7	main	324
2022.2	PE101	8	main	325
2022.2	PH101	6	main	326
2022.2	PL101	5	main	327
2022.2	PS101	3	main	328
2022.2	PS101	4	main	329
2022.2	PS102	7	main	330
2022.2	PS103	8	main	331
2022.2	PS104	8	main	332
2022.2	PT101	4	main	333
2022.2	SS101	2	main	334
2022.2	SS102	4	main	335
2022.6	BM101	3	main	336
2022.6	BM102	4	main	337
2022.6	CS101	3	main	338
2022.6	CS102	4	main	339
2022.6	CS103	5	main	340
2022.6	CS104	2	main	341
2022.6	CS105	5	main	342
2022.6	CS106	6	main	343
2022.6	CS107	6	main	344
2022.6	CS108	7	main	345
2022.6	CS109	5	main	346
2022.6	CS109	6	main	347
2022.6	CS110	2	main	348
2022.6	CS111	3	main	349
2022.6	CS112	7	main	350
2022.6	CS113	8	main	351
2022.6	CS116	1	main	352
2022.6	CS117	3	main	353
2022.6	CS118	4	main	354
2022.6	CS119	2	main	355
2022.6	CS120	2	main	356
2022.6	DM101	1	main	357
2022.6	EC101	6	main	358
2022.6	EN101	1	main	359
2022.6	EN101	2	main	360
2022.6	EN101	3	main	361
2022.6	EN101	4	main	362
2022.6	EN102	5	main	363
2022.6	EN102	6	main	364
2022.6	GL101	3	elective	365
2022.6	GL101	4	elective	366
2022.6	HS101	1	main	367
2022.6	LS101	4	main	368
2022.6	ML101	3	main	369
2022.6	ML101	4	main	370
2022.6	ML102	8	main	371
2022.6	ML103	7	main	372
2022.6	PE101	1	main	373
2022.6	PE101	2	main	374
2022.6	PE101	3	main	375
2022.6	PE101	4	main	376
2022.6	PE101	5	main	377
2022.6	PE101	6	main	378
2022.6	PE101	7	main	379
2022.6	PE101	8	main	380
2022.6	PL101	4	main	381
2022.6	SS101	2	main	382
2022.6	SS102	3	main	383
2022.6	SS201	5	elective	384
2022.6	SS202	5	elective	385
\.


--
-- TOC entry 3445 (class 0 OID 17513)
-- Dependencies: 218
-- Data for Name: edu_plan; Type: TABLE DATA; Schema: structure; Owner: postgres
--

COPY structure.edu_plan (edu_plan_no, begin_year, edu_program_no) FROM stdin;
2022.1	2022	45.03.04.1
2022.2	2022	27.04.05.1
2022.3	2022	27.04.05.2
2022.4	2022	07.04.04.1
2022.5	2022	09.03.03.1
2022.6	2022	11.03.02.1
2022.7	2022	05.03.06.1
2022.8	2022	12.03.04.1
2022.9	2022	18.03.01.1
2022.10	2022	19.03.01.1
2022.11	2022	09.03.03.2
2021.1	2021	45.03.04.1
2021.2	2021	27.04.05.1
2021.3	2021	27.04.05.2
2021.4	2021	07.04.04.1
2020.1	2020	05.03.06.1
2020.2	2020	12.03.04.1
2020.3	2020	18.03.01.1
2020.4	2020	19.03.01.1
2020.5	2020	09.03.03.2
2019.1	2019	27.04.05.2
2019.2	2019	07.04.04.1
2019.3	2019	09.03.03.1
2019.4	2019	11.03.02.1
2019.5	2019	05.03.06.1
\.


--
-- TOC entry 3446 (class 0 OID 17523)
-- Dependencies: 219
-- Data for Name: edu_program; Type: TABLE DATA; Schema: structure; Owner: postgres
--

COPY structure.edu_program (name, edu_program_no, direction_code, learning_type) FROM stdin;
Интеллекутальные системы в гуманитарной сфере	45.03.04.1	45.03.04	full-time
Научная коммуникация	27.04.05.2	27.04.05	full-time
Цифровая урбанистика	07.04.04.1	07.04.04	full-time
Мобильные и сетевые технологии	09.03.03.1	09.03.03	full-time
Программирование в инфокоммуникационных системах	11.03.02.1	11.03.02	full-time
Экотехнологии и устойчивое развитие	05.03.06.1	05.03.06	full-time
Биоинженерия	12.03.04.1	12.03.04	full-time
Инфохимия	18.03.01.1	18.03.01	full-time
Биотехнология	19.03.01.1	19.03.01	full-time
Разработка программного обеспечения	09.03.03.2	09.03.03	full-time
Технологии и инновации	27.04.05.1	27.03.05	full-time
\.


--
-- TOC entry 3441 (class 0 OID 17427)
-- Dependencies: 214
-- Data for Name: group; Type: TABLE DATA; Schema: structure; Owner: postgres
--

COPY structure."group" (group_no, date_of_form, date_of_deform, edu_plan_no, admin_isu, discipline_code) FROM stdin;
АЯ-С1/1	2022-09-01	2023-01-25	\N	\N	EN101
АЯ-С1/2	2023-02-06	\N	\N	\N	EN102
НОЖ 1	2022-09-01	2023-01-25	\N	\N	PS101
НОЖ 1.1	2022-09-01	2023-01-25	\N	\N	PS101
K32422	2022-09-01	\N	2021.1	316269	\N
R3143	2021-09-01	2022-07-01	2021.3	300803	\N
R3243	2022-09-01	\N	2021.3	300803	\N
\.


--
-- TOC entry 3440 (class 0 OID 17206)
-- Dependencies: 213
-- Data for Name: schedule; Type: TABLE DATA; Schema: structure; Owner: postgres
--

COPY structure.schedule (group_no, discipline_code, auditory_no, year, season, tutor_isu_no, week_no, day_of_week_no, begin_time, end_time, fixed_day, lesson_type, lesson_no) FROM stdin;
K32422	CS102	11208	2022	fall	100087	36	1	08:20:00	09:50:00	\N	practice	1
K32422	CS102	11208	2022	fall	100087	37	1	08:20:00	09:50:00	\N	practice	2
K32422	CS102	11208	2022	fall	100087	38	1	08:20:00	09:50:00	\N	practice	3
K32422	CS102	11208	2022	fall	100087	39	1	08:20:00	09:50:00	\N	practice	4
K32422	CS102	11208	2022	fall	100087	40	1	08:20:00	09:50:00	\N	practice	5
K32422	CS102	11208	2022	fall	100087	41	1	08:20:00	09:50:00	\N	practice	6
K32422	CS102	11208	2022	fall	100087	42	1	08:20:00	09:50:00	\N	practice	7
K32422	CS102	11208	2022	fall	100087	43	1	08:20:00	09:50:00	\N	practice	8
K32422	CS102	11208	2022	fall	100087	44	1	08:20:00	09:50:00	\N	practice	9
K32422	CS102	11208	2022	fall	100087	45	1	08:20:00	09:50:00	\N	practice	10
K32422	CS102	11208	2022	fall	100087	46	1	08:20:00	09:50:00	\N	practice	11
K32422	CS102	11208	2022	fall	100087	47	1	08:20:00	09:50:00	\N	practice	12
K32422	CS102	11208	2022	fall	100087	48	1	08:20:00	09:50:00	\N	practice	13
K32422	CS102	11208	2022	fall	100087	49	1	08:20:00	09:50:00	\N	practice	14
K32422	CS102	11208	2022	fall	100087	50	1	08:20:00	09:50:00	\N	practice	15
K32422	CS102	11208	2022	fall	100087	51	1	08:20:00	09:50:00	\N	practice	16
K32422	CS102	11208	2022	fall	100087	52	1	08:20:00	09:50:00	\N	practice	17
K32422	CS102	12306	2022	fall	100087	36	1	10:00:00	11:30:00	\N	lecture	18
K32422	CS102	12306	2022	fall	100087	38	1	10:00:00	11:30:00	\N	lecture	19
K32422	CS102	12306	2022	fall	100087	40	1	10:00:00	11:30:00	\N	lecture	20
K32422	CS102	12306	2022	fall	100087	42	1	10:00:00	11:30:00	\N	lecture	21
K32422	CS102	12306	2022	fall	100087	44	1	10:00:00	11:30:00	\N	lecture	22
K32422	CS102	12306	2022	fall	100087	46	1	10:00:00	11:30:00	\N	lecture	23
K32422	CS102	12306	2022	fall	100087	48	1	10:00:00	11:30:00	\N	lecture	24
K32422	CS102	12306	2022	fall	100087	50	1	10:00:00	11:30:00	\N	lecture	25
K32422	CS102	12306	2022	fall	100087	52	1	10:00:00	11:30:00	\N	lecture	26
K32422	CS105	12306	2022	fall	111982	36	2	15:20:00	16:50:00	\N	lecture	27
K32422	CS105	12306	2022	fall	111982	39	2	15:20:00	16:50:00	\N	lecture	28
K32422	CS105	12306	2022	fall	111982	42	2	15:20:00	16:50:00	\N	lecture	29
K32422	CS105	12306	2022	fall	111982	45	2	15:20:00	16:50:00	\N	lecture	30
K32422	CS105	12306	2022	fall	111982	48	2	15:20:00	16:50:00	\N	lecture	31
K32422	CS105	12306	2022	fall	111982	51	2	15:20:00	16:50:00	\N	lecture	32
K32422	CS105	14426	2022	fall	111982	36	2	13:30:00	15:00:00	\N	practice	33
K32422	CS105	14426	2022	fall	111982	36	2	11:40:00	13:10:00	\N	practice	34
K32422	CS105	14426	2022	fall	111982	39	2	13:30:00	15:00:00	\N	practice	35
K32422	CS105	14426	2022	fall	111982	39	2	11:40:00	13:10:00	\N	practice	36
K32422	CS105	14426	2022	fall	111982	42	2	13:30:00	15:00:00	\N	practice	37
K32422	CS105	14426	2022	fall	111982	42	2	11:40:00	13:10:00	\N	practice	38
K32422	CS105	14426	2022	fall	111982	45	2	13:30:00	15:00:00	\N	practice	39
K32422	CS105	14426	2022	fall	111982	45	2	11:40:00	13:10:00	\N	practice	40
K32422	CS105	14426	2022	fall	111982	48	2	13:30:00	15:00:00	\N	practice	41
K32422	CS105	14426	2022	fall	111982	48	2	11:40:00	13:10:00	\N	practice	42
K32422	CS105	14426	2022	fall	111982	51	2	13:30:00	15:00:00	\N	practice	43
K32422	CS105	14426	2022	fall	111982	51	2	11:40:00	13:10:00	\N	practice	44
АЯ-С1/1	EN101	12210	2022	fall	199870	36	6	08:20:00	09:50:00	\N	practice	45
АЯ-С1/1	EN101	12210	2022	fall	199870	36	6	10:00:00	11:30:00	\N	practice	46
АЯ-С1/1	EN101	12210	2022	fall	199870	37	6	08:20:00	09:50:00	\N	practice	47
АЯ-С1/1	EN101	12210	2022	fall	199870	37	6	10:00:00	11:30:00	\N	practice	48
АЯ-С1/1	EN101	12210	2022	fall	199870	38	6	08:20:00	09:50:00	\N	practice	49
АЯ-С1/1	EN101	12210	2022	fall	199870	38	6	10:00:00	11:30:00	\N	practice	50
АЯ-С1/1	EN101	12210	2022	fall	199870	39	6	08:20:00	09:50:00	\N	practice	51
АЯ-С1/1	EN101	12210	2022	fall	199870	39	6	10:00:00	11:30:00	\N	practice	52
АЯ-С1/1	EN101	12210	2022	fall	199870	40	6	08:20:00	09:50:00	\N	practice	53
АЯ-С1/1	EN101	12210	2022	fall	199870	40	6	10:00:00	11:30:00	\N	practice	54
АЯ-С1/1	EN101	12210	2022	fall	199870	41	6	08:20:00	09:50:00	\N	practice	55
АЯ-С1/1	EN101	12210	2022	fall	199870	41	6	10:00:00	11:30:00	\N	practice	56
АЯ-С1/1	EN101	12210	2022	fall	199870	42	6	08:20:00	09:50:00	\N	practice	57
АЯ-С1/1	EN101	12210	2022	fall	199870	42	6	10:00:00	11:30:00	\N	practice	58
АЯ-С1/1	EN101	12210	2022	fall	199870	43	6	08:20:00	09:50:00	\N	practice	59
АЯ-С1/1	EN101	12210	2022	fall	199870	43	6	10:00:00	11:30:00	\N	practice	60
АЯ-С1/1	EN101	12210	2022	fall	199870	44	6	08:20:00	09:50:00	\N	practice	61
АЯ-С1/1	EN101	12210	2022	fall	199870	44	6	10:00:00	11:30:00	\N	practice	62
АЯ-С1/1	EN101	12210	2022	fall	199870	45	6	08:20:00	09:50:00	\N	practice	63
АЯ-С1/1	EN101	12210	2022	fall	199870	45	6	10:00:00	11:30:00	\N	practice	64
АЯ-С1/1	EN101	12210	2022	fall	199870	46	6	08:20:00	09:50:00	\N	practice	65
АЯ-С1/1	EN101	12210	2022	fall	199870	46	6	10:00:00	11:30:00	\N	practice	66
АЯ-С1/1	EN101	12210	2022	fall	199870	47	6	08:20:00	09:50:00	\N	practice	67
АЯ-С1/1	EN101	12210	2022	fall	199870	47	6	10:00:00	11:30:00	\N	practice	68
АЯ-С1/1	EN101	12210	2022	fall	199870	48	6	08:20:00	09:50:00	\N	practice	69
АЯ-С1/1	EN101	12210	2022	fall	199870	48	6	10:00:00	11:30:00	\N	practice	70
АЯ-С1/1	EN101	12210	2022	fall	199870	49	6	08:20:00	09:50:00	\N	practice	71
АЯ-С1/1	EN101	12210	2022	fall	199870	49	6	10:00:00	11:30:00	\N	practice	72
АЯ-С1/1	EN101	12210	2022	fall	199870	50	6	08:20:00	09:50:00	\N	practice	73
АЯ-С1/1	EN101	12210	2022	fall	199870	50	6	10:00:00	11:30:00	\N	practice	74
АЯ-С1/1	EN101	12210	2022	fall	199870	51	6	08:20:00	09:50:00	\N	practice	75
АЯ-С1/1	EN101	12210	2022	fall	199870	51	6	10:00:00	11:30:00	\N	practice	76
АЯ-С1/1	EN101	12210	2022	fall	199870	52	6	08:20:00	09:50:00	\N	practice	77
АЯ-С1/1	EN101	12210	2022	fall	199870	52	6	10:00:00	11:30:00	\N	practice	78
НОЖ 1	PS101	24307	2022	fall	233876	36	5	08:20:00	09:50:00	\N	lecture	79
НОЖ 1	PS101	24307	2022	fall	233876	38	5	08:20:00	09:50:00	\N	lecture	80
НОЖ 1	PS101	24307	2022	fall	233876	40	5	08:20:00	09:50:00	\N	lecture	81
НОЖ 1	PS101	24307	2022	fall	233876	42	5	08:20:00	09:50:00	\N	lecture	82
НОЖ 1	PS101	24307	2022	fall	233876	44	5	08:20:00	09:50:00	\N	lecture	83
НОЖ 1	PS101	24307	2022	fall	233876	46	5	08:20:00	09:50:00	\N	lecture	84
НОЖ 1	PS101	24307	2022	fall	233876	48	5	08:20:00	09:50:00	\N	lecture	85
НОЖ 1	PS101	24307	2022	fall	233876	50	5	08:20:00	09:50:00	\N	lecture	86
НОЖ 1	PS101	24307	2022	fall	233876	52	5	08:20:00	09:50:00	\N	lecture	87
НОЖ 1.1	PS101	21401	2022	fall	233876	36	5	10:00:00	11:30:00	\N	practice	88
НОЖ 1.1	PS101	21401	2022	fall	233876	36	5	11:40:00	13:10:00	\N	practice	89
НОЖ 1.1	PS101	21401	2022	fall	233876	38	5	10:00:00	11:30:00	\N	practice	90
НОЖ 1.1	PS101	21401	2022	fall	233876	38	5	11:40:00	13:10:00	\N	practice	91
НОЖ 1.1	PS101	21401	2022	fall	233876	40	5	10:00:00	11:30:00	\N	practice	92
НОЖ 1.1	PS101	21401	2022	fall	233876	40	5	11:40:00	13:10:00	\N	practice	93
НОЖ 1.1	PS101	21401	2022	fall	233876	42	5	10:00:00	11:30:00	\N	practice	94
НОЖ 1.1	PS101	21401	2022	fall	233876	42	5	11:40:00	13:10:00	\N	practice	95
НОЖ 1.1	PS101	21401	2022	fall	233876	44	5	10:00:00	11:30:00	\N	practice	96
НОЖ 1.1	PS101	21401	2022	fall	233876	44	5	11:40:00	13:10:00	\N	practice	97
НОЖ 1.1	PS101	21401	2022	fall	233876	46	5	10:00:00	11:30:00	\N	practice	98
НОЖ 1.1	PS101	21401	2022	fall	233876	46	5	11:40:00	13:10:00	\N	practice	99
НОЖ 1.1	PS101	21401	2022	fall	233876	48	5	10:00:00	11:30:00	\N	practice	100
НОЖ 1.1	PS101	21401	2022	fall	233876	48	5	11:40:00	13:10:00	\N	practice	101
НОЖ 1.1	PS101	21401	2022	fall	233876	50	5	10:00:00	11:30:00	\N	practice	102
НОЖ 1.1	PS101	21401	2022	fall	233876	50	5	11:40:00	13:10:00	\N	practice	103
НОЖ 1.1	PS101	21401	2022	fall	233876	52	5	10:00:00	11:30:00	\N	practice	104
НОЖ 1.1	PS101	21401	2022	fall	233876	52	5	11:40:00	13:10:00	\N	practice	105
R3243	MC305	33120	2022	fall	267987	36	4	17:00:00	18:30:00	\N	lecture	106
R3243	MC305	33120	2022	fall	267987	38	4	17:00:00	18:30:00	\N	lecture	107
R3243	MC305	33120	2022	fall	267987	40	4	17:00:00	18:30:00	\N	lecture	108
R3243	MC305	33120	2022	fall	267987	42	4	17:00:00	18:30:00	\N	lecture	109
R3243	MC305	33120	2022	fall	267987	44	4	17:00:00	18:30:00	\N	lecture	110
R3243	MC305	33120	2022	fall	267987	46	4	17:00:00	18:30:00	\N	lecture	111
R3243	MC305	33120	2022	fall	267987	48	4	17:00:00	18:30:00	\N	lecture	112
R3243	MC305	33120	2022	fall	267987	50	4	17:00:00	18:30:00	\N	lecture	113
R3243	MC305	33120	2022	fall	267987	52	4	17:00:00	18:30:00	\N	lecture	114
R3243	MC305	32401	2022	fall	267987	36	4	18:40:00	20:10:00	\N	practice	115
R3243	MC305	32401	2022	fall	267987	38	4	18:40:00	20:10:00	\N	practice	116
R3243	MC305	32401	2022	fall	267987	40	4	18:40:00	20:10:00	\N	practice	117
R3243	MC305	32401	2022	fall	267987	42	4	18:40:00	20:10:00	\N	practice	118
R3243	MC305	32401	2022	fall	267987	44	4	18:40:00	20:10:00	\N	practice	119
R3243	MC305	32401	2022	fall	267987	46	4	18:40:00	20:10:00	\N	practice	120
R3243	MC305	32401	2022	fall	267987	48	4	18:40:00	20:10:00	\N	practice	121
R3243	MC305	32401	2022	fall	267987	50	4	18:40:00	20:10:00	\N	practice	122
R3243	MC305	32401	2022	fall	267987	52	4	18:40:00	20:10:00	\N	practice	123
R3243	MC304	33413	2022	fall	267987	36	3	17:00:00	18:30:00	\N	lecture	124
R3243	MC304	33413	2022	fall	267987	38	3	17:00:00	18:30:00	\N	lecture	125
R3243	MC304	33413	2022	fall	267987	40	3	17:00:00	18:30:00	\N	lecture	126
R3243	MC304	33413	2022	fall	267987	42	3	17:00:00	18:30:00	\N	lecture	127
R3243	MC304	33413	2022	fall	267987	44	3	17:00:00	18:30:00	\N	lecture	128
R3243	MC304	33413	2022	fall	267987	46	3	17:00:00	18:30:00	\N	lecture	129
R3243	MC304	33413	2022	fall	267987	48	3	17:00:00	18:30:00	\N	lecture	130
R3243	MC304	33413	2022	fall	267987	50	3	17:00:00	18:30:00	\N	lecture	131
R3243	MC304	33413	2022	fall	267987	52	3	17:00:00	18:30:00	\N	lecture	132
R3243	MC304	33421	2022	fall	210976	36	3	18:40:00	20:10:00	\N	practice	133
R3243	MC304	33421	2022	fall	210976	37	3	18:40:00	20:10:00	\N	practice	134
R3243	MC304	33421	2022	fall	210976	38	3	18:40:00	20:10:00	\N	practice	135
R3243	MC304	33421	2022	fall	210976	39	3	18:40:00	20:10:00	\N	practice	136
R3243	MC304	33421	2022	fall	210976	40	3	18:40:00	20:10:00	\N	practice	137
R3243	MC304	33421	2022	fall	210976	41	3	18:40:00	20:10:00	\N	practice	138
R3243	MC304	33421	2022	fall	210976	42	3	18:40:00	20:10:00	\N	practice	139
R3243	MC304	33421	2022	fall	210976	43	3	18:40:00	20:10:00	\N	practice	140
R3243	MC304	33421	2022	fall	210976	44	3	18:40:00	20:10:00	\N	practice	141
R3243	MC304	33421	2022	fall	210976	45	3	18:40:00	20:10:00	\N	practice	142
R3243	MC304	33421	2022	fall	210976	46	3	18:40:00	20:10:00	\N	practice	143
R3243	MC304	33421	2022	fall	210976	47	3	18:40:00	20:10:00	\N	practice	144
R3243	MC304	33421	2022	fall	210976	48	3	18:40:00	20:10:00	\N	practice	145
R3243	MC304	33421	2022	fall	210976	49	3	18:40:00	20:10:00	\N	practice	146
R3243	MC304	33421	2022	fall	210976	50	3	18:40:00	20:10:00	\N	practice	147
R3243	MC304	33421	2022	fall	210976	51	3	18:40:00	20:10:00	\N	practice	148
R3243	MC304	33421	2022	fall	210976	52	3	18:40:00	20:10:00	\N	practice	149
R3243	ML303	\N	2022	fall	123443	36	1	18:40:00	20:10:00	\N	practice	150
R3243	ML303	\N	2022	fall	123443	37	1	18:40:00	20:10:00	\N	practice	151
R3243	ML303	\N	2022	fall	123443	38	1	18:40:00	20:10:00	\N	practice	152
R3243	ML303	\N	2022	fall	123443	39	1	18:40:00	20:10:00	\N	practice	153
R3243	ML303	\N	2022	fall	123443	40	1	18:40:00	20:10:00	\N	practice	154
R3243	ML303	\N	2022	fall	123443	41	1	18:40:00	20:10:00	\N	practice	155
R3243	ML303	\N	2022	fall	123443	42	1	18:40:00	20:10:00	\N	practice	156
R3243	ML303	\N	2022	fall	123443	43	1	18:40:00	20:10:00	\N	practice	157
R3243	ML303	\N	2022	fall	123443	\N	\N	18:40:00	20:10:00	2022-12-01	practice	158
R3243	ML303	\N	2022	fall	123443	\N	\N	18:40:00	20:10:00	2022-12-08	practice	159
R3243	ML303	\N	2022	fall	123443	\N	\N	18:40:00	20:10:00	2022-12-15	practice	160
\.


--
-- TOC entry 3443 (class 0 OID 17463)
-- Dependencies: 216
-- Data for Name: student; Type: TABLE DATA; Schema: structure; Owner: postgres
--

COPY structure.student (phone_no, student_isu_no, enroll_year, name) FROM stdin;
+79093094854	581450	2018	Цой Ариана Никитична
+79687366452	577660	2021	Ерохина Ясмин Федотовна
+79129915346	443933	2015	Краснянский Измаил Сократович
+79084231852	323102	2017	Серебров Елисей Игнатиевич
+79457825561	419113	2017	Петров Гавриил Брониславович
+79002705475	366924	2020	Минаева Изабелла Робертовна
+79524668373	495375	2016	Щеголяева Жасмина Альбертовна
+79505643539	377088	2016	Чужинова Василина Мефодиевна
+79391996891	593848	2022	Москвина Любовь Несторовна
+79466126880	611086	2022	Абоимова Светлана Артёмовна
+79386453481	401338	2020	Лидина Асия Билаловна
+79326785731	410526	2020	Тупицын Онуфрий Яковович
+79958264839	360931	2016	Рошет Феофан Якубович
+79026292002	319213	2019	Божко Лариса Данииловна
+79009404225	507752	2022	Койначёнок Никита Павлович
+79394291614	681895	2016	Федорова Василиса Каримовна
+79826238751	604171	2016	Матизов Ираклий Константинович
+79858855110	460919	2017	Бухало Семён Титович
+79504306363	500747	2020	Сязи Ирина Михайловна
+79191090360	578792	2021	Яманова Роза Валерьевна
+79004927702	333088	2015	Карасёва Камила Рустамовна
+79756081872	674668	2017	Катериночкина Кира Святославовна
+79757219133	685276	2021	Салькова Алеся Федотовна
+79578962090	304463	2017	Черенчикова Алисия Рафаэльевна
+79317570203	648418	2018	Маслака Николь Руслановна
+79224766424	682719	2016	Токмакова Агата Юрьевна
+79604481819	381269	2018	Воликов Демид Данисович
+79331135188	442414	2017	Кравец Аскольд Эрнстович
+79954323956	363329	2017	Яркина Амелия Камильевна
+79755609356	345485	2020	Горячев Адриан Артемович
+79506725564	596939	2021	Иноземцева Оксана Назаровна
+79933924352	306015	2019	Еркулаева Соня Николаевна
+79487043506	543550	2021	Канаша Лея Германовна
+79418314927	644989	2020	Кирсанов Владилен Семенович
+79889384549	480464	2018	Счастливцев Никон Фомевич
+79638133799	359227	2019	Енотова Фаина Анатольевна
+79599850827	587913	2018	Шлыков Владимир Севастьянович
+79903631985	418710	2017	Ярков Арсений Валерьевич
+79704510896	524242	2017	Ходяев Федот Игнатиевич
+79747787832	435983	2019	Кузубов Елизар Ерофеевич
+79811677649	314828	2017	Орехов Захар Анатолиевич
+79476704319	485174	2018	Пярин Радислав Ермолаевич
+79656830634	562774	2022	Митькин Аркадий Эрнестович
+79625712155	681655	2020	Султанов Всеволод Евгеньевич
+79513234880	694903	2020	Щеголяев Максимильян Мечиславович
+79494008598	386184	2017	Куклачёва Миа Николаевна
+79137511646	440404	2021	Хромченко Игнатий Якубович
+79957083156	321385	2021	Харитонюк Марсель Михаилович
+79036386093	573800	2019	Фотина Мелисса Ильинична
+79362853164	552768	2017	Бондарев Рафаэль Антонович
+79378557839	613357	2022	Каверин Ким Борисович
+79515466824	547570	2017	Папилов Потап Ильевич
+79388164426	565890	2020	Шишмарёва Рената Марковна
+79386554742	440409	2018	Янсона Диана Арсеновна
+79392627553	378732	2022	Лопатина Сабрина Витальевна
+79080816058	605342	2018	Фомин Антип Агапович
+79420704780	409696	2018	Якутин Александр Савельевич
+79027394258	530575	2021	Канунников Данияр Титович
+79660356063	679991	2019	Сиялов Анатолий Миронович
+79830266901	534917	2021	Ефремова Ясмина Ираклиевна
+79874656567	606662	2015	Кошельков Якуб Леонтиевич
+79966840405	326207	2016	Кобелева Марфа Рустамовна
+79788437174	433447	2015	Гершельмана Инесса Даниэльевна
+79964473261	515133	2015	Стародубцева Марина Михайловна
+79587428911	533439	2016	Ярочкин Лукьян Валерьянович
+79910246873	437510	2016	Жолдин Емельян Богданович
+79387367061	435202	2020	Висенин Лаврентий Измаилович
+79339617731	645737	2020	Мещерякова Марианна Егоровна
+79202425704	600264	2021	Шульгина Лада Данисовна
+79089352787	420858	2018	Яценковский Эдуард Севастьянович
+79042296238	402101	2021	Титов Тарас Эмилевич
+79045312289	621690	2022	Пустохин Эрнест Никитич
+79688602153	376704	2017	Саянков Терентий Феоктистович
+79206844660	671026	2020	Черникова Елена Георгиевна
+79559774988	504631	2015	Якунчикова Вера Саввична
+79235228531	598139	2017	Громыко Валерьян Мартинович
+79891112367	426239	2019	Милюкова Станислава Егоровна
+79081542832	481495	2015	Кравчука Маргарита Константиновна
+79059995055	453803	2016	Берлунова Лия Германовна
+79660203807	366929	2015	Черных Валентина Степановна
+79512628667	344878	2015	Подшивалов Артём Брониславович
+79797664257	492938	2016	Яхненко Ника Дмитриевна
+79339542790	587335	2020	Арцишевский Кузьма Валериевич
+79818005189	627027	2015	Ратаева Владислава Елизаровна
+79434007140	375968	2020	Ювелев Эмиль Проклович
+79508398050	321148	2020	Караева Арина Марковна
+79504894820	583714	2018	Милюкова Сафия Богдановна
+79563109129	544422	2020	Трошкин Капитон Альбертович
+79989845168	634528	2018	Дроздова Тея Игоревна
+79211814423	500668	2016	Яхин Нестор Брониславович
+79111957130	407303	2022	Миронова Сара Якововна
+79826351827	396631	2022	Вихорев Павел Маркович
+79724450073	361373	2015	Половов Владлен Эмилевич
+79355216311	631248	2016	Ляпина Ульяна Афанасиевна
+79088366663	630473	2021	Лепихова Любава Федоровна
+79228382658	633704	2021	Самойлов Святослав Даниэльевич
+79370937449	630005	2019	Третьякова Ася Семеновна
+79843310823	396837	2022	Мосина Аврора Гордеевна
+79209028801	319556	2017	Шлиппенбах Родион Михайлович
+79330585910	474671	2018	Картавый Игорь Натанович
+79835424626	603965	2017	Пудина Вероника Фомевна
+79909109516	675475	2020	Безродный Елизавета Петровна
+79726829008	342563	2017	Грекова Валерия Несторовна
+79809203796	409312	2015	Мячиков Тимофей Трофимович
+79172291725	646056	2017	Шапошникова Василиса Юрьевна
+79265284111	379423	2020	Карташёва Александра Эминовна
+79425251220	683647	2018	Малинина Сафия Игоревна
+79249741025	304535	2022	Яковлева Мариам Яромировна
+79549473842	516722	2018	Новичкова Жасмина Руслановна
+79277424433	562719	2021	Травин Аркадий Вячеславович
+79983016175	313894	2015	Меркушев Юлиан Ипатиевич
+79826768261	563050	2016	Лозанов Егор Артемьевич
+79632820368	662126	2019	Волошина Инна Лукинична
+79373862278	393417	2020	Лазуткина Ульяна Борисовна
+79155343357	617497	2015	Малиновский Соломон Прохорович
+79152989371	546241	2020	Сунгатулин Зиновий Прохорович
+79088351135	602390	2021	Алешина Ефросинья Никитична
+79153445625	398146	2018	Эскина Сара Иларионовна
+79267476384	491686	2017	Звягина Пелагея Якововна
+79831095427	348231	2020	Тукай Камилла Антоновна
+79446068235	661068	2018	Астахов Вениамин Натанович
+79376236501	322378	2019	Комзина Ирина Захаровна
+79201753749	648911	2015	Гоминов Стефан Святославович
+79698224025	301209	2016	Быстров Серафим Михеевич
+79260637657	581259	2019	Ратаева Марфа Виталиевна
+79413696520	636772	2015	Слепынин Венедикт Добрынич
+79474411707	571196	2020	Белоконь Роза Эминовна
+79724666579	371125	2017	Игошева Марта Макаровна
+79093456163	316501	2018	Паршина Лея Анатолиевна
+79271799418	641752	2016	Розанов Тарас Артемович
+79060828104	630665	2019	Поджио Марьяна Святославовна
+79486065946	661497	2020	Агафонова Алия Елизаровна
+79945424614	657715	2015	Яздовский Данила Богданович
+79029898983	517864	2019	Витвинский Павел Кириллович
+79089322638	404951	2019	Бурков Рустам Всеволодович
+79044601784	323208	2018	Ширяев Изяслав Измаилович
+79602227437	649062	2020	Гусарова Анжелика Константиновна
+79812572107	345794	2022	Монакова София Демидовна
+79888091390	678700	2022	Румянцев Лавр Владимирович
+79735539964	600804	2018	Давыдова Виталина Никитична
+79793351543	526811	2021	Бялик Данис Эрнестович
+79582491477	545726	2016	Есипова Екатерина Лукинична
+79135538375	690768	2020	Хабибова Серафима Тимофеевна
+79640278247	565330	2017	Ядучев Руслан Геннадиевич
+79307932225	302308	2016	Орел Игорь Макарович
+79160727102	583356	2017	Мишутин Рюрик Пахомович
+79004163172	575672	2017	Мешкова Стела Назаровна
+79843076263	330955	2019	Хитрово Ким Фролович
+79273007315	320133	2017	Демьянов Даниэль Агапович
+79181881305	332543	2019	Кузиева Аглая Филипповна
+79612938983	392922	2020	Ягодинский Мстислав Онисимович
+79847027126	300803	2021	Грибакин Марк Леонидович
+79094803584	625610	2019	Осокина Алисия Ипполитовна
+79357899384	329839	2019	Жжёнова Наталья Андрияновна
+79249801280	470838	2020	Агапов Елисей Сидорович
+79385654749	650086	2016	Онегин Назар Федосиевич
+79687671939	345005	2019	Арсеиньева Лидия Владиславовна
+79395293015	508406	2021	Жернакова Эльвира Трофимовна
+79750671137	638458	2015	Евтушенков Максим Кондратович
+79283911179	554563	2017	Григорьева Ясмин Андреевна
+79318197129	580390	2022	Ноздрин Евграф Чеславович
+79088583322	633905	2020	Агеева Злата Мефодиевна
+79488561674	533227	2019	Рогозин Али Изяславович
+79209851803	628291	2016	Сайтахметова Аделя Леоновна
+79793146399	370290	2017	Глушкова Аиша Трофимовна
+79526737069	571691	2016	Кобзева Айлин Давидовна
+79083749822	575860	2020	Борисов Дмитрий Карлович
+79625900859	502495	2015	Быкова Юнона Антониновна
+79969750249	582213	2020	Болокана Вера Афанасиевна
+79083211501	456901	2018	Баренцев Валерий Родионович
+79179992066	536796	2019	Дунин-Барковский Святослав Русланович
+79844370079	354544	2017	Дукачёва Теона Трофимовна
+79798942608	400532	2019	Ерохина Софья Давидовна
+79739094234	358575	2017	Самохин Ираклий Еремеевич
+79973098437	427705	2021	Антонович Надежда Германовна
+79374504777	447994	2016	Дворецков Аристарх Данисович
+79936115486	354605	2021	Помельников Глеб Эрнестович
+79931754452	585150	2020	Гнусарев Самсон Артемиевич
+79187773033	564470	2015	Званцев Рубен Андронович
+79217114007	342438	2017	Яловенко Макар Федорович
+79425961365	417773	2017	Ягуткин Филимон Савельевич
+79976933277	377670	2022	Дудкин Фома Миронович
+79714645804	533112	2015	Дедов Чеслав Георгиевич
+79067250684	437028	2022	Кокоткин Борислав Савелиевич
+79873324396	566127	2022	Страхова Марьям Витальевна
+79757289161	317643	2022	Криштофич Давид Андриянович
+79982069530	374402	2021	Шувалова Адель Петровна
+79137624000	549949	2016	Саитов Валерьян Лукич
+79436523462	341221	2018	Ярмольника Милослава Фомевна
+79114995848	648962	2018	Гриневеца Марина Елизаровна
+79760120916	475970	2022	Максудов Захар Валериевич
+79038862358	392767	2015	Ковтунова Дарина Васильевна
+79105889416	570038	2021	Колотушкина Амалия Альбертовна
+79459980710	425267	2016	Искрицкий Карл Федотович
+79143315303	333162	2016	Яматин Авдей Данисович
+79026194551	640684	2019	Фастер Михаил Станиславович
+79933119543	635313	2016	Феднов Бронислав Андронович
+79499331735	672734	2020	Характеров Степан Глебович
+79776167067	339637	2019	Эзрина Лада Анатолиевна
+79175624042	551814	2022	Швецова Альбина Марковна
+79526840252	595522	2019	Оськин Серафим Владимирович
+79387024036	537302	2015	Сухов Михей Сократович
+79980802049	502768	2016	Хомичев Прохор Альбертович
+79007493839	564019	2017	Толстокожев Моисей Несторович
+79358720459	683109	2015	Задков Ефрем Архипович
+79714816512	696621	2018	Жаркин Даниэль Данилович
+79293957392	406192	2020	Антонова Ясина Вячеславовна
+79954949900	407776	2015	Переверзев Владислав Борисович
+79980552887	336945	2017	Кондрат Яков Проклович
+79309032023	511783	2020	Ячевский Демид Самуилович
+79721329413	614986	2018	Коренев Поликарп Трофимович
+79623314107	596832	2019	Ромазанов Добрыня Владимирович
+79326294368	635806	2016	Деникина Лада Елисеевна
+79197145024	346726	2020	Абумайлов Мирон Михеевич
+79000697652	341255	2017	Суснин Илья Модестович
+79078044364	478461	2020	Уржумцева Пелагея Романовна
+79713985893	434292	2020	Грибалева Оливия Евгеньевна
+79311114905	526353	2021	Солодский Мартин Игоревич
+79919894407	669684	2015	Дёшин Марк Богданович
+79154654301	374775	2019	Доронина Камила Яновна
+79605938562	363204	2020	Борцова Вера Витальевна
+79558728145	316269	2021	Ручкин Демьян Измаилович
+79221208853	469480	2017	Ожгибесов Герасим Рустамович
+79933901704	379303	2015	Каипов Юлиан Климович
+79279266428	548293	2015	Набойщикова Нина Станиславовна
+79803708668	654139	2017	Янаслов Кондратий Эмирович
+79469259706	384308	2021	Семина Николь Витальевна
+79218588458	672794	2018	Кияк Гаврила Иннокентиевич
+79561100911	396371	2021	Туполев Тимофей Эрнестович
+79703231722	679128	2017	Дорофеев Тимур Феоктистович
+79344437210	540922	2022	Тимирёв Всеволод Якубович
+79793419717	372469	2020	Державина Евангелина Яновна
+79312393487	307129	2022	Чичваркин Терентий Григорьевич
+79420003107	405059	2016	Мазурин Арсен Демидович
+79871390640	673848	2017	Кобонова Людмила Владленовна
+79781493762	468956	2021	Калугин Леонид Евгениевич
+79665702618	642482	2018	Успенский Игорь Аполлинариевич
+79155992343	361249	2015	Чазова Амалия Евгеньевна
+79943653927	436667	2017	Кулешова Моника Виталиевна
+79609975155	694028	2017	Половов Гавриил Сократович
+79250025233	643901	2022	Махнёв Степан Серафимович
+79111852806	610018	2018	Яковенцев Вячеслав Билалович
+79739304094	402714	2019	Анников Федор Петрович
+79103896032	482117	2020	Суслякова Адель Эмировна
+79424266528	372996	2015	Автухова Валентина Билаловна
+79819664303	632188	2019	Шамякина Ксения Емельяновна
+79723559388	663346	2017	Теплухин Аскольд Кондратиевич
+79287180132	394153	2015	Комарова Ирина Кузьмевна
+79649797895	403950	2021	Кочкорбаев Валентин Глебович
+79160112494	492546	2018	Романова Виталина Данилевна
+79419330313	520695	2016	Хмельнов Эрнст Данилевич
+79751271709	624067	2020	Бугаков Онуфрий Иосифович
+79498485096	331132	2021	Сабанцев Тарас Якубович
+79784916402	597197	2018	Чечин Петр Игнатиевич
+79932300600	484281	2021	Яковеца Юнона Даниловна
+79300602317	567089	2016	Кадетова Инна Фомевна
+79524969925	687698	2017	Стаин Мир Тарасович
+79999590482	560786	2018	Тюлепова Ева Филипповна
+79285408180	653603	2022	Нилин Нестор Каримович
+79906176965	516227	2021	Чебыкина Варвара Павеловна
+79764937203	586466	2017	Агеева Эльвира Григорьевна
+79933737725	629382	2022	Лапина Аида Всеволодовна
+79479002257	324546	2021	Корчагина Валерия Егоровна
+79372667376	584232	2019	Нутрихина Лариса Ильевна
+79617307592	575987	2017	Осокина Мелисса Вадимовна
+79848963466	337346	2019	Мозжухин Агафон Ильевич
+79664120076	572887	2015	Руднев Ким Ильевич
+79443250833	652179	2017	Убейсобакина Мариам Марковна
+79005806867	562962	2015	Кочнев Аристарх Демьянович
+79621289118	413333	2021	Бок Пахом Владиславович
+79145328753	583309	2019	Богуна София Львовна
+79403142034	338225	2016	Акимова Екатерина Викторовна
+79772124196	442353	2016	Бугайчук Святослав Сидорович
+79795434318	507084	2021	Корбылев Эрик Ульянович
+79380182423	660951	2018	Другаков Бронислав Александрович
+79628431611	368482	2018	Поздова Айша Андрияновна
+79473957271	430862	2022	Ковригина Каролина Тиграновна
+79325683401	495326	2021	Толкачев Прокл Никитич
+79544198528	501649	2018	Краснянский Рюрик Геннадиевич
+79897145131	301577	2016	Анисимова Ася Фёдоровна
+79518633127	541056	2021	Ярославцев Данила Яковович
+79977621842	404035	2015	Федоров Прокофий Натанович
+79157224845	652724	2015	Янибеков Савелий Венедиктович
+79556753562	694256	2015	Котик Евдоким Фёдорович
+79041062798	682879	2020	Ябловский Эммануил Олегович
+79384274648	654319	2019	Ульяшин Кузьма Онисимович
+79056092163	636797	2021	Лебедева Александра Денисовна
+79748402984	532028	2019	Бока Мила Дмитриевна
+79723977483	395619	2019	Головченко Ясмина Яромировна
+79746606619	495371	2016	Волынкина Дария Михеевна
+79338601790	457539	2018	Грош Ипполит Ростиславович
+79440936369	588022	2017	Тукаева Марта Игнатиевна
+79535441092	686513	2015	Куликова Медина Рустамовна
+79649252941	683183	2017	Перевалова Аиша Эриковна
+79275675159	326886	2017	Мозговой Рубен Федосиевич
+79923390307	683994	2015	Плахтюрин Феофан Чеславович
+79660894082	663047	2019	Сиянко Белла Александровна
+79125779448	565369	2016	Ремизов Емельян Максимович
+79965667234	622509	2015	Огородников Богдан Яковлевич
+79737544490	300782	2015	Гаврин Фока Брониславович
+79522686469	361422	2022	Оськин Серафим Владимирович
+79231696284	657507	2018	Сухов Михей Сократович
+79041547344	673373	2021	Хомичев Прохор Альбертович
+79918705498	388664	2021	Толстокожев Моисей Несторович
+79701895694	527327	2020	Задков Ефрем Архипович
+79154529863	625952	2021	Жаркин Даниэль Данилович
+79360615786	662005	2015	Антонова Ясина Вячеславовна
+79368364139	418943	2021	Переверзев Владислав Борисович
+79645048311	325397	2017	Кондрат Яков Проклович
+79782397964	459520	2017	Ячевский Демид Самуилович
+79176208208	413471	2021	Коренев Поликарп Трофимович
+79201006278	374570	2015	Ромазанов Добрыня Владимирович
+79593909528	400878	2019	Деникина Лада Елисеевна
+79032741875	348027	2018	Абумайлов Мирон Михеевич
+79515170884	306307	2017	Суснин Илья Модестович
+79204477451	448505	2016	Уржумцева Пелагея Романовна
+79352405791	523488	2022	Грибалева Оливия Евгеньевна
+79726972237	480733	2016	Солодский Мартин Игоревич
+79795769913	427353	2016	Дёшин Марк Богданович
+79591224180	553257	2017	Доронина Камила Яновна
+79682445841	336208	2015	Борцова Вера Витальевна
+79962144692	576363	2019	Ручкин Демьян Измаилович
+79441284311	323407	2022	Ожгибесов Герасим Рустамович
+79302232419	319255	2022	Каипов Юлиан Климович
+79348819624	356639	2019	Набойщикова Нина Станиславовна
+79336953370	538724	2020	Янаслов Кондратий Эмирович
+79857823452	497524	2022	Семина Николь Витальевна
+79378745466	687728	2020	Кияк Гаврила Иннокентиевич
+79998162389	448346	2021	Туполев Тимофей Эрнестович
+79669416861	699425	2016	Дорофеев Тимур Феоктистович
+79414113840	655802	2018	Тимирёв Всеволод Якубович
+79346031353	445163	2017	Державина Евангелина Яновна
+79735026073	325561	2016	Чичваркин Терентий Григорьевич
+79571686699	404581	2018	Мазурин Арсен Демидович
+79790070575	692166	2015	Кобонова Людмила Владленовна
+79525708076	663494	2015	Калугин Леонид Евгениевич
+79788525676	321174	2018	Успенский Игорь Аполлинариевич
+79670278932	387548	2022	Чазова Амалия Евгеньевна
+79827498993	442880	2016	Кулешова Моника Виталиевна
+79776931808	386813	2019	Половов Гавриил Сократович
+79196809659	524896	2022	Махнёв Степан Серафимович
+79632467858	388607	2015	Яковенцев Вячеслав Билалович
+79800150931	315561	2017	Анников Федор Петрович
+79051684278	574029	2019	Суслякова Адель Эмировна
+79237014876	666919	2018	Автухова Валентина Билаловна
+79479734625	380255	2021	Шамякина Ксения Емельяновна
+79433909783	628133	2018	Теплухин Аскольд Кондратиевич
+79889668757	398358	2016	Комарова Ирина Кузьмевна
+79670972636	504952	2017	Кочкорбаев Валентин Глебович
+79119265100	440318	2018	Романова Виталина Данилевна
+79814900856	685487	2018	Хмельнов Эрнст Данилевич
+79459490023	374480	2021	Бугаков Онуфрий Иосифович
+79864567011	640747	2020	Сабанцев Тарас Якубович
+79439687384	586175	2021	Чечин Петр Игнатиевич
+79121123509	696043	2016	Яковеца Юнона Даниловна
+79208413754	476186	2020	Кадетова Инна Фомевна
+79163240273	392110	2020	Стаин Мир Тарасович
+79489710478	613231	2016	Тюлепова Ева Филипповна
+79508737671	371210	2020	Нилин Нестор Каримович
+79326751695	330044	2017	Чебыкина Варвара Павеловна
+79517411376	634075	2019	Агеева Эльвира Григорьевна
+79477452101	458410	2015	Лапина Аида Всеволодовна
+79263409690	358237	2017	Корчагина Валерия Егоровна
+79853410777	669828	2019	Нутрихина Лариса Ильевна
+79993350494	423272	2015	Осокина Мелисса Вадимовна
+79020387033	452308	2018	Мозжухин Агафон Ильевич
+79931567584	475025	2017	Руднев Ким Ильевич
+79388189471	619441	2020	Убейсобакина Мариам Марковна
+79317932675	303447	2022	Кочнев Аристарх Демьянович
+79369335988	423797	2017	Бок Пахом Владиславович
+79865029427	523066	2020	Богуна София Львовна
+79856001966	339868	2017	Акимова Екатерина Викторовна
+79633528382	526029	2020	Бугайчук Святослав Сидорович
+79489240749	694615	2019	Корбылев Эрик Ульянович
+79737281358	368820	2017	Другаков Бронислав Александрович
+79753324831	377268	2015	Поздова Айша Андрияновна
+79766021460	497614	2020	Ковригина Каролина Тиграновна
+79566065773	606212	2022	Толкачев Прокл Никитич
+79677671026	379336	2018	Краснянский Рюрик Геннадиевич
+79178278158	336166	2017	Анисимова Ася Фёдоровна
+79318396823	580554	2019	Ярославцев Данила Яковович
+79820202519	461607	2022	Федоров Прокофий Натанович
+79781122765	305423	2018	Янибеков Савелий Венедиктович
+79391531312	526003	2020	Котик Евдоким Фёдорович
+79011422498	405456	2020	Ябловский Эммануил Олегович
+79084530245	549509	2019	Ульяшин Кузьма Онисимович
+79355352076	434531	2017	Лебедева Александра Денисовна
+79224446793	553176	2021	Бока Мила Дмитриевна
+79966098959	620517	2015	Головченко Ясмина Яромировна
+79912578204	472915	2020	Волынкина Дария Михеевна
+79514311691	586668	2021	Грош Ипполит Ростиславович
+79533853497	579076	2020	Тукаева Марта Игнатиевна
+79661527923	401707	2021	Куликова Медина Рустамовна
+79723351533	662400	2021	Перевалова Аиша Эриковна
+79859540572	600893	2022	Мозговой Рубен Федосиевич
+79728932720	306417	2020	Плахтюрин Феофан Чеславович
+79641134746	523117	2020	Сиянко Белла Александровна
+79428035876	450726	2020	Ремизов Емельян Максимович
+79455604177	466013	2021	Огородников Богдан Яковлевич
+79442024957	308893	2018	Гаврин Фока Брониславович
\.


--
-- TOC entry 3442 (class 0 OID 17435)
-- Dependencies: 215
-- Data for Name: student_status; Type: TABLE DATA; Schema: structure; Owner: postgres
--

COPY structure.student_status (group_no, status, start_date, end_date, student_isu_no, id_status) FROM stdin;
R3143	finished	2021-09-01	2022-07-01	300803	1
R3143	academic leave	2021-09-01	2021-12-05	577660	2
R3143	finished	2021-09-01	2022-07-01	578792	3
R3143	academic leave	2021-09-01	2021-10-08	586175	4
R3143	finished	2021-09-01	2022-07-01	586668	5
R3143	finished	2021-09-01	2022-07-01	596939	6
R3143	finished	2021-09-01	2022-07-01	600264	7
R3143	finished	2021-09-01	2022-07-01	602390	8
R3143	finished	2021-09-01	2022-07-01	625952	9
R3143	finished	2021-09-01	2022-07-01	630473	10
R3143	finished	2021-09-01	2022-07-01	633704	11
R3143	finished	2021-09-01	2022-07-01	636797	12
R3143	finished	2021-09-01	2022-07-01	662400	13
R3143	finished	2021-09-01	2022-07-01	673373	14
R3143	debt	2021-09-01	2022-04-25	685276	15
R3243	study	2022-09-01	\N	300803	16
R3243	study	2022-09-01	\N	578792	17
R3243	study	2022-09-01	\N	586668	18
R3243	study	2022-09-01	\N	596939	19
R3243	study	2022-09-01	\N	600264	20
R3243	study	2022-09-01	\N	602390	21
R3243	study	2022-09-01	\N	625952	22
R3243	study	2022-09-01	\N	630473	23
R3243	academic leave	2022-09-01	2023-01-17	633704	24
R3243	study	2022-09-01	\N	636797	25
R3243	study	2022-09-01	\N	662400	26
R3243	study	2022-09-01	\N	673373	27
K32422	study	2022-09-01	\N	316269	28
K32422	study	2022-09-01	\N	321385	29
K32422	academic leave	2022-09-01	2022-12-02	324546	30
K32422	study	2022-09-01	\N	331132	31
K32422	study	2022-09-01	\N	354605	32
K32422	study	2022-09-01	\N	374402	33
K32422	study	2022-09-01	\N	374480	34
K32422	study	2022-09-01	\N	380255	35
K32422	study	2022-09-01	\N	384308	36
K32422	debt	2022-09-01	2023-04-15	388664	37
K32422	study	2022-09-01	\N	396371	38
K32422	study	2022-09-01	\N	401707	39
K32422	study	2022-09-01	\N	402101	40
K32422	study	2022-09-01	\N	403950	41
K32422	study	2022-09-01	\N	413333	42
K32422	debt	2022-09-01	2023-04-15	413471	43
K32422	study	2022-09-01	\N	418943	44
K32422	study	2022-09-01	\N	427705	45
K32422	study	2022-09-01	\N	440404	46
K32422	study	2022-09-01	\N	448346	47
K32422	study	2022-09-01	\N	466013	48
АЯ-С1/1	finished	2022-09-01	2023-01-25	304535	49
АЯ-С1/1	finished	2022-09-01	2023-01-25	345794	50
АЯ-С1/1	finished	2022-09-01	2023-01-25	378732	51
АЯ-С1/1	finished	2022-09-01	2023-01-25	388664	52
АЯ-С1/1	finished	2022-09-01	2023-01-25	403950	53
АЯ-С1/1	finished	2022-09-01	2023-01-25	418943	54
АЯ-С1/1	academic leave	2022-09-01	2022-10-23	437028	55
АЯ-С1/1	finished	2022-09-01	2023-01-25	440404	56
АЯ-С1/1	finished	2022-09-01	2023-01-25	448346	57
АЯ-С1/1	finished	2022-09-01	2023-01-25	475970	58
АЯ-С1/1	finished	2022-09-01	2023-01-25	507084	59
АЯ-С1/1	finished	2022-09-01	2023-01-25	516227	60
АЯ-С1/1	finished	2022-09-01	2023-01-25	524896	61
АЯ-С1/1	finished	2022-09-01	2023-01-25	526353	62
АЯ-С1/1	finished	2022-09-01	2023-01-25	534917	63
АЯ-С1/1	finished	2022-09-01	2023-01-25	540922	64
АЯ-С1/1	academic leave	2022-09-01	2022-11-19	551814	65
АЯ-С1/2	study	2023-02-06	\N	348231	66
АЯ-С1/2	study	2023-02-06	\N	371210	67
АЯ-С1/2	study	2023-02-06	\N	392110	68
АЯ-С1/2	study	2023-02-06	\N	392922	69
АЯ-С1/2	study	2023-02-06	\N	405456	70
АЯ-С1/2	study	2023-02-06	\N	406192	71
АЯ-С1/2	study	2023-02-06	\N	434292	72
АЯ-С1/2	study	2023-02-06	\N	470838	73
АЯ-С1/2	study	2023-02-06	\N	472915	74
АЯ-С1/2	study	2023-02-06	\N	497614	75
АЯ-С1/2	study	2023-02-06	\N	523117	76
НОЖ 1	finished	2022-09-01	2023-01-25	316269	77
НОЖ 1	finished	2022-09-01	2023-01-25	331132	78
НОЖ 1	finished	2022-09-01	2023-01-25	354605	79
НОЖ 1	finished	2022-09-01	2023-01-25	374402	80
НОЖ 1	finished	2022-09-01	2023-01-25	374480	81
НОЖ 1	finished	2022-09-01	2023-01-25	384308	82
НОЖ 1	finished	2022-09-01	2023-01-25	388664	83
НОЖ 1	finished	2022-09-01	2023-01-25	402101	84
НОЖ 1	finished	2022-09-01	2023-01-25	403950	85
НОЖ 1	finished	2022-09-01	2023-01-25	413333	86
НОЖ 1	finished	2022-09-01	2023-01-25	418943	87
НОЖ 1	finished	2022-09-01	2023-01-25	448346	88
НОЖ 1	finished	2022-09-01	2023-01-25	468956	89
НОЖ 1	finished	2022-09-01	2023-01-25	484281	90
НОЖ 1	finished	2022-09-01	2023-01-25	507084	91
НОЖ 1	finished	2022-09-01	2023-01-25	516227	92
НОЖ 1	finished	2022-09-01	2023-01-25	526811	93
НОЖ 1	finished	2022-09-01	2023-01-25	534917	94
НОЖ 1	finished	2022-09-01	2023-01-25	543550	95
НОЖ 1.1	finished	2022-09-01	2023-01-25	354605	96
НОЖ 1.1	finished	2022-09-01	2023-01-25	374402	97
НОЖ 1.1	finished	2022-09-01	2023-01-25	384308	98
НОЖ 1.1	finished	2022-09-01	2023-01-25	402101	99
НОЖ 1.1	finished	2022-09-01	2023-01-25	413333	100
НОЖ 1.1	finished	2022-09-01	2023-01-25	468956	101
НОЖ 1.1	finished	2022-09-01	2023-01-25	516227	102
НОЖ 1.1	finished	2022-09-01	2023-01-25	526811	103
НОЖ 1.1	finished	2022-09-01	2023-01-25	543550	104
\.


--
-- TOC entry 3439 (class 0 OID 16426)
-- Dependencies: 212
-- Data for Name: tutor; Type: TABLE DATA; Schema: structure; Owner: postgres
--

COPY structure.tutor (name, tutor_isu_no, "position", phone) FROM stdin;
Гойл Ариана	123443	mentor	+79634519834
Джонс Марта 	111982	professor	+79005623462
Бортко Кирилл Иванович	111981	professor	+79167894300
Железнов Василий Юрьевич	109724	professor	+79231098722
Казачкова Марина Елизаровна	245672	mentor	+79839309813
Шурма Родион Васильевич	100087	professor	+79660982743
Алексеева Жанар Маратовна	274508	assistant	+79017823309
Тимошенко Жанна Викторовна	233876	professor	+79087357771
Иванова Лариса Дмитриевна	109885	professor	+79654491277
Жирко Виталий Павлович	199870	mentor	+79003462728
Тшасковский Рафал	267987	assistant	+79636781233
Фогель Александр	210976	professor	+79994628916
Ковалев Иван Денисович	199856	mentor	+79883092164
\.


--
-- TOC entry 3259 (class 2606 OID 49992)
-- Name: student_status ,m ; Type: CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.student_status
    ADD CONSTRAINT ",m " UNIQUE (group_no, student_isu_no);


--
-- TOC entry 3208 (class 2606 OID 17322)
-- Name: auditory auditory no; Type: CHECK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE structure.auditory
    ADD CONSTRAINT "auditory no" CHECK ((auditory_no > 0)) NOT VALID;


--
-- TOC entry 3239 (class 2606 OID 17284)
-- Name: auditory auditory_no; Type: CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.auditory
    ADD CONSTRAINT auditory_no UNIQUE (auditory_no);


--
-- TOC entry 3241 (class 2606 OID 33653)
-- Name: auditory auditory_pkey; Type: CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.auditory
    ADD CONSTRAINT auditory_pkey PRIMARY KEY (auditory_no);


--
-- TOC entry 3215 (class 2606 OID 17217)
-- Name: schedule begin time; Type: CHECK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE structure.schedule
    ADD CONSTRAINT "begin time" CHECK (((begin_time >= '08:20:00'::time without time zone) AND (begin_time <= '20:20:00'::time without time zone))) NOT VALID;


--
-- TOC entry 3243 (class 2606 OID 17540)
-- Name: building build; Type: CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.building
    ADD CONSTRAINT build UNIQUE (building_no);


--
-- TOC entry 3211 (class 2606 OID 17321)
-- Name: building building no; Type: CHECK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE structure.building
    ADD CONSTRAINT "building no" CHECK ((building_no > 0)) NOT VALID;


--
-- TOC entry 3245 (class 2606 OID 17307)
-- Name: building building_pkey; Type: CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.building
    ADD CONSTRAINT building_pkey PRIMARY KEY (building_no);


--
-- TOC entry 3229 (class 2606 OID 25491)
-- Name: discipline credit; Type: CHECK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE structure.discipline
    ADD CONSTRAINT credit CHECK (((type_of_credit)::text = ANY (ARRAY[('exam'::character varying)::text, ('pass'::character varying)::text, ('differentiable pass'::character varying)::text, ('course work'::character varying)::text]))) NOT VALID;


--
-- TOC entry 3230 (class 2606 OID 41798)
-- Name: discipline credit un; Type: CHECK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE structure.discipline
    ADD CONSTRAINT "credit un" CHECK (((credit_unit >= 1) AND (credit_unit <= 5))) NOT VALID;


--
-- TOC entry 3223 (class 2606 OID 33642)
-- Name: student_status date; Type: CHECK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE structure.student_status
    ADD CONSTRAINT date CHECK ((end_date > start_date)) NOT VALID;


--
-- TOC entry 3222 (class 2606 OID 33619)
-- Name: group date of deform; Type: CHECK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE structure."group"
    ADD CONSTRAINT "date of deform" CHECK ((date_of_deform > date_of_form)) NOT VALID;


--
-- TOC entry 3279 (class 2606 OID 25434)
-- Name: direction direct; Type: CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.direction
    ADD CONSTRAINT direct PRIMARY KEY (direction_code);


--
-- TOC entry 3269 (class 2606 OID 25466)
-- Name: discipline disc; Type: CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.discipline
    ADD CONSTRAINT disc UNIQUE (discipline_code);


--
-- TOC entry 3271 (class 2606 OID 25464)
-- Name: discipline discipline un; Type: CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.discipline
    ADD CONSTRAINT "discipline un" PRIMARY KEY (discipline_code);


--
-- TOC entry 3281 (class 2606 OID 41800)
-- Name: discipline_list discipline_list_pkey; Type: CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.discipline_list
    ADD CONSTRAINT discipline_list_pkey PRIMARY KEY (id_discipline);


--
-- TOC entry 3273 (class 2606 OID 25529)
-- Name: edu_plan edu plan; Type: CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.edu_plan
    ADD CONSTRAINT "edu plan" UNIQUE (edu_plan_no);


--
-- TOC entry 3275 (class 2606 OID 33666)
-- Name: edu_plan edu_plan_pkey; Type: CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.edu_plan
    ADD CONSTRAINT edu_plan_pkey PRIMARY KEY (edu_plan_no);


--
-- TOC entry 3277 (class 2606 OID 25565)
-- Name: edu_program edu_program_pkey; Type: CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.edu_program
    ADD CONSTRAINT edu_program_pkey PRIMARY KEY (edu_program_no);


--
-- TOC entry 3217 (class 2606 OID 25667)
-- Name: schedule end time; Type: CHECK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE structure.schedule
    ADD CONSTRAINT "end time" CHECK ((end_time = (begin_time + '01:30:00'::interval))) NOT VALID;


--
-- TOC entry 3226 (class 2606 OID 25404)
-- Name: student enroll; Type: CHECK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE structure.student
    ADD CONSTRAINT enroll CHECK ((enroll_year >= 1900)) NOT VALID;


--
-- TOC entry 3255 (class 2606 OID 49983)
-- Name: group gr no; Type: CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure."group"
    ADD CONSTRAINT "gr no" UNIQUE (group_no, date_of_form);


--
-- TOC entry 3257 (class 2606 OID 49990)
-- Name: group group_pkey; Type: CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure."group"
    ADD CONSTRAINT group_pkey PRIMARY KEY (group_no);


--
-- TOC entry 3236 (class 2606 OID 41803)
-- Name: discipline_list id_disc; Type: CHECK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE structure.discipline_list
    ADD CONSTRAINT id_disc CHECK ((id_discipline >= 0)) NOT VALID;


--
-- TOC entry 3224 (class 2606 OID 50003)
-- Name: student_status idst; Type: CHECK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE structure.student_status
    ADD CONSTRAINT idst CHECK ((id_status > 0)) NOT VALID;


--
-- TOC entry 3263 (class 2606 OID 17473)
-- Name: student isu; Type: CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.student
    ADD CONSTRAINT isu PRIMARY KEY (student_isu_no);


--
-- TOC entry 3233 (class 2606 OID 41807)
-- Name: direction lang; Type: CHECK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE structure.direction
    ADD CONSTRAINT lang CHECK (((language)::text = ANY ((ARRAY['english'::character varying, 'russian'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 3218 (class 2606 OID 33658)
-- Name: schedule lesson no; Type: CHECK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE structure.schedule
    ADD CONSTRAINT "lesson no" CHECK ((lesson_no >= 1)) NOT VALID;


--
-- TOC entry 3234 (class 2606 OID 41808)
-- Name: direction level; Type: CHECK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE structure.direction
    ADD CONSTRAINT level CHECK (((level)::text = ANY ((ARRAY['bachelor'::character varying, 'master'::character varying, 'PhD'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 3265 (class 2606 OID 25408)
-- Name: student phone; Type: CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.student
    ADD CONSTRAINT phone UNIQUE (phone_no);


--
-- TOC entry 3212 (class 2606 OID 17426)
-- Name: tutor phone number; Type: CHECK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE structure.tutor
    ADD CONSTRAINT "phone number" CHECK (((phone)::text ~~ '+7%'::text)) NOT VALID;


--
-- TOC entry 3213 (class 2606 OID 17425)
-- Name: tutor position; Type: CHECK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE structure.tutor
    ADD CONSTRAINT "position" CHECK ((("position")::text = ANY ((ARRAY['mentor'::character varying, 'professor'::character varying, 'assistant'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 3251 (class 2606 OID 33657)
-- Name: schedule schedule_pkey; Type: CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (lesson_no);


--
-- TOC entry 3220 (class 2606 OID 33649)
-- Name: schedule sem; Type: CHECK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE structure.schedule
    ADD CONSTRAINT sem CHECK (((season)::text = ANY ((ARRAY['autumn'::character varying, 'fall'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 3267 (class 2606 OID 17542)
-- Name: student st isu; Type: CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.student
    ADD CONSTRAINT "st isu" UNIQUE (student_isu_no);


--
-- TOC entry 3261 (class 2606 OID 41811)
-- Name: student_status student_status_pkey; Type: CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.student_status
    ADD CONSTRAINT student_status_pkey PRIMARY KEY (id_status);


--
-- TOC entry 3214 (class 2606 OID 17477)
-- Name: tutor tutor isu; Type: CHECK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE structure.tutor
    ADD CONSTRAINT "tutor isu" CHECK (((tutor_isu_no >= 100000) AND (tutor_isu_no <= 300000))) NOT VALID;


--
-- TOC entry 3247 (class 2606 OID 17424)
-- Name: tutor tutor_isu_no; Type: CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.tutor
    ADD CONSTRAINT tutor_isu_no UNIQUE (tutor_isu_no);


--
-- TOC entry 3249 (class 2606 OID 17414)
-- Name: tutor tutor_pkey; Type: CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.tutor
    ADD CONSTRAINT tutor_pkey PRIMARY KEY (tutor_isu_no);


--
-- TOC entry 3209 (class 2606 OID 50006)
-- Name: auditory type aud; Type: CHECK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE structure.auditory
    ADD CONSTRAINT "type aud" CHECK (((auditory_type)::text = ANY ((ARRAY['lecture'::character varying, 'laboratory'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 3253 (class 2606 OID 50005)
-- Name: schedule un lesson; Type: CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.schedule
    ADD CONSTRAINT "un lesson" UNIQUE (auditory_no, year, season, week_no, begin_time, fixed_day);


--
-- TOC entry 3210 (class 2606 OID 17324)
-- Name: auditory value of seats ; Type: CHECK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE structure.auditory
    ADD CONSTRAINT "value of seats " CHECK (((value_of_seats > 0) AND (value_of_seats < 200))) NOT VALID;


--
-- TOC entry 3283 (class 2606 OID 41806)
-- Name: discipline_list wfe; Type: CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.discipline_list
    ADD CONSTRAINT wfe UNIQUE (edu_plan_no, discipline_code, semester);


--
-- TOC entry 3289 (class 2606 OID 25399)
-- Name: group admin isu; Type: FK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure."group"
    ADD CONSTRAINT "admin isu" FOREIGN KEY (admin_isu) REFERENCES structure.student(student_isu_no) NOT VALID;


--
-- TOC entry 3285 (class 2606 OID 17590)
-- Name: schedule audtr; Type: FK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.schedule
    ADD CONSTRAINT audtr FOREIGN KEY (auditory_no) REFERENCES structure.auditory(auditory_no) NOT VALID;


--
-- TOC entry 3284 (class 2606 OID 17308)
-- Name: auditory building_no; Type: FK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.auditory
    ADD CONSTRAINT building_no FOREIGN KEY (building_no) REFERENCES structure.building(building_no) NOT VALID;


--
-- TOC entry 3295 (class 2606 OID 25577)
-- Name: edu_program dir; Type: FK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.edu_program
    ADD CONSTRAINT dir FOREIGN KEY (direction_code) REFERENCES structure.direction(direction_code) NOT VALID;


--
-- TOC entry 3296 (class 2606 OID 33602)
-- Name: discipline_list disc code; Type: FK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.discipline_list
    ADD CONSTRAINT "disc code" FOREIGN KEY (discipline_code) REFERENCES structure.discipline(discipline_code);


--
-- TOC entry 3291 (class 2606 OID 33614)
-- Name: group discip code; Type: FK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure."group"
    ADD CONSTRAINT "discip code" FOREIGN KEY (discipline_code) REFERENCES structure.discipline(discipline_code) NOT VALID;


--
-- TOC entry 3287 (class 2606 OID 33637)
-- Name: schedule dscp; Type: FK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.schedule
    ADD CONSTRAINT dscp FOREIGN KEY (discipline_code) REFERENCES structure.discipline(discipline_code) NOT VALID;


--
-- TOC entry 3297 (class 2606 OID 33607)
-- Name: discipline_list edu plan no; Type: FK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.discipline_list
    ADD CONSTRAINT "edu plan no" FOREIGN KEY (edu_plan_no) REFERENCES structure.edu_plan(edu_plan_no);


--
-- TOC entry 3294 (class 2606 OID 25566)
-- Name: edu_plan edu pr code; Type: FK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.edu_plan
    ADD CONSTRAINT "edu pr code" FOREIGN KEY (edu_program_no) REFERENCES structure.edu_program(edu_program_no) NOT VALID;


--
-- TOC entry 3288 (class 2606 OID 49998)
-- Name: schedule l;; Type: FK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.schedule
    ADD CONSTRAINT "l;" FOREIGN KEY (group_no) REFERENCES structure."group"(group_no) NOT VALID;


--
-- TOC entry 3293 (class 2606 OID 49993)
-- Name: student_status lkm; Type: FK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.student_status
    ADD CONSTRAINT lkm FOREIGN KEY (group_no) REFERENCES structure."group"(group_no) NOT VALID;


--
-- TOC entry 3290 (class 2606 OID 25614)
-- Name: group plan no; Type: FK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure."group"
    ADD CONSTRAINT "plan no" FOREIGN KEY (edu_plan_no) REFERENCES structure.edu_plan(edu_plan_no) NOT VALID;


--
-- TOC entry 3292 (class 2606 OID 17543)
-- Name: student_status st_isu; Type: FK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.student_status
    ADD CONSTRAINT st_isu FOREIGN KEY (student_isu_no) REFERENCES structure.student(student_isu_no) NOT VALID;


--
-- TOC entry 3286 (class 2606 OID 17595)
-- Name: schedule ttr; Type: FK CONSTRAINT; Schema: structure; Owner: postgres
--

ALTER TABLE ONLY structure.schedule
    ADD CONSTRAINT ttr FOREIGN KEY (tutor_isu_no) REFERENCES structure.tutor(tutor_isu_no) NOT VALID;


-- Completed on 2023-03-16 18:32:12

--
-- PostgreSQL database dump complete
--

