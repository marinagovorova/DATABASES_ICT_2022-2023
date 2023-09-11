--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-05-03 16:11:29 MSK

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
-- TOC entry 6 (class 2615 OID 17880)
-- Name: lab_1; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA lab_1;


ALTER SCHEMA lab_1 OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 17881)
-- Name: conveniences; Type: TABLE; Schema: lab_1; Owner: postgres
--

CREATE TABLE lab_1.conveniences (
    id_conveniences bigint NOT NULL,
    category character varying(40) NOT NULL,
    name character varying(40) NOT NULL
);


ALTER TABLE lab_1.conveniences OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 17884)
-- Name: conveniences_id_conveniences_seq; Type: SEQUENCE; Schema: lab_1; Owner: postgres
--

ALTER TABLE lab_1.conveniences ALTER COLUMN id_conveniences ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME lab_1.conveniences_id_conveniences_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 217 (class 1259 OID 17885)
-- Name: employee; Type: TABLE; Schema: lab_1; Owner: postgres
--

CREATE TABLE lab_1.employee (
    id_employee bigint NOT NULL,
    full_name character varying(60) NOT NULL,
    post character varying(20) NOT NULL,
    category character varying(20) NOT NULL,
    salary integer NOT NULL,
    number_of_passport character varying(11) NOT NULL,
    CONSTRAINT employee_salary_check CHECK ((salary > 0))
);


ALTER TABLE lab_1.employee OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 17889)
-- Name: employee_id_employee_seq; Type: SEQUENCE; Schema: lab_1; Owner: postgres
--

ALTER TABLE lab_1.employee ALTER COLUMN id_employee ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME lab_1.employee_id_employee_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 219 (class 1259 OID 17890)
-- Name: hotel; Type: TABLE; Schema: lab_1; Owner: postgres
--

CREATE TABLE lab_1.hotel (
    id_hotel bigint NOT NULL,
    name character varying(20) NOT NULL,
    adress character varying(60) NOT NULL,
    promotion_id bigint NOT NULL,
    hotel_room_id bigint NOT NULL,
    employee_id bigint NOT NULL
);


ALTER TABLE lab_1.hotel OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17893)
-- Name: hotel_id_hotel_seq; Type: SEQUENCE; Schema: lab_1; Owner: postgres
--

ALTER TABLE lab_1.hotel ALTER COLUMN id_hotel ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME lab_1.hotel_id_hotel_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 221 (class 1259 OID 17894)
-- Name: hotel_room; Type: TABLE; Schema: lab_1; Owner: postgres
--

CREATE TABLE lab_1.hotel_room (
    id_hotel_room bigint NOT NULL,
    type_id bigint NOT NULL,
    cleaning_status boolean NOT NULL,
    employment_status boolean NOT NULL
);


ALTER TABLE lab_1.hotel_room OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17897)
-- Name: hotel_room_id_hotel_room_seq; Type: SEQUENCE; Schema: lab_1; Owner: postgres
--

ALTER TABLE lab_1.hotel_room ALTER COLUMN id_hotel_room ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME lab_1.hotel_room_id_hotel_room_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 223 (class 1259 OID 17898)
-- Name: promotion; Type: TABLE; Schema: lab_1; Owner: postgres
--

CREATE TABLE lab_1.promotion (
    id_promotion bigint NOT NULL,
    holiday character varying(20),
    benefit character varying(20) NOT NULL,
    season character varying(6)
);


ALTER TABLE lab_1.promotion OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17901)
-- Name: promotion_id_promotion_seq; Type: SEQUENCE; Schema: lab_1; Owner: postgres
--

ALTER TABLE lab_1.promotion ALTER COLUMN id_promotion ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME lab_1.promotion_id_promotion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 225 (class 1259 OID 17902)
-- Name: registration; Type: TABLE; Schema: lab_1; Owner: postgres
--

