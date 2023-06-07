--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7
-- Dumped by pg_dump version 14.7

-- Started on 2023-03-23 14:39:26 MSK

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
-- TOC entry 6 (class 2615 OID 16395)
-- Name: schema_hotel; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA schema_hotel;


ALTER SCHEMA schema_hotel OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 16443)
-- Name: cleaning; Type: TABLE; Schema: schema_hotel; Owner: postgres
--

CREATE TABLE schema_hotel.cleaning (
    id_cleaning integer NOT NULL,
    date_clean date NOT NULL,
    status_clean text NOT NULL,
    id_employee integer NOT NULL,
    id_room integer NOT NULL
);


ALTER TABLE schema_hotel.cleaning OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16442)
-- Name: Cleaning_id_cleaning_seq; Type: SEQUENCE; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE schema_hotel.cleaning ALTER COLUMN id_cleaning ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME schema_hotel."Cleaning_id_cleaning_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 211 (class 1259 OID 16398)
-- Name: client; Type: TABLE; Schema: schema_hotel; Owner: postgres
--

CREATE TABLE schema_hotel.client (
    id_client integer NOT NULL,
    address character varying(50) NOT NULL,
    passport_datas character varying(50) NOT NULL,
    full_name text NOT NULL,
    email character varying(50) NOT NULL
);


ALTER TABLE schema_hotel.client OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16397)
-- Name: Client_id_client_seq; Type: SEQUENCE; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE schema_hotel.client ALTER COLUMN id_client ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME schema_hotel."Client_id_client_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 213 (class 1259 OID 16406)
-- Name: employee; Type: TABLE; Schema: schema_hotel; Owner: postgres
--

CREATE TABLE schema_hotel.employee (
    personal_number integer NOT NULL,
    full_name text NOT NULL,
    hotel smallint NOT NULL,
    "position" character varying(25) NOT NULL
);


ALTER TABLE schema_hotel.employee OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16405)
-- Name: Employee_personal_number_seq; Type: SEQUENCE; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE schema_hotel.employee ALTER COLUMN personal_number ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME schema_hotel."Employee_personal_number_seq"
    START WITH 3000
    INCREMENT BY 1
    MINVALUE 3000
    MAXVALUE 9000
    CACHE 1
);


--
-- TOC entry 215 (class 1259 OID 16414)
-- Name: hotel; Type: TABLE; Schema: schema_hotel; Owner: postgres
--

CREATE TABLE schema_hotel.hotel (
    id_hotel integer NOT NULL,
    city text NOT NULL,
    name text NOT NULL,
    street character varying(30) NOT NULL,
    count_rooms integer NOT NULL,
    num_of_building smallint NOT NULL
);


ALTER TABLE schema_hotel.hotel OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16413)
-- Name: Hotel_id_hotel_seq; Type: SEQUENCE; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE schema_hotel.hotel ALTER COLUMN id_hotel ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME schema_hotel."Hotel_id_hotel_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 16461)
-- Name: order; Type: TABLE; Schema: schema_hotel; Owner: postgres
--

CREATE TABLE schema_hotel."order" (
    id_order integer NOT NULL,
    client integer NOT NULL,
    employee integer NOT NULL,
    room integer NOT NULL,
    arrival_date date NOT NULL,
    departure_date date NOT NULL,
    payment_type text NOT NULL,
    status_order text NOT NULL,
    booking_date date NOT NULL
);


ALTER TABLE schema_hotel."order" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16460)
-- Name: Order_id_order_seq; Type: SEQUENCE; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE schema_hotel."order" ALTER COLUMN id_order ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME schema_hotel."Order_id_order_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 16503)
-- Name: price; Type: TABLE; Schema: schema_hotel; Owner: postgres
--

CREATE TABLE schema_hotel.price (
    id_price integer NOT NULL,
    room_type integer NOT NULL,
    date_begin date NOT NULL,
    date_end date NOT NULL,
    sum money NOT NULL
);


