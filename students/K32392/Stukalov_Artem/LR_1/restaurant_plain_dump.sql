--
-- PostgreSQL database dump
--

-- Dumped from database version 14.3
-- Dumped by pg_dump version 14.3

-- Started on 2023-03-18 14:32:00 MSK

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
-- TOC entry 234 (class 1259 OID 20321)
-- Name: bookings; Type: TABLE; Schema: public; Owner: astukalov
--

CREATE TABLE public.bookings (
    booking_id bigint NOT NULL,
    name_for_booking character varying(80),
    is_confirmed boolean NOT NULL,
    booking_datetime timestamp without time zone NOT NULL,
    table_id bigint NOT NULL,
    CONSTRAINT bookings_booking_datetime_check CHECK ((booking_datetime >= CURRENT_TIMESTAMP))
);


ALTER TABLE public.bookings OWNER TO astukalov;

--
-- TOC entry 233 (class 1259 OID 20320)
-- Name: bookings_booking_id_seq; Type: SEQUENCE; Schema: public; Owner: astukalov
--

ALTER TABLE public.bookings ALTER COLUMN booking_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bookings_booking_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 232 (class 1259 OID 20299)
-- Name: cooking_progress; Type: TABLE; Schema: public; Owner: astukalov
--

CREATE TABLE public.cooking_progress (
    dish_id bigint NOT NULL,
    order_id bigint NOT NULL,
    employee_id bigint NOT NULL,
    dish_count integer NOT NULL,
    is_ready boolean NOT NULL,
    guest_wishes character varying(200),
    CONSTRAINT cooking_progress_dish_count_check CHECK ((dish_count > 0))
);


ALTER TABLE public.cooking_progress OWNER TO astukalov;

--
-- TOC entry 212 (class 1259 OID 20139)
-- Name: dish_categories; Type: TABLE; Schema: public; Owner: astukalov
--

CREATE TABLE public.dish_categories (
    dish_category_id bigint NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.dish_categories OWNER TO astukalov;

--
-- TOC entry 211 (class 1259 OID 20138)
-- Name: dish_categories_dish_category_id_seq; Type: SEQUENCE; Schema: public; Owner: astukalov
--

ALTER TABLE public.dish_categories ALTER COLUMN dish_category_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.dish_categories_dish_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 214 (class 1259 OID 20147)
-- Name: dishes; Type: TABLE; Schema: public; Owner: astukalov
--

CREATE TABLE public.dishes (
    dish_id bigint NOT NULL,
    dish_category_id bigint,
    name character varying(80) NOT NULL,
    price integer NOT NULL,
    recipe character varying(1200) NOT NULL,
    CONSTRAINT dishes_price_check CHECK ((price > 0))
);


ALTER TABLE public.dishes OWNER TO astukalov;

--
-- TOC entry 213 (class 1259 OID 20146)
-- Name: dishes_dish_id_seq; Type: SEQUENCE; Schema: public; Owner: astukalov
--

ALTER TABLE public.dishes ALTER COLUMN dish_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.dishes_dish_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 210 (class 1259 OID 20131)
-- Name: employees; Type: TABLE; Schema: public; Owner: astukalov
--

CREATE TABLE public.employees (
    employee_id bigint NOT NULL,
    pasport character varying(20) NOT NULL,
    fio character varying(120) NOT NULL,
    postition character varying(80) NOT NULL,
    category character varying(80) NOT NULL,
    salary integer NOT NULL,
    CONSTRAINT employees_category_check CHECK (((category)::text = ANY ((ARRAY['Кухня'::character varying, 'Обслуживание'::character varying, 'Администрация'::character varying])::text[]))),
    CONSTRAINT employees_salary_check CHECK ((salary >= 16242))
);


ALTER TABLE public.employees OWNER TO astukalov;

--
-- TOC entry 209 (class 1259 OID 20130)
-- Name: employees_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: astukalov
--

ALTER TABLE public.employees ALTER COLUMN employee_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.employees_employee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 230 (class 1259 OID 20266)
-- Name: orders; Type: TABLE; Schema: public; Owner: astukalov
--

CREATE TABLE public.orders (
    order_id bigint NOT NULL,
    table_id bigint,
    employee_id bigint,
    open_datetime timestamp without time zone NOT NULL,
    close_datetime timestamp without time zone,
    is_paid boolean NOT NULL,
    CONSTRAINT orders_check CHECK ((close_datetime > open_datetime)),
    CONSTRAINT orders_close_datetime_check CHECK ((close_datetime >= CURRENT_TIMESTAMP)),
    CONSTRAINT orders_open_datetime_check CHECK ((open_datetime >= CURRENT_TIMESTAMP))
);


ALTER TABLE public.orders OWNER TO astukalov;

--
-- TOC entry 229 (class 1259 OID 20265)
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: astukalov
--

ALTER TABLE public.orders ALTER COLUMN order_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.orders_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 20175)
-- Name: product_providers; Type: TABLE; Schema: public; Owner: astukalov
--

