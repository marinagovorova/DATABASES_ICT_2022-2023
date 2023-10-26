--
-- PostgreSQL database dump
--

-- Dumped from database version 11.21
-- Dumped by pg_dump version 11.21

-- Started on 2023-09-22 00:14:24

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
-- TOC entry 8 (class 2615 OID 16401)
-- Name: publishing_office_scheme; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA publishing_office_scheme;


ALTER SCHEMA publishing_office_scheme OWNER TO postgres;

--
-- TOC entry 1 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 2885 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 198 (class 1259 OID 16552)
-- Name: author; Type: TABLE; Schema: publishing_office_scheme; Owner: postgres
--

CREATE TABLE publishing_office_scheme.author (
    author_id integer NOT NULL,
    email character varying(40) NOT NULL,
    first_name character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    patronymic_name character varying(20)
);


ALTER TABLE publishing_office_scheme.author OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 16559)
-- Name: book; Type: TABLE; Schema: publishing_office_scheme; Owner: postgres
--

CREATE TABLE publishing_office_scheme.book (
    book_id integer NOT NULL,
    pages_count integer NOT NULL,
    category_id integer NOT NULL,
    publication_year date NOT NULL,
    name character varying(20) NOT NULL
);


ALTER TABLE publishing_office_scheme.book OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16576)
-- Name: book_author; Type: TABLE; Schema: publishing_office_scheme; Owner: postgres
--

CREATE TABLE publishing_office_scheme.book_author (
    book_id integer NOT NULL,
    author_id integer NOT NULL,
    email character varying(40) NOT NULL,
    author_index integer NOT NULL,
    id integer NOT NULL
);


ALTER TABLE publishing_office_scheme.book_author OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 16547)
-- Name: book_category; Type: TABLE; Schema: publishing_office_scheme; Owner: postgres
--

CREATE TABLE publishing_office_scheme.book_category (
    category_id integer NOT NULL,
    name character varying(20) NOT NULL
);


ALTER TABLE publishing_office_scheme.book_category OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16564)
-- Name: circulation; Type: TABLE; Schema: publishing_office_scheme; Owner: postgres
--

CREATE TABLE publishing_office_scheme.circulation (
    circulation_id integer NOT NULL,
    task_id integer NOT NULL,
    book_id integer NOT NULL,
    "ISBN" character varying(17) NOT NULL,
    price integer,
    type character varying(20) NOT NULL,
    date date NOT NULL
);


ALTER TABLE publishing_office_scheme.circulation OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16588)
-- Name: customer; Type: TABLE; Schema: publishing_office_scheme; Owner: postgres
--

CREATE TABLE publishing_office_scheme.customer (
    customer_id integer NOT NULL,
    phone_number character varying(14) NOT NULL,
    address character varying(40) NOT NULL,
    first_name character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    patronymic_name character varying(20)
);


ALTER TABLE publishing_office_scheme.customer OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16581)
-- Name: order; Type: TABLE; Schema: publishing_office_scheme; Owner: postgres
--

CREATE TABLE publishing_office_scheme."order" (
    order_id integer NOT NULL,
    customer_id integer NOT NULL,
    phone_number character varying(14) NOT NULL,
    task_id integer NOT NULL,
    book_id integer NOT NULL,
    "ISBN" character varying(17) NOT NULL,
    job_status character varying(11) DEFAULT 'в обработке'::character varying NOT NULL,
    payment_status character varying(14) DEFAULT 'ожидает оплаты'::character varying NOT NULL,
    deadline date,
    order_date date NOT NULL
);


ALTER TABLE publishing_office_scheme."order" OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 16569)
-- Name: technical_task; Type: TABLE; Schema: publishing_office_scheme; Owner: postgres
--

CREATE TABLE publishing_office_scheme.technical_task (
    task_id integer NOT NULL,
    book_id integer NOT NULL,
    copies_number integer NOT NULL,
    is_illustration boolean NOT NULL,
    "ISBN" character varying(17) NOT NULL,
    binding_type character varying(20) NOT NULL
);


ALTER TABLE publishing_office_scheme.technical_task OWNER TO postgres;

--
-- TOC entry 2873 (class 0 OID 16552)
-- Dependencies: 198
-- Data for Name: author; Type: TABLE DATA; Schema: publishing_office_scheme; Owner: postgres
--

COPY publishing_office_scheme.author (author_id, email, first_name, last_name, patronymic_name) FROM stdin;
1	antony@example.com	Anton	Ivanov	Sergeevich
2	marina@example.com	Marina	Petrova	Alexandrovna
3	bob23@example.com	Bob	Smith	Miller
4	alicejohnson@example.com	Alice	Johnson	Brown
5	alexandro@example.com	Alexandro	Doe	Clark
6	mihail@example.com	Mihail	Sokolov	Petrovich
\.


