--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7
-- Dumped by pg_dump version 14.7

-- Started on 2023-03-23 15:42:33

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

DROP DATABASE "Opt Base";
--
-- TOC entry 3418 (class 1262 OID 24586)
-- Name: Opt Base; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "Opt Base" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';


ALTER DATABASE "Opt Base" OWNER TO postgres;

\connect -reuse-previous=on "dbname='Opt Base'"

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
-- TOC entry 224 (class 1259 OID 25175)
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    client_id bigint NOT NULL,
    full_name character varying(40) NOT NULL,
    organization_name character varying(50) NOT NULL,
    address character varying(50) NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 25174)
-- Name: client_client_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.client ALTER COLUMN client_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.client_client_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 212 (class 1259 OID 25104)
-- Name: manager; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manager (
    manager_id bigint NOT NULL,
    full_name character varying(40) NOT NULL,
    "position" character varying(25) NOT NULL,
    contact_information character varying(20) NOT NULL
);


ALTER TABLE public.manager OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 25103)
-- Name: manager_manager_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.manager ALTER COLUMN manager_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.manager_manager_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 25145)
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    product_id bigint NOT NULL,
    product_type character varying(30) NOT NULL,
    product_name character varying(50) NOT NULL,
    unit_of_measurement_id bigint
);


ALTER TABLE public.product OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 25144)
-- Name: product_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.product ALTER COLUMN product_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 210 (class 1259 OID 25098)
-- Name: provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provider (
    provider_id bigint NOT NULL,
    name_of_company character varying(50) NOT NULL,
    full_name character varying(40) NOT NULL,
    address character varying(40) NOT NULL
);


ALTER TABLE public.provider OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 25097)
-- Name: provider_provider_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.provider ALTER COLUMN provider_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.provider_provider_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 226 (class 1259 OID 25181)
-- Name: purchase; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase (
    purchase_id bigint NOT NULL,
    client_id bigint,
    manager_id bigint,
    invoice_creation_date date,
    invoice_fulfillment_date date,
    status character varying(40),
    CONSTRAINT purchase_check CHECK ((invoice_creation_date <= invoice_fulfillment_date))
);


ALTER TABLE public.purchase OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 25208)
-- Name: purchase_content; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase_content (
    purchase_content_id bigint NOT NULL,
    purchase_id bigint,
    product_id bigint,
    amount_of_goods integer NOT NULL,
    expiration_date date NOT NULL,
    price integer NOT NULL,
    CONSTRAINT purchase_content_amount_of_goods_check CHECK ((amount_of_goods > 0)),
    CONSTRAINT purchase_content_price_check CHECK ((price > 0))
);


ALTER TABLE public.purchase_content OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 25197)
-- Name: purchase_invoice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase_invoice (
    purchase_invoice_id bigint NOT NULL,
    purchase_id bigint,
    invoice_number integer NOT NULL,
    invoice_date date NOT NULL,
    payment_date date NOT NULL,
    CONSTRAINT purchase_invoice_check CHECK ((payment_date > invoice_date))
);


ALTER TABLE public.purchase_invoice OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 25180)
-- Name: purchase_purchase_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.purchase ALTER COLUMN purchase_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.purchase_purchase_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 214 (class 1259 OID 25110)
-- Name: shipment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipment (
    shipment_id bigint NOT NULL,
    provider_id bigint,
    manager_id bigint,
    invoice_creation_date date,
    invoice_fulfillment_date date,
    status character varying(40),
    CONSTRAINT shipment_check CHECK ((invoice_creation_date <= invoice_fulfillment_date))
);


ALTER TABLE public.shipment OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 25156)
-- Name: shipment_content; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipment_content (
    shipment_content_id bigint NOT NULL,
    shipment_id bigint,
    product_id bigint,
    remains integer NOT NULL,
    amount_of_goods integer NOT NULL,
    expiration_date date NOT NULL,
    price integer NOT NULL,
    CONSTRAINT shipment_content_amount_of_goods_check CHECK ((amount_of_goods > 0)),
    CONSTRAINT shipment_content_price_check CHECK ((price >= 0)),
    CONSTRAINT shipment_content_remains_check CHECK ((remains > 0))
);


