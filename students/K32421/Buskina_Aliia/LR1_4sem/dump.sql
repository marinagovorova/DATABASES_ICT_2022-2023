--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7
-- Dumped by pg_dump version 14.7

-- Started on 2023-03-27 10:45:31 MSK

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
-- TOC entry 2 (class 3079 OID 16430)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- TOC entry 3731 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- TOC entry 864 (class 1247 OID 16482)
-- Name: ed_izm; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.ed_izm AS ENUM (
    'килограмм',
    'штука',
    'литр'
);


ALTER TYPE public.ed_izm OWNER TO postgres;

--
-- TOC entry 858 (class 1247 OID 16462)
-- Name: post; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.post AS ENUM (
    'старший менеджер',
    'менеджер',
    'стажер'
);


ALTER TYPE public.post OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 16441)
-- Name: buyer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.buyer (
    buyer_id character varying(10) DEFAULT public.uuid_generate_v4() NOT NULL,
    buyer_name character varying(100) NOT NULL,
    buyer_address character varying(50) NOT NULL
);


ALTER TABLE public.buyer OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16758)
-- Name: buyer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.buyer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.buyer_id_seq OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16447)
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer (
    customer_id character varying(10) DEFAULT public.uuid_generate_v4() NOT NULL,
    customer_name character varying(100) NOT NULL,
    customer_address character varying(50) NOT NULL
);


ALTER TABLE public.customer OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16469)
-- Name: managers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.managers (
    manager_id character varying(10) DEFAULT public.uuid_generate_v4() NOT NULL,
    fio character varying(60) NOT NULL,
    passport character varying(11) NOT NULL,
    post public.post NOT NULL
);


ALTER TABLE public.managers OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16831)
-- Name: order_composition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_composition (
    id integer NOT NULL,
    order_id character varying(10) NOT NULL,
    amount_of_product integer NOT NULL,
    cost_for_sale integer NOT NULL,
    purchase_composition_id integer,
    CONSTRAINT amount_of_product CHECK ((amount_of_product > 0)),
    CONSTRAINT cost_for_sale CHECK ((cost_for_sale > 0))
);


ALTER TABLE public.order_composition OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16830)
-- Name: order_composition_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.order_composition ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.order_composition_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 223 (class 1259 OID 16849)
-- Name: order_invoice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_invoice (
    id integer NOT NULL,
    order_id character varying(10) NOT NULL,
    issue_date date NOT NULL,
    payment_date date NOT NULL,
    sum_of_order integer NOT NULL,
    status character varying(10) NOT NULL,
    CONSTRAINT date CHECK ((issue_date < payment_date)),
    CONSTRAINT sum_of_order CHECK ((sum_of_order > 0))
);


ALTER TABLE public.order_invoice OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16848)
-- Name: order_invoice_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.order_invoice ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.order_invoice_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 219 (class 1259 OID 16811)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id character varying(10) NOT NULL,
    buyer_id character varying(10) NOT NULL,
    manager_id character varying(10) NOT NULL,
    order_date date NOT NULL,
    recieve_date date NOT NULL,
    status character varying NOT NULL,
    CONSTRAINT date CHECK ((order_date < recieve_date))
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16809)
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16489)
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    product_id character varying(10) DEFAULT public.uuid_generate_v4() NOT NULL,
    product_name character varying(100) NOT NULL,
    customer_id character varying(10) NOT NULL,
    ed_izm public.ed_izm NOT NULL,
    cost_ed integer NOT NULL
);


ALTER TABLE public.product OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16864)
-- Name: purchase; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase (
    purchase_id character varying(10) NOT NULL,
    manager_id character varying(10) NOT NULL,
    customer_id character varying(10) NOT NULL,
    purchase_date date NOT NULL,
    shipment_date date NOT NULL,
    status character varying(10),
    CONSTRAINT date CHECK ((purchase_date < shipment_date)),
    CONSTRAINT status CHECK (((status)::text = ANY ((ARRAY['отправлена'::character varying, 'в работе'::character varying, 'на базе'::character varying])::text[])))
);


ALTER TABLE public.purchase OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16882)
-- Name: purchase_composition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase_composition (
    id integer NOT NULL,
    purchase_id character varying(10) NOT NULL,
    product_id character varying(10) NOT NULL,
    amount_of_products integer NOT NULL,
    cost_for_sale integer NOT NULL,
    stock integer,
    CONSTRAINT amount CHECK ((amount_of_products > 0)),
    CONSTRAINT cost CHECK ((cost_for_sale > 0))
);