ALTER TABLE schema_hotel.price OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16502)
-- Name: Price_id_price_seq; Type: SEQUENCE; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE schema_hotel.price ALTER COLUMN id_price ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME schema_hotel."Price_id_price_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 16432)
-- Name: room; Type: TABLE; Schema: schema_hotel; Owner: postgres
--

CREATE TABLE schema_hotel.room (
    id_room integer NOT NULL,
    num integer NOT NULL,
    hotel integer NOT NULL,
    type integer NOT NULL
);


ALTER TABLE schema_hotel.room OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16431)
-- Name: Room_id_room_seq; Type: SEQUENCE; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE schema_hotel.room ALTER COLUMN id_room ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME schema_hotel."Room_id_room_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 226 (class 1259 OID 16492)
-- Name: sale; Type: TABLE; Schema: schema_hotel; Owner: postgres
--

CREATE TABLE schema_hotel.sale (
    id_sale integer NOT NULL,
    room_type integer NOT NULL,
    date_begin date NOT NULL,
    date_end date NOT NULL,
    sale_size numeric NOT NULL
);


ALTER TABLE schema_hotel.sale OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16491)
-- Name: Sale_id_sale_seq; Type: SEQUENCE; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE schema_hotel.sale ALTER COLUMN id_sale ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME schema_hotel."Sale_id_sale_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 16484)
-- Name: type_room; Type: TABLE; Schema: schema_hotel; Owner: postgres
--

CREATE TABLE schema_hotel.type_room (
    id_type integer NOT NULL,
    description text NOT NULL,
    amenities text NOT NULL,
    name_type character varying(50) NOT NULL
);


ALTER TABLE schema_hotel.type_room OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16483)
-- Name: Type_room_id_type_seq; Type: SEQUENCE; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE schema_hotel.type_room ALTER COLUMN id_type ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME schema_hotel."Type_room_id_type_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 216 (class 1259 OID 16421)
-- Name: discount; Type: TABLE; Schema: schema_hotel; Owner: postgres
--

CREATE TABLE schema_hotel.discount (
    id_discount integer NOT NULL,
    id_hotel integer NOT NULL,
    amount numeric NOT NULL,
    date_begin date NOT NULL,
    date_end date NOT NULL
);


ALTER TABLE schema_hotel.discount OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16538)
-- Name: discount_id_discount_seq; Type: SEQUENCE; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE schema_hotel.discount ALTER COLUMN id_discount ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME schema_hotel.discount_id_discount_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3671 (class 0 OID 16443)
-- Dependencies: 220
-- Data for Name: cleaning; Type: TABLE DATA; Schema: schema_hotel; Owner: postgres
--

COPY schema_hotel.cleaning (id_cleaning, date_clean, status_clean, id_employee, id_room) FROM stdin;
1	2023-03-01	clean	3005	1
2	2023-03-01	clean	3005	2
3	2023-03-01	clean	3005	3
4	2023-03-01	clean	3005	4
5	2023-03-02	clean	3004	5
6	2023-03-02	clean	3004	5
7	2023-03-02	no clean	3004	6
8	2023-03-02	no clean	3004	7
9	2023-03-02	clean	3004	8
10	2023-03-09	clean	3003	9
11	2023-03-09	clean	3003	10
12	2023-03-09	clean	3003	11
13	2023-03-09	clean	3003	12
\.


--
-- TOC entry 3662 (class 0 OID 16398)
-- Dependencies: 211
-- Data for Name: client; Type: TABLE DATA; Schema: schema_hotel; Owner: postgres
--

COPY schema_hotel.client (id_client, address, passport_datas, full_name, email) FROM stdin;
1	Lensovata 23	HB3121108	Starovoytova Elizaveta Anatolyovna	lstarovoytova17@gmail.com
2	Piskarevski 45	HB3121109	Starovoytova Ekaterina Anatolyovna	katyastarovoytova03@gmail.com
3	Karvata 9	HB3105213	Peskun Maria Vadimovna	mariapeskun@gmail.com
4	Pobedy 24	HB3111234	Yaroshenko Maria Genadievna	myarosh2004@gmail.com
\.