ALTER TABLE public.shipment_content OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 25155)
-- Name: shipment_content_shipment_content_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.shipment_content ALTER COLUMN shipment_content_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.shipment_content_shipment_content_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 216 (class 1259 OID 25127)
-- Name: shipment_invoice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipment_invoice (
    shipment_invoice_id bigint NOT NULL,
    shipment_id bigint,
    invoice_number integer NOT NULL,
    invoice_date date NOT NULL,
    payment_date date NOT NULL,
    CONSTRAINT shipment_invoice_check CHECK ((payment_date > invoice_date))
);


ALTER TABLE public.shipment_invoice OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 25126)
-- Name: shipment_invoice_shipment_invoice_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.shipment_invoice ALTER COLUMN shipment_invoice_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.shipment_invoice_shipment_invoice_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 213 (class 1259 OID 25109)
-- Name: shipment_shipment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.shipment ALTER COLUMN shipment_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.shipment_shipment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 25139)
-- Name: unit_of_measurement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unit_of_measurement (
    unit_of_measurement_id bigint NOT NULL,
    name character varying(20) NOT NULL
);


ALTER TABLE public.unit_of_measurement OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 25138)
-- Name: unit_of_measurement_unit_of_measurement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.unit_of_measurement ALTER COLUMN unit_of_measurement_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.unit_of_measurement_unit_of_measurement_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3408 (class 0 OID 25175)
-- Dependencies: 224
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client OVERRIDING SYSTEM VALUE VALUES (1, 'John Smith', 'ABC Corp', '123 Main St');
INSERT INTO public.client OVERRIDING SYSTEM VALUE VALUES (2, 'Jane Johnson', 'XYZ Inc', '456 Maple Ave');
INSERT INTO public.client OVERRIDING SYSTEM VALUE VALUES (3, 'Bob Brown', 'Brown Enterprises', '789 Oak St');
INSERT INTO public.client OVERRIDING SYSTEM VALUE VALUES (4, 'Sue Wilson', 'Wilson Marketing', '321 Elm St');


--
-- TOC entry 3396 (class 0 OID 25104)
-- Dependencies: 212
-- Data for Name: manager; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.manager OVERRIDING SYSTEM VALUE VALUES (1, 'John Doe', 'CEO', '555-1234');
INSERT INTO public.manager OVERRIDING SYSTEM VALUE VALUES (2, 'Jane Smith', 'CFO', '555-5678');
INSERT INTO public.manager OVERRIDING SYSTEM VALUE VALUES (3, 'Bob Johnson', 'COO', '555-9101');
INSERT INTO public.manager OVERRIDING SYSTEM VALUE VALUES (4, 'Sue Wilson', 'Marketing Director', '555-1212');


--
-- TOC entry 3404 (class 0 OID 25145)
-- Dependencies: 220
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3394 (class 0 OID 25098)
-- Dependencies: 210
-- Data for Name: provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.provider OVERRIDING SYSTEM VALUE VALUES (1, 'ABC Supplies', 'John Smith', '123 Main St');
INSERT INTO public.provider OVERRIDING SYSTEM VALUE VALUES (2, 'XYZ Inc.', 'Jane Doe', '456 Oak Ave');
INSERT INTO public.provider OVERRIDING SYSTEM VALUE VALUES (3, 'Acme Corp.', 'Bob Johnson', '789 Maple Ln');