ALTER TABLE public.purchase_composition OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16881)
-- Name: purchase_composition_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.purchase_composition ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.purchase_composition_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 229 (class 1259 OID 16912)
-- Name: purchase_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.purchase_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purchase_id_seq OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16900)
-- Name: purchase_invoice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase_invoice (
    id integer NOT NULL,
    purchase_id character varying(10) NOT NULL,
    issue_date date NOT NULL,
    payment_date date NOT NULL,
    sum_of_puchase integer NOT NULL,
    status character varying(10) NOT NULL,
    CONSTRAINT date CHECK ((issue_date < payment_date)),
    CONSTRAINT status CHECK (((status)::text = ANY ((ARRAY['оплачен'::character varying, 'не оплачен'::character varying, 'частично'::character varying])::text[])))
);


ALTER TABLE public.purchase_invoice OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16899)
-- Name: purchase_invoice_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.purchase_invoice ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.purchase_invoice_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 215 (class 1259 OID 16761)
-- Name: stock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stock (
    stock_id character varying(10) NOT NULL,
    stock_address character varying(60) NOT NULL
);


ALTER TABLE public.stock OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16786)
-- Name: stock_in_stock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stock_in_stock (
    zapas_id integer NOT NULL,
    stock_id character varying(10) NOT NULL,
    product_id character varying(10) NOT NULL,
    amount_of_product integer NOT NULL,
    CONSTRAINT amount CHECK ((amount_of_product > 0))
);


ALTER TABLE public.stock_in_stock OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16785)
-- Name: stock_in_stock_zapas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.stock_in_stock ALTER COLUMN zapas_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.stock_in_stock_zapas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3706 (class 0 OID 16441)
-- Dependencies: 210
-- Data for Name: buyer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.buyer (buyer_id, buyer_name, buyer_address) FROM stdin;
buyer2	company_2	street no.2
buyer3	company_3	street no.3
buyer4	company_4	street no.4
buyer5	company_5	street no.5
buyer6	company_6	street no.6
buyer7	company_7	street no.7
buyer8	company_8	street no.8
buyer9	company_9	street no.9
buyer10	company_10	street no.10
buyer11	company_11	street no.11
buyer12	company_12	street no.12
buyer13	company_13	street no.13
buyer14	company_14	street no.14
buyer15	company_15	street no.15
buyer16	company_16	street no.16
buyer17	company_17	street no.17
buyer18	company_18	street no.18
buyer19	company_19	street no.19
buyer20	company_20	street no.20
buyer21	company_21	street no.21
buyer22	company_22	street no.22
buyer23	company_23	street no.23
buyer24	company_24	street no.24
buyer25	company_25	street no.25
buyer26	company_26	street no.26
buyer27	company_27	street no.27
buyer28	company_28	street no.28
buyer29	company_29	street no.29
buyer30	company_30	street no.30
buyer31	company_31	street no.31
buyer32	company_32	street no.32
buyer33	company_33	street no.33
buyer34	company_34	street no.34
buyer35	company_35	street no.35
buyer36	company_36	street no.36
buyer37	company_37	street no.37
buyer38	company_38	street no.38
buyer39	company_39	street no.39
buyer40	company_40	street no.40
buyer41	company_41	street no.41
buyer42	company_42	street no.42
buyer43	company_43	street no.43
buyer44	company_44	street no.44
buyer45	company_45	street no.45
buyer46	company_46	street no.46
buyer47	company_47	street no.47
buyer48	company_48	street no.48
buyer49	company_49	street no.49
buyer50	company_50	street no.50
buyer51	company_51	street no.51
buyer52	company_52	street no.52
buyer53	company_53	street no.53
buyer54	company_54	street no.54
buyer55	company_55	street no.55
buyer56	company_56	street no.56
buyer57	company_57	street no.57
buyer58	company_58	street no.58
buyer59	company_59	street no.59
buyer60	company_60	street no.60
buyer61	company_61	street no.61
buyer62	company_62	street no.62
buyer63	company_63	street no.63
buyer64	company_64	street no.64
buyer65	company_65	street no.65
buyer66	company_66	street no.66
buyer67	company_67	street no.67
buyer68	company_68	street no.68
buyer69	company_69	street no.69
buyer70	company_70	street no.70
buyer71	company_71	street no.71
buyer72	company_72	street no.72
buyer73	company_73	street no.73
buyer74	company_74	street no.74
buyer75	company_75	street no.75
buyer76	company_76	street no.76
buyer77	company_77	street no.77
buyer78	company_78	street no.78
buyer79	company_79	street no.79
buyer80	company_80	street no.80
buyer81	company_81	street no.81
buyer82	company_82	street no.82
buyer83	company_83	street no.83
buyer84	company_84	street no.84
buyer85	company_85	street no.85
buyer86	company_86	street no.86
buyer87	company_87	street no.87
buyer88	company_88	street no.88
buyer89	company_89	street no.89
buyer90	company_90	street no.90
buyer91	company_91	street no.91
buyer92	company_92	street no.92
buyer93	company_93	street no.93
buyer94	company_94	street no.94
buyer95	company_95	street no.95
buyer96	company_96	street no.96
buyer97	company_97	street no.97
buyer98	company_98	street no.98
buyer99	company_99	street no.99
buyer1	Acme Corporation	456 Main St
\.