--
-- TOC entry 3667 (class 0 OID 16421)
-- Dependencies: 216
-- Data for Name: discount; Type: TABLE DATA; Schema: schema_hotel; Owner: postgres
--

COPY schema_hotel.discount (id_discount, id_hotel, amount, date_begin, date_end) FROM stdin;
3	1	0.05	2023-03-01	2023-03-30
1	2	0.1	2023-03-01	2023-03-30
\.


--
-- TOC entry 3664 (class 0 OID 16406)
-- Dependencies: 213
-- Data for Name: employee; Type: TABLE DATA; Schema: schema_hotel; Owner: postgres
--

COPY schema_hotel.employee (personal_number, full_name, hotel, "position") FROM stdin;
3000	Karpova Elena Nokolaevna	1	Administrator
3001	Isachenko Daria Alexandrovna	2	Administrator
3002	Markevich Angelina Sergeevna	3	Administrator
3003	Markevich Ekaterina Anatolyovna	1	Cleaneress
3004	Danchenko Margo Alexandrovna	2	Cleaneress
3005	Alhimovich Anastasiya Olegovna	3	Cleaneress
3006	Alhimovich Maria Olegovna	3	Cleaneress
\.


--
-- TOC entry 3666 (class 0 OID 16414)
-- Dependencies: 215
-- Data for Name: hotel; Type: TABLE DATA; Schema: schema_hotel; Owner: postgres
--

COPY schema_hotel.hotel (id_hotel, city, name, street, count_rooms, num_of_building) FROM stdin;
1	Spb	Rixos SPB	Nevski prospect	59	132
2	Minsk	Rixos MINSK	Kupaly street	36	12
3	Ekb	Rixos EKB	Klasnaya street	29	53
\.


--
-- TOC entry 3673 (class 0 OID 16461)
-- Dependencies: 222
-- Data for Name: order; Type: TABLE DATA; Schema: schema_hotel; Owner: postgres
--

COPY schema_hotel."order" (id_order, client, employee, room, arrival_date, departure_date, payment_type, status_order, booking_date) FROM stdin;
1	1	3000	10	2023-04-14	2023-04-16	visa	approved	2023-03-20
3	2	3005	6	2023-04-14	2023-04-16	mir pay	approved	2023-03-29
4	3	3000	6	2023-04-13	2023-04-14	mastercard	approved	2023-03-24
\.


--
-- TOC entry 3679 (class 0 OID 16503)
-- Dependencies: 228
-- Data for Name: price; Type: TABLE DATA; Schema: schema_hotel; Owner: postgres
--

COPY schema_hotel.price (id_price, room_type, date_begin, date_end, sum) FROM stdin;
1	1	2023-03-01	2024-03-01	$50.00
2	2	2023-03-01	2024-03-01	$150.00
\.


--
-- TOC entry 3669 (class 0 OID 16432)
-- Dependencies: 218
-- Data for Name: room; Type: TABLE DATA; Schema: schema_hotel; Owner: postgres
--

COPY schema_hotel.room (id_room, num, hotel, type) FROM stdin;
1	10	3	2
2	20	3	2
3	30	3	1
4	40	3	1
5	10	2	2
6	20	2	2
7	30	2	1
8	40	2	1
9	40	1	1
10	30	1	1
11	20	1	2
12	10	1	2
\.


--
-- TOC entry 3677 (class 0 OID 16492)
-- Dependencies: 226
-- Data for Name: sale; Type: TABLE DATA; Schema: schema_hotel; Owner: postgres
--

COPY schema_hotel.sale (id_sale, room_type, date_begin, date_end, sale_size) FROM stdin;
1	2	2023-03-01	2023-03-08	0.2
\.


--
-- TOC entry 3675 (class 0 OID 16484)
-- Dependencies: 224
-- Data for Name: type_room; Type: TABLE DATA; Schema: schema_hotel; Owner: postgres
--

COPY schema_hotel.type_room (id_type, description, amenities, name_type) FROM stdin;
1	This room is suitable for a family	Refrigerator, baby cot	standart
2	This room is more comfortable, than standart room	Mini-bar, balcony with view, evrth you need	comfort
\.