--
-- TOC entry 3410 (class 0 OID 25181)
-- Dependencies: 226
-- Data for Name: purchase; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3412 (class 0 OID 25208)
-- Dependencies: 228
-- Data for Name: purchase_content; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3411 (class 0 OID 25197)
-- Dependencies: 227
-- Data for Name: purchase_invoice; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3398 (class 0 OID 25110)
-- Dependencies: 214
-- Data for Name: shipment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3406 (class 0 OID 25156)
-- Dependencies: 222
-- Data for Name: shipment_content; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3400 (class 0 OID 25127)
-- Dependencies: 216
-- Data for Name: shipment_invoice; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3402 (class 0 OID 25139)
-- Dependencies: 218
-- Data for Name: unit_of_measurement; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.unit_of_measurement OVERRIDING SYSTEM VALUE VALUES (1, 'kg');
INSERT INTO public.unit_of_measurement OVERRIDING SYSTEM VALUE VALUES (2, 'g');
INSERT INTO public.unit_of_measurement OVERRIDING SYSTEM VALUE VALUES (3, 'lb');
INSERT INTO public.unit_of_measurement OVERRIDING SYSTEM VALUE VALUES (4, 'oz');
INSERT INTO public.unit_of_measurement OVERRIDING SYSTEM VALUE VALUES (5, 'L');
INSERT INTO public.unit_of_measurement OVERRIDING SYSTEM VALUE VALUES (6, 'mL');
INSERT INTO public.unit_of_measurement OVERRIDING SYSTEM VALUE VALUES (7, 'gal');
INSERT INTO public.unit_of_measurement OVERRIDING SYSTEM VALUE VALUES (8, 'fl oz');


--
-- TOC entry 3419 (class 0 OID 0)
-- Dependencies: 223
-- Name: client_client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_client_id_seq', 4, true);


--
-- TOC entry 3420 (class 0 OID 0)
-- Dependencies: 211
-- Name: manager_manager_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.manager_manager_id_seq', 4, true);


--
-- TOC entry 3421 (class 0 OID 0)
-- Dependencies: 219
-- Name: product_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_product_id_seq', 1, false);


--
-- TOC entry 3422 (class 0 OID 0)
-- Dependencies: 209
-- Name: provider_provider_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.provider_provider_id_seq', 3, true);


--
-- TOC entry 3423 (class 0 OID 0)
-- Dependencies: 225
-- Name: purchase_purchase_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purchase_purchase_id_seq', 1, false);


--
-- TOC entry 3424 (class 0 OID 0)
-- Dependencies: 221
-- Name: shipment_content_shipment_content_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shipment_content_shipment_content_id_seq', 1, false);


--
-- TOC entry 3425 (class 0 OID 0)
-- Dependencies: 215
-- Name: shipment_invoice_shipment_invoice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shipment_invoice_shipment_invoice_id_seq', 1, false);


--
-- TOC entry 3426 (class 0 OID 0)
-- Dependencies: 213
-- Name: shipment_shipment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shipment_shipment_id_seq', 1, false);


--
-- TOC entry 3427 (class 0 OID 0)
-- Dependencies: 217
-- Name: unit_of_measurement_unit_of_measurement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.unit_of_measurement_unit_of_measurement_id_seq', 8, true);


--
-- TOC entry 3236 (class 2606 OID 25179)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (client_id);


--
-- TOC entry 3224 (class 2606 OID 25108)
-- Name: manager manager_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manager
    ADD CONSTRAINT manager_pkey PRIMARY KEY (manager_id);


--
-- TOC entry 3232 (class 2606 OID 25149)
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (product_id);


--
-- TOC entry 3222 (class 2606 OID 25102)
-- Name: provider provider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider
    ADD CONSTRAINT provider_pkey PRIMARY KEY (provider_id);


--
-- TOC entry 3242 (class 2606 OID 25214)
-- Name: purchase_content purchase_content_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_content
    ADD CONSTRAINT purchase_content_pkey PRIMARY KEY (purchase_content_id);


