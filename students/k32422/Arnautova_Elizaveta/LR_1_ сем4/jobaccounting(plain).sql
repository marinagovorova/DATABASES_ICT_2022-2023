--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7
-- Dumped by pg_dump version 14.7

-- Started on 2023-03-18 23:14:07 MSK

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

DROP DATABASE "Job Accounting";
--
-- TOC entry 3682 (class 1262 OID 16394)
-- Name: Job Accounting; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "Job Accounting" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C';


ALTER DATABASE "Job Accounting" OWNER TO postgres;

\connect -reuse-previous=on "dbname='Job Accounting'"

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
-- TOC entry 209 (class 1259 OID 16400)
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id_client integer NOT NULL,
    client_name character varying(128) NOT NULL,
    client_address character varying(128),
    "Contact_person" character varying(128) NOT NULL,
    "Contact" character varying(128) NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16606)
-- Name: client_id_client_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.client ALTER COLUMN id_client ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.client_id_client_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 211 (class 1259 OID 16425)
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    id_department integer NOT NULL,
    department_name character varying(128) NOT NULL,
    department_phone character varying(12) NOT NULL
);


ALTER TABLE public.department OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16613)
-- Name: department_id_department_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.department ALTER COLUMN id_department ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.department_id_department_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 212 (class 1259 OID 16435)
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    id_employee integer NOT NULL,
    id_job_title integer NOT NULL,
    id_department integer NOT NULL,
    id_schedule integer NOT NULL,
    name character varying(32) NOT NULL,
    surname character varying(32) NOT NULL,
    patronymic character varying(32),
    phone_number character varying(12) NOT NULL,
    salary integer NOT NULL
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16611)
-- Name: employee_id_employee_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.employee ALTER COLUMN id_employee ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.employee_id_employee_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 217 (class 1259 OID 16565)
-- Name: execution_control; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.execution_control (
    id_execution integer NOT NULL,
    id_schedule integer NOT NULL,
    id_supervisor integer NOT NULL,
    control_date date,
    comment text,
    task_status character varying(15) NOT NULL
);


ALTER TABLE public.execution_control OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16638)
-- Name: execution_control_id_execution_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.execution_control ALTER COLUMN id_execution ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.execution_control_id_execution_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 210 (class 1259 OID 16420)
-- Name: job_title; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_title (
    id_job_title integer NOT NULL,
    id_department integer NOT NULL,
    job_title character varying(128) NOT NULL,
    salary integer NOT NULL
);


ALTER TABLE public.job_title OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16614)
-- Name: job_title_id_job_title_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.job_title ALTER COLUMN id_job_title ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.job_title_id_job_title_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 214 (class 1259 OID 16528)
-- Name: project; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project (
    id_client integer NOT NULL,
    id_manager integer NOT NULL,
    id_supervisor integer NOT NULL,
    project_status character varying(15) NOT NULL,
    project_name character varying(128) NOT NULL,
    project_deadlines date NOT NULL,
    price integer NOT NULL,
    payment_state character varying(20) NOT NULL,
    signing_contract_date date NOT NULL,
    signing_act_date date,
    id_project integer NOT NULL
);


ALTER TABLE public.project OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16635)
-- Name: project_id_project_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.project ALTER COLUMN id_project ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.project_id_project_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 213 (class 1259 OID 16450)
-- Name: schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedule (
    id_schedule integer NOT NULL,
    id_employee integer NOT NULL,
    id_job_title integer NOT NULL,
    id_department integer NOT NULL,
    wage_rate character varying(15) NOT NULL
);


ALTER TABLE public.schedule OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16617)
-- Name: schedule_id_schedule_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.schedule ALTER COLUMN id_schedule ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.schedule_id_schedule_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 215 (class 1259 OID 16548)
-- Name: task; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task (
    id_task integer NOT NULL,
    id_project integer NOT NULL,
    task_price integer NOT NULL,
    task_deadline date NOT NULL,
    task_start_date date NOT NULL
);


ALTER TABLE public.task OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16637)
-- Name: task_id_task_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.task ALTER COLUMN id_task ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.task_id_task_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 216 (class 1259 OID 16560)
-- Name: task_steps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_steps (
    id_contract integer NOT NULL,
    id_project integer NOT NULL,
    id_schedule integer NOT NULL,
    step_price integer NOT NULL,
    step_start_date date NOT NULL,
    step_deadline date NOT NULL,
    step_status character varying(15) NOT NULL
);


ALTER TABLE public.task_steps OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16639)
-- Name: task_steps_id_contract_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.task_steps ALTER COLUMN id_contract ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.task_steps_id_contract_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3659 (class 0 OID 16400)
-- Dependencies: 209
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (1, 'приятный версия', '4949 Lost Quay', 'Костин Всеволод Павлович', '+168707374672');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (2, 'оранжевый миг', '944 Umber Embers Manor', 'Васильева Елена Артёмовна', '+498127608980');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (3, 'сегодняшний расстояние', '', 'Губанова Ева Арсентьевна', '+57297620271');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (4, 'влюбленный жертва', '4571 Lazy Extension', 'Мещеряков Фёдор Викторович', '+2398286654');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (5, 'электрический клетка', '319 Sunny Gardens', 'Павлова Елизавета Владимировна', '+145243646158');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (6, 'интеллектуальный расчет', '6822 Cotton Landing', 'Гаврилов Василий Фёдорович', '+289735241385');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (7, 'автоматический край', '', 'Чернышев Иван Савельевич', '+641763929565');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (8, 'убежденный структура', '5506 Emerald Abbey', 'Смирнова Полина Никитична', '+19533029590');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (9, 'добровольный достоинство', '5960 High Acres', 'Измайлова Анна Давидовна', '+580381735363');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (10, 'данный кризис', '7261 Dusty Horse Abbey', 'Карпова Дарья Матвеевна', '+432459589012');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (11, 'некоторые церковь', '2689 Green View Manor', 'Селиванов Матвей Сергеевич', '+97078565469');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (12, 'запасной кухня', '3190 Amber Pointe', 'Селиванов Матвей Сергеевич', '+76180974782');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (13, 'раненый эксплуатация', '', 'Коновалов Артём Александрович', '+560695417397');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (14, 'вчерашний дума', '6103 Sunny Brook Byway', 'Горелов Савва Викторович', '+306147371775');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (15, 'временной создание', '8601 Misty Treasure Estates', 'Климова Александра Егоровна', '+814567930472');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (16, 'твердый президент', '3190 Amber Pointe', 'Данилов Тимур Тимурович', '+623244258584');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (17, 'откровенный прием', '3578 Rocky Meadow', 'Субботина Алиса Владимировна', '+280735075685');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (18, 'социальный население', '9386 Bright Hill', 'Королев Михаил Тимофеевич', '+15225666019');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (19, 'дальний расстояние', '', 'Иванов Иван Тимофеевич', '+576404373366');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (20, 'подводной дурак', '2876 Lazy Beacon Vale', 'Субботина Алиса Владимировна', '+812323358045');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (21, 'непосредственный правило', '1405 Velvet Lagoon Dell', 'Степанова Алина Александровна', '+492153133351');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (22, 'народный уход', '4724 Lost Cape', 'Гаврилова Анна Романовна', '+639657542957');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (23, 'производственный кость', '', 'Соколов Даниил Григорьевич', '+870280153653');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (24, 'зимний выход', '6303 Shady Corners', 'Федорова Вероника Марковна', '+236425898108');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (25, 'светский кольцо', '', 'Сидорова София Ярославовна', '+283376302294');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (26, 'густой программа', '3578 Rocky Meadow', 'Данилов Тимур Тимурович', '+422426935172');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (27, 'голодный женщина', '4665 Emerald Promenade', 'Гусева Дарья Марковна', '+708388659510');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (28, 'равный подход', '7979 Green Nectar Range', 'Спиридонова Юлия Глебовна', '+177765148428');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (29, 'короткий статус', '459 Round Leaf Townline', 'Хохлов Михаил Никитич', '+352692931282');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (30, 'кредитный кусок', '3666 Shady Vista', 'Яковлева Дарья Денисовна', '+539358775308');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (31, 'космический проблема', '6211 Heather Jetty', 'Попов Андрей Русланович', '+191298730775');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (32, 'молодежный брак', '', 'Васильев Егор Олегович', '+94598545685');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (33, 'максимальный водитель', '5515 Amber Mountain Village', 'Хромова Вероника Сергеевна', '+68194348207');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (34, 'несчастный отличие', '', 'Назарова Варвара Петровна', '+850724695670');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (35, 'производственный председатель', '3666 Shady Vista', 'Аксенов Александр Антонович', '+785586880282');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (36, 'основной особенность', '', 'Маслова Валерия Валерьевна', '+721776485859');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (37, 'многие документ', '7238 Golden Zephyr Stead', 'Соколов Константин Лукич', '+907034311789');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (38, 'газовый желание', '3190 Amber Pointe', 'Иванова Амина Никитична', '+987402561152');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (39, 'израильский суд', '5960 High Acres', 'Лебедева Алиса Ильинична', '+147290176741');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (40, 'возможный спина', '319 Sunny Gardens', 'Кузнецов Роман Сергеевич', '+799147076844');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (41, 'газовый сентябрь', '', 'Плотникова Алина Максимовна', '+869671990332');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (42, 'очередной июль', '4744 Old Cove', 'Бирюков Фёдор Егорович', '+102878529849');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (43, 'двойной выпуск', '6374 Broad Bend', 'Панков Михаил Александрович', '+907208468022');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (44, 'подводной условие', '2064 Little By-pass', 'Балашов Владимир Алексеевич', '+431744293387');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (45, 'тогдашний глаз', '604 Honey Terrace', 'Горелов Савва Викторович', '+111836226294');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (46, 'атомный поэзия', '3190 Amber Pointe', 'Суворова Софья Григорьевна', '+689837983163');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (47, 'заинтересованный бой', '1964 Merry Fawn Bend', 'Чижова Виктория Олеговна', '+2112430217');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (48, 'магнитный житель', '3666 Shady Vista', 'Волкова Дарина Дмитриевна', '+331714551033');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (49, 'местный тетя', '', 'Павлов Давид Андреевич', '+416230110833');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (50, 'очевидный дверь', '2363 Velvet Timber Nook', 'Скворцова Мария Кирилловна', '+574005140610');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (51, 'достойный танк', '4843 Easy Blossom Orchard', 'Макарова София Тимуровна', '+394372107563');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (52, 'ужасный статья', '4420 Clear Sky Promenade', 'Зуев Андрей Михайлович', '+778395598178');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (53, 'мировой церковь', '4431 Old Trace', 'Никифоров Максим Ярославович', '+170321845171');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (54, 'саратовский колено', '459 Round Leaf Townline', 'Пугачев Семён Георгиевич', '+672385382323');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (55, 'правый сигнал', '280 Round Alley', 'Дмитриева Мария Данииловна', '+539245050897');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (56, 'философский жертва', '7043 Old Deer Downs', 'Дроздов Тихон Максимович', '+448361279709');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (57, 'половый библиотека', '2324 Cinder Prairie Port', 'Павлова Ксения Артёмовна', '+276721870615');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (58, 'понятный плата', '', 'Панова Анастасия Марковна', '+300705529902');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (59, 'ледяной улица', '3119 Sleepy Hills Promenade', 'Павлов Эмин Фёдорович', '+664137840308');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (60, 'пыльный итог', '9565 Pleasant Wynd', 'Васильев Тимур Артёмович', '+906394724565');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (61, 'таможенный граница', '', 'Иванова Амина Никитична', '+107311436477');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (62, 'налоговый сочинение', '4802 Jagged Pines', 'Захарова Полина Георгиевна', '+289315047407');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (63, 'бешеный пример', '1311 Crystal Wagon Quay', 'Гаврилов Александр Владиславович', '+364225220631');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (64, 'длинный половина', '4628 Lazy Highway', 'Калинин Павел Викторович', '+767750527949');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (65, 'свежий коридор', '', 'Балашов Владимир Алексеевич', '+279353999720');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (66, 'педагогический январь', '4431 Old Trace', 'Маслова Валерия Валерьевна', '+778349620955');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (67, 'вечерний очередь', '', 'Ершова София Мироновна', '+954273556988');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (68, 'несчастный развитие', '', 'Климов Денис Матвеевич', '+13269503935');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (69, 'удивительный раз', '1311 Crystal Wagon Quay', 'Русаков Дмитрий Саввич', '+528792532211');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (70, 'прогрессивный анализ', '', 'Игнатов Владимир Тимофеевич', '+609973096928');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (71, 'либеральный ребенок', '9991 Sunny Round', 'Николаев Фёдор Васильевич', '+359079637380');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (72, 'экологический рубль', '459 Round Leaf Townline', 'Успенская Виктория Львовна', '+925027666362');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (73, 'предыдущий услуга', '9565 Pleasant Wynd', 'Хохлов Михаил Никитич', '+565763027938');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (74, 'актуальный статья', '331 Thunder Turnabout', 'Назарова Варвара Петровна', '+593632862168');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (75, 'природный развитие', '8768 Broad Arbor', 'Титова Диана Богдановна', '+342065461473');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (76, 'ориентированный вечер', '9946 Hidden Trace', 'Котов Макар Лукич', '+177801309570');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (77, 'отдаленный период', '4068 Foggy Bear Circle', 'Субботина Алиса Владимировна', '+226950820964');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (78, 'глухой режим', '', 'Попова Мария Тимуровна', '+726636395383');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (79, 'данный рост', '1172 Cinder Anchor Port', 'Зуев Андрей Михайлович', '+388220846388');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (80, 'рыбный читатель', '1927 Stony Acres', 'Гаврилов Александр Владиславович', '+744299629537');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (81, 'исполнительный ответственность', '6610 Foggy Close', 'Морозов Глеб Давидович', '+291104885584');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (82, 'славянский количество', '9218 High Vale', 'Бирюкова Полина Тимофеевна', '+390715626316');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (83, 'олимпийский сочинение', '836 Red River End', 'Уткин Константин Артёмович', '+639585350968');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (84, 'ударный рассмотрение', '7208 Misty Pond Farm', 'Морозова Дарья Максимовна', '+124888556214');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (85, 'германский пора', '4827 High Embers Line', 'Игнатов Леонид Арсентьевич', '+513855391187');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (86, 'интересный наличие', '5479 Bright Hill', 'Гончаров Илья Савельевич', '+847681851630');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (87, 'многочисленный общение', '6939 Lost Lake Wood', 'Мельникова Кристина Дамировна', '+629968973740');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (88, 'лишенный рынок', '', 'Павлов Артемий Даниилович', '+448443188241');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (89, 'добровольный режим', '5993 Noble Loop', 'Соколов Даниил Григорьевич', '+819531246584');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (90, 'случайный слой', '4571 Lazy Extension', 'Соколов Даниил Григорьевич', '+223455812376');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (91, 'жирный округ', '', 'Кондрашов Константин Дамирович', '+284910744479');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (92, 'технологический значение', '', 'Киреева Ника Андреевна', '+358140460207');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (93, 'совместный сюжет', '437 Easy Blossom Front', 'Шапошников Марк Даниилович', '+649487323955');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (94, 'двойной должность', '3378 Fallen Pioneer Ledge', 'Ларин Даниил Романович', '+245173407285');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (95, 'влажный оружие', '', 'Афанасьева Ксения Ярославовна', '+274155507999');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (96, 'символический пакет', '1941 Tawny Corner', 'Никольский Артём Артемьевич', '+718247189884');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (97, 'кожаный лидер', '280 Round Alley', 'Макаров Александр Валерьевич', '+915945026268');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (98, 'присущий сила', '', 'Зайцев Макар Ярославович', '+774545614788');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (99, 'транспортный количество', '3846 Foggy Harbour', 'Денисов Марк Григорьевич', '+678398801647');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (100, 'довольный мальчик', '', 'Касаткин Максим Иванович', '+734878153539');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (101, 'редкий правда', '9422 Grand Bear Island', 'Алексеев Дмитрий Макарович', '+444950948090');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (102, 'повседневный тип', '5131 Merry Deer Inlet', 'Савельев Александр Дмитриевич', '+121680798305');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (103, 'низкий развитие', '6822 Cotton Landing', 'Бычкова Вера Алексеевна', '+27819129183');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (104, 'мясной право', '', 'Масленников Максим Русланович', '+649598625572');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (105, 'ужасный кусок', '1995 Cinder Way', 'Попова Василина Романовна', '+751780762773');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (106, 'населенный ошибка', '2612 Broad Barn Chase', 'Беляков Иван Алексеевич', '+672118510504');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (107, 'московский лошадь', '', 'Смирнов Лев Михайлович', '+598376976521');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (108, 'личный урок', '4467 Cozy Expressway', 'Ершова София Александровна', '+629180613822');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (109, 'эстетический февраль', '6802 Colonial Bluff End', 'Нечаева Александра Семёновна', '+376134583323');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (110, 'добрый приказ', '3119 Sleepy Hills Promenade', 'Спиридонова Юлия Глебовна', '+599226651339');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (111, 'огненный применение', '1947 Burning Creek Field', 'Соколова Полина Львовна', '+685540658635');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (112, 'полноценный государство', '', 'Кузнецов Герман Ибрагимович', '+692061217230');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (113, 'пространственный деревня', '', 'Яковлева Дарья Денисовна', '+484167714293');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (114, 'уличный автор', '5821 Misty By-pass', 'Федорова Каролина Игоревна', '+948409526296');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (115, 'голодный фильм', '3905 Fallen Fox Pathway', 'Мельников Елисей Русланович', '+174647286658');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (116, 'просторный служба', '1745 Tawny Hickory Stead', 'Дроздов Тихон Максимович', '+391080812863');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (117, 'глупый банк', '', 'Новикова Василина Михайловна', '+171968804278');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (118, 'рыбный колено', '944 Umber Embers Manor', 'Маркова Яна Михайловна', '+759157568129');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (119, 'духовный кожа', '', 'Александров Егор Тимофеевич', '+805547618995');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (120, 'современный брак', '8601 Misty Treasure Estates', 'Степанова Аделина Артёмовна', '+447328526014');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (121, 'изящный общение', '5515 Amber Mountain Village', 'Шаповалов Александр Ильич', '+854900500300');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (122, 'материальный соглашение', '8506 Silent Deer Mount', 'Федоров Александр Ростиславович', '+339305490393');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (123, 'символический окончание', '8441 Dewy Corners', 'Емельянов Всеволод Кириллович', '+901070195703');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (124, 'стандартный разница', '3190 Sleepy Port', 'Глушков Макар Кириллович', '+87441889339');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (125, 'рыбный чувство', '3345 Emerald River Crossing', 'Тарасова Валерия Глебовна', '+124923136646');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (126, 'московский войско', '1941 Tawny Corner', 'Григорьев Даниил Марсельевич', '+824459195795');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (127, 'должностной сеть', '646 Wishing Shadow Valley', 'Афанасьева София Владиславовна', '+381957024184');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (128, 'ядерный мнение', '5245 Clear Bear Mall', 'Титова Диана Богдановна', '+473775800280');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (129, 'электрический дым', '', 'Иванова Полина Данииловна', '+293945238357');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (130, 'революционный необходимость', '1405 Velvet Lagoon Dell', 'Панков Михаил Александрович', '+935926676237');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (131, 'виртуальный исполнение', '5166 Heather Cider Impasse', 'Маслова Валерия Валерьевна', '+445879292711');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (132, 'плохой партия', '8939 Middle Cloud Centre', 'Климов Денис Матвеевич', '+318760718941');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (133, 'тревожный статус', '6018 Jagged Horse Orchard', 'Журавлева Марьям Дмитриевна', '+526665857176');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (134, 'лишенный море', '8438 Little Fox Run', 'Федорова Вероника Марковна', '+644202085318');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (135, 'незначительный житель', '', 'Власов Демид Дамирович', '+870591149755');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (136, 'опасный пакет', '', 'Гончаров Тимофей Матвеевич', '+386865373716');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (137, 'ракетный губа', '1971 Easy Freeway', 'Власова Анна Демидовна', '+524698731701');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (138, 'типичный жена', '', 'Михайлова Алиса Тимофеевна', '+999492756983');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (139, 'знакомый время', '8506 Silent Deer Mount', 'Чистяков Марк Иванович', '+667645320248');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (140, 'стандартный портрет', '917 Umber Berry Parade', 'Лаптев Фёдор Дмитриевич', '+340537772150');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (141, 'незначительный пакет', '2080 Middle Wynd', 'Захарова Полина Георгиевна', '+600263773183');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (142, 'бюджетный фотография', '3846 Foggy Harbour', 'Васильева Яна Макаровна', '+810083218450');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (143, 'гуманитарный редактор', '1262 Indian Villas', 'Зверев Семён Платонович', '+977595504719');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (144, 'теплый голова', '1311 Crystal Wagon Quay', 'Борисова Александра Максимовна', '+14134924389');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (145, 'электрический борьба', '4744 Old Cove', 'Мельникова Кристина Дамировна', '+548082316445');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (146, 'входной состав', '7098 Silver Trace', 'Ларин Даниил Романович', '+550182338295');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (147, 'специфический продукт', '', 'Романова Дарья Даниловна', '+3993190953');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (148, 'погибший страсть', '6610 Foggy Close', 'Васильев Егор Олегович', '+615479374845');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (149, 'стройный самолет', '5821 Misty By-pass', 'Макарова София Тимуровна', '+548328743468');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (150, 'идеологический мир', '5396 Silent Place', 'Васильев Егор Олегович', '+559463181685');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (151, 'невероятный читатель', '4817 Quiet Cloud Crescent', 'Рогов Михаил Фёдорович', '+674222984919');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (152, 'кривой итог', '', 'Гончаров Тимофей Матвеевич', '+78092531473');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (153, 'бешеный роль', '8441 Dewy Corners', 'Афанасьева Ксения Ярославовна', '+816069510158');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (154, 'кредитный общение', '7576 Grand Panda Court', 'Глушков Макар Кириллович', '+313485591794');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (155, 'безумный врач', '5130 Lost Glen', 'Дегтярев Егор Платонович', '+189970760596');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (156, 'горный разница', '4849 Silver Orchard', 'Кузьмина Анна Артёмовна', '+881060641278');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (157, 'логический тип', '5875 Crystal Quail Cape', 'Макарова Виктория Григорьевна', '+917471774685');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (158, 'особенный пример', '6749 Amber Beach', 'Зайцев Фёдор Егорович', '+749473917544');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (159, 'плохой редактор', '6802 Colonial Bluff End', 'Воробьев Даниил Арсентьевич', '+686902745273');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (160, 'предельный кулак', '604 Honey Terrace', 'Артемова Валерия Ивановна', '+861014981420');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (161, 'стройный замок', '7576 Grand Panda Court', 'Иванова Кира Давидовна', '+422872754824');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (162, 'своеобразный разработка', '7469 Burning Hills Glade', 'Никонова София Матвеевна', '+121863252864');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (163, 'акционерный партия', '3060 Quiet Willow Dale', 'Родионов Тимофей Дмитриевич', '+775287619319');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (164, 'символический брат', '4998 Fallen Zephyr Farm', 'Борисов Константин Семёнович', '+235233589177');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (165, 'пьяный название', '3905 Fallen Fox Pathway', 'Григорьева Анастасия Романовна', '+499952058925');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (166, 'вечерний зеркало', '8911 Middle Fox Campus', 'Прохоров Андрей Григорьевич', '+612926436575');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (167, 'синий теория', '8723 Thunder Log Meadow', 'Шаповалова Вероника Николаевна', '+578413343545');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (168, 'пьяный представитель', '1819 Colonial Anchor Park', 'Ефремов Владимир Дмитриевич', '+159572298869');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (169, 'массовый фильм', '9619 Cozy Autumn Range', 'Горохов Егор Иванович', '+327239276258');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (170, 'генетический взрыв', '2689 Green View Manor', 'Касаткин Максим Иванович', '+646811258911');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (171, 'банальный источник', '8283 Rocky Heath', 'Михайлова Алиса Тимофеевна', '+270835474309');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (172, 'загадочный подарок', '', 'Золотарев Иван Даниилович', '+773577140456');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (173, 'энергетический кухня', '8796 Little View Thicket', 'Смирнова Елизавета Алиевна', '+653541850389');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (174, 'правильный реализация', '', 'Березина Вероника Тихоновна', '+47700665517');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (175, 'любовный глава', '8438 Little Fox Run', 'Шилов Егор Павлович', '+588064238126');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (176, 'нелепый бог', '4467 Cozy Expressway', 'Новикова Василина Михайловна', '+627829203259');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (177, 'октябрьский действительность', '4136 Harvest Field', 'Завьялов Даниил Львович', '+94161324496');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (178, 'ленинский банк', '2999 Noble Sky Common', 'Никифоров Макар Захарович', '+195740007227');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (179, 'квадратный сведение', '', 'Жуков Алексей Дмитриевич', '+782362710337');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (180, 'благородный бок', '', 'Королев Михаил Тимофеевич', '+214857109401');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (181, 'криминальный танк', '4420 Clear Sky Promenade', 'Копылов Даниил Иванович', '+947951761248');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (182, 'террористический главное', '', 'Спиридонов Лев Маркович', '+696790221717');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (183, 'крайний постель', '5023 Red Rise Autoroute', 'Комарова Дарья Артёмовна', '+526432668338');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (184, 'минеральный должность', '', 'Гончаров Тимофей Никитич', '+484677384962');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (185, 'благодарный вариант', '6103 Sunny Brook Byway', 'Титова Диана Богдановна', '+992315229276');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (186, 'должностной норма', '8911 Middle Fox Campus', 'Кошелев Артём Артёмович', '+842247312695');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (187, 'транспортный добро', '', 'Никитин Михаил Артёмович', '+586285945200');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (188, 'специфический подход', '', 'Власова Стефания Алексеевна', '+347892456944');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (189, 'строительный проблема', '5023 Red Rise Autoroute', 'Поляков Артём Львович', '+942741661353');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (190, 'правильный жертва', '7238 Golden Zephyr Stead', 'Минаев Савелий Ярославович', '+989171520168');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (191, 'бешеный весна', '3378 Fallen Pioneer Ledge', 'Маслова Валерия Валерьевна', '+287594059453');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (192, 'рыбный ребята', '5479 Bright Hill', 'Павлов Али Иванович', '+993776604202');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (193, 'синий рубль', '4628 Lazy Highway', 'Степанов Иван Денисович', '+390729711521');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (194, 'часовой просьба', '5208 High Hickory Farms', 'Васильев Егор Олегович', '+341994753637');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (195, 'ядерный сюжет', '9003 Quaking Barn Parade', 'Кочергин Руслан Богданович', '+986229846085');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (196, 'неподвижный состав', '9867 Gentle Rabbit Valley', 'Карасев Тимур Ярославович', '+416715964691');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (197, 'поразительный мужчина', '5526 Hazy Beacon Gardens', 'Смирнова Мария Павловна', '+148203049022');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (198, 'нехороший опыт', '', 'Маркова Софья Тимуровна', '+859129843611');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (199, 'теплый дача', '', 'Воробьев Всеволод Романович', '+187466272437');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (200, 'методический чиновник', '1300 Green Pony Inlet', 'Котова Алина Степановна', '+842311839853');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (201, 'северный встреча', '', 'Гончарова Полина Дмитриевна', '+650288290106');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (202, 'гладкий конфликт', '3345 Emerald River Crossing', 'Григорьева Анна Данииловна', '+393566225641');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (203, 'вечерний женщина', '4231 Sleepy Willow Highway', 'Петрова Любовь Ивановна', '+405670205643');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (204, 'передовой обеспечение', '6594 Silver Drive', 'Воронин Михаил Антонович', '+759338163399');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (205, 'социалистический плата', '2876 Lazy Beacon Vale', 'Сергеева Вероника Владимировна', '+97018889749');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (206, 'недовольный ответ', '6749 Amber Beach', 'Макарова Валерия Вадимовна', '+43124251949');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (207, 'дурной автомобиль', '', 'Панков Михаил Александрович', '+401600201136');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (208, 'пространственный крик', '229 Hidden Lookout', 'Щукина Евдокия Михайловна', '+937344592561');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (209, 'безопасный сведение', '9868 Hazy Round', 'Белова Агния Никитична', '+1200321242');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (210, 'автономный миллион', '8796 Little View Thicket', 'Смирнов Михаил Фёдорович', '+742890967428');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (211, 'ежегодный капитал', '8796 Little View Thicket', 'Петрова Любовь Ивановна', '+646683684326');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (212, 'социалистический рисунок', '2876 Lazy Beacon Vale', 'Трифонова Маргарита Алексеевна', '+642472275598');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (213, 'руководящий тип', '5515 Amber Mountain Village', 'Федоров Александр Ростиславович', '+129178665072');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (214, 'густой соглашение', '6211 Heather Jetty', 'Березина Вероника Тихоновна', '+735199947106');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (215, 'окружающий название', '5821 Misty By-pass', 'Блинова Юлия Алексеевна', '+197483686235');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (216, 'конституционный вещество', '7248 Thunder Autumn Village', 'Кузнецова Василиса Ильинична', '+95079865649');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (217, 'популярный метр', '', 'Спиридонова Юлия Глебовна', '+412730197005');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (218, 'сомнительный церковь', '2080 Middle Wynd', 'Щербакова Кира Константиновна', '+665437488596');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (219, 'обязанный преступление', '2186 Red Lookout', 'Беляков Иван Алексеевич', '+624664928304');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (220, 'пьяный май', '', 'Гончаров Тимофей Никитич', '+86667006221');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (221, 'жуткий особенность', '7874 Pleasant Hollow', 'Новикова Василина Михайловна', '+950816113917');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (222, 'ранний офицер', '', 'Вешнякова Алиса Савельевна', '+654053260454');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (223, 'бедный столица', '4365 Iron Abbey', 'Емельянов Всеволод Кириллович', '+251618416001');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (224, 'краткий достоинство', '2070 Quaking Centre', 'Митрофанов Александр Денисович', '+196687885546');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (225, 'конституционный точка', '', 'Игнатьева Вероника Артёмовна', '+705015618211');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (226, 'пермский значение', '', 'Костин Всеволод Павлович', '+164769664455');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (227, 'бывший точка', '2724 Cinder Hollow', 'Тарасова Валерия Глебовна', '+213243134197');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (228, 'квадратный водитель', '3329 Cozy Forest', 'Никитина Ева Ивановна', '+83909368788');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (229, 'стройный зарплата', '', 'Никитина Ева Ивановна', '+123377854481');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (230, 'грузинский природа', '', 'Захаров Давид Артёмович', '+509608181996');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (231, 'целый сведение', '8441 Dewy Corners', 'Чижова Виктория Олеговна', '+575242401287');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (232, 'звездный вкус', '5479 Bright Hill', 'Смирнов Михаил Фёдорович', '+601934457380');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (233, 'садовый реакция', '8589 Quiet Turnabout', 'Семенов Леонид Артёмович', '+364303951930');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (234, 'парламентский противник', '3190 Amber Pointe', 'Сергеева Аврора Максимовна', '+361470691071');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (235, 'универсальный половина', '973 Silver Via', 'Спиридонов Демид Елисеевич', '+701514049456');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (236, 'технологический проект', '9565 Pleasant Wynd', 'Петров Марк Георгиевич', '+116031457973');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (237, 'густой повышение', '9059 Pleasant Campus', 'Родионова Николь Евгеньевна', '+646201888280');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (238, 'частый станция', '9422 Grand Bear Island', 'Васильев Егор Олегович', '+166695478862');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (239, 'вечерний тетя', '1311 Crystal Wagon Quay', 'Павлов Роберт Артёмович', '+138712187697');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (240, 'секретный мастер', '1941 Tawny Corner', 'Васильев Марк Ярославович', '+94063393404');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (241, 'оперативный описание', '3666 Shady Vista', 'Сергеева Таисия Владиславовна', '+125512853126');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (242, 'предварительный крик', '8851 Honey Loop', 'Емельянов Всеволод Кириллович', '+572411356637');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (243, 'тогдашний общение', '1995 Cinder Way', 'Алексеев Иван Глебович', '+484427105249');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (244, 'откровенный TRUE', '9003 Quaking Barn Parade', 'Волкова Василиса Павловна', '+392778277922');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (245, 'краткий программа', '6610 Foggy Close', 'Белоусова Полина Егоровна', '+934045038770');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (246, 'заключенный техника', '5020 Dewy Street', 'Беляков Иван Алексеевич', '+791217875867');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (247, 'обыкновенный платье', '8471 Rustic Dale Wharf', 'Трифонова Маргарита Алексеевна', '+269829578213');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (248, 'мрачный краска', '', 'Федоров Александр Ростиславович', '+760751861759');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (249, 'ракетный песня', '', 'Павлова Ксения Артёмовна', '+720410273744');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (250, 'неведомый актер', '5374 Quaking Willow Crest', 'Соколова Полина Андреевна', '+47143324252');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (251, 'жизненный проект', '', 'Пономарева Софья Романовна', '+724140155503');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (252, 'интеллектуальный самолет', '3060 Quiet Willow Dale', 'Смирнова Мария Павловна', '+155889026748');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (253, 'удачный майор', '5350 Harvest Carrefour', 'Александров Егор Тимофеевич', '+717792630214');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (254, 'безопасный раз', '7261 Dusty Horse Abbey', 'Панина Ульяна Михайловна', '+216248829430');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (255, 'пенсионный нос', '8926 Heather Gate', 'Степанов Егор Дмитриевич', '+306313371778');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (256, 'узкий очередь', '3492 Round Island Alley', 'Борисова Вероника Павловна', '+53519518980');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (257, 'женский направление', '1947 Burning Creek Field', 'Калинин Павел Викторович', '+709689457743');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (258, 'автономный сын', '7208 Misty Pond Farm', 'Степанова Алина Александровна', '+484360110564');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (259, 'подозрительный новость', '7043 Old Deer Downs', 'Тихомирова Алиса Вадимовна', '+670785392365');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (260, 'оперативный повышение', '2742 Merry Leaf Beach', 'Гаврилов Василий Фёдорович', '+451449533419');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (261, 'торжественный экран', '9838 Colonial Crossing', 'Морозов Глеб Давидович', '+32876493531');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (262, 'голодный соединение', '4068 Foggy Bear Circle', 'Алексеева Ева Никитична', '+103818995642');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (263, 'жаркий зависимость', '3345 Emerald River Crossing', 'Спиридонова Яна Артёмовна', '+408669076312');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (264, 'божественный занятие', '6303 Shady Corners', 'Вешнякова Алиса Савельевна', '+745532613523');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (265, 'педагогический сестра', '4827 High Embers Line', 'Киселев Станислав Дмитриевич', '+633679359793');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (266, 'многочисленный воздействие', '7728 Jagged Grounds', 'Исаева Екатерина Михайловна', '+907563981912');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (267, 'ежегодный анализ', '7469 Burning Hills Glade', 'Афанасьева Ксения Ярославовна', '+224191585125');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (268, 'всемирный температура', '7864 Stony Trail', 'Морозов Глеб Давидович', '+737813334026');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (269, 'совместный путь', '5479 Bright Hill', 'Щукина Евдокия Михайловна', '+478262351109');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (270, 'краткий переговоры', '9247 Shady Mountain Glen', 'Фомина Милана Артёмовна', '+219164155494');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (271, 'вынужденный тело', '9218 High Vale', 'Дегтярев Егор Платонович', '+941111854677');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (272, 'подземный очередь', '1745 Tawny Hickory Stead', 'Иванова Амина Никитична', '+918672328153');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (273, 'недовольный слой', '331 Thunder Turnabout', 'Потапов Данила Даниилович', '+40122402369');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (274, 'армейский проект', '', 'Шевцова Алиса Алексеевна', '+745703532778');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (275, 'немалый пистолет', '8456 Harvest Pony Line', 'Ефимова Милана Ивановна', '+319526231107');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (276, 'генетический оборона', '4259 Bright Close', 'Козлов Никита Демидович', '+506393029702');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (277, 'конструктивный сутки', '', 'Горбунова Николь Михайловна', '+305027801635');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (278, 'кровавый комитет', '', 'Кузнецов Герман Ибрагимович', '+325360344184');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (279, 'трогательный май', '1520 Umber Grounds', 'Абрамов Елисей Александрович', '+151704634153');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (280, 'взрослый реализация', '8441 Dewy Corners', 'Золотарева Арина Робертовна', '+366900989443');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (281, 'заметный крест', '2363 Velvet Timber Nook', 'Степанов Иван Денисович', '+746135409819');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (282, 'небольшой победа', '6303 Shady Corners', 'Яковлева Дарья Денисовна', '+961655009045');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (283, 'вечерний лидер', '8456 Harvest Pony Line', 'Захарова Таисия Максимовна', '+43282183385');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (284, 'молодежный прием', '4628 Lazy Highway', 'Федоров Данил Платонович', '+53404796417');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (285, 'газовый вкус', '4467 Cozy Expressway', 'Кузнецова Анна Данииловна', '+120879759006');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (286, 'изящный пример', '', 'Ларин Артём Ярославович', '+41114677438');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (287, 'типичный край', '6939 Lost Lake Wood', 'Алексеева Ева Никитична', '+637943349770');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (288, 'достойный плата', '', 'Чернышев Роман Глебович', '+689717129738');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (289, 'дипломатический комитет', '5020 Dewy Street', 'Попов Андрей Русланович', '+397771312547');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (290, 'глупый поддержка', '604 Honey Terrace', 'Морозов Глеб Давидович', '+229293856275');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (291, 'названый начальство', '5166 Heather Cider Impasse', 'Титова Диана Богдановна', '+413231596630');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (292, 'полноценный название', '7728 Jagged Grounds', 'Сычева Василиса Данииловна', '+9100134095');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (293, 'тяжелый отец', '1941 Tawny Corner', 'Казаков Максим Львович', '+632587679054');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (294, 'прошлый понятие', '', 'Дегтярев Адам Антонович', '+415601139461');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (295, 'длинный талант', '3190 Amber Pointe', 'Маслова Валерия Валерьевна', '+563983220936');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (296, 'подходящий крыло', '8589 Quiet Turnabout', 'Макаров Александр Александрович', '+564339479018');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (297, 'преподобный предмет', '6103 Sunny Brook Byway', 'Кузнецова Василиса Ильинична', '+383241473286');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (298, 'таможенный хвост', '5208 High Hickory Farms', 'Измайлова Анна Давидовна', '+894806598007');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (299, 'позитивный развитие', '459 Round Leaf Townline', 'Иванов Иван Тимофеевич', '+46179627403');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (300, 'ранний увеличение', '3755 Rocky Anchor Ledge', 'Новикова Василина Михайловна', '+140539069893');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (301, 'бешеный эксплуатация', '4235 Sunny Leaf Estates', 'Павлов Али Иванович', '+743442177181');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (302, 'грузовой вариант', '944 Umber Embers Manor', 'Захарова Елизавета Максимовна', '+433497234792');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (303, 'многие проект', '9218 High Vale', 'Яковлев Михаил Алексеевич', '+541598083555');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (304, 'непрерывный вид', '9946 Hidden Trace', 'Шилова Ангелина Дмитриевна', '+566614385586');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (305, 'генетический проблема', '6802 Colonial Bluff End', 'Никулина Диана Никитична', '+682068320030');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (306, 'банковский чудо', '6610 Foggy Close', 'Коновалов Артём Александрович', '+328016573355');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (307, 'кремлевский сезон', '7149 Wishing Treasure Range', 'Кузнецов Роман Дмитриевич', '+336299023978');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (308, 'ограниченный земля', '3329 Cozy Forest', 'Алексеев Александр Михайлович', '+184332067926');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (309, 'максимальный порядок', '', 'Игнатов Леонид Арсентьевич', '+392456331735');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (310, 'священный аппарат', '9947 Stony Grove Lane', 'Павлов Артемий Даниилович', '+385858008361');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (311, 'этнический письмо', '6749 Amber Beach', 'Назарова Варвара Петровна', '+731907279891');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (312, 'ближний переход', '', 'Ларин Даниил Романович', '+441946043342');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (313, 'вчерашний письмо', '917 Umber Berry Parade', 'Трофимов Демид Павлович', '+804990765059');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (314, 'олимпийский комитет', '646 Wishing Shadow Valley', 'Романов Кирилл Александрович', '+596955398731');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (315, 'информационный солнце', '1971 Easy Freeway', 'Харитонов Артём Григорьевич', '+911524214649');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (316, 'безопасный капитал', '4365 Iron Abbey', 'Журавлева Марьям Дмитриевна', '+865442792763');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (317, 'вертикальный форма', '2742 Merry Leaf Beach', 'Копылов Даниил Иванович', '+784396469784');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (318, 'божественный пистолет', '', 'Богданова Ольга Юрьевна', '+721022429497');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (319, 'сельскохозяйственный подруга', '', 'Савельева Анастасия Романовна', '+292486069281');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (320, 'мрачный добро', '7149 Wishing Treasure Range', 'Жуков Алексей Дмитриевич', '+303565353103');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (321, 'крайний лидер', '5132 Blue Sky Autoroute', 'Шубин Денис Александрович', '+217235960631');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (322, 'приятный необходимость', '2999 Noble Sky Common', 'Медведева Милана Леоновна', '+855105236232');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (323, 'разнообразный фильм', '6103 Sunny Brook Byway', 'Щукина Евдокия Михайловна', '+629805121078');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (324, 'земельный колесо', '7576 Grand Panda Court', 'Бурова София Степановна', '+489446300693');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (325, 'полноценный банк', '280 Round Alley', 'Литвинова Варвара Мироновна', '+700287659718');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (326, 'одинокий оборона', '8283 Rocky Heath', 'Шульгина Виктория Петровна', '+235017225419');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (327, 'искусственный танк', '5967 Dusty Pike', 'Денисова Анастасия Николаевна', '+262234249238');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (328, 'коммерческий дама', '6303 Shady Corners', 'Воронина Сабрина Святославовна', '+772275772976');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (329, 'офицерский слово', '280 Round Alley', 'Шубин Денис Александрович', '+588356936974');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (330, 'ледяной победа', '8547 Honey Key', 'Абрамова Варвара Захаровна', '+389389669336');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (331, 'иркутский должность', '', 'Чернышева Ангелина Ивановна', '+818780479122');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (332, 'подозрительный изменение', '4365 Iron Abbey', 'Беляев Кирилл Ильич', '+215780221867');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (333, 'пьяный реформа', '6749 Amber Beach', 'Фомина Милана Артёмовна', '+443977786368');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (334, 'опасный пример', '4259 Bright Close', 'Леонова Ариана Ярославовна', '+606427449072');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (335, 'местный сущность', '5396 Silent Place', 'Игнатов Владимир Тимофеевич', '+497458114643');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (336, 'трогательный кадр', '1300 Green Pony Inlet', 'Золотарев Иван Даниилович', '+184522288036');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (337, 'федеральный рука', '', 'Павлова Ксения Артёмовна', '+493937582102');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (338, 'заметный лед', '367 Velvet Oak Towers', 'Никитина Виктория Давидовна', '+767516907011');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (339, 'заинтересованный пример', '', 'Нечаева Александра Семёновна', '+679863966794');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (340, 'практический время', '', 'Никифоров Максим Ярославович', '+203693252076');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (341, 'недовольный защита', '8768 Broad Arbor', 'Никитин Михаил Артёмович', '+108389608401');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (342, 'заинтересованный воздействие', '', 'Горохов Егор Иванович', '+546644064028');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (343, 'незначительный отказ', '4571 Lazy Extension', 'Гончаров Илья Савельевич', '+914365797185');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (344, 'острый лагерь', '2070 Quaking Centre', 'Волкова Дарья Никитична', '+511089260272');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (345, 'статистический полет', '5993 Noble Loop', 'Морозов Александр Андреевич', '+809739010038');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (346, 'инженерный декабрь', '1819 Colonial Anchor Park', 'Никитин Михаил Артёмович', '+514702249053');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (347, 'энергичный норма', '', 'Костин Всеволод Павлович', '+973042056071');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (348, 'слабый хвост', '', 'Савин Егор Артёмович', '+326284038100');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (349, 'исключительный применение', '2724 Cinder Hollow', 'Васильев Марк Ярославович', '+936348954401');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (350, 'долгий рисунок', '', 'Поляков Вячеслав Кириллович', '+830356909100');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (351, 'уважаемый запас', '782 Colonial Island Rise', 'Григорьева Анна Данииловна', '+485764990220');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (352, 'скучный событие', '3190 Sleepy Port', 'Макарова Виктория Александровна', '+741863860074');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (353, 'замечательный степень', '4843 Easy Blossom Orchard', 'Макарова Виктория Александровна', '+671948952510');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (354, 'центральный ребенок', '229 Hidden Lookout', 'Захарова Таисия Максимовна', '+125450490144');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (355, 'мобильный столица', '4431 Old Trace', 'Новикова Ольга Антоновна', '+282692991780');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (356, 'достойный победа', '', 'Яковлев Михаил Алексеевич', '+20928411211');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (357, 'сексуальный отличие', '782 Colonial Island Rise', 'Сергеева Аврора Максимовна', '+895587073399');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (358, 'временной музей', '5245 Clear Bear Mall', 'Родионов Тимофей Дмитриевич', '+864584518354');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (359, 'изящный грудь', '9059 Pleasant Campus', 'Селиванов Матвей Сергеевич', '+880671268466');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (360, 'весенний сравнение', '', 'Фирсов Давид Владимирович', '+626645115129');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (361, 'народный кандидат', '8911 Middle Fox Campus', 'Никитина Ева Ивановна', '+209541044561');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (362, 'смутный постель', '2070 Quaking Centre', 'Воронова Виктория Петровна', '+177013167512');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (363, 'будущий главное', '', 'Никитин Давид Эмирович', '+536694025133');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (364, 'пушкинский пыль', '4259 Bright Close', 'Гончаров Тимофей Никитич', '+123839181267');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (365, 'непривычный желание', '', 'Новикова Ольга Антоновна', '+806698123203');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (366, 'невидимый дверь', '', 'Смирнова Александра Романовна', '+70004739840');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (367, 'далекий пространство', '', 'Авдеев Иван Владиславович', '+990567627181');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (368, 'молодой полковник', '', 'Иванова Дарья Владиславовна', '+661557288186');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (369, 'случайный срок', '459 Round Leaf Townline', 'Маслов Филипп Леонидович', '+981508948716');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (370, 'мясной дым', '', 'Комарова Дарья Артёмовна', '+122665617329');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (371, 'многочисленный лейтенант', '8589 Quiet Turnabout', 'Воробьев Артём Иванович', '+400088276402');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (372, 'базовый испытание', '459 Round Leaf Townline', 'Савельева Анастасия Романовна', '+266426527111');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (373, 'ограниченный центр', '9386 Bright Hill', 'Матвеева Есения Матвеевна', '+602714847972');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (374, 'стратегический вывод', '9619 Cozy Autumn Range', 'Нефедова Виктория Игоревна', '+184196098397');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (375, 'восточный век', '', 'Васильев Михаил Артёмович', '+668193145027');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (376, 'непривычный сюжет', '2363 Velvet Timber Nook', 'Коновалов Тимофей Эрикович', '+675324464036');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (377, 'кривой земля', '4665 Emerald Promenade', 'Смирнова Мария Павловна', '+225191671148');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (378, 'региональный исполнение', '6303 Shady Corners', 'Митрофанов Александр Денисович', '+685355142824');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (379, 'дурацкий забота', '', 'Козлова Елена Артёмовна', '+613779466940');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (380, 'названый бой', '6749 Amber Beach', 'Котов Евгений Максимович', '+101339862294');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (381, 'неизвестный лед', '8911 Easy Creek Drive', 'Шубин Денис Александрович', '+425645617871');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (382, 'молодежный краска', '9003 Quaking Barn Parade', 'Кошелев Артём Артёмович', '+296913001141');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (383, 'элементарный подход', '3060 Quiet Willow Dale', 'Макаров Александр Валерьевич', '+939055688389');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (384, 'священный мир', '', 'Соколов Константин Лукич', '+739491341513');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (385, 'подходящий зритель', '', 'Мельникова Кристина Дамировна', '+444131281345');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (386, 'электрический глубина', '437 Easy Blossom Front', 'Новикова Василина Михайловна', '+142639729346');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (387, 'временной тип', '917 Umber Berry Parade', 'Родионова Николь Евгеньевна', '+793733456534');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (388, 'должный врач', '', 'Никитина Виктория Давидовна', '+860394980244');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (389, 'зимний пора', '229 Hidden Lookout', 'Дроздов Тихон Максимович', '+871817509243');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (390, 'исключительный пиво', '331 Thunder Turnabout', 'Иванова Ксения Фёдоровна', '+270404833181');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (391, 'лекарственный заключение', '9392 Emerald Villas', 'Беспалов Григорий Артёмович', '+74784050151');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (392, 'базовый приказ', '5011 Noble Way', 'Панков Михаил Александрович', '+751625480347');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (393, 'православный возвращение', '3119 Sleepy Hills Promenade', 'Нечаева Александра Семёновна', '+149606155053');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (394, 'тяжелый строй', '2955 Silent Fawn Harbour', 'Федоров Дмитрий Кириллович', '+324444520592');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (395, 'резиновый дурак', '3434 Cotton Road', 'Карпова Арина Лукинична', '+597553974506');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (396, 'статистический тень', '', 'Мешков Иван Эминович', '+964711747538');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (397, 'конституционный редактор', '7605 Crystal Zephyr Falls', 'Денисова Анастасия Николаевна', '+410781524443');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (398, 'энергетический воздействие', '3905 Fallen Fox Pathway', 'Шаповалова Вероника Николаевна', '+90162010633');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (399, 'эмоциональный постановление', '5350 Harvest Carrefour', 'Смирнова Мария Павловна', '+89410301152');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (400, 'присущий занятие', '1028 Indian Treasure Terrace', 'Прохоров Андрей Григорьевич', '+764603694523');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (401, 'верховный лагерь', '973 Silver Via', 'Демина Татьяна Евгеньевна', '+191514528787');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (402, 'здоровый помощь', '8441 Dewy Corners', 'Смирнова Зоя Егоровна', '+787751800706');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (403, 'далекий сочинение', '646 Wishing Shadow Valley', 'Кожевников Никита Александрович', '+7800589490');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (404, 'немецкий месяц', '', 'Савельева Сабина Саввична', '+174365406508');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (405, 'школьный соглашение', '7273 Golden Nectar Farms', 'Королев Михаил Тимофеевич', '+186377264236');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (406, 'медный черт', '6822 Cotton Landing', 'Болдырев Арсений Иванович', '+806604999696');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (407, 'патриотический лед', '', 'Родионов Тимофей Дмитриевич', '+578705692188');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (408, 'офицерский комплекс', '5571 Quiet Chase', 'Игнатов Леонид Арсентьевич', '+763605422291');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (409, 'жалкий жена', '1405 Velvet Lagoon Dell', 'Окулова Дарина Матвеевна', '+376486736106');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (410, 'пыльный теория', '5057 Velvet Heights', 'Котова Алина Степановна', '+262813640201');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (411, 'частный площадка', '6374 Broad Bend', 'Никифоров Максим Ярославович', '+342511853248');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (412, 'актуальный ракета', '5374 Quaking Willow Crest', 'Зуев Фёдор Артёмович', '+272636082654');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (413, 'полный войско', '2999 Noble Sky Common', 'Орлова Любовь Арсентьевна', '+839151862441');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (414, 'традиционный тема', '', 'Кондратьева Мария Дмитриевна', '+909877374962');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (415, 'голодный сочинение', '1658 Red Treasure Village', 'Павлов Давид Андреевич', '+404908636310');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (416, 'удобный фильм', '280 Round Alley', 'Павлов Артемий Даниилович', '+636925498330');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (417, 'дипломатический лидер', '', 'Петров Иван Тимофеевич', '+882826364551');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (418, 'простой возможность', '5396 Silent Place', 'Воронин Михаил Антонович', '+402673098803');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (419, 'преступный президент', '437 Easy Blossom Front', 'Семенов Леонид Артёмович', '+725455255457');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (420, 'искренний сведение', '1964 Merry Fawn Bend', 'Гусев Егор Денисович', '+486899596318');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (421, 'методический природа', '5515 Amber Mountain Village', 'Прокофьева Елизавета Святославовна', '+757087657302');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (422, 'приятный край', '4357 Cotton Bay', 'Мельников Захар Евгеньевич', '+345579024697');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (423, 'лесной оборона', '2689 Green View Manor', 'Панова Анастасия Марковна', '+887146558339');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (424, 'вечный слово', '3846 Foggy Harbour', 'Соколов Артур Артёмович', '+544033241469');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (425, 'неведомый формирование', '', 'Чижова Виктория Олеговна', '+786937191251');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (426, 'сексуальный полоса', '', 'Соболева Полина Данииловна', '+183713603500');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (427, 'готовый ужас', '280 Round Alley', 'Кошелев Артём Артёмович', '+698452416844');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (428, 'транспортный май', '9947 Stony Grove Lane', 'Горбунова Николь Михайловна', '+356354011737');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (429, 'многочисленный американец', '319 Sunny Gardens', 'Козлова Елена Артёмовна', '+585541600951');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (430, 'незначительный кресло', '4365 Iron Abbey', 'Нечаева Александра Семёновна', '+579292958111');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (431, 'возрастной население', '5350 Harvest Carrefour', 'Борисов Артём Игоревич', '+389938205336');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (432, 'искренний колесо', '', 'Кондратьева Стефания Семёновна', '+526588269336');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (433, 'передовой постановление', '', 'Соболева Полина Данииловна', '+429161912148');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (434, 'локальный вес', '', 'Панова Анастасия Марковна', '+692084969799');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (435, 'страстной строй', '8796 Little View Thicket', 'Гусева Дарья Марковна', '+217141867314');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (436, 'греческий самолет', '4136 Harvest Field', 'Федоров Александр Ростиславович', '+782906252088');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (437, 'мучительный развитие', '1405 Velvet Lagoon Dell', 'Ковалев Марк Иванович', '+266059194643');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (438, 'мировой удивление', '6845 Burning Embers Villas', 'Воронина Сабрина Святославовна', '+150577467563');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (439, 'саратовский глубина', '280 Round Alley', 'Алексеев Платон Степанович', '+165601440877');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (440, 'хитрый конференция', '5011 Noble Way', 'Плотникова Мария Артёмовна', '+838460553903');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (441, 'понятный восток', '4068 Foggy Bear Circle', 'Коновалов Тимофей Эрикович', '+211823052739');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (442, 'юный ракета', '7273 Golden Nectar Farms', 'Софронов Михаил Глебович', '+8617359065');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (443, 'спортивный вино', '3190 Sleepy Port', 'Рогов Михаил Фёдорович', '+253076690155');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (444, 'коренной месяц', '7248 Thunder Autumn Village', 'Козлова Стефания Романовна', '+735766741112');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (445, 'вертикальный бой', '8174 Clear Line', 'Григорьев Даниил Марсельевич', '+125218007120');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (446, 'будущий страсть', '6303 Shady Corners', 'Алексеев Иван Глебович', '+398632109406');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (447, 'идеологический замок', '', 'Беляева Элина Юрьевна', '+36088693216');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (448, 'удивительный нарушение', '7261 Dusty Horse Abbey', 'Дегтярев Адам Антонович', '+751269120828');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (449, 'базовый партия', '1947 Burning Creek Field', 'Щукина Евдокия Михайловна', '+394281131620');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (450, 'заключенный небо', '390 Sleepy Centre', 'Шульгина Виктория Петровна', '+969525181112');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (451, 'участковый женщина', '3755 Rocky Anchor Ledge', 'Лаптев Фёдор Дмитриевич', '+570611430434');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (452, 'драматический заказ', '554 Noble Avenue', 'Гончарова Полина Данииловна', '+35469044776');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (453, 'саратовский слой', '9619 Cozy Autumn Range', 'Высоцкая Ясмина Егоровна', '+894970503247');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (454, 'пыльный данные', '9808 Gentle Forest', 'Лапин Марк Константинович', '+375633330448');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (455, 'заключенный отказ', '', 'Колпакова Алиса Артёмовна', '+116390575957');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (456, 'удачный сюжет', '6103 Sunny Brook Byway', 'Сычева Василиса Данииловна', '+221515887373');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (457, 'заключенный степень', '8601 Misty Treasure Estates', 'Быкова Алиса Максимовна', '+814504297792');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (458, 'полный чудо', '782 Colonial Island Rise', 'Комиссаров Глеб Андреевич', '+289328420784');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (459, 'электрический стол', '6027 Blue Dale Plaza', 'Пугачев Семён Георгиевич', '+959173387038');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (460, 'уличный граница', '9218 High Vale', 'Беляев Михаил Михайлович', '+812127488135');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (461, 'ужасный граница', '8723 Thunder Log Meadow', 'Никитина Ева Ивановна', '+536392450612');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (462, 'окончательный режим', '', 'Кочергин Руслан Богданович', '+70572513636');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (463, 'зеленый переход', '4467 Cozy Expressway', 'Власов Демид Дамирович', '+380990036424');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (464, 'срочный период', '331 Thunder Turnabout', 'Борисова Айлин Богдановна', '+876037599876');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (465, 'детский комитет', '6756 Iron Limits', 'Кожевников Никита Александрович', '+860503720690');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (466, 'информационный борьба', '794 Silent Mountain', 'Макарова София Тимуровна', '+508455676361');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (467, 'безумный век', '4827 High Embers Line', 'Скворцова Мария Кирилловна', '+784594922391');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (468, 'надежный секунда', '9946 Hidden Trace', 'Никитина Ева Ивановна', '+189810538771');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (469, 'мясной развитие', '', 'Гончарова Милана Викторовна', '+987104820295');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (470, 'светский декабрь', '1941 Tawny Corner', 'Смирнов Сергей Всеволодович', '+766671849118');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (471, 'газовый доля', '2186 Red Lookout', 'Кузнецова Анна Данииловна', '+256884211031');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (472, 'ответственный порядок', '', 'Соболева Полина Данииловна', '+647238443071');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (473, 'молочный позиция', '4949 Lost Quay', 'Власова Анна Демидовна', '+460431189288');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (474, 'юридический начальство', '9422 Grand Bear Island', 'Медведев Владимир Давидович', '+487829632675');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (475, 'американский охрана', '5011 Noble Way', 'Уткин Константин Артёмович', '+742278417481');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (476, 'полицейский ребенок', '3378 Fallen Pioneer Ledge', 'Миронов Иван Алексеевич', '+93417772763');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (477, 'вертикальный образец', '280 Round Alley', 'Нечаев Леон Борисович', '+753247131249');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (478, 'юридический природа', '2742 Merry Leaf Beach', 'Комарова Алиса Тимофеевна', '+94517465748');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (479, 'должен бумага', '6610 Foggy Close', 'Сычева Кристина Романовна', '+319039002457');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (480, 'коммунистический сезон', '6559 Crystal Crescent', 'Денисова Анастасия Николаевна', '+867560128753');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (481, 'собачий документ', '1811 Cotton Berry Diversion', 'Фомина Милана Артёмовна', '+174105520415');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (482, 'жалкий показатель', '3846 Foggy Harbour', 'Лыков Владимир Константинович', '+457503183811');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (483, 'бюджетный бумага', '6822 Cotton Landing', 'Данилов Лука Антонович', '+161391703753');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (484, 'небесный кандидат', '3820 Rustic Spring Farms', 'Смирнов Михаил Фёдорович', '+402674373883');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (485, 'конституционный свобода', '8441 Dewy Corners', 'Мальцев Лев Никитич', '+360077841580');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (486, 'бытовой палата', '8851 Honey Loop', 'Соколов Лука Владиславович', '+167981588018');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (487, 'возрастной слой', '', 'Маркина Есения Данииловна', '+105663359364');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (488, 'личный масло', '5245 Clear Bear Mall', 'Карпова Арина Лукинична', '+349601405867');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (489, 'стеклянный рубеж', '', 'Фирсов Давид Владимирович', '+599157043864');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (490, 'западный сын', '8438 Little Fox Run', 'Яковлева Дарья Денисовна', '+910646110717');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (491, 'саратовский желание', '7273 Golden Nectar Farms', 'Федоров Данил Платонович', '+205692250817');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (492, 'смертельный соединение', '9982 Wishing Arbor', 'Чернышева Ангелина Ивановна', '+111321655442');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (493, 'правильный обязанность', '2363 Velvet Timber Nook', 'Васильев Тимур Артёмович', '+595043753102');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (494, 'долгосрочный пиво', '7098 Silver Trace', 'Фролов Константин Егорович', '+403785946692');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (495, 'качественный название', '6027 Blue Dale Plaza', 'Золотарева Арина Робертовна', '+429645617097');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (496, 'производственный сестра', '', 'Сычева Василиса Данииловна', '+57134845747');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (497, 'заметный предприятие', '', 'Белов Владислав Сергеевич', '+924441064474');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (498, 'мобильный дым', '9386 Bright Hill', 'Соколов Лука Владиславович', '+680791097944');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (499, 'ужасный строка', '554 Noble Avenue', 'Верещагина Мария Серафимовна', '+794533293304');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (500, 'должный забота', '9386 Bright Hill', 'Романов Леонид Данилович', '+562940444970');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (501, 'будущий граница', '5374 Quaking Willow Crest', 'Кузнецов Роман Сергеевич', '+647867510870');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (502, 'длинный дым', '554 Noble Avenue', 'Захарова Екатерина Георгиевна', '+266866752102');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (503, 'каменный право', '8589 Quiet Turnabout', 'Березина Вероника Тихоновна', '+701995180384');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (504, 'парламентский предмет', '1740 Stony Circle', 'Степанов Григорий Андреевич', '+526971281457');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (505, 'любовный понятие', '', 'Родионов Тимофей Дмитриевич', '+70526502234');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (506, 'старинный боль', '', 'Лебедев Давид Давидович', '+320709944178');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (507, 'деревянный дым', '6939 Lost Lake Wood', 'Ларин Даниил Романович', '+961714495913');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (508, 'эффективный достоинство', '8796 Little View Thicket', 'Никифоров Макар Захарович', '+905367575083');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (509, 'всеобщий постановление', '2934 Shady Robin Diversion', 'Мельникова Кристина Дамировна', '+285614204451');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (510, 'конструктивный направление', '4467 Cozy Expressway', 'Яковлева Кира Дмитриевна', '+223453682229');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (511, 'частный воздействие', '9808 Gentle Forest', 'Леонова Ариана Ярославовна', '+988910356288');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (512, 'конституционный сбор', '9247 Shady Mountain Glen', 'Золотарева Арина Робертовна', '+577824221887');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (513, 'временной решение', '5571 Quiet Chase', 'Беляева Элина Юрьевна', '+613378276487');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (514, 'серьезный ночь', '8980 Tawny Horse Grounds', 'Грачев Михаил Ибрагимович', '+168455216023');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (515, 'стандартный деревня', '4365 Iron Abbey', 'Павлов Али Иванович', '+476693422067');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (516, 'германский июль', '', 'Смирнов Лев Дмитриевич', '+799635873064');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (517, 'атомный прошлое', '', 'Вавилова Софья Глебовна', '+956667327635');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (518, 'автономный параметр', '367 Velvet Oak Towers', 'Козлов Никита Демидович', '+112296101809');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (519, 'социалистический подруга', '2955 Silent Fawn Harbour', 'Смирнова Александра Михайловна', '+813664054546');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (520, 'многочисленный песня', '1520 Umber Grounds', 'Гусева Елизавета Матвеевна', '+145656159961');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (521, 'учебный машина', '9947 Stony Grove Lane', 'Васильева Елена Артёмовна', '+92961604659');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (522, 'активный способность', '4231 Sleepy Willow Highway', 'Попова Василина Романовна', '+981840390140');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (523, 'областной дума', '5342 Grand Lake Swale', 'Соболева Полина Данииловна', '+506605066324');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (524, 'саратовский масло', '7193 Bright Row', 'Алексеева Серафима Игоревна', '+227616130885');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (525, 'колючий вкус', '4068 Foggy Bear Circle', 'Савин Арсений Дмитриевич', '+274430016421');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (526, 'надежный лейтенант', '1658 Red Treasure Village', 'Смирнов Лев Михайлович', '+154499194318');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (527, 'сомнительный элемент', '2612 Broad Barn Chase', 'Павлов Роберт Артёмович', '+345502197981');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (528, 'немецкий итог', '5131 Merry Deer Inlet', 'Романова Дарья Даниловна', '+229173759495');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (529, 'коричневый урок', '1995 Cinder Way', 'Смирнов Никита Львович', '+636802637583');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (530, 'тюремный взгляд', '4744 Old Cove', 'Щербаков Филипп Артурович', '+686147526306');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (531, 'двойной тень', '1575 Pleasant Circuit', 'Алексеева Ева Никитична', '+7725880387');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (532, 'экспертный площадка', '9003 Quaking Barn Parade', 'Егорова Софья Андреевна', '+178408996363');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (533, 'зарубежный ощущение', '319 Sunny Gardens', 'Павлов Эмин Фёдорович', '+795367024222');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (534, 'повседневный лето', '4744 Old Cove', 'Григорьев Даниил Марсельевич', '+853149372445');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (535, 'короткий расчет', '6018 Jagged Horse Orchard', 'Борисова Вероника Павловна', '+620389371243');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (536, 'частый мост', '5506 Emerald Abbey', 'Мартынов Илья Романович', '+818446559079');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (537, 'последовательный костюм', '2612 Broad Barn Chase', 'Орлова Сафия Максимовна', '+780595761974');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (538, 'актуальный запад', '', 'Скворцова Мария Кирилловна', '+607600551343');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (539, 'защитный слеза', '9059 Pleasant Campus', 'Мельников Захар Евгеньевич', '+849307279488');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (540, 'советский рождение', '8851 Honey Loop', 'Тимофеев Андрей Даниилович', '+252898351850');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (541, 'коричневый ребенок', '459 Round Leaf Townline', 'Скворцова Мария Кирилловна', '+52273528722');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (542, 'заключенный коридор', '2955 Silent Fawn Harbour', 'Спиридонова Яна Артёмовна', '+102670809012');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (543, 'краткий бизнес', '5020 Dewy Street', 'Киселев Станислав Дмитриевич', '+199826620476');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (544, 'киевский вариант', '2724 Cinder Hollow', 'Березин Даниил Степанович', '+421164101103');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (545, 'совместный надежда', '6756 Iron Limits', 'Карпова Алиса Фёдоровна', '+816455066246');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (546, 'человеческий танец', '2186 Red Lookout', 'Иванова Александра Артемьевна', '+697547648431');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (547, 'непосредственный переход', '7208 Misty Pond Farm', 'Кондратьева Стефания Семёновна', '+734150766299');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (548, 'многочисленный масло', '4744 Old Cove', 'Митрофанов Александр Денисович', '+649945701796');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (549, 'знаменитый глаз', '229 Hidden Lookout', 'Сорокин Владислав Владимирович', '+121286966366');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (550, 'славянский фонд', '3994 Thunder Jetty', 'Ершова София Александровна', '+915538656158');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (551, 'коммунистический пример', '2689 Green View Manor', 'Калмыкова Агата Максимовна', '+783840866266');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (552, 'парижский глава', '1811 Cotton Berry Diversion', 'Сорокин Владислав Владимирович', '+210120759126');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (553, 'провинциальный страсть', '3846 Foggy Harbour', 'Киселев Станислав Дмитриевич', '+705842250169');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (554, 'краткий лагерь', '', 'Кузнецов Владимир Максимович', '+703496388243');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (555, 'казенный время', '3425 Iron Lane', 'Константинов Алексей Львович', '+138945166613');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (556, 'мировой промышленность', '4357 Cotton Bay', 'Софронов Владимир Андреевич', '+158500208659');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (557, 'полный совесть', '5374 Quaking Willow Crest', 'Яковлева Кира Дмитриевна', '+82340720842');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (558, 'всевозможный женщина', '8174 Clear Line', 'Александров Матвей Дмитриевич', '+139186946800');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (559, 'звездный слово', '3994 Thunder Jetty', 'Николаев Алексей Дмитриевич', '+945430016491');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (560, 'своеобразный увеличение', '794 Silent Mountain', 'Панков Михаил Александрович', '+95406977813');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (561, 'очередной дума', '', 'Мещеряков Фёдор Викторович', '+616495027083');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (562, 'заметный глубина', '331 Thunder Turnabout', 'Березина Вероника Тихоновна', '+47407420625');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (563, 'параллельный профессор', '5020 Dewy Street', 'Лебедева Милана Евгеньевна', '+668894002417');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (564, 'видный прием', '', 'Медведева Милана Леоновна', '+906537922315');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (565, 'искренний попытка', '', 'Тарасова Валерия Глебовна', '+735200685564');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (566, 'небесный достоинство', '5132 Blue Sky Autoroute', 'Беляева Элина Юрьевна', '+175043939676');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (567, 'дальний программа', '5132 Blue Sky Autoroute', 'Костина Сафия Данииловна', '+104063361501');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (568, 'провинциальный крест', '', 'Романов Кирилл Александрович', '+676292844011');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (569, 'бетонный мешок', '', 'Софронов Владимир Андреевич', '+40392363944');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (570, 'законный войско', '', 'Смирнов Лев Михайлович', '+398615713744');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (571, 'полезный взгляд', '', 'Федотова Василиса Романовна', '+496932389977');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (572, 'приятный голос', '836 Red River End', 'Морозов Александр Никитич', '+421883375091');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (573, 'убежденный время', '7580 Quaking Butterfly Path', 'Смирнов Лев Михайлович', '+440443444924');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (574, 'немалый рубль', '5130 Lost Glen', 'Фролова Алиса Леонидовна', '+890126334747');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (575, 'энергичный храм', '3668 Middle Hill', 'Никитин Михаил Артёмович', '+262588838340');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (576, 'либеральный сентябрь', '', 'Киселев Никита Тимофеевич', '+186839680626');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (577, 'восточный нарушение', '', 'Карпова Арина Лукинична', '+551465056242');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (578, 'совершенный председатель', '', 'Бирюков Максим Александрович', '+322098244486');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (579, 'звездный полоса', '7261 Dusty Horse Abbey', 'Сычева Кристина Романовна', '+26348081758');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (580, 'тревожный слово', '3434 Cotton Road', 'Гончарова Полина Данииловна', '+622295705948');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (581, 'демократический спорт', '', 'Харитонов Артём Григорьевич', '+726416595179');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (582, 'привлекательный конкурс', '3425 Iron Lane', 'Зуев Андрей Михайлович', '+837061498538');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (583, 'многочисленный желание', '5374 Quaking Willow Crest', 'Синицын Роман Романович', '+655563790311');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (584, 'меньший препарат', '2186 Red Lookout', 'Гончарова Милана Викторовна', '+35843661016');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (585, 'социалистический труд', '1964 Merry Fawn Bend', 'Тихомирова Алиса Вадимовна', '+822669268449');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (586, 'боевой слой', '4231 Sleepy Willow Highway', 'Трофимов Демид Павлович', '+721760762649');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (587, 'двойной возможность', '782 Colonial Island Rise', 'Тарасов Лев Данилович', '+625994059549');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (588, 'позитивный москвич', '4827 High Embers Line', 'Журавлева Марьям Дмитриевна', '+130480618508');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (589, 'женский конкурс', '8768 Broad Arbor', 'Щукина Евдокия Михайловна', '+299856340836');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (590, 'профессиональный президент', '7864 Stony Trail', 'Миронов Иван Алексеевич', '+731974350493');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (591, 'крепкий земля', '', 'Масленников Максим Русланович', '+508033136947');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (592, 'честный собрание', '280 Round Alley', 'Голубева Полина Ильинична', '+284246955813');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (593, 'грузовой эксплуатация', '9422 Grand Bear Island', 'Киреева Ника Андреевна', '+414297529150');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (594, 'кредитный крыло', '2324 Cinder Prairie Port', 'Прохоров Андрей Григорьевич', '+385065759824');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (595, 'письменный рождение', '944 Umber Embers Manor', 'Тимофеев Андрей Даниилович', '+999239110171');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (596, 'деловой правда', '1819 Colonial Anchor Park', 'Гусева Дарья Марковна', '+677364709029');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (597, 'должностной шея', '5342 Grand Lake Swale', 'Глухов Глеб Никитич', '+674736534365');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (598, 'прочный условие', '5967 Dusty Pike', 'Кондрашов Константин Дамирович', '+915750402461');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (599, 'возрастной войско', '1262 Indian Villas', 'Потапов Данила Даниилович', '+395360847537');
INSERT INTO public.client (id_client, client_name, client_address, "Contact_person", "Contact") OVERRIDING SYSTEM VALUE VALUES (600, 'коричневый федерация', '5023 Red Rise Autoroute', 'Евдокимов Максим Михайлович', '+731404828064');


--
-- TOC entry 3661 (class 0 OID 16425)
-- Dependencies: 211
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (1, 'Отдел перспективных разработок', '840283406242');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (2, 'Служба делопроизводства', '684888588185');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (3, 'IT-отдел', '376390358583');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (4, 'Отдел кадров', '266659592111');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (5, 'Отдел продаж', '789452248816');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (6, 'Служба делопроизводства', '738210331415');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (7, 'Бухгалтерия', '601546908564');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (8, 'Бухгалтерия', '678793236462');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (9, 'Отдел снабжения', '16621589235');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (10, 'Отдел технической поддержки', '865974797244');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (11, 'IT-отдел', '386614492355');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (12, 'Отдел перспективных разработок', '640143528112');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (13, 'Проектно-конструкторский отдел', '183364388148');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (14, 'Отдел снабжения', '468770402685');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (15, 'Администрация', '840785261333');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (16, 'Юридический отдел', '306954588782');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (17, 'Отдел перспективных разработок', '296538139006');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (18, 'Отдел перспективных разработок', '328112439627');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (19, 'Отдел снабжения', '136696319761');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (20, 'Отдел технической поддержки', '224209599924');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (21, 'IT-отдел', '269325918820');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (22, 'Отдел технической поддержки', '187509115950');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (23, 'Отдел снабжения', '195902097588');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (24, 'Отдел снабжения', '47533314606');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (25, 'Отдел снабжения', '882039498126');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (26, 'Отдел технической поддержки', '810091163480');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (27, 'Отдел технической поддержки', '918811007264');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (28, 'Отдел кадров', '782434904175');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (29, 'Отдел продаж', '529812073248');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (30, 'Отдел маркетинга', '100543112743');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (31, 'Отдел перспективных разработок', '261456188728');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (32, 'Отдел технической поддержки', '401939058605');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (33, 'Проектно-конструкторский отдел', '937767451767');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (34, 'Отдел продаж', '715928761367');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (35, 'Отдел продаж', '434104570249');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (36, 'Отдел перспективных разработок', '884048543194');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (37, 'Бухгалтерия', '505978640310');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (38, 'Отдел снабжения', '333865090124');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (39, 'Отдел технической поддержки', '29237152330');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (40, 'Отдел продаж', '247494495060');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (41, 'Отдел перспективных разработок', '149400804327');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (42, 'Отдел снабжения', '136693374484');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (43, 'IT-отдел', '359245908370');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (44, 'Отдел снабжения', '32391384109');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (45, 'Отдел снабжения', '468634642138');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (46, 'Отдел продаж', '46486314081');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (47, 'Бухгалтерия', '825098625505');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (48, 'Администрация', '746650745113');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (49, 'IT-отдел', '988316145061');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (50, 'Администрация', '851071437279');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (51, 'Отдел кадров', '511765640858');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (52, 'Отдел перспективных разработок', '721788491566');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (53, 'Отдел перспективных разработок', '900250078628');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (54, 'Администрация', '856496451989');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (55, 'Отдел продаж', '898197924928');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (56, 'Отдел маркетинга', '121200903689');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (57, 'Отдел продаж', '188127740761');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (58, 'Юридический отдел', '939405300680');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (59, 'Служба делопроизводства', '603183651818');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (60, 'Проектно-конструкторский отдел', '405732978947');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (61, 'Отдел перспективных разработок', '359520724083');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (62, 'Отдел снабжения', '154071178934');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (63, 'Отдел перспективных разработок', '261891728579');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (64, 'Отдел продаж', '627653209546');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (65, 'IT-отдел', '817374496356');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (66, 'Отдел маркетинга', '141167282851');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (67, 'Отдел маркетинга', '572759588265');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (68, 'Отдел снабжения', '113419495664');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (69, 'Служба делопроизводства', '378950408101');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (70, 'Отдел кадров', '895482274421');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (71, 'IT-отдел', '682878729244');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (72, 'Отдел технической поддержки', '487423183746');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (73, 'Отдел кадров', '371385725194');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (74, 'Администрация', '749417348891');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (75, 'Отдел перспективных разработок', '40628106834');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (76, 'Проектно-конструкторский отдел', '486523086944');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (77, 'Юридический отдел', '681643822938');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (78, 'Отдел снабжения', '411168448827');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (79, 'Отдел кадров', '144533113646');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (80, 'Служба делопроизводства', '58753403430');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (81, 'Отдел перспективных разработок', '740868750458');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (82, 'Бухгалтерия', '588254932756');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (83, 'Отдел перспективных разработок', '533040571767');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (84, 'Отдел перспективных разработок', '584765001916');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (85, 'Проектно-конструкторский отдел', '36005912196');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (86, 'Проектно-конструкторский отдел', '537599402784');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (87, 'Отдел продаж', '649214544230');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (88, 'Отдел продаж', '798698747291');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (89, 'Юридический отдел', '608145086495');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (90, 'Отдел перспективных разработок', '944703127935');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (91, 'Проектно-конструкторский отдел', '792677282116');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (92, 'Юридический отдел', '227546236414');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (93, 'Отдел маркетинга', '738531707293');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (94, 'Администрация', '779866418344');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (286, 'Бухгалтерия', '362757929099');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (95, 'Проектно-конструкторский отдел', '338859696991');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (96, 'Отдел снабжения', '207261131237');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (97, 'Отдел технической поддержки', '279596357045');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (98, 'Отдел снабжения', '820863921455');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (99, 'Администрация', '411610442797');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (100, 'Отдел маркетинга', '728778662875');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (101, 'Бухгалтерия', '915200648203');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (102, 'Администрация', '908951973902');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (103, 'Отдел перспективных разработок', '824911421765');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (104, 'Проектно-конструкторский отдел', '941617989561');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (105, 'Отдел продаж', '359167412993');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (106, 'IT-отдел', '622896619958');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (107, 'Отдел технической поддержки', '652767241171');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (108, 'Отдел снабжения', '77927017572');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (109, 'Отдел технической поддержки', '541521576011');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (110, 'Бухгалтерия', '998522846977');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (111, 'Отдел снабжения', '855165405272');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (112, 'Отдел продаж', '147493390523');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (113, 'Отдел кадров', '615167334195');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (114, 'Проектно-конструкторский отдел', '874952219172');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (115, 'IT-отдел', '220184143342');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (116, 'Отдел перспективных разработок', '751154327076');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (117, 'Служба делопроизводства', '136019826808');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (118, 'Проектно-конструкторский отдел', '285051214892');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (119, 'Отдел снабжения', '27549265489');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (120, 'Отдел продаж', '687733261948');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (121, 'Отдел маркетинга', '249725780470');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (122, 'Юридический отдел', '766463506510');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (123, 'IT-отдел', '893618619419');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (124, 'Отдел продаж', '28389914695');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (125, 'Администрация', '781949226250');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (126, 'Отдел продаж', '902175693018');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (127, 'Служба делопроизводства', '885688995244');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (128, 'Отдел перспективных разработок', '259788667328');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (129, 'Отдел кадров', '853824104508');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (130, 'Служба делопроизводства', '844280650974');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (131, 'Отдел маркетинга', '122629147449');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (132, 'Бухгалтерия', '215941235573');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (133, 'Отдел маркетинга', '618866861860');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (134, 'Отдел технической поддержки', '432317300972');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (135, 'Отдел кадров', '744166791281');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (136, 'Отдел продаж', '518215109125');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (137, 'Служба делопроизводства', '422796585599');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (138, 'Бухгалтерия', '441150452605');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (139, 'Отдел технической поддержки', '108387099865');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (140, 'Отдел продаж', '664642420831');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (141, 'IT-отдел', '264146237551');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (142, 'Отдел перспективных разработок', '432161193702');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (143, 'Отдел кадров', '765131757170');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (144, 'Отдел перспективных разработок', '97150743274');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (145, 'Отдел снабжения', '314651884337');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (146, 'Отдел кадров', '580522916305');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (147, 'Отдел технической поддержки', '291066749161');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (148, 'Проектно-конструкторский отдел', '725776505850');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (149, 'Отдел перспективных разработок', '716693289046');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (150, 'Бухгалтерия', '424240615488');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (151, 'IT-отдел', '334728709244');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (152, 'Служба делопроизводства', '312392027168');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (153, 'Юридический отдел', '925567734291');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (154, 'Служба делопроизводства', '231691667447');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (155, 'Отдел продаж', '709986227848');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (156, 'Бухгалтерия', '225505363584');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (157, 'Проектно-конструкторский отдел', '554819071882');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (158, 'Проектно-конструкторский отдел', '58761817565');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (159, 'Отдел продаж', '677986520835');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (160, 'Отдел кадров', '153272821760');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (161, 'Бухгалтерия', '789429573683');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (162, 'Отдел технической поддержки', '375543183264');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (163, 'Отдел маркетинга', '758970891221');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (164, 'IT-отдел', '325920388652');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (165, 'Юридический отдел', '787557445048');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (166, 'Отдел маркетинга', '988379973313');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (167, 'Бухгалтерия', '559085529240');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (168, 'Проектно-конструкторский отдел', '746534885318');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (169, 'Юридический отдел', '444992270592');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (170, 'Отдел технической поддержки', '465022640545');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (171, 'Служба делопроизводства', '178884967431');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (172, 'Отдел перспективных разработок', '110749818232');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (173, 'Бухгалтерия', '487686547065');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (174, 'Юридический отдел', '766368436281');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (175, 'Отдел технической поддержки', '745100832890');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (176, 'Отдел продаж', '367172112349');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (177, 'Проектно-конструкторский отдел', '261116308638');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (178, 'Отдел технической поддержки', '700613465177');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (179, 'Проектно-конструкторский отдел', '243213682801');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (180, 'Отдел снабжения', '200137635026');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (181, 'Отдел кадров', '226263270868');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (182, 'Отдел кадров', '316608401089');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (183, 'Отдел продаж', '839155177029');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (184, 'Отдел кадров', '457606407337');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (185, 'Отдел маркетинга', '245327847869');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (186, 'Служба делопроизводства', '817962339317');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (187, 'Отдел маркетинга', '771370039874');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (188, 'Служба делопроизводства', '392811939284');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (189, 'Проектно-конструкторский отдел', '533673252039');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (190, 'Отдел маркетинга', '648107437819');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (191, 'Юридический отдел', '114064444353');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (192, 'Отдел кадров', '597832406594');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (193, 'Отдел кадров', '623763182466');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (194, 'Отдел маркетинга', '232414530763');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (195, 'Администрация', '490519450569');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (196, 'Проектно-конструкторский отдел', '782213016270');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (197, 'Служба делопроизводства', '716010877269');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (198, 'Администрация', '951269793615');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (199, 'Отдел маркетинга', '141152680952');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (200, 'Бухгалтерия', '512549137354');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (201, 'Администрация', '934406148253');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (202, 'Отдел кадров', '606480088383');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (203, 'Отдел кадров', '893562905961');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (204, 'Администрация', '284206506678');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (205, 'Бухгалтерия', '292110466895');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (206, 'Отдел маркетинга', '124153276931');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (207, 'Администрация', '934183671708');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (208, 'Отдел снабжения', '431065739736');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (209, 'Администрация', '86932199113');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (210, 'Отдел перспективных разработок', '274009939738');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (211, 'Отдел технической поддержки', '564026731590');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (212, 'Администрация', '522828521108');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (213, 'Юридический отдел', '503081100153');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (214, 'Бухгалтерия', '654488827071');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (215, 'Администрация', '484952834532');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (216, 'IT-отдел', '848537026609');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (217, 'Проектно-конструкторский отдел', '723153798637');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (218, 'Проектно-конструкторский отдел', '739935652308');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (219, 'Служба делопроизводства', '332236549443');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (220, 'Отдел маркетинга', '825147199635');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (221, 'Отдел снабжения', '210927359144');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (222, 'Проектно-конструкторский отдел', '920495074198');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (223, 'Служба делопроизводства', '305614063978');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (224, 'Служба делопроизводства', '561720469805');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (225, 'Проектно-конструкторский отдел', '258890262755');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (226, 'Бухгалтерия', '71312775967');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (227, 'Служба делопроизводства', '831717388014');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (228, 'Служба делопроизводства', '638557518562');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (229, 'Отдел кадров', '346270401633');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (230, 'Проектно-конструкторский отдел', '838087565647');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (231, 'Отдел перспективных разработок', '716113598054');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (232, 'Отдел перспективных разработок', '887215994061');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (233, 'Бухгалтерия', '836120586754');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (234, 'Отдел кадров', '811412770957');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (235, 'Отдел технической поддержки', '867124719578');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (236, 'Бухгалтерия', '388930619193');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (237, 'Отдел технической поддержки', '216362032805');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (238, 'Отдел снабжения', '585802767556');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (239, 'Служба делопроизводства', '740413891908');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (240, 'Отдел перспективных разработок', '364070884339');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (241, 'Отдел перспективных разработок', '529316175595');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (242, 'IT-отдел', '685349945855');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (243, 'Администрация', '339247636883');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (244, 'Отдел продаж', '106469725692');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (245, 'Юридический отдел', '416366723407');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (246, 'IT-отдел', '517138957509');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (247, 'Отдел технической поддержки', '345700148655');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (248, 'Администрация', '726078256534');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (249, 'Юридический отдел', '998514129757');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (250, 'Отдел технической поддержки', '321352359542');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (251, 'Отдел кадров', '706125424490');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (252, 'Служба делопроизводства', '336127804849');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (253, 'Администрация', '187237861210');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (254, 'Отдел перспективных разработок', '4244317777');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (255, 'Отдел продаж', '351187216803');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (256, 'Отдел технической поддержки', '221299516708');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (257, 'Администрация', '514254419462');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (258, 'Администрация', '804469182667');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (259, 'Администрация', '655674581440');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (260, 'Бухгалтерия', '378102995790');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (261, 'Отдел кадров', '777567239509');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (262, 'Бухгалтерия', '800278870892');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (263, 'Отдел кадров', '694311522495');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (264, 'Отдел кадров', '997665703213');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (265, 'Отдел технической поддержки', '588475465726');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (266, 'Отдел маркетинга', '182029625053');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (267, 'Отдел технической поддержки', '593190623579');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (268, 'Проектно-конструкторский отдел', '424160992622');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (269, 'Отдел продаж', '811034952954');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (270, 'Юридический отдел', '550188883915');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (271, 'Проектно-конструкторский отдел', '438030890285');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (272, 'Служба делопроизводства', '383940766996');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (273, 'Бухгалтерия', '423927487536');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (274, 'Отдел технической поддержки', '873584882632');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (275, 'Отдел продаж', '97463289841');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (276, 'Отдел кадров', '216224853912');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (277, 'Отдел кадров', '729002965203');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (278, 'Отдел технической поддержки', '236338695097');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (279, 'Администрация', '42663229261');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (280, 'Юридический отдел', '565171114474');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (281, 'IT-отдел', '508922556099');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (282, 'Отдел кадров', '717280498401');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (283, 'Отдел перспективных разработок', '897757196069');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (284, 'Отдел снабжения', '331581990784');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (285, 'Юридический отдел', '658751990214');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (287, 'IT-отдел', '337415676834');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (288, 'Отдел кадров', '414209055089');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (289, 'Юридический отдел', '470563827174');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (290, 'Служба делопроизводства', '631969859391');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (291, 'Отдел технической поддержки', '423416129889');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (292, 'Отдел маркетинга', '668440850393');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (293, 'Служба делопроизводства', '324485539185');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (294, 'Юридический отдел', '815990022025');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (295, 'Проектно-конструкторский отдел', '677135781208');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (296, 'Отдел маркетинга', '432345764908');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (297, 'Отдел технической поддержки', '499808752570');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (298, 'Бухгалтерия', '873877659292');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (299, 'Бухгалтерия', '58167400424');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (300, 'Проектно-конструкторский отдел', '280389407862');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (301, 'IT-отдел', '440618659578');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (302, 'IT-отдел', '785715179582');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (303, 'Отдел кадров', '861891480973');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (304, 'Отдел кадров', '823381740900');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (305, 'IT-отдел', '133117019075');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (306, 'Администрация', '967836869537');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (307, 'Служба делопроизводства', '2349794913');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (308, 'Отдел маркетинга', '41691290096');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (309, 'Отдел перспективных разработок', '736348197925');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (310, 'Проектно-конструкторский отдел', '579158966469');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (311, 'Отдел технической поддержки', '672822212527');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (312, 'Отдел маркетинга', '755785072789');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (313, 'Отдел продаж', '211883663574');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (314, 'Отдел продаж', '266729552841');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (315, 'Отдел перспективных разработок', '216036709203');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (316, 'Юридический отдел', '737767491338');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (317, 'Отдел технической поддержки', '930109876715');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (318, 'Отдел технической поддержки', '573267592272');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (319, 'Отдел перспективных разработок', '621901196613');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (320, 'Отдел снабжения', '584934227563');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (321, 'IT-отдел', '402244640365');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (322, 'Отдел маркетинга', '494475332950');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (323, 'Проектно-конструкторский отдел', '640705355830');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (324, 'Юридический отдел', '328748971615');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (325, 'Отдел продаж', '861533187131');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (326, 'Бухгалтерия', '370533908387');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (327, 'Отдел снабжения', '303262512153');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (328, 'Отдел маркетинга', '546342709086');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (329, 'Проектно-конструкторский отдел', '676038270643');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (330, 'Отдел снабжения', '678321124781');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (331, 'Юридический отдел', '259565811851');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (332, 'Юридический отдел', '834141970430');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (333, 'Отдел перспективных разработок', '244030178434');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (334, 'Отдел снабжения', '842871927831');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (335, 'IT-отдел', '511686178759');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (336, 'Отдел кадров', '793908305525');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (337, 'Отдел маркетинга', '622952576651');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (338, 'Отдел маркетинга', '67184328844');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (339, 'Отдел технической поддержки', '777744785639');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (340, 'Администрация', '475906271154');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (341, 'Юридический отдел', '989956984942');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (342, 'Отдел снабжения', '856803385300');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (343, 'Отдел снабжения', '344023628889');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (344, 'Отдел снабжения', '974964887398');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (345, 'Отдел технической поддержки', '495261040446');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (346, 'Администрация', '520597929996');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (347, 'Отдел снабжения', '180473611158');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (348, 'Отдел маркетинга', '193036687849');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (349, 'Служба делопроизводства', '468851563754');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (350, 'Отдел перспективных разработок', '227907320076');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (351, 'Администрация', '602609506418');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (352, 'Отдел снабжения', '347770271955');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (353, 'Отдел перспективных разработок', '308770055139');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (354, 'Проектно-конструкторский отдел', '867033176057');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (355, 'Служба делопроизводства', '173773339346');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (356, 'Отдел снабжения', '80113984031');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (357, 'Проектно-конструкторский отдел', '907124167929');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (358, 'Администрация', '638932551488');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (359, 'Бухгалтерия', '519860320712');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (360, 'Отдел кадров', '617628887606');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (361, 'Бухгалтерия', '603168130353');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (362, 'Юридический отдел', '499481145441');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (363, 'IT-отдел', '51662282847');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (364, 'Администрация', '476557207661');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (365, 'Проектно-конструкторский отдел', '591535773437');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (366, 'Юридический отдел', '798683973423');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (367, 'Отдел технической поддержки', '611518835500');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (368, 'Отдел технической поддержки', '119045660610');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (369, 'Администрация', '848702432231');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (370, 'Администрация', '36802589018');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (371, 'Отдел продаж', '983926014548');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (372, 'Проектно-конструкторский отдел', '523628165858');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (373, 'IT-отдел', '932212530185');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (374, 'Отдел продаж', '433571129388');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (375, 'Администрация', '495928971566');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (376, 'Отдел перспективных разработок', '675998236148');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (377, 'Отдел перспективных разработок', '792862274602');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (378, 'Отдел кадров', '997060734363');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (379, 'Отдел кадров', '455745653985');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (380, 'Отдел маркетинга', '167063337778');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (381, 'Отдел маркетинга', '585265136799');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (382, 'Проектно-конструкторский отдел', '341942111564');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (383, 'Юридический отдел', '298017222089');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (384, 'Отдел продаж', '946578657882');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (385, 'Бухгалтерия', '452075939018');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (386, 'Отдел продаж', '387611356083');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (387, 'IT-отдел', '253973004743');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (388, 'Отдел продаж', '349569439859');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (389, 'Проектно-конструкторский отдел', '657427271385');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (390, 'Администрация', '38811183338');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (391, 'Отдел снабжения', '501557326454');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (392, 'Отдел перспективных разработок', '161752387482');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (393, 'Юридический отдел', '577684477294');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (394, 'Отдел маркетинга', '49704363517');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (395, 'Отдел маркетинга', '183973083813');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (396, 'Отдел снабжения', '260806339341');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (397, 'Отдел кадров', '463089420845');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (398, 'Отдел кадров', '526499664506');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (399, 'Отдел технической поддержки', '122167498083');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (400, 'Отдел технической поддержки', '312522321906');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (401, 'Отдел кадров', '712347004679');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (402, 'Администрация', '977587272984');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (403, 'Администрация', '248846412058');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (404, 'Служба делопроизводства', '339770478306');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (405, 'Отдел маркетинга', '493093021848');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (406, 'Отдел маркетинга', '721790529829');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (407, 'Бухгалтерия', '919241424533');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (408, 'Бухгалтерия', '713541149496');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (409, 'Отдел снабжения', '997298414972');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (410, 'Отдел перспективных разработок', '773068316476');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (411, 'Отдел кадров', '488548980834');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (412, 'Проектно-конструкторский отдел', '299229173273');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (413, 'Отдел кадров', '872865837350');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (414, 'Отдел снабжения', '656088708772');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (415, 'Отдел технической поддержки', '816338045447');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (416, 'Администрация', '114244995151');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (417, 'Отдел кадров', '613769015157');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (418, 'Проектно-конструкторский отдел', '190329676238');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (419, 'Администрация', '337634925969');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (420, 'Отдел кадров', '123866702968');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (421, 'Бухгалтерия', '662794936338');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (422, 'Администрация', '298540309548');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (423, 'Служба делопроизводства', '6539207308');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (424, 'Отдел технической поддержки', '156676274238');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (425, 'Отдел кадров', '332863357653');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (426, 'Отдел технической поддержки', '955984698771');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (427, 'Отдел снабжения', '86231667010');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (428, 'Отдел перспективных разработок', '117993816292');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (429, 'Отдел перспективных разработок', '562994603373');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (430, 'Отдел технической поддержки', '728697821157');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (431, 'IT-отдел', '144262821817');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (432, 'Администрация', '577603508615');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (433, 'IT-отдел', '857119480303');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (434, 'Отдел кадров', '722460432954');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (435, 'Администрация', '119561108139');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (436, 'Бухгалтерия', '626237626713');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (437, 'Отдел технической поддержки', '226954036619');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (438, 'Администрация', '774293309478');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (439, 'Проектно-конструкторский отдел', '282673608626');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (440, 'IT-отдел', '559497150348');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (441, 'Отдел перспективных разработок', '201398222258');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (442, 'Отдел перспективных разработок', '776200422068');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (443, 'Юридический отдел', '354897871629');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (444, 'Отдел технической поддержки', '235232975974');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (445, 'Юридический отдел', '422056064315');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (446, 'Юридический отдел', '506125127583');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (447, 'Отдел снабжения', '608943580337');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (448, 'Отдел снабжения', '261838317867');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (449, 'Отдел снабжения', '375978542106');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (450, 'Отдел снабжения', '313859911911');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (451, 'Отдел продаж', '56205167759');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (452, 'Отдел маркетинга', '328581830682');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (453, 'Отдел снабжения', '800618864074');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (454, 'Администрация', '843386420208');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (455, 'Проектно-конструкторский отдел', '618644539926');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (456, 'Отдел снабжения', '428791666402');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (457, 'Проектно-конструкторский отдел', '944660905720');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (458, 'Юридический отдел', '395944034084');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (459, 'Юридический отдел', '136733314729');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (460, 'Юридический отдел', '874086007913');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (461, 'Бухгалтерия', '703534812872');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (462, 'Отдел кадров', '408956274021');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (463, 'Юридический отдел', '409092331674');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (464, 'Бухгалтерия', '135569492474');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (465, 'Проектно-конструкторский отдел', '159379696903');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (466, 'IT-отдел', '396058684477');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (467, 'IT-отдел', '723831874750');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (468, 'Отдел продаж', '451373895994');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (469, 'Отдел маркетинга', '751681069955');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (470, 'Отдел продаж', '770102670099');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (471, 'Юридический отдел', '278083667011');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (472, 'Служба делопроизводства', '650129542354');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (473, 'Отдел кадров', '236944217468');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (474, 'Отдел снабжения', '641714611376');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (475, 'Юридический отдел', '784242401537');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (476, 'Отдел кадров', '272991289949');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (477, 'Проектно-конструкторский отдел', '113760823514');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (478, 'Отдел технической поддержки', '770766673261');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (479, 'Отдел кадров', '358918679584');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (480, 'Администрация', '162589256078');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (481, 'Отдел маркетинга', '429572952481');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (482, 'Администрация', '122217485517');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (483, 'Отдел технической поддержки', '682466651642');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (484, 'Бухгалтерия', '212085917957');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (485, 'Юридический отдел', '62846596619');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (486, 'Отдел кадров', '192650133130');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (487, 'Отдел маркетинга', '982067895428');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (488, 'Юридический отдел', '217139394028');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (489, 'Проектно-конструкторский отдел', '956680749402');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (490, 'Отдел перспективных разработок', '745439169373');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (491, 'Отдел снабжения', '835004667039');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (492, 'Бухгалтерия', '450132642668');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (493, 'Юридический отдел', '837563938778');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (494, 'Отдел продаж', '267320553762');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (495, 'Отдел технической поддержки', '407277785431');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (496, 'Отдел кадров', '908774963405');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (497, 'Служба делопроизводства', '168325793872');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (498, 'Отдел перспективных разработок', '480923780538');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (499, 'Отдел маркетинга', '769840691656');
INSERT INTO public.department (id_department, department_name, department_phone) OVERRIDING SYSTEM VALUE VALUES (500, 'IT-отдел', '89700868105');


--
-- TOC entry 3662 (class 0 OID 16435)
-- Dependencies: 212
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (1, 387, 381, 204, 'Макарова', 'Елизавета', 'Германовна', '83344758008', 43679530);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (2, 356, 66, 120, 'Малышев', 'Денис', 'Денисович', '954603998538', 650022427);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (3, 325, 440, 367, 'Еремин', 'Дмитрий', 'Артёмович', '109201314829', 477456905);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (4, 475, 316, 419, 'Губанова', 'Виктория', 'Михайловна', '382565178636', 677574550);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (5, 214, 66, 194, 'Самойлова', 'Елизавета', 'Артемьевна', '72871452905', 299857238);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (6, 102, 37, 386, 'Никитина', 'Виктория', 'Давидовна', '856235480587', 279767916);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (7, 279, 402, 399, 'Панина', 'Ульяна', 'Михайловна', '574433719367', 505524178);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (8, 172, 481, 324, 'Громов', 'Алексей', 'Фёдорович', '431888523432', 209522577);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (9, 109, 442, 61, 'Нефедова', 'Виктория', 'Игоревна', '550105954672', 55038014);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (10, 334, 415, 412, 'Успенская', 'Виктория', 'Львовна', '281631925595', 509458021);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (11, 385, 227, 337, 'Баженов', 'Савелий', 'Матвеевич', '492118103468', 261276149);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (12, 479, 325, 264, 'Балашов', 'Владимир', 'Алексеевич', '791597623670', 770582714);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (13, 62, 136, 224, 'Третьякова', 'София', 'Давидовна', '782250313343', 469764157);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (14, 258, 480, 42, 'Смирнова', 'Елизавета', 'Алиевна', '363012446281', 486044009);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (15, 209, 456, 316, 'Соколова', 'Ксения', 'Артёмовна', '124180732731', 273230991);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (16, 226, 263, 478, 'Акимова', 'Кира', 'Марковна', '889664426796', 365463347);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (17, 38, 337, 127, 'Медведева', 'Милана', 'Леоновна', '310742680219', 620805727);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (18, 33, 430, 372, 'Прокофьева', 'Елизавета', 'Святославовна', '922558045608', 282598811);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (19, 68, 256, 82, 'Колесникова', 'Анна', 'Андреевна', '356004938971', 146534013);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (20, 218, 184, 492, 'Гончаров', 'Тимофей', 'Никитич', '25634705664', 761939362);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (21, 148, 79, 284, 'Матвеев', 'Михаил', 'Николаевич', '596664826782', 417646003);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (22, 461, 202, 480, 'Соколов', 'Даниил', 'Григорьевич', '771572051089', 151252387);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (23, 396, 65, 485, 'Богданова', 'Ольга', 'Юрьевна', '877436459304', 333809714);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (24, 22, 7, 369, 'Гусева', 'Елизавета', 'Матвеевна', '983381817754', 333789190);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (25, 374, 304, 62, 'Нечаева', 'Аиша', 'Артёмовна', '623795776433', 235333920);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (26, 290, 335, 399, 'Чернышев', 'Михаил', 'Дмитриевич', '964077212775', 149731708);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (27, 491, 275, 44, 'Морозов', 'Глеб', 'Давидович', '49963026820', 407728147);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (28, 152, 21, 76, 'Смирнова', 'Полина', 'Никитична', '583619086716', 650980327);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (29, 384, 18, 130, 'Сорокин', 'Даниил', 'Евгеньевич', '83444165050', 398459525);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (30, 276, 173, 195, 'Моисеев', 'Дмитрий', 'Константинович', '987428344727', 466354132);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (31, 255, 159, 229, 'Ильин', 'Денис', 'Николаевич', '654422868184', 710214226);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (32, 97, 493, 356, 'Горячева', 'София', 'Ярославовна', '174242778712', 674039817);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (33, 154, 499, 178, 'Зверев', 'Семён', 'Платонович', '259485202762', 779226007);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (34, 327, 97, 74, 'Данилова', 'Варвара', 'Артёмовна', '473719823785', 226305865);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (35, 446, 43, 340, 'Власов', 'Демид', 'Дамирович', '478506711192', 398588256);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (36, 499, 162, 149, 'Верещагина', 'Мария', 'Серафимовна', '422396624485', 263537023);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (37, 159, 355, 133, 'Зайцева', 'Александра', 'Артемьевна', '240774590859', 256192735);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (38, 162, 130, 241, 'Леонов', 'Ярослав', 'Даниилович', '409410116541', 303766881);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (39, 45, 207, 131, 'Седов', 'Владимир', 'Матвеевич', '73929753940', 572011865);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (40, 269, 202, 440, 'Савельева', 'Софья', 'Степановна', '470492404723', 297552831);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (41, 310, 124, 295, 'Фирсова', 'Мия', 'Ильинична', '383846079614', 133675522);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (42, 435, 152, 81, 'Кравцов', 'Артём', 'Маркович', '85665617005', 129317777);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (43, 247, 305, 164, 'Андреева', 'Алиса', 'Александровна', '217603791330', 485469158);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (44, 245, 116, 256, 'Авдеева', 'Александра', 'Владиславовна', '108884579738', 456246927);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (45, 390, 369, 466, 'Алексеева', 'Ева', 'Никитична', '198245004869', 636347901);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (46, 389, 224, 175, 'Алексеева', 'Дарья', 'Давидовна', '974977017829', 723942744);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (47, 182, 395, 78, 'Лавров', 'Егор', 'Иванович', '63077078956', 230864420);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (48, 304, 413, 306, 'Федоров', 'Ярослав', 'Михайлович', '911703049198', 412125172);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (49, 7, 233, 384, 'Александров', 'Егор', 'Тимофеевич', '851123967721', 420610674);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (50, 16, 315, 267, 'Спиридонов', 'Ярослав', 'Антонович', '812833456884', 488222877);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (51, 402, 430, 349, 'Хромова', 'Вероника', 'Сергеевна', '58002230770', 121597292);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (52, 82, 238, 285, 'Орлова', 'Алия', 'Васильевна', '49380992890', 401675895);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (53, 470, 71, 124, 'Климова', 'Александра', 'Егоровна', '137940058720', 734755654);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (54, 112, 467, 297, 'Черных', 'Ибрагим', 'Георгиевич', '251322815098', 221667100);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (55, 111, 66, 474, 'Захарова', 'Елизавета', 'Всеволодовна', '814907779637', 434893427);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (56, 163, 249, 368, 'Трофимов', 'Егор', 'Елисеевич', '340223579036', 791082476);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (57, 456, 162, 228, 'Старостина', 'Ангелина', 'Дмитриевна', '538585503906', 290634778);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (58, 291, 365, 451, 'Прокофьева', 'Елизавета', 'Святославовна', '391658080878', 410740495);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (59, 499, 429, 424, 'Васильева', 'Мария', 'Дмитриевна', '293772972253', 722024990);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (60, 130, 470, 73, 'Ковалев', 'Даниил', 'Иванович', '865334142331', 619917732);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (61, 265, 29, 63, 'Авдеев', 'Иван', 'Владиславович', '522032487539', 87563582);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (62, 484, 220, 435, 'Казаков', 'Максим', 'Львович', '610532073598', 152510297);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (63, 98, 43, 250, 'Волкова', 'Дарья', 'Никитична', '20605261406', 63493379);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (64, 340, 196, 388, 'Ермакова', 'Виктория', 'Фёдоровна', '141916281693', 577408554);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (65, 282, 60, 426, 'Иванов', 'Марк', 'Ильич', '841926988778', 695458466);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (66, 489, 302, 183, 'Горелова', 'Софья', 'Ярославовна', '53916616581', 637326578);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (67, 339, 418, 57, 'Ершова', 'Любовь', 'Давидовна', '801002034616', 314862955);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (68, 379, 345, 187, 'Ефимов', 'Николай', 'Кириллович', '907197199370', 177208916);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (69, 113, 270, 333, 'Павлова', 'Екатерина', 'Артёмовна', '938808407340', 478806752);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (70, 68, 432, 21, 'Кузнецов', 'Егор', 'Ильич', '405900356078', 165566062);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (71, 361, 148, 381, 'Попов', 'Давид', 'Егорович', '891178349681', 262485555);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (72, 152, 496, 413, 'Леонов', 'Ярослав', 'Даниилович', '126605049588', 507153853);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (73, 103, 165, 19, 'Денисов', 'Тимофей', 'Кириллович', '904907968051', 124946109);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (74, 314, 190, 496, 'Иванова', 'Ксения', 'Фёдоровна', '125471169818', 666700394);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (75, 137, 322, 397, 'Бобров', 'Даниил', 'Максимович', '219978144948', 684023819);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (76, 23, 350, 150, 'Сорокин', 'Даниил', 'Евгеньевич', '863241949992', 71624225);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (77, 101, 97, 485, 'Волкова', 'Василиса', 'Павловна', '501092441467', 50889279);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (78, 494, 498, 388, 'Попов', 'Андрей', 'Русланович', '254052746115', 294037136);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (79, 369, 458, 476, 'Горелов', 'Роман', 'Сергеевич', '315874690319', 363798926);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (80, 328, 8, 167, 'Беспалова', 'Варвара', 'Владиславовна', '88568239479', 750768412);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (81, 210, 23, 162, 'Попова', 'Анна', 'Артёмовна', '890287721729', 35545444);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (82, 418, 442, 360, 'Комарова', 'Алиса', 'Тимофеевна', '974710164382', 352568230);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (83, 152, 347, 447, 'Кузнецов', 'Александр', 'Иванович', '40812503617', 162009539);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (84, 226, 216, 210, 'Малышева', 'Анастасия', 'Львовна', '509291070328', 726418515);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (85, 147, 365, 134, 'Кудряшова', 'Олеся', 'Кирилловна', '410764804049', 454711622);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (86, 490, 310, 382, 'Попова', 'Алина', 'Александровна', '664087621261', 56821515);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (87, 281, 126, 167, 'Вдовина', 'Алиса', 'Александровна', '295536289425', 206176384);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (88, 397, 324, 23, 'Ковалев', 'Даниил', 'Иванович', '89305791195', 428156089);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (89, 315, 210, 345, 'Семенова', 'Ангелина', 'Александровна', '647580081049', 252975282);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (90, 239, 117, 154, 'Дубинин', 'Юрий', 'Эмирович', '42854244287', 305877861);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (91, 360, 393, 25, 'Суханов', 'Артём', 'Захарович', '416366444246', 325962148);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (92, 175, 79, 160, 'Мельникова', 'Кристина', 'Дамировна', '984031185736', 690661179);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (93, 83, 165, 193, 'Соколова', 'Полина', 'Львовна', '60293129038', 498246435);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (94, 28, 35, 119, 'Николаев', 'Фёдор', 'Николаевич', '835111545154', 704897518);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (95, 413, 111, 426, 'Леонов', 'Макар', 'Матвеевич', '634102121542', 541647105);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (96, 10, 7, 134, 'Евдокимов', 'Максим', 'Михайлович', '492396662087', 252449749);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (97, 116, 146, 352, 'Плотникова', 'Александра', 'Артёмовна', '833539217306', 455543233);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (98, 107, 364, 30, 'Григорьева', 'Анастасия', 'Романовна', '91858462203', 760124576);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (99, 115, 169, 63, 'Власова', 'Мирослава', 'Билаловна', '106911885829', 112460002);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (100, 405, 128, 102, 'Поляков', 'Вячеслав', 'Кириллович', '138307119975', 632513788);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (101, 133, 233, 463, 'Тарасов', 'Назар', 'Степанович', '514214116789', 131793325);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (102, 110, 107, 206, 'Литвинова', 'Анастасия', 'Михайловна', '443441957324', 299093376);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (103, 310, 354, 181, 'Беляев', 'Михаил', 'Михайлович', '832159227747', 363850588);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (104, 366, 380, 447, 'Иванова', 'Мария', 'Мирославовна', '153929251107', 711123791);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (105, 451, 381, 305, 'Кулагин', 'Ярослав', 'Арсентьевич', '970128154986', 175873974);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (106, 122, 172, 258, 'Скворцова', 'Мария', 'Кирилловна', '288568452629', 456288421);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (107, 116, 162, 441, 'Лобанов', 'Михаил', 'Ильич', '118683098202', 451741543);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (108, 21, 60, 395, 'Егорова', 'Софья', 'Андреевна', '342525928034', 94634378);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (109, 180, 294, 83, 'Абрамова', 'Валерия', 'Матвеевна', '329904953642', 173223595);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (110, 368, 65, 117, 'Тимофеева', 'Алия', 'Егоровна', '862233085500', 434131914);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (111, 19, 463, 426, 'Третьякова', 'София', 'Давидовна', '712039700115', 774117989);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (112, 208, 167, 355, 'Минаев', 'Савелий', 'Ярославович', '733834663523', 694556835);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (113, 99, 73, 315, 'Павловская', 'Ксения', 'Георгиевна', '199250227061', 407437318);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (114, 355, 124, 109, 'Соколова', 'Нина', 'Марковна', '419704663497', 114043464);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (115, 72, 57, 402, 'Фирсова', 'Мия', 'Ильинична', '89153615986', 738280906);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (116, 102, 46, 228, 'Еремин', 'Алексей', 'Артёмович', '677967180701', 590506009);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (117, 286, 3, 182, 'Никулина', 'Милана', 'Тимуровна', '120480356684', 198158480);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (118, 329, 5, 425, 'Иванов', 'Денис', 'Львович', '985632278330', 49530339);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (119, 71, 205, 350, 'Титов', 'Всеволод', 'Никитич', '424957703778', 300059407);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (120, 115, 33, 471, 'Широкова', 'Маргарита', 'Тимуровна', '53342578274', 410726282);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (121, 165, 260, 64, 'Сергеев', 'Константин', 'Тимофеевич', '66628401388', 551830004);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (122, 167, 77, 72, 'Лобанов', 'Михаил', 'Ильич', '814901525424', 146933299);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (123, 244, 476, 381, 'Сорокин', 'Константин', 'Артёмович', '426301557002', 237226962);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (124, 347, 437, 310, 'Волкова', 'Василиса', 'Павловна', '408907658693', 310572568);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (125, 108, 166, 120, 'Егорова', 'Любовь', 'Михайловна', '315609449378', 630103156);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (126, 254, 128, 230, 'Воробьев', 'Даниил', 'Арсентьевич', '808085356726', 605434054);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (127, 287, 500, 497, 'Шульгина', 'Виктория', 'Петровна', '252026180433', 262589170);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (128, 297, 447, 96, 'Соловьев', 'Степан', 'Анатольевич', '623436412615', 585896304);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (129, 193, 332, 38, 'Захарова', 'Полина', 'Георгиевна', '256500205671', 252448702);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (130, 84, 84, 33, 'Захаров', 'Дмитрий', 'Александрович', '408360302663', 213960033);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (131, 394, 480, 192, 'Руднева', 'Наталья', 'Владимировна', '518832292241', 579120537);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (132, 337, 163, 427, 'Филатов', 'Степан', 'Иванович', '288589857486', 389543023);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (133, 345, 266, 213, 'Ковалев', 'Александр', 'Германович', '578547499026', 343802304);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (134, 452, 153, 322, 'Никитин', 'Михаил', 'Артёмович', '34829192929', 321478029);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (135, 149, 262, 132, 'Абрамова', 'Варвара', 'Захаровна', '279683525683', 660973604);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (136, 250, 208, 436, 'Жуков', 'Алексей', 'Дмитриевич', '148680783668', 342159056);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (137, 448, 210, 78, 'Сычева', 'Полина', 'Фёдоровна', '741553667502', 520692325);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (138, 28, 1, 85, 'Шапошников', 'Марк', 'Даниилович', '195964823623', 145828461);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (139, 54, 428, 393, 'Лазарева', 'Амина', 'Филипповна', '189030666135', 400836829);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (140, 451, 35, 353, 'Киреева', 'Ника', 'Андреевна', '315599417243', 464022763);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (141, 79, 430, 11, 'Королев', 'Егор', 'Адамович', '155800733678', 138218125);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (142, 127, 71, 75, 'Кондрашов', 'Константин', 'Дамирович', '233221876525', 367410496);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (143, 325, 30, 200, 'Колпакова', 'Эвелина', 'Юрьевна', '135786072681', 336056614);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (144, 226, 290, 490, 'Нечаев', 'Леон', 'Борисович', '504456031303', 675684754);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (145, 358, 307, 328, 'Дубинин', 'Юрий', 'Эмирович', '299931775222', 669984461);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (146, 436, 91, 295, 'Ермакова', 'Виктория', 'Савельевна', '225790594819', 155814522);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (147, 218, 328, 371, 'Попова', 'София', 'Кирилловна', '258447492294', 678121551);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (148, 495, 414, 443, 'Андреева', 'Маргарита', 'Николаевна', '157514016400', 523927794);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (149, 327, 435, 285, 'Митрофанов', 'Александр', 'Денисович', '644884788228', 311456305);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (150, 413, 245, 388, 'Кондратьева', 'Агата', 'Максимовна', '6589438522', 722502204);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (151, 322, 301, 200, 'Котов', 'Макар', 'Лукич', '385342636511', 29852024);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (152, 267, 241, 233, 'Калинина', 'Полина', 'Никитична', '476827506406', 387521522);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (153, 489, 125, 489, 'Дубинин', 'Юрий', 'Эмирович', '345131628456', 676063010);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (154, 168, 299, 121, 'Ефимов', 'Михаил', 'Владиславович', '466109186052', 251469686);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (155, 454, 81, 276, 'Александров', 'Матвей', 'Дмитриевич', '660050570943', 533092473);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (156, 311, 451, 431, 'Воробьев', 'Всеволод', 'Романович', '232940060810', 84129889);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (157, 175, 405, 276, 'Карасев', 'Тимур', 'Ярославович', '40409725865', 215776891);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (158, 194, 312, 201, 'Кожевникова', 'Дарья', 'Ильинична', '400101575564', 291757018);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (159, 110, 144, 341, 'Суворова', 'Софья', 'Григорьевна', '994527141763', 449759781);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (160, 281, 196, 54, 'Горохов', 'Иван', 'Макарович', '343739439099', 252078837);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (161, 278, 485, 163, 'Матвеева', 'Майя', 'Фёдоровна', '251460381068', 642433986);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (162, 238, 444, 321, 'Павловский', 'Лука', 'Андреевич', '819217048732', 729223978);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (163, 193, 187, 377, 'Михайлова', 'Елизавета', 'Фёдоровна', '932284727841', 218665281);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (164, 349, 344, 416, 'Еремин', 'Алексей', 'Артёмович', '595366223429', 36206897);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (165, 265, 118, 171, 'Волкова', 'Дарина', 'Дмитриевна', '398854201976', 184446548);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (166, 38, 434, 480, 'Нечаева', 'Аиша', 'Артёмовна', '734527928437', 636771550);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (167, 278, 336, 268, 'Серова', 'Дарья', 'Богдановна', '556619566457', 658521695);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (168, 222, 56, 211, 'Павлова', 'Елизавета', 'Владимировна', '193953273665', 644082078);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (169, 394, 57, 323, 'Волкова', 'Василиса', 'Павловна', '477940248105', 350181065);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (170, 269, 183, 199, 'Голубев', 'Никита', 'Максимович', '933073533098', 485960180);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (171, 377, 358, 500, 'Сазонов', 'Кирилл', 'Иванович', '162495457373', 355241447);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (172, 137, 101, 427, 'Суханов', 'Артём', 'Захарович', '378090915780', 310494877);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (173, 55, 10, 109, 'Руднев', 'Лука', 'Иванович', '589936909081', 228602212);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (174, 483, 342, 37, 'Мартынова', 'Мария', 'Сергеевна', '590065460263', 260702272);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (175, 196, 10, 303, 'Горелов', 'Глеб', 'Робертович', '394603288866', 698046306);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (176, 110, 441, 306, 'Дегтярев', 'Егор', 'Платонович', '711853701795', 202805455);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (177, 441, 126, 247, 'Маркова', 'Дарья', 'Кирилловна', '152998918742', 764322918);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (178, 437, 241, 461, 'Игнатов', 'Владимир', 'Тимофеевич', '969034802763', 287311266);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (179, 455, 332, 490, 'Данилов', 'Лука', 'Антонович', '4503116923', 294123103);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (180, 355, 419, 256, 'Иванова', 'Дарья', 'Владиславовна', '467098465623', 712008645);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (181, 272, 208, 362, 'Алексеева', 'Майя', 'Александровна', '958472910667', 132678199);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (182, 500, 300, 251, 'Фетисова', 'Ксения', 'Степановна', '396448519298', 674791396);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (183, 199, 242, 251, 'Карпова', 'Алиса', 'Фёдоровна', '715012217942', 149442880);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (184, 107, 366, 253, 'Шапошников', 'Марк', 'Даниилович', '142759705143', 601143173);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (185, 15, 376, 153, 'Никитина', 'Ева', 'Ивановна', '774752658407', 81290422);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (186, 283, 190, 383, 'Соловьев', 'Михаил', 'Максимович', '107451992811', 528682057);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (187, 336, 471, 60, 'Савельева', 'Анастасия', 'Романовна', '809535120332', 59538350);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (188, 266, 40, 185, 'Константинов', 'Демид', 'Никитич', '285853558530', 28359601);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (189, 141, 442, 132, 'Поляков', 'Вячеслав', 'Кириллович', '751286226263', 618582027);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (190, 190, 177, 46, 'Морозова', 'Александра', 'Саввична', '618004156207', 706325041);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (191, 403, 484, 106, 'Спиридонов', 'Демид', 'Елисеевич', '126880094949', 416766649);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (192, 189, 258, 217, 'Денисов', 'Александр', 'Платонович', '434561665022', 47956964);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (193, 210, 370, 281, 'Федотов', 'Дмитрий', 'Тимофеевич', '147950296977', 521466973);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (194, 227, 348, 10, 'Кулагин', 'Ярослав', 'Арсентьевич', '570314833757', 570818523);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (195, 73, 441, 325, 'Бурова', 'София', 'Степановна', '941879801785', 499314266);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (196, 361, 105, 408, 'Соколов', 'Лука', 'Владиславович', '432138137534', 140822591);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (197, 178, 481, 158, 'Тимофеев', 'Андрей', 'Даниилович', '815174924009', 765048617);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (198, 472, 397, 499, 'Сизова', 'Анна', 'Артёмовна', '487554265542', 345251579);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (199, 491, 321, 52, 'Федорова', 'Екатерина', 'Львовна', '771649099051', 472988730);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (200, 27, 59, 348, 'Ершова', 'Любовь', 'Давидовна', '627709346307', 651329048);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (201, 324, 40, 450, 'Волкова', 'Александра', 'Глебовна', '151412348647', 381901540);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (202, 29, 466, 7, 'Федорова', 'Варвара', 'Матвеевна', '16095841090', 418702281);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (203, 318, 446, 330, 'Орлова', 'Алия', 'Васильевна', '864081879781', 167048045);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (204, 370, 471, 45, 'Иванов', 'Денис', 'Львович', '450781454800', 768725970);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (205, 52, 235, 225, 'Зуев', 'Андрей', 'Михайлович', '543356992938', 760245067);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (206, 462, 111, 200, 'Ермаков', 'Ярослав', 'Михайлович', '452602110444', 737600677);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (207, 450, 247, 84, 'Жуков', 'Марк', 'Маркович', '616442682853', 329932250);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (208, 57, 165, 385, 'Гончарова', 'Милана', 'Викторовна', '604632480459', 129466575);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (209, 308, 231, 143, 'Семенов', 'Марк', 'Матвеевич', '265829573145', 147930667);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (210, 301, 465, 439, 'Спиридонов', 'Ярослав', 'Антонович', '990600350579', 730288351);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (211, 254, 380, 224, 'Шубин', 'Денис', 'Александрович', '481062877141', 336469085);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (212, 444, 337, 32, 'Сальников', 'Тимур', 'Иванович', '302247211976', 39052623);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (213, 441, 92, 399, 'Измайлова', 'Анна', 'Давидовна', '178105298159', 272398366);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (214, 465, 149, 62, 'Кулагин', 'Ярослав', 'Арсентьевич', '156827630893', 346237683);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (215, 462, 346, 65, 'Морозов', 'Александр', 'Андреевич', '653196716974', 630711039);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (216, 264, 350, 392, 'Малахова', 'Надежда', 'Михайловна', '670729007386', 586139792);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (217, 202, 338, 220, 'Новиков', 'Михаил', 'Ильич', '367241004658', 431940843);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (218, 321, 281, 61, 'Климова', 'Александра', 'Егоровна', '667530073225', 58725543);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (219, 391, 442, 156, 'Евдокимов', 'Максим', 'Михайлович', '381788240194', 428543677);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (220, 249, 160, 383, 'Евдокимова', 'Александра', 'Георгиевна', '797977405857', 479302514);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (221, 294, 327, 55, 'Давыдов', 'Дмитрий', 'Матвеевич', '6068240872', 256794290);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (222, 258, 276, 408, 'Акимова', 'Кира', 'Марковна', '343498292033', 77418489);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (223, 228, 197, 294, 'Колесников', 'Егор', 'Гордеевич', '665218430051', 114113808);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (224, 266, 476, 254, 'Дегтярев', 'Адам', 'Антонович', '963011506182', 758507690);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (225, 77, 353, 123, 'Малышева', 'Ева', 'Тихоновна', '24102639565', 672967821);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (226, 211, 87, 176, 'Парамонов', 'Константин', 'Михайлович', '524635456984', 161836099);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (227, 350, 326, 323, 'Краснова', 'Амина', 'Леонидовна', '559914630711', 623740300);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (228, 216, 136, 121, 'Васильев', 'Тимофей', 'Николаевич', '871743438868', 358044837);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (229, 176, 482, 228, 'Рожкова', 'Елизавета', 'Тихоновна', '861367241642', 109257772);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (230, 133, 487, 352, 'Белова', 'Анастасия', 'Егоровна', '402883797492', 181391496);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (231, 204, 499, 267, 'Виноградов', 'Иван', 'Егорович', '410734555189', 683487406);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (232, 152, 384, 305, 'Ларионов', 'Максим', 'Артёмович', '862834558919', 291121947);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (233, 61, 436, 111, 'Яковлева', 'Дарья', 'Денисовна', '345074982761', 27889324);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (234, 312, 215, 57, 'Агеев', 'Максим', 'Маркович', '722649637276', 112375850);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (235, 196, 211, 472, 'Никулин', 'Константин', 'Павлович', '730848978472', 224698556);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (236, 364, 312, 375, 'Емельянов', 'Максим', 'Ярославович', '282593633887', 291491850);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (237, 429, 462, 250, 'Ситникова', 'Татьяна', 'Алиевна', '235311840815', 432334837);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (238, 279, 285, 141, 'Крылова', 'Вероника', 'Денисовна', '832958588192', 546140109);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (239, 479, 14, 389, 'Завьялов', 'Даниил', 'Львович', '357883540527', 166176461);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (240, 40, 496, 254, 'Березин', 'Мирон', 'Михайлович', '604419468402', 540520474);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (241, 157, 240, 492, 'Глушкова', 'Алиса', 'Романовна', '802375938083', 721593499);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (242, 354, 33, 494, 'Савельева', 'Сабина', 'Саввична', '348214562468', 339408225);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (243, 16, 21, 14, 'Егорова', 'Полина', 'Константиновна', '518736767981', 26504998);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (244, 207, 5, 250, 'Ершова', 'Злата', 'Андреевна', '415961544217', 80169732);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (245, 365, 364, 467, 'Горюнов', 'Валерий', 'Олегович', '603827997960', 552436325);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (246, 307, 325, 363, 'Анисимова', 'Василиса', 'Александровна', '704437130811', 418874604);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (247, 112, 419, 478, 'Смирнова', 'Зоя', 'Егоровна', '799904059877', 316989573);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (248, 87, 293, 72, 'Иванов', 'Александр', 'Михайлович', '834353292000', 388466142);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (249, 354, 98, 145, 'Сидоров', 'Артём', 'Кириллович', '369813815908', 215850314);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (250, 169, 439, 401, 'Смирнова', 'Елизавета', 'Алиевна', '888956965636', 224481374);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (251, 394, 256, 432, 'Щербаков', 'Тимофей', 'Сергеевич', '892653530618', 781022381);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (252, 317, 286, 272, 'Дубровина', 'Маргарита', 'Данииловна', '794541569410', 289432265);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (253, 118, 334, 192, 'Егорова', 'Мадина', 'Георгиевна', '589320310097', 243265517);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (254, 342, 208, 276, 'Тимофеев', 'Андрей', 'Даниилович', '214707089521', 743389933);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (255, 406, 10, 67, 'Савельев', 'Александр', 'Дмитриевич', '51229292175', 384125937);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (256, 111, 13, 432, 'Сидоров', 'Илья', 'Тимофеевич', '35974343071', 276165687);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (257, 483, 36, 161, 'Кондратьева', 'Ева', 'Вадимовна', '273288338851', 529419872);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (258, 63, 17, 239, 'Лавров', 'Егор', 'Иванович', '23353337224', 129026877);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (259, 262, 447, 359, 'Зеленин', 'Александр', 'Александрович', '327492713978', 382102804);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (260, 126, 309, 321, 'Блинова', 'Амина', 'Егоровна', '814450605547', 596736047);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (261, 96, 149, 62, 'Панина', 'Марина', 'Владиславовна', '977085280819', 349924665);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (262, 237, 392, 209, 'Касьянов', 'Максим', 'Филиппович', '14352443110', 583553086);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (263, 107, 181, 307, 'Леонов', 'Владимир', 'Михайлович', '144243854179', 247927835);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (264, 471, 93, 238, 'Михайлов', 'Матвей', 'Сергеевич', '814200051721', 528035257);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (265, 288, 354, 391, 'Михайлов', 'Адам', 'Александрович', '95358103964', 698896051);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (266, 74, 447, 108, 'Зверев', 'Семён', 'Платонович', '337299727550', 528554958);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (267, 34, 473, 192, 'Волкова', 'Дарина', 'Дмитриевна', '652122149712', 222843677);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (268, 276, 491, 424, 'Ершова', 'София', 'Александровна', '992115097936', 424944941);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (269, 81, 5, 188, 'Смирнова', 'Мария', 'Павловна', '998809110778', 133891945);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (270, 343, 476, 90, 'Дьяконов', 'Алексей', 'Павлович', '676862239481', 623439202);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (271, 447, 112, 403, 'Смирнова', 'Анна', 'Глебовна', '451021790978', 374889488);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (272, 456, 491, 14, 'Матвеев', 'Иван', 'Алексеевич', '658049791571', 699577577);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (273, 353, 49, 450, 'Емельянов', 'Максим', 'Ярославович', '377278956173', 567604319);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (274, 374, 260, 473, 'Морозова', 'Александра', 'Саввична', '794510501413', 89898309);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (275, 340, 354, 158, 'Власова', 'Вероника', 'Степановна', '904397189756', 576028836);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (276, 10, 354, 459, 'Борисова', 'Александра', 'Максимовна', '584798004590', 111026248);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (277, 62, 89, 387, 'Балашов', 'Владимир', 'Алексеевич', '352644027010', 400696652);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (278, 50, 121, 293, 'Савельева', 'Карина', 'Петровна', '61028879188', 26402970);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (279, 454, 370, 174, 'Лебедева', 'Милана', 'Евгеньевна', '543077051284', 453436267);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (280, 499, 200, 486, 'Зайцев', 'Фёдор', 'Егорович', '959038812541', 371987737);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (281, 156, 163, 21, 'Мельников', 'Елисей', 'Русланович', '696386093974', 664445080);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (282, 259, 249, 438, 'Софронов', 'Владимир', 'Андреевич', '894014339593', 413202166);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (283, 220, 115, 269, 'Михайлов', 'Максим', 'Иванович', '194231718398', 691275264);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (284, 335, 482, 67, 'Лаптев', 'Фёдор', 'Дмитриевич', '98900558044', 548732262);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (285, 364, 85, 248, 'Павлов', 'Иван', 'Максимович', '272676086321', 727095011);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (286, 242, 204, 233, 'Бобров', 'Даниил', 'Максимович', '473104365410', 504593227);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (287, 318, 171, 64, 'Горохов', 'Егор', 'Иванович', '486068476472', 698941322);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (288, 363, 229, 104, 'Ершова', 'София', 'Александровна', '718817132708', 529563247);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (289, 248, 105, 14, 'Жукова', 'Алиса', 'Львовна', '68203485006', 399515866);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (290, 193, 380, 444, 'Спиридонов', 'Лев', 'Маркович', '958449471645', 435515971);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (291, 329, 480, 488, 'Попова', 'Мария', 'Тимуровна', '915765534871', 365121023);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (292, 201, 227, 495, 'Малахова', 'Надежда', 'Михайловна', '816644168857', 573986350);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (293, 297, 183, 221, 'Тихомирова', 'Алиса', 'Вадимовна', '20835565594', 127186112);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (294, 197, 155, 500, 'Кондратьева', 'Мария', 'Дмитриевна', '572845728573', 652429563);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (295, 194, 474, 94, 'Зайцев', 'Тимофей', 'Марсельевич', '827989377098', 46576772);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (296, 267, 26, 81, 'Артемова', 'Анна', 'Глебовна', '437786614229', 754713519);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (297, 335, 474, 234, 'Лаптев', 'Фёдор', 'Дмитриевич', '455043070365', 780286941);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (298, 497, 491, 89, 'Власова', 'Анна', 'Демидовна', '619748400928', 645517515);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (299, 122, 452, 352, 'Федотов', 'Артём', 'Мирославович', '166935655839', 794172761);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (300, 391, 265, 206, 'Леонова', 'Арина', 'Кирилловна', '408924382456', 284697025);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (301, 4, 493, 312, 'Яковлев', 'Сергей', 'Львович', '592631503166', 156555039);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (302, 382, 199, 78, 'Аксенов', 'Александр', 'Антонович', '796779222786', 530508059);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (303, 212, 205, 413, 'Алексеев', 'Платон', 'Степанович', '389531555143', 314676451);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (304, 345, 490, 105, 'Константинов', 'Алексей', 'Львович', '475467862302', 481545314);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (305, 97, 381, 433, 'Киселев', 'Артём', 'Петрович', '254196887626', 543358309);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (306, 377, 92, 2, 'Плотникова', 'Мария', 'Артёмовна', '451918066280', 553419576);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (307, 310, 301, 217, 'Прокофьева', 'Елизавета', 'Святославовна', '2991389922', 270002971);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (308, 243, 264, 285, 'Малышева', 'Анастасия', 'Львовна', '33914099554', 742983418);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (309, 478, 17, 53, 'Моисеев', 'Арсений', 'Андреевич', '168695623423', 604838673);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (310, 170, 33, 24, 'Козлова', 'Мария', 'Степановна', '330706162565', 621598244);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (311, 299, 175, 209, 'Куприянова', 'Есения', 'Александровна', '762677120386', 372718404);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (312, 299, 100, 270, 'Семенов', 'Леонид', 'Артёмович', '382224772826', 78729364);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (313, 354, 68, 447, 'Ершов', 'Иван', 'Вячеславович', '416283299169', 400395289);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (314, 164, 310, 308, 'Воробьева', 'Таисия', 'Данииловна', '456038248032', 224209665);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (315, 285, 488, 364, 'Макарова', 'Елизавета', 'Германовна', '210426154675', 195236849);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (316, 467, 299, 105, 'Маркова', 'Василиса', 'Матвеевна', '568917525849', 747816519);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (317, 76, 236, 25, 'Орлов', 'Владислав', 'Арсентьевич', '415150281470', 174982478);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (318, 60, 165, 340, 'Осипова', 'Алиса', 'Данииловна', '785703294970', 741542013);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (319, 372, 28, 456, 'Алексеева', 'Ева', 'Никитична', '384412470244', 420901772);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (320, 63, 69, 139, 'Чижова', 'Виктория', 'Олеговна', '374546727919', 504882197);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (321, 133, 43, 409, 'Пономарева', 'Софья', 'Романовна', '609736772076', 795839370);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (322, 102, 90, 256, 'Мешков', 'Иван', 'Эминович', '67702952476', 433764485);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (323, 125, 419, 322, 'Рыбаков', 'Матвей', 'Серафимович', '249741806030', 386788188);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (324, 493, 83, 484, 'Сычева', 'Василиса', 'Данииловна', '171036784288', 154913135);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (325, 474, 485, 25, 'Лапин', 'Марк', 'Константинович', '217900682292', 787096996);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (326, 342, 476, 338, 'Сергеев', 'Константин', 'Тимофеевич', '338583864824', 638517747);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (327, 387, 414, 67, 'Савельева', 'Анастасия', 'Романовна', '833191556509', 606322694);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (328, 183, 414, 29, 'Соколова', 'Ксения', 'Артёмовна', '196629898275', 121481112);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (329, 307, 197, 388, 'Федорова', 'Александра', 'Георгиевна', '143124782977', 168221541);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (330, 354, 274, 307, 'Кудряшов', 'Александр', 'Константинович', '400764901414', 207953027);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (331, 260, 444, 359, 'Григорьева', 'Злата', 'Данииловна', '244601599379', 326492572);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (332, 482, 43, 27, 'Митрофанов', 'Александр', 'Денисович', '446483450834', 717683541);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (333, 408, 279, 199, 'Мартынова', 'Мария', 'Сергеевна', '297309865814', 488870665);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (334, 84, 225, 18, 'Селиванов', 'Юрий', 'Владимирович', '672621629787', 68841644);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (335, 53, 89, 189, 'Кузнецова', 'Анна', 'Кирилловна', '969329340558', 511030763);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (336, 255, 11, 348, 'Павлова', 'Екатерина', 'Артёмовна', '789730108965', 306186766);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (337, 401, 454, 364, 'Ершова', 'София', 'Мироновна', '782524032552', 685818603);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (338, 264, 231, 50, 'Алексеева', 'Анна', 'Богдановна', '832323260938', 567653818);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (339, 220, 490, 164, 'Петров', 'Фёдор', 'Викторович', '954705759515', 678294492);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (340, 358, 248, 383, 'Золотарева', 'Арина', 'Робертовна', '406080650208', 656106506);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (341, 283, 122, 284, 'Колесова', 'Яна', 'Мироновна', '816775886944', 272620252);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (342, 97, 248, 357, 'Щербакова', 'Кира', 'Константиновна', '339318757361', 578775130);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (343, 462, 493, 385, 'Мальцева', 'Мария', 'Олеговна', '227914847427', 246922502);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (344, 284, 259, 410, 'Тимофеев', 'Денис', 'Егорович', '628436101949', 703859000);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (345, 248, 280, 183, 'Макарова', 'Виктория', 'Григорьевна', '314009847168', 435252567);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (346, 38, 359, 121, 'Ефимов', 'Николай', 'Кириллович', '335362896066', 347966900);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (347, 278, 378, 426, 'Быкова', 'Алиса', 'Максимовна', '933321119537', 518300537);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (348, 421, 277, 267, 'Старостина', 'Ангелина', 'Дмитриевна', '880219509821', 291840476);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (349, 105, 107, 251, 'Жданов', 'Максим', 'Романович', '113045800093', 727970182);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (350, 491, 358, 69, 'Никулина', 'Милана', 'Тимуровна', '55653460450', 354154926);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (351, 391, 483, 257, 'Громов', 'Алексей', 'Фёдорович', '733654888768', 421090751);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (352, 133, 322, 402, 'Никитин', 'Михаил', 'Сергеевич', '408596133392', 793770098);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (353, 100, 225, 276, 'Юдин', 'Артём', 'Денисович', '227396213505', 712845759);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (354, 50, 491, 419, 'Щукина', 'Евдокия', 'Михайловна', '714572445972', 661455575);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (355, 430, 452, 186, 'Елизаров', 'Никита', 'Артёмович', '47598553190', 106446721);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (356, 472, 142, 274, 'Захарова', 'Елизавета', 'Всеволодовна', '621530761522', 63805631);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (357, 353, 76, 128, 'Коршунов', 'Егор', 'Дмитриевич', '439740988533', 234416134);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (358, 276, 454, 19, 'Карасева', 'Таисия', 'Денисовна', '418552486091', 270522216);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (359, 476, 470, 100, 'Сизова', 'Анна', 'Артёмовна', '936218748798', 246323161);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (360, 191, 230, 94, 'Кузнецов', 'Александр', 'Иванович', '302853693027', 152226113);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (361, 489, 69, 46, 'Баженов', 'Савелий', 'Матвеевич', '687815024790', 192726802);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (362, 10, 410, 477, 'Селиванов', 'Матвей', 'Сергеевич', '461037122254', 282187648);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (363, 324, 69, 70, 'Тарасов', 'Владимир', 'Степанович', '83013062712', 268070196);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (364, 364, 150, 98, 'Комарова', 'Дарья', 'Артёмовна', '330940902973', 649144642);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (365, 126, 111, 247, 'Попов', 'Давид', 'Егорович', '993098623346', 665034682);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (366, 388, 292, 231, 'Осипова', 'Сафия', 'Данииловна', '410958123479', 294385701);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (367, 10, 174, 126, 'Беляков', 'Иван', 'Алексеевич', '285202842721', 201274125);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (368, 308, 196, 103, 'Макарова', 'Виктория', 'Григорьевна', '779812248811', 164146159);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (369, 456, 310, 489, 'Вешняков', 'Макар', 'Максимович', '986990710503', 318663952);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (370, 7, 300, 479, 'Басов', 'Даниил', 'Семёнович', '703359073051', 341491583);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (371, 442, 394, 173, 'Захаров', 'Роман', 'Кириллович', '452459657778', 516993670);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (372, 22, 491, 185, 'Быкова', 'Алиса', 'Максимовна', '244697811947', 434864487);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (373, 265, 320, 3, 'Михайлов', 'Адам', 'Александрович', '77360541055', 126622994);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (374, 33, 1, 320, 'Александров', 'Егор', 'Тимофеевич', '581777642139', 256709469);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (375, 295, 496, 1, 'Захарова', 'Екатерина', 'Георгиевна', '538018789437', 757267531);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (376, 492, 343, 141, 'Гусев', 'Егор', 'Денисович', '912278447291', 321982776);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (377, 60, 2, 155, 'Карпова', 'Алиса', 'Фёдоровна', '359874876410', 289190724);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (378, 373, 2, 468, 'Матвеева', 'Екатерина', 'Вячеславовна', '395556037794', 750702438);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (379, 247, 169, 383, 'Малышева', 'Ева', 'Тихоновна', '251428591664', 69090219);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (380, 148, 225, 492, 'Романова', 'Мирослава', 'Гордеевна', '706415186158', 364637994);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (381, 158, 10, 255, 'Трофимов', 'Егор', 'Елисеевич', '802204593639', 450235553);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (382, 477, 48, 271, 'Григорьев', 'Артём', 'Максимович', '479489624606', 82932615);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (383, 289, 248, 225, 'Старостина', 'Алина', 'Андреевна', '375780008781', 421192612);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (384, 213, 475, 265, 'Борисов', 'Артём', 'Игоревич', '61518804649', 750345908);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (385, 149, 218, 296, 'Королев', 'Иван', 'Артёмович', '926735759277', 692876279);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (386, 354, 133, 286, 'Ларин', 'Артём', 'Ярославович', '60642415316', 680089734);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (387, 90, 92, 208, 'Власова', 'Анна', 'Демидовна', '595635072435', 245322356);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (388, 301, 116, 208, 'Руднева', 'Наталья', 'Владимировна', '106073123646', 792361451);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (389, 401, 83, 56, 'Кошелева', 'Марьяна', 'Александровна', '505054802762', 651024390);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (390, 449, 411, 276, 'Александров', 'Матвей', 'Дмитриевич', '497807169159', 615745376);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (391, 274, 58, 150, 'Исаков', 'Михаил', 'Евгеньевич', '388832033754', 382108586);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (392, 418, 167, 468, 'Кожевникова', 'Дарья', 'Ильинична', '251632895588', 230776666);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (393, 355, 134, 91, 'Уткин', 'Константин', 'Артёмович', '182305048843', 23924905);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (394, 273, 235, 283, 'Краснова', 'София', 'Арсентьевна', '414707619326', 656033061);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (395, 425, 141, 496, 'Гончарова', 'Милана', 'Викторовна', '656746282371', 667632283);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (396, 65, 443, 53, 'Щербаков', 'Тимофей', 'Сергеевич', '551109629151', 146039577);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (397, 172, 387, 476, 'Соловьева', 'Зоя', 'Романовна', '583460766688', 765384686);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (398, 291, 151, 125, 'Тарасов', 'Назар', 'Степанович', '132467807783', 512995371);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (399, 110, 35, 456, 'Мальцев', 'Василий', 'Ярославович', '67559152620', 593886101);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (400, 126, 157, 158, 'Винокуров', 'Василий', 'Михайлович', '866951532015', 96586613);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (401, 33, 458, 493, 'Бондарева', 'Маргарита', 'Александровна', '599456768107', 241810874);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (402, 166, 475, 169, 'Титов', 'Всеволод', 'Никитич', '752899099585', 537532013);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (403, 367, 393, 487, 'Горелов', 'Роман', 'Сергеевич', '612886911035', 426666015);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (404, 292, 257, 3, 'Григорьева', 'Виктория', 'Сергеевна', '642245483055', 82384052);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (405, 431, 426, 455, 'Попов', 'Давид', 'Егорович', '468174000386', 749732935);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (406, 182, 134, 180, 'Никитин', 'Михаил', 'Сергеевич', '37358392887', 161546446);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (407, 160, 293, 23, 'Ермаков', 'Ярослав', 'Михайлович', '292932646579', 388565702);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (408, 426, 268, 160, 'Сергеев', 'Константин', 'Тимофеевич', '736703714661', 266527414);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (409, 51, 351, 206, 'Васильев', 'Андрей', 'Львович', '79057920817', 517558583);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (410, 350, 286, 353, 'Сидорова', 'София', 'Ярославовна', '857661193916', 364800818);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (411, 360, 432, 317, 'Петухов', 'Тимофей', 'Михайлович', '295690150618', 636807912);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (412, 157, 398, 478, 'Егоров', 'Даниил', 'Романович', '504876509363', 157086658);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (413, 436, 167, 445, 'Захаров', 'Николай', 'Константинович', '937955245305', 232585940);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (414, 338, 112, 108, 'Сорокин', 'Константин', 'Артёмович', '59807709006', 710691495);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (415, 7, 398, 337, 'Гончаров', 'Фёдор', 'Никитич', '958961286487', 190904913);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (416, 72, 118, 104, 'Селиванов', 'Юрий', 'Владимирович', '841823212996', 371085301);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (417, 455, 347, 50, 'Рожкова', 'Елизавета', 'Тихоновна', '822598258532', 32429013);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (418, 159, 488, 173, 'Мальцев', 'Александр', 'Леонидович', '707546394053', 368261693);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (419, 134, 345, 33, 'Белкина', 'София', 'Тиграновна', '812454559791', 588960655);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (420, 331, 289, 255, 'Кондрашов', 'Константин', 'Дамирович', '632329007675', 188454189);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (421, 446, 82, 414, 'Уткин', 'Константин', 'Артёмович', '613233347124', 542753660);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (422, 353, 89, 500, 'Высоцкая', 'Евангелина', 'Александровна', '933771794674', 319345416);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (423, 8, 468, 385, 'Козлова', 'София', 'Фёдоровна', '631804281019', 478924566);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (424, 263, 180, 233, 'Соболева', 'Полина', 'Данииловна', '181914929996', 678488434);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (425, 476, 35, 100, 'Константинов', 'Демид', 'Никитич', '232400581417', 262278601);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (426, 214, 324, 301, 'Головина', 'Мария', 'Мартиновна', '313044153138', 224027434);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (427, 288, 331, 299, 'Федоров', 'Ярослав', 'Михайлович', '202266790737', 220717365);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (428, 289, 332, 373, 'Леонов', 'Александр', 'Егорович', '259288216187', 743396755);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (429, 245, 429, 302, 'Виноградова', 'Арина', 'Артуровна', '842741939176', 111712306);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (430, 143, 177, 353, 'Власова', 'Мирослава', 'Билаловна', '214606855357', 304349203);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (431, 176, 359, 108, 'Фролова', 'Василиса', 'Вадимовна', '771208175549', 205812183);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (432, 46, 179, 83, 'Добрынина', 'Лидия', 'Фёдоровна', '823212157434', 750755820);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (433, 475, 46, 65, 'Морозова', 'Александра', 'Саввична', '870561702649', 618348217);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (434, 491, 465, 23, 'Ларионов', 'Максим', 'Артёмович', '428624735590', 457096664);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (435, 272, 129, 480, 'Кошелева', 'Марьяна', 'Александровна', '58948796157', 556589401);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (436, 355, 320, 430, 'Королев', 'Егор', 'Адамович', '191996819198', 279574959);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (437, 316, 129, 424, 'Акимова', 'Кира', 'Марковна', '872633081038', 637837974);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (438, 300, 101, 367, 'Васильева', 'Елена', 'Артёмовна', '395572488859', 758738788);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (439, 156, 354, 379, 'Григорьева', 'Виктория', 'Сергеевна', '642779483050', 140519244);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (440, 476, 84, 178, 'Кочеткова', 'Валентина', 'Артёмовна', '828720293880', 267054432);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (441, 237, 462, 477, 'Плотникова', 'Александра', 'Артёмовна', '159142292353', 114704344);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (442, 22, 383, 314, 'Калинина', 'Полина', 'Никитична', '999415413456', 74705755);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (443, 343, 376, 412, 'Герасимова', 'Василиса', 'Ивановна', '320594001030', 308081462);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (444, 460, 160, 69, 'Максимов', 'Артём', 'Дмитриевич', '62483105765', 131442682);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (445, 352, 287, 51, 'Казанцева', 'Полина', 'Ильинична', '444321961196', 87182465);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (446, 277, 66, 369, 'Поляков', 'Вячеслав', 'Кириллович', '366647180938', 83188953);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (447, 264, 75, 271, 'Артемова', 'Анна', 'Глебовна', '51374649473', 690958749);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (448, 288, 37, 247, 'Королева', 'Василиса', 'Ивановна', '273819982209', 194159170);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (449, 114, 185, 248, 'Петров', 'Семён', 'Максимович', '975257797252', 388155232);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (450, 115, 228, 362, 'Семенов', 'Марк', 'Матвеевич', '154277334185', 798787195);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (451, 377, 375, 264, 'Николаева', 'Кристина', 'Игоревна', '704599356845', 332194106);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (452, 400, 188, 43, 'Ситникова', 'Татьяна', 'Алиевна', '874129907018', 456342191);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (453, 405, 381, 251, 'Зайцев', 'Макар', 'Ярославович', '505671106885', 657704090);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (454, 277, 114, 188, 'Руднева', 'Наталья', 'Владимировна', '856066501830', 655144385);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (455, 375, 209, 114, 'Власов', 'Владимир', 'Матвеевич', '426257993848', 639737356);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (456, 376, 196, 172, 'Ермаков', 'Андрей', 'Иванович', '111501662264', 149965843);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (457, 165, 409, 73, 'Щербакова', 'Елизавета', 'Кирилловна', '943126191711', 190971070);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (458, 478, 352, 139, 'Николаев', 'Михаил', 'Миронович', '263382328468', 58262231);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (459, 448, 195, 38, 'Сычева', 'Амина', 'Фёдоровна', '464332441058', 607730205);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (460, 352, 148, 410, 'Гончаров', 'Илья', 'Савельевич', '398952237778', 520499675);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (461, 257, 438, 460, 'Семенов', 'Марк', 'Матвеевич', '962861992938', 670190846);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (462, 345, 261, 109, 'Кудряшов', 'Александр', 'Константинович', '866007797047', 88395803);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (463, 380, 256, 358, 'Романова', 'Мирослава', 'Гордеевна', '543071054848', 414814785);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (464, 83, 145, 196, 'Николаева', 'София', 'Артёмовна', '663010535151', 709701312);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (465, 183, 363, 219, 'Суворова', 'Софья', 'Григорьевна', '119373177246', 764734425);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (466, 142, 10, 311, 'Львов', 'Игорь', 'Алексеевич', '870306943447', 532952887);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (467, 223, 452, 2, 'Литвинова', 'Варвара', 'Мироновна', '243975958718', 101771515);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (468, 209, 386, 206, 'Чернышев', 'Роман', 'Глебович', '419480159992', 765983993);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (469, 56, 255, 394, 'Новикова', 'Василина', 'Михайловна', '241862157805', 730198495);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (470, 373, 434, 270, 'Фролов', 'Константин', 'Егорович', '890186908814', 765459070);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (471, 133, 249, 15, 'Алексеева', 'Серафима', 'Игоревна', '38871097883', 483959008);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (472, 487, 116, 204, 'Тихомирова', 'Алиса', 'Вадимовна', '758596955438', 597907759);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (473, 11, 74, 30, 'Кошелева', 'Марьяна', 'Александровна', '541255264773', 111933734);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (474, 327, 169, 312, 'Фролова', 'Алиса', 'Леонидовна', '215024514208', 696347826);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (475, 182, 492, 96, 'Лебедева', 'Ева', 'Артёмовна', '942416324665', 366044533);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (476, 324, 229, 109, 'Горелов', 'Глеб', 'Робертович', '641096199008', 394441230);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (477, 485, 341, 437, 'Самойлова', 'Елизавета', 'Артемьевна', '693781658111', 172103838);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (478, 140, 9, 154, 'Крылова', 'Вероника', 'Денисовна', '946379786352', 206412377);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (479, 11, 290, 198, 'Федотова', 'Василиса', 'Романовна', '562496528284', 765129731);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (480, 4, 77, 6, 'Хромова', 'Вероника', 'Сергеевна', '908304856967', 617678610);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (481, 407, 243, 311, 'Яковлева', 'Милана', 'Александровна', '376312433680', 753904926);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (482, 122, 130, 371, 'Авдеев', 'Иван', 'Владиславович', '464487096343', 556441555);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (483, 335, 392, 322, 'Вавилова', 'Софья', 'Глебовна', '331948170301', 332043167);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (484, 417, 499, 258, 'Чернышев', 'Дмитрий', 'Тихонович', '283037615348', 561710644);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (485, 220, 464, 357, 'Литвинов', 'Александр', 'Григорьевич', '386893428735', 152787618);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (486, 61, 221, 292, 'Скворцова', 'София', 'Марсельевна', '912553583354', 726052150);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (487, 341, 457, 154, 'Терехов', 'Даниил', 'Макарович', '146390858474', 670780232);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (488, 56, 50, 255, 'Николаев', 'Роман', 'Саввич', '806134472869', 633360117);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (489, 154, 303, 123, 'Спиридонова', 'Юлия', 'Глебовна', '224553661778', 702186672);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (490, 9, 56, 249, 'Соболева', 'Полина', 'Данииловна', '878179242172', 28984771);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (491, 248, 186, 292, 'Попов', 'Давид', 'Егорович', '246548664485', 456143119);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (492, 123, 253, 459, 'Васильева', 'Мария', 'Дмитриевна', '118214846785', 750792366);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (493, 78, 105, 110, 'Ситникова', 'Татьяна', 'Алиевна', '288334643389', 234651088);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (494, 162, 415, 445, 'Васильева', 'Сафия', 'Ивановна', '652350561535', 680368942);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (495, 184, 154, 460, 'Косарева', 'Анастасия', 'Макаровна', '362646695804', 46118894);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (496, 303, 66, 277, 'Филиппова', 'Ксения', 'Михайловна', '566124734653', 362879232);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (497, 256, 159, 55, 'Горелова', 'Софья', 'Ярославовна', '152233602646', 352130020);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (498, 211, 473, 37, 'Васильева', 'Сафия', 'Ивановна', '582192941864', 490751070);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (499, 102, 210, 64, 'Кузнецова', 'Мия', 'Максимовна', '76846059443', 539147181);
INSERT INTO public.employee (id_employee, id_job_title, id_department, id_schedule, name, surname, patronymic, phone_number, salary) OVERRIDING SYSTEM VALUE VALUES (500, 119, 430, 389, 'Кузнецова', 'Анна', 'Кирилловна', '594276226568', 715728542);


--
-- TOC entry 3667 (class 0 OID 16565)
-- Dependencies: 217
-- Data for Name: execution_control; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (1, 126, 87, '2001-06-25', 'культура', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (2, 201, 290, '2090-08-22', 'призывать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (3, 120, 329, '2054-12-20', 'вирусный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (4, 64, 152, '1999-07-22', 'всевозможный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (5, 199, 380, '2013-02-18', 'автоматический', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (6, 404, 229, '2004-11-08', 'поиск', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (7, 422, 356, '2079-10-02', 'воскликнуть', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (8, 14, 176, '2036-07-12', 'воскликнуть', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (9, 194, 312, '2011-12-22', 'аккуратный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (10, 100, 482, '2085-09-25', 'установить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (11, 406, 183, '2079-01-07', 'этаж', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (12, 397, 91, '2010-06-04', 'количество', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (13, 459, 292, '2000-06-18', 'полагаться', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (14, 159, 347, '2022-12-25', 'признак', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (15, 421, 436, '2082-08-01', 'государственный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (16, 487, 376, '2079-01-01', 'коричневый', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (17, 438, 168, '2046-05-18', 'назвать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (18, 358, 9, '2014-03-21', 'уютный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (19, 241, 352, '2003-09-11', 'социальный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (20, 351, 283, '2006-04-02', 'субъект', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (21, 41, 200, '2023-08-12', 'кивнуть', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (22, 317, 489, '2089-02-09', 'русский', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (23, 374, 481, '2079-03-20', 'серебряный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (24, 256, 430, '2027-01-08', 'ящик', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (25, 203, 124, '2018-11-05', 'платье', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (26, 8, 399, '2088-06-04', 'книжный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (27, 339, 175, '2040-03-08', 'кормить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (28, 189, 454, '2023-03-04', 'личной', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (29, 15, 493, '2085-02-12', 'подразделение', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (30, 482, 129, '2086-08-15', 'действие', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (31, 418, 399, '2046-03-18', 'сотня', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (32, 106, 141, '2030-09-13', 'наивный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (33, 275, 247, '2002-03-02', 'изложить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (34, 138, 215, '2046-05-15', 'славянский', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (35, 267, 268, '2005-04-10', 'строгий', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (36, 293, 404, '2058-08-08', 'схватить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (37, 143, 123, '2080-07-04', 'понятие', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (38, 71, 398, '2074-08-13', 'ресурс', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (39, 154, 458, '2041-11-17', 'труд', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (40, 471, 342, '2013-09-12', 'наличие', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (41, 45, 426, '2008-08-19', 'деревянный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (42, 297, 175, '2004-09-25', 'горный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (43, 122, 380, '2068-06-19', 'звук', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (44, 226, 493, '2034-11-09', 'рука', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (45, 62, 144, '2067-09-08', 'различный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (46, 267, 220, '2069-04-26', 'немец', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (47, 46, 238, '2048-05-23', 'обернуться', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (48, 443, 148, '2038-03-03', 'рекламный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (49, 264, 417, '2007-11-04', 'договор', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (50, 332, 481, '2064-02-04', 'неподвижный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (51, 243, 342, '2066-01-17', 'дойти', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (52, 310, 260, '2075-07-07', 'собраться', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (53, 14, 235, '2017-10-09', 'повторить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (54, 402, 46, '2009-07-27', 'срок', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (55, 475, 409, '2035-08-20', 'удаваться', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (56, 134, 7, '2020-03-07', 'занять', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (57, 38, 359, '2014-06-20', 'причина', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (58, 61, 212, '2087-12-22', 'дипломатический', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (59, 371, 328, '2057-03-22', 'подарить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (60, 424, 367, '2054-09-11', 'арестовать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (61, 227, 242, '2086-12-12', 'учесть', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (62, 71, 380, '2019-02-07', 'кредитный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (63, 433, 318, '2043-08-11', 'зеленый', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (64, 464, 362, '2041-11-19', 'многий', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (65, 94, 473, '2042-06-18', 'городской', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (66, 184, 274, '2090-11-24', 'срок', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (67, 472, 379, '2023-04-10', 'прислушиваться', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (68, 135, 427, '2031-08-09', 'командовать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (69, 477, 306, '2021-01-09', 'вершина', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (70, 125, 296, '2079-03-05', 'дача', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (71, 202, 187, '2081-10-15', 'недавний', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (72, 20, 54, '2048-05-18', 'пожелать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (73, 113, 434, '2046-12-09', 'квадратный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (74, 55, 316, '2040-11-19', 'процесс', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (75, 374, 281, '2020-01-16', 'социологический', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (76, 371, 240, '2047-05-21', 'познакомиться', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (77, 66, 436, '2040-11-16', 'социалистический', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (78, 136, 44, '2021-10-06', 'управление', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (79, 448, 136, '2074-06-06', 'воздух', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (80, 274, 381, '2088-07-21', 'набрать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (81, 177, 192, '2056-04-18', 'противоречить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (82, 385, 442, '2059-07-23', 'должностной', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (83, 111, 382, '2085-05-15', 'король', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (84, 417, 283, '2052-04-11', 'соединение', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (85, 445, 145, '2045-12-23', 'ледяной', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (86, 149, 168, '2030-12-14', 'трудящийся', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (87, 477, 338, '2071-09-05', 'повод', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (88, 59, 355, '2088-06-19', 'линейный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (89, 494, 323, '2069-04-19', 'процесс', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (90, 192, 45, '2014-05-13', 'трудный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (91, 420, 178, '2075-04-17', 'властный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (92, 288, 441, '2032-03-07', 'сохранить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (93, 492, 236, '2030-05-01', 'заместитель', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (94, 34, 393, '2077-07-20', 'обозначить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (95, 488, 39, '2088-06-01', 'сельскохозяйственный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (96, 338, 404, '2007-12-12', 'боковой', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (97, 285, 497, '2070-08-27', 'обойти', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (98, 59, 83, '2032-10-27', 'есть', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (99, 254, 193, '2048-12-13', 'столик', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (100, 13, 29, '2026-11-12', 'выпасть', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (101, 22, 182, '2083-06-24', 'раненый', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (102, 458, 112, '2008-06-12', 'работать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (103, 131, 322, '2051-04-23', 'одинаковый', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (104, 327, 283, '2035-05-11', 'вопрос', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (105, 315, 124, '2067-01-24', 'ровный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (106, 270, 98, '1999-07-23', 'металлический', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (107, 374, 137, '2074-04-10', 'бросить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (108, 264, 44, '2003-06-22', 'христианский', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (109, 148, 94, '2068-01-18', 'культурный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (110, 159, 454, '2052-03-09', 'помощник', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (111, 155, 74, '2069-10-09', 'проектный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (112, 224, 431, '2016-07-28', 'избежать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (113, 454, 19, '2078-12-17', 'состоять', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (114, 496, 272, '2015-05-07', 'мешать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (115, 251, 136, '2034-10-21', 'разговаривать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (116, 75, 7, '2026-10-14', 'платить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (117, 76, 16, '2002-09-24', 'нога', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (118, 343, 357, '1999-02-23', 'ошибиться', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (119, 136, 123, '2015-12-08', 'страстной', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (120, 156, 121, '2088-10-25', 'еврей', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (121, 31, 292, '2085-08-25', 'этап', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (122, 498, 116, '2028-08-05', 'разрушить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (123, 481, 110, '2053-05-14', 'побывать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (124, 225, 449, '2084-07-28', 'кредит', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (125, 42, 215, '2078-05-20', 'весенний', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (126, 59, 70, '2045-02-02', 'киевский', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (127, 457, 410, '2020-12-18', 'кольцо', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (128, 403, 41, '2049-09-18', 'зарегистрировать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (129, 466, 457, '1999-08-26', 'повторять', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (130, 68, 199, '2026-05-01', 'кино', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (131, 443, 19, '2055-12-03', 'государство', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (132, 320, 68, '2051-08-15', 'заинтересовать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (133, 493, 137, '2061-10-16', 'кожа', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (134, 286, 470, '2068-04-28', 'широкий', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (135, 8, 189, '2011-06-26', 'послать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (136, 444, 350, '2021-10-20', 'изучать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (137, 200, 380, '2058-11-22', 'прямой', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (138, 267, 320, '2025-10-04', 'успевать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (139, 395, 365, '2033-11-24', 'главное', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (140, 355, 31, '2043-12-19', 'кивнуть', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (141, 444, 327, '2039-07-08', 'слава', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (142, 147, 81, '2040-12-21', 'выполнить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (143, 273, 139, '2026-05-06', 'успевать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (144, 90, 36, '2005-03-25', 'художественный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (145, 314, 413, '2020-07-03', 'провожать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (146, 303, 400, '2067-05-27', 'дорога', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (147, 161, 190, '2089-09-11', 'нормальный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (148, 133, 294, '2064-12-14', 'честь', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (149, 153, 397, '2017-03-21', 'модель', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (150, 384, 135, '2068-12-23', 'стол', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (151, 475, 458, '2007-09-23', 'отношение', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (152, 51, 187, '2068-04-18', 'улица', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (153, 343, 453, '2054-11-10', 'мешок', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (154, 317, 68, '2017-04-16', 'сложить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (155, 313, 199, '2041-03-05', 'параметр', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (156, 4, 408, '2029-07-20', 'стена', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (157, 421, 142, '2083-11-03', 'кризис', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (158, 364, 422, '2067-02-06', 'получать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (159, 350, 177, '2006-06-17', 'промышленность', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (160, 160, 121, '2029-04-28', 'сложить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (161, 369, 387, '2015-04-25', 'помощь', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (162, 23, 52, '2043-09-20', 'угроза', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (163, 236, 94, '2067-03-24', 'окончательный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (164, 157, 175, '2053-09-12', 'май', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (165, 259, 398, '2047-03-16', 'должность', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (166, 493, 261, '2054-11-13', 'сухой', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (167, 297, 264, '2039-09-10', 'оплата', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (168, 183, 16, '2063-07-09', 'организм', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (169, 242, 167, '2037-12-03', 'популярный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (170, 309, 22, '2052-10-04', 'выдающийся', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (171, 65, 253, '2057-11-28', 'любимый', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (172, 235, 104, '2002-07-26', 'искренний', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (173, 329, 240, '2028-11-06', 'сердечный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (174, 241, 374, '2031-07-01', 'расширить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (175, 157, 150, '2023-05-19', 'идеальный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (176, 227, 230, '2083-08-23', 'повторить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (177, 32, 409, '2013-01-04', 'конфликт', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (178, 220, 111, '2058-06-11', 'войско', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (179, 66, 481, '2049-03-07', 'предоставлять', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (180, 392, 459, '2051-10-25', 'уровень', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (181, 62, 329, '2053-09-20', 'тишина', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (182, 279, 377, '2054-12-10', 'многие', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (183, 82, 122, '2059-01-24', 'разрушить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (184, 161, 448, '2074-05-23', 'капитал', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (185, 421, 447, '2072-12-02', 'пищевой', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (186, 55, 347, '2052-08-10', 'немыслимый', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (187, 13, 150, '2090-01-07', 'печать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (188, 312, 145, '2076-10-12', 'родитель', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (189, 407, 222, '2016-02-01', 'чистый', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (190, 407, 376, '2060-08-01', 'способный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (191, 147, 166, '2053-04-25', 'обсуждать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (192, 277, 314, '2063-03-22', 'тело', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (193, 61, 310, '2074-03-14', 'ситуация', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (194, 69, 249, '2000-01-20', 'культура', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (195, 403, 158, '2016-12-13', 'район', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (196, 89, 236, '2029-02-24', 'изучение', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (197, 499, 441, '2028-04-01', 'раз', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (198, 414, 125, '2010-03-12', 'прятать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (199, 94, 242, '2085-12-27', 'спуститься', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (200, 280, 425, '2072-01-17', 'рисунок', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (201, 73, 302, '2025-10-25', 'помощник', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (202, 133, 327, '2034-07-20', 'враг', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (203, 12, 130, '2006-07-22', 'задача', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (204, 306, 22, '2011-06-27', 'свежий', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (205, 331, 135, '2077-01-02', 'мертвый', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (206, 252, 100, '2059-05-13', 'длиться', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (207, 143, 403, '2067-12-13', 'парк', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (208, 202, 419, '2053-10-14', 'схема', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (209, 35, 382, '2078-02-16', 'реформа', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (210, 192, 355, '2089-04-07', 'психический', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (211, 300, 26, '2005-07-05', 'смочь', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (212, 306, 149, '2085-05-12', 'блок', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (213, 351, 327, '2075-03-25', 'предпочитать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (214, 204, 205, '2020-09-04', 'зеленый', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (215, 6, 284, '2037-08-26', 'захотеть', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (216, 48, 209, '2089-12-09', 'полет', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (217, 140, 258, '2044-07-20', 'случай', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (218, 292, 458, '2004-01-11', 'войско', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (219, 286, 58, '1999-02-10', 'изучение', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (220, 300, 178, '2007-09-04', 'жилищный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (221, 4, 200, '2042-01-21', 'методический', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (222, 365, 332, '2026-01-09', 'глупый', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (223, 64, 234, '2062-08-09', 'годовой', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (224, 156, 32, '2010-01-16', 'хвост', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (225, 275, 363, '2053-03-25', 'существование', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (226, 441, 173, '2080-06-26', 'показательный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (227, 276, 32, '2043-09-25', 'петь', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (228, 237, 275, '2016-06-16', 'специальный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (229, 154, 28, '2081-09-05', 'прогрессивный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (230, 392, 406, '2053-02-07', 'стучать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (231, 194, 366, '2037-11-09', 'сходить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (232, 68, 191, '2014-07-28', 'перспектива', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (233, 359, 438, '2036-06-04', 'простой', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (234, 381, 374, '2037-10-02', 'золотой', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (235, 114, 290, '2045-05-15', 'тогдашний', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (236, 21, 31, '2020-11-21', 'указание', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (237, 447, 17, '2009-08-22', 'отсутствие', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (238, 293, 261, '2087-09-23', 'круглый', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (239, 466, 483, '2042-07-22', 'одинаковый', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (240, 132, 254, '2011-07-11', 'птица', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (241, 426, 320, '2001-03-15', 'спрашивать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (242, 330, 333, '2041-01-11', 'везти', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (243, 99, 243, '2027-08-27', 'производитель', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (244, 398, 2, '2036-06-28', 'отказываться', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (245, 383, 294, '2073-09-05', 'принципиальный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (246, 2, 338, '2069-12-11', 'птица', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (247, 395, 324, '2039-11-08', 'сердечный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (248, 463, 483, '2067-11-28', 'внести', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (249, 395, 86, '2009-01-11', 'машина', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (250, 225, 77, '2048-11-22', 'остаток', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (251, 346, 201, '2053-08-14', 'погибший', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (252, 89, 437, '2045-10-27', 'набор', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (253, 421, 367, '2012-01-18', 'достать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (254, 312, 336, '2067-10-20', 'конференция', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (255, 240, 151, '2077-07-17', 'картина', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (256, 466, 58, '2079-07-18', 'состав', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (257, 23, 363, '2011-12-27', 'нога', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (258, 329, 89, '2017-04-25', 'месяц', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (259, 309, 424, '2079-08-08', 'немецкий', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (260, 315, 51, '2003-07-09', 'советский', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (261, 226, 114, '2076-10-02', 'товар', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (262, 364, 481, '2050-04-21', 'грубый', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (263, 370, 204, '2029-12-26', 'шумный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (264, 465, 443, '2082-02-11', 'почтовый', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (265, 62, 116, '2048-12-03', 'реальность', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (266, 403, 463, '2086-06-10', 'ударить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (267, 67, 78, '2017-04-26', 'стремиться', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (268, 150, 250, '2069-07-17', 'описание', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (269, 302, 97, '2038-05-16', 'учить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (270, 373, 492, '2013-05-16', 'добавлять', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (271, 477, 152, '2025-08-04', 'рядовой', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (272, 383, 493, '2044-02-06', 'сделка', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (273, 12, 350, '2018-12-09', 'автор', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (274, 7, 55, '2061-06-01', 'нормальный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (275, 145, 15, '2059-03-05', 'сцена', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (276, 149, 440, '2060-03-18', 'грамотный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (277, 363, 80, '2022-01-20', 'приятный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (278, 20, 135, '2041-03-04', 'одеть', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (279, 212, 283, '2025-09-17', 'выставка', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (280, 360, 444, '2024-01-28', 'шептать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (281, 3, 188, '2029-06-06', 'бесплатный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (282, 211, 85, '2036-02-06', 'электронный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (283, 332, 77, '2080-05-09', 'построить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (284, 170, 230, '2039-08-28', 'девочка', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (285, 444, 159, '2022-11-06', 'мальчик', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (286, 386, 196, '2018-07-09', 'испытывать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (287, 378, 104, '2073-04-25', 'лоб', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (288, 500, 45, '2090-08-19', 'знакомый', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (289, 443, 85, '2003-04-03', 'профессиональный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (290, 68, 421, '2031-10-05', 'совместный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (291, 449, 26, '2076-07-10', 'принадлежать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (292, 392, 371, '2062-07-09', 'отделение', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (293, 107, 144, '2070-03-05', 'молчать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (294, 364, 469, '2025-12-01', 'офицер', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (295, 438, 312, '2089-08-28', 'сходить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (296, 308, 189, '2021-03-23', 'сегодняшний', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (297, 68, 38, '2010-06-17', 'значить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (298, 131, 224, '2087-03-14', 'частность', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (299, 7, 233, '2026-01-05', 'переговоры', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (300, 361, 327, '2055-12-02', 'рыночный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (301, 69, 268, '2040-04-28', 'судья', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (302, 26, 488, '2045-01-28', 'находиться', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (303, 386, 142, '2038-03-22', 'упасть', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (304, 406, 327, '2005-12-26', 'прямой', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (305, 238, 354, '2008-03-27', 'зависимость', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (306, 19, 253, '2081-10-17', 'идеологический', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (307, 428, 273, '2025-02-04', 'показательный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (308, 47, 294, '2009-03-02', 'миллион', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (309, 280, 157, '2090-08-12', 'гуманитарный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (310, 115, 235, '2075-03-24', 'комсомольский', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (311, 149, 480, '2038-08-19', 'гость', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (312, 432, 178, '2038-09-05', 'спектакль', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (313, 420, 417, '2083-11-15', 'гнать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (314, 63, 100, '2074-09-15', 'тень', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (315, 387, 423, '1999-07-23', 'сосед', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (316, 161, 92, '2077-02-26', 'относительный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (317, 56, 284, '2015-02-11', 'пытаться', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (318, 43, 214, '2061-03-09', 'грубый', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (319, 406, 15, '2062-08-13', 'слой', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (320, 230, 368, '2089-08-06', 'ценность', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (321, 74, 103, '1999-10-05', 'интеллигентный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (322, 494, 291, '2023-12-28', 'затрата', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (323, 348, 121, '2090-11-09', 'обеспечивать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (324, 388, 362, '2085-08-09', 'хороший', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (325, 204, 379, '2054-09-18', 'уголовный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (326, 61, 81, '2034-05-21', 'воинский', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (327, 478, 122, '2073-03-25', 'преодолеть', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (328, 97, 410, '2076-02-01', 'расстаться', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (329, 301, 175, '2055-06-28', 'складываться', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (330, 144, 386, '2047-10-16', 'тихий', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (331, 459, 171, '2054-10-01', 'надежный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (332, 184, 44, '2047-04-02', 'отправляться', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (333, 63, 308, '2081-03-19', 'прожить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (334, 337, 104, '2072-07-02', 'своеобразный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (335, 64, 356, '2048-10-14', 'выйти', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (336, 41, 201, '2072-08-03', 'штука', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (337, 250, 288, '2064-10-04', 'количество', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (338, 487, 92, '2025-07-21', 'река', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (339, 204, 357, '2090-05-25', 'духовный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (340, 331, 239, '2062-11-04', 'предложить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (341, 439, 212, '2069-10-06', 'деревенский', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (342, 385, 402, '2073-06-19', 'мысль', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (343, 264, 197, '1999-06-02', 'предоставить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (344, 451, 144, '2012-10-12', 'фирма', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (345, 15, 280, '2039-04-07', 'глава', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (346, 495, 209, '2079-07-04', 'порог', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (347, 433, 491, '2057-08-22', 'воля', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (348, 8, 389, '2019-08-14', 'крыло', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (349, 182, 364, '2018-01-20', 'откровенный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (350, 202, 39, '2050-01-08', 'связь', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (351, 306, 466, '2090-08-28', 'развитый', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (352, 397, 210, '2046-04-22', 'сегодняшний', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (353, 481, 258, '2073-06-14', 'газ', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (354, 452, 180, '2069-05-08', 'лишний', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (355, 486, 70, '2051-11-20', 'китайский', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (356, 438, 27, '2063-01-14', 'птица', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (357, 31, 106, '2022-04-11', 'обстоятельство', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (358, 172, 374, '2014-03-03', 'гигантский', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (359, 262, 37, '2059-07-28', 'популярный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (360, 470, 152, '2060-11-26', 'разойтись', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (361, 483, 39, '2025-08-07', 'региональный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (362, 315, 239, '2069-03-26', 'иностранный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (363, 156, 363, '2029-08-21', 'учебный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (364, 387, 454, '2015-04-21', 'примитивный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (365, 321, 177, '2042-12-19', 'перестать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (366, 58, 315, '2060-11-01', 'убежденный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (367, 179, 329, '2011-10-27', 'изменение', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (368, 234, 25, '2021-08-25', 'объем', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (369, 339, 3, '2084-09-13', 'многочисленный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (370, 97, 448, '2078-09-20', 'кивнуть', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (371, 272, 224, '2070-11-04', 'порог', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (372, 175, 284, '2085-02-08', 'петербургский', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (373, 19, 147, '2039-10-26', 'естественный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (374, 169, 411, '2078-08-04', 'предположить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (375, 72, 188, '2084-08-10', 'молодой', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (376, 319, 359, '2005-05-23', 'влюбленный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (377, 165, 82, '2015-04-24', 'машина', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (378, 352, 130, '1999-10-19', 'надежный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (379, 220, 343, '2067-10-11', 'явление', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (380, 418, 64, '2073-08-27', 'принудительный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (381, 438, 306, '2088-08-23', 'пространственный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (382, 379, 223, '2025-04-22', 'образование', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (383, 355, 386, '2083-01-19', 'удивляться', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (384, 360, 427, '2047-10-14', 'проверять', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (385, 214, 471, '2084-04-22', 'отправиться', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (386, 429, 90, '2022-12-05', 'совершенный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (387, 189, 391, '2006-07-22', 'бросить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (388, 61, 197, '2053-07-23', 'следствие', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (389, 319, 326, '2080-04-15', 'надоесть', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (390, 73, 146, '2066-01-27', 'делиться', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (391, 382, 419, '2008-09-17', 'пустить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (392, 422, 251, '2038-09-04', 'пригласить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (393, 423, 190, '2040-10-27', 'торжественный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (394, 310, 182, '2001-08-12', 'роскошный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (395, 112, 181, '2064-01-17', 'культурный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (396, 71, 154, '2072-04-15', 'суровый', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (397, 380, 145, '2046-05-01', 'вирус', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (398, 299, 305, '2087-06-20', 'лечь', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (399, 137, 193, '2073-07-09', 'ночь', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (400, 233, 18, '2062-08-16', 'всевозможный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (401, 355, 19, '2056-12-27', 'сбросить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (402, 37, 68, '2035-01-26', 'посидеть', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (403, 419, 421, '2049-07-16', 'проявить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (404, 37, 179, '2060-05-21', 'этап', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (405, 229, 262, '2051-11-19', 'ночь', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (406, 410, 106, '2040-02-10', 'строй', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (407, 386, 368, '2070-09-02', 'производить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (408, 282, 124, '2006-11-20', 'вооруженный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (409, 175, 386, '2080-02-20', 'симпатичный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (410, 165, 11, '2012-11-04', 'снижение', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (411, 214, 374, '2004-01-05', 'герой', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (412, 156, 362, '2067-09-09', 'позволить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (413, 224, 460, '2046-07-01', 'победить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (414, 87, 329, '2003-10-04', 'черта', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (415, 400, 256, '2052-12-07', 'желание', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (416, 484, 403, '2022-06-10', 'режиссер', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (417, 417, 410, '2071-04-19', 'лидер', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (418, 249, 280, '2085-01-20', 'рынок', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (419, 300, 253, '2021-07-22', 'написать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (420, 266, 430, '2048-03-10', 'замечать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (421, 98, 294, '2073-10-01', 'пожарный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (422, 461, 347, '2026-02-18', 'двинуться', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (423, 147, 416, '2075-12-18', 'заглянуть', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (424, 466, 243, '2068-10-09', 'подобрать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (425, 220, 79, '1999-04-13', 'заплакать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (426, 45, 266, '2089-06-12', 'стараться', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (427, 266, 38, '2035-07-21', 'настаивать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (428, 482, 396, '2045-05-08', 'биологический', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (429, 222, 496, '2013-02-12', 'уютный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (430, 450, 246, '2018-03-28', 'повышенный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (431, 287, 169, '2038-10-14', 'грядущий', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (432, 103, 160, '2081-08-26', 'картина', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (433, 7, 319, '2048-07-10', 'достаточный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (434, 200, 118, '2011-03-01', 'помочь', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (435, 335, 78, '2075-10-09', 'охрана', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (436, 318, 320, '2084-11-20', 'музыка', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (437, 63, 208, '2000-03-14', 'смерть', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (438, 73, 169, '2054-12-14', 'заработный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (439, 181, 280, '2084-03-10', 'слабый', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (440, 385, 425, '2057-01-14', 'явление', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (441, 363, 138, '2041-02-28', 'настаивать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (442, 103, 242, '2003-01-24', 'старинный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (443, 360, 333, '2037-05-12', 'конституционный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (444, 340, 488, '2073-12-13', 'производитель', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (445, 273, 183, '2060-08-18', 'выход', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (446, 269, 285, '2087-04-04', 'пройти', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (447, 144, 141, '2080-08-09', 'спрятать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (448, 224, 282, '2070-09-12', 'достигать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (449, 120, 358, '2058-04-06', 'актерский', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (450, 89, 408, '2047-11-08', 'ожидание', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (451, 303, 492, '2038-03-08', 'виноватый', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (452, 405, 271, '2007-07-02', 'правый', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (453, 83, 340, '2036-12-16', 'толпа', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (454, 245, 51, '2081-09-14', 'тогдашний', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (455, 281, 290, '2041-02-13', 'кривой', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (456, 264, 43, '2071-08-25', 'налоговый', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (457, 58, 196, '2005-05-05', 'верный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (458, 476, 376, '2038-12-24', 'чемпионат', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (459, 120, 64, '2040-11-02', 'парламентский', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (460, 353, 157, '2011-11-21', 'метод', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (461, 356, 473, '2071-01-03', 'испытывать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (462, 43, 87, '2065-01-09', 'предназначить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (463, 446, 145, '2000-06-18', 'судить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (464, 426, 167, '2088-04-24', 'связь', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (465, 33, 187, '2076-01-06', 'предпочитать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (466, 238, 307, '2070-08-27', 'командовать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (467, 9, 80, '2067-03-21', 'сообразить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (468, 215, 481, '2071-03-06', 'оценить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (469, 5, 452, '2049-01-25', 'передовой', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (470, 321, 127, '2039-07-14', 'лес', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (471, 443, 63, '2019-10-01', 'слой', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (472, 477, 313, '2005-08-04', 'печатный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (473, 261, 264, '2021-09-18', 'округ', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (474, 300, 266, '2014-05-28', 'сущность', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (475, 397, 134, '2058-11-25', 'логический', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (476, 105, 48, '2013-12-15', 'главное', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (477, 374, 275, '2006-02-13', 'кресло', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (478, 232, 7, '2057-06-13', 'плоский', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (479, 31, 482, '2038-02-24', 'простить', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (480, 493, 318, '2084-05-13', 'модель', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (481, 33, 166, '2064-07-02', 'дед', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (482, 445, 463, '2062-07-21', 'дойти', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (483, 311, 322, '2073-10-13', 'газета', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (484, 322, 477, '2066-12-01', 'испытать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (485, 112, 281, '2041-11-22', 'товарный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (486, 300, 129, '2008-10-26', 'уголовный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (487, 80, 59, '2055-06-11', 'будущий', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (488, 474, 253, '2029-10-06', 'занимать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (489, 72, 340, '2028-04-16', 'помещение', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (490, 469, 272, '2032-12-03', 'долг', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (491, 340, 75, '2058-03-24', 'иметься', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (492, 135, 347, '2085-01-03', 'хитрый', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (493, 187, 413, '2086-09-09', 'создать', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (494, 170, 348, '2029-08-08', 'английский', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (495, 258, 1, '2079-12-14', 'отличный', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (496, 245, 238, '2059-06-12', 'регион', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (497, 246, 186, '2067-09-05', 'сложиться', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (498, 340, 323, '2072-08-21', 'село', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (499, 315, 109, '2071-11-12', 'звонок', 'в процессе');
INSERT INTO public.execution_control (id_execution, id_schedule, id_supervisor, control_date, comment, task_status) OVERRIDING SYSTEM VALUE VALUES (500, 218, 89, '2088-02-19', 'университет', 'в процессе');


--
-- TOC entry 3660 (class 0 OID 16420)
-- Dependencies: 210
-- Data for Name: job_title; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (1, 249, 'Инженер по научно-технической информации', 228190568);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (2, 231, 'Начальник хозяйственного отдела', 650681499);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (3, 125, 'Главный специалист по защите информации', 175741259);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (4, 311, 'Главный технолог', 169555793);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (5, 371, 'Заведующий фотолабораторией', 648049644);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (6, 221, 'Начальник отдела по связям с инвесторами', 44991589);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (7, 126, 'Экономист по финансовой работе', 395938123);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (8, 226, 'Экономист по планированию', 749758567);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (9, 326, 'Лаборант', 381583192);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (10, 295, 'Техник по наладке и испытаниям', 372006214);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (11, 11, 'Инженер-энергетик (энергетик)', 768613735);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (12, 84, 'Лаборант', 432491200);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (13, 90, 'Документовед', 404567162);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (14, 166, 'Заведующий хозяйством', 169561347);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (15, 141, 'Художник', 119450433);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (16, 220, 'Эксперт по промышленной безопасности подъемных сооружений', 700242525);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (17, 442, 'Математик', 381297507);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (18, 149, 'Техник по планированию', 436987744);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (19, 498, 'Переводчик', 281201433);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (20, 431, 'Начальник автоколонны', 429945401);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (21, 373, 'Начальник нормативно-исследовательской лаборатории по труду', 279025701);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (22, 338, 'Заведующий (начальник) отделом кадров', 399967173);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (23, 391, 'Профконсультант', 179387090);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (24, 133, 'Директор (начальник) учреждения (организации)', 191973902);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (25, 121, 'Инженер-проектировщик', 691989984);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (26, 388, 'Комендант', 156604943);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (27, 401, 'Начальник цеха опытного производства', 589040340);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (28, 366, 'Мастер контрольный (участка, цеха)', 308006385);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (29, 307, 'Экономист по сбыту', 689419765);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (30, 363, 'Экономист по планированию', 622903444);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (31, 41, 'Дежурный бюро пропусков', 244213319);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (32, 256, 'Техник-технолог', 537237449);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (33, 161, 'Экономист по труду', 52813101);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (34, 110, 'Экономист вычислительного (информационно-вычислительного) центра', 218918343);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (35, 398, 'Начальник цеха (участка)', 794414405);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (36, 385, 'Нарядчик', 767087246);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (37, 335, 'Главный инженер', 107689144);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (38, 459, 'Менеджер по связям с инвесторами', 686930573);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (39, 42, 'Начальник отдела информации', 789360493);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (40, 256, 'Директор (начальник) учреждения (организации)', 559019151);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (41, 250, 'Экономист', 287511240);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (42, 404, 'Биржевой маклер', 379921379);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (43, 489, 'Механик', 541488587);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (44, 49, 'Начальник цеха опытного производства', 205040366);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (45, 441, 'Чертежник', 509716229);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (46, 340, 'Техник-конструктор', 428920062);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (47, 411, 'Менеджер по рекламе', 689950576);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (48, 274, 'Кассир', 644162399);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (49, 484, 'Главный метролог', 46417985);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (50, 401, 'Инкассатор', 102740967);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (51, 350, 'Главный диспетчер', 587107946);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (52, 47, 'Техник по защите информации', 548026864);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (53, 431, 'Оценщик интеллектуальной собственности', 48467462);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (54, 237, 'Шеф-инженер', 210197367);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (55, 88, 'Руководитель группы по инвентаризации строений и сооружений', 321659214);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (56, 442, 'Методист по физической культуре', 71764014);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (57, 24, 'Начальник цеха опытного производства', 649174484);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (58, 160, 'Начальник отдела охраны окружающей среды', 524886252);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (59, 420, 'Начальник отдела патентной и изобретательской работы', 636114865);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (60, 410, 'Заведующий канцелярией', 586367109);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (61, 344, 'Заведующий (начальник) отделом кадров', 30087370);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (62, 278, 'Заведующий жилым корпусом пансионата (гостиницы)', 255815923);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (63, 487, 'Администратор', 651763030);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (64, 75, 'Техник по планированию', 80757929);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (65, 415, 'Главный сварщик', 311187930);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (66, 185, 'Делопроизводитель', 509327705);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (67, 127, 'Начальник отдела стандартизации', 714798069);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (68, 149, 'Заведующий экспедицией', 230734613);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (69, 145, 'Техник-конструктор', 282535520);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (70, 408, 'Инженер по инструменту', 692252478);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (71, 235, 'Инженер', 138047901);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (72, 474, 'Техник-конструктор', 510861136);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (73, 350, 'Специалист по маркетингу', 773690808);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (74, 84, 'Директор (начальник) вычислительного (информационно-вычислительного) центра', 393072797);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (75, 7, 'Начальник отдела автоматизации и механизации производственных процессов', 462907405);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (76, 40, 'Инженер по защите информации', 486770857);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (77, 143, 'Экономист по планированию', 415238064);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (78, 327, 'Техник по стандартизации', 461592584);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (79, 371, 'Директор типографии', 613451765);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (80, 371, 'Оператор диспетчерской службы', 711044836);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (81, 483, 'Специалист по автотехнической экспертизе (эксперт-автотехник)', 389860345);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (82, 428, 'Ландшафтный архитектор', 152847269);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (83, 184, 'Эксперт дорожного хозяйства', 245379122);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (84, 130, 'Секретарь-машинистка', 518961556);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (85, 308, 'Аукционист', 94538621);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (249, 316, 'Стенографистка. - Исключено', 214382657);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (86, 3, 'Инспектор по контролю за исполнением поручений', 416991826);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (87, 175, 'Специалист по защите информации', 113434636);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (88, 291, 'Финансовый директор (заместитель директора по финансам)', 95489141);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (89, 63, 'Инженер по метрологии', 59486126);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (90, 408, 'Ведущий инженер', 473124206);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (91, 320, 'Таксировщик', 568607539);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (92, 170, 'Инженер', 510687288);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (93, 410, 'Главный диспетчер', 129318820);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (94, 368, 'Крупье', 703259863);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (95, 235, 'Ведущий инженер', 62343991);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (96, 469, 'Начальник отдела комплектации оборудования', 106421328);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (97, 99, 'Начальник гаража', 145926533);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (98, 348, 'Инженер по подготовке производства', 698592207);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (99, 113, 'Директор по связям с инвесторами', 557531217);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (100, 412, 'Ведущий инженер', 73827991);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (101, 168, 'Лаборант', 413323169);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (102, 311, 'Производитель работ (прораб)', 137139256);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (103, 150, 'Начальник отдела кадров', 542072718);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (104, 14, 'Техник-лаборант', 624001720);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (105, 423, 'Начальник нормативно-исследовательской лаборатории по труду', 710854586);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (106, 273, 'Методист по физической культуре', 477371913);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (107, 164, 'Машинистка', 193025007);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (108, 321, 'Заведующий аспирантурой', 690285473);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (109, 174, 'Начальник отдела сбыта', 377262768);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (110, 77, 'Переводчик', 513102053);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (111, 286, 'Заведующий общежитием', 550709113);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (112, 323, 'Математик', 543424936);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (113, 430, 'Агент торговый', 584447535);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (114, 467, 'Эксперт', 752676943);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (115, 274, 'Комендант', 712985467);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (116, 14, 'Начальник финансового отдела', 446034701);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (117, 312, 'Старший научный сотрудник', 249765673);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (118, 221, 'Таксировщик', 105395416);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (119, 151, 'Начальник лаборатории (бюро) по организации труда и управления производством', 137338841);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (120, 14, 'Специалист по промышленной безопасности подъемных сооружений', 469280081);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (121, 485, 'Начальник отдела по связям с общественностью', 21867029);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (122, 203, 'Директор (начальник) вычислительного (информационно-вычислительного) центра', 691625628);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (123, 153, 'Научный редактор', 27293704);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (124, 137, 'Экономист по бухгалтерскому учету и анализу хозяйственной деятельности', 316114000);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (125, 386, 'Бухгалтер', 758229996);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (126, 301, 'Заведующий складом', 316602567);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (127, 234, 'Инженер-энергетик (энергетик)', 325288984);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (128, 473, 'Кодификатор', 743281811);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (129, 335, 'Главный энергетик', 47711453);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (130, 209, 'Экономист по материально-техническому снабжению', 661762234);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (131, 18, 'Директор (генеральный директор, управляющий) предприятия', 495213250);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (132, 134, 'Специалист по оценке соответствия лифтов требованиям безопасности', 311879063);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (133, 236, 'Аудитор', 468201720);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (134, 81, 'Социолог', 303941456);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (135, 10, 'Кассир', 88561219);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (136, 60, 'Агент коммерческий', 759422607);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (137, 3, 'Экспедитор по перевозке грузов', 750717108);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (138, 316, 'Экономист по материально-техническому снабжению', 290042549);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (139, 165, 'Заведующий (начальник) отделом кадров', 279155164);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (140, 248, 'Заведующий канцелярией', 752330256);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (141, 195, 'Техник по планированию', 56823586);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (142, 150, 'Заведующий чертежно-копировальным бюро', 613768908);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (143, 398, 'Начальник (руководитель) бригады (группы)', 201283417);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (144, 500, 'Делопроизводитель', 755240861);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (145, 335, 'Переводчик-дактилолог', 561725292);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (146, 314, 'Заведующий (начальник) научно-исследовательским отделом (отделением, лабораторией) института', 399005309);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (147, 352, 'Заведующий бюро пропусков', 28825954);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (148, 44, 'Научный сотрудник', 409390496);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (149, 327, 'Экономист', 381811869);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (150, 425, 'Начальник отдела по связям с инвесторами', 786524059);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (151, 102, 'Заведующий конструкторским отделом', 159090864);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (152, 205, 'Механик', 636983605);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (153, 489, 'Начальник центральной заводской лаборатории', 289116633);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (154, 331, 'Специалист по связям с инвесторами', 608980620);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (155, 494, 'Инженер по подготовке кадров', 399471995);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (156, 319, 'Переводчик-дактилолог', 44958272);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (157, 130, 'Техник по планированию', 354393938);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (158, 258, 'Статистик', 164536077);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (159, 37, 'Переводчик', 687029397);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (160, 185, 'Инженер по автоматизации и механизации производственных процессов', 625611967);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (161, 193, 'Директор (начальник) учреждения (организации)', 582342426);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (162, 425, 'Дежурный (по выдаче справок, залу, этажу гостиницы, комнате отдыха, общежитию и др.)', 516928669);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (163, 149, 'Экономист по материально-техническому снабжению', 21211854);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (164, 500, 'Главный металлург', 566307125);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (165, 230, 'Главный специалист в основном отделе (архитектурно-планировочной мастерской)', 379593219);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (166, 383, 'Инженер по инвентаризации строений и сооружений', 213281247);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (167, 424, 'Главный инженер проекта. Главный архитектор проекта', 170057528);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (168, 86, 'Начальник отдела по связям с общественностью', 85749397);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (169, 34, 'Главный механик', 438898813);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (170, 190, 'Стенографистка. - Исключено', 31857159);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (171, 242, 'Ведущий экономист', 281044569);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (172, 269, 'Профконсультант', 692313291);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (173, 164, 'Начальник исследовательской лаборатории', 543938405);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (174, 258, 'Директор гостиницы', 124928396);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (175, 252, 'Начальник отдела контроля качества', 775368222);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (176, 46, 'Эксперт по оценке соответствия лифтов требованиям безопасности', 644730811);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (177, 72, 'Инженер-конструктор (конструктор)', 210855093);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (178, 134, 'Специалист по защите информации', 167217542);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (179, 452, 'Начальник отдела социального развития', 190494360);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (180, 417, 'Начальник отдела материально-технического снабжения', 186354361);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (181, 442, 'Заместитель директора по коммерческим вопросам', 309164033);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (182, 8, 'Директор котельной', 488773522);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (183, 337, 'Инженер по научно-технической информации', 164720927);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (184, 381, 'Начальник центральной заводской лаборатории', 357587789);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (185, 23, 'Начальник отдела капитального строительства', 672501819);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (186, 257, 'Начальник технического отдела', 243860136);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (187, 133, 'Заведующий (начальник) отделом кадров', 320493595);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (188, 40, 'Инженер по организации управления производством', 48173627);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (189, 228, 'Заведующий жилым корпусом пансионата (гостиницы)', 768858348);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (190, 499, 'Заместитель директора по коммерческим вопросам', 313204588);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (191, 399, 'Методист по физической культуре', 489747876);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (192, 451, 'Инженер по защите информации', 121403832);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (193, 320, 'Заведующий общежитием', 444106589);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (194, 166, 'Начальник отдела патентной и изобретательской работы', 756067160);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (195, 287, 'Начальник отдела подготовки кадров', 460266401);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (196, 360, 'Специалист по маркетингу', 766549718);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (197, 408, 'Экономист по труду', 402758828);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (198, 60, 'Заместитель директора по коммерческим вопросам', 346545060);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (199, 300, 'Лаборант', 442933242);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (200, 220, 'Главный механик', 465352241);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (201, 217, 'Инженер', 100637731);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (202, 455, 'Чертежник', 24475945);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (203, 25, 'Социолог', 751980324);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (204, 194, 'Крупье', 65121524);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (205, 431, 'Техник по труду', 533798735);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (206, 275, 'Инженер по ремонту', 314631378);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (207, 170, 'Брокер', 78376641);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (208, 372, 'Руководитель группы по инвентаризации строений и сооружений', 49524049);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (209, 5, 'Специалист по связям с инвесторами', 555780905);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (210, 185, 'Начальник отдела автоматизации и механизации производственных процессов', 136744869);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (211, 93, 'Агент торговый', 516132073);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (212, 15, 'Технический редактор', 167653081);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (213, 491, 'Статистик', 101506988);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (214, 143, 'Статистик', 283678417);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (215, 443, 'Руководитель подразделения', 33925092);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (216, 371, 'Делопроизводитель', 469555134);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (217, 262, 'Заведующий (начальник) научно-исследовательским отделом (отделением, лабораторией) института', 80426518);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (218, 128, 'Производитель работ (прораб)', 556990259);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (219, 1, 'Техник по планированию', 54994597);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (220, 20, 'Инженер по подготовке кадров', 618818846);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (221, 3, 'Социолог', 639347737);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (222, 101, 'Техник по планированию', 654355196);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (223, 315, 'Начальник нормативно-исследовательской лаборатории по труду', 386071098);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (224, 263, 'Директор гостиницы', 161909073);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (225, 142, 'Инженер-энергетик (энергетик)', 657038742);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (226, 491, 'Начальник отдела материально-технического снабжения', 206635271);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (227, 152, 'Инкассатор', 305649470);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (228, 220, 'Заведующий аспирантурой', 577741868);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (229, 276, 'Эксперт дорожного хозяйства', 723665820);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (230, 496, 'Корпоративный секретарь акционерного общества', 247648474);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (231, 247, 'Бухгалтер', 205117873);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (232, 182, 'Техник по защите информации', 107729770);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (233, 486, 'Директор гостиницы', 708078487);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (234, 338, 'Начальник отдела комплектации оборудования', 306541405);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (235, 139, 'Техник по инструменту', 28618924);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (236, 412, 'Финансовый директор (заместитель директора по финансам)', 648410541);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (237, 469, 'Переводчик', 554689394);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (238, 353, 'Начальник лаборатории (бюро) технико-экономических исследований', 67229485);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (239, 66, 'Начальник технического отдела', 651132610);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (240, 95, 'Техник-лаборант', 109150050);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (241, 170, 'Главный технолог', 666691175);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (242, 103, 'Архитектор', 551110746);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (243, 25, 'Физиолог', 86772145);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (244, 171, 'Диспетчер', 555565352);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (245, 450, 'Начальник технического отдела', 317160169);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (246, 175, 'Заведующий копировально-множительным бюро', 192775050);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (247, 88, 'Техник по стандартизации', 392139729);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (248, 131, 'Мастер участка', 371627543);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (250, 185, 'Методист по физической культуре', 563648526);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (251, 33, 'Директор (начальник) учреждения (организации)', 796962555);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (252, 7, 'Редактор', 65889970);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (253, 491, 'Заместитель директора по коммерческим вопросам', 613520566);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (254, 6, 'Начальник отдела стандартизации', 437834628);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (255, 56, 'Заведующий научно-технической библиотекой', 644363384);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (256, 406, 'Заведующий (начальник) научно-исследовательским отделом (отделением, лабораторией) института', 459271895);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (257, 376, 'Ведущий конструктор', 242097468);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (258, 364, 'Инженер по автоматизации и механизации производственных процессов', 54322225);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (259, 494, 'Экономист вычислительного (информационно-вычислительного) центра', 71474812);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (260, 430, 'Эксперт по оценке соответствия лифтов требованиям безопасности', 563230356);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (261, 436, 'Главный бухгалтер', 574797315);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (262, 104, 'Техник по защите информации', 170548526);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (263, 373, 'Финансовый директор (заместитель директора по финансам)', 747188079);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (264, 446, 'Начальник отдела материально-технического снабжения', 398674197);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (265, 491, 'Начальник отдела организации и оплаты труда', 208417218);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (266, 154, 'Переводчик', 405511931);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (267, 453, 'Директор (генеральный директор, управляющий) предприятия', 579834420);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (268, 12, 'Заведующий конструкторским отделом', 276893533);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (269, 22, 'Начальник отдела (лаборатории, сектора) по защите информации', 125661856);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (270, 238, 'Инженер', 240356936);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (271, 246, 'Документовед', 648403892);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (272, 82, 'Инженер по подготовке кадров', 431487232);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (273, 433, 'Начальник отдела (лаборатории, сектора) по защите информации', 395777790);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (274, 140, 'Заведующий (начальник) научно-исследовательским отделом (отделением, лабораторией) института', 151773265);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (275, 229, 'Заведующий хозяйством', 262497464);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (276, 229, 'Начальник лаборатории (бюро) технико-экономических исследований', 68327986);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (277, 381, 'Оператор по диспетчерскому обслуживанию лифтов', 67066216);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (278, 74, 'Эксперт дорожного хозяйства', 193610783);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (279, 183, 'Заведующий (начальник) отделом научно-технической информации', 793196798);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (280, 285, 'Эксперт дорожного хозяйства', 671438794);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (281, 499, 'Экспедитор по перевозке грузов', 316955904);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (282, 390, 'Начальник цеха (участка)', 258209324);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (283, 66, 'Главный механик', 301827089);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (284, 498, 'Инженер-технолог (технолог)', 455970277);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (285, 66, 'Техник-конструктор', 373823208);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (286, 167, 'Корректор', 250595334);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (287, 395, 'Начальник цеха опытного производства', 44408466);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (288, 319, 'Администратор', 626342027);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (289, 491, 'Экономист по бухгалтерскому учету и анализу хозяйственной деятельности', 177445540);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (290, 472, 'Заместитель директора по коммерческим вопросам', 569321614);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (291, 311, 'Копировщик', 615377899);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (292, 419, 'Мастер участка', 442002374);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (293, 484, 'Технический редактор', 277165379);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (294, 114, 'Ученый секретарь', 772498731);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (295, 58, 'Начальник отдела подготовки кадров', 726278413);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (296, 303, 'Бухгалтер-ревизор', 600834010);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (297, 304, 'Инженер по стандартизации', 681612326);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (298, 250, 'Документовед', 416962928);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (299, 27, 'Переводчик', 734504565);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (300, 55, 'Специалист по связям с общественностью', 133954623);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (301, 222, 'Документовед', 500834491);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (302, 92, 'Старший научный сотрудник', 548639088);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (303, 137, 'Аукционист', 103576781);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (304, 221, 'Психолог', 683070719);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (305, 150, 'Лаборант', 578247248);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (306, 13, 'Экономист по бухгалтерскому учету и анализу хозяйственной деятельности', 771538734);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (307, 410, 'Ученый секретарь', 532422400);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (308, 270, 'Инженер по подготовке кадров', 409248668);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (309, 316, 'Инспектор по контролю за исполнением поручений', 551763448);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (310, 476, 'Директор типографии', 193488160);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (311, 143, 'Главный энергетик', 211586179);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (312, 227, 'Переводчик', 25688840);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (313, 17, 'Учетчик', 617849590);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (314, 405, 'Инженер', 528856877);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (315, 154, 'Начальник отдела организации и оплаты труда', 197717676);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (316, 17, 'Начальник цеха опытного производства', 363453252);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (317, 27, 'Инженер по защите информации', 604581318);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (318, 277, 'Специалист по промышленной безопасности подъемных сооружений', 427452974);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (319, 157, 'Инженер по организации труда', 202671852);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (320, 75, 'Инженер по стандартизации', 352303862);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (321, 163, 'Инженер по метрологии', 83494453);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (322, 106, 'Начальник лаборатории (бюро) по организации труда и управления производством', 208815697);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (323, 181, 'Секретарь-стенографистка. - Исключено', 332603334);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (324, 460, 'Переводчик синхронный', 240100816);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (325, 334, 'Начальник отдела информации', 117676354);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (326, 211, 'Начальник отдела капитального строительства', 28710935);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (327, 98, 'Комендант', 560053710);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (328, 211, 'Начальник отдела охраны труда. - Исключен', 87548032);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (329, 309, 'Инженер по охране труда. - Исключен', 320086302);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (330, 456, 'Главный металлург', 225270678);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (331, 317, 'Заместитель директора по коммерческим вопросам', 211970836);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (332, 263, 'Техник', 201746304);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (333, 484, 'Дежурный (по выдаче справок, залу, этажу гостиницы, комнате отдыха, общежитию и др.)', 181665948);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (334, 311, 'Начальник отдела патентной и изобретательской работы', 629260641);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (335, 88, 'Специалист по связям с инвесторами', 135779936);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (336, 285, 'Начальник финансового отдела', 645421986);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (337, 392, 'Главный энергетик', 449966142);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (338, 285, 'Специалист по защите информации', 27929399);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (339, 198, 'Заведующий научно-технической библиотекой', 511041193);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (340, 492, 'Ведущий конструктор', 632559851);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (341, 148, 'Специалист по маркетингу', 580936590);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (342, 64, 'Табельщик', 284898503);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (343, 225, 'Копировщик', 549852567);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (344, 218, 'Инженер по подготовке производства', 25092436);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (345, 162, 'Переводчик-дактилолог', 390512574);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (346, 413, 'Начальник производственной лаборатории (по контролю производства)', 53439888);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (347, 114, 'Главный сварщик', 773277519);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (348, 387, 'Начальник отдела подготовки кадров', 704254139);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (349, 60, 'Ведущий конструктор', 171447209);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (350, 4, 'Заведующий архивом', 704414332);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (351, 39, 'Начальник смены', 405381239);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (352, 432, 'Экономист по сбыту', 322244921);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (353, 160, 'Мастер участка', 632029830);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (354, 48, 'Секретарь руководителя', 433470737);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (355, 180, 'Ведущий инженер', 322829273);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (356, 431, 'Главный механик', 686873556);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (357, 141, 'Инспектор по кадрам', 634939155);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (358, 166, 'Научный сотрудник', 294169593);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (359, 450, 'Начальник отдела маркетинга', 526637320);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (360, 82, 'Техник по труду', 514809957);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (361, 122, 'Главный бухгалтер', 216055911);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (362, 58, 'Художник', 658162904);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (363, 300, 'Заведующий камерой хранения', 625865113);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (364, 367, 'Математик', 588461049);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (365, 106, 'Начальник исследовательской лаборатории', 660378989);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (366, 305, 'Заведующий складом', 752809590);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (367, 141, 'Инженер-технолог (технолог)', 88018246);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (368, 266, 'Инженер по подготовке кадров', 276144572);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (369, 271, 'Ведущий экономист', 185723065);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (370, 123, 'Инженер по нормированию труда', 125506472);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (371, 43, 'Экономист по сбыту', 624618876);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (372, 13, 'Младший научный сотрудник', 429973208);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (373, 133, 'Научный редактор', 719729330);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (374, 399, 'Брокер', 493514414);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (375, 164, 'Агент коммерческий', 358192525);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (376, 421, 'Заведующий техническим архивом', 51048442);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (377, 39, 'Начальник производственного отдела', 396650730);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (378, 168, 'Заведующий отделом (бюро) оформления проектных материалов', 524544217);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (379, 379, 'Ведущий конструктор', 154635662);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (380, 348, 'Комендант', 198215937);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (381, 1, 'Комендант', 34066980);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (382, 496, 'Аукционист', 239819929);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (383, 245, 'Главный инженер проекта. Главный архитектор проекта', 308403991);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (384, 29, 'Инженер по надзору за строительством', 523576008);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (385, 142, 'Инспектор по контролю за исполнением поручений', 377538598);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (386, 421, 'Агент', 245639020);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (387, 284, 'Директор (генеральный директор, управляющий) предприятия', 224187285);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (388, 363, 'Оператор диспетчерской движения и погрузочно-разгрузочных работ', 700130728);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (389, 355, 'Инженер по подготовке производства', 564715449);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (390, 457, 'Инженер', 318598078);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (391, 409, 'Экономист по труду', 410639061);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (392, 496, 'Инженер по качеству', 124344183);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (393, 215, 'Экономист', 548566882);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (394, 360, 'Экономист по сбыту', 469690331);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (395, 479, 'Главный технолог', 564770921);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (396, 251, 'Редактор', 131764567);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (397, 226, 'Лаборант', 785110232);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (398, 487, 'Начальник ремонтного цеха', 99669507);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (399, 415, 'Начальник отдела сбыта', 605936023);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (400, 400, 'Директор (начальник) учреждения (организации)', 286461923);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (401, 330, 'Ученый секретарь', 364806567);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (402, 45, 'Начальник финансового отдела', 544077461);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (403, 170, 'Менеджер по рекламе', 368560653);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (404, 345, 'Специалист по связям с общественностью', 655044370);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (405, 478, 'Нарядчик', 619703763);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (406, 209, 'Заведующий чертежно-копировальным бюро', 521157416);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (407, 423, 'Техник вычислительного (информационно-вычислительного) центра', 633769187);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (408, 344, 'Дежурный бюро пропусков', 362713371);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (409, 283, 'Директор гостиницы', 613868599);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (410, 79, 'Техник-проектировщик', 590360356);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (411, 482, 'Переводчик', 466601273);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (412, 236, 'Хронометражист', 373481608);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (413, 468, 'Лаборант', 431564179);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (414, 474, 'Директор гостиницы', 667863031);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (415, 241, 'Психолог', 463608998);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (416, 362, 'Заведующий фотолабораторией', 729133608);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (417, 484, 'Начальник отдела материально-технического снабжения', 426602478);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (418, 119, 'Дежурный бюро пропусков', 112911292);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (419, 479, 'Бухгалтер-ревизор', 217893782);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (420, 251, 'Инженер по метрологии', 709472031);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (421, 52, 'Главный инженер', 361978839);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (422, 321, 'Главный научный сотрудник', 613238172);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (423, 330, 'Заведующий фотолабораторией', 516795154);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (424, 426, 'Техник-лаборант', 76653567);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (425, 219, 'Главный специалист в основном отделе (архитектурно-планировочной мастерской)', 296945079);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (426, 36, 'Заведующий жилым корпусом пансионата (гостиницы)', 150648474);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (427, 428, 'Заведующий столовой', 628564828);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (428, 345, 'Директор типографии', 793793008);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (429, 120, 'Начальник отдела подготовки кадров', 528621244);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (430, 404, 'Инженер-конструктор (конструктор)', 257444592);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (431, 489, 'Менеджер по связям с общественностью', 491971399);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (432, 79, 'Специалист по защите информации', 704288547);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (433, 169, 'Инженер по ремонту', 639359777);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (434, 311, 'Эксперт', 201891172);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (435, 290, 'Техник по защите информации', 437210740);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (436, 316, 'Ассистент инспектора фонда', 170321292);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (437, 446, 'Дилер', 624943252);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (438, 85, 'Начальник производственного отдела', 158974977);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (439, 86, 'Инженер-программист (программист)', 547310106);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (440, 406, 'Статистик', 456833353);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (441, 307, 'Руководитель группы по инвентаризации строений и сооружений', 56085815);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (442, 39, 'Специалист по защите информации', 116260992);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (443, 326, 'Главный конструктор', 427191064);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (444, 78, 'Главный редактор', 675938477);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (445, 155, 'Таксировщик', 328256056);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (446, 36, 'Начальник отдела (лаборатории, сектора) по защите информации', 310500568);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (447, 323, 'Агент по закупкам', 793503365);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (448, 115, 'Начальник производственной лаборатории (по контролю производства)', 530150857);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (449, 318, 'Администратор', 165998780);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (450, 3, 'Ведущий научный сотрудник', 307886695);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (451, 237, 'Начальник хозяйственного отдела', 448775587);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (452, 366, 'Инженер по метрологии', 786762558);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (453, 118, 'Оценщик интеллектуальной собственности', 317103263);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (454, 408, 'Инженер по метрологии', 222602075);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (455, 69, 'Директор по связям с инвесторами', 458691622);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (456, 135, 'Учетчик', 645362446);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (457, 52, 'Табельщик', 551582412);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (458, 165, 'Корректор', 30801545);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (459, 420, 'Статистик', 389577618);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (460, 79, 'Специалист по защите информации', 373039728);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (461, 466, 'Начальник отдела сбыта', 438266217);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (462, 119, 'Менеджер по персоналу', 638886491);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (463, 119, 'Художник-конструктор (дизайнер)', 425409364);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (464, 43, 'Инженер по охране окружающей среды (эколог)', 308649138);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (465, 91, 'Документовед', 425855580);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (466, 342, 'Руководитель подразделения', 211380171);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (467, 442, 'Биржевой маклер', 145629711);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (468, 440, 'Хронометражист', 638610377);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (469, 314, 'Инженер по ремонту', 360504343);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (470, 277, 'Учетчик', 249691200);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (471, 65, 'Начальник ремонтного цеха', 66782388);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (472, 35, 'Ассистент инспектора фонда', 385721099);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (473, 240, 'Корпоративный секретарь акционерного общества', 742906863);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (474, 156, 'Биржевой маклер', 454258337);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (475, 261, 'Старший научный сотрудник', 242804092);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (476, 141, 'Начальник автоколонны', 337137079);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (477, 44, 'Инженер по автоматизации и механизации производственных процессов', 772043209);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (478, 448, 'Ассистент инспектора фонда', 716111976);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (479, 377, 'Специалист по связям с общественностью', 523860677);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (480, 262, 'Начальник центральной заводской лаборатории', 87681959);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (481, 106, 'Директор (начальник) учреждения (организации)', 605635737);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (482, 233, 'Начальник гаража', 306733712);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (483, 327, 'Заместитель директора по капитальному строительству', 336585284);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (484, 51, 'Брокер торговый', 47694046);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (485, 323, 'Агент по снабжению', 607307280);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (486, 348, 'Начальник отдела по связям с инвесторами', 135046152);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (487, 6, 'Специалист по оценке соответствия лифтов требованиям безопасности', 198618056);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (488, 44, 'Инженер по инструменту', 37763670);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (489, 384, 'Художественный редактор', 438084625);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (490, 188, 'Начальник гаража', 481021350);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (491, 474, 'Директор гостиницы', 110145389);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (492, 259, 'Начальник отдела материально-технического снабжения', 492127910);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (493, 159, 'Начальник отдела патентной и изобретательской работы', 331539342);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (494, 382, 'Инженер по защите информации', 708279990);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (495, 421, 'Заведующий архивом', 311698292);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (496, 168, 'Начальник отдела социального развития', 629361530);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (497, 233, 'Главный метролог', 625244177);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (498, 198, 'Экономист по планированию', 666509012);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (499, 290, 'Начальник отдела автоматизированной системы управления производством (АСУП)', 210368445);
INSERT INTO public.job_title (id_job_title, id_department, job_title, salary) OVERRIDING SYSTEM VALUE VALUES (500, 254, 'Инженер по нормированию труда', 595436933);


--
-- TOC entry 3664 (class 0 OID 16528)
-- Dependencies: 214
-- Data for Name: project; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (45, 115, 315, 'приостановлен', 'коренной курс', '2010-06-22', 693962513, 'внесена предоплата', '2027-09-11', '2030-05-14', 1);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (132, 230, 345, 'приостановлен', 'атомный земля', '2059-08-09', 85759580, 'внесена предоплата', '2061-06-09', '2064-05-06', 2);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (26, 32, 258, 'приостановлен', 'банальный итог', '2073-06-18', 540990367, 'полностью оплачен', '2007-05-27', '2009-09-06', 3);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (223, 59, 437, 'приостановлен', 'экспертный характеристика', '2038-03-27', 60597389, 'полностью оплачен', '2018-11-25', '2019-07-23', 4);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (451, 202, 428, 'приостановлен', 'лишний совесть', '2053-05-05', 449289951, 'внесена предоплата', '2002-09-04', '2003-04-08', 5);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (238, 129, 462, 'в процессе', 'полноценный проверка', '2007-06-16', 446800364, 'полностью оплачен', '2001-10-13', '2003-06-26', 6);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (330, 99, 445, 'не начат', 'открытый вечер', '2037-04-25', 766397215, 'не оплачен', '2029-08-28', '2031-06-24', 7);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (384, 53, 429, 'приостановлен', 'деловой документ', '2032-10-18', 625089331, 'не оплачен', '2063-06-19', '2066-06-06', 8);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (325, 141, 435, 'выполнен', 'действительный самолет', '2031-04-24', 536890601, 'внесена предоплата', '2041-06-18', '2044-04-10', 9);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (293, 71, 400, 'выполнен', 'загадочный президент', '2073-11-04', 656315730, 'полностью оплачен', '2031-05-09', '2032-12-26', 10);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (344, 24, 402, 'в процессе', 'временной слой', '2028-12-22', 691594670, 'полностью оплачен', '2009-04-24', '2010-04-24', 11);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (462, 137, 426, 'не начат', 'атомный армия', '2014-11-15', 523952497, 'внесена предоплата', '2042-02-23', '2044-07-28', 12);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (480, 105, 329, 'выполнен', 'прогрессивный соглашение', '2040-02-17', 615657742, 'внесена предоплата', '2077-03-15', '2079-10-08', 13);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (148, 96, 436, 'в процессе', 'универсальный читатель', '2062-09-22', 796432170, 'внесена предоплата', '2034-06-02', '2035-08-01', 14);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (380, 117, 341, 'не начат', 'жалкий пора', '2070-04-16', 646467426, 'не оплачен', '2071-05-05', '2074-05-28', 15);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (432, 192, 350, 'приостановлен', 'относительный столица', '2051-02-10', 325160495, 'полностью оплачен', '2018-02-17', '2021-02-14', 16);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (93, 118, 287, 'не начат', 'лишний команда', '2012-07-18', 701437655, 'полностью оплачен', '2042-10-22', '2044-09-26', 17);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (86, 191, 275, 'не начат', 'программный кресло', '2007-10-09', 302933052, 'полностью оплачен', '2055-10-13', '2058-06-14', 18);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (347, 239, 476, 'в процессе', 'чрезвычайный рука', '2061-12-18', 799869586, 'полностью оплачен', '2049-04-10', '2050-07-16', 19);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (199, 191, 475, 'не начат', 'откровенный рубеж', '2088-01-18', 701077785, 'не оплачен', '2047-05-13', '2049-07-02', 20);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (224, 195, 487, 'в процессе', 'вчерашний изображение', '2044-10-17', 516610979, 'полностью оплачен', '2075-01-19', '2078-10-10', 21);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (410, 138, 481, 'выполнен', 'органический сюжет', '2079-02-28', 629299815, 'не оплачен', '2050-05-11', '2052-07-27', 22);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (472, 59, 344, 'не начат', 'талантливый отказ', '2019-05-04', 286521376, 'полностью оплачен', '2060-10-09', '2063-02-12', 23);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (70, 141, 366, 'в процессе', 'великолепный данные', '2083-10-06', 692546453, 'внесена предоплата', '2036-10-27', '2037-10-17', 24);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (16, 149, 455, 'не начат', 'совместный комитет', '2048-09-17', 718503582, 'полностью оплачен', '2047-07-06', '2050-06-04', 25);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (432, 45, 473, 'в процессе', 'эстетический граница', '2000-01-01', 113998053, 'не оплачен', '2060-04-28', '2061-11-09', 26);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (260, 249, 489, 'выполнен', 'звездный мальчишка', '2048-12-20', 224634353, 'полностью оплачен', '2071-05-23', '2074-05-07', 27);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (150, 15, 257, 'выполнен', 'ужасный сигнал', '2067-02-18', 380772518, 'не оплачен', '2034-03-09', '2037-07-18', 28);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (62, 12, 434, 'не начат', 'всякий цена', '2082-04-22', 51631166, 'полностью оплачен', '2028-02-26', '2031-05-24', 29);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (326, 144, 399, 'не начат', 'символический вкус', '2074-07-04', 709982199, 'внесена предоплата', '2019-09-26', '2020-08-19', 30);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (281, 209, 273, 'в процессе', 'последующий достижение', '2085-10-17', 389379505, 'внесена предоплата', '2028-07-18', '2030-07-01', 31);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (62, 133, 366, 'приостановлен', 'банковский признак', '2043-02-02', 667475062, 'не оплачен', '2022-04-13', '2025-06-14', 32);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (356, 113, 362, 'приостановлен', 'сухой ребенок', '2067-11-22', 502627094, 'внесена предоплата', '2075-09-26', '2077-03-07', 33);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (165, 243, 281, 'приостановлен', 'ледяной раз', '2053-02-05', 161761916, 'полностью оплачен', '2022-06-18', '2025-06-05', 34);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (35, 88, 378, 'не начат', 'жалкий определение', '2019-05-03', 139550974, 'внесена предоплата', '2022-02-16', '2023-10-09', 35);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (369, 168, 497, 'не начат', 'убежденный комитет', '2088-10-17', 314301375, 'полностью оплачен', '2082-06-01', '2083-10-15', 36);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (64, 176, 369, 'не начат', 'краткий изменение', '2013-06-03', 150425258, 'не оплачен', '2007-07-22', '2009-01-14', 37);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (14, 179, 482, 'не начат', 'весенний рост', '2072-06-21', 72337411, 'не оплачен', '2035-12-26', '2036-08-12', 38);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (356, 112, 310, 'не начат', 'пьяный ряд', '2079-01-27', 493674772, 'полностью оплачен', '2065-02-13', '2068-03-02', 39);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (120, 100, 500, 'выполнен', 'криминальный крик', '2046-10-21', 438339033, 'не оплачен', '2046-12-13', '2048-09-17', 40);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (409, 224, 419, 'приостановлен', 'позитивный письмо', '2034-07-01', 60272700, 'внесена предоплата', '2090-06-14', '2092-06-24', 41);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (242, 159, 266, 'не начат', 'символический журнал', '2001-11-11', 646937225, 'не оплачен', '2087-04-27', '2089-10-12', 42);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (85, 162, 420, 'не начат', 'теплый голова', '2076-07-28', 387687685, 'не оплачен', '2038-01-04', '2040-08-09', 43);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (159, 144, 486, 'выполнен', 'северный герой', '2052-09-08', 539135740, 'не оплачен', '2017-09-03', '2018-05-26', 44);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (471, 141, 380, 'выполнен', 'советский бизнес', '2051-09-08', 765256901, 'внесена предоплата', '2059-08-01', '2060-09-01', 45);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (59, 212, 388, 'приостановлен', 'передовой эксплуатация', '2083-07-22', 200424792, 'полностью оплачен', '2007-09-13', '2010-09-12', 46);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (84, 64, 406, 'выполнен', 'голодный источник', '2053-06-25', 74701482, 'полностью оплачен', '2024-02-05', '2025-10-27', 47);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (369, 72, 381, 'выполнен', 'киевский деньги', '2063-05-09', 77322452, 'внесена предоплата', '2006-04-04', '2007-04-25', 48);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (219, 163, 422, 'не начат', 'лишенный ошибка', '2001-12-11', 68697671, 'не оплачен', '2063-05-08', '2066-10-12', 49);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (25, 106, 311, 'выполнен', 'умственный лошадь', '2057-03-11', 67430287, 'не оплачен', '2082-12-28', '2083-06-23', 50);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (104, 143, 257, 'в процессе', 'милицейский бог', '2085-04-19', 521588452, 'внесена предоплата', '2090-05-15', '2093-07-18', 51);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (196, 166, 361, 'выполнен', 'лишний линия', '2017-06-04', 36608985, 'внесена предоплата', '2017-11-24', '2019-09-27', 52);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (405, 86, 436, 'выполнен', 'единый прокурор', '2030-07-04', 24256186, 'внесена предоплата', '2074-08-26', '2076-04-26', 53);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (362, 221, 401, 'в процессе', 'озабоченный норма', '2032-05-18', 390487867, 'не оплачен', '2045-03-08', '2047-01-08', 54);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (31, 7, 480, 'в процессе', 'организованный слава', '2065-07-16', 204890608, 'не оплачен', '2020-10-23', '2021-02-09', 55);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (254, 55, 342, 'выполнен', 'функциональный урок', '2036-03-04', 188190337, 'внесена предоплата', '2082-10-04', '2084-06-01', 56);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (423, 154, 339, 'не начат', 'светский полоса', '2033-08-03', 422844293, 'внесена предоплата', '2085-10-22', '2086-01-23', 57);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (306, 6, 323, 'не начат', 'электрический сын', '2058-01-03', 40975393, 'внесена предоплата', '2060-11-19', '2061-10-19', 58);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (169, 109, 454, 'в процессе', 'двойной место', '2005-05-22', 105383211, 'полностью оплачен', '2032-11-28', '2035-10-09', 59);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (219, 222, 407, 'выполнен', 'крепкий прокурор', '2037-09-06', 584092653, 'полностью оплачен', '2050-10-07', '2052-07-03', 60);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (236, 152, 367, 'выполнен', 'седой свобода', '2036-04-25', 376248879, 'внесена предоплата', '2077-06-15', '2079-03-27', 61);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (391, 148, 290, 'выполнен', 'стройный единица', '2027-12-01', 417651665, 'полностью оплачен', '2018-12-20', '2019-10-26', 62);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (464, 178, 372, 'выполнен', 'смертельный рисунок', '2069-02-21', 253282426, 'не оплачен', '2075-12-27', '2078-06-13', 63);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (371, 249, 385, 'приостановлен', 'симпатичный обязанность', '2003-05-28', 620943481, 'полностью оплачен', '2039-08-21', '2041-07-19', 64);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (289, 195, 373, 'выполнен', 'действующий предприятие', '2079-05-27', 36776873, 'внесена предоплата', '2027-09-16', '2029-06-05', 65);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (369, 195, 323, 'приостановлен', 'молодой окончание', '2009-08-12', 604037123, 'полностью оплачен', '2035-04-27', '2038-01-09', 66);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (295, 85, 406, 'приостановлен', 'региональный искусство', '2000-10-07', 614514951, 'внесена предоплата', '2048-02-14', '2050-01-18', 67);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (455, 231, 320, 'в процессе', 'пушкинский единица', '2006-10-14', 732384323, 'не оплачен', '2082-05-25', '2085-11-09', 68);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (404, 31, 296, 'выполнен', 'каменный фотография', '2073-03-02', 488318459, 'полностью оплачен', '2055-11-10', '2056-11-17', 69);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (69, 133, 308, 'приостановлен', 'преступный надежда', '2024-07-10', 748240282, 'внесена предоплата', '2072-06-23', '2074-07-16', 70);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (215, 56, 433, 'приостановлен', 'человеческий хвост', '2084-11-01', 731510157, 'не оплачен', '2037-04-24', '2040-05-19', 71);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (181, 97, 433, 'в процессе', 'головной содержание', '2070-01-10', 509436413, 'полностью оплачен', '2053-02-21', '2055-07-02', 72);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (178, 142, 406, 'выполнен', 'капитальный тело', '2084-01-16', 372343939, 'не оплачен', '2041-04-14', '2042-05-14', 73);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (91, 189, 397, 'в процессе', 'голодный постель', '2077-05-19', 275521310, 'внесена предоплата', '2006-06-07', '2007-09-26', 74);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (66, 187, 442, 'выполнен', 'атомный министр', '2047-08-25', 197610818, 'внесена предоплата', '2038-01-06', '2039-11-10', 75);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (249, 192, 285, 'приостановлен', 'всякий ощущение', '2081-11-01', 788592675, 'не оплачен', '2049-11-25', '2051-10-21', 76);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (500, 209, 428, 'в процессе', 'романтический клетка', '2037-05-26', 754042030, 'внесена предоплата', '2029-03-23', '2032-04-09', 77);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (493, 152, 290, 'приостановлен', 'исключительный брак', '2061-01-06', 402240517, 'внесена предоплата', '2066-10-02', '2068-12-22', 78);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (162, 226, 400, 'не начат', 'лишний служба', '2030-05-13', 120310132, 'внесена предоплата', '2086-02-11', '2088-11-04', 79);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (458, 31, 388, 'в процессе', 'скрытый поведение', '2070-11-05', 498006381, 'полностью оплачен', '2055-06-08', '2056-06-21', 80);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (212, 112, 298, 'в процессе', 'либеральный воздух', '2030-02-17', 560230800, 'полностью оплачен', '2016-05-10', '2017-10-10', 81);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (138, 146, 323, 'в процессе', 'хитрый кольцо', '2023-12-27', 150451453, 'внесена предоплата', '2029-10-11', '2031-06-01', 82);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (339, 9, 331, 'не начат', 'официальный грудь', '2032-09-05', 624963245, 'внесена предоплата', '2069-08-07', '2071-10-13', 83);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (227, 222, 421, 'в процессе', 'сельский предмет', '2043-07-19', 531650135, 'не оплачен', '2068-05-20', '2071-11-20', 84);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (38, 108, 491, 'приостановлен', 'сегодняшний честь', '2074-12-28', 94604547, 'не оплачен', '2047-01-09', '2048-02-05', 85);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (87, 157, 413, 'выполнен', 'любовный соединение', '2029-09-14', 680219712, 'не оплачен', '2012-04-26', '2014-09-09', 86);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (326, 60, 420, 'не начат', 'ленинский деньги', '2079-11-23', 288018895, 'внесена предоплата', '2069-10-11', '2070-03-06', 87);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (30, 240, 308, 'приостановлен', 'колючий щека', '2044-12-24', 454654810, 'внесена предоплата', '2025-03-21', '2028-10-02', 88);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (213, 242, 390, 'в процессе', 'синий монастырь', '2047-07-24', 205091975, 'не оплачен', '2087-03-06', '2090-07-14', 89);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (308, 25, 411, 'выполнен', 'позитивный миллион', '2086-12-26', 114282277, 'полностью оплачен', '2077-02-18', '2080-06-01', 90);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (83, 111, 467, 'не начат', 'фундаментальный повышение', '2070-09-20', 108423080, 'полностью оплачен', '2051-06-04', '2054-05-08', 91);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (412, 99, 474, 'приостановлен', 'окончательный выступление', '2026-08-06', 523626412, 'полностью оплачен', '2052-09-01', '2053-10-19', 92);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (169, 74, 383, 'приостановлен', 'юридический дружба', '2079-08-27', 601025970, 'внесена предоплата', '2001-01-13', '2003-04-25', 93);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (206, 46, 500, 'не начат', 'надежный банк', '2004-03-06', 258191774, 'внесена предоплата', '2008-09-22', '2011-04-23', 94);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (389, 222, 452, 'выполнен', 'просторный рост', '2000-01-07', 556282119, 'внесена предоплата', '2031-09-28', '2033-08-22', 95);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (466, 157, 388, 'приостановлен', 'плотный улица', '2043-08-11', 325220425, 'полностью оплачен', '2087-09-19', '2088-09-17', 96);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (305, 91, 413, 'приостановлен', 'транспортный коллега', '2063-06-11', 599728162, 'внесена предоплата', '2012-04-14', '2015-03-24', 97);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (221, 49, 355, 'приостановлен', 'заинтересованный платье', '2000-11-12', 390340943, 'внесена предоплата', '2007-11-18', '2008-09-05', 98);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (230, 86, 490, 'выполнен', 'странный баба', '2087-10-20', 285178053, 'полностью оплачен', '2070-12-02', '2072-09-15', 99);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (155, 76, 449, 'не начат', 'региональный система', '2086-09-04', 462015279, 'не оплачен', '2039-05-05', '2042-10-03', 100);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (342, 224, 382, 'в процессе', 'восточный слава', '2085-07-10', 437295670, 'не оплачен', '2037-11-17', '2040-11-25', 101);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (352, 94, 263, 'выполнен', 'современный сигарета', '2084-05-03', 543827601, 'внесена предоплата', '2007-01-12', '2009-10-01', 102);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (169, 22, 446, 'в процессе', 'ленинский отличие', '2064-04-15', 546189539, 'полностью оплачен', '2010-01-10', '2011-09-26', 103);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (244, 159, 297, 'выполнен', 'дальний появление', '2078-11-19', 741028053, 'не оплачен', '2090-06-21', '2091-11-14', 104);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (226, 91, 269, 'не начат', 'предметный правда', '2027-08-14', 492545558, 'полностью оплачен', '2080-02-10', '2082-07-19', 105);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (371, 184, 373, 'в процессе', 'ненужный союз', '2066-10-03', 650582841, 'полностью оплачен', '2041-04-03', '2042-10-13', 106);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (331, 13, 450, 'приостановлен', 'божественный письмо', '2063-06-13', 353623314, 'внесена предоплата', '2052-02-23', '2054-10-19', 107);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (134, 107, 490, 'в процессе', 'удивительный горло', '2051-05-10', 736420189, 'внесена предоплата', '2082-11-22', '2085-02-10', 108);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (338, 46, 412, 'в процессе', 'входной тип', '2014-08-08', 233007704, 'внесена предоплата', '2002-07-27', '2003-01-19', 109);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (116, 207, 401, 'выполнен', 'ранний запись', '2047-07-14', 323480236, 'не оплачен', '2061-06-14', '2064-01-05', 110);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (440, 133, 417, 'выполнен', 'чувствительный сентябрь', '2061-03-17', 253467288, 'не оплачен', '2082-07-08', '2083-07-24', 111);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (472, 143, 351, 'приостановлен', 'серьезный мешок', '2085-12-19', 367789945, 'внесена предоплата', '2008-08-22', '2010-08-02', 112);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (408, 165, 363, 'не начат', 'убежденный суть', '2073-06-11', 173711946, 'полностью оплачен', '2011-08-10', '2014-02-09', 113);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (161, 20, 346, 'приостановлен', 'талантливый осень', '2006-05-13', 538228523, 'внесена предоплата', '2035-08-25', '2037-08-19', 114);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (53, 164, 483, 'в процессе', 'смешной основа', '2028-08-15', 62115782, 'не оплачен', '2006-10-01', '2007-07-09', 115);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (331, 226, 332, 'не начат', 'очевидный стиль', '2026-08-28', 690925120, 'полностью оплачен', '2007-10-03', '2008-04-21', 116);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (375, 129, 421, 'выполнен', 'кожаный тип', '2030-12-21', 466252837, 'не оплачен', '2009-04-06', '2010-02-04', 117);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (82, 73, 429, 'выполнен', 'федеральный служба', '2037-11-27', 387464659, 'полностью оплачен', '2046-10-12', '2048-08-02', 118);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (465, 145, 322, 'выполнен', 'прогрессивный запас', '2082-10-18', 294706770, 'полностью оплачен', '2026-08-10', '2028-01-01', 119);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (261, 133, 484, 'не начат', 'голый танк', '2038-01-28', 283838162, 'полностью оплачен', '2045-04-09', '2047-01-11', 120);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (399, 61, 375, 'не начат', 'добровольный кольцо', '2049-11-28', 570819513, 'полностью оплачен', '2073-06-24', '2075-06-19', 121);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (232, 38, 356, 'приостановлен', 'боковой слово', '2065-10-22', 80835398, 'не оплачен', '2055-01-02', '2058-07-22', 122);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (89, 117, 378, 'не начат', 'программный ключ', '2019-07-02', 480921921, 'полностью оплачен', '2031-04-01', '2032-11-17', 123);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (283, 174, 382, 'приостановлен', 'неплохой молоко', '2019-07-05', 645502081, 'не оплачен', '1999-01-07', '2002-08-25', 124);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (419, 182, 407, 'приостановлен', 'потенциальный рисунок', '2040-01-11', 748245772, 'полностью оплачен', '2056-07-17', '2057-12-07', 125);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (407, 81, 253, 'не начат', 'пушкинский пункт', '2015-12-22', 126303328, 'полностью оплачен', '2078-02-18', '2081-04-08', 126);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (201, 133, 253, 'в процессе', 'верхний кухня', '2028-08-16', 152006559, 'не оплачен', '2064-04-08', '2067-01-27', 127);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (266, 160, 283, 'выполнен', 'ежегодный народ', '2008-11-09', 690091649, 'не оплачен', '2046-12-10', '2049-11-24', 128);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (405, 90, 348, 'в процессе', 'транспортный академия', '2055-03-02', 766081545, 'не оплачен', '2058-05-04', '2060-06-14', 129);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (272, 168, 443, 'приостановлен', 'криминальный реализация', '2057-02-19', 550140048, 'внесена предоплата', '2050-08-19', '2051-12-21', 130);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (116, 214, 283, 'выполнен', 'предметный большинство', '2013-08-02', 794595423, 'полностью оплачен', '2005-11-07', '2006-07-04', 131);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (479, 4, 392, 'в процессе', 'законный деньги', '2047-02-19', 462574214, 'внесена предоплата', '2086-04-10', '2089-09-27', 132);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (470, 215, 418, 'приостановлен', 'узкий проблема', '2022-08-25', 53397586, 'внесена предоплата', '2040-03-26', '2042-03-12', 133);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (366, 248, 472, 'выполнен', 'худой сын', '2055-12-09', 537068994, 'полностью оплачен', '2029-02-07', '2030-04-24', 134);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (384, 112, 466, 'выполнен', 'бумажный итог', '2077-08-16', 188729526, 'внесена предоплата', '2059-03-23', '2060-02-09', 135);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (304, 223, 481, 'приостановлен', 'самарский суд', '2083-01-24', 71375151, 'внесена предоплата', '2054-11-21', '2056-11-26', 136);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (76, 54, 393, 'выполнен', 'учебный орган', '2027-08-27', 653909744, 'внесена предоплата', '2035-10-21', '2038-06-03', 137);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (456, 115, 403, 'выполнен', 'искусственный служба', '2088-10-24', 394814598, 'не оплачен', '1999-03-25', '2002-11-06', 138);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (221, 103, 477, 'приостановлен', 'легендарный сюжет', '2027-05-18', 107745562, 'не оплачен', '2020-02-15', '2022-05-17', 139);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (342, 191, 447, 'не начат', 'смутный председатель', '2045-04-20', 683450128, 'внесена предоплата', '2009-04-27', '2012-10-14', 140);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (326, 185, 287, 'в процессе', 'научный станция', '2089-03-03', 76507846, 'не оплачен', '2070-03-11', '2073-04-14', 141);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (432, 141, 340, 'в процессе', 'позитивный мир', '2044-11-28', 611302304, 'полностью оплачен', '2026-03-22', '2027-01-25', 142);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (252, 222, 334, 'выполнен', 'деловой море', '2031-09-14', 461955471, 'внесена предоплата', '2066-01-04', '2067-12-26', 143);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (254, 139, 369, 'в процессе', 'убежденный еда', '2072-05-08', 777770691, 'полностью оплачен', '2085-01-02', '2087-12-13', 144);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (321, 133, 481, 'не начат', 'пыльный полковник', '2082-03-26', 157335774, 'не оплачен', '2082-12-01', '2085-07-21', 145);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (142, 49, 286, 'не начат', 'абстрактный достоинство', '2012-05-09', 535523641, 'полностью оплачен', '2037-07-21', '2038-11-08', 146);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (234, 6, 295, 'не начат', 'единый проблема', '2000-09-02', 516074164, 'полностью оплачен', '2016-05-26', '2018-11-22', 147);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (490, 217, 288, 'приостановлен', 'загадочный лошадь', '2080-03-12', 405398155, 'не оплачен', '2085-04-10', '2086-06-25', 148);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (396, 132, 295, 'в процессе', 'домашний вещь', '2000-10-18', 145578146, 'не оплачен', '2011-06-27', '2013-12-21', 149);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (322, 100, 369, 'не начат', 'киевский позиция', '2082-10-22', 580387842, 'полностью оплачен', '2010-10-17', '2013-04-21', 150);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (269, 165, 327, 'приостановлен', 'подводной эпоха', '2016-11-05', 598035368, 'полностью оплачен', '2005-01-16', '2006-09-19', 151);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (183, 105, 412, 'приостановлен', 'звездный танец', '2026-03-19', 683264932, 'не оплачен', '2075-07-05', '2078-03-25', 152);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (265, 42, 476, 'не начат', 'мужской окончание', '2042-10-02', 230516857, 'внесена предоплата', '2087-05-17', '2089-09-21', 153);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (63, 226, 258, 'в процессе', 'очередной мнение', '2022-01-17', 166112512, 'внесена предоплата', '2065-04-17', '2068-10-13', 154);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (144, 145, 315, 'не начат', 'предельный выпуск', '2072-02-12', 363426032, 'не оплачен', '2011-03-02', '2013-06-10', 155);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (364, 209, 411, 'не начат', 'энергичный подруга', '2021-10-19', 636750921, 'полностью оплачен', '2082-05-21', '2085-06-13', 156);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (458, 61, 443, 'в процессе', 'голодный разработка', '2044-08-20', 669234243, 'полностью оплачен', '2040-01-22', '2043-01-07', 157);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (186, 146, 430, 'приостановлен', 'женский зритель', '2033-06-13', 503698871, 'внесена предоплата', '2025-01-21', '2027-11-28', 158);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (449, 72, 488, 'в процессе', 'коричневый зависимость', '1999-07-10', 774507444, 'не оплачен', '2024-02-28', '2027-12-08', 159);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (383, 212, 386, 'приостановлен', 'одетый пиво', '2067-05-16', 493435109, 'полностью оплачен', '2000-09-13', '2002-07-19', 160);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (288, 126, 480, 'не начат', 'параллельный инструмент', '2064-11-25', 622013142, 'полностью оплачен', '2055-11-10', '2057-12-07', 161);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (169, 138, 315, 'не начат', 'эффективный ребенок', '2051-10-27', 502146431, 'полностью оплачен', '2086-08-14', '2087-06-07', 162);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (401, 27, 260, 'выполнен', 'сомнительный вкус', '2077-08-09', 405374682, 'полностью оплачен', '2017-09-04', '2020-06-12', 163);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (395, 112, 412, 'в процессе', 'вертикальный подъезд', '2023-10-01', 158221131, 'полностью оплачен', '2066-10-28', '2069-12-08', 164);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (226, 206, 413, 'приостановлен', 'разнообразный реализация', '2000-05-12', 22513341, 'полностью оплачен', '2019-02-05', '2022-10-24', 165);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (88, 89, 469, 'выполнен', 'молочный замок', '2011-11-19', 223781014, 'полностью оплачен', '2015-10-28', '2017-11-19', 166);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (322, 89, 489, 'в процессе', 'криминальный пенсия', '2051-07-06', 94981685, 'полностью оплачен', '2030-10-07', '2031-08-11', 167);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (336, 16, 302, 'выполнен', 'окружающий председатель', '2083-12-07', 197797783, 'не оплачен', '2040-03-19', '2042-10-17', 168);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (416, 44, 265, 'выполнен', 'должный водитель', '2057-03-12', 586126020, 'внесена предоплата', '2010-05-28', '2011-02-21', 169);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (93, 8, 284, 'в процессе', 'женский препарат', '2032-08-25', 161544083, 'не оплачен', '2030-07-06', '2032-11-09', 170);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (419, 115, 442, 'в процессе', 'влюбленный колесо', '2030-04-12', 454533732, 'полностью оплачен', '2054-12-23', '2056-03-20', 171);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (223, 9, 418, 'выполнен', 'целый краска', '2014-02-25', 738382958, 'не оплачен', '2073-05-15', '2074-08-09', 172);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (460, 26, 258, 'приостановлен', 'искренний документ', '2057-08-12', 723378259, 'не оплачен', '2016-01-28', '2018-10-03', 173);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (295, 102, 366, 'не начат', 'бешеный смерть', '2086-08-23', 798575670, 'полностью оплачен', '2055-11-12', '2056-10-09', 174);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (261, 214, 484, 'в процессе', 'акционерный миг', '2063-03-08', 560085450, 'полностью оплачен', '2001-03-28', '2003-02-28', 175);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (224, 93, 305, 'приостановлен', 'полный понятие', '2076-09-14', 138927819, 'не оплачен', '2000-03-23', '2002-10-24', 176);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (107, 65, 378, 'не начат', 'мясной ремонт', '2050-08-18', 100927875, 'не оплачен', '2011-05-17', '2014-10-28', 177);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (323, 141, 332, 'выполнен', 'старинный сын', '2020-03-02', 431410775, 'полностью оплачен', '2066-07-08', '2067-03-02', 178);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (202, 122, 351, 'в процессе', 'мировой предмет', '2082-10-10', 396777144, 'полностью оплачен', '2075-10-01', '2077-07-09', 179);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (86, 232, 493, 'приостановлен', 'странный окно', '2074-02-01', 748980723, 'не оплачен', '2000-05-14', '2001-08-13', 180);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (260, 53, 323, 'в процессе', 'данный доля', '2043-08-06', 342606474, 'не оплачен', '2058-12-16', '2060-04-09', 181);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (422, 186, 433, 'выполнен', 'типичный воздействие', '2055-12-12', 550294578, 'полностью оплачен', '2017-04-18', '2020-04-26', 182);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (417, 5, 370, 'в процессе', 'славянский камера', '2044-09-18', 785754078, 'не оплачен', '2017-07-26', '2018-10-09', 183);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (346, 96, 426, 'приостановлен', 'особенный инициатива', '2040-09-14', 214039791, 'полностью оплачен', '2006-03-12', '2007-04-13', 184);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (269, 83, 414, 'в процессе', 'крошечный сюжет', '2082-10-01', 633438263, 'полностью оплачен', '2047-02-12', '2049-05-14', 185);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (68, 50, 420, 'в процессе', 'голодный правило', '2084-07-09', 595514622, 'внесена предоплата', '2057-10-23', '2058-04-22', 186);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (405, 73, 294, 'не начат', 'будущий содержание', '2058-07-26', 585606175, 'полностью оплачен', '2067-04-03', '2070-05-25', 187);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (15, 124, 312, 'приостановлен', 'социалистический список', '2010-02-14', 736854075, 'внесена предоплата', '2055-08-08', '2056-03-20', 188);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (224, 170, 449, 'не начат', 'стандартный тетя', '2060-02-07', 596711004, 'полностью оплачен', '2086-05-01', '2088-06-14', 189);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (187, 246, 338, 'не начат', 'искренний лист', '2007-02-11', 202888981, 'не оплачен', '2071-11-19', '2073-11-10', 190);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (4, 137, 493, 'в процессе', 'странный признак', '2016-07-23', 126551065, 'внесена предоплата', '2011-02-09', '2013-01-05', 191);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (150, 207, 388, 'не начат', 'подводной правда', '2026-03-28', 742155864, 'внесена предоплата', '2063-10-01', '2066-07-07', 192);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (173, 222, 438, 'выполнен', 'лишенный граница', '2077-12-03', 127439648, 'не оплачен', '2037-07-19', '2038-10-20', 193);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (482, 174, 390, 'выполнен', 'стандартный контакт', '2046-11-15', 657506042, 'не оплачен', '2074-05-25', '2075-02-08', 194);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (452, 203, 262, 'в процессе', 'всемирный программа', '2067-03-13', 229959428, 'полностью оплачен', '2062-06-09', '2064-06-14', 195);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (172, 158, 440, 'в процессе', 'социальный река', '2040-08-06', 785854491, 'внесена предоплата', '2052-04-07', '2055-10-20', 196);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (494, 10, 477, 'приостановлен', 'специфический американец', '2071-11-11', 520358057, 'полностью оплачен', '2058-05-15', '2059-05-05', 197);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (4, 87, 255, 'приостановлен', 'значительный кольцо', '2040-08-24', 654858700, 'внесена предоплата', '2011-05-23', '2012-07-13', 198);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (324, 218, 288, 'выполнен', 'особенный колесо', '2027-04-14', 22123623, 'внесена предоплата', '2074-04-13', '2077-11-24', 199);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (484, 225, 339, 'приостановлен', 'горный образец', '2037-12-22', 572197381, 'внесена предоплата', '2032-08-15', '2034-03-28', 200);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (493, 23, 383, 'выполнен', 'молодежный тип', '2053-02-26', 490989836, 'внесена предоплата', '2073-12-05', '2074-01-16', 201);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (218, 102, 264, 'приостановлен', 'многочисленный вечер', '2062-04-17', 312128523, 'полностью оплачен', '2033-07-17', '2035-08-26', 202);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (4, 89, 308, 'в процессе', 'массовый надежда', '2087-01-13', 89260708, 'полностью оплачен', '2075-04-06', '2077-07-28', 203);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (254, 34, 317, 'в процессе', 'мощный дым', '2009-02-08', 669435009, 'не оплачен', '2007-09-04', '2010-01-15', 204);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (303, 186, 433, 'выполнен', 'всевозможный офицер', '2048-11-22', 347441184, 'внесена предоплата', '2075-07-04', '2078-10-27', 205);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (358, 120, 411, 'не начат', 'электрический добро', '2080-06-20', 690935095, 'не оплачен', '2089-12-27', '2090-02-23', 206);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (4, 85, 423, 'приостановлен', 'официальный мечта', '2008-09-03', 591752249, 'полностью оплачен', '2010-05-23', '2013-10-02', 207);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (13, 61, 370, 'не начат', 'небесный сын', '2042-02-12', 439777618, 'внесена предоплата', '2052-09-15', '2054-02-27', 208);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (468, 247, 272, 'выполнен', 'автономный свобода', '2060-12-13', 639107407, 'полностью оплачен', '2003-10-21', '2006-11-08', 209);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (257, 215, 310, 'приостановлен', 'внезапный вывод', '2046-02-03', 343848619, 'полностью оплачен', '2062-04-16', '2064-11-05', 210);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (88, 181, 380, 'в процессе', 'кремлевский ум', '2025-02-27', 721330937, 'не оплачен', '2007-01-10', '2010-08-17', 211);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (32, 79, 325, 'приостановлен', 'теоретический сезон', '2079-12-01', 706865773, 'полностью оплачен', '2019-10-17', '2020-09-25', 212);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (409, 145, 436, 'выполнен', 'служебный сбор', '2026-11-22', 140914046, 'полностью оплачен', '2016-02-18', '2017-04-26', 213);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (431, 30, 276, 'не начат', 'аналитический солнце', '2009-01-07', 419836573, 'полностью оплачен', '2037-11-14', '2038-05-24', 214);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (68, 247, 404, 'приостановлен', 'церковный понятие', '2002-11-16', 276855704, 'не оплачен', '2069-01-28', '2071-05-26', 215);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (9, 177, 449, 'не начат', 'светский платье', '2075-03-22', 86396612, 'внесена предоплата', '2076-09-28', '2079-12-05', 216);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (240, 243, 312, 'приостановлен', 'прошлый реализация', '2047-07-17', 147946935, 'не оплачен', '2024-06-05', '2025-12-20', 217);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (177, 188, 267, 'выполнен', 'стратегический реальность', '2056-11-10', 135739909, 'внесена предоплата', '2069-05-16', '2072-10-08', 218);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (345, 184, 452, 'выполнен', 'ледяной должность', '2016-03-18', 221498496, 'внесена предоплата', '2042-03-12', '2044-07-18', 219);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (162, 145, 328, 'в процессе', 'участковый автобус', '2079-12-17', 392674776, 'полностью оплачен', '2083-04-14', '2084-10-19', 220);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (133, 226, 288, 'в процессе', 'неподвижный совесть', '2021-01-22', 610089955, 'внесена предоплата', '2041-02-06', '2043-11-21', 221);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (393, 61, 388, 'выполнен', 'сомнительный начальство', '2033-02-05', 254034240, 'полностью оплачен', '2047-01-27', '2050-07-19', 222);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (218, 111, 496, 'не начат', 'частный пример', '2025-11-05', 701591913, 'полностью оплачен', '2083-06-07', '2084-12-26', 223);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (8, 48, 356, 'не начат', 'нехороший май', '2054-02-09', 24173575, 'не оплачен', '2063-05-24', '2066-05-26', 224);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (291, 220, 269, 'выполнен', 'методический смена', '2027-10-09', 473785479, 'не оплачен', '2012-05-01', '2013-10-21', 225);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (330, 66, 360, 'выполнен', 'оперативный портрет', '2047-06-19', 458630074, 'не оплачен', '2083-01-08', '2084-12-13', 226);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (97, 143, 333, 'не начат', 'параллельный кадр', '2017-07-23', 346391630, 'внесена предоплата', '2066-05-18', '2069-01-19', 227);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (12, 219, 319, 'приостановлен', 'участковый молоко', '2040-03-04', 310122511, 'полностью оплачен', '2030-11-25', '2033-09-22', 228);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (299, 146, 256, 'приостановлен', 'реальный редактор', '2050-01-27', 428291163, 'внесена предоплата', '2079-12-10', '2081-08-15', 229);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (304, 210, 313, 'в процессе', 'мировой глава', '2049-08-03', 496525156, 'внесена предоплата', '2002-10-02', '2005-12-26', 230);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (446, 166, 456, 'в процессе', 'саратовский технология', '2074-04-01', 41432322, 'внесена предоплата', '2016-04-06', '2019-11-28', 231);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (182, 196, 477, 'выполнен', 'мужской редактор', '1999-05-11', 219546402, 'полностью оплачен', '2013-07-06', '2016-09-22', 232);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (110, 242, 462, 'выполнен', 'повседневный увеличение', '2047-05-24', 779455788, 'полностью оплачен', '2049-12-02', '2051-03-12', 233);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (170, 55, 494, 'в процессе', 'конкретный вид', '2074-06-22', 792589981, 'не оплачен', '2046-10-13', '2047-08-02', 234);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (149, 207, 366, 'выполнен', 'мировой сигарета', '2083-10-15', 603267927, 'полностью оплачен', '2088-01-08', '2089-10-07', 235);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (412, 176, 280, 'в процессе', 'половый человек', '2040-06-20', 713955381, 'внесена предоплата', '2033-10-08', '2034-10-15', 236);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (402, 59, 269, 'приостановлен', 'густой товар', '2083-08-18', 429525760, 'внесена предоплата', '2024-11-11', '2026-08-25', 237);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (71, 66, 473, 'выполнен', 'своеобразный танк', '2060-10-24', 89875363, 'не оплачен', '2050-04-13', '2051-08-23', 238);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (165, 86, 270, 'выполнен', 'здешний партия', '2086-02-09', 130280856, 'внесена предоплата', '2066-09-06', '2069-02-04', 239);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (300, 127, 292, 'в процессе', 'совместный канал', '2080-12-17', 350549966, 'не оплачен', '2022-02-15', '2025-11-09', 240);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (303, 119, 387, 'приостановлен', 'книжный пример', '2000-08-15', 156081414, 'полностью оплачен', '2072-06-02', '2073-12-27', 241);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (289, 221, 302, 'не начат', 'газовый союз', '2042-03-12', 721996241, 'внесена предоплата', '2041-11-07', '2044-08-03', 242);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (229, 169, 267, 'приостановлен', 'народный стакан', '2023-11-19', 552874636, 'внесена предоплата', '2027-11-19', '2030-07-19', 243);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (368, 186, 421, 'приостановлен', 'официальный кадр', '2083-03-02', 590152353, 'не оплачен', '2012-11-04', '2015-07-27', 244);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (259, 73, 349, 'не начат', 'польский человек', '2013-01-19', 212638650, 'полностью оплачен', '2051-09-01', '2052-02-03', 245);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (343, 112, 306, 'не начат', 'нравственный машина', '2063-05-16', 263999151, 'не оплачен', '2024-05-26', '2025-05-19', 246);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (256, 171, 367, 'приостановлен', 'возрастной краска', '2073-02-18', 228696389, 'полностью оплачен', '2090-03-26', '2093-02-12', 247);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (417, 11, 447, 'в процессе', 'конструктивный американец', '2080-08-02', 477487818, 'не оплачен', '2016-12-28', '2018-11-27', 248);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (42, 214, 426, 'приостановлен', 'голодный помощь', '2008-11-23', 672474249, 'внесена предоплата', '2016-11-21', '2019-05-24', 249);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (212, 120, 312, 'не начат', 'нужный больной', '2069-08-01', 458390876, 'не оплачен', '2039-09-28', '2040-09-19', 250);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (440, 237, 412, 'выполнен', 'громадный полет', '2058-12-21', 369209566, 'внесена предоплата', '2004-11-17', '2005-03-20', 251);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (402, 97, 379, 'приостановлен', 'равный начало', '2021-03-23', 127793270, 'внесена предоплата', '2074-08-24', '2077-12-08', 252);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (187, 66, 310, 'выполнен', 'тайный ночь', '2031-09-10', 560362565, 'полностью оплачен', '2085-08-27', '2088-10-13', 253);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (82, 58, 417, 'приостановлен', 'обязательный полет', '2009-11-09', 354171983, 'полностью оплачен', '2077-02-11', '2080-12-17', 254);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (378, 5, 380, 'приостановлен', 'должный академия', '2008-12-14', 509293676, 'внесена предоплата', '2054-06-25', '2056-11-24', 255);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (336, 117, 347, 'выполнен', 'преподобный вкус', '2055-11-26', 459933776, 'не оплачен', '2089-09-21', '2090-12-27', 256);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (31, 181, 355, 'в процессе', 'экологический весна', '2029-08-25', 123832357, 'внесена предоплата', '2080-08-27', '2081-03-06', 257);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (258, 81, 457, 'выполнен', 'механический хвост', '2009-11-12', 242921856, 'не оплачен', '2077-07-07', '2078-06-15', 258);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (42, 203, 460, 'выполнен', 'крошечный правда', '2017-12-20', 325755630, 'полностью оплачен', '2085-11-24', '2087-04-28', 259);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (133, 117, 285, 'приостановлен', 'заинтересованный период', '2014-07-05', 288937426, 'полностью оплачен', '2026-06-08', '2028-09-21', 260);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (337, 14, 400, 'не начат', 'израильский животное', '2019-10-22', 229959323, 'полностью оплачен', '2023-06-19', '2024-09-20', 261);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (475, 165, 441, 'в процессе', 'населенный глубина', '2011-06-14', 407604555, 'полностью оплачен', '2076-12-15', '2078-05-26', 262);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (349, 31, 377, 'приостановлен', 'качественный середина', '2042-07-05', 39797105, 'не оплачен', '2031-08-23', '2032-06-13', 263);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (81, 185, 338, 'не начат', 'зарубежный стекло', '2090-09-01', 31762524, 'внесена предоплата', '2059-05-02', '2060-01-24', 264);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (268, 52, 323, 'приостановлен', 'конструктивный монастырь', '2056-05-28', 131142596, 'не оплачен', '2030-11-14', '2031-03-11', 265);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (110, 112, 299, 'в процессе', 'молодой поведение', '2077-07-08', 634147960, 'не оплачен', '2021-04-07', '2022-02-06', 266);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (84, 225, 267, 'не начат', 'вертикальный волос', '2065-02-09', 636786097, 'не оплачен', '2039-05-28', '2040-11-24', 267);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (449, 164, 423, 'приостановлен', 'немой орган', '2036-11-08', 265612534, 'полностью оплачен', '2064-12-02', '2065-03-06', 268);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (77, 34, 444, 'не начат', 'хитрый вес', '2048-11-15', 81089324, 'полностью оплачен', '2080-07-25', '2081-02-24', 269);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (320, 175, 325, 'в процессе', 'медный костюм', '2041-03-12', 197019802, 'полностью оплачен', '2054-04-11', '2056-11-01', 270);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (428, 83, 348, 'не начат', 'добровольный брат', '1999-07-04', 305406836, 'не оплачен', '2016-12-14', '2017-11-17', 271);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (96, 107, 456, 'выполнен', 'сухой утро', '2057-09-25', 297896914, 'внесена предоплата', '2028-07-08', '2030-10-15', 272);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (162, 43, 477, 'приостановлен', 'открытый ночь', '2031-11-25', 514772061, 'не оплачен', '2032-11-03', '2033-08-19', 273);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (179, 22, 403, 'выполнен', 'тогдашний путь', '2058-02-16', 521922548, 'внесена предоплата', '2058-07-04', '2060-01-10', 274);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (128, 200, 377, 'не начат', 'характерный будущее', '2043-01-04', 123548113, 'полностью оплачен', '2090-03-09', '2091-11-11', 275);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (365, 133, 417, 'выполнен', 'электрический единица', '2057-06-17', 570351635, 'не оплачен', '2023-04-20', '2024-10-04', 276);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (295, 29, 398, 'не начат', 'тесный магазин', '2020-01-28', 157373252, 'не оплачен', '2070-09-08', '2071-09-10', 277);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (31, 141, 351, 'в процессе', 'технологический товар', '2079-09-18', 449995438, 'полностью оплачен', '2001-11-08', '2004-06-11', 278);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (282, 54, 424, 'приостановлен', 'методический особенность', '2039-10-22', 620417956, 'полностью оплачен', '2016-05-15', '2019-02-21', 279);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (440, 238, 451, 'выполнен', 'заключенный выступление', '2050-09-15', 442694285, 'внесена предоплата', '2044-11-23', '2045-06-04', 280);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (486, 34, 350, 'не начат', 'гордый автор', '2023-06-24', 313639240, 'не оплачен', '2038-09-26', '2039-09-04', 281);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (105, 237, 458, 'в процессе', 'здешний кость', '2033-05-20', 68933162, 'внесена предоплата', '2090-08-24', '2093-09-06', 282);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (69, 78, 344, 'не начат', 'ручной страсть', '2085-06-02', 528588504, 'полностью оплачен', '2038-01-20', '2041-08-02', 283);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (160, 113, 331, 'не начат', 'ведущий палата', '2071-02-23', 734054562, 'не оплачен', '2032-01-09', '2035-12-20', 284);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (309, 59, 494, 'приостановлен', 'редкий представление', '2056-12-05', 735276622, 'полностью оплачен', '2003-03-11', '2005-06-01', 285);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (120, 139, 284, 'выполнен', 'полный дача', '2038-03-21', 102700696, 'не оплачен', '2057-02-22', '2058-04-23', 286);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (33, 73, 451, 'приостановлен', 'совместный редактор', '2082-05-15', 288222683, 'полностью оплачен', '2039-08-28', '2042-12-26', 287);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (150, 108, 382, 'в процессе', 'многие участник', '2078-12-18', 759532105, 'не оплачен', '2009-10-09', '2011-07-04', 288);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (205, 107, 496, 'выполнен', 'радикальный затрата', '2021-03-14', 677147239, 'полностью оплачен', '2046-03-03', '2047-07-17', 289);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (159, 218, 312, 'выполнен', 'радикальный бумага', '2066-04-06', 146844930, 'не оплачен', '2016-08-26', '2017-09-24', 290);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (16, 17, 496, 'выполнен', 'банковский храм', '2068-04-14', 761935761, 'полностью оплачен', '2032-07-07', '2033-06-05', 291);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (176, 27, 368, 'выполнен', 'равный картина', '2009-11-13', 195488154, 'внесена предоплата', '2057-05-21', '2059-04-14', 292);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (53, 214, 299, 'не начат', 'сельскохозяйственный старик', '2022-04-07', 460631836, 'внесена предоплата', '2043-02-02', '2046-08-08', 293);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (271, 71, 360, 'не начат', 'многочисленный лейтенант', '2006-04-08', 257272346, 'полностью оплачен', '2088-10-14', '2091-10-12', 294);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (176, 72, 349, 'не начат', 'летний должность', '2075-03-04', 603992416, 'внесена предоплата', '2032-11-15', '2033-11-22', 295);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (30, 2, 471, 'выполнен', 'обыкновенный подход', '1999-06-01', 723145648, 'внесена предоплата', '2086-04-19', '2089-04-13', 296);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (193, 73, 497, 'не начат', 'конституционный заказ', '2088-01-08', 552441190, 'не оплачен', '2047-01-09', '2049-05-23', 297);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (279, 48, 359, 'не начат', 'методический точка', '2000-10-21', 335659581, 'внесена предоплата', '2030-10-06', '2031-08-02', 298);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (94, 144, 415, 'в процессе', 'дорожный выпуск', '2086-01-04', 426066414, 'внесена предоплата', '2024-04-05', '2025-04-15', 299);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (493, 199, 352, 'выполнен', 'кавказский обработка', '2001-04-20', 659481541, 'полностью оплачен', '2038-04-25', '2040-01-02', 300);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (52, 242, 359, 'выполнен', 'ясный способ', '2054-09-27', 792982736, 'внесена предоплата', '2042-10-19', '2043-12-07', 301);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (203, 177, 292, 'в процессе', 'организованный водитель', '2048-01-21', 527182150, 'внесена предоплата', '2001-12-12', '2003-05-28', 302);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (163, 225, 302, 'в процессе', 'заключенный доктор', '2076-01-05', 329220211, 'внесена предоплата', '2042-12-05', '2045-06-03', 303);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (363, 76, 431, 'не начат', 'тогдашний офицер', '2022-12-01', 426051580, 'не оплачен', '2026-08-28', '2027-07-21', 304);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (117, 158, 487, 'не начат', 'экспертный герой', '2075-03-22', 579736675, 'внесена предоплата', '2041-03-20', '2044-11-21', 305);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (334, 159, 339, 'в процессе', 'английский пример', '2050-10-19', 436466953, 'не оплачен', '2003-11-09', '2006-04-12', 306);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (151, 153, 396, 'приостановлен', 'весенний служба', '2017-05-25', 68536522, 'полностью оплачен', '2018-06-27', '2019-05-14', 307);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (455, 246, 436, 'выполнен', 'скрытый основа', '2004-09-18', 565631921, 'не оплачен', '2090-03-02', '2093-05-23', 308);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (240, 15, 449, 'в процессе', 'ужасный прокурор', '2008-09-19', 458225313, 'не оплачен', '2000-07-10', '2003-12-04', 309);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (150, 169, 386, 'в процессе', 'многие слеза', '2089-05-13', 420694248, 'внесена предоплата', '2080-03-03', '2082-12-28', 310);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (386, 213, 433, 'в процессе', 'футбольный земля', '2080-12-12', 188931207, 'внесена предоплата', '2053-01-24', '2054-03-13', 311);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (265, 238, 308, 'в процессе', 'узкий банк', '2001-01-22', 120315363, 'внесена предоплата', '2056-02-20', '2058-08-03', 312);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (123, 55, 386, 'не начат', 'дорогой деньги', '2015-05-13', 467563846, 'не оплачен', '2029-07-03', '2031-12-05', 313);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (253, 171, 401, 'выполнен', 'сознательный половина', '2070-06-19', 740535096, 'внесена предоплата', '2010-04-10', '2012-12-11', 314);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (302, 59, 373, 'не начат', 'относительный комиссия', '2016-09-27', 708547692, 'внесена предоплата', '2048-06-12', '2050-11-01', 315);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (13, 228, 400, 'в процессе', 'лысый сигарета', '2018-04-10', 391970243, 'полностью оплачен', '2037-10-19', '2039-12-27', 316);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (368, 176, 487, 'не начат', 'огненный страх', '2088-07-17', 92499258, 'внесена предоплата', '2052-03-06', '2054-05-13', 317);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (430, 129, 394, 'не начат', 'каменный путь', '2044-01-27', 91818493, 'не оплачен', '2089-08-22', '2090-03-15', 318);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (479, 231, 399, 'выполнен', 'далекий плечо', '2077-02-21', 581593749, 'полностью оплачен', '2012-05-11', '2014-12-19', 319);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (417, 117, 484, 'в процессе', 'рекламный обучение', '2016-01-19', 288054293, 'полностью оплачен', '2063-05-09', '2065-11-21', 320);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (187, 225, 328, 'не начат', 'юный уход', '2024-10-08', 162312569, 'не оплачен', '2079-02-01', '2081-10-08', 321);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (457, 164, 458, 'не начат', 'узкий атмосфера', '2056-05-07', 390275341, 'внесена предоплата', '2048-02-22', '2051-08-26', 322);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (463, 85, 365, 'приостановлен', 'лекарственный семья', '2000-03-15', 409120685, 'внесена предоплата', '2021-11-16', '2022-12-05', 323);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (308, 92, 354, 'выполнен', 'крошечный граница', '2076-01-01', 786733535, 'полностью оплачен', '2070-02-08', '2073-06-24', 324);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (466, 77, 450, 'не начат', 'священный смерть', '2063-10-25', 179652666, 'полностью оплачен', '2083-05-08', '2086-07-18', 325);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (29, 29, 422, 'приостановлен', 'интенсивный кодекс', '2056-04-13', 270092287, 'внесена предоплата', '2054-05-16', '2056-05-24', 326);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (49, 249, 449, 'в процессе', 'влажный выступление', '2073-03-15', 182442331, 'не оплачен', '2073-04-05', '2076-02-07', 327);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (322, 238, 463, 'выполнен', 'меньший машина', '2058-05-21', 117541684, 'не оплачен', '2016-10-03', '2017-01-14', 328);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (270, 202, 462, 'выполнен', 'отдаленный герой', '2080-09-11', 71262961, 'внесена предоплата', '2003-09-14', '2004-04-26', 329);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (23, 201, 347, 'выполнен', 'оперативный рассмотрение', '2065-04-05', 652602935, 'не оплачен', '2071-07-13', '2073-04-25', 330);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (170, 83, 270, 'в процессе', 'чувствительный рубль', '2069-02-23', 603760186, 'не оплачен', '2017-03-17', '2018-01-16', 331);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (28, 128, 267, 'не начат', 'искренний достоинство', '2016-12-17', 523299864, 'полностью оплачен', '2054-12-28', '2057-02-03', 332);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (377, 182, 457, 'приостановлен', 'искренний режим', '2069-12-22', 123320670, 'полностью оплачен', '2056-06-22', '2058-05-22', 333);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (187, 67, 404, 'выполнен', 'понятный направление', '2075-07-05', 29112571, 'полностью оплачен', '2065-07-21', '2068-11-27', 334);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (237, 115, 290, 'выполнен', 'серьезный эксплуатация', '2067-04-09', 249854554, 'внесена предоплата', '2000-04-09', '2002-05-09', 335);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (289, 221, 437, 'в процессе', 'вчерашний мешок', '2030-10-16', 169889242, 'не оплачен', '2033-07-19', '2036-02-28', 336);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (428, 21, 261, 'выполнен', 'железный рубль', '2061-11-05', 48345732, 'не оплачен', '2071-09-22', '2074-07-11', 337);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (477, 32, 497, 'в процессе', 'незначительный переход', '2033-02-02', 727277846, 'внесена предоплата', '2020-05-09', '2022-10-05', 338);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (222, 17, 291, 'не начат', 'заинтересованный множество', '2014-11-13', 519944047, 'полностью оплачен', '2010-09-17', '2011-02-18', 339);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (36, 126, 351, 'в процессе', 'вынужденный достоинство', '2082-02-12', 346133008, 'не оплачен', '2075-10-18', '2076-09-02', 340);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (482, 140, 413, 'в процессе', 'равный заказ', '2018-11-11', 406516182, 'полностью оплачен', '2076-02-19', '2077-06-17', 341);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (448, 16, 415, 'не начат', 'базовый проблема', '2033-07-03', 670049951, 'полностью оплачен', '2042-11-05', '2043-06-23', 342);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (240, 221, 358, 'приостановлен', 'строительный основа', '2054-02-18', 423961626, 'полностью оплачен', '2027-09-23', '2029-07-18', 343);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (293, 78, 301, 'в процессе', 'благополучный выполнение', '2086-04-25', 736988930, 'полностью оплачен', '2060-09-15', '2061-11-05', 344);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (324, 174, 283, 'не начат', 'тревожный концерт', '2006-05-25', 522129644, 'полностью оплачен', '2020-04-28', '2023-11-17', 345);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (151, 131, 309, 'выполнен', 'должен май', '2016-10-09', 799392049, 'внесена предоплата', '2058-12-27', '2059-02-27', 346);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (39, 34, 377, 'приостановлен', 'поэтический рассмотрение', '2015-02-27', 387982705, 'не оплачен', '2062-07-16', '2063-12-18', 347);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (169, 229, 496, 'в процессе', 'краткий молоко', '2052-06-08', 633621388, 'полностью оплачен', '2089-09-27', '2092-02-17', 348);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (261, 174, 361, 'в процессе', 'подобный концерт', '2049-08-18', 371068707, 'полностью оплачен', '2020-02-27', '2023-01-22', 349);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (353, 124, 443, 'в процессе', 'подводной реакция', '2047-10-11', 759035727, 'не оплачен', '2090-08-27', '2093-02-25', 350);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (196, 69, 444, 'в процессе', 'валютный суд', '2051-04-18', 694998355, 'не оплачен', '2034-08-08', '2037-10-06', 351);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (293, 45, 340, 'выполнен', 'личный машина', '2016-08-24', 242102812, 'полностью оплачен', '2053-09-24', '2055-03-05', 352);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (483, 181, 464, 'не начат', 'преподобный бог', '2087-09-13', 510522049, 'полностью оплачен', '2082-10-03', '2084-12-04', 353);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (417, 4, 375, 'приостановлен', 'израильский оборона', '2012-10-08', 382850897, 'не оплачен', '2048-01-26', '2049-06-06', 354);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (373, 59, 256, 'выполнен', 'синий период', '2058-05-04', 607473727, 'не оплачен', '2035-12-02', '2036-11-23', 355);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (499, 93, 407, 'не начат', 'колючий очередь', '2035-07-05', 149597295, 'внесена предоплата', '2045-06-22', '2046-09-07', 356);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (213, 167, 256, 'не начат', 'учебный дым', '2012-08-24', 295517947, 'внесена предоплата', '2022-03-10', '2023-08-17', 357);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (459, 76, 466, 'приостановлен', 'федеральный середина', '2006-01-06', 631809486, 'внесена предоплата', '2036-10-21', '2039-06-18', 358);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (280, 72, 483, 'не начат', 'честный появление', '1999-02-14', 782832634, 'не оплачен', '2042-09-01', '2044-01-01', 359);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (312, 112, 358, 'в процессе', 'прямой собака', '2037-01-23', 761163887, 'внесена предоплата', '2023-09-22', '2026-04-21', 360);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (500, 104, 375, 'не начат', 'краткий дача', '2053-06-09', 333802533, 'внесена предоплата', '2047-09-27', '2049-08-24', 361);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (26, 160, 306, 'в процессе', 'одетый масло', '2022-02-17', 105967272, 'не оплачен', '2069-08-04', '2072-12-10', 362);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (149, 234, 310, 'в процессе', 'эстетический сигарета', '2013-07-15', 103738486, 'полностью оплачен', '2013-06-02', '2015-12-16', 363);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (434, 17, 411, 'в процессе', 'многочисленный вино', '2051-03-11', 168601879, 'не оплачен', '2067-03-14', '2068-10-10', 364);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (392, 141, 338, 'выполнен', 'магнитный образ', '2053-11-23', 178097455, 'внесена предоплата', '2050-08-03', '2052-12-23', 365);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (465, 96, 397, 'приостановлен', 'польский прошлое', '2040-07-11', 583396128, 'не оплачен', '2076-08-18', '2077-01-18', 366);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (336, 102, 397, 'в процессе', 'влюбленный чай', '2053-04-28', 713065438, 'внесена предоплата', '2053-08-23', '2055-11-11', 367);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (177, 148, 453, 'выполнен', 'осенний основание', '2046-10-04', 556201248, 'внесена предоплата', '2070-10-12', '2073-06-20', 368);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (235, 52, 340, 'не начат', 'заработный выражение', '2043-08-19', 23870562, 'полностью оплачен', '2052-05-12', '2054-08-16', 369);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (212, 198, 369, 'не начат', 'торговый ужас', '2080-09-27', 599947546, 'не оплачен', '2057-05-21', '2059-05-02', 370);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (164, 123, 453, 'выполнен', 'случайный голос', '2086-08-08', 396560206, 'внесена предоплата', '2089-08-05', '2090-04-11', 371);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (299, 119, 263, 'приостановлен', 'методический врач', '2008-01-10', 69402584, 'полностью оплачен', '2026-05-24', '2028-10-20', 372);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (94, 48, 257, 'выполнен', 'бедный звезда', '2014-03-08', 385887411, 'не оплачен', '2061-03-16', '2063-10-23', 373);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (427, 204, 256, 'не начат', 'торжественный реакция', '2001-11-21', 689327992, 'не оплачен', '2008-02-14', '2009-10-06', 374);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (80, 172, 372, 'в процессе', 'женский колено', '2089-03-03', 301961184, 'внесена предоплата', '2006-05-09', '2009-09-14', 375);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (171, 240, 333, 'выполнен', 'незначительный слово', '2048-05-22', 797578912, 'внесена предоплата', '2022-04-18', '2023-02-01', 376);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (180, 118, 460, 'приостановлен', 'банковский роль', '2000-04-12', 476584201, 'не оплачен', '2078-01-07', '2080-01-06', 377);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (476, 28, 348, 'приостановлен', 'бумажный точка', '2015-04-26', 449581014, 'полностью оплачен', '2080-09-10', '2081-04-22', 378);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (24, 64, 474, 'не начат', 'американский бок', '2043-06-21', 454326565, 'полностью оплачен', '2035-07-19', '2036-11-18', 379);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (176, 40, 365, 'не начат', 'саратовский отказ', '1999-03-04', 449580437, 'внесена предоплата', '2013-03-12', '2016-03-18', 380);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (67, 155, 256, 'не начат', 'духовный сюжет', '2063-08-06', 238067442, 'полностью оплачен', '2020-07-18', '2021-05-23', 381);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (154, 6, 254, 'в процессе', 'совместный параметр', '2007-10-08', 734405951, 'не оплачен', '2052-10-26', '2053-01-26', 382);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (77, 169, 432, 'не начат', 'ограниченный миг', '2068-10-09', 721301986, 'внесена предоплата', '2052-12-03', '2054-11-09', 383);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (489, 49, 351, 'приостановлен', 'длинный использование', '2027-01-02', 766809323, 'не оплачен', '2007-12-06', '2008-05-16', 384);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (344, 193, 487, 'выполнен', 'генетический кандидат', '2071-04-08', 350179537, 'полностью оплачен', '2078-12-04', '2081-06-12', 385);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (254, 17, 416, 'выполнен', 'мучительный попытка', '2019-03-08', 242675478, 'внесена предоплата', '2053-01-09', '2054-12-25', 386);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (5, 96, 494, 'приостановлен', 'парламентский дача', '2031-04-27', 285479624, 'внесена предоплата', '2005-07-19', '2007-06-19', 387);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (383, 223, 480, 'выполнен', 'поэтический психология', '2002-11-05', 165532977, 'полностью оплачен', '2046-02-08', '2047-03-22', 388);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (159, 237, 438, 'не начат', 'погибший сравнение', '2057-09-24', 553624893, 'внесена предоплата', '2012-07-12', '2014-06-03', 389);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (408, 43, 372, 'приостановлен', 'идеологический портрет', '2089-06-16', 650756219, 'не оплачен', '2085-03-27', '2088-07-16', 390);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (168, 40, 492, 'выполнен', 'убежденный дело', '2031-01-14', 324041194, 'внесена предоплата', '2012-09-10', '2014-07-18', 391);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (405, 240, 324, 'не начат', 'чудовищный искусство', '2018-10-21', 242831432, 'не оплачен', '2056-08-14', '2058-11-08', 392);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (35, 7, 433, 'приостановлен', 'радостный карман', '2084-05-20', 789730855, 'полностью оплачен', '2050-02-28', '2052-12-16', 393);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (64, 177, 465, 'приостановлен', 'передовой зеркало', '2082-05-11', 460837680, 'не оплачен', '2012-07-11', '2015-12-25', 394);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (464, 29, 266, 'приостановлен', 'низкий основание', '2075-07-24', 510363949, 'не оплачен', '2081-02-25', '2082-01-05', 395);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (246, 246, 264, 'приостановлен', 'специфический ящик', '2031-05-04', 299083963, 'внесена предоплата', '2057-08-08', '2059-06-07', 396);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (311, 159, 407, 'в процессе', 'бытовой инженер', '2034-06-06', 555938350, 'не оплачен', '2066-10-02', '2068-04-10', 397);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (12, 207, 389, 'выполнен', 'сомнительный слово', '2003-09-19', 677429258, 'внесена предоплата', '2067-05-21', '2070-10-15', 398);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (286, 145, 259, 'в процессе', 'параллельный минута', '1999-02-02', 494376449, 'полностью оплачен', '2075-09-09', '2076-06-27', 399);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (404, 59, 408, 'не начат', 'усталый способность', '2038-02-01', 618472884, 'внесена предоплата', '2018-10-26', '2021-06-15', 400);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (415, 101, 383, 'приостановлен', 'нелепый век', '2016-02-08', 553727606, 'внесена предоплата', '2044-04-22', '2047-09-04', 401);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (241, 235, 322, 'выполнен', 'знаменитый аппарат', '2013-08-04', 656416023, 'внесена предоплата', '2027-08-08', '2029-05-02', 402);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (79, 13, 387, 'приостановлен', 'информационный прошлое', '2032-02-18', 162289579, 'полностью оплачен', '2089-03-23', '2090-11-20', 403);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (99, 244, 276, 'приостановлен', 'типичный граница', '2055-05-12', 257331555, 'не оплачен', '2022-06-17', '2024-12-04', 404);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (140, 55, 417, 'не начат', 'валютный механизм', '2017-07-19', 122848438, 'внесена предоплата', '2080-11-22', '2081-02-12', 405);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (436, 189, 264, 'выполнен', 'остальной пример', '2081-08-19', 428477252, 'полностью оплачен', '2002-03-15', '2004-12-16', 406);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (436, 46, 474, 'приостановлен', 'базовый кухня', '2038-01-26', 699157417, 'полностью оплачен', '2071-03-24', '2072-08-24', 407);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (96, 126, 301, 'приостановлен', 'боевой дума', '2019-04-23', 349591765, 'внесена предоплата', '2051-05-20', '2054-05-23', 408);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (25, 219, 427, 'в процессе', 'конституционный конференция', '2064-05-10', 664636964, 'не оплачен', '2041-05-19', '2042-01-15', 409);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (77, 212, 402, 'приостановлен', 'радостный темнота', '2027-08-21', 284055216, 'внесена предоплата', '2032-01-21', '2033-07-03', 410);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (9, 239, 469, 'приостановлен', 'многочисленный перспектива', '2027-05-20', 130338994, 'внесена предоплата', '2068-03-22', '2070-05-06', 411);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (149, 138, 264, 'не начат', 'экологический выступление', '2046-09-02', 775247569, 'внесена предоплата', '2089-10-26', '2092-09-24', 412);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (443, 126, 466, 'не начат', 'банковский сцена', '2075-09-02', 557182259, 'полностью оплачен', '2015-07-17', '2017-08-24', 413);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (98, 147, 254, 'приостановлен', 'минеральный положение', '2073-08-15', 218738748, 'не оплачен', '2047-06-23', '2048-06-19', 414);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (135, 69, 437, 'в процессе', 'интересный взгляд', '2051-02-18', 677643228, 'полностью оплачен', '2079-07-07', '2081-03-15', 415);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (477, 53, 404, 'приостановлен', 'оперативный ставка', '2010-06-09', 518257691, 'внесена предоплата', '2064-05-01', '2065-05-06', 416);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (29, 250, 274, 'в процессе', 'горный рост', '2079-06-05', 43101693, 'полностью оплачен', '2071-05-28', '2074-05-05', 417);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (445, 50, 254, 'не начат', 'долгий желание', '2059-01-01', 72745736, 'внесена предоплата', '2037-05-07', '2038-10-23', 418);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (70, 107, 416, 'в процессе', 'дорогой оружие', '2085-11-10', 615357261, 'не оплачен', '2030-03-02', '2031-07-27', 419);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (12, 27, 390, 'в процессе', 'устойчивый ошибка', '2028-02-12', 692152843, 'полностью оплачен', '2011-05-15', '2013-10-20', 420);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (240, 177, 321, 'приостановлен', 'ограниченный мастер', '2047-04-22', 292646928, 'полностью оплачен', '2035-09-17', '2036-03-18', 421);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (305, 42, 278, 'в процессе', 'лишний постель', '2081-01-14', 294562985, 'не оплачен', '2045-12-06', '2046-04-25', 422);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (349, 27, 286, 'в процессе', 'видный путь', '2013-08-22', 550888271, 'полностью оплачен', '2059-11-05', '2062-03-05', 423);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (1, 90, 288, 'не начат', 'олимпийский вода', '2018-08-11', 297695657, 'не оплачен', '2058-09-08', '2061-10-03', 424);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (407, 195, 257, 'не начат', 'коричневый правда', '2068-12-05', 564613472, 'полностью оплачен', '2033-03-25', '2034-07-05', 425);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (324, 175, 281, 'не начат', 'нежный способность', '2026-07-04', 227847798, 'полностью оплачен', '2079-08-26', '2081-03-14', 426);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (174, 91, 422, 'приостановлен', 'квадратный лед', '2044-08-05', 202157763, 'не оплачен', '2022-02-27', '2025-08-12', 427);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (71, 136, 476, 'не начат', 'внутренний кабинет', '2013-08-28', 776971132, 'не оплачен', '2036-06-08', '2039-12-01', 428);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (61, 245, 313, 'выполнен', 'серьезный больной', '2074-05-27', 431225886, 'не оплачен', '2087-06-01', '2089-11-03', 429);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (254, 115, 450, 'не начат', 'страховой попытка', '2047-11-28', 616774932, 'не оплачен', '2058-12-27', '2059-11-21', 430);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (235, 208, 304, 'приостановлен', 'незначительный темнота', '2077-05-16', 596212290, 'внесена предоплата', '2048-11-11', '2049-07-28', 431);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (107, 194, 286, 'не начат', 'уникальный разработка', '2069-04-10', 306593167, 'не оплачен', '2077-08-21', '2079-04-14', 432);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (401, 193, 458, 'приостановлен', 'заинтересованный нос', '2048-08-15', 498671382, 'не оплачен', '2077-08-28', '2079-01-12', 433);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (342, 199, 288, 'приостановлен', 'безумный март', '2002-11-16', 784520453, 'внесена предоплата', '2040-09-11', '2041-06-15', 434);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (189, 173, 454, 'в процессе', 'садовый запад', '2056-02-05', 106339570, 'полностью оплачен', '2074-05-01', '2076-10-28', 435);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (395, 130, 371, 'в процессе', 'космический добро', '2083-08-15', 25966219, 'полностью оплачен', '2089-04-21', '2090-06-21', 436);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (478, 3, 276, 'в процессе', 'искусственный пример', '2036-08-15', 605691157, 'внесена предоплата', '2039-09-26', '2042-03-23', 437);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (279, 183, 477, 'не начат', 'своеобразный лошадь', '2052-01-11', 294164535, 'внесена предоплата', '2066-06-21', '2067-01-05', 438);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (362, 125, 407, 'в процессе', 'силовой раз', '2056-12-09', 78035700, 'полностью оплачен', '2015-02-20', '2016-10-22', 439);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (349, 197, 489, 'не начат', 'космический миллион', '2088-06-02', 81637512, 'внесена предоплата', '2037-05-07', '2038-11-21', 440);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (31, 105, 454, 'выполнен', 'гордый март', '2061-02-13', 714078794, 'полностью оплачен', '2077-10-28', '2079-10-02', 441);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (110, 233, 315, 'в процессе', 'киевский воля', '2073-04-11', 39149065, 'полностью оплачен', '2015-07-28', '2018-11-06', 442);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (47, 162, 345, 'выполнен', 'особенный зритель', '2051-07-11', 701511496, 'полностью оплачен', '2046-04-09', '2047-06-10', 443);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (405, 184, 297, 'приостановлен', 'передовой пора', '2028-01-05', 216916516, 'внесена предоплата', '2053-08-22', '2056-11-28', 444);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (104, 45, 496, 'не начат', 'лишний пиво', '2020-05-22', 672829578, 'не оплачен', '2019-01-12', '2021-08-08', 445);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (49, 165, 425, 'в процессе', 'нефтяной комитет', '2024-07-16', 498341209, 'полностью оплачен', '2041-10-07', '2044-11-07', 446);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (14, 125, 367, 'не начат', 'заинтересованный применение', '1999-02-02', 783423633, 'внесена предоплата', '2083-03-18', '2085-05-07', 447);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (170, 57, 300, 'приостановлен', 'просторный активность', '2029-07-08', 44875502, 'внесена предоплата', '2073-08-16', '2075-07-17', 448);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (231, 217, 385, 'не начат', 'кредитный стихи', '2067-07-13', 266741611, 'полностью оплачен', '2014-07-27', '2017-09-24', 449);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (206, 125, 298, 'выполнен', 'судебный наличие', '2043-06-08', 798657483, 'внесена предоплата', '2009-04-04', '2010-10-20', 450);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (71, 176, 255, 'приостановлен', 'армейский взгляд', '2006-09-03', 616113463, 'внесена предоплата', '2059-11-07', '2060-06-27', 451);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (301, 95, 275, 'в процессе', 'железный глубина', '2041-06-08', 405646875, 'не оплачен', '2054-03-14', '2056-03-15', 452);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (128, 163, 366, 'в процессе', 'учебный вино', '2075-06-02', 753869148, 'внесена предоплата', '2025-09-07', '2026-02-03', 453);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (360, 75, 370, 'не начат', 'пространственный спорт', '2013-02-03', 360931476, 'полностью оплачен', '2000-11-16', '2001-12-19', 454);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (349, 69, 281, 'приостановлен', 'сельскохозяйственный дым', '2074-05-08', 198872162, 'полностью оплачен', '2009-11-27', '2010-08-07', 455);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (117, 71, 322, 'в процессе', 'названый поведение', '1999-03-17', 104552368, 'не оплачен', '2061-04-25', '2063-09-26', 456);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (130, 242, 392, 'не начат', 'громкий полоса', '2004-11-03', 571759415, 'полностью оплачен', '2014-08-19', '2016-08-20', 457);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (76, 97, 392, 'в процессе', 'странный сентябрь', '2053-10-01', 388439023, 'внесена предоплата', '2018-11-22', '2019-07-25', 458);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (250, 170, 380, 'выполнен', 'серьезный камера', '2014-06-18', 361336518, 'полностью оплачен', '2080-07-16', '2081-08-01', 459);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (165, 169, 442, 'в процессе', 'северный поэзия', '2022-07-13', 179710855, 'не оплачен', '2062-01-18', '2065-02-13', 460);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (366, 67, 257, 'в процессе', 'многие основание', '2064-08-17', 83245666, 'внесена предоплата', '2018-12-20', '2021-08-02', 461);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (448, 164, 262, 'не начат', 'светский голова', '2015-11-10', 284539165, 'не оплачен', '2066-04-21', '2068-02-28', 462);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (46, 4, 442, 'не начат', 'стандартный направление', '2016-03-18', 522628582, 'полностью оплачен', '2058-05-19', '2060-11-23', 463);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (354, 64, 441, 'в процессе', 'бывший грудь', '2042-01-23', 522832726, 'полностью оплачен', '2081-10-01', '2083-08-23', 464);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (335, 93, 262, 'приостановлен', 'длинный доход', '2031-04-16', 663683753, 'не оплачен', '2034-02-23', '2036-11-25', 465);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (90, 90, 389, 'не начат', 'хороший проблема', '2038-06-20', 390341763, 'внесена предоплата', '2052-10-01', '2053-12-02', 466);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (295, 116, 386, 'в процессе', 'исключительный множество', '2032-06-23', 512997027, 'полностью оплачен', '2052-10-28', '2054-01-26', 467);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (107, 44, 449, 'в процессе', 'бесконечный признак', '2066-02-07', 777412825, 'внесена предоплата', '2083-03-17', '2084-10-20', 468);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (464, 20, 417, 'в процессе', 'парижский команда', '2081-08-12', 584227250, 'внесена предоплата', '1999-02-17', '2001-03-28', 469);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (437, 55, 270, 'выполнен', 'жуткий образование', '2042-09-09', 231433924, 'полностью оплачен', '2075-12-16', '2076-11-03', 470);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (229, 155, 438, 'не начат', 'учебный месяц', '2044-10-11', 56800640, 'полностью оплачен', '2052-01-04', '2054-04-14', 471);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (36, 37, 452, 'приостановлен', 'организованный звонок', '2011-11-15', 693798758, 'не оплачен', '2059-09-02', '2060-09-22', 472);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (46, 7, 306, 'в процессе', 'потенциальный дочь', '2079-12-08', 765715049, 'полностью оплачен', '2090-06-23', '2092-11-22', 473);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (360, 194, 324, 'в процессе', 'ближний предмет', '2006-08-19', 157364096, 'внесена предоплата', '2051-11-14', '2052-05-21', 474);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (358, 129, 454, 'не начат', 'стандартный вещество', '2080-11-02', 635905472, 'не оплачен', '2000-05-17', '2002-05-25', 475);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (31, 175, 401, 'в процессе', 'многие значение', '2070-01-27', 565894642, 'внесена предоплата', '2003-12-16', '2005-11-14', 476);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (223, 116, 281, 'не начат', 'уважаемый сигнал', '2033-06-22', 766447899, 'не оплачен', '2034-07-21', '2037-07-06', 477);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (102, 195, 394, 'приостановлен', 'поразительный ряд', '2066-03-05', 284637887, 'полностью оплачен', '2047-11-02', '2050-01-06', 478);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (373, 86, 385, 'в процессе', 'клинический представление', '2067-07-05', 101044918, 'полностью оплачен', '2078-12-06', '2079-04-08', 479);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (95, 33, 318, 'выполнен', 'современный вещь', '2076-03-20', 101089511, 'не оплачен', '2063-11-19', '2065-08-19', 480);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (356, 193, 373, 'не начат', 'подводной орган', '2082-08-04', 622873218, 'не оплачен', '2066-07-02', '2067-01-11', 481);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (342, 96, 481, 'приостановлен', 'стратегический художник', '2004-10-23', 422979563, 'полностью оплачен', '2013-06-01', '2016-10-24', 482);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (44, 129, 486, 'в процессе', 'огромный середина', '2058-11-23', 446666785, 'внесена предоплата', '2048-03-25', '2051-10-04', 483);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (151, 80, 420, 'не начат', 'заработный кодекс', '2010-02-16', 695952303, 'не оплачен', '2020-06-04', '2023-09-16', 484);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (318, 163, 269, 'приостановлен', 'исключительный округ', '2036-10-07', 302516331, 'не оплачен', '2063-07-19', '2065-08-16', 485);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (280, 40, 434, 'выполнен', 'мобильный власть', '2073-09-23', 87765949, 'полностью оплачен', '2076-12-20', '2078-04-25', 486);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (146, 139, 276, 'выполнен', 'божественный сочинение', '2069-04-20', 144013122, 'не оплачен', '2004-07-11', '2005-01-01', 487);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (307, 218, 396, 'не начат', 'интеллектуальный полоса', '2022-03-12', 157773997, 'не оплачен', '2030-11-26', '2033-03-18', 488);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (310, 96, 421, 'приостановлен', 'силовой глава', '2089-12-27', 259143890, 'полностью оплачен', '2027-12-28', '2030-06-01', 489);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (261, 223, 426, 'в процессе', 'заработный реализация', '2029-04-27', 540972747, 'полностью оплачен', '2033-04-17', '2035-04-05', 490);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (221, 135, 497, 'приостановлен', 'относительный весна', '2081-10-23', 405139880, 'полностью оплачен', '2088-09-26', '2089-02-07', 491);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (230, 228, 471, 'выполнен', 'многие курс', '2050-03-05', 737253557, 'не оплачен', '2019-04-18', '2022-02-06', 492);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (224, 12, 281, 'в процессе', 'голодный транспорт', '2060-06-18', 561248848, 'полностью оплачен', '2082-03-02', '2084-02-17', 493);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (396, 113, 352, 'приостановлен', 'удобный эксплуатация', '2031-01-03', 706968916, 'полностью оплачен', '2085-05-22', '2088-09-23', 494);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (40, 120, 264, 'не начат', 'таинственный ставка', '2041-08-18', 633086658, 'не оплачен', '2027-05-11', '2030-07-11', 495);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (400, 167, 352, 'в процессе', 'выходной прокурор', '2081-02-12', 351950895, 'полностью оплачен', '2084-04-24', '2087-03-15', 496);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (310, 66, 419, 'приостановлен', 'населенный академия', '2078-04-06', 494721586, 'полностью оплачен', '2024-01-12', '2026-03-13', 497);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (18, 48, 330, 'выполнен', 'праздничный разница', '2044-03-16', 418079880, 'внесена предоплата', '2016-12-16', '2018-07-24', 498);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (72, 223, 377, 'в процессе', 'космический пример', '2086-08-01', 340122144, 'не оплачен', '2025-02-06', '2028-06-21', 499);
INSERT INTO public.project (id_client, id_manager, id_supervisor, project_status, project_name, project_deadlines, price, payment_state, signing_contract_date, signing_act_date, id_project) OVERRIDING SYSTEM VALUE VALUES (84, 142, 281, 'не начат', 'патриотический песня', '2029-11-17', 196459881, 'внесена предоплата', '2059-07-10', '2061-01-14', 500);


--
-- TOC entry 3663 (class 0 OID 16450)
-- Dependencies: 213
-- Data for Name: schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (1, 1, 299, 366, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (2, 2, 97, 6, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (3, 3, 428, 285, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (4, 4, 428, 208, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (5, 5, 81, 26, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (6, 6, 297, 351, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (7, 7, 185, 364, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (8, 8, 266, 56, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (9, 9, 356, 247, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (10, 10, 399, 96, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (11, 11, 70, 271, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (12, 12, 482, 333, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (13, 13, 176, 84, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (14, 14, 378, 306, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (15, 15, 434, 382, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (16, 16, 79, 51, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (17, 17, 238, 110, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (18, 18, 188, 99, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (19, 19, 307, 136, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (20, 20, 406, 435, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (21, 21, 417, 32, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (22, 22, 315, 275, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (23, 23, 131, 489, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (24, 24, 68, 485, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (25, 25, 240, 29, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (26, 26, 254, 23, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (27, 27, 198, 211, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (28, 28, 217, 277, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (29, 29, 185, 357, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (30, 30, 482, 130, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (31, 31, 335, 444, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (32, 32, 175, 147, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (33, 33, 2, 379, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (34, 34, 315, 153, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (35, 35, 291, 197, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (36, 36, 48, 497, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (37, 37, 205, 14, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (38, 38, 179, 475, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (39, 39, 491, 472, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (40, 40, 435, 459, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (41, 41, 146, 36, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (42, 42, 499, 362, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (43, 43, 51, 164, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (44, 44, 377, 49, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (45, 45, 247, 241, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (46, 46, 466, 204, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (47, 47, 397, 317, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (48, 48, 357, 159, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (49, 49, 299, 457, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (50, 50, 342, 252, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (51, 51, 363, 11, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (52, 52, 122, 151, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (53, 53, 397, 349, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (54, 54, 363, 282, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (55, 55, 418, 111, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (56, 56, 41, 10, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (57, 57, 413, 208, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (58, 58, 445, 198, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (59, 59, 426, 265, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (60, 60, 263, 251, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (61, 61, 293, 343, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (62, 62, 338, 175, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (63, 63, 86, 285, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (64, 64, 316, 20, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (65, 65, 322, 407, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (66, 66, 262, 295, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (67, 67, 361, 477, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (68, 68, 386, 425, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (69, 69, 283, 352, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (70, 70, 38, 324, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (71, 71, 89, 448, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (72, 72, 381, 85, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (73, 73, 280, 378, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (74, 74, 192, 118, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (75, 75, 221, 124, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (76, 76, 366, 281, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (77, 77, 449, 53, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (78, 78, 242, 244, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (79, 79, 86, 419, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (80, 80, 148, 179, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (81, 81, 1, 281, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (82, 82, 98, 72, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (83, 83, 154, 249, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (84, 84, 498, 357, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (85, 85, 38, 339, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (86, 86, 21, 368, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (87, 87, 463, 292, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (88, 88, 453, 371, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (89, 89, 373, 1, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (90, 90, 117, 35, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (91, 91, 301, 100, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (92, 92, 373, 401, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (93, 93, 13, 451, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (94, 94, 117, 297, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (95, 95, 426, 220, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (96, 96, 35, 139, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (97, 97, 137, 247, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (98, 98, 370, 30, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (99, 99, 207, 314, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (100, 100, 267, 35, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (101, 101, 481, 211, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (102, 102, 87, 240, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (103, 103, 134, 135, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (104, 104, 233, 328, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (105, 105, 387, 317, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (106, 106, 344, 418, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (107, 107, 362, 239, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (108, 108, 214, 397, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (109, 109, 451, 287, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (110, 110, 85, 21, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (111, 111, 409, 274, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (112, 112, 31, 87, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (113, 113, 248, 339, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (114, 114, 239, 381, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (115, 115, 284, 378, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (116, 116, 457, 284, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (117, 117, 26, 387, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (118, 118, 3, 60, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (119, 119, 319, 221, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (120, 120, 464, 307, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (121, 121, 192, 222, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (122, 122, 189, 470, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (123, 123, 258, 168, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (124, 124, 25, 444, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (125, 125, 18, 346, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (126, 126, 437, 244, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (127, 127, 332, 182, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (128, 128, 139, 109, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (129, 129, 379, 232, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (130, 130, 124, 322, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (131, 131, 408, 113, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (132, 132, 143, 20, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (133, 133, 212, 148, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (134, 134, 359, 492, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (135, 135, 52, 361, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (136, 136, 419, 193, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (137, 137, 51, 438, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (138, 138, 395, 427, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (139, 139, 245, 333, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (140, 140, 227, 31, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (141, 141, 338, 319, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (142, 142, 64, 496, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (143, 143, 254, 380, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (144, 144, 396, 272, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (145, 145, 330, 390, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (146, 146, 111, 117, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (147, 147, 406, 401, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (148, 148, 475, 36, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (149, 149, 309, 377, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (150, 150, 98, 250, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (151, 151, 388, 497, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (152, 152, 43, 233, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (153, 153, 399, 267, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (154, 154, 354, 68, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (155, 155, 379, 377, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (156, 156, 496, 491, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (157, 157, 307, 294, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (158, 158, 108, 124, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (159, 159, 494, 113, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (160, 160, 423, 87, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (161, 161, 98, 245, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (162, 162, 170, 22, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (163, 163, 479, 256, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (164, 164, 234, 497, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (165, 165, 380, 150, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (166, 166, 129, 338, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (167, 167, 423, 235, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (168, 168, 268, 125, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (169, 169, 363, 415, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (170, 170, 154, 419, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (171, 171, 360, 317, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (172, 172, 45, 476, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (173, 173, 111, 197, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (174, 174, 400, 138, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (175, 175, 439, 298, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (176, 176, 134, 294, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (177, 177, 186, 172, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (178, 178, 161, 463, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (179, 179, 12, 272, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (180, 180, 179, 110, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (181, 181, 454, 147, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (182, 182, 298, 256, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (183, 183, 95, 457, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (184, 184, 413, 138, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (185, 185, 162, 356, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (186, 186, 461, 125, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (187, 187, 34, 445, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (188, 188, 338, 319, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (189, 189, 49, 376, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (190, 190, 248, 166, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (191, 191, 33, 496, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (192, 192, 431, 351, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (193, 193, 179, 304, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (194, 194, 78, 266, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (195, 195, 220, 233, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (196, 196, 319, 158, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (197, 197, 395, 51, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (198, 198, 7, 77, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (199, 199, 157, 231, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (200, 200, 274, 347, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (201, 201, 351, 192, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (202, 202, 473, 123, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (203, 203, 449, 209, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (204, 204, 277, 10, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (205, 205, 402, 144, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (206, 206, 449, 322, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (207, 207, 66, 12, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (208, 208, 285, 316, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (209, 209, 140, 359, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (210, 210, 399, 15, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (211, 211, 341, 480, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (212, 212, 219, 148, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (213, 213, 465, 406, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (214, 214, 215, 168, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (215, 215, 40, 103, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (216, 216, 366, 377, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (217, 217, 362, 428, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (218, 218, 38, 189, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (219, 219, 488, 186, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (220, 220, 173, 18, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (221, 221, 50, 112, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (222, 222, 329, 308, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (223, 223, 73, 434, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (224, 224, 227, 432, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (225, 225, 109, 374, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (226, 226, 245, 88, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (227, 227, 355, 106, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (228, 228, 399, 92, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (229, 229, 22, 481, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (230, 230, 181, 500, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (231, 231, 186, 357, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (232, 232, 181, 438, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (233, 233, 477, 450, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (234, 234, 119, 356, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (235, 235, 256, 418, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (236, 236, 329, 9, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (237, 237, 121, 287, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (238, 238, 336, 478, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (239, 239, 3, 386, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (240, 240, 346, 120, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (241, 241, 321, 432, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (242, 242, 191, 151, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (243, 243, 219, 158, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (244, 244, 254, 53, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (245, 245, 418, 369, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (246, 246, 27, 82, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (247, 247, 56, 287, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (248, 248, 28, 228, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (249, 249, 247, 483, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (250, 250, 53, 208, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (251, 251, 131, 425, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (252, 252, 404, 40, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (253, 253, 356, 3, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (254, 254, 296, 332, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (255, 255, 144, 61, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (256, 256, 123, 130, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (257, 257, 150, 194, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (258, 258, 366, 324, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (259, 259, 212, 213, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (260, 260, 59, 409, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (261, 261, 341, 282, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (262, 262, 61, 478, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (263, 263, 114, 12, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (264, 264, 324, 376, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (265, 265, 439, 287, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (266, 266, 294, 145, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (267, 267, 115, 72, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (268, 268, 470, 257, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (269, 269, 5, 81, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (270, 270, 219, 19, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (271, 271, 366, 80, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (272, 272, 185, 374, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (273, 273, 238, 188, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (274, 274, 434, 196, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (275, 275, 345, 385, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (276, 276, 271, 26, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (277, 277, 168, 475, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (278, 278, 214, 217, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (279, 279, 327, 437, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (280, 280, 256, 203, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (281, 281, 182, 223, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (282, 282, 377, 308, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (283, 283, 182, 127, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (284, 284, 291, 42, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (285, 285, 165, 295, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (286, 286, 302, 265, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (287, 287, 227, 444, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (288, 288, 315, 51, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (289, 289, 340, 290, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (290, 290, 114, 408, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (291, 291, 449, 286, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (292, 292, 499, 191, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (293, 293, 73, 466, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (294, 294, 228, 112, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (295, 295, 365, 191, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (296, 296, 455, 344, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (297, 297, 308, 67, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (298, 298, 291, 442, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (299, 299, 182, 423, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (300, 300, 374, 140, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (301, 301, 91, 208, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (302, 302, 131, 484, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (303, 303, 206, 414, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (304, 304, 289, 174, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (305, 305, 490, 236, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (306, 306, 418, 367, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (307, 307, 152, 326, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (308, 308, 87, 58, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (309, 309, 336, 52, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (310, 310, 363, 279, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (311, 311, 46, 428, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (312, 312, 97, 21, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (313, 313, 308, 140, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (314, 314, 128, 26, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (315, 315, 110, 389, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (316, 316, 25, 458, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (317, 317, 263, 472, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (318, 318, 232, 216, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (319, 319, 132, 64, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (320, 320, 279, 284, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (321, 321, 498, 19, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (322, 322, 118, 142, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (323, 323, 202, 369, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (324, 324, 283, 375, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (325, 325, 495, 219, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (326, 326, 29, 218, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (327, 327, 471, 32, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (328, 328, 259, 21, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (329, 329, 193, 258, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (330, 330, 60, 434, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (331, 331, 152, 6, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (332, 332, 446, 103, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (333, 333, 30, 470, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (334, 334, 139, 11, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (335, 335, 312, 217, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (336, 336, 184, 167, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (337, 337, 499, 202, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (338, 338, 39, 485, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (339, 339, 265, 296, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (340, 340, 218, 397, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (341, 341, 262, 381, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (342, 342, 89, 327, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (343, 343, 460, 192, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (344, 344, 113, 291, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (345, 345, 181, 443, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (346, 346, 250, 413, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (347, 347, 277, 359, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (348, 348, 271, 312, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (349, 349, 193, 67, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (350, 350, 117, 264, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (351, 351, 471, 189, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (352, 352, 422, 20, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (353, 353, 293, 292, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (354, 354, 162, 498, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (355, 355, 63, 71, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (356, 356, 353, 170, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (357, 357, 240, 211, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (358, 358, 49, 49, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (359, 359, 374, 218, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (360, 360, 308, 348, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (361, 361, 157, 54, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (362, 362, 75, 319, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (363, 363, 277, 181, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (364, 364, 371, 153, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (365, 365, 326, 375, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (366, 366, 159, 191, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (367, 367, 449, 189, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (368, 368, 134, 189, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (369, 369, 265, 467, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (370, 370, 148, 407, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (371, 371, 293, 44, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (372, 372, 146, 86, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (373, 373, 62, 445, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (374, 374, 169, 469, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (375, 375, 288, 267, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (376, 376, 288, 195, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (377, 377, 87, 212, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (378, 378, 488, 226, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (379, 379, 411, 67, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (380, 380, 341, 385, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (381, 381, 296, 346, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (382, 382, 49, 4, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (383, 383, 315, 426, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (384, 384, 340, 70, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (385, 385, 77, 44, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (386, 386, 202, 141, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (387, 387, 456, 256, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (388, 388, 28, 313, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (389, 389, 158, 463, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (390, 390, 230, 473, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (391, 391, 6, 226, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (392, 392, 369, 389, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (393, 393, 202, 73, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (394, 394, 199, 29, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (395, 395, 55, 216, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (396, 396, 221, 366, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (397, 397, 51, 432, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (398, 398, 478, 404, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (399, 399, 417, 386, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (400, 400, 283, 247, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (401, 401, 114, 313, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (402, 402, 162, 277, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (403, 403, 457, 225, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (404, 404, 159, 125, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (405, 405, 31, 267, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (406, 406, 159, 412, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (407, 407, 257, 499, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (408, 408, 397, 144, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (409, 409, 126, 422, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (410, 410, 413, 261, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (411, 411, 162, 342, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (412, 412, 117, 429, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (413, 413, 175, 472, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (414, 414, 394, 210, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (415, 415, 11, 15, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (416, 416, 363, 225, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (417, 417, 152, 470, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (418, 418, 376, 359, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (419, 419, 111, 74, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (420, 420, 235, 124, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (421, 421, 292, 410, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (422, 422, 3, 62, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (423, 423, 487, 44, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (424, 424, 145, 36, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (425, 425, 475, 352, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (426, 426, 484, 29, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (427, 427, 346, 2, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (428, 428, 79, 177, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (429, 429, 348, 470, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (430, 430, 155, 271, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (431, 431, 168, 374, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (432, 432, 221, 87, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (433, 433, 45, 80, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (434, 434, 367, 243, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (435, 435, 45, 457, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (436, 436, 358, 430, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (437, 437, 65, 168, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (438, 438, 373, 6, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (439, 439, 347, 253, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (440, 440, 367, 48, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (441, 441, 486, 432, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (442, 442, 299, 280, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (443, 443, 259, 125, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (444, 444, 270, 248, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (445, 445, 75, 45, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (446, 446, 468, 435, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (447, 447, 387, 124, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (448, 448, 446, 296, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (449, 449, 439, 307, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (450, 450, 116, 14, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (451, 451, 379, 102, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (452, 452, 153, 476, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (453, 453, 142, 290, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (454, 454, 243, 98, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (455, 455, 323, 150, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (456, 456, 461, 420, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (457, 457, 414, 471, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (458, 458, 304, 167, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (459, 459, 176, 334, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (460, 460, 248, 438, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (461, 461, 172, 266, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (462, 462, 103, 61, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (463, 463, 376, 325, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (464, 464, 198, 9, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (465, 465, 235, 221, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (466, 466, 245, 221, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (467, 467, 295, 317, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (468, 468, 159, 193, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (469, 469, 261, 287, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (470, 470, 97, 406, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (471, 471, 64, 325, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (472, 472, 92, 227, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (473, 473, 353, 190, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (474, 474, 284, 249, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (475, 475, 140, 271, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (476, 476, 467, 83, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (477, 477, 98, 179, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (478, 478, 429, 209, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (479, 479, 419, 286, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (480, 480, 360, 342, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (481, 481, 426, 171, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (482, 482, 97, 341, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (483, 483, 72, 167, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (484, 484, 389, 292, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (485, 485, 346, 440, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (486, 486, 4, 236, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (487, 487, 445, 422, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (488, 488, 181, 406, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (489, 489, 15, 14, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (490, 490, 262, 338, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (491, 491, 321, 75, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (492, 492, 261, 335, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (493, 493, 399, 468, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (494, 494, 337, 181, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (495, 495, 134, 200, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (496, 496, 59, 340, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (497, 497, 152, 197, 'полная ставка');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (498, 498, 385, 89, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (499, 499, 47, 197, 'полставки');
INSERT INTO public.schedule (id_schedule, id_employee, id_job_title, id_department, wage_rate) OVERRIDING SYSTEM VALUE VALUES (500, 500, 355, 428, 'полная ставка');


--
-- TOC entry 3665 (class 0 OID 16548)
-- Dependencies: 215
-- Data for Name: task; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (1, 460, 1482032490, '2086-07-07', '2020-10-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (2, 204, 1079679670, '2068-02-19', '2062-11-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (3, 280, 1731471284, '2076-11-19', '2026-07-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (4, 97, 123846061, '2067-02-22', '2033-01-17');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (5, 472, 1741438618, '2042-12-22', '2066-11-24');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (6, 474, 173900456, '2010-12-15', '2082-10-26');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (7, 500, 1826416911, '2012-06-05', '2040-02-28');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (8, 121, 1513094907, '2022-11-10', '2086-01-13');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (9, 183, 1789067272, '2036-05-18', '2072-08-02');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (10, 181, 568040015, '2028-06-13', '2047-11-28');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (11, 450, 859079824, '2049-07-16', '2043-05-23');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (12, 276, 1065870741, '2052-07-12', '2032-02-01');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (13, 91, 749361316, '2048-11-07', '2033-05-04');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (14, 31, 1250326473, '2090-03-18', '2072-10-27');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (15, 271, 1788525861, '2018-10-17', '2040-07-13');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (16, 136, 1244501142, '2061-02-12', '2085-04-12');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (17, 130, 936479538, '2019-10-11', '2005-03-19');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (18, 489, 1612668662, '2025-01-11', '2031-08-04');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (19, 301, 653435588, '2082-07-18', '2034-11-04');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (20, 469, 1055021826, '2004-01-27', '2044-02-03');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (21, 138, 334803930, '2087-11-10', '2022-01-07');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (22, 310, 180960942, '2043-01-10', '2069-09-28');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (23, 396, 833998720, '2038-10-08', '2007-10-11');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (24, 307, 845998736, '2075-05-04', '2003-07-15');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (25, 1, 1647776242, '2038-03-11', '2018-04-14');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (26, 80, 337717404, '2020-09-17', '2088-06-28');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (27, 497, 1761414701, '1999-10-27', '2083-08-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (28, 257, 114464518, '2005-08-14', '2005-04-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (29, 372, 1556749775, '2005-07-07', '2016-12-15');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (30, 182, 338147512, '2031-04-11', '2014-08-06');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (31, 257, 1413750168, '2081-08-21', '2041-11-03');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (32, 306, 1716862153, '2000-12-15', '2034-06-27');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (33, 36, 164232895, '2045-01-19', '2057-08-25');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (34, 65, 149746483, '2030-05-22', '2048-08-26');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (35, 96, 852379754, '2083-03-09', '2070-07-12');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (36, 159, 871059831, '2020-02-27', '2056-08-15');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (37, 427, 1723944600, '2048-02-11', '2049-04-02');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (38, 292, 1240767300, '2063-01-19', '2047-11-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (39, 119, 1952660350, '2014-11-13', '2045-03-20');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (40, 364, 1477973619, '2035-07-22', '2010-10-17');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (41, 131, 1510417275, '2047-04-23', '2044-11-01');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (42, 440, 417606609, '2082-11-22', '1999-05-04');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (43, 133, 1502878923, '2024-03-10', '2054-10-01');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (44, 341, 1416181456, '2032-01-20', '2055-04-11');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (45, 371, 536374238, '2032-10-20', '2002-05-25');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (46, 425, 948488536, '2049-04-23', '2065-10-02');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (47, 305, 1108628864, '2090-05-21', '2060-09-07');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (48, 97, 1748914977, '2073-01-06', '2053-01-17');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (49, 223, 1263174694, '2004-06-07', '2026-12-28');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (50, 54, 782468442, '2048-10-08', '2065-06-22');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (51, 50, 1060824573, '2018-02-28', '2079-01-21');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (52, 334, 1752208084, '2087-08-12', '2052-06-15');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (53, 17, 1157161366, '2026-04-02', '2023-05-02');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (54, 101, 1091612866, '2053-05-08', '2083-11-23');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (55, 270, 197209353, '2062-02-26', '2056-10-02');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (56, 218, 300240178, '2048-07-11', '2022-08-20');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (57, 237, 1043739280, '2084-02-05', '2063-03-12');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (58, 286, 784331332, '2015-03-18', '2061-04-24');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (59, 87, 88097524, '2039-04-20', '2075-02-23');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (60, 86, 211637507, '2086-04-06', '2057-04-23');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (61, 405, 1294745611, '2002-04-23', '2083-10-23');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (62, 132, 844905016, '2070-06-04', '2065-05-19');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (63, 354, 953871607, '2068-04-10', '2024-03-25');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (64, 17, 394687692, '2034-08-02', '2005-09-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (65, 85, 117433460, '2059-02-19', '2007-01-04');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (66, 425, 922041425, '2020-07-17', '2066-09-23');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (67, 289, 1697654663, '2025-08-10', '2036-07-15');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (68, 243, 124175491, '2046-03-08', '2066-02-23');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (69, 359, 1301957538, '2026-04-23', '2009-12-02');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (70, 263, 1761160842, '2070-08-22', '2026-06-25');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (71, 112, 760861149, '2080-02-06', '2048-10-18');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (72, 445, 420040071, '2067-05-09', '2002-08-28');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (73, 141, 1569229780, '2049-09-24', '2047-10-02');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (74, 2, 1377386087, '2067-07-22', '2041-10-19');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (75, 154, 1571770203, '2049-05-27', '2056-11-25');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (76, 402, 748691466, '2083-08-04', '2002-01-19');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (77, 26, 1173200386, '2001-03-25', '2023-10-22');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (78, 107, 1339792179, '2087-12-22', '2083-08-07');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (79, 356, 1710520504, '2008-04-19', '2033-08-01');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (80, 445, 571798526, '2042-09-19', '2087-06-01');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (81, 134, 893684401, '2048-03-18', '2067-01-03');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (82, 93, 1292272518, '2026-05-28', '2034-07-11');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (83, 470, 1372910051, '2045-05-05', '2052-10-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (84, 300, 589081465, '2074-05-07', '2025-05-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (85, 333, 415448791, '2018-02-19', '2079-06-03');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (86, 43, 530341811, '2040-04-10', '2032-03-03');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (87, 9, 12079705, '2013-01-25', '1999-03-02');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (88, 267, 643862637, '2001-11-08', '2044-09-18');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (89, 424, 179923095, '2043-01-10', '2037-10-16');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (90, 403, 1238515412, '2081-02-08', '2027-05-22');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (91, 98, 104866017, '2027-04-04', '2064-08-21');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (92, 305, 1557123188, '2025-06-05', '2048-02-07');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (93, 429, 1107992072, '2003-04-05', '2052-07-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (94, 4, 1621035030, '2042-05-08', '2084-06-17');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (95, 4, 748122643, '2045-04-12', '2055-12-06');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (96, 149, 1253061240, '2073-11-23', '2011-09-24');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (97, 376, 1053534866, '2054-09-13', '2017-07-07');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (98, 62, 1016543861, '2013-01-27', '2056-06-15');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (99, 46, 1775673583, '2069-12-15', '2065-11-04');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (100, 429, 1869988288, '2005-06-05', '2049-06-19');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (101, 231, 1279545103, '2052-04-04', '2072-04-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (102, 436, 1081005120, '2025-08-10', '2042-01-26');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (103, 93, 1028448642, '2066-07-15', '2044-06-13');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (104, 188, 889203778, '2016-11-05', '2048-10-15');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (105, 451, 36704686, '2083-05-20', '2006-08-28');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (106, 143, 799226872, '2021-09-26', '2012-05-18');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (107, 216, 1734086675, '1999-04-17', '2051-10-28');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (108, 310, 1771953433, '2032-12-23', '2069-03-01');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (109, 384, 1469923841, '2080-09-16', '2041-04-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (110, 350, 1574891350, '2028-04-19', '2043-10-08');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (111, 304, 872988788, '2009-01-07', '2048-10-13');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (112, 388, 961979827, '2052-10-12', '2039-02-19');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (113, 31, 705477591, '2013-07-20', '2021-06-20');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (114, 443, 1878676536, '2038-08-26', '2037-06-10');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (115, 213, 1463311569, '2009-12-10', '2019-10-09');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (116, 349, 689267699, '2043-10-25', '2020-11-10');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (117, 303, 1552707517, '2073-06-28', '2067-06-19');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (118, 161, 1927099185, '2077-02-19', '2029-04-20');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (119, 136, 1522954190, '2065-11-02', '2052-05-21');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (120, 300, 1627796681, '2011-07-16', '2030-08-21');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (121, 244, 807955675, '2000-04-03', '2002-01-22');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (122, 395, 1834916226, '2040-12-09', '2033-10-16');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (123, 80, 1087261006, '2078-02-05', '2061-03-11');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (124, 430, 949837345, '2087-03-24', '2019-04-14');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (125, 477, 572656093, '1999-07-14', '2082-12-17');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (126, 275, 1891637383, '2036-05-26', '2056-10-28');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (127, 41, 1030327608, '2026-08-07', '2023-01-10');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (128, 246, 106949518, '2050-03-01', '2016-09-10');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (129, 200, 1646659969, '2029-02-14', '2052-02-11');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (130, 88, 1854283236, '2010-08-06', '2046-11-21');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (131, 334, 458199355, '2025-12-26', '2040-03-23');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (132, 247, 616764669, '2052-11-16', '2038-04-19');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (133, 42, 372342766, '2028-02-12', '2010-01-10');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (134, 26, 461815779, '2078-12-11', '2076-04-21');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (135, 86, 873002799, '2005-11-23', '2042-07-10');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (136, 63, 309433768, '2074-11-20', '2060-09-14');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (137, 331, 1357818703, '2080-11-24', '2010-04-07');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (138, 340, 84746095, '2032-01-02', '2090-04-22');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (139, 213, 1911700716, '2017-02-22', '2005-12-14');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (140, 488, 1985957647, '2017-06-12', '2047-09-14');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (141, 382, 1613987877, '2028-04-03', '2066-03-12');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (142, 399, 392741992, '2037-10-18', '2073-12-26');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (143, 418, 273017936, '2016-07-13', '2027-11-20');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (144, 275, 661269017, '2022-09-18', '2001-11-21');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (145, 200, 336539818, '2016-07-12', '2033-10-15');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (146, 450, 1962529948, '2030-01-19', '2089-12-14');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (147, 426, 124330520, '2002-07-20', '2079-05-13');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (148, 343, 472155837, '2058-01-01', '2076-12-11');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (149, 2, 1015069666, '2019-10-11', '2039-08-14');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (150, 408, 484761778, '2067-03-07', '2066-10-06');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (151, 338, 1351372265, '2000-01-14', '2045-03-01');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (152, 303, 1582508472, '2067-07-23', '2062-05-14');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (153, 346, 930669864, '2029-02-12', '2041-12-18');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (154, 262, 895095973, '2031-09-20', '2081-08-07');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (155, 135, 1743174853, '2068-06-05', '2038-07-02');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (156, 391, 1077555866, '2005-02-12', '2076-02-02');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (157, 396, 278504536, '2053-08-08', '2007-07-09');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (158, 326, 1627207373, '2018-03-06', '2020-02-06');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (159, 91, 925208559, '2045-05-01', '2076-07-02');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (160, 457, 1367703463, '2057-02-16', '2059-03-16');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (161, 162, 1698295075, '2022-04-26', '2066-04-27');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (162, 34, 1954183926, '2032-07-09', '2053-01-28');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (163, 9, 1050963364, '2079-12-26', '2043-09-09');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (164, 84, 1655362365, '2075-08-01', '2082-04-23');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (165, 377, 1029537616, '2081-05-28', '2082-05-16');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (166, 362, 1103119963, '2041-03-07', '2014-09-11');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (167, 167, 1371131730, '2070-10-20', '2027-06-07');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (168, 316, 761643386, '2065-03-11', '2057-10-02');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (169, 258, 244857770, '2050-02-23', '2025-01-24');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (170, 223, 1488951421, '2000-09-07', '2008-06-21');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (171, 152, 1574782676, '2034-03-19', '2042-06-19');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (172, 38, 999175157, '2062-08-02', '2017-10-08');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (173, 225, 658246790, '2076-11-25', '2056-10-11');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (174, 282, 386191265, '2072-03-17', '2016-04-02');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (175, 23, 896693555, '2046-05-01', '2057-08-11');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (176, 134, 695632439, '2005-09-02', '2010-08-17');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (177, 226, 1024565499, '2052-01-27', '2020-10-20');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (178, 148, 562715841, '2054-08-23', '2074-12-01');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (179, 90, 1808881903, '2081-06-02', '2083-10-12');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (180, 273, 870516205, '2027-02-06', '2057-06-01');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (181, 279, 10181827, '2085-10-06', '2032-01-04');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (182, 468, 1116365739, '2024-04-17', '2006-10-13');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (183, 226, 3791391, '2034-04-20', '2064-12-13');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (184, 453, 121306814, '2069-03-12', '2073-06-02');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (185, 95, 97075456, '2039-01-27', '2010-05-10');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (186, 497, 61506289, '2038-07-22', '2015-11-03');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (187, 469, 1632106806, '2051-08-13', '2001-08-27');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (188, 361, 645946509, '2079-12-18', '2074-05-17');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (189, 194, 532136836, '2059-05-17', '2006-10-28');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (190, 285, 955889013, '2086-12-26', '2054-07-24');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (191, 205, 1019758641, '1999-07-07', '2032-07-22');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (192, 208, 747124253, '2034-04-07', '2008-11-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (193, 256, 5338425, '2029-09-14', '2086-08-03');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (194, 319, 1754972958, '2040-02-26', '2043-06-20');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (195, 318, 1338782390, '2070-09-17', '2078-05-08');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (196, 58, 847327099, '2084-01-28', '2084-01-15');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (197, 233, 1890635613, '2067-04-10', '2055-09-19');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (198, 284, 138956785, '2039-05-20', '2005-12-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (199, 282, 1088165015, '2055-05-28', '2085-02-26');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (200, 173, 1718287526, '2070-09-22', '2036-10-15');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (201, 99, 552232229, '2031-01-26', '2079-10-08');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (202, 124, 699956051, '2032-07-02', '2079-04-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (203, 184, 1918191341, '2086-11-01', '2051-04-04');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (204, 340, 1611958354, '2054-08-12', '2036-05-27');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (205, 448, 860522206, '2009-01-26', '2024-11-26');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (206, 3, 1145786201, '2075-12-19', '2016-12-26');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (207, 174, 1161993273, '2060-07-27', '2022-08-12');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (208, 467, 415021321, '2045-02-03', '2087-01-04');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (209, 386, 1127284998, '2076-02-16', '2047-10-06');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (210, 286, 523520629, '2064-10-01', '2023-01-06');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (211, 322, 1767471144, '2048-09-25', '2000-09-16');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (212, 304, 568015120, '2088-02-02', '2025-12-03');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (213, 155, 972496983, '2063-06-11', '2040-06-09');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (214, 453, 223184629, '2079-11-02', '2039-10-01');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (215, 245, 1014509638, '2071-09-17', '2051-07-27');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (216, 104, 1326545408, '2017-08-19', '2010-05-10');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (217, 150, 1356239410, '2081-03-15', '2076-06-27');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (218, 312, 593115807, '2051-08-28', '2031-08-08');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (219, 125, 937526621, '2066-12-15', '2047-05-28');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (220, 54, 1995639241, '2074-05-25', '2088-05-26');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (221, 343, 662106295, '2010-01-12', '2036-02-10');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (222, 380, 1852647731, '2027-02-26', '2050-04-07');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (223, 174, 310279313, '2002-07-15', '2052-09-24');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (224, 340, 909670462, '2002-01-22', '2030-12-10');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (225, 290, 1290870099, '2070-04-28', '2032-02-20');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (226, 402, 900767102, '2009-10-13', '2059-12-24');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (227, 37, 58166895, '2072-02-21', '2082-02-19');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (228, 171, 1414231154, '2046-11-08', '2079-05-17');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (229, 232, 1832305701, '2013-08-05', '2022-01-19');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (230, 483, 1392617586, '2076-07-02', '2000-11-24');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (231, 167, 952264615, '2043-10-01', '2089-10-08');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (232, 452, 1275908773, '2035-05-02', '2005-12-16');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (233, 123, 1279435765, '2060-12-05', '2017-12-24');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (234, 9, 1365870999, '2050-12-12', '2040-03-06');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (235, 355, 1767120038, '2022-03-08', '2005-07-22');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (236, 109, 1183630090, '2025-04-26', '2003-03-08');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (237, 306, 1187420791, '2062-06-06', '2072-08-25');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (238, 44, 244035134, '2014-12-24', '2050-09-13');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (239, 400, 1001190540, '2033-12-21', '2079-12-10');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (240, 74, 1645554886, '2003-03-22', '2037-06-14');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (241, 197, 239328831, '2033-07-10', '2041-04-20');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (242, 415, 545492273, '2001-10-20', '2075-12-07');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (243, 381, 419372569, '2050-12-12', '2047-10-26');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (244, 389, 622662255, '2051-01-25', '2001-03-16');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (245, 389, 1494810331, '2028-06-09', '2015-02-09');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (246, 442, 457013612, '2081-11-20', '2021-10-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (247, 328, 928378787, '2044-08-13', '2087-07-02');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (248, 154, 171239089, '2039-09-17', '1999-09-14');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (249, 116, 1710934777, '2015-10-16', '2000-06-11');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (250, 258, 757459606, '2026-04-20', '2018-11-03');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (251, 77, 338372244, '2052-11-05', '2025-04-27');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (252, 105, 1096518917, '2079-07-02', '2088-05-07');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (253, 19, 398772057, '2078-06-14', '2043-09-23');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (254, 428, 629497065, '2007-05-06', '2087-09-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (255, 284, 1768574181, '2029-12-05', '2042-06-10');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (256, 447, 289561172, '2028-10-23', '2086-03-16');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (257, 114, 1577964285, '2080-07-26', '2081-04-27');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (258, 184, 1427756365, '2047-08-23', '2016-01-24');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (259, 389, 946462388, '2078-08-25', '2001-04-24');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (260, 446, 351112317, '2036-01-20', '2065-09-14');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (261, 445, 1862719825, '2062-11-23', '2052-01-03');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (262, 55, 635370415, '2076-05-20', '2041-08-11');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (263, 17, 1523942019, '2017-10-08', '2006-02-21');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (264, 116, 656826992, '2034-03-08', '2053-08-12');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (265, 396, 1928771311, '2004-11-27', '2060-04-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (266, 40, 373622552, '2018-07-17', '2003-02-26');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (267, 241, 1799616599, '2028-02-03', '2018-09-10');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (268, 241, 266188157, '2002-09-13', '2069-07-07');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (269, 74, 574485944, '2051-10-24', '2019-04-19');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (270, 36, 1762641171, '2035-03-22', '2028-02-22');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (271, 460, 507456395, '2033-08-04', '2076-09-12');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (272, 436, 1936871752, '2015-07-25', '2052-08-11');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (273, 288, 1991816713, '2029-04-12', '2058-02-28');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (274, 370, 308170151, '2028-08-11', '2005-11-04');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (275, 192, 813312722, '2046-11-28', '2041-09-15');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (276, 357, 1539009733, '2038-10-28', '2052-06-26');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (277, 418, 1023844438, '2084-12-17', '2073-12-28');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (278, 325, 1327049553, '2054-06-07', '2044-11-11');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (279, 65, 438340178, '2050-02-17', '2065-11-15');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (280, 38, 1932005263, '2014-06-16', '2013-12-14');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (281, 421, 360622525, '2053-09-12', '2085-03-24');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (282, 214, 1269116817, '2023-09-16', '2030-02-17');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (283, 166, 1683333336, '2075-11-03', '2056-09-22');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (284, 164, 1111753560, '2089-05-19', '2022-09-03');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (285, 264, 82088410, '2066-07-18', '2026-08-12');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (286, 381, 487388843, '2047-01-08', '2001-12-09');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (287, 110, 822133777, '2034-09-04', '2036-07-09');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (288, 252, 1377376081, '2082-12-22', '2069-12-18');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (289, 257, 668375320, '2084-12-05', '2039-08-21');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (290, 12, 638063524, '2062-06-08', '2066-04-22');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (291, 409, 1555959806, '2009-01-08', '2085-03-26');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (292, 375, 299735471, '2025-11-01', '2024-11-18');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (293, 339, 140100830, '2014-11-13', '2001-08-12');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (294, 115, 315571748, '2066-05-24', '2085-09-20');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (295, 243, 1361398501, '2009-07-24', '2054-06-19');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (296, 23, 193116654, '2040-06-03', '2071-08-18');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (297, 317, 1963044963, '1999-10-12', '2077-01-07');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (298, 378, 602936049, '2087-09-03', '2089-08-06');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (299, 99, 923075733, '2012-07-28', '2050-01-17');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (300, 376, 1334049969, '2082-01-26', '2027-01-10');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (301, 5, 1457852073, '2038-09-18', '2027-12-10');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (302, 493, 584270636, '2069-01-11', '2045-01-19');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (303, 491, 1433922995, '2003-03-19', '2088-10-13');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (304, 62, 221219939, '2023-08-13', '2060-09-26');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (305, 422, 337564504, '2025-01-17', '2023-02-03');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (306, 105, 907226808, '2056-02-22', '2078-05-03');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (307, 78, 1033147229, '2051-12-11', '2022-11-06');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (308, 275, 1285270071, '2060-05-08', '2013-08-10');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (309, 108, 1685399830, '2041-11-24', '2087-10-01');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (310, 450, 816269409, '2016-01-24', '2042-11-07');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (311, 336, 1177881938, '2028-10-24', '2020-02-10');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (312, 160, 281900707, '2077-12-02', '2083-08-06');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (313, 463, 1524410143, '2030-02-11', '2077-01-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (314, 262, 1400828666, '2044-04-25', '2034-05-08');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (315, 289, 1661965105, '2028-08-17', '2075-04-01');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (316, 192, 74674002, '2033-07-18', '2076-11-21');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (317, 444, 851140485, '2035-10-08', '2033-05-28');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (318, 461, 487305870, '2009-05-13', '2070-05-25');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (319, 106, 574676748, '2032-07-14', '2047-02-09');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (320, 27, 1775681021, '2050-08-16', '2083-05-06');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (321, 437, 1754206754, '2072-09-27', '2064-11-11');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (322, 302, 115279333, '2072-02-07', '2025-10-25');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (323, 346, 1396948869, '2012-02-05', '2003-02-19');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (324, 464, 668718454, '2064-10-28', '2063-02-11');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (325, 354, 1417514351, '2005-10-20', '2090-01-16');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (326, 269, 29698676, '2066-12-05', '2076-02-28');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (327, 371, 1652585554, '2016-11-19', '2004-01-26');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (328, 105, 173900492, '2029-08-08', '2038-10-02');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (329, 399, 434763639, '2087-06-12', '2029-07-02');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (330, 348, 1195748708, '2025-09-11', '2037-08-06');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (331, 14, 717190342, '2015-07-18', '2032-08-06');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (332, 61, 316953433, '2066-02-19', '2055-12-15');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (333, 4, 580300644, '2026-05-22', '2001-01-17');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (334, 342, 1782991440, '2035-05-07', '2004-01-28');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (335, 246, 1849398427, '2006-05-12', '2049-10-08');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (336, 304, 1149527760, '2064-02-12', '2066-05-25');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (337, 494, 233395722, '2054-01-02', '2081-07-21');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (338, 397, 588494842, '2075-01-06', '2075-04-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (339, 481, 1613885354, '2066-04-07', '2038-02-04');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (340, 200, 231203638, '2081-04-03', '2011-04-18');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (341, 339, 786286391, '2068-04-17', '2043-01-14');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (342, 442, 364770261, '2061-12-02', '2049-08-04');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (343, 481, 303765497, '2048-06-06', '2077-07-02');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (344, 453, 1246769974, '2059-06-15', '2048-12-28');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (345, 457, 848728407, '2056-06-06', '2036-03-09');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (346, 402, 1196618348, '2074-06-20', '2000-07-28');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (347, 369, 596674585, '2010-02-06', '2048-03-01');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (348, 265, 1862974528, '2063-11-24', '2009-06-09');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (349, 119, 1628440307, '2051-05-20', '1999-08-25');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (350, 462, 1326564564, '2047-01-21', '2039-10-23');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (351, 309, 1532719448, '2088-12-09', '2052-08-04');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (352, 224, 1638057097, '2056-04-22', '2071-07-14');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (353, 356, 1203955032, '2001-12-21', '2054-07-04');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (354, 65, 681583855, '2019-06-14', '2001-08-03');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (355, 59, 1130882480, '2033-01-18', '2012-12-03');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (356, 19, 1707210920, '2040-11-16', '2031-09-16');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (357, 227, 476493054, '2014-01-21', '2006-04-06');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (358, 218, 299057419, '2055-07-20', '2048-07-11');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (359, 465, 895449778, '1999-02-01', '1999-04-14');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (360, 309, 1716445248, '2054-09-11', '2065-10-26');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (361, 9, 1280978334, '2049-01-01', '2030-03-25');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (362, 345, 260769589, '2030-07-22', '2068-06-14');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (363, 453, 892752804, '2011-08-07', '2042-12-28');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (364, 308, 633837192, '2056-06-13', '2005-05-20');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (365, 98, 285860347, '2025-12-01', '2002-01-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (366, 158, 1314171098, '2053-03-17', '2056-05-23');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (367, 352, 1602677396, '2066-04-23', '2027-10-25');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (368, 443, 131652592, '2057-06-01', '2081-12-13');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (369, 44, 126619251, '2004-01-01', '2008-01-18');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (370, 206, 680546410, '2046-07-26', '2032-08-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (371, 328, 1518044746, '2082-05-02', '2049-07-10');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (372, 482, 1542572377, '2004-09-13', '2004-01-13');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (373, 390, 512154685, '2057-04-18', '2079-03-17');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (374, 16, 574626886, '2001-09-06', '2029-12-09');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (375, 272, 1786641254, '2062-01-19', '2069-09-12');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (376, 2, 665730106, '2005-10-04', '2038-11-23');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (377, 455, 475357343, '2035-08-04', '2036-03-22');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (378, 473, 963085901, '2041-04-20', '2012-11-24');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (379, 54, 1228862248, '2043-09-16', '2017-03-06');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (380, 271, 1956677152, '2028-08-06', '2004-02-10');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (381, 361, 1955561954, '2064-04-17', '2079-08-19');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (382, 415, 319847966, '2031-08-12', '2078-07-22');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (383, 207, 979323044, '2002-08-01', '2075-12-20');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (384, 236, 1817353645, '2072-08-28', '2055-02-17');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (385, 418, 1404917538, '2039-12-17', '2035-09-10');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (386, 380, 203849228, '2027-11-09', '2018-12-02');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (387, 52, 525508262, '2085-12-11', '2031-04-08');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (388, 251, 1278894422, '2015-11-10', '2024-06-20');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (389, 376, 1600997890, '2006-06-14', '2024-01-12');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (390, 361, 1787494743, '2082-08-14', '2004-09-03');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (391, 280, 216447625, '2048-10-27', '2085-05-27');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (392, 448, 356617746, '2049-11-06', '2016-12-13');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (393, 217, 1324537570, '2031-11-10', '2004-03-11');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (394, 311, 882035220, '2012-06-27', '2013-08-17');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (395, 375, 669582542, '2017-06-08', '2054-09-02');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (396, 234, 175579859, '2010-10-22', '2057-11-15');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (397, 76, 350014473, '2075-12-09', '2054-01-26');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (398, 55, 1792238405, '2022-09-01', '2061-02-14');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (399, 204, 1938367428, '2072-09-22', '2058-07-04');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (400, 214, 1365748700, '2041-06-25', '2007-07-13');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (401, 192, 562232512, '2000-08-23', '2018-09-09');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (402, 442, 1812506838, '2073-01-07', '2089-12-24');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (403, 408, 1006429260, '2081-05-15', '2076-04-04');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (404, 464, 352229086, '2054-08-16', '2014-06-10');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (405, 466, 1807065893, '2008-03-26', '2004-01-13');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (406, 202, 603249808, '2000-11-14', '2089-05-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (407, 387, 1567881966, '2005-05-10', '2076-03-08');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (408, 79, 521753943, '2084-04-11', '2046-11-23');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (409, 473, 412309366, '2084-01-10', '2078-12-09');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (410, 1, 736721086, '2025-07-23', '2075-02-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (411, 264, 1964502239, '2052-09-14', '2080-03-15');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (412, 235, 1552846491, '2062-11-03', '2083-04-23');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (413, 57, 137231202, '1999-04-21', '2051-10-09');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (414, 4, 1724418425, '2031-08-23', '2033-07-19');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (415, 115, 1457132397, '2029-10-22', '2075-01-04');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (416, 122, 374739653, '2015-12-23', '2069-09-19');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (417, 192, 1246951200, '2014-08-17', '2003-07-26');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (418, 469, 917753123, '2000-01-12', '2015-11-27');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (419, 96, 24748214, '2033-05-03', '2048-04-28');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (420, 368, 1795588805, '2009-05-17', '2061-02-09');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (421, 455, 154054295, '2009-12-14', '2016-06-27');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (422, 384, 117895549, '2012-01-09', '2023-04-26');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (423, 418, 720128950, '2086-12-28', '2065-01-10');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (424, 160, 995522869, '2081-11-14', '2019-08-26');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (425, 485, 1937334240, '2006-08-04', '2041-03-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (426, 485, 674713553, '2043-04-24', '2033-01-23');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (427, 99, 400274640, '2026-06-01', '2028-07-06');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (428, 174, 1003436892, '2023-11-08', '2087-02-26');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (429, 344, 443374486, '2017-10-25', '2026-11-03');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (430, 199, 415434111, '2023-10-27', '2044-01-10');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (431, 360, 1173602282, '2003-04-14', '2052-12-14');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (432, 432, 1798104609, '2006-11-17', '2028-12-17');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (433, 59, 1711703783, '2051-03-09', '2015-03-15');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (434, 281, 978723876, '2026-11-24', '2083-03-28');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (435, 227, 1446929772, '2007-03-14', '2052-11-06');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (436, 296, 27754017, '2047-02-21', '2010-07-24');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (437, 201, 390531584, '2008-07-24', '2047-11-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (438, 71, 915456400, '2080-12-27', '2012-02-09');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (439, 289, 1033491771, '2013-05-20', '2062-05-04');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (440, 103, 1468585165, '2006-01-20', '2058-07-18');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (441, 57, 1343010194, '2072-10-22', '2010-12-26');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (442, 290, 1756709359, '2047-09-27', '2047-08-28');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (443, 319, 289418129, '2011-06-12', '2054-12-07');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (444, 158, 1972253640, '2011-03-13', '2063-12-25');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (445, 391, 1672728014, '2059-08-10', '2078-02-11');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (446, 282, 831990925, '2002-09-04', '2070-03-12');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (447, 461, 448155583, '2088-12-11', '2076-11-26');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (448, 103, 1017290805, '2003-10-09', '2077-06-27');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (449, 207, 1895107554, '2067-01-09', '2050-06-01');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (450, 8, 694207969, '2066-07-19', '2040-11-04');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (451, 449, 1001259386, '2030-09-08', '2011-01-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (452, 35, 140482853, '2042-01-15', '2039-03-23');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (453, 124, 506896252, '2076-07-28', '2072-07-13');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (454, 447, 1180343929, '2090-09-06', '2077-12-26');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (455, 58, 152749129, '2084-03-23', '2059-02-12');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (456, 60, 64524174, '2013-08-16', '2074-06-11');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (457, 255, 1011935781, '2058-01-25', '2031-07-14');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (458, 289, 55116809, '2033-07-05', '2051-11-05');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (459, 67, 1569884431, '2082-05-19', '2017-05-24');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (460, 299, 1303837327, '2070-09-02', '2064-03-15');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (461, 46, 1809158101, '2076-08-26', '2030-06-27');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (462, 18, 749912926, '2067-02-04', '2008-10-02');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (463, 113, 217005750, '2054-02-26', '2018-12-11');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (464, 454, 1786835957, '2049-11-25', '2042-01-22');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (465, 30, 1157457988, '2018-07-04', '2085-05-25');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (466, 55, 319660639, '2050-02-22', '2041-01-24');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (467, 192, 1942252322, '2035-02-26', '2072-04-13');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (468, 307, 243275862, '2052-06-11', '2049-11-14');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (469, 470, 1619647550, '2063-07-01', '2017-11-08');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (470, 409, 293690410, '2045-06-27', '2045-10-26');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (471, 347, 55801564, '2087-02-11', '2014-12-16');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (472, 293, 1373086038, '2003-10-22', '2060-10-08');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (473, 22, 1612291197, '2025-06-04', '2009-07-16');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (474, 462, 1978954807, '2048-11-12', '2051-01-27');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (475, 329, 325666640, '2058-10-04', '2036-05-03');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (476, 293, 577357158, '2061-10-05', '2086-12-25');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (477, 402, 1684460796, '2089-02-12', '2035-07-19');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (478, 56, 1560809538, '2040-08-03', '2087-10-13');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (479, 340, 1105424832, '2011-10-21', '2086-04-25');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (480, 411, 1458889855, '2054-05-11', '2059-05-08');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (481, 80, 698867765, '2016-12-05', '2026-09-14');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (482, 379, 1024582103, '2009-12-19', '2040-02-13');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (483, 159, 127151403, '2038-03-28', '2019-09-28');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (484, 213, 388193553, '2010-05-17', '2042-05-16');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (485, 340, 201879372, '2089-04-22', '2049-01-28');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (486, 488, 1938205717, '2075-12-03', '2003-02-22');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (487, 88, 761351116, '2088-03-10', '2042-06-04');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (488, 44, 1593579153, '2050-01-03', '2020-08-02');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (489, 130, 1235078686, '2004-05-15', '2074-05-14');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (490, 284, 633712818, '2088-08-27', '2008-05-13');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (491, 150, 568370691, '2041-02-23', '2058-04-11');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (492, 62, 405464681, '2033-11-19', '2044-12-13');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (493, 454, 39581689, '2072-07-21', '2020-09-26');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (494, 413, 1730680822, '2044-03-19', '2072-06-22');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (495, 13, 1225495895, '2049-08-23', '2036-06-26');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (496, 20, 1044927818, '2049-12-28', '2062-04-04');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (497, 400, 1860641670, '2021-03-18', '2047-06-15');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (498, 460, 840656445, '2003-12-05', '2045-11-19');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (499, 280, 1020111596, '2048-12-04', '2016-12-09');
INSERT INTO public.task (id_task, id_project, task_price, task_deadline, task_start_date) OVERRIDING SYSTEM VALUE VALUES (500, 325, 499099428, '2048-07-02', '2079-02-22');


--
-- TOC entry 3666 (class 0 OID 16560)
-- Dependencies: 216
-- Data for Name: task_steps; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (1, 74, 38, 152074, '2001-02-16', '2003-09-11', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (2, 190, 362, 315762, '2074-12-06', '2077-08-21', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (3, 191, 281, 172142, '2038-01-18', '2040-08-25', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (4, 178, 100, 119622, '2025-10-13', '2027-08-14', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (5, 365, 100, 475899, '2029-05-06', '2030-05-14', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (6, 13, 393, 453782, '2058-06-01', '2061-10-09', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (7, 435, 230, 407159, '2024-12-08', '2027-03-18', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (8, 460, 371, 190665, '2057-11-06', '2060-10-26', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (9, 53, 474, 350001, '2074-12-01', '2076-01-08', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (10, 472, 248, 296109, '2038-04-18', '2041-11-19', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (11, 25, 146, 77599, '2009-12-01', '2012-02-04', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (12, 314, 140, 313332, '2083-03-22', '2085-11-04', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (13, 15, 306, 285203, '2030-07-17', '2032-09-14', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (14, 203, 432, 8637, '2078-02-15', '2079-08-02', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (15, 214, 446, 221227, '2039-01-02', '2040-11-16', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (16, 56, 287, 86267, '2060-08-22', '2061-04-08', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (17, 84, 305, 159509, '2041-10-12', '2042-12-25', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (18, 192, 198, 442245, '2042-03-03', '2043-07-03', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (19, 42, 34, 153187, '2029-03-27', '2032-09-12', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (20, 102, 327, 126753, '2037-12-27', '2039-01-16', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (21, 176, 130, 52493, '2090-08-24', '2091-02-16', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (22, 68, 211, 466963, '2000-08-16', '2003-01-25', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (23, 360, 257, 75099, '2019-09-08', '2021-12-09', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (24, 412, 491, 271690, '2035-02-21', '2037-04-14', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (25, 37, 156, 418538, '2008-10-14', '2009-09-07', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (26, 237, 342, 451056, '2067-01-11', '2069-07-12', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (27, 101, 463, 412137, '2000-10-09', '2002-11-20', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (28, 85, 436, 47760, '2062-04-02', '2064-09-21', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (29, 379, 245, 164335, '2015-11-16', '2017-08-27', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (30, 177, 197, 374857, '2079-06-26', '2081-04-11', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (31, 410, 112, 132120, '2026-07-01', '2027-03-14', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (32, 433, 485, 166928, '2088-10-02', '2091-10-12', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (33, 258, 201, 407778, '2025-07-06', '2027-03-14', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (34, 37, 340, 95905, '2012-10-09', '2015-03-13', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (35, 176, 277, 308911, '2067-09-11', '2068-09-08', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (36, 331, 217, 16745, '2051-04-04', '2052-11-09', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (37, 427, 211, 179638, '2042-05-18', '2043-11-16', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (38, 322, 184, 124374, '2086-05-19', '2088-04-06', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (39, 212, 380, 365655, '2038-10-22', '2041-07-16', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (40, 283, 90, 33958, '2027-02-10', '2030-04-06', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (41, 194, 352, 174639, '2012-08-23', '2013-09-17', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (42, 443, 368, 220893, '2012-06-25', '2013-08-03', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (43, 237, 127, 98999, '2018-06-04', '2019-05-27', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (44, 99, 1, 6757, '2035-06-20', '2036-08-03', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (45, 452, 77, 830, '2047-06-22', '2050-10-27', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (46, 341, 374, 102211, '2062-05-06', '2064-08-03', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (47, 96, 71, 135576, '2038-06-07', '2040-05-13', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (48, 310, 393, 388621, '2078-01-28', '2081-01-25', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (49, 364, 408, 464353, '1999-02-01', '2000-12-23', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (50, 354, 477, 318747, '2006-03-19', '2007-12-19', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (51, 153, 381, 196767, '2027-05-13', '2029-06-08', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (52, 323, 118, 141461, '2090-10-25', '2093-04-08', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (53, 414, 433, 418467, '2031-11-10', '2032-07-12', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (54, 79, 184, 295048, '2006-07-17', '2008-07-17', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (55, 205, 238, 66914, '2054-06-14', '2057-06-21', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (56, 358, 428, 147391, '2069-12-16', '2070-01-09', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (57, 101, 187, 453042, '2076-10-14', '2078-03-21', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (58, 94, 282, 436445, '2045-11-24', '2048-03-21', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (59, 136, 63, 206570, '2058-08-21', '2061-05-24', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (60, 268, 97, 14382, '2047-08-07', '2049-07-01', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (61, 309, 270, 107716, '2076-06-10', '2078-01-15', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (62, 433, 489, 385126, '2066-03-16', '2067-06-25', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (63, 156, 168, 467195, '2033-04-19', '2036-02-25', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (64, 407, 274, 271023, '2012-04-11', '2014-11-25', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (65, 78, 477, 423998, '2012-06-08', '2013-05-07', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (66, 381, 101, 74592, '2013-11-20', '2016-11-21', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (67, 31, 461, 136252, '2028-03-10', '2029-09-08', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (68, 311, 63, 313303, '1999-04-09', '2000-09-07', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (69, 141, 365, 85607, '2073-03-19', '2074-11-25', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (70, 374, 423, 27212, '2063-09-21', '2065-11-04', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (71, 100, 119, 260923, '2084-09-24', '2085-03-13', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (72, 441, 5, 306189, '2083-09-08', '2085-06-12', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (73, 296, 269, 70073, '2028-09-16', '2030-03-03', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (74, 172, 474, 315157, '2024-09-09', '2026-01-02', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (75, 489, 238, 57364, '2084-03-27', '2085-04-25', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (76, 480, 295, 453963, '2002-03-26', '2003-01-11', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (77, 169, 438, 440057, '2084-08-22', '2087-09-25', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (78, 134, 366, 372073, '2068-08-07', '2071-07-07', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (79, 163, 268, 333051, '2089-03-19', '2090-05-22', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (80, 198, 28, 110673, '2003-08-23', '2004-05-26', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (81, 44, 44, 282324, '2067-10-23', '2068-01-15', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (82, 91, 308, 127039, '2031-08-13', '2032-07-20', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (83, 89, 199, 399236, '2075-07-24', '2076-01-07', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (84, 296, 103, 271477, '2038-12-03', '2039-01-17', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (85, 81, 6, 45957, '2025-05-19', '2027-01-10', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (86, 408, 292, 333181, '2084-07-02', '2086-07-19', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (87, 321, 360, 486351, '2032-06-02', '2034-01-07', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (88, 259, 345, 201550, '2089-07-28', '2090-12-04', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (89, 496, 47, 214974, '2069-03-19', '2070-07-06', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (90, 298, 495, 363372, '2076-03-21', '2078-09-16', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (91, 259, 196, 19864, '2046-06-13', '2048-08-20', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (92, 412, 172, 395920, '2067-06-09', '2068-11-24', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (93, 361, 359, 474940, '2004-10-12', '2006-08-25', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (94, 50, 435, 97012, '2070-09-08', '2073-12-21', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (95, 175, 9, 331540, '2056-12-25', '2057-01-20', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (96, 270, 290, 254653, '2058-01-01', '2061-12-20', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (97, 88, 215, 127621, '2025-02-25', '2028-03-11', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (98, 13, 186, 249814, '2064-04-16', '2065-11-21', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (99, 328, 283, 264081, '2021-07-18', '2023-07-16', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (100, 356, 181, 265390, '2000-08-06', '2001-09-15', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (101, 152, 82, 493544, '2088-01-17', '2090-02-04', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (102, 60, 360, 457702, '2021-10-26', '2024-05-19', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (103, 45, 42, 3141, '2033-11-11', '2036-06-19', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (104, 418, 96, 115444, '2006-10-16', '2008-06-06', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (105, 365, 5, 128637, '2071-03-12', '2074-09-21', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (106, 415, 296, 422316, '2088-12-05', '2090-12-23', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (107, 493, 455, 169739, '2087-09-24', '2088-04-02', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (108, 254, 143, 385137, '2053-10-28', '2056-12-07', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (109, 28, 449, 6554, '2003-03-03', '2004-04-11', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (110, 278, 133, 279561, '2059-08-06', '2061-06-09', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (111, 314, 68, 421375, '2066-12-05', '2069-10-08', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (112, 391, 89, 64653, '2050-06-17', '2053-02-16', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (113, 245, 63, 140123, '2033-04-25', '2034-08-08', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (114, 109, 249, 375479, '1999-12-06', '2002-10-21', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (115, 186, 282, 234378, '2045-04-24', '2046-04-21', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (116, 419, 361, 260841, '2016-01-08', '2017-03-28', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (117, 20, 47, 266814, '2002-04-18', '2005-06-19', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (118, 178, 451, 388327, '2006-01-05', '2007-05-26', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (119, 123, 229, 265024, '2019-01-12', '2020-06-09', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (120, 396, 31, 61393, '2058-10-09', '2061-07-10', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (121, 214, 402, 204055, '2053-08-13', '2055-02-04', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (122, 238, 296, 198220, '2062-11-24', '2065-06-10', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (123, 121, 218, 76158, '2065-09-11', '2067-05-08', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (124, 222, 173, 287627, '2043-06-08', '2046-10-01', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (125, 325, 280, 433233, '2082-07-14', '2085-08-22', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (126, 113, 101, 29610, '2080-07-10', '2081-08-27', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (127, 285, 73, 59522, '2085-04-14', '2086-01-17', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (128, 294, 382, 143982, '2065-05-17', '2066-04-26', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (129, 198, 418, 180310, '2069-03-03', '2070-03-03', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (130, 398, 453, 268704, '2029-07-16', '2030-08-13', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (131, 495, 211, 331745, '2050-08-09', '2052-02-21', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (132, 386, 13, 355937, '2016-02-18', '2017-06-07', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (133, 256, 234, 425090, '2019-04-28', '2022-05-16', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (134, 38, 408, 59494, '2038-07-09', '2040-12-25', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (135, 208, 224, 189929, '2021-11-02', '2023-08-17', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (136, 104, 85, 299793, '2019-09-27', '2021-09-15', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (137, 305, 169, 483133, '2036-12-17', '2038-11-12', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (138, 248, 264, 144574, '2044-09-06', '2046-10-04', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (139, 480, 46, 31645, '2063-01-21', '2066-01-16', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (140, 46, 292, 459481, '2009-01-28', '2011-05-04', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (141, 9, 371, 328787, '2068-08-07', '2070-02-22', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (142, 138, 161, 58725, '2075-12-16', '2077-06-12', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (143, 412, 424, 182165, '2063-11-10', '2065-08-05', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (144, 396, 256, 464157, '2022-07-27', '2025-08-27', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (145, 459, 17, 386371, '2003-09-01', '2005-03-11', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (146, 172, 407, 422130, '2082-07-21', '2083-10-15', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (147, 45, 322, 249469, '2036-04-24', '2039-01-23', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (148, 74, 321, 281241, '2038-12-01', '2041-01-14', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (149, 366, 15, 95280, '2076-07-03', '2078-12-17', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (150, 404, 211, 136788, '2078-07-13', '2079-01-17', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (151, 295, 396, 380840, '2065-01-25', '2068-03-25', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (152, 140, 497, 51047, '2005-09-09', '2007-06-21', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (153, 285, 186, 359979, '2013-08-10', '2014-04-01', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (154, 323, 115, 57268, '2059-05-08', '2062-10-21', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (155, 354, 247, 214681, '2030-07-18', '2033-04-21', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (156, 278, 430, 205980, '2011-08-03', '2014-08-20', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (157, 279, 476, 76341, '2006-09-05', '2009-03-20', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (158, 469, 123, 426395, '2090-11-07', '2093-12-19', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (159, 219, 58, 90675, '2090-11-20', '2093-11-26', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (160, 103, 309, 19195, '2087-10-22', '2089-09-04', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (161, 7, 91, 156192, '2046-11-16', '2047-11-27', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (162, 483, 251, 234178, '2085-12-28', '2088-03-28', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (163, 101, 20, 378489, '2035-02-28', '2038-08-14', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (164, 338, 49, 83156, '2018-07-19', '2020-04-16', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (165, 183, 218, 270222, '2054-01-27', '2057-12-06', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (166, 72, 405, 229269, '2028-12-01', '2029-05-18', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (167, 446, 35, 433471, '2003-05-03', '2004-03-12', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (168, 494, 176, 302576, '2076-04-11', '2079-05-27', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (169, 359, 140, 386402, '2021-02-14', '2022-12-05', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (170, 259, 169, 442882, '2071-03-07', '2073-06-03', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (171, 137, 55, 463550, '2033-11-06', '2035-04-22', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (172, 249, 173, 404165, '2077-10-28', '2080-10-05', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (173, 255, 398, 44011, '2014-01-24', '2017-07-10', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (174, 325, 464, 371740, '2080-08-01', '2082-08-25', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (175, 1, 194, 331486, '2074-02-04', '2075-05-03', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (176, 254, 487, 156906, '2085-04-26', '2088-09-21', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (177, 286, 62, 163941, '2011-01-18', '2014-02-23', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (178, 410, 314, 180899, '2048-01-23', '2050-09-19', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (179, 111, 61, 44670, '2034-11-27', '2036-01-21', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (180, 204, 58, 495808, '2014-10-18', '2015-07-05', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (181, 477, 265, 358003, '2048-09-24', '2051-12-03', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (182, 86, 392, 383642, '2045-06-04', '2047-04-11', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (183, 200, 24, 9956, '2011-06-24', '2012-03-14', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (184, 109, 227, 427798, '2060-12-02', '2061-06-12', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (185, 139, 418, 374926, '2061-10-27', '2062-06-10', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (186, 121, 188, 226052, '2074-10-17', '2077-04-24', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (187, 297, 76, 294937, '2010-09-27', '2013-05-10', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (188, 176, 261, 182420, '2077-03-11', '2079-09-12', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (189, 57, 180, 259102, '2065-03-26', '2066-12-09', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (190, 367, 284, 190289, '2030-02-17', '2031-03-17', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (191, 36, 476, 260923, '2006-06-13', '2008-04-15', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (192, 163, 189, 368575, '2029-11-07', '2031-07-09', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (193, 5, 474, 79201, '2026-03-24', '2029-11-23', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (194, 297, 11, 217916, '2085-02-06', '2088-01-01', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (195, 106, 295, 276731, '2035-02-06', '2038-08-03', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (196, 396, 38, 160471, '2004-10-01', '2006-04-22', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (197, 351, 112, 348820, '2011-12-01', '2012-04-23', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (198, 480, 436, 411212, '2030-04-02', '2033-11-01', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (199, 285, 181, 223289, '2051-07-21', '2053-07-16', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (200, 299, 413, 371266, '2080-01-07', '2081-08-27', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (201, 229, 459, 118816, '1999-11-12', '2000-08-08', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (202, 195, 350, 73315, '2084-04-23', '2087-06-19', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (203, 108, 336, 30891, '2008-02-23', '2011-07-07', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (204, 216, 450, 39981, '2003-11-08', '2004-01-22', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (205, 128, 351, 53602, '2000-11-03', '2001-11-23', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (206, 63, 76, 72130, '1999-10-28', '2001-11-09', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (207, 291, 283, 475229, '2036-02-13', '2038-06-18', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (208, 244, 320, 265516, '2049-12-10', '2050-05-14', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (209, 499, 404, 473184, '2086-11-21', '2088-10-06', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (210, 483, 266, 91310, '2077-04-19', '2078-06-08', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (211, 52, 31, 9218, '2037-05-10', '2038-11-01', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (212, 256, 455, 104341, '2024-05-04', '2026-02-19', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (213, 62, 376, 103797, '2025-07-19', '2028-11-08', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (214, 192, 454, 304531, '2087-05-05', '2090-04-12', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (215, 266, 159, 139467, '2059-12-26', '2062-10-23', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (216, 50, 235, 346000, '2053-05-08', '2054-09-18', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (217, 112, 129, 163712, '2081-05-26', '2084-09-23', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (218, 178, 37, 303290, '2022-04-27', '2023-05-08', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (219, 317, 371, 115650, '2002-03-19', '2004-05-26', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (220, 185, 45, 301323, '2075-12-05', '2078-09-20', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (221, 93, 156, 460642, '2078-09-06', '2080-12-11', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (222, 147, 296, 430477, '2000-02-22', '2001-12-19', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (223, 132, 439, 94067, '2054-01-01', '2057-03-02', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (224, 108, 178, 433222, '2029-10-14', '2030-12-17', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (225, 264, 72, 403890, '2011-06-23', '2014-12-04', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (226, 416, 367, 436320, '2026-12-11', '2028-06-09', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (227, 387, 217, 484629, '2047-08-27', '2048-01-25', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (228, 461, 226, 324578, '2081-02-01', '2084-08-13', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (229, 269, 405, 433032, '2079-11-25', '2081-06-19', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (230, 325, 58, 436987, '2030-02-11', '2032-08-09', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (231, 233, 174, 281464, '2069-09-08', '2070-08-15', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (232, 131, 86, 312399, '2056-01-21', '2058-03-12', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (233, 22, 103, 168652, '2077-12-10', '2079-11-28', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (234, 368, 351, 466960, '2042-06-09', '2044-12-16', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (235, 499, 472, 489953, '2080-05-07', '2083-07-12', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (236, 419, 339, 417772, '2087-08-12', '2089-10-26', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (237, 396, 207, 218110, '2042-06-27', '2045-11-05', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (238, 229, 424, 80136, '2029-10-23', '2030-05-09', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (239, 397, 418, 148756, '2056-08-02', '2059-09-28', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (240, 263, 391, 322488, '2057-03-18', '2059-07-07', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (241, 352, 279, 108701, '2007-03-15', '2009-11-02', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (242, 404, 249, 8049, '2022-08-24', '2023-12-17', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (243, 216, 433, 22165, '2028-03-27', '2031-06-04', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (244, 326, 478, 404836, '2012-08-20', '2015-08-08', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (245, 469, 452, 452445, '2042-01-01', '2044-09-11', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (246, 305, 146, 24325, '2010-06-18', '2013-01-04', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (247, 455, 82, 232671, '2041-04-13', '2042-07-08', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (248, 59, 57, 170400, '2047-06-26', '2049-07-26', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (249, 260, 246, 168347, '2004-06-06', '2007-12-02', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (250, 301, 464, 327801, '2042-03-24', '2045-04-04', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (251, 371, 266, 423763, '2064-10-14', '2065-10-04', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (252, 150, 187, 70511, '2037-04-14', '2039-04-08', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (253, 369, 133, 130050, '2006-06-12', '2007-03-06', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (254, 120, 201, 159546, '2037-07-15', '2038-10-13', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (255, 199, 30, 47152, '2060-10-03', '2062-01-08', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (256, 322, 201, 58161, '2004-08-01', '2006-02-17', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (257, 480, 154, 27639, '2001-08-22', '2004-05-07', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (258, 215, 213, 281782, '2037-04-14', '2039-09-22', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (259, 345, 359, 79589, '2027-04-19', '2030-05-16', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (260, 465, 128, 470917, '2042-02-26', '2043-05-18', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (261, 382, 328, 481011, '2071-04-04', '2072-10-08', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (262, 273, 35, 152312, '2027-03-07', '2029-02-22', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (263, 316, 443, 225630, '2016-05-26', '2019-08-09', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (264, 457, 12, 11354, '2053-05-03', '2056-04-03', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (265, 140, 59, 238922, '2078-02-04', '2080-11-11', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (266, 266, 443, 382780, '2042-12-22', '2045-05-08', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (267, 115, 261, 164347, '2000-10-07', '2001-01-21', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (268, 34, 180, 67311, '1999-08-12', '2002-10-19', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (269, 257, 55, 225818, '2083-05-13', '2086-10-27', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (270, 478, 23, 199976, '2039-07-19', '2040-12-08', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (271, 146, 90, 61239, '2081-01-28', '2083-01-04', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (272, 346, 279, 97446, '2054-11-13', '2055-02-16', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (273, 28, 130, 97774, '2060-09-15', '2061-10-15', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (274, 55, 97, 476511, '2046-12-08', '2048-05-27', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (275, 430, 437, 103730, '2069-07-08', '2071-05-09', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (276, 458, 490, 98767, '2065-02-22', '2066-05-09', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (277, 14, 275, 154753, '1999-12-20', '2001-02-20', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (278, 31, 146, 273353, '2006-02-16', '2008-06-07', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (279, 33, 90, 73282, '2053-06-26', '2056-10-10', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (280, 80, 379, 320722, '2029-12-06', '2030-01-04', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (281, 362, 485, 86475, '2056-04-28', '2059-10-03', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (282, 98, 79, 230188, '2004-12-11', '2007-07-10', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (283, 98, 136, 70169, '2015-07-16', '2018-08-27', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (284, 147, 202, 208012, '2058-12-09', '2060-01-11', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (285, 360, 95, 244643, '2029-02-22', '2030-07-24', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (286, 51, 499, 190586, '2058-10-24', '2060-06-18', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (287, 408, 343, 377564, '2081-04-07', '2083-11-20', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (288, 176, 14, 232589, '2060-07-05', '2063-10-13', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (289, 243, 5, 294289, '2000-03-24', '2003-01-16', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (290, 471, 399, 284635, '2028-06-21', '2029-11-12', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (291, 54, 257, 322641, '2036-11-12', '2039-12-19', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (292, 332, 364, 308983, '2088-10-20', '2091-09-05', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (293, 23, 169, 438915, '2040-08-01', '2043-12-16', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (294, 187, 205, 63017, '2016-06-04', '2019-05-02', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (295, 33, 178, 228570, '2027-07-13', '2028-12-19', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (296, 235, 392, 109978, '2074-07-02', '2075-02-12', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (297, 99, 484, 482999, '2027-04-03', '2030-11-10', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (298, 285, 389, 434391, '2032-07-09', '2034-08-27', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (299, 194, 439, 399969, '2005-07-16', '2007-05-07', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (300, 105, 152, 327907, '2049-03-27', '2050-05-15', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (301, 78, 184, 165171, '2082-09-25', '2085-07-16', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (302, 366, 31, 32778, '2025-12-16', '2027-12-17', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (303, 45, 79, 407972, '2035-06-08', '2037-05-05', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (304, 319, 172, 293954, '2075-03-28', '2077-02-20', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (305, 420, 442, 490628, '2034-08-02', '2037-08-10', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (306, 32, 490, 172455, '2043-01-17', '2045-12-28', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (307, 34, 359, 240762, '2029-09-09', '2031-10-18', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (308, 437, 226, 437200, '2022-04-13', '2025-12-21', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (309, 485, 301, 228322, '2015-12-01', '2017-04-10', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (310, 150, 491, 274355, '2070-05-19', '2072-01-17', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (311, 57, 129, 418984, '2012-09-10', '2013-08-10', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (312, 189, 156, 224476, '2059-02-18', '2061-04-25', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (313, 204, 128, 289688, '2001-12-02', '2004-09-24', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (314, 297, 142, 316192, '2079-09-27', '2082-05-23', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (315, 62, 289, 452511, '2048-02-05', '2049-06-04', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (316, 9, 477, 402574, '2064-03-20', '2066-03-03', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (317, 191, 269, 219299, '2072-04-12', '2073-04-04', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (318, 311, 191, 221560, '2081-04-27', '2083-02-27', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (319, 266, 478, 364414, '2053-09-25', '2056-08-27', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (320, 126, 492, 496802, '2080-10-13', '2081-05-03', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (321, 353, 232, 390929, '2068-07-03', '2071-09-04', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (322, 143, 120, 492430, '2003-10-19', '2004-11-06', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (323, 156, 99, 276035, '2002-04-22', '2003-06-16', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (324, 228, 263, 484164, '2068-07-20', '2071-06-02', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (325, 392, 406, 102830, '2074-02-04', '2076-01-09', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (326, 49, 455, 390684, '2049-12-27', '2050-04-11', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (327, 300, 37, 166744, '2056-08-25', '2059-12-06', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (328, 251, 236, 339003, '2005-06-15', '2007-05-21', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (329, 410, 484, 186819, '2068-11-02', '2070-09-07', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (330, 415, 132, 219251, '2013-08-26', '2014-01-28', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (331, 228, 471, 201977, '2029-01-02', '2031-11-24', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (332, 373, 206, 35083, '2070-03-21', '2072-07-03', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (333, 55, 167, 286619, '1999-01-24', '2000-04-16', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (334, 23, 104, 33030, '2082-08-05', '2085-02-14', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (335, 217, 260, 251093, '2047-03-02', '2048-03-28', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (336, 186, 402, 402135, '2081-06-15', '2084-06-24', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (337, 108, 499, 150819, '2051-12-16', '2053-12-18', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (338, 272, 148, 499401, '2018-10-03', '2020-06-23', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (339, 305, 324, 172416, '2079-01-03', '2080-08-10', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (340, 19, 212, 444203, '2067-03-18', '2069-02-12', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (341, 153, 66, 256117, '2043-09-16', '2046-09-15', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (342, 286, 267, 203080, '2080-06-13', '2081-01-11', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (343, 136, 402, 244822, '2052-07-23', '2053-10-02', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (344, 200, 238, 395996, '2072-01-25', '2075-04-02', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (345, 174, 99, 135633, '2065-12-12', '2068-06-09', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (346, 11, 107, 360675, '2063-06-07', '2066-12-06', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (347, 127, 149, 454554, '2024-10-27', '2027-02-05', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (348, 390, 54, 333144, '2045-02-06', '2047-11-17', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (349, 473, 302, 433047, '2075-07-05', '2076-07-08', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (350, 462, 343, 347858, '2046-06-07', '2049-11-11', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (351, 99, 213, 55124, '2086-07-20', '2088-11-17', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (352, 474, 21, 207559, '2042-04-11', '2045-01-10', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (353, 131, 165, 101261, '2057-07-26', '2059-05-06', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (354, 55, 211, 239905, '2060-10-16', '2063-05-28', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (355, 425, 497, 108199, '2054-03-17', '2057-12-13', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (356, 88, 282, 304057, '2068-01-07', '2070-04-12', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (357, 310, 426, 189354, '2063-02-16', '2064-09-17', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (358, 428, 235, 200524, '2037-01-01', '2038-12-19', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (359, 274, 284, 454335, '2081-08-19', '2084-12-04', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (360, 186, 338, 377672, '2039-04-21', '2042-07-18', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (361, 146, 286, 216019, '2002-04-24', '2005-11-02', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (362, 349, 108, 494213, '2053-11-15', '2054-01-14', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (363, 271, 472, 43750, '2020-11-15', '2022-01-03', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (364, 440, 284, 70147, '2016-04-02', '2018-09-26', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (365, 367, 365, 265875, '2001-04-27', '2003-03-22', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (366, 376, 27, 265449, '2085-08-28', '2086-06-02', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (367, 400, 494, 362682, '2021-09-23', '2024-10-20', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (368, 84, 85, 270899, '2032-05-07', '2035-09-17', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (369, 233, 19, 309808, '2065-05-11', '2068-04-14', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (370, 119, 183, 237145, '2056-10-21', '2059-01-17', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (371, 347, 267, 465217, '2026-09-18', '2029-03-24', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (372, 156, 210, 413847, '2036-09-11', '2037-10-26', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (373, 196, 319, 405782, '2058-07-10', '2061-10-08', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (374, 56, 480, 339660, '2001-10-17', '2003-11-21', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (375, 349, 283, 380822, '2060-08-26', '2063-04-05', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (376, 210, 67, 25903, '2013-06-13', '2016-08-07', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (377, 334, 412, 97792, '2084-06-28', '2086-10-22', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (378, 313, 31, 230641, '2072-08-10', '2074-10-03', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (379, 144, 377, 310235, '2067-06-27', '2070-02-26', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (380, 97, 290, 421858, '2063-07-27', '2066-10-03', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (381, 343, 184, 492982, '2090-12-22', '2091-11-07', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (382, 71, 217, 279808, '2051-02-08', '2053-09-23', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (383, 354, 195, 6678, '2085-08-18', '2086-11-08', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (384, 313, 373, 383394, '2016-03-20', '2019-05-11', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (385, 130, 222, 67381, '2059-12-02', '2061-05-06', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (386, 250, 395, 147745, '2021-05-12', '2024-01-24', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (387, 362, 467, 365396, '2034-01-03', '2035-09-18', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (388, 78, 152, 88222, '2062-11-22', '2063-07-11', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (389, 198, 227, 426263, '2013-01-21', '2014-12-24', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (390, 405, 338, 285660, '2005-04-21', '2006-12-10', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (391, 35, 275, 230909, '2036-06-27', '2038-06-12', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (392, 197, 193, 276941, '2043-11-17', '2046-12-04', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (393, 239, 431, 369366, '2014-06-27', '2015-11-14', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (394, 231, 276, 422348, '2079-07-24', '2082-03-08', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (395, 350, 276, 181867, '2002-06-28', '2005-05-25', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (396, 169, 193, 306498, '2084-11-24', '2086-06-22', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (397, 469, 462, 443469, '2080-05-07', '2083-01-17', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (398, 437, 383, 167755, '2037-02-09', '2039-12-13', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (399, 98, 299, 419151, '2006-10-16', '2007-09-10', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (400, 343, 497, 131811, '2086-10-09', '2088-10-26', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (401, 3, 313, 270292, '2064-10-27', '2067-07-20', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (402, 179, 431, 183053, '2040-08-10', '2042-03-12', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (403, 328, 127, 438844, '2076-04-04', '2077-10-15', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (404, 321, 317, 446644, '2062-09-09', '2064-03-08', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (405, 37, 410, 98419, '2008-09-04', '2010-02-13', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (406, 365, 131, 264055, '2031-09-17', '2032-12-12', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (407, 366, 144, 46651, '2030-09-16', '2033-03-27', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (408, 172, 173, 140592, '2022-08-17', '2024-09-23', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (409, 73, 423, 56837, '2027-02-05', '2029-07-21', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (410, 240, 479, 50842, '2041-04-08', '2043-02-20', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (411, 257, 279, 419013, '2041-04-02', '2044-04-27', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (412, 405, 320, 444335, '2046-11-01', '2048-08-07', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (413, 24, 71, 165812, '2033-03-11', '2034-01-17', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (414, 474, 296, 102844, '2089-06-06', '2092-12-06', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (415, 10, 262, 226020, '2090-06-24', '2092-02-16', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (416, 410, 136, 415205, '2077-12-19', '2079-04-12', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (417, 258, 198, 342584, '2077-11-08', '2078-09-15', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (418, 175, 29, 64270, '2037-04-10', '2040-04-26', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (419, 229, 388, 434876, '2083-02-06', '2085-02-27', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (420, 171, 232, 311189, '2086-07-27', '2089-02-24', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (421, 81, 311, 137860, '2041-07-19', '2043-08-28', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (422, 314, 169, 343740, '2079-02-22', '2080-03-02', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (423, 93, 500, 391445, '2035-05-05', '2036-05-21', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (424, 427, 470, 251156, '2068-09-22', '2069-01-17', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (425, 165, 285, 192533, '2086-03-02', '2089-12-03', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (426, 11, 214, 58688, '2067-01-05', '2069-11-14', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (427, 36, 171, 414401, '2044-07-05', '2047-06-18', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (428, 420, 178, 493009, '2036-08-09', '2037-02-02', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (429, 265, 264, 258456, '2041-06-03', '2044-02-24', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (430, 381, 100, 280191, '2063-10-26', '2064-09-27', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (431, 332, 216, 371435, '2061-09-10', '2064-05-03', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (432, 100, 59, 396495, '2033-07-26', '2034-11-05', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (433, 241, 237, 178528, '2019-10-12', '2021-07-10', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (434, 140, 239, 94657, '2082-11-26', '2084-11-08', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (435, 466, 112, 235277, '2001-12-18', '2003-08-25', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (436, 14, 286, 15417, '2019-02-20', '2020-11-03', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (437, 348, 171, 279211, '2046-08-05', '2049-03-13', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (438, 375, 62, 356825, '2007-01-10', '2009-02-26', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (439, 181, 383, 107698, '2002-03-22', '2005-12-16', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (440, 437, 306, 245328, '2002-03-27', '2005-06-27', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (441, 260, 404, 363548, '2056-04-21', '2059-02-15', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (442, 378, 252, 111286, '2068-07-21', '2071-08-25', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (443, 254, 487, 155028, '2009-07-26', '2011-10-18', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (444, 311, 75, 308748, '2069-02-18', '2072-06-25', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (445, 187, 301, 439339, '2045-01-20', '2047-11-02', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (446, 321, 335, 284736, '2061-07-23', '2064-08-13', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (447, 56, 67, 227428, '2009-08-26', '2012-07-03', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (448, 146, 375, 278210, '2041-02-07', '2043-07-27', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (449, 278, 196, 221487, '2082-11-12', '2083-02-13', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (450, 30, 411, 267535, '2035-10-16', '2036-07-12', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (451, 122, 40, 138884, '2074-06-11', '2077-02-01', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (452, 83, 468, 64045, '2003-08-13', '2004-09-09', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (453, 147, 389, 47461, '2074-12-21', '2075-04-07', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (454, 60, 8, 43354, '2043-07-18', '2046-02-23', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (455, 180, 128, 196802, '2027-05-28', '2029-02-10', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (456, 399, 121, 295151, '2061-02-18', '2063-03-28', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (457, 367, 267, 412512, '2040-06-18', '2042-01-28', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (458, 25, 266, 158718, '2008-04-15', '2011-10-11', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (459, 216, 261, 260962, '2046-10-07', '2048-01-02', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (460, 264, 407, 238828, '2005-06-19', '2008-11-01', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (461, 332, 178, 78973, '2056-06-10', '2059-04-01', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (462, 44, 145, 422594, '2038-08-14', '2039-03-21', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (463, 370, 60, 152800, '2054-06-09', '2057-04-09', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (464, 156, 261, 5108, '2059-06-14', '2062-08-21', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (465, 46, 234, 343707, '2022-12-15', '2024-11-12', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (466, 21, 60, 64442, '2014-07-21', '2017-07-02', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (467, 244, 333, 128896, '2063-07-16', '2066-07-09', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (468, 473, 108, 392274, '2014-03-27', '2017-08-18', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (469, 490, 364, 336034, '2073-07-16', '2075-01-04', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (470, 339, 33, 280420, '2087-03-24', '2090-01-27', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (471, 71, 112, 494476, '2035-11-24', '2036-12-15', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (472, 420, 158, 77989, '2005-10-18', '2007-08-06', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (473, 441, 138, 365285, '2031-06-02', '2034-10-28', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (474, 443, 449, 365576, '2074-07-15', '2076-10-27', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (475, 366, 209, 92517, '2035-02-02', '2036-06-05', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (476, 284, 92, 80280, '2038-10-10', '2041-04-07', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (477, 127, 220, 166956, '2015-04-10', '2017-10-21', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (478, 75, 441, 351432, '2087-05-10', '2089-03-04', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (479, 167, 404, 489628, '2073-06-13', '2075-05-08', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (480, 182, 214, 395099, '2011-01-28', '2014-08-26', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (481, 262, 13, 107339, '2020-05-01', '2021-12-25', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (482, 386, 431, 226048, '2086-02-20', '2087-04-03', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (483, 387, 434, 428828, '2003-09-24', '2004-09-07', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (484, 487, 62, 217163, '2007-04-20', '2010-09-07', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (485, 46, 447, 70005, '2078-07-09', '2080-12-01', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (486, 26, 58, 221073, '2003-05-24', '2005-02-09', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (487, 197, 361, 336597, '2026-04-27', '2027-07-26', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (488, 175, 376, 491088, '2025-06-05', '2026-10-21', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (489, 255, 63, 54595, '2033-07-06', '2034-06-25', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (490, 458, 121, 310072, '2044-11-17', '2047-10-28', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (491, 118, 140, 186172, '2015-02-25', '2017-11-03', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (492, 392, 302, 9266, '1999-08-08', '2001-01-23', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (493, 312, 419, 157644, '2017-09-14', '2018-11-19', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (494, 180, 46, 446452, '2074-04-03', '2077-06-15', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (495, 298, 85, 461082, '2030-09-21', '2033-05-05', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (496, 163, 148, 256431, '2069-02-18', '2072-04-06', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (497, 201, 315, 312938, '1999-07-07', '2001-11-19', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (498, 154, 177, 303416, '2086-10-17', '2088-12-02', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (499, 32, 140, 75755, '2025-08-13', '2028-06-05', 'приостановлен');
INSERT INTO public.task_steps (id_contract, id_project, id_schedule, step_price, step_start_date, step_deadline, step_status) OVERRIDING SYSTEM VALUE VALUES (500, 458, 346, 478372, '2021-04-07', '2024-12-20', 'приостановлен');


--
-- TOC entry 3683 (class 0 OID 0)
-- Dependencies: 218
-- Name: client_id_client_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_id_client_seq', 600, true);


--
-- TOC entry 3684 (class 0 OID 0)
-- Dependencies: 220
-- Name: department_id_department_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.department_id_department_seq', 500, true);


--
-- TOC entry 3685 (class 0 OID 0)
-- Dependencies: 219
-- Name: employee_id_employee_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employee_id_employee_seq', 500, true);


--
-- TOC entry 3686 (class 0 OID 0)
-- Dependencies: 225
-- Name: execution_control_id_execution_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.execution_control_id_execution_seq', 500, true);


--
-- TOC entry 3687 (class 0 OID 0)
-- Dependencies: 221
-- Name: job_title_id_job_title_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.job_title_id_job_title_seq', 500, true);


--
-- TOC entry 3688 (class 0 OID 0)
-- Dependencies: 223
-- Name: project_id_project_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.project_id_project_seq', 502, true);


--
-- TOC entry 3689 (class 0 OID 0)
-- Dependencies: 222
-- Name: schedule_id_schedule_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schedule_id_schedule_seq', 500, true);


--
-- TOC entry 3690 (class 0 OID 0)
-- Dependencies: 224
-- Name: task_id_task_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_id_task_seq', 500, true);


--
-- TOC entry 3691 (class 0 OID 0)
-- Dependencies: 226
-- Name: task_steps_id_contract_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_steps_id_contract_seq', 500, true);


--
-- TOC entry 3488 (class 2606 OID 16404)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id_client);


--
-- TOC entry 3486 (class 2606 OID 16654)
-- Name: execution_control control_date; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.execution_control
    ADD CONSTRAINT control_date CHECK ((control_date > '1980-01-01'::date)) NOT VALID;


--
-- TOC entry 3492 (class 2606 OID 16429)
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (id_department);


--
-- TOC entry 3494 (class 2606 OID 16439)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (id_employee);


--
-- TOC entry 3504 (class 2606 OID 16571)
-- Name: execution_control execution_control_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.execution_control
    ADD CONSTRAINT execution_control_pkey PRIMARY KEY (id_execution);


--
-- TOC entry 3473 (class 2606 OID 16889)
-- Name: project id_manager_chk; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.project
    ADD CONSTRAINT id_manager_chk CHECK ((id_supervisor <> id_manager)) NOT VALID;


--
-- TOC entry 3498 (class 2606 OID 16554)
-- Name: project id_project; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT id_project PRIMARY KEY (id_project);


--
-- TOC entry 3490 (class 2606 OID 16424)
-- Name: job_title job_title_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_title
    ADD CONSTRAINT job_title_pkey PRIMARY KEY (id_job_title);


--
-- TOC entry 3474 (class 2606 OID 16656)
-- Name: project payment_state; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.project
    ADD CONSTRAINT payment_state CHECK (((payment_state)::text = ANY ((ARRAY['не оплачен'::character varying, 'внесена предоплата'::character varying, 'полностью оплачен'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 3475 (class 2606 OID 16642)
-- Name: project project_deadlines_chk; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.project
    ADD CONSTRAINT project_deadlines_chk CHECK ((project_deadlines > '1980-01-01'::date)) NOT VALID;


--
-- TOC entry 3476 (class 2606 OID 16655)
-- Name: project project_status; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.project
    ADD CONSTRAINT project_status CHECK (((project_status)::text = ANY ((ARRAY['выполнен'::character varying, 'в процессе'::character varying, 'не начат'::character varying, 'приостановлен'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 3470 (class 2606 OID 16652)
-- Name: job_title salary; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.job_title
    ADD CONSTRAINT salary CHECK ((salary >= 0)) NOT VALID;


--
-- TOC entry 3471 (class 2606 OID 16653)
-- Name: employee salary; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.employee
    ADD CONSTRAINT salary CHECK ((salary >= 0)) NOT VALID;


--
-- TOC entry 3496 (class 2606 OID 16454)
-- Name: schedule schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (id_schedule);


--
-- TOC entry 3477 (class 2606 OID 16640)
-- Name: project signing_act_date_chk; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.project
    ADD CONSTRAINT signing_act_date_chk CHECK ((signing_act_date > signing_contract_date)) NOT VALID;


--
-- TOC entry 3478 (class 2606 OID 16641)
-- Name: project signing_contract_date_chk; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.project
    ADD CONSTRAINT signing_contract_date_chk CHECK ((signing_contract_date > '1980-01-01'::date)) NOT VALID;


--
-- TOC entry 3482 (class 2606 OID 16649)
-- Name: task_steps step_deadline; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.task_steps
    ADD CONSTRAINT step_deadline CHECK ((step_deadline > step_start_date)) NOT VALID;


--
-- TOC entry 3483 (class 2606 OID 16650)
-- Name: task_steps step_price; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.task_steps
    ADD CONSTRAINT step_price CHECK ((step_price > 0)) NOT VALID;


--
-- TOC entry 3484 (class 2606 OID 16648)
-- Name: task_steps step_start_date; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.task_steps
    ADD CONSTRAINT step_start_date CHECK ((step_start_date > '1980-01-01'::date)) NOT VALID;


--
-- TOC entry 3485 (class 2606 OID 16657)
-- Name: task_steps step_status; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.task_steps
    ADD CONSTRAINT step_status CHECK (((step_status)::text = ANY ((ARRAY['выполнен'::character varying, 'в процессе'::character varying, 'не начат'::character varying, 'приостановлен'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 3479 (class 2606 OID 16646)
-- Name: task task_deadline; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.task
    ADD CONSTRAINT task_deadline CHECK ((task_deadline > '1980-01-01'::date)) NOT VALID;


--
-- TOC entry 3500 (class 2606 OID 16552)
-- Name: task task_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT task_pkey PRIMARY KEY (id_task);


--
-- TOC entry 3480 (class 2606 OID 16645)
-- Name: task task_price; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.task
    ADD CONSTRAINT task_price CHECK ((task_price > 0)) NOT VALID;


--
-- TOC entry 3481 (class 2606 OID 16647)
-- Name: task task_start_date; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.task
    ADD CONSTRAINT task_start_date CHECK ((task_start_date > '1980-01-01'::date)) NOT VALID;


--
-- TOC entry 3502 (class 2606 OID 16564)
-- Name: task_steps task_steps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_steps
    ADD CONSTRAINT task_steps_pkey PRIMARY KEY (id_contract);


--
-- TOC entry 3472 (class 2606 OID 16658)
-- Name: schedule wage_rate; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.schedule
    ADD CONSTRAINT wage_rate CHECK (((wage_rate)::text = ANY ((ARRAY['полная ставка'::character varying, 'полставки'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 3512 (class 2606 OID 16689)
-- Name: project id_client; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT id_client FOREIGN KEY (id_client) REFERENCES public.client(id_client) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3506 (class 2606 OID 16659)
-- Name: employee id_department; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT id_department FOREIGN KEY (id_department) REFERENCES public.department(id_department) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3505 (class 2606 OID 16684)
-- Name: job_title id_department; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_title
    ADD CONSTRAINT id_department FOREIGN KEY (id_department) REFERENCES public.department(id_department) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3509 (class 2606 OID 16704)
-- Name: schedule id_department; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT id_department FOREIGN KEY (id_department) REFERENCES public.department(id_department) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3510 (class 2606 OID 16709)
-- Name: schedule id_employee; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT id_employee FOREIGN KEY (id_employee) REFERENCES public.employee(id_employee) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3508 (class 2606 OID 16669)
-- Name: employee id_job_title; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT id_job_title FOREIGN KEY (id_job_title) REFERENCES public.job_title(id_job_title) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3511 (class 2606 OID 16714)
-- Name: schedule id_job_title; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT id_job_title FOREIGN KEY (id_job_title) REFERENCES public.job_title(id_job_title) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3513 (class 2606 OID 16694)
-- Name: project id_manager; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT id_manager FOREIGN KEY (id_manager) REFERENCES public.employee(id_employee) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3515 (class 2606 OID 16719)
-- Name: task id_project; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT id_project FOREIGN KEY (id_project) REFERENCES public.project(id_project) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3516 (class 2606 OID 16724)
-- Name: task_steps id_project; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_steps
    ADD CONSTRAINT id_project FOREIGN KEY (id_project) REFERENCES public.project(id_project) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3507 (class 2606 OID 16664)
-- Name: employee id_schedule; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT id_schedule FOREIGN KEY (id_schedule) REFERENCES public.schedule(id_schedule) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3518 (class 2606 OID 16674)
-- Name: execution_control id_schedule; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.execution_control
    ADD CONSTRAINT id_schedule FOREIGN KEY (id_schedule) REFERENCES public.schedule(id_schedule) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3517 (class 2606 OID 16729)
-- Name: task_steps id_schedule; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_steps
    ADD CONSTRAINT id_schedule FOREIGN KEY (id_schedule) REFERENCES public.schedule(id_schedule) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3519 (class 2606 OID 16679)
-- Name: execution_control id_supervisor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.execution_control
    ADD CONSTRAINT id_supervisor FOREIGN KEY (id_supervisor) REFERENCES public.employee(id_employee) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3514 (class 2606 OID 16699)
-- Name: project id_supervisor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT id_supervisor FOREIGN KEY (id_supervisor) REFERENCES public.employee(id_employee) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


-- Completed on 2023-03-18 23:14:08 MSK

--
-- PostgreSQL database dump complete
--