CREATE TABLE lab_1.registration (
    date_of_registration timestamp without time zone NOT NULL,
    date_of_departure timestamp without time zone NOT NULL,
    hotel_room_id bigint NOT NULL,
    employee_id bigint NOT NULL,
    visitor_id bigint NOT NULL,
    reservation_status boolean NOT NULL,
    lateness_status boolean NOT NULL,
    CONSTRAINT registration_check CHECK ((date_of_registration < date_of_departure))
);


ALTER TABLE lab_1.registration OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17906)
-- Name: shift; Type: TABLE; Schema: lab_1; Owner: postgres
--

CREATE TABLE lab_1.shift (
    id_shift bigint NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL,
    break_length character varying(1) NOT NULL,
    CONSTRAINT shift_check CHECK ((start_time < end_time))
);


ALTER TABLE lab_1.shift OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17910)
-- Name: shift_id_shift_seq; Type: SEQUENCE; Schema: lab_1; Owner: postgres
--

ALTER TABLE lab_1.shift ALTER COLUMN id_shift ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME lab_1.shift_id_shift_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 17911)
-- Name: type; Type: TABLE; Schema: lab_1; Owner: postgres
--

CREATE TABLE lab_1.type (
    id_type bigint NOT NULL,
    price integer NOT NULL,
    number_of_seats integer NOT NULL,
    conveniences_id bigint,
    title character varying(10) NOT NULL,
    CONSTRAINT type_number_of_seats_check CHECK (((number_of_seats > 0) AND (number_of_seats <= 10))),
    CONSTRAINT type_price_check CHECK ((price > 0))
);


ALTER TABLE lab_1.type OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17916)
-- Name: type_id_type_seq; Type: SEQUENCE; Schema: lab_1; Owner: postgres
--

ALTER TABLE lab_1.type ALTER COLUMN id_type ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME lab_1.type_id_type_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 230 (class 1259 OID 17917)
-- Name: visitor; Type: TABLE; Schema: lab_1; Owner: postgres
--

CREATE TABLE lab_1.visitor (
    id_visitor bigint NOT NULL,
    name character varying(20) NOT NULL,
    surname character varying(20) NOT NULL,
    patronymic character varying(20) NOT NULL,
    adress character varying(60) NOT NULL,
    number_of_passport character varying(11) NOT NULL
);


ALTER TABLE lab_1.visitor OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17920)
-- Name: visitor_id_visitor_seq; Type: SEQUENCE; Schema: lab_1; Owner: postgres
--

ALTER TABLE lab_1.visitor ALTER COLUMN id_visitor ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME lab_1.visitor_id_visitor_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 232 (class 1259 OID 17921)
-- Name: work_schedule; Type: TABLE; Schema: lab_1; Owner: postgres
--

CREATE TABLE lab_1.work_schedule (
    id_work_schedule bigint NOT NULL,
    shift_id bigint NOT NULL,
    employee_id bigint NOT NULL
);


ALTER TABLE lab_1.work_schedule OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17924)
-- Name: work_schedule_id_work_schedule_seq; Type: SEQUENCE; Schema: lab_1; Owner: postgres
--

ALTER TABLE lab_1.work_schedule ALTER COLUMN id_work_schedule ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME lab_1.work_schedule_id_work_schedule_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3663 (class 0 OID 17881)
-- Dependencies: 215
-- Data for Name: conveniences; Type: TABLE DATA; Schema: lab_1; Owner: postgres
--

COPY lab_1.conveniences (id_conveniences, category, name) FROM stdin;
21	Техника	Кондиционер
22	Техника	Телевизор
23	Техника	Микроволновка
24	Услуга	Массаж
25	Услуга	Завтрак в номер
\.


--
-- TOC entry 3665 (class 0 OID 17885)
-- Dependencies: 217
-- Data for Name: employee; Type: TABLE DATA; Schema: lab_1; Owner: postgres
--