--
-- TOC entry 3240 (class 2606 OID 25202)
-- Name: purchase_invoice purchase_invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_invoice
    ADD CONSTRAINT purchase_invoice_pkey PRIMARY KEY (purchase_invoice_id);


--
-- TOC entry 3238 (class 2606 OID 25186)
-- Name: purchase purchase_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_pkey PRIMARY KEY (purchase_id);


--
-- TOC entry 3234 (class 2606 OID 25163)
-- Name: shipment_content shipment_content_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_content
    ADD CONSTRAINT shipment_content_pkey PRIMARY KEY (shipment_content_id);


--
-- TOC entry 3228 (class 2606 OID 25132)
-- Name: shipment_invoice shipment_invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_invoice
    ADD CONSTRAINT shipment_invoice_pkey PRIMARY KEY (shipment_invoice_id);


--
-- TOC entry 3226 (class 2606 OID 25115)
-- Name: shipment shipment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment
    ADD CONSTRAINT shipment_pkey PRIMARY KEY (shipment_id);


--
-- TOC entry 3230 (class 2606 OID 25143)
-- Name: unit_of_measurement unit_of_measurement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit_of_measurement
    ADD CONSTRAINT unit_of_measurement_pkey PRIMARY KEY (unit_of_measurement_id);


--
-- TOC entry 3246 (class 2606 OID 25150)
-- Name: product product_unit_of_measurement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_unit_of_measurement_id_fkey FOREIGN KEY (unit_of_measurement_id) REFERENCES public.unit_of_measurement(unit_of_measurement_id);


--
-- TOC entry 3249 (class 2606 OID 25187)
-- Name: purchase purchase_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.client(client_id);


--
-- TOC entry 3253 (class 2606 OID 25220)
-- Name: purchase_content purchase_content_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_content
    ADD CONSTRAINT purchase_content_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id);


--
-- TOC entry 3252 (class 2606 OID 25215)
-- Name: purchase_content purchase_content_purchase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_content
    ADD CONSTRAINT purchase_content_purchase_id_fkey FOREIGN KEY (purchase_id) REFERENCES public.purchase(purchase_id);


--
-- TOC entry 3251 (class 2606 OID 25203)
-- Name: purchase_invoice purchase_invoice_purchase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_invoice
    ADD CONSTRAINT purchase_invoice_purchase_id_fkey FOREIGN KEY (purchase_id) REFERENCES public.purchase(purchase_id);


--
-- TOC entry 3250 (class 2606 OID 25192)
-- Name: purchase purchase_manager_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_manager_id_fkey FOREIGN KEY (manager_id) REFERENCES public.manager(manager_id);


--
-- TOC entry 3248 (class 2606 OID 25169)
-- Name: shipment_content shipment_content_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_content
    ADD CONSTRAINT shipment_content_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id);


--
-- TOC entry 3247 (class 2606 OID 25164)
-- Name: shipment_content shipment_content_shipment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_content
    ADD CONSTRAINT shipment_content_shipment_id_fkey FOREIGN KEY (shipment_id) REFERENCES public.shipment(shipment_id);


--
-- TOC entry 3245 (class 2606 OID 25133)
-- Name: shipment_invoice shipment_invoice_shipment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_invoice
    ADD CONSTRAINT shipment_invoice_shipment_id_fkey FOREIGN KEY (shipment_id) REFERENCES public.shipment(shipment_id);


--
-- TOC entry 3244 (class 2606 OID 25121)
-- Name: shipment shipment_manager_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment
    ADD CONSTRAINT shipment_manager_id_fkey FOREIGN KEY (manager_id) REFERENCES public.manager(manager_id);


--
-- TOC entry 3243 (class 2606 OID 25116)
-- Name: shipment shipment_provider_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment
    ADD CONSTRAINT shipment_provider_id_fkey FOREIGN KEY (provider_id) REFERENCES public.provider(provider_id);


-- Completed on 2023-03-23 15:42:33

--
-- PostgreSQL database dump complete
--

