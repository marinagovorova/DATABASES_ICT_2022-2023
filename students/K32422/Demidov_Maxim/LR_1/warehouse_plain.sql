--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7
-- Dumped by pg_dump version 14.7

-- Started on 2023-05-14 12:10:44

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
-- TOC entry 5 (class 2615 OID 16698)
-- Name: warehouse; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA warehouse;


ALTER SCHEMA warehouse OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 16699)
-- Name: buyer_company; Type: TABLE; Schema: warehouse; Owner: postgres
--

CREATE TABLE warehouse.buyer_company (
    organization_code integer NOT NULL,
    company_name character varying(30) NOT NULL,
    buyer_company_address character varying(100) NOT NULL
);


ALTER TABLE warehouse.buyer_company OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16702)
-- Name: item; Type: TABLE; Schema: warehouse; Owner: postgres
--

CREATE TABLE warehouse.item (
    item_code integer NOT NULL,
    item_type character varying(30) NOT NULL,
    unit_measurement character varying(10) NOT NULL,
    expiration_date date NOT NULL,
    name character varying(30) NOT NULL,
    description character varying(200) NOT NULL,
    CONSTRAINT expiration_check CHECK (((expiration_date > '2000-01-01'::date) AND (expiration_date < '2030-12-31'::date)))
);


ALTER TABLE warehouse.item OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16706)
-- Name: manager; Type: TABLE; Schema: warehouse; Owner: postgres
--

CREATE TABLE warehouse.manager (
    employee_code integer NOT NULL,
    service_number integer NOT NULL,
    "position" character varying(15) NOT NULL,
    passport_data bigint NOT NULL
);


ALTER TABLE warehouse.manager OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16709)
-- Name: purchase_item; Type: TABLE; Schema: warehouse; Owner: postgres
--

CREATE TABLE warehouse.purchase_item (
    shipping_code integer NOT NULL,
    item integer NOT NULL,
    purchase_price integer NOT NULL,
    item_quantity integer NOT NULL,
    purchase_item integer NOT NULL,
    CONSTRAINT quantity_check CHECK ((item_quantity > 0))
);


ALTER TABLE warehouse.purchase_item OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16713)
-- Name: sale; Type: TABLE; Schema: warehouse; Owner: postgres
--

CREATE TABLE warehouse.sale (
    lot_number integer NOT NULL,
    employee_code integer NOT NULL,
    organization_code integer NOT NULL,
    export_date date NOT NULL,
    order_date date NOT NULL,
    CONSTRAINT export_check CHECK (((export_date > '2000-01-01'::date) AND (export_date < '2030-12-31'::date))),
    CONSTRAINT order_check CHECK (((order_date > '2000-01-01'::date) AND (order_date < '2030-12-31'::date)))
);


ALTER TABLE warehouse.sale OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16718)
-- Name: sales_item; Type: TABLE; Schema: warehouse; Owner: postgres
--

CREATE TABLE warehouse.sales_item (
    sales_code integer NOT NULL,
    delivered_item integer NOT NULL,
    price_for_sale integer NOT NULL,
    product_quantity integer NOT NULL
);


ALTER TABLE warehouse.sales_item OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16721)
-- Name: shipping; Type: TABLE; Schema: warehouse; Owner: postgres
--

CREATE TABLE warehouse.shipping (
    shipping_code integer NOT NULL,
    employee_code integer NOT NULL,
    supplier_code integer NOT NULL,
    delivery_date date NOT NULL,
    CONSTRAINT delivery_check CHECK (((delivery_date > '2000-01-01'::date) AND (delivery_date < '2030-12-31'::date)))
);


ALTER TABLE warehouse.shipping OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16725)
-- Name: storage; Type: TABLE; Schema: warehouse; Owner: postgres
--

CREATE TABLE warehouse.storage (
    storage_code integer NOT NULL,
    item_residue integer NOT NULL,
    location character varying(100) NOT NULL,
    item_code integer NOT NULL,
    purchase_item integer NOT NULL,
    delivered_item integer NOT NULL
);


ALTER TABLE warehouse.storage OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16728)
-- Name: supplier_company; Type: TABLE; Schema: warehouse; Owner: postgres
--

CREATE TABLE warehouse.supplier_company (
    supplier_code integer NOT NULL,
    supplier_account_number integer NOT NULL,
    supplier_company_name character varying(30) NOT NULL,
    supplier_address character varying(100) NOT NULL
);


ALTER TABLE warehouse.supplier_company OWNER TO postgres;