COPY lab_1.employee (id_employee, full_name, post, category, salary, number_of_passport) FROM stdin;
26	Андреев Артем Сергеевич	Администратор	Первая	40000	4015 535678
27	Павлов ‘Кирилл Андреевич	Администратор	Вторая	50000	4012 536587
28	Задохин Александр Антонович	Повар	Третья	80000	4013 125689
29	Уколов Георгий Владимирович	Беллбой	Первая	25000	4010 908045
30	Зайцев Олег Андреевич	Уборщик	Вторая	20000	4016 341223
\.


--
-- TOC entry 3667 (class 0 OID 17890)
-- Dependencies: 219
-- Data for Name: hotel; Type: TABLE DATA; Schema: lab_1; Owner: postgres
--

COPY lab_1.hotel (id_hotel, name, adress, promotion_id, hotel_room_id, employee_id) FROM stdin;
1	Гранд	Москва, малая Садовая, дом 32	33	6	26
\.


--
-- TOC entry 3669 (class 0 OID 17894)
-- Dependencies: 221
-- Data for Name: hotel_room; Type: TABLE DATA; Schema: lab_1; Owner: postgres
--

COPY lab_1.hotel_room (id_hotel_room, type_id, cleaning_status, employment_status) FROM stdin;
6	16	t	f
7	17	f	f
8	18	f	t
9	19	t	f
10	20	f	t
\.


--
-- TOC entry 3671 (class 0 OID 17898)
-- Dependencies: 223
-- Data for Name: promotion; Type: TABLE DATA; Schema: lab_1; Owner: postgres
--

COPY lab_1.promotion (id_promotion, holiday, benefit, season) FROM stdin;
31	Новый год	20%	
32	День рождения	15%	
33		1%	Весна
34		1%	Осень
35		5%	Зима
36		3%	Лето
\.


--
-- TOC entry 3673 (class 0 OID 17902)
-- Dependencies: 225
-- Data for Name: registration; Type: TABLE DATA; Schema: lab_1; Owner: postgres
--

COPY lab_1.registration (date_of_registration, date_of_departure, hotel_room_id, employee_id, visitor_id, reservation_status, lateness_status) FROM stdin;
2023-04-11 11:11:11	2023-04-22 22:22:22	6	30	21	t	f
2023-04-20 13:34:11	2023-04-21 15:11:54	7	29	23	f	f
2023-03-07 18:17:45	2023-03-10 11:43:17	8	27	25	t	t
2023-01-01 11:00:12	2023-01-05 10:16:23	9	28	24	f	f
2023-02-12 14:15:16	2023-02-24 13:56:34	10	26	22	f	f
\.


--
-- TOC entry 3674 (class 0 OID 17906)
-- Dependencies: 226
-- Data for Name: shift; Type: TABLE DATA; Schema: lab_1; Owner: postgres
--

COPY lab_1.shift (id_shift, start_time, end_time, break_length) FROM stdin;
17	2023-03-13 10:00:00	2023-03-13 19:00:00	1
18	2023-03-13 15:00:00	2023-03-14 10:00:00	1
19	2023-03-13 20:00:00	2023-03-14 05:00:00	1
20	2023-03-14 10:00:00	2023-03-14 11:00:00	1
\.


--
-- TOC entry 3676 (class 0 OID 17911)
-- Dependencies: 228
-- Data for Name: type; Type: TABLE DATA; Schema: lab_1; Owner: postgres
--

COPY lab_1.type (id_type, price, number_of_seats, conveniences_id, title) FROM stdin;
16	15000	8	21	Президент
17	2500	2	22	Классик
18	4000	3	23	Классик
19	8000	4	24	Люкс
20	10000	6	25	Люкс
\.


--
-- TOC entry 3678 (class 0 OID 17917)
-- Dependencies: 230
-- Data for Name: visitor; Type: TABLE DATA; Schema: lab_1; Owner: postgres
--