--
-- TOC entry 2874 (class 0 OID 16559)
-- Dependencies: 199
-- Data for Name: book; Type: TABLE DATA; Schema: publishing_office_scheme; Owner: postgres
--

COPY publishing_office_scheme.book (book_id, pages_count, category_id, publication_year, name) FROM stdin;
11	512	1	2018-01-01	The Outsider
12	320	2	2017-01-01	Exit West
13	448	3	2020-01-01	American Dirt
14	384	4	2021-01-01	The Midnight Library
15	256	5	2019-01-01	The Great Gatsby
\.


--
-- TOC entry 2877 (class 0 OID 16576)
-- Dependencies: 202
-- Data for Name: book_author; Type: TABLE DATA; Schema: publishing_office_scheme; Owner: postgres
--

COPY publishing_office_scheme.book_author (book_id, author_id, email, author_index, id) FROM stdin;
11	3	bob23@example.com	1	6
12	1	antony@example.com	2	7
13	2	marina@example.com	3	8
14	5	alexandro@example.com	4	9
15	4	alicejohnson@example.com	5	10
\.


--
-- TOC entry 2872 (class 0 OID 16547)
-- Dependencies: 197
-- Data for Name: book_category; Type: TABLE DATA; Schema: publishing_office_scheme; Owner: postgres
--

COPY publishing_office_scheme.book_category (category_id, name) FROM stdin;
1	Drama
2	Science-fiction
3	Horror
4	Fantasy
5	Detective
\.


--
-- TOC entry 2875 (class 0 OID 16564)
-- Dependencies: 200
-- Data for Name: circulation; Type: TABLE DATA; Schema: publishing_office_scheme; Owner: postgres
--

COPY publishing_office_scheme.circulation (circulation_id, task_id, book_id, "ISBN", price, type, date) FROM stdin;
1	2	11	978-0-06-269601-9	1990	book	2023-09-01
2	4	13	978-3-16-148410-0	699	journal	2023-09-02
\.


--
-- TOC entry 2879 (class 0 OID 16588)
-- Dependencies: 204
-- Data for Name: customer; Type: TABLE DATA; Schema: publishing_office_scheme; Owner: postgres
--

COPY publishing_office_scheme.customer (customer_id, phone_number, address, first_name, last_name, patronymic_name) FROM stdin;
1	+15555551212	123 Main St, Anytown, USA	Alice	Doe	Smith
2	+15551112222	321 Oak St, Anytown, USA	Bob	Lee	Johnson
3	+14155552671	456 High St, Anytown, UK	Jane	Jones	Williams
4	+81312345678	321 Oak St, Anytown, Japan	Taro	Smith	Brown
5	+61298765432	789 Elm St, Anytown, USA	Sarah	Tanaka	Smith
\.


--
-- TOC entry 2878 (class 0 OID 16581)
-- Dependencies: 203
-- Data for Name: order; Type: TABLE DATA; Schema: publishing_office_scheme; Owner: postgres
--

COPY publishing_office_scheme."order" (order_id, customer_id, phone_number, task_id, book_id, "ISBN", job_status, payment_status, deadline, order_date) FROM stdin;
1	1	+15555551212	1	11	978-0-06-269601-9	in process	paid	2023-09-01	2023-10-01
2	3	+14155552671	3	13	978-3-16-148410-0	done	Smith	2023-09-02	2023-10-02
\.


--
-- TOC entry 2876 (class 0 OID 16569)
-- Dependencies: 201
-- Data for Name: technical_task; Type: TABLE DATA; Schema: publishing_office_scheme; Owner: postgres
--

COPY publishing_office_scheme.technical_task (task_id, book_id, copies_number, is_illustration, "ISBN", binding_type) FROM stdin;
1	11	200	t	978-0-06-269601-9	hard
2	12	2000	t	978-0-14-312656-0	soft
3	13	3000	f	978-3-16-148410-0	kbs
4	14	100	f	978-0-241-29752-8	hard
\.


--
-- TOC entry 2719 (class 2606 OID 16558)
-- Name: author author_email_key; Type: CONSTRAINT; Schema: publishing_office_scheme; Owner: postgres
--

ALTER TABLE ONLY publishing_office_scheme.author
    ADD CONSTRAINT author_email_key UNIQUE (email);


--
-- TOC entry 2712 (class 2606 OID 16785)
-- Name: book_author author_index; Type: CHECK CONSTRAINT; Schema: publishing_office_scheme; Owner: postgres
--