--
-- TOC entry 3380 (class 0 OID 16699)
-- Dependencies: 210
-- Data for Name: buyer_company; Type: TABLE DATA; Schema: warehouse; Owner: postgres
--

COPY warehouse.buyer_company (organization_code, company_name, buyer_company_address) FROM stdin;
137421	ShopSmart	Russia, Saint-Petersburg, Khudozhnikov 34, 194352
749274	BuyBetter	Russia, Moscow, Malaya Polyanka 8, 119180
589329	Value Ventures	Russia, Republic of Crimea, Sevastopol, Gogolya 21, 299011
\.


--
-- TOC entry 3381 (class 0 OID 16702)
-- Dependencies: 211
-- Data for Name: item; Type: TABLE DATA; Schema: warehouse; Owner: postgres
--

COPY warehouse.item (item_code, item_type, unit_measurement, expiration_date, name, description) FROM stdin;
992649	Canned fish	Grams	2026-09-23	Tuna chunks	Canned fish in its own juice, made from gutted tuna with the addition of black pepper.
292462	Confectionery products	Grams	2023-05-15	Napoleon Cake	Napoleon cake is a perfect combination of thin layers of crispy puff pastry and delicate cream based on butter and condensed milk.
332074	Fresh vegetables	Kilos	2023-04-17	Tomatoes	Kuban pink tomatoes.
\.


--
-- TOC entry 3382 (class 0 OID 16706)
-- Dependencies: 212
-- Data for Name: manager; Type: TABLE DATA; Schema: warehouse; Owner: postgres
--

COPY warehouse.manager (employee_code, service_number, "position", passport_data) FROM stdin;
927943	3294	Storekeeper	4382091728
309128	8403	Janiator	7632908345
283244	9234	Guard	9144894309
\.


--
-- TOC entry 3383 (class 0 OID 16709)
-- Dependencies: 213
-- Data for Name: purchase_item; Type: TABLE DATA; Schema: warehouse; Owner: postgres
--

COPY warehouse.purchase_item (shipping_code, item, purchase_price, item_quantity, purchase_item) FROM stdin;
848203	992649	50	592	489223
840321	292462	120	354	327233
302832	332074	30	768	958928
\.


--
-- TOC entry 3384 (class 0 OID 16713)
-- Dependencies: 214
-- Data for Name: sale; Type: TABLE DATA; Schema: warehouse; Owner: postgres
--

COPY warehouse.sale (lot_number, employee_code, organization_code, export_date, order_date) FROM stdin;
427492	927943	137421	2021-07-07	2021-06-01
471224	309128	749274	2022-12-14	2022-11-08
830132	283244	589329	2023-02-14	2023-01-22
\.


--
-- TOC entry 3385 (class 0 OID 16718)
-- Dependencies: 215
-- Data for Name: sales_item; Type: TABLE DATA; Schema: warehouse; Owner: postgres
--

COPY warehouse.sales_item (sales_code, delivered_item, price_for_sale, product_quantity) FROM stdin;
427492	249231	35	60
471224	465232	54	240
830132	554532	143	80
\.


--
-- TOC entry 3386 (class 0 OID 16721)
-- Dependencies: 216
-- Data for Name: shipping; Type: TABLE DATA; Schema: warehouse; Owner: postgres
--

COPY warehouse.shipping (shipping_code, employee_code, supplier_code, delivery_date) FROM stdin;
848203	927943	592342	2022-01-21
840321	309128	432435	2021-08-03
302832	283244	325541	2023-02-15
\.


--
-- TOC entry 3387 (class 0 OID 16725)
-- Dependencies: 217
-- Data for Name: storage; Type: TABLE DATA; Schema: warehouse; Owner: postgres
--

COPY warehouse.storage (storage_code, item_residue, location, item_code, purchase_item, delivered_item) FROM stdin;
111111	35	Russia, Rostov-on-Don, Zorge 52, 344103	992649	489223	249231
222222	4356	Russia, Yamalo-Nenets Autonomous okrug (YANAO), Novy Urengoj, Promyslovaya 2, 629306	292462	327233	465232
333333	12	Russia, Khanty-Mansi Autonomous Okrug (Yugra), Surgut, Universitetskaya 9, 628403	332074	958928	554532
\.


--
-- TOC entry 3388 (class 0 OID 16728)
-- Dependencies: 218
-- Data for Name: supplier_company; Type: TABLE DATA; Schema: warehouse; Owner: postgres
--