--
-- TOC entry 3697 (class 0 OID 0)
-- Dependencies: 219
-- Name: Cleaning_id_cleaning_seq; Type: SEQUENCE SET; Schema: schema_hotel; Owner: postgres
--

SELECT pg_catalog.setval('schema_hotel."Cleaning_id_cleaning_seq"', 13, true);


--
-- TOC entry 3698 (class 0 OID 0)
-- Dependencies: 210
-- Name: Client_id_client_seq; Type: SEQUENCE SET; Schema: schema_hotel; Owner: postgres
--

SELECT pg_catalog.setval('schema_hotel."Client_id_client_seq"', 4, true);


--
-- TOC entry 3699 (class 0 OID 0)
-- Dependencies: 212
-- Name: Employee_personal_number_seq; Type: SEQUENCE SET; Schema: schema_hotel; Owner: postgres
--

SELECT pg_catalog.setval('schema_hotel."Employee_personal_number_seq"', 3006, true);


--
-- TOC entry 3700 (class 0 OID 0)
-- Dependencies: 214
-- Name: Hotel_id_hotel_seq; Type: SEQUENCE SET; Schema: schema_hotel; Owner: postgres
--

SELECT pg_catalog.setval('schema_hotel."Hotel_id_hotel_seq"', 3, true);


--
-- TOC entry 3701 (class 0 OID 0)
-- Dependencies: 221
-- Name: Order_id_order_seq; Type: SEQUENCE SET; Schema: schema_hotel; Owner: postgres
--

SELECT pg_catalog.setval('schema_hotel."Order_id_order_seq"', 4, true);


--
-- TOC entry 3702 (class 0 OID 0)
-- Dependencies: 227
-- Name: Price_id_price_seq; Type: SEQUENCE SET; Schema: schema_hotel; Owner: postgres
--

SELECT pg_catalog.setval('schema_hotel."Price_id_price_seq"', 2, true);


--
-- TOC entry 3703 (class 0 OID 0)
-- Dependencies: 217
-- Name: Room_id_room_seq; Type: SEQUENCE SET; Schema: schema_hotel; Owner: postgres
--

SELECT pg_catalog.setval('schema_hotel."Room_id_room_seq"', 12, true);


--
-- TOC entry 3704 (class 0 OID 0)
-- Dependencies: 225
-- Name: Sale_id_sale_seq; Type: SEQUENCE SET; Schema: schema_hotel; Owner: postgres
--

SELECT pg_catalog.setval('schema_hotel."Sale_id_sale_seq"', 1, true);


--
-- TOC entry 3705 (class 0 OID 0)
-- Dependencies: 223
-- Name: Type_room_id_type_seq; Type: SEQUENCE SET; Schema: schema_hotel; Owner: postgres
--

SELECT pg_catalog.setval('schema_hotel."Type_room_id_type_seq"', 2, true);


--
-- TOC entry 3706 (class 0 OID 0)
-- Dependencies: 229
-- Name: discount_id_discount_seq; Type: SEQUENCE SET; Schema: schema_hotel; Owner: postgres
--

SELECT pg_catalog.setval('schema_hotel.discount_id_discount_seq', 3, true);


--
-- TOC entry 3503 (class 2606 OID 16449)
-- Name: cleaning Cleaning_pkey; Type: CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE ONLY schema_hotel.cleaning
    ADD CONSTRAINT "Cleaning_pkey" PRIMARY KEY (id_cleaning);


--
-- TOC entry 3493 (class 2606 OID 16404)
-- Name: client Client_pkey; Type: CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE ONLY schema_hotel.client
    ADD CONSTRAINT "Client_pkey" PRIMARY KEY (id_client);


--
-- TOC entry 3499 (class 2606 OID 16425)
-- Name: discount Discount_pkey; Type: CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE ONLY schema_hotel.discount
    ADD CONSTRAINT "Discount_pkey" PRIMARY KEY (id_discount);


--
-- TOC entry 3495 (class 2606 OID 16412)
-- Name: employee Employee_pkey; Type: CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE ONLY schema_hotel.employee
    ADD CONSTRAINT "Employee_pkey" PRIMARY KEY (personal_number);