CREATE TABLE public.product_providers (
    provider_id bigint NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.product_providers OWNER TO astukalov;

--
-- TOC entry 217 (class 1259 OID 20174)
-- Name: product_providers_provider_id_seq; Type: SEQUENCE; Schema: public; Owner: astukalov
--

ALTER TABLE public.product_providers ALTER COLUMN provider_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_providers_provider_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 20183)
-- Name: product_purchases; Type: TABLE; Schema: public; Owner: astukalov
--

CREATE TABLE public.product_purchases (
    product_purchase_id bigint NOT NULL,
    product_id bigint,
    provider_id bigint,
    volume integer NOT NULL,
    price integer NOT NULL,
    purchase_date date NOT NULL,
    expiration_date date NOT NULL,
    CONSTRAINT product_purchases_check CHECK ((expiration_date > purchase_date)),
    CONSTRAINT product_purchases_expiration_date_check CHECK ((expiration_date > CURRENT_DATE)),
    CONSTRAINT product_purchases_price_check CHECK ((price > 0)),
    CONSTRAINT product_purchases_volume_check CHECK ((volume > 0))
);


ALTER TABLE public.product_purchases OWNER TO astukalov;

--
-- TOC entry 219 (class 1259 OID 20182)
-- Name: product_purchases_product_purchase_id_seq; Type: SEQUENCE; Schema: public; Owner: astukalov
--

ALTER TABLE public.product_purchases ALTER COLUMN product_purchase_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_purchases_product_purchase_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 216 (class 1259 OID 20163)
-- Name: products; Type: TABLE; Schema: public; Owner: astukalov
--

CREATE TABLE public.products (
    product_id bigint NOT NULL,
    name character varying(80) NOT NULL,
    max_price integer NOT NULL,
    required_volume integer NOT NULL,
    calories integer NOT NULL,
    stock_volume integer NOT NULL,
    CONSTRAINT products_calories_check CHECK ((calories > 0)),
    CONSTRAINT products_max_price_check CHECK ((max_price > 0)),
    CONSTRAINT products_required_volume_check CHECK ((required_volume >= 0)),
    CONSTRAINT products_stock_volume_check CHECK ((stock_volume >= 0))
);


ALTER TABLE public.products OWNER TO astukalov;

--
-- TOC entry 221 (class 1259 OID 20202)
-- Name: products_in_dishes; Type: TABLE; Schema: public; Owner: astukalov
--

CREATE TABLE public.products_in_dishes (
    dish_id bigint NOT NULL,
    product_id bigint NOT NULL,
    product_volume integer NOT NULL,
    CONSTRAINT products_in_dishes_product_volume_check CHECK ((product_volume > 0))
);


ALTER TABLE public.products_in_dishes OWNER TO astukalov;