COPY warehouse.supplier_company (supplier_code, supplier_account_number, supplier_company_name, supplier_address) FROM stdin;
592342	982332	SupplyPro	Russia, Moscow, Tverskaya 14, 125009
432435	632427	Elite Imports	Russia, Rostov-on-Don, Zorge 52, 344103
325541	834132	Premier Products	Russia, Tula, Mosina 27, 300041
\.


--
-- TOC entry 3202 (class 2606 OID 16732)
-- Name: buyer_company buyer_company_pkey; Type: CONSTRAINT; Schema: warehouse; Owner: postgres
--

ALTER TABLE ONLY warehouse.buyer_company
    ADD CONSTRAINT buyer_company_pkey PRIMARY KEY (organization_code);


--
-- TOC entry 3206 (class 2606 OID 16734)
-- Name: item item_pkey; Type: CONSTRAINT; Schema: warehouse; Owner: postgres
--

ALTER TABLE ONLY warehouse.item
    ADD CONSTRAINT item_pkey PRIMARY KEY (item_code);


--
-- TOC entry 3210 (class 2606 OID 16736)
-- Name: manager manager_pkey; Type: CONSTRAINT; Schema: warehouse; Owner: postgres
--

ALTER TABLE ONLY warehouse.manager
    ADD CONSTRAINT manager_pkey PRIMARY KEY (employee_code);


--
-- TOC entry 3214 (class 2606 OID 16831)
-- Name: purchase_item purchase_item_pkey; Type: CONSTRAINT; Schema: warehouse; Owner: postgres
--

ALTER TABLE ONLY warehouse.purchase_item
    ADD CONSTRAINT purchase_item_pkey PRIMARY KEY (purchase_item);


--
-- TOC entry 3216 (class 2606 OID 16738)
-- Name: sale sale_pkey; Type: CONSTRAINT; Schema: warehouse; Owner: postgres
--

ALTER TABLE ONLY warehouse.sale
    ADD CONSTRAINT sale_pkey PRIMARY KEY (lot_number);


--
-- TOC entry 3218 (class 2606 OID 16838)
-- Name: sales_item sales_item_pkey; Type: CONSTRAINT; Schema: warehouse; Owner: postgres
--

ALTER TABLE ONLY warehouse.sales_item
    ADD CONSTRAINT sales_item_pkey PRIMARY KEY (delivered_item);


--
-- TOC entry 3220 (class 2606 OID 16740)
-- Name: shipping shipping_pkey; Type: CONSTRAINT; Schema: warehouse; Owner: postgres
--

ALTER TABLE ONLY warehouse.shipping
    ADD CONSTRAINT shipping_pkey PRIMARY KEY (shipping_code);


--
-- TOC entry 3224 (class 2606 OID 16742)
-- Name: storage storage_pkey; Type: CONSTRAINT; Schema: warehouse; Owner: postgres
--

ALTER TABLE ONLY warehouse.storage
    ADD CONSTRAINT storage_pkey PRIMARY KEY (storage_code);


--
-- TOC entry 3228 (class 2606 OID 16744)
-- Name: supplier_company supplier_company_pkey; Type: CONSTRAINT; Schema: warehouse; Owner: postgres
--

ALTER TABLE ONLY warehouse.supplier_company
    ADD CONSTRAINT supplier_company_pkey PRIMARY KEY (supplier_code);


--
-- TOC entry 3204 (class 2606 OID 16746)
-- Name: buyer_company unique_buyer; Type: CONSTRAINT; Schema: warehouse; Owner: postgres
--

ALTER TABLE ONLY warehouse.buyer_company
    ADD CONSTRAINT unique_buyer UNIQUE (organization_code);


--
-- TOC entry 3208 (class 2606 OID 16748)
-- Name: item unique_item; Type: CONSTRAINT; Schema: warehouse; Owner: postgres
--

ALTER TABLE ONLY warehouse.item
    ADD CONSTRAINT unique_item UNIQUE (item_code);


--
-- TOC entry 3212 (class 2606 OID 16750)
-- Name: manager unique_manager; Type: CONSTRAINT; Schema: warehouse; Owner: postgres
--

ALTER TABLE ONLY warehouse.manager
    ADD CONSTRAINT unique_manager UNIQUE (employee_code);


--
-- TOC entry 3222 (class 2606 OID 16752)
-- Name: shipping unique_shipping; Type: CONSTRAINT; Schema: warehouse; Owner: postgres
--

ALTER TABLE ONLY warehouse.shipping
    ADD CONSTRAINT unique_shipping UNIQUE (shipping_code);