--
-- TOC entry 3497 (class 2606 OID 16420)
-- Name: hotel Hotel_pkey; Type: CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE ONLY schema_hotel.hotel
    ADD CONSTRAINT "Hotel_pkey" PRIMARY KEY (id_hotel);


--
-- TOC entry 3505 (class 2606 OID 16467)
-- Name: order Order_pkey; Type: CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE ONLY schema_hotel."order"
    ADD CONSTRAINT "Order_pkey" PRIMARY KEY (id_order);


--
-- TOC entry 3511 (class 2606 OID 16507)
-- Name: price Price_pkey; Type: CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE ONLY schema_hotel.price
    ADD CONSTRAINT "Price_pkey" PRIMARY KEY (id_price);


--
-- TOC entry 3501 (class 2606 OID 16436)
-- Name: room Room_pkey; Type: CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE ONLY schema_hotel.room
    ADD CONSTRAINT "Room_pkey" PRIMARY KEY (id_room);


--
-- TOC entry 3509 (class 2606 OID 16496)
-- Name: sale Sale_pkey; Type: CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE ONLY schema_hotel.sale
    ADD CONSTRAINT "Sale_pkey" PRIMARY KEY (id_sale);


--
-- TOC entry 3507 (class 2606 OID 16490)
-- Name: type_room Type_room_pkey; Type: CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE ONLY schema_hotel.type_room
    ADD CONSTRAINT "Type_room_pkey" PRIMARY KEY (id_type);


--
-- TOC entry 3482 (class 2606 OID 16529)
-- Name: order chk_arrivaldate; Type: CHECK CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE schema_hotel."order"
    ADD CONSTRAINT chk_arrivaldate CHECK ((arrival_date < departure_date)) NOT VALID;


--
-- TOC entry 3483 (class 2606 OID 16531)
-- Name: order chk_bookingdate; Type: CHECK CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE schema_hotel."order"
    ADD CONSTRAINT chk_bookingdate CHECK ((booking_date <= arrival_date)) NOT VALID;


--
-- TOC entry 3490 (class 2606 OID 16533)
-- Name: price chk_datebegin; Type: CHECK CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE schema_hotel.price
    ADD CONSTRAINT chk_datebegin CHECK ((date_begin < date_end)) NOT VALID;


--
-- TOC entry 3487 (class 2606 OID 16535)
-- Name: sale chk_datebegin; Type: CHECK CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE schema_hotel.sale
    ADD CONSTRAINT chk_datebegin CHECK ((date_begin < date_end)) NOT VALID;


--
-- TOC entry 3491 (class 2606 OID 16534)
-- Name: price chk_dateend; Type: CHECK CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE schema_hotel.price
    ADD CONSTRAINT chk_dateend CHECK ((date_end > date_begin)) NOT VALID;


--
-- TOC entry 3488 (class 2606 OID 16536)
-- Name: sale chk_dateend; Type: CHECK CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE schema_hotel.sale
    ADD CONSTRAINT chk_dateend CHECK ((date_end > date_begin)) NOT VALID;


--
-- TOC entry 3484 (class 2606 OID 16530)
-- Name: order chk_departuredate; Type: CHECK CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE schema_hotel."order"
    ADD CONSTRAINT chk_departuredate CHECK ((departure_date > arrival_date)) NOT VALID;


--
-- TOC entry 3479 (class 2606 OID 16526)
-- Name: discount chk_discount_datebegin; Type: CHECK CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE schema_hotel.discount
    ADD CONSTRAINT chk_discount_datebegin CHECK ((date_begin < date_end)) NOT VALID;


--
-- TOC entry 3480 (class 2606 OID 16527)
-- Name: discount chk_discount_dateend; Type: CHECK CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE schema_hotel.discount
    ADD CONSTRAINT chk_discount_dateend CHECK ((date_end > date_begin)) NOT VALID;


--
-- TOC entry 3478 (class 2606 OID 16528)
-- Name: hotel chk_hotel_countrooms; Type: CHECK CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE schema_hotel.hotel
    ADD CONSTRAINT chk_hotel_countrooms CHECK ((count_rooms > 0)) NOT VALID;