--
-- TOC entry 3707 (class 0 OID 16447)
-- Dependencies: 211
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer (customer_id, customer_name, customer_address) FROM stdin;
customer2	caterer2	any street no.2
customer3	caterer3	any street no.3
customer4	caterer4	any street no.4
customer5	caterer5	any street no.5
customer1	new caterer	456 Market St
\.


--
-- TOC entry 3708 (class 0 OID 16469)
-- Dependencies: 212
-- Data for Name: managers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.managers (manager_id, fio, passport, post) FROM stdin;
manager1	Ivan Ivanov	12345678901	стажер
manager2	Petr Petrov	12345678902	менеджер
manager3	Petr Sozonov	12345678903	старший менеджер
manager4	Ivan Sozonov	12345678904	менеджер
manager5	Ivan Orekhov	12345678905	стажер
\.


--
-- TOC entry 3717 (class 0 OID 16831)
-- Dependencies: 221
-- Data for Name: order_composition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_composition (id, order_id, amount_of_product, cost_for_sale, purchase_composition_id) FROM stdin;
1	order1	10	200	\N
4	order1	10	190	\N
5	order1	11	190	\N
6	order3	11	190	\N
7	order3	15	180	\N
\.


--
-- TOC entry 3719 (class 0 OID 16849)
-- Dependencies: 223
-- Data for Name: order_invoice; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_invoice (id, order_id, issue_date, payment_date, sum_of_order, status) FROM stdin;
1	order1	2022-04-02	2022-04-10	5990	оплачен
2	order3	2022-04-02	2022-04-10	4790	не оплачен
\.


--
-- TOC entry 3715 (class 0 OID 16811)
-- Dependencies: 219
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (order_id, buyer_id, manager_id, order_date, recieve_date, status) FROM stdin;
order1	buyer1	manager1	2022-04-01	2022-04-15	доставлен
order3	buyer10	manager3	2022-04-13	2022-04-15	доставлен
order4	buyer11	manager3	2022-04-13	2022-04-15	доставлен
order5	buyer12	manager4	2022-04-13	2022-04-15	доставлен
order7	buyer12	manager4	2022-04-13	2022-04-15	получен
\.


--
-- TOC entry 3709 (class 0 OID 16489)
-- Dependencies: 213
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product (product_id, product_name, customer_id, ed_izm, cost_ed) FROM stdin;
product01	apple	customer1	килограмм	100
product02	pear	customer1	килограмм	100
product03	juice	customer1	литр	150
product04	compote	customer1	литр	156
product05	melon	customer1	штука	170
product06	water melon	customer1	штука	160
product07	water melon	customer2	штука	161
product08	melon	customer2	штука	189
product10	apple	customer2	килограмм	110
product11	pear	customer2	килограмм	115
product1	pear	customer2	килограмм	115
\.


--
-- TOC entry 3720 (class 0 OID 16864)
-- Dependencies: 224
-- Data for Name: purchase; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchase (purchase_id, manager_id, customer_id, purchase_date, shipment_date, status) FROM stdin;
purchase1	manager1	customer1	2022-04-01	2022-04-15	отправлена
purchase2	manager2	customer2	2022-05-01	2022-05-15	на базе
purchase3	manager3	customer3	2022-05-02	2022-05-16	на базе
purchase4	manager4	customer4	2022-05-02	2022-05-16	в работе
purchase5	manager5	customer5	2022-05-02	2022-05-16	на базе
\.


--
-- TOC entry 3722 (class 0 OID 16882)
-- Dependencies: 226
-- Data for Name: purchase_composition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchase_composition (id, purchase_id, product_id, amount_of_products, cost_for_sale, stock) FROM stdin;
1	purchase1	product01	10	190	\N
2	purchase1	product02	10	190	\N
3	purchase1	product03	10	190	\N
7	purchase2	product01	15	200	\N
8	purchase2	product05	15	190	\N
9	purchase3	product06	15	190	\N
10	purchase3	product07	15	190	\N
\.