ALTER TABLE publishing_office_scheme.book_author
    ADD CONSTRAINT author_index CHECK ((author_index >= 0)) NOT VALID;


--
-- TOC entry 2721 (class 2606 OID 16556)
-- Name: author author_pkey; Type: CONSTRAINT; Schema: publishing_office_scheme; Owner: postgres
--

ALTER TABLE ONLY publishing_office_scheme.author
    ADD CONSTRAINT author_pkey PRIMARY KEY (author_id);


--
-- TOC entry 2731 (class 2606 OID 16580)
-- Name: book_author book_author_pkey; Type: CONSTRAINT; Schema: publishing_office_scheme; Owner: postgres
--

ALTER TABLE ONLY publishing_office_scheme.book_author
    ADD CONSTRAINT book_author_pkey PRIMARY KEY (id);


--
-- TOC entry 2717 (class 2606 OID 16551)
-- Name: book_category book_category_pkey; Type: CONSTRAINT; Schema: publishing_office_scheme; Owner: postgres
--

ALTER TABLE ONLY publishing_office_scheme.book_category
    ADD CONSTRAINT book_category_pkey PRIMARY KEY (category_id);


--
-- TOC entry 2723 (class 2606 OID 16563)
-- Name: book book_pkey; Type: CONSTRAINT; Schema: publishing_office_scheme; Owner: postgres
--

ALTER TABLE ONLY publishing_office_scheme.book
    ADD CONSTRAINT book_pkey PRIMARY KEY (book_id);


--
-- TOC entry 2725 (class 2606 OID 16568)
-- Name: circulation circulation_pkey; Type: CONSTRAINT; Schema: publishing_office_scheme; Owner: postgres
--

ALTER TABLE ONLY publishing_office_scheme.circulation
    ADD CONSTRAINT circulation_pkey PRIMARY KEY (circulation_id);


--
-- TOC entry 2735 (class 2606 OID 16594)
-- Name: customer customer_phone_number_key; Type: CONSTRAINT; Schema: publishing_office_scheme; Owner: postgres
--

ALTER TABLE ONLY publishing_office_scheme.customer
    ADD CONSTRAINT customer_phone_number_key UNIQUE (phone_number);


--
-- TOC entry 2737 (class 2606 OID 16592)
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: publishing_office_scheme; Owner: postgres
--

ALTER TABLE ONLY publishing_office_scheme.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);


--
-- TOC entry 2715 (class 2606 OID 16786)
-- Name: order job_status; Type: CHECK CONSTRAINT; Schema: publishing_office_scheme; Owner: postgres
--

ALTER TABLE publishing_office_scheme."order"
    ADD CONSTRAINT job_status CHECK (((job_status)::text = ANY (ARRAY[('in process'::character varying)::text, ('done'::character varying)::text]))) NOT VALID;


--
-- TOC entry 2733 (class 2606 OID 16587)
-- Name: order order_pkey; Type: CONSTRAINT; Schema: publishing_office_scheme; Owner: postgres
--

ALTER TABLE ONLY publishing_office_scheme."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (order_id);


--
-- TOC entry 2727 (class 2606 OID 16575)
-- Name: technical_task technical_task_ISBN_key; Type: CONSTRAINT; Schema: publishing_office_scheme; Owner: postgres
--

ALTER TABLE ONLY publishing_office_scheme.technical_task
    ADD CONSTRAINT "technical_task_ISBN_key" UNIQUE ("ISBN");


--
-- TOC entry 2729 (class 2606 OID 16573)
-- Name: technical_task technical_task_pkey; Type: CONSTRAINT; Schema: publishing_office_scheme; Owner: postgres
--

ALTER TABLE ONLY publishing_office_scheme.technical_task
    ADD CONSTRAINT technical_task_pkey PRIMARY KEY (task_id);


--
-- TOC entry 2739 (class 2606 OID 16615)
-- Name: circulation ISBN; Type: FK CONSTRAINT; Schema: publishing_office_scheme; Owner: postgres
--

ALTER TABLE ONLY publishing_office_scheme.circulation
    ADD CONSTRAINT "ISBN" FOREIGN KEY ("ISBN") REFERENCES publishing_office_scheme.technical_task("ISBN") NOT VALID;


--
-- TOC entry 2746 (class 2606 OID 16620)
-- Name: order ISBN; Type: FK CONSTRAINT; Schema: publishing_office_scheme; Owner: postgres
--

ALTER TABLE ONLY publishing_office_scheme."order"
    ADD CONSTRAINT "ISBN" FOREIGN KEY ("ISBN") REFERENCES publishing_office_scheme.technical_task("ISBN") NOT VALID;