--
-- TOC entry 3485 (class 2606 OID 16540)
-- Name: order chk_payment; Type: CHECK CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE schema_hotel."order"
    ADD CONSTRAINT chk_payment CHECK ((payment_type = ANY (ARRAY['visa'::text, 'mastercard'::text, 'mir pay'::text, 'apple pay'::text]))) NOT VALID;


--
-- TOC entry 3489 (class 2606 OID 16563)
-- Name: sale chk_percent; Type: CHECK CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE schema_hotel.sale
    ADD CONSTRAINT chk_percent CHECK ((sale_size > (0)::numeric)) NOT VALID;


--
-- TOC entry 3481 (class 2606 OID 16572)
-- Name: cleaning chk_statusclean; Type: CHECK CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE schema_hotel.cleaning
    ADD CONSTRAINT chk_statusclean CHECK ((status_clean = ANY (ARRAY['clean'::text, 'no clean'::text]))) NOT VALID;


--
-- TOC entry 3486 (class 2606 OID 16573)
-- Name: order chk_statusorder; Type: CHECK CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE schema_hotel."order"
    ADD CONSTRAINT chk_statusorder CHECK ((status_order = ANY (ARRAY['approved'::text, 'not approved'::text, 'settlement'::text, 'left'::text, 'cancelled'::text, 'lateness'::text]))) NOT VALID;