--
-- TOC entry 3724 (class 0 OID 16900)
-- Dependencies: 228
-- Data for Name: purchase_invoice; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchase_invoice (id, purchase_id, issue_date, payment_date, sum_of_puchase, status) FROM stdin;
1	purchase1	2022-04-02	2022-04-10	5700	не оплачен
2	purchase2	2022-04-02	2022-04-10	5850	не оплачен
4	purchase3	2022-04-02	2022-04-10	5700	оплачен
\.


--
-- TOC entry 3711 (class 0 OID 16761)
-- Dependencies: 215
-- Data for Name: stock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stock (stock_id, stock_address) FROM stdin;
stock1	Town street1
stock2	Town street2
stock3	Town street3
stock4	Town street4
stock5	Town street5
stock6	Town street6
stock7	Town street7
stock8	Town street8
stock9	Town street9
\.


--
-- TOC entry 3713 (class 0 OID 16786)
-- Dependencies: 217
-- Data for Name: stock_in_stock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stock_in_stock (zapas_id, stock_id, product_id, amount_of_product) FROM stdin;
1	stock1	product1	115
3	stock1	product01	130
4	stock1	product03	100
6	stock7	product05	100
\.


--
-- TOC entry 3732 (class 0 OID 0)
-- Dependencies: 214
-- Name: buyer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.buyer_id_seq', 208, true);


--
-- TOC entry 3733 (class 0 OID 0)
-- Dependencies: 220
-- Name: order_composition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_composition_id_seq', 7, true);


--
-- TOC entry 3734 (class 0 OID 0)
-- Dependencies: 222
-- Name: order_invoice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_invoice_id_seq', 2, true);


--
-- TOC entry 3735 (class 0 OID 0)
-- Dependencies: 218
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 7, true);


--
-- TOC entry 3736 (class 0 OID 0)
-- Dependencies: 225
-- Name: purchase_composition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purchase_composition_id_seq', 10, true);


--
-- TOC entry 3737 (class 0 OID 0)
-- Dependencies: 229
-- Name: purchase_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purchase_id_seq', 5, true);


--
-- TOC entry 3738 (class 0 OID 0)
-- Dependencies: 227
-- Name: purchase_invoice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purchase_invoice_id_seq', 4, true);


--
-- TOC entry 3739 (class 0 OID 0)
-- Dependencies: 216
-- Name: stock_in_stock_zapas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stock_in_stock_zapas_id_seq', 6, true);


--
-- TOC entry 3521 (class 2606 OID 16704)
-- Name: buyer buyer_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buyer
    ADD CONSTRAINT buyer_id UNIQUE (buyer_id);


--
-- TOC entry 3523 (class 2606 OID 16446)
-- Name: buyer buyer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buyer
    ADD CONSTRAINT buyer_pkey PRIMARY KEY (buyer_id);


--
-- TOC entry 3503 (class 2606 OID 16741)
-- Name: product cost_ed; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.product
    ADD CONSTRAINT cost_ed CHECK ((cost_ed > 0)) NOT VALID;


--
-- TOC entry 3525 (class 2606 OID 16706)
-- Name: customer customer_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_id UNIQUE (customer_id);


--
-- TOC entry 3527 (class 2606 OID 16452)
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);


--
-- TOC entry 3504 (class 2606 OID 16784)
-- Name: product ed_izm; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.product
    ADD CONSTRAINT ed_izm CHECK ((ed_izm = ANY (ARRAY['литр'::public.ed_izm, 'килограмм'::public.ed_izm, 'штука'::public.ed_izm]))) NOT VALID;


--
-- TOC entry 3545 (class 2606 OID 16837)
-- Name: order_composition id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_composition
    ADD CONSTRAINT id PRIMARY KEY (id);


--
-- TOC entry 3529 (class 2606 OID 16714)
-- Name: managers manager_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.managers
    ADD CONSTRAINT manager_id UNIQUE (manager_id);


--
-- TOC entry 3531 (class 2606 OID 16474)
-- Name: managers managers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.managers
    ADD CONSTRAINT managers_pkey PRIMARY KEY (manager_id);


--
-- TOC entry 3547 (class 2606 OID 16856)
-- Name: order_invoice order_invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_invoice
    ADD CONSTRAINT order_invoice_pkey PRIMARY KEY (id);


--
-- TOC entry 3543 (class 2606 OID 16819)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- TOC entry 3533 (class 2606 OID 16783)
-- Name: managers passport; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.managers
    ADD CONSTRAINT passport UNIQUE (passport);


--
-- TOC entry 3501 (class 2606 OID 16757)
-- Name: managers post; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.managers
    ADD CONSTRAINT post CHECK ((post = ANY (ARRAY['старший менеджер'::public.post, 'менеджер'::public.post, 'стажер'::public.post]))) NOT VALID;