--
-- TOC entry 2744 (class 2606 OID 16605)
-- Name: book_author author_id; Type: FK CONSTRAINT; Schema: publishing_office_scheme; Owner: postgres
--

ALTER TABLE ONLY publishing_office_scheme.book_author
    ADD CONSTRAINT author_id FOREIGN KEY (author_id) REFERENCES publishing_office_scheme.author(author_id) NOT VALID;


--
-- TOC entry 2743 (class 2606 OID 16600)
-- Name: book_author book_id; Type: FK CONSTRAINT; Schema: publishing_office_scheme; Owner: postgres
--

ALTER TABLE ONLY publishing_office_scheme.book_author
    ADD CONSTRAINT book_id FOREIGN KEY (book_id) REFERENCES publishing_office_scheme.book(book_id) NOT VALID;


--
-- TOC entry 2742 (class 2606 OID 16625)
-- Name: technical_task book_id; Type: FK CONSTRAINT; Schema: publishing_office_scheme; Owner: postgres
--

ALTER TABLE ONLY publishing_office_scheme.technical_task
    ADD CONSTRAINT book_id FOREIGN KEY (book_id) REFERENCES publishing_office_scheme.book(book_id);


--
-- TOC entry 2740 (class 2606 OID 16630)
-- Name: circulation book_id; Type: FK CONSTRAINT; Schema: publishing_office_scheme; Owner: postgres
--

ALTER TABLE ONLY publishing_office_scheme.circulation
    ADD CONSTRAINT book_id FOREIGN KEY (book_id) REFERENCES publishing_office_scheme.book(book_id) NOT VALID;


--
-- TOC entry 2747 (class 2606 OID 16635)
-- Name: order book_id; Type: FK CONSTRAINT; Schema: publishing_office_scheme; Owner: postgres
--

ALTER TABLE ONLY publishing_office_scheme."order"
    ADD CONSTRAINT book_id FOREIGN KEY (book_id) REFERENCES publishing_office_scheme.book(book_id) NOT VALID;


--
-- TOC entry 2738 (class 2606 OID 16595)
-- Name: book category_id; Type: FK CONSTRAINT; Schema: publishing_office_scheme; Owner: postgres
--

ALTER TABLE ONLY publishing_office_scheme.book
    ADD CONSTRAINT category_id FOREIGN KEY (category_id) REFERENCES publishing_office_scheme.book_category(category_id) NOT VALID;


--
-- TOC entry 2748 (class 2606 OID 16640)
-- Name: order customer_id; Type: FK CONSTRAINT; Schema: publishing_office_scheme; Owner: postgres
--

ALTER TABLE ONLY publishing_office_scheme."order"
    ADD CONSTRAINT customer_id FOREIGN KEY (customer_id) REFERENCES publishing_office_scheme.customer(customer_id) NOT VALID;


--
-- TOC entry 2745 (class 2606 OID 16610)
-- Name: book_author email; Type: FK CONSTRAINT; Schema: publishing_office_scheme; Owner: postgres
--

ALTER TABLE ONLY publishing_office_scheme.book_author
    ADD CONSTRAINT email FOREIGN KEY (email) REFERENCES publishing_office_scheme.author(email) NOT VALID;


--
-- TOC entry 2749 (class 2606 OID 16645)
-- Name: order phone_number; Type: FK CONSTRAINT; Schema: publishing_office_scheme; Owner: postgres
--

ALTER TABLE ONLY publishing_office_scheme."order"
    ADD CONSTRAINT phone_number FOREIGN KEY (phone_number) REFERENCES publishing_office_scheme.customer(phone_number) NOT VALID;


--
-- TOC entry 2741 (class 2606 OID 16650)
-- Name: circulation task_id; Type: FK CONSTRAINT; Schema: publishing_office_scheme; Owner: postgres
--

ALTER TABLE ONLY publishing_office_scheme.circulation
    ADD CONSTRAINT task_id FOREIGN KEY (task_id) REFERENCES publishing_office_scheme.technical_task(task_id) NOT VALID;


--
-- TOC entry 2750 (class 2606 OID 16655)
-- Name: order task_id; Type: FK CONSTRAINT; Schema: publishing_office_scheme; Owner: postgres
--

ALTER TABLE ONLY publishing_office_scheme."order"
    ADD CONSTRAINT task_id FOREIGN KEY (task_id) REFERENCES publishing_office_scheme.technical_task(task_id) NOT VALID;


-- Completed on 2023-09-22 00:14:24

--
-- PostgreSQL database dump complete
--