--
-- TOC entry 3477 (class 2606 OID 16549)
-- Name: employee position; Type: CHECK CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE schema_hotel.employee
    ADD CONSTRAINT "position" CHECK ((("position")::text = ANY ((ARRAY['Administrator'::character varying, 'Cleaneress'::character varying, 'Director'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 3517 (class 2606 OID 16468)
-- Name: order fk_client; Type: FK CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE ONLY schema_hotel."order"
    ADD CONSTRAINT fk_client FOREIGN KEY (client) REFERENCES schema_hotel.client(id_client);


--
-- TOC entry 3518 (class 2606 OID 16473)
-- Name: order fk_employee; Type: FK CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE ONLY schema_hotel."order"
    ADD CONSTRAINT fk_employee FOREIGN KEY (employee) REFERENCES schema_hotel.employee(personal_number);


--
-- TOC entry 3513 (class 2606 OID 16437)
-- Name: room fk_hotel; Type: FK CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE ONLY schema_hotel.room
    ADD CONSTRAINT fk_hotel FOREIGN KEY (hotel) REFERENCES schema_hotel.hotel(id_hotel);


--
-- TOC entry 3512 (class 2606 OID 16426)
-- Name: discount fk_id_hotel; Type: FK CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE ONLY schema_hotel.discount
    ADD CONSTRAINT fk_id_hotel FOREIGN KEY (id_hotel) REFERENCES schema_hotel.hotel(id_hotel);


--
-- TOC entry 3519 (class 2606 OID 16478)
-- Name: order fk_room; Type: FK CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE ONLY schema_hotel."order"
    ADD CONSTRAINT fk_room FOREIGN KEY (room) REFERENCES schema_hotel.room(id_room);


--
-- TOC entry 3520 (class 2606 OID 16497)
-- Name: sale fk_room_type; Type: FK CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE ONLY schema_hotel.sale
    ADD CONSTRAINT fk_room_type FOREIGN KEY (room_type) REFERENCES schema_hotel.type_room(id_type);


--
-- TOC entry 3521 (class 2606 OID 16508)
-- Name: price fk_room_type; Type: FK CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE ONLY schema_hotel.price
    ADD CONSTRAINT fk_room_type FOREIGN KEY (room_type) REFERENCES schema_hotel.type_room(id_type);


--
-- TOC entry 3514 (class 2606 OID 16517)
-- Name: room fk_type; Type: FK CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE ONLY schema_hotel.room
    ADD CONSTRAINT fk_type FOREIGN KEY (type) REFERENCES schema_hotel.type_room(id_type) NOT VALID;


--
-- TOC entry 3516 (class 2606 OID 16455)
-- Name: cleaning id_employee; Type: FK CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE ONLY schema_hotel.cleaning
    ADD CONSTRAINT id_employee FOREIGN KEY (id_employee) REFERENCES schema_hotel.employee(personal_number);


--
-- TOC entry 3515 (class 2606 OID 16450)
-- Name: cleaning id_room; Type: FK CONSTRAINT; Schema: schema_hotel; Owner: postgres
--

ALTER TABLE ONLY schema_hotel.cleaning
    ADD CONSTRAINT id_room FOREIGN KEY (id_room) REFERENCES schema_hotel.room(id_room);


--
-- TOC entry 3686 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA schema_hotel; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA schema_hotel FROM postgres;
GRANT ALL ON SCHEMA schema_hotel TO postgres WITH GRANT OPTION;


--
-- TOC entry 3687 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE cleaning; Type: ACL; Schema: schema_hotel; Owner: postgres
--

REVOKE ALL ON TABLE schema_hotel.cleaning FROM postgres;
GRANT ALL ON TABLE schema_hotel.cleaning TO postgres WITH GRANT OPTION;


--
-- TOC entry 3688 (class 0 OID 0)
-- Dependencies: 211
-- Name: TABLE client; Type: ACL; Schema: schema_hotel; Owner: postgres
--

REVOKE ALL ON TABLE schema_hotel.client FROM postgres;
GRANT ALL ON TABLE schema_hotel.client TO postgres WITH GRANT OPTION;


--
-- TOC entry 3689 (class 0 OID 0)
-- Dependencies: 213
-- Name: TABLE employee; Type: ACL; Schema: schema_hotel; Owner: postgres
--

REVOKE ALL ON TABLE schema_hotel.employee FROM postgres;
GRANT ALL ON TABLE schema_hotel.employee TO postgres WITH GRANT OPTION;


--
-- TOC entry 3690 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE hotel; Type: ACL; Schema: schema_hotel; Owner: postgres
--

REVOKE ALL ON TABLE schema_hotel.hotel FROM postgres;
GRANT ALL ON TABLE schema_hotel.hotel TO postgres WITH GRANT OPTION;


--
-- TOC entry 3691 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE "order"; Type: ACL; Schema: schema_hotel; Owner: postgres
--

REVOKE ALL ON TABLE schema_hotel."order" FROM postgres;
GRANT ALL ON TABLE schema_hotel."order" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3692 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE price; Type: ACL; Schema: schema_hotel; Owner: postgres
--

REVOKE ALL ON TABLE schema_hotel.price FROM postgres;
GRANT ALL ON TABLE schema_hotel.price TO postgres WITH GRANT OPTION;


--
-- TOC entry 3693 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE room; Type: ACL; Schema: schema_hotel; Owner: postgres
--

REVOKE ALL ON TABLE schema_hotel.room FROM postgres;
GRANT ALL ON TABLE schema_hotel.room TO postgres WITH GRANT OPTION;


--
-- TOC entry 3694 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE sale; Type: ACL; Schema: schema_hotel; Owner: postgres
--

REVOKE ALL ON TABLE schema_hotel.sale FROM postgres;
GRANT ALL ON TABLE schema_hotel.sale TO postgres WITH GRANT OPTION;


--
-- TOC entry 3695 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE type_room; Type: ACL; Schema: schema_hotel; Owner: postgres
--

REVOKE ALL ON TABLE schema_hotel.type_room FROM postgres;
GRANT ALL ON TABLE schema_hotel.type_room TO postgres WITH GRANT OPTION;


--
-- TOC entry 3696 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE discount; Type: ACL; Schema: schema_hotel; Owner: postgres
--

REVOKE ALL ON TABLE schema_hotel.discount FROM postgres;
GRANT ALL ON TABLE schema_hotel.discount TO postgres WITH GRANT OPTION;


--
-- TOC entry 2071 (class 826 OID 16396)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: schema_hotel; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA schema_hotel GRANT ALL ON TABLES  TO postgres WITH GRANT OPTION;


-- Completed on 2023-03-23 14:39:26 MSK

--
-- PostgreSQL database dump complete
--