--
-- TOC entry 215 (class 1259 OID 20162)
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: astukalov
--

ALTER TABLE public.products ALTER COLUMN product_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.products_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 226 (class 1259 OID 20241)
-- Name: schedules; Type: TABLE; Schema: public; Owner: astukalov
--

CREATE TABLE public.schedules (
    schedule_id bigint NOT NULL,
    employee_id bigint NOT NULL,
    working_shift_id bigint NOT NULL
);


ALTER TABLE public.schedules OWNER TO astukalov;

--
-- TOC entry 225 (class 1259 OID 20240)
-- Name: schedules_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: astukalov
--

ALTER TABLE public.schedules ALTER COLUMN schedule_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.schedules_schedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 231 (class 1259 OID 20284)
-- Name: table_allocations; Type: TABLE; Schema: public; Owner: astukalov
--

CREATE TABLE public.table_allocations (
    table_id bigint NOT NULL,
    schedule_id bigint NOT NULL
);


ALTER TABLE public.table_allocations OWNER TO astukalov;

--
-- TOC entry 228 (class 1259 OID 20259)
-- Name: tables; Type: TABLE; Schema: public; Owner: astukalov
--

CREATE TABLE public.tables (
    table_id bigint NOT NULL,
    places_count integer NOT NULL,
    location_features character varying(200),
    is_taken boolean NOT NULL,
    CONSTRAINT tables_places_count_check CHECK ((places_count > 0))
);


ALTER TABLE public.tables OWNER TO astukalov;

--
-- TOC entry 227 (class 1259 OID 20258)
-- Name: tables_table_id_seq; Type: SEQUENCE; Schema: public; Owner: astukalov
--

ALTER TABLE public.tables ALTER COLUMN table_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tables_table_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 20218)
-- Name: workers_skills; Type: TABLE; Schema: public; Owner: astukalov
--

CREATE TABLE public.workers_skills (
    dish_id bigint NOT NULL,
    employee_id bigint NOT NULL
);


ALTER TABLE public.workers_skills OWNER TO astukalov;

--
-- TOC entry 224 (class 1259 OID 20234)
-- Name: working_shifts; Type: TABLE; Schema: public; Owner: astukalov
--

CREATE TABLE public.working_shifts (
    working_shift_id bigint NOT NULL,
    start_datetime timestamp without time zone NOT NULL,
    end_datetime timestamp without time zone NOT NULL,
    CONSTRAINT working_shifts_check CHECK ((start_datetime < end_datetime))
);


ALTER TABLE public.working_shifts OWNER TO astukalov;

--
-- TOC entry 223 (class 1259 OID 20233)
-- Name: working_shifts_working_shift_id_seq; Type: SEQUENCE; Schema: public; Owner: astukalov
--

ALTER TABLE public.working_shifts ALTER COLUMN working_shift_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.working_shifts_working_shift_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 4495 (class 0 OID 20321)
-- Dependencies: 234
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: astukalov
--

COPY public.bookings (booking_id, name_for_booking, is_confirmed, booking_datetime, table_id) FROM stdin;
1	Андрей	f	2023-03-16 13:27:00	1
\.


--
-- TOC entry 4493 (class 0 OID 20299)
-- Dependencies: 232
-- Data for Name: cooking_progress; Type: TABLE DATA; Schema: public; Owner: astukalov
--

COPY public.cooking_progress (dish_id, order_id, employee_id, dish_count, is_ready, guest_wishes) FROM stdin;
1	1	1	2	f	Одно блюдо без кетчупа
\.


--
-- TOC entry 4473 (class 0 OID 20139)
-- Dependencies: 212
-- Data for Name: dish_categories; Type: TABLE DATA; Schema: public; Owner: astukalov
--

COPY public.dish_categories (dish_category_id, name) FROM stdin;
1	Домашние
\.


--
-- TOC entry 4475 (class 0 OID 20147)
-- Dependencies: 214
-- Data for Name: dishes; Type: TABLE DATA; Schema: public; Owner: astukalov
--