--
-- TOC entry 3535 (class 2606 OID 16739)
-- Name: product product_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_id UNIQUE (product_id);


--
-- TOC entry 3537 (class 2606 OID 16494)
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (product_id);


--
-- TOC entry 3551 (class 2606 OID 16888)
-- Name: purchase_composition purchase_composition_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_composition
    ADD CONSTRAINT purchase_composition_pkey PRIMARY KEY (id);


--
-- TOC entry 3553 (class 2606 OID 16906)
-- Name: purchase_invoice purchase_invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_invoice
    ADD CONSTRAINT purchase_invoice_pkey PRIMARY KEY (id);


--
-- TOC entry 3549 (class 2606 OID 16870)
-- Name: purchase purchase_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_pkey PRIMARY KEY (purchase_id);


--
-- TOC entry 3511 (class 2606 OID 16862)
-- Name: order_invoice status; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.order_invoice
    ADD CONSTRAINT status CHECK (((status)::text = ANY ((ARRAY['оплачен'::character varying, 'не оплачен'::character varying, 'частично'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 3507 (class 2606 OID 16863)
-- Name: orders status; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.orders
    ADD CONSTRAINT status CHECK (((status)::text = ANY ((ARRAY['доставлен'::character varying, 'получен'::character varying, 'собран'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 3517 (class 2606 OID 16918)
-- Name: purchase_composition stock; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.purchase_composition
    ADD CONSTRAINT stock CHECK ((stock <= amount_of_products)) NOT VALID;


--
-- TOC entry 3539 (class 2606 OID 16765)
-- Name: stock stock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock
    ADD CONSTRAINT stock_pkey PRIMARY KEY (stock_id);


--
-- TOC entry 3541 (class 2606 OID 16791)
-- Name: stock_in_stock zapas_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_in_stock
    ADD CONSTRAINT zapas_id PRIMARY KEY (zapas_id);


--
-- TOC entry 3557 (class 2606 OID 16820)
-- Name: orders buyer_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT buyer_id FOREIGN KEY (buyer_id) REFERENCES public.buyer(buyer_id);


--
-- TOC entry 3562 (class 2606 OID 16876)
-- Name: purchase customer_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT customer_id FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id);


--
-- TOC entry 3558 (class 2606 OID 16825)
-- Name: orders manager_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT manager_id FOREIGN KEY (manager_id) REFERENCES public.managers(manager_id);


--
-- TOC entry 3563 (class 2606 OID 16871)
-- Name: purchase manager_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT manager_id FOREIGN KEY (manager_id) REFERENCES public.managers(manager_id);


--
-- TOC entry 3559 (class 2606 OID 16838)
-- Name: order_composition order_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_composition
    ADD CONSTRAINT order_id FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- TOC entry 3561 (class 2606 OID 16857)
-- Name: order_invoice order_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_invoice
    ADD CONSTRAINT order_id FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- TOC entry 3554 (class 2606 OID 16495)
-- Name: product product_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id);


--
-- TOC entry 3555 (class 2606 OID 16792)
-- Name: stock_in_stock product_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_in_stock
    ADD CONSTRAINT product_id FOREIGN KEY (product_id) REFERENCES public.product(product_id);


--
-- TOC entry 3564 (class 2606 OID 16894)
-- Name: purchase_composition product_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_composition
    ADD CONSTRAINT product_id FOREIGN KEY (product_id) REFERENCES public.product(product_id);


--
-- TOC entry 3560 (class 2606 OID 16913)
-- Name: order_composition purchase_composition_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_composition
    ADD CONSTRAINT purchase_composition_id FOREIGN KEY (purchase_composition_id) REFERENCES public.purchase_composition(id) NOT VALID;


--
-- TOC entry 3565 (class 2606 OID 16889)
-- Name: purchase_composition purchase_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_composition
    ADD CONSTRAINT purchase_id FOREIGN KEY (purchase_id) REFERENCES public.purchase(purchase_id);


--
-- TOC entry 3566 (class 2606 OID 16907)
-- Name: purchase_invoice purchase_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_invoice
    ADD CONSTRAINT purchase_id FOREIGN KEY (purchase_id) REFERENCES public.purchase(purchase_id);


--
-- TOC entry 3556 (class 2606 OID 16797)
-- Name: stock_in_stock stock_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_in_stock
    ADD CONSTRAINT stock_id FOREIGN KEY (stock_id) REFERENCES public.stock(stock_id);


-- Completed on 2023-03-27 10:45:31 MSK

--
-- PostgreSQL database dump complete
--