COPY lab_1.visitor (id_visitor, name, surname, patronymic, adress, number_of_passport) FROM stdin;
21	Артём	Бочкарь	Артёмович	Санкт-Петербург, улица Бронная, дом 15/4, кв. 1	4013 457890
22	Лобус	Виктория	Витальевна	Санкт-Петербург, улица Бронная, дом 15/4, кв. 1	4013 673412
23	Комаров	Алексей	Иванович	Мурманск, проспкт Сергея Приминина, дом 37, кв. 16	4011 554421
24	Исаев	Батыр	Бактыбекович	Москва, улица Советников, дом 12, кв. 567	4010 425363
25	Кислый	Иван	Петрович	Пермь, улица Горская, дом 3, кв. 114	4006 571973
\.


--
-- TOC entry 3680 (class 0 OID 17921)
-- Dependencies: 232
-- Data for Name: work_schedule; Type: TABLE DATA; Schema: lab_1; Owner: postgres
--

COPY lab_1.work_schedule (id_work_schedule, shift_id, employee_id) FROM stdin;
1	17	27
2	17	26
3	18	30
4	19	29
5	20	28
\.


--
-- TOC entry 3687 (class 0 OID 0)
-- Dependencies: 216
-- Name: conveniences_id_conveniences_seq; Type: SEQUENCE SET; Schema: lab_1; Owner: postgres
--

SELECT pg_catalog.setval('lab_1.conveniences_id_conveniences_seq', 25, true);


--
-- TOC entry 3688 (class 0 OID 0)
-- Dependencies: 218
-- Name: employee_id_employee_seq; Type: SEQUENCE SET; Schema: lab_1; Owner: postgres
--

SELECT pg_catalog.setval('lab_1.employee_id_employee_seq', 30, true);


--
-- TOC entry 3689 (class 0 OID 0)
-- Dependencies: 220
-- Name: hotel_id_hotel_seq; Type: SEQUENCE SET; Schema: lab_1; Owner: postgres
--

SELECT pg_catalog.setval('lab_1.hotel_id_hotel_seq', 1, true);


--
-- TOC entry 3690 (class 0 OID 0)
-- Dependencies: 222
-- Name: hotel_room_id_hotel_room_seq; Type: SEQUENCE SET; Schema: lab_1; Owner: postgres
--

SELECT pg_catalog.setval('lab_1.hotel_room_id_hotel_room_seq', 10, true);


--
-- TOC entry 3691 (class 0 OID 0)
-- Dependencies: 224
-- Name: promotion_id_promotion_seq; Type: SEQUENCE SET; Schema: lab_1; Owner: postgres
--

SELECT pg_catalog.setval('lab_1.promotion_id_promotion_seq', 36, true);


--
-- TOC entry 3692 (class 0 OID 0)
-- Dependencies: 227
-- Name: shift_id_shift_seq; Type: SEQUENCE SET; Schema: lab_1; Owner: postgres
--

SELECT pg_catalog.setval('lab_1.shift_id_shift_seq', 20, true);


--
-- TOC entry 3693 (class 0 OID 0)
-- Dependencies: 229
-- Name: type_id_type_seq; Type: SEQUENCE SET; Schema: lab_1; Owner: postgres
--

SELECT pg_catalog.setval('lab_1.type_id_type_seq', 20, true);


--
-- TOC entry 3694 (class 0 OID 0)
-- Dependencies: 231
-- Name: visitor_id_visitor_seq; Type: SEQUENCE SET; Schema: lab_1; Owner: postgres
--

SELECT pg_catalog.setval('lab_1.visitor_id_visitor_seq', 25, true);


--
-- TOC entry 3695 (class 0 OID 0)
-- Dependencies: 233
-- Name: work_schedule_id_work_schedule_seq; Type: SEQUENCE SET; Schema: lab_1; Owner: postgres
--

SELECT pg_catalog.setval('lab_1.work_schedule_id_work_schedule_seq', 5, true);


--
-- TOC entry 3490 (class 2606 OID 17926)
-- Name: conveniences conveniences_pkey; Type: CONSTRAINT; Schema: lab_1; Owner: postgres
--