COPY public.dishes (dish_id, dish_category_id, name, price, recipe) FROM stdin;
1	1	Спагетти с сосисками и кетчупом	356	Варим спагетти 5 минут...
\.


--
-- TOC entry 4471 (class 0 OID 20131)
-- Dependencies: 210
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: astukalov
--

COPY public.employees (employee_id, pasport, fio, postition, category, salary) FROM stdin;
1	1234 123456	Стукалов Артем Сергеевич	Шеф-повар	Кухня	100000
2	1234 123457	Денис Аксенов Иванович	Су-шеф	Кухня	70000
3	1234 123458	Егор Лавров Ефимович	Повар	Кухня	50000
4	1234 123459	Кристина Гончарова Владимировна	Управляющий	Администрация	100000
5	1234 123460	Влад Анисимов Юрьевич	Официант	Обслуживание	50000
6	1234 123461	Петр Анисимов Юрьевич	Официант	Обслуживание	50000
\.


--
-- TOC entry 4491 (class 0 OID 20266)
-- Dependencies: 230
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: astukalov
--

COPY public.orders (order_id, table_id, employee_id, open_datetime, close_datetime, is_paid) FROM stdin;
1	1	5	2023-03-13 13:27:00	\N	f
\.


--
-- TOC entry 4479 (class 0 OID 20175)
-- Dependencies: 218
-- Data for Name: product_providers; Type: TABLE DATA; Schema: public; Owner: astukalov
--

COPY public.product_providers (provider_id, name) FROM stdin;
1	ООО Продукты для ресторанов
\.


--
-- TOC entry 4481 (class 0 OID 20183)
-- Dependencies: 220
-- Data for Name: product_purchases; Type: TABLE DATA; Schema: public; Owner: astukalov
--

COPY public.product_purchases (product_purchase_id, product_id, provider_id, volume, price, purchase_date, expiration_date) FROM stdin;
1	1	1	7000	3200	2023-03-10	2023-06-10
2	2	1	8000	5400	2023-03-10	2023-03-27
3	3	1	3000	1607	2023-03-10	2023-03-25
\.


--
-- TOC entry 4477 (class 0 OID 20163)
-- Dependencies: 216
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: astukalov
--

COPY public.products (product_id, name, max_price, required_volume, calories, stock_volume) FROM stdin;
1	Макароны спагетти 3мм	100	5000	23	5300
2	Сосиски вязанка молочные	150	3000	56	3478
3	Кетчуп махеев	25	2000	13	2167
\.


--
-- TOC entry 4482 (class 0 OID 20202)
-- Dependencies: 221
-- Data for Name: products_in_dishes; Type: TABLE DATA; Schema: public; Owner: astukalov
--

COPY public.products_in_dishes (dish_id, product_id, product_volume) FROM stdin;
1	1	200
1	2	150
1	3	50
\.


--
-- TOC entry 4487 (class 0 OID 20241)
-- Dependencies: 226
-- Data for Name: schedules; Type: TABLE DATA; Schema: public; Owner: astukalov
--

COPY public.schedules (schedule_id, employee_id, working_shift_id) FROM stdin;
1	1	1
2	2	1
3	3	1
4	4	1
5	5	1
6	6	1
\.


--
-- TOC entry 4492 (class 0 OID 20284)
-- Dependencies: 231
-- Data for Name: table_allocations; Type: TABLE DATA; Schema: public; Owner: astukalov
--

COPY public.table_allocations (table_id, schedule_id) FROM stdin;
1	5
2	5
3	5
4	6
5	6
\.


--
-- TOC entry 4489 (class 0 OID 20259)
-- Dependencies: 228
-- Data for Name: tables; Type: TABLE DATA; Schema: public; Owner: astukalov
--