--
-- TOC entry 3226 (class 2606 OID 16754)
-- Name: storage unique_storage; Type: CONSTRAINT; Schema: warehouse; Owner: postgres
--

ALTER TABLE ONLY warehouse.storage
    ADD CONSTRAINT unique_storage UNIQUE (storage_code);


--
-- TOC entry 3230 (class 2606 OID 16756)
-- Name: supplier_company unique_supplier; Type: CONSTRAINT; Schema: warehouse; Owner: postgres
--

ALTER TABLE ONLY warehouse.supplier_company
    ADD CONSTRAINT unique_supplier UNIQUE (supplier_code);


--
-- TOC entry 3233 (class 2606 OID 16757)
-- Name: sale fk_buyer; Type: FK CONSTRAINT; Schema: warehouse; Owner: postgres
--

ALTER TABLE ONLY warehouse.sale
    ADD CONSTRAINT fk_buyer FOREIGN KEY (organization_code) REFERENCES warehouse.buyer_company(organization_code) NOT VALID;


--
-- TOC entry 3231 (class 2606 OID 16762)
-- Name: purchase_item fk_item; Type: FK CONSTRAINT; Schema: warehouse; Owner: postgres
--

ALTER TABLE ONLY warehouse.purchase_item
    ADD CONSTRAINT fk_item FOREIGN KEY (item) REFERENCES warehouse.item(item_code) NOT VALID;


--
-- TOC entry 3238 (class 2606 OID 16823)
-- Name: storage fk_item; Type: FK CONSTRAINT; Schema: warehouse; Owner: postgres
--

ALTER TABLE ONLY warehouse.storage
    ADD CONSTRAINT fk_item FOREIGN KEY (item_code) REFERENCES warehouse.item(item_code) NOT VALID;


--
-- TOC entry 3236 (class 2606 OID 16767)
-- Name: shipping fk_manager; Type: FK CONSTRAINT; Schema: warehouse; Owner: postgres
--

ALTER TABLE ONLY warehouse.shipping
    ADD CONSTRAINT fk_manager FOREIGN KEY (employee_code) REFERENCES warehouse.manager(employee_code) NOT VALID;


--
-- TOC entry 3234 (class 2606 OID 16772)
-- Name: sale fk_manager; Type: FK CONSTRAINT; Schema: warehouse; Owner: postgres
--

ALTER TABLE ONLY warehouse.sale
    ADD CONSTRAINT fk_manager FOREIGN KEY (employee_code) REFERENCES warehouse.manager(employee_code) NOT VALID;


--
-- TOC entry 3239 (class 2606 OID 16832)
-- Name: storage fk_purchase; Type: FK CONSTRAINT; Schema: warehouse; Owner: postgres
--

ALTER TABLE ONLY warehouse.storage
    ADD CONSTRAINT fk_purchase FOREIGN KEY (purchase_item) REFERENCES warehouse.purchase_item(purchase_item) NOT VALID;


--
-- TOC entry 3235 (class 2606 OID 16777)
-- Name: sales_item fk_sale; Type: FK CONSTRAINT; Schema: warehouse; Owner: postgres
--

ALTER TABLE ONLY warehouse.sales_item
    ADD CONSTRAINT fk_sale FOREIGN KEY (sales_code) REFERENCES warehouse.sale(lot_number) NOT VALID;


--
-- TOC entry 3240 (class 2606 OID 16839)
-- Name: storage fk_sales; Type: FK CONSTRAINT; Schema: warehouse; Owner: postgres
--

ALTER TABLE ONLY warehouse.storage
    ADD CONSTRAINT fk_sales FOREIGN KEY (delivered_item) REFERENCES warehouse.sales_item(delivered_item) NOT VALID;


--
-- TOC entry 3232 (class 2606 OID 16782)
-- Name: purchase_item fk_shipping; Type: FK CONSTRAINT; Schema: warehouse; Owner: postgres
--

ALTER TABLE ONLY warehouse.purchase_item
    ADD CONSTRAINT fk_shipping FOREIGN KEY (shipping_code) REFERENCES warehouse.shipping(shipping_code) NOT VALID;


--
-- TOC entry 3237 (class 2606 OID 16787)
-- Name: shipping fk_supplier; Type: FK CONSTRAINT; Schema: warehouse; Owner: postgres
--

ALTER TABLE ONLY warehouse.shipping
    ADD CONSTRAINT fk_supplier FOREIGN KEY (supplier_code) REFERENCES warehouse.supplier_company(supplier_code) NOT VALID;


-- Completed on 2023-05-14 12:10:44

--
-- PostgreSQL database dump complete
--