ALTER TABLE ONLY lab_1.conveniences
    ADD CONSTRAINT conveniences_pkey PRIMARY KEY (id_conveniences);


--
-- TOC entry 3492 (class 2606 OID 17928)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: lab_1; Owner: postgres
--

ALTER TABLE ONLY lab_1.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (id_employee);


--
-- TOC entry 3494 (class 2606 OID 17930)
-- Name: hotel hotel_pkey; Type: CONSTRAINT; Schema: lab_1; Owner: postgres
--

ALTER TABLE ONLY lab_1.hotel
    ADD CONSTRAINT hotel_pkey PRIMARY KEY (id_hotel);


--
-- TOC entry 3496 (class 2606 OID 17932)
-- Name: hotel hotel_promotion_id_hotel_room_id_employee_id_key; Type: CONSTRAINT; Schema: lab_1; Owner: postgres
--

ALTER TABLE ONLY lab_1.hotel
    ADD CONSTRAINT hotel_promotion_id_hotel_room_id_employee_id_key UNIQUE (promotion_id, hotel_room_id, employee_id);


--
-- TOC entry 3498 (class 2606 OID 17934)
-- Name: hotel_room hotel_room_pkey; Type: CONSTRAINT; Schema: lab_1; Owner: postgres
--

ALTER TABLE ONLY lab_1.hotel_room
    ADD CONSTRAINT hotel_room_pkey PRIMARY KEY (id_hotel_room);


--
-- TOC entry 3500 (class 2606 OID 17936)
-- Name: promotion promotion_pkey; Type: CONSTRAINT; Schema: lab_1; Owner: postgres
--

ALTER TABLE ONLY lab_1.promotion
    ADD CONSTRAINT promotion_pkey PRIMARY KEY (id_promotion);


--
-- TOC entry 3502 (class 2606 OID 17938)
-- Name: registration registration_pkey; Type: CONSTRAINT; Schema: lab_1; Owner: postgres
--

ALTER TABLE ONLY lab_1.registration
    ADD CONSTRAINT registration_pkey PRIMARY KEY (hotel_room_id, employee_id, visitor_id);


--
-- TOC entry 3504 (class 2606 OID 17940)
-- Name: shift shift_pkey; Type: CONSTRAINT; Schema: lab_1; Owner: postgres
--

ALTER TABLE ONLY lab_1.shift
    ADD CONSTRAINT shift_pkey PRIMARY KEY (id_shift);


--
-- TOC entry 3506 (class 2606 OID 17942)
-- Name: type type_pkey; Type: CONSTRAINT; Schema: lab_1; Owner: postgres
--

ALTER TABLE ONLY lab_1.type
    ADD CONSTRAINT type_pkey PRIMARY KEY (id_type);


--
-- TOC entry 3508 (class 2606 OID 17944)
-- Name: visitor visitor_pkey; Type: CONSTRAINT; Schema: lab_1; Owner: postgres
--

ALTER TABLE ONLY lab_1.visitor
    ADD CONSTRAINT visitor_pkey PRIMARY KEY (id_visitor);


--
-- TOC entry 3510 (class 2606 OID 17946)
-- Name: work_schedule work_schedule_pkey; Type: CONSTRAINT; Schema: lab_1; Owner: postgres
--

ALTER TABLE ONLY lab_1.work_schedule
    ADD CONSTRAINT work_schedule_pkey PRIMARY KEY (id_work_schedule);


--
-- TOC entry 3511 (class 2606 OID 17947)
-- Name: hotel hotel_employee_id_fkey; Type: FK CONSTRAINT; Schema: lab_1; Owner: postgres
--

ALTER TABLE ONLY lab_1.hotel
    ADD CONSTRAINT hotel_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES lab_1.employee(id_employee) ON DELETE CASCADE;