COPY public.tables (table_id, places_count, location_features, is_taken) FROM stdin;
1	2	Столик у окна	f
2	2		f
3	4		f
4	4		f
5	4		f
\.


--
-- TOC entry 4483 (class 0 OID 20218)
-- Dependencies: 222
-- Data for Name: workers_skills; Type: TABLE DATA; Schema: public; Owner: astukalov
--

COPY public.workers_skills (dish_id, employee_id) FROM stdin;
1	1
1	2
1	3
\.


--
-- TOC entry 4485 (class 0 OID 20234)
-- Dependencies: 224
-- Data for Name: working_shifts; Type: TABLE DATA; Schema: public; Owner: astukalov
--

COPY public.working_shifts (working_shift_id, start_datetime, end_datetime) FROM stdin;
1	2023-03-13 09:00:00	2023-03-13 18:00:00
\.


--
-- TOC entry 4501 (class 0 OID 0)
-- Dependencies: 233
-- Name: bookings_booking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: astukalov
--

SELECT pg_catalog.setval('public.bookings_booking_id_seq', 1, true);


--
-- TOC entry 4502 (class 0 OID 0)
-- Dependencies: 211
-- Name: dish_categories_dish_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: astukalov
--

SELECT pg_catalog.setval('public.dish_categories_dish_category_id_seq', 1, true);


--
-- TOC entry 4503 (class 0 OID 0)
-- Dependencies: 213
-- Name: dishes_dish_id_seq; Type: SEQUENCE SET; Schema: public; Owner: astukalov
--

SELECT pg_catalog.setval('public.dishes_dish_id_seq', 1, true);


--
-- TOC entry 4504 (class 0 OID 0)
-- Dependencies: 209
-- Name: employees_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: astukalov
--

SELECT pg_catalog.setval('public.employees_employee_id_seq', 6, true);


--
-- TOC entry 4505 (class 0 OID 0)
-- Dependencies: 229
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: astukalov
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 1, true);


--
-- TOC entry 4506 (class 0 OID 0)
-- Dependencies: 217
-- Name: product_providers_provider_id_seq; Type: SEQUENCE SET; Schema: public; Owner: astukalov
--

SELECT pg_catalog.setval('public.product_providers_provider_id_seq', 1, true);


--
-- TOC entry 4507 (class 0 OID 0)
-- Dependencies: 219
-- Name: product_purchases_product_purchase_id_seq; Type: SEQUENCE SET; Schema: public; Owner: astukalov
--

SELECT pg_catalog.setval('public.product_purchases_product_purchase_id_seq', 3, true);


--
-- TOC entry 4508 (class 0 OID 0)
-- Dependencies: 215
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: astukalov
--

SELECT pg_catalog.setval('public.products_product_id_seq', 3, true);


--
-- TOC entry 4509 (class 0 OID 0)
-- Dependencies: 225
-- Name: schedules_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: astukalov
--

SELECT pg_catalog.setval('public.schedules_schedule_id_seq', 6, true);


--
-- TOC entry 4510 (class 0 OID 0)
-- Dependencies: 227
-- Name: tables_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: astukalov
--

SELECT pg_catalog.setval('public.tables_table_id_seq', 5, true);


--
-- TOC entry 4511 (class 0 OID 0)
-- Dependencies: 223
-- Name: working_shifts_working_shift_id_seq; Type: SEQUENCE SET; Schema: public; Owner: astukalov
--

SELECT pg_catalog.setval('public.working_shifts_working_shift_id_seq', 1, true);


--
-- TOC entry 4313 (class 2606 OID 20326)
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (booking_id);


--
-- TOC entry 4311 (class 2606 OID 20304)
-- Name: cooking_progress cooking_progress_pkey; Type: CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.cooking_progress
    ADD CONSTRAINT cooking_progress_pkey PRIMARY KEY (dish_id, order_id, employee_id);


--
-- TOC entry 4277 (class 2606 OID 20145)
-- Name: dish_categories dish_categories_name_key; Type: CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.dish_categories
    ADD CONSTRAINT dish_categories_name_key UNIQUE (name);


--
-- TOC entry 4279 (class 2606 OID 20143)
-- Name: dish_categories dish_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.dish_categories
    ADD CONSTRAINT dish_categories_pkey PRIMARY KEY (dish_category_id);


--
-- TOC entry 4281 (class 2606 OID 20156)
-- Name: dishes dishes_name_key; Type: CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.dishes
    ADD CONSTRAINT dishes_name_key UNIQUE (name);


--
-- TOC entry 4283 (class 2606 OID 20154)
-- Name: dishes dishes_pkey; Type: CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.dishes
    ADD CONSTRAINT dishes_pkey PRIMARY KEY (dish_id);


--
-- TOC entry 4275 (class 2606 OID 20137)
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employee_id);


--
-- TOC entry 4307 (class 2606 OID 20273)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- TOC entry 4289 (class 2606 OID 20181)
-- Name: product_providers product_providers_name_key; Type: CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.product_providers
    ADD CONSTRAINT product_providers_name_key UNIQUE (name);


--
-- TOC entry 4291 (class 2606 OID 20179)
-- Name: product_providers product_providers_pkey; Type: CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.product_providers
    ADD CONSTRAINT product_providers_pkey PRIMARY KEY (provider_id);


--
-- TOC entry 4293 (class 2606 OID 20191)
-- Name: product_purchases product_purchases_pkey; Type: CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.product_purchases
    ADD CONSTRAINT product_purchases_pkey PRIMARY KEY (product_purchase_id);


--
-- TOC entry 4295 (class 2606 OID 20207)
-- Name: products_in_dishes products_in_dishes_pkey; Type: CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.products_in_dishes
    ADD CONSTRAINT products_in_dishes_pkey PRIMARY KEY (dish_id, product_id);


--
-- TOC entry 4285 (class 2606 OID 20173)
-- Name: products products_name_key; Type: CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_name_key UNIQUE (name);


--
-- TOC entry 4287 (class 2606 OID 20171)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- TOC entry 4301 (class 2606 OID 20247)
-- Name: schedules schedules_employee_id_working_shift_id_key; Type: CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_employee_id_working_shift_id_key UNIQUE (employee_id, working_shift_id);


--
-- TOC entry 4303 (class 2606 OID 20245)
-- Name: schedules schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_pkey PRIMARY KEY (schedule_id);


--
-- TOC entry 4309 (class 2606 OID 20288)
-- Name: table_allocations table_allocations_pkey; Type: CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.table_allocations
    ADD CONSTRAINT table_allocations_pkey PRIMARY KEY (table_id, schedule_id);


--
-- TOC entry 4305 (class 2606 OID 20264)
-- Name: tables tables_pkey; Type: CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.tables
    ADD CONSTRAINT tables_pkey PRIMARY KEY (table_id);


--
-- TOC entry 4297 (class 2606 OID 20222)
-- Name: workers_skills workers_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.workers_skills
    ADD CONSTRAINT workers_skills_pkey PRIMARY KEY (dish_id, employee_id);


--
-- TOC entry 4299 (class 2606 OID 20239)
-- Name: working_shifts working_shifts_pkey; Type: CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.working_shifts
    ADD CONSTRAINT working_shifts_pkey PRIMARY KEY (working_shift_id);


--
-- TOC entry 4330 (class 2606 OID 20327)
-- Name: bookings bookings_table_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_table_id_fkey FOREIGN KEY (table_id) REFERENCES public.tables(table_id) ON DELETE CASCADE;


--
-- TOC entry 4327 (class 2606 OID 20305)
-- Name: cooking_progress cooking_progress_dish_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.cooking_progress
    ADD CONSTRAINT cooking_progress_dish_id_fkey FOREIGN KEY (dish_id) REFERENCES public.dishes(dish_id) ON DELETE CASCADE;