--
-- TOC entry 3512 (class 2606 OID 17952)
-- Name: hotel hotel_hotel_room_id_fkey; Type: FK CONSTRAINT; Schema: lab_1; Owner: postgres
--

ALTER TABLE ONLY lab_1.hotel
    ADD CONSTRAINT hotel_hotel_room_id_fkey FOREIGN KEY (hotel_room_id) REFERENCES lab_1.hotel_room(id_hotel_room) ON DELETE CASCADE;


--
-- TOC entry 3513 (class 2606 OID 17957)
-- Name: hotel hotel_promotion_id_fkey; Type: FK CONSTRAINT; Schema: lab_1; Owner: postgres
--

ALTER TABLE ONLY lab_1.hotel
    ADD CONSTRAINT hotel_promotion_id_fkey FOREIGN KEY (promotion_id) REFERENCES lab_1.promotion(id_promotion) ON DELETE CASCADE;


--
-- TOC entry 3514 (class 2606 OID 17962)
-- Name: hotel_room hotel_room_type_id_fkey; Type: FK CONSTRAINT; Schema: lab_1; Owner: postgres
--

ALTER TABLE ONLY lab_1.hotel_room
    ADD CONSTRAINT hotel_room_type_id_fkey FOREIGN KEY (type_id) REFERENCES lab_1.type(id_type) ON DELETE CASCADE;


--
-- TOC entry 3515 (class 2606 OID 17967)
-- Name: registration registration_employee_id_fkey; Type: FK CONSTRAINT; Schema: lab_1; Owner: postgres
--

ALTER TABLE ONLY lab_1.registration
    ADD CONSTRAINT registration_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES lab_1.employee(id_employee) ON DELETE CASCADE;


--
-- TOC entry 3516 (class 2606 OID 17972)
-- Name: registration registration_hotel_room_id_fkey; Type: FK CONSTRAINT; Schema: lab_1; Owner: postgres
--

ALTER TABLE ONLY lab_1.registration
    ADD CONSTRAINT registration_hotel_room_id_fkey FOREIGN KEY (hotel_room_id) REFERENCES lab_1.hotel_room(id_hotel_room) ON DELETE CASCADE;


--
-- TOC entry 3517 (class 2606 OID 17977)
-- Name: registration registration_visitor_id_fkey; Type: FK CONSTRAINT; Schema: lab_1; Owner: postgres
--

ALTER TABLE ONLY lab_1.registration
    ADD CONSTRAINT registration_visitor_id_fkey FOREIGN KEY (visitor_id) REFERENCES lab_1.visitor(id_visitor) ON DELETE CASCADE;


--
-- TOC entry 3518 (class 2606 OID 17982)
-- Name: type type_conveniences_id_fkey; Type: FK CONSTRAINT; Schema: lab_1; Owner: postgres
--

ALTER TABLE ONLY lab_1.type
    ADD CONSTRAINT type_conveniences_id_fkey FOREIGN KEY (conveniences_id) REFERENCES lab_1.conveniences(id_conveniences) ON DELETE CASCADE;


--
-- TOC entry 3519 (class 2606 OID 17987)
-- Name: work_schedule work_schedule_employee_id_fkey; Type: FK CONSTRAINT; Schema: lab_1; Owner: postgres
--

ALTER TABLE ONLY lab_1.work_schedule
    ADD CONSTRAINT work_schedule_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES lab_1.employee(id_employee) ON DELETE CASCADE;


--
-- TOC entry 3520 (class 2606 OID 17992)
-- Name: work_schedule work_schedule_shift_id_fkey; Type: FK CONSTRAINT; Schema: lab_1; Owner: postgres
--

ALTER TABLE ONLY lab_1.work_schedule
    ADD CONSTRAINT work_schedule_shift_id_fkey FOREIGN KEY (shift_id) REFERENCES lab_1.shift(id_shift) ON DELETE CASCADE;


-- Completed on 2023-05-03 16:11:30 MSK

--
-- PostgreSQL database dump complete
--