--
-- TOC entry 4329 (class 2606 OID 20315)
-- Name: cooking_progress cooking_progress_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.cooking_progress
    ADD CONSTRAINT cooking_progress_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id) ON DELETE CASCADE;


--
-- TOC entry 4328 (class 2606 OID 20310)
-- Name: cooking_progress cooking_progress_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.cooking_progress
    ADD CONSTRAINT cooking_progress_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON DELETE CASCADE;


--
-- TOC entry 4314 (class 2606 OID 20157)
-- Name: dishes dishes_dish_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.dishes
    ADD CONSTRAINT dishes_dish_category_id_fkey FOREIGN KEY (dish_category_id) REFERENCES public.dish_categories(dish_category_id) ON DELETE SET NULL;


--
-- TOC entry 4323 (class 2606 OID 20274)
-- Name: orders orders_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id) ON DELETE SET NULL;


--
-- TOC entry 4324 (class 2606 OID 20279)
-- Name: orders orders_table_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_table_id_fkey FOREIGN KEY (table_id) REFERENCES public.tables(table_id) ON DELETE SET NULL;


--
-- TOC entry 4315 (class 2606 OID 20192)
-- Name: product_purchases product_purchases_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.product_purchases
    ADD CONSTRAINT product_purchases_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON DELETE SET NULL;


--
-- TOC entry 4316 (class 2606 OID 20197)
-- Name: product_purchases product_purchases_provider_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.product_purchases
    ADD CONSTRAINT product_purchases_provider_id_fkey FOREIGN KEY (provider_id) REFERENCES public.product_providers(provider_id) ON DELETE SET NULL;


--
-- TOC entry 4317 (class 2606 OID 20208)
-- Name: products_in_dishes products_in_dishes_dish_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.products_in_dishes
    ADD CONSTRAINT products_in_dishes_dish_id_fkey FOREIGN KEY (dish_id) REFERENCES public.dishes(dish_id) ON DELETE CASCADE;


--
-- TOC entry 4318 (class 2606 OID 20213)
-- Name: products_in_dishes products_in_dishes_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.products_in_dishes
    ADD CONSTRAINT products_in_dishes_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON DELETE CASCADE;


--
-- TOC entry 4321 (class 2606 OID 20248)
-- Name: schedules schedules_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id) ON DELETE CASCADE;


--
-- TOC entry 4322 (class 2606 OID 20253)
-- Name: schedules schedules_working_shift_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_working_shift_id_fkey FOREIGN KEY (working_shift_id) REFERENCES public.working_shifts(working_shift_id) ON DELETE CASCADE;


--
-- TOC entry 4326 (class 2606 OID 20294)
-- Name: table_allocations table_allocations_schedule_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.table_allocations
    ADD CONSTRAINT table_allocations_schedule_id_fkey FOREIGN KEY (schedule_id) REFERENCES public.schedules(schedule_id) ON DELETE CASCADE;


--
-- TOC entry 4325 (class 2606 OID 20289)
-- Name: table_allocations table_allocations_table_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.table_allocations
    ADD CONSTRAINT table_allocations_table_id_fkey FOREIGN KEY (table_id) REFERENCES public.tables(table_id) ON DELETE CASCADE;


--
-- TOC entry 4319 (class 2606 OID 20223)
-- Name: workers_skills workers_skills_dish_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.workers_skills
    ADD CONSTRAINT workers_skills_dish_id_fkey FOREIGN KEY (dish_id) REFERENCES public.dishes(dish_id) ON DELETE CASCADE;


--
-- TOC entry 4320 (class 2606 OID 20228)
-- Name: workers_skills workers_skills_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: astukalov
--

ALTER TABLE ONLY public.workers_skills
    ADD CONSTRAINT workers_skills_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id) ON DELETE CASCADE;


-- Completed on 2023-03-18 14:32:00 MSK

--
-- PostgreSQL database dump complete
--

