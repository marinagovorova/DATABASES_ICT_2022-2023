--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-03-21 14:23:15

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

DROP DATABASE "Lab-1";
--
-- TOC entry 3477 (class 1262 OID 16398)
-- Name: Lab-1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "Lab-1" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';


ALTER DATABASE "Lab-1" OWNER TO postgres;

\connect -reuse-previous=on "dbname='Lab-1'"

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
-- TOC entry 6 (class 2615 OID 16400)
-- Name: all_flights; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA all_flights;


ALTER SCHEMA all_flights OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16401)
-- Name: airline; Type: TABLE; Schema: all_flights; Owner: postgres
--

CREATE TABLE all_flights.airline (
    id integer NOT NULL,
    country character varying(100) NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE all_flights.airline OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16581)
-- Name: airline_id_seq; Type: SEQUENCE; Schema: all_flights; Owner: postgres
--

ALTER TABLE all_flights.airline ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME all_flights.airline_id_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 217 (class 1259 OID 16411)
-- Name: airport; Type: TABLE; Schema: all_flights; Owner: postgres
--

CREATE TABLE all_flights.airport (
    id integer NOT NULL,
    city character varying(30) NOT NULL,
    name character varying(100) NOT NULL,
    country character varying(100) NOT NULL
);


ALTER TABLE all_flights.airport OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16585)
-- Name: airport_id_seq; Type: SEQUENCE; Schema: all_flights; Owner: postgres
--

ALTER TABLE all_flights.airport ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME all_flights.airport_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 216 (class 1259 OID 16406)
-- Name: brand; Type: TABLE; Schema: all_flights; Owner: postgres
--

CREATE TABLE all_flights.brand (
    id integer NOT NULL,
    speed integer NOT NULL,
    manufacturer character varying(30) NOT NULL,
    fuel_consumption integer NOT NULL,
    capacity integer NOT NULL,
    country character varying(100) NOT NULL,
    amount_of_places integer,
    name character varying(30)
);


ALTER TABLE all_flights.brand OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16587)
-- Name: brand_id_seq; Type: SEQUENCE; Schema: all_flights; Owner: postgres
--

ALTER TABLE all_flights.brand ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME all_flights.brand_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 16416)
-- Name: cash_register; Type: TABLE; Schema: all_flights; Owner: postgres
--

CREATE TABLE all_flights.cash_register (
    id integer NOT NULL,
    address character varying(100) NOT NULL,
    city character varying(30) NOT NULL
);


ALTER TABLE all_flights.cash_register OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16588)
-- Name: cash_register_id_seq; Type: SEQUENCE; Schema: all_flights; Owner: postgres
--

ALTER TABLE all_flights.cash_register ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME all_flights.cash_register_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 16426)
-- Name: cost; Type: TABLE; Schema: all_flights; Owner: postgres
--

CREATE TABLE all_flights.cost (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(250) NOT NULL,
    cost money NOT NULL
);


ALTER TABLE all_flights.cost OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16589)
-- Name: cost_id_seq; Type: SEQUENCE; Schema: all_flights; Owner: postgres
--

ALTER TABLE all_flights.cost ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME all_flights.cost_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 16548)
-- Name: crew; Type: TABLE; Schema: all_flights; Owner: postgres
--

CREATE TABLE all_flights.crew (
    id integer NOT NULL,
    id_flight integer NOT NULL,
    "position" character varying(30) NOT NULL,
    date_phys_exam date NOT NULL,
    phys_exam_status boolean NOT NULL,
    id_crew_member integer
);


ALTER TABLE all_flights.crew OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16602)
-- Name: crew_id_seq; Type: SEQUENCE; Schema: all_flights; Owner: postgres
--

ALTER TABLE all_flights.crew ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME all_flights.crew_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 16451)
-- Name: crew_member; Type: TABLE; Schema: all_flights; Owner: postgres
--

CREATE TABLE all_flights.crew_member (
    id integer NOT NULL,
    passport character varying(20) NOT NULL,
    id_airline integer,
    name character varying(100) NOT NULL
);


ALTER TABLE all_flights.crew_member OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16601)
-- Name: crew_member_id_seq; Type: SEQUENCE; Schema: all_flights; Owner: postgres
--

ALTER TABLE all_flights.crew_member ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME all_flights.crew_member_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 225 (class 1259 OID 16489)
-- Name: flight; Type: TABLE; Schema: all_flights; Owner: postgres
--

CREATE TABLE all_flights.flight (
    id integer NOT NULL,
    date_departure date NOT NULL,
    date_arrive date NOT NULL,
    flight_num character varying(20) NOT NULL,
    id_plane integer NOT NULL,
    id_schedule integer NOT NULL
);


ALTER TABLE all_flights.flight OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 24601)
-- Name: flight_id_seq; Type: SEQUENCE; Schema: all_flights; Owner: postgres
--

ALTER TABLE all_flights.flight ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME all_flights.flight_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 219 (class 1259 OID 16421)
-- Name: passanger; Type: TABLE; Schema: all_flights; Owner: postgres
--

CREATE TABLE all_flights.passanger (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    passport character varying(20) NOT NULL,
    mail character varying(20) NOT NULL,
    telephone character varying(206) NOT NULL
);


ALTER TABLE all_flights.passanger OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 24590)
-- Name: passanger_id_seq; Type: SEQUENCE; Schema: all_flights; Owner: postgres
--

ALTER TABLE all_flights.passanger ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME all_flights.passanger_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 226 (class 1259 OID 16504)
-- Name: place; Type: TABLE; Schema: all_flights; Owner: postgres
--

CREATE TABLE all_flights.place (
    id integer NOT NULL,
    emp_status boolean NOT NULL,
    type character varying(30) NOT NULL,
    cost money NOT NULL,
    id_flight integer NOT NULL
);


ALTER TABLE all_flights.place OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 24591)
-- Name: place_id_seq; Type: SEQUENCE; Schema: all_flights; Owner: postgres
--

ALTER TABLE all_flights.place ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME all_flights.place_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 221 (class 1259 OID 16434)
-- Name: plane; Type: TABLE; Schema: all_flights; Owner: postgres
--

CREATE TABLE all_flights.plane (
    id integer NOT NULL,
    plane_num character varying(20) NOT NULL,
    creation_date date NOT NULL,
    mileage integer NOT NULL,
    last_repair_date date NOT NULL,
    id_brand integer NOT NULL,
    id_airline integer NOT NULL
);


ALTER TABLE all_flights.plane OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16591)
-- Name: plane_id_seq; Type: SEQUENCE; Schema: all_flights; Owner: postgres
--

ALTER TABLE all_flights.plane ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME all_flights.plane_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 223 (class 1259 OID 16462)
-- Name: schedule; Type: TABLE; Schema: all_flights; Owner: postgres
--

CREATE TABLE all_flights.schedule (
    id integer NOT NULL,
    periodic boolean NOT NULL,
    arrive_date date NOT NULL,
    departure_date date NOT NULL,
    distance integer NOT NULL,
    id_airport integer
);


ALTER TABLE all_flights.schedule OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16592)
-- Name: schedule_id_seq; Type: SEQUENCE; Schema: all_flights; Owner: postgres
--

ALTER TABLE all_flights.schedule ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME all_flights.schedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 227 (class 1259 OID 16514)
-- Name: ticket; Type: TABLE; Schema: all_flights; Owner: postgres
--

CREATE TABLE all_flights.ticket (
    id integer NOT NULL,
    id_flight integer,
    id_cost integer,
    id_passanger integer,
    id_cash_register integer,
    ticket_num character varying(20) NOT NULL,
    type_of_paying boolean NOT NULL,
    payment_status boolean NOT NULL,
    id_place integer,
    done_status boolean NOT NULL
);


ALTER TABLE all_flights.ticket OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 24600)
-- Name: ticket_id_seq; Type: SEQUENCE; Schema: all_flights; Owner: postgres
--

ALTER TABLE all_flights.ticket ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME all_flights.ticket_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 16472)
-- Name: transit; Type: TABLE; Schema: all_flights; Owner: postgres
--

CREATE TABLE all_flights.transit (
    id integer NOT NULL,
    id_airport integer,
    id_schedule integer,
    arrive_date date NOT NULL,
    departure_date date NOT NULL
);


ALTER TABLE all_flights.transit OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 24592)
-- Name: transit_id_seq; Type: SEQUENCE; Schema: all_flights; Owner: postgres
--

ALTER TABLE all_flights.transit ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME all_flights.transit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3444 (class 0 OID 16401)
-- Dependencies: 215
-- Data for Name: airline; Type: TABLE DATA; Schema: all_flights; Owner: postgres
--

INSERT INTO all_flights.airline (id, country, name) OVERRIDING SYSTEM VALUE VALUES (1, 'РФ', 'Победа');
INSERT INTO all_flights.airline (id, country, name) OVERRIDING SYSTEM VALUE VALUES (2, 'РФ', 'Аэрофлот');
INSERT INTO all_flights.airline (id, country, name) OVERRIDING SYSTEM VALUE VALUES (3, 'Катар', 'Qatar Airlines');
INSERT INTO all_flights.airline (id, country, name) OVERRIDING SYSTEM VALUE VALUES (4, 'Сингапур', 'Singapore Airlines');
INSERT INTO all_flights.airline (id, country, name) OVERRIDING SYSTEM VALUE VALUES (5, 'Япония', 'ANA All Nippon Airways');
INSERT INTO all_flights.airline (id, country, name) OVERRIDING SYSTEM VALUE VALUES (6, 'Япония', 'Japan Airways');
INSERT INTO all_flights.airline (id, country, name) OVERRIDING SYSTEM VALUE VALUES (7, 'Франция', 'Air France');
INSERT INTO all_flights.airline (id, country, name) OVERRIDING SYSTEM VALUE VALUES (8, 'Турция', 'Turkish Airlines');


--
-- TOC entry 3446 (class 0 OID 16411)
-- Dependencies: 217
-- Data for Name: airport; Type: TABLE DATA; Schema: all_flights; Owner: postgres
--

INSERT INTO all_flights.airport (id, city, name, country) OVERRIDING SYSTEM VALUE VALUES (1, 'Санкт-Петербург', 'Пулково', 'Рф');
INSERT INTO all_flights.airport (id, city, name, country) OVERRIDING SYSTEM VALUE VALUES (2, 'Москва', 'Внуково', 'Рф');
INSERT INTO all_flights.airport (id, city, name, country) OVERRIDING SYSTEM VALUE VALUES (3, 'Atlanta', 'Hartsfield-Jakson', 'USA');
INSERT INTO all_flights.airport (id, city, name, country) OVERRIDING SYSTEM VALUE VALUES (4, 'Цюрих', 'Клотен', 'Швейцария');
INSERT INTO all_flights.airport (id, city, name, country) OVERRIDING SYSTEM VALUE VALUES (5, 'Нарита', 'Нарита Интернэшнл', 'Япония');
INSERT INTO all_flights.airport (id, city, name, country) OVERRIDING SYSTEM VALUE VALUES (6, 'Лондон', 'Хитроу', 'Великобритания');
INSERT INTO all_flights.airport (id, city, name, country) OVERRIDING SYSTEM VALUE VALUES (7, 'Гонконг', 'Чхеклапкок', 'Гонконг');


--
-- TOC entry 3445 (class 0 OID 16406)
-- Dependencies: 216
-- Data for Name: brand; Type: TABLE DATA; Schema: all_flights; Owner: postgres
--

INSERT INTO all_flights.brand (id, speed, manufacturer, fuel_consumption, capacity, country, amount_of_places, name) OVERRIDING SYSTEM VALUE VALUES (1, 807, 'Boeing', 26, 1000, 'USA', 103, 'Boeing 737-300');
INSERT INTO all_flights.brand (id, speed, manufacturer, fuel_consumption, capacity, country, amount_of_places, name) OVERRIDING SYSTEM VALUE VALUES (2, 325, 'ОКБ Ильюшина', 26, 3000, 'СССР', 27, 'Ил-12');
INSERT INTO all_flights.brand (id, speed, manufacturer, fuel_consumption, capacity, country, amount_of_places, name) OVERRIDING SYSTEM VALUE VALUES (3, 900, 'Авиакор', 25, 18000, 'СССР', 27, 'Ил-12');


--
-- TOC entry 3447 (class 0 OID 16416)
-- Dependencies: 218
-- Data for Name: cash_register; Type: TABLE DATA; Schema: all_flights; Owner: postgres
--

INSERT INTO all_flights.cash_register (id, address, city) OVERRIDING SYSTEM VALUE VALUES (1, 'адрес1', 'Санкт-Петербург');
INSERT INTO all_flights.cash_register (id, address, city) OVERRIDING SYSTEM VALUE VALUES (2, 'адрес1', 'Москва');
INSERT INTO all_flights.cash_register (id, address, city) OVERRIDING SYSTEM VALUE VALUES (3, 'адрес1', 'Великий Новгород');
INSERT INTO all_flights.cash_register (id, address, city) OVERRIDING SYSTEM VALUE VALUES (4, 'адрес1', 'Казань');
INSERT INTO all_flights.cash_register (id, address, city) OVERRIDING SYSTEM VALUE VALUES (5, 'адрес1', 'Владивосток');
INSERT INTO all_flights.cash_register (id, address, city) OVERRIDING SYSTEM VALUE VALUES (6, 'адрес1', 'Екатеринбург');


--
-- TOC entry 3449 (class 0 OID 16426)
-- Dependencies: 220
-- Data for Name: cost; Type: TABLE DATA; Schema: all_flights; Owner: postgres
--

INSERT INTO all_flights.cost (id, name, description, cost) OVERRIDING SYSTEM VALUE VALUES (1, 'First', 'desc', '1 000,00 ?');
INSERT INTO all_flights.cost (id, name, description, cost) OVERRIDING SYSTEM VALUE VALUES (2, 'Second', 'desc', '1 000,00 ?');
INSERT INTO all_flights.cost (id, name, description, cost) OVERRIDING SYSTEM VALUE VALUES (3, 'Third', 'desc', '1 000,00 ?');
INSERT INTO all_flights.cost (id, name, description, cost) OVERRIDING SYSTEM VALUE VALUES (4, 'Forth', 'desc', '1 500,00 ?');
INSERT INTO all_flights.cost (id, name, description, cost) OVERRIDING SYSTEM VALUE VALUES (5, 'Fith', 'desc', '2 000,00 ?');
INSERT INTO all_flights.cost (id, name, description, cost) OVERRIDING SYSTEM VALUE VALUES (6, 'Sixth', 'desc', '2 100,00 ?');
INSERT INTO all_flights.cost (id, name, description, cost) OVERRIDING SYSTEM VALUE VALUES (7, 'Seventh', 'desc', '2 320,00 ?');


--
-- TOC entry 3457 (class 0 OID 16548)
-- Dependencies: 228
-- Data for Name: crew; Type: TABLE DATA; Schema: all_flights; Owner: postgres
--

INSERT INTO all_flights.crew (id, id_flight, "position", date_phys_exam, phys_exam_status, id_crew_member) OVERRIDING SYSTEM VALUE VALUES (3, 2, 'captain', '2020-10-10', true, 1);
INSERT INTO all_flights.crew (id, id_flight, "position", date_phys_exam, phys_exam_status, id_crew_member) OVERRIDING SYSTEM VALUE VALUES (4, 2, 'stuard', '2020-10-10', true, 2);
INSERT INTO all_flights.crew (id, id_flight, "position", date_phys_exam, phys_exam_status, id_crew_member) OVERRIDING SYSTEM VALUE VALUES (5, 2, 'stuard', '2020-10-10', true, 3);
INSERT INTO all_flights.crew (id, id_flight, "position", date_phys_exam, phys_exam_status, id_crew_member) OVERRIDING SYSTEM VALUE VALUES (6, 2, 'stuard', '2020-10-10', true, 4);
INSERT INTO all_flights.crew (id, id_flight, "position", date_phys_exam, phys_exam_status, id_crew_member) OVERRIDING SYSTEM VALUE VALUES (7, 3, 'stuard', '2020-10-10', true, 6);
INSERT INTO all_flights.crew (id, id_flight, "position", date_phys_exam, phys_exam_status, id_crew_member) OVERRIDING SYSTEM VALUE VALUES (8, 3, 'captain', '2020-10-10', true, 7);
INSERT INTO all_flights.crew (id, id_flight, "position", date_phys_exam, phys_exam_status, id_crew_member) OVERRIDING SYSTEM VALUE VALUES (9, 3, 'stuard', '2020-10-10', true, 8);


--
-- TOC entry 3451 (class 0 OID 16451)
-- Dependencies: 222
-- Data for Name: crew_member; Type: TABLE DATA; Schema: all_flights; Owner: postgres
--

INSERT INTO all_flights.crew_member (id, passport, id_airline, name) OVERRIDING SYSTEM VALUE VALUES (4, '1001-200001', 1, 'Member4');
INSERT INTO all_flights.crew_member (id, passport, id_airline, name) OVERRIDING SYSTEM VALUE VALUES (5, '1001-21001', 1, 'Member5');
INSERT INTO all_flights.crew_member (id, passport, id_airline, name) OVERRIDING SYSTEM VALUE VALUES (6, '1201-21000003', 2, 'Member1');
INSERT INTO all_flights.crew_member (id, passport, id_airline, name) OVERRIDING SYSTEM VALUE VALUES (7, '12211-21000003', 2, 'Member2');
INSERT INTO all_flights.crew_member (id, passport, id_airline, name) OVERRIDING SYSTEM VALUE VALUES (9, '4444-21000003', 2, 'Member4');
INSERT INTO all_flights.crew_member (id, passport, id_airline, name) OVERRIDING SYSTEM VALUE VALUES (3, '0000-11111122', 1, 'Member3');
INSERT INTO all_flights.crew_member (id, passport, id_airline, name) OVERRIDING SYSTEM VALUE VALUES (1, '0000-23232323', 1, 'Member1');
INSERT INTO all_flights.crew_member (id, passport, id_airline, name) OVERRIDING SYSTEM VALUE VALUES (2, '0000-2222222', 1, 'Member2');
INSERT INTO all_flights.crew_member (id, passport, id_airline, name) OVERRIDING SYSTEM VALUE VALUES (8, '33333-21000003', 2, 'Member3');


--
-- TOC entry 3454 (class 0 OID 16489)
-- Dependencies: 225
-- Data for Name: flight; Type: TABLE DATA; Schema: all_flights; Owner: postgres
--

INSERT INTO all_flights.flight (id, date_departure, date_arrive, flight_num, id_plane, id_schedule) OVERRIDING SYSTEM VALUE VALUES (2, '2024-01-05', '2024-01-05', 'num1', 1, 2);
INSERT INTO all_flights.flight (id, date_departure, date_arrive, flight_num, id_plane, id_schedule) OVERRIDING SYSTEM VALUE VALUES (3, '2024-01-06', '2024-01-06', 'num2', 2, 3);
INSERT INTO all_flights.flight (id, date_departure, date_arrive, flight_num, id_plane, id_schedule) OVERRIDING SYSTEM VALUE VALUES (4, '2024-01-06', '2024-01-07', 'num3', 3, 4);
INSERT INTO all_flights.flight (id, date_departure, date_arrive, flight_num, id_plane, id_schedule) OVERRIDING SYSTEM VALUE VALUES (5, '2024-01-07', '2024-01-08', 'num4', 4, 6);


--
-- TOC entry 3448 (class 0 OID 16421)
-- Dependencies: 219
-- Data for Name: passanger; Type: TABLE DATA; Schema: all_flights; Owner: postgres
--

INSERT INTO all_flights.passanger (id, name, passport, mail, telephone) OVERRIDING SYSTEM VALUE VALUES (1, 'Passanger name 1', '1111-00000001', 'pass1@mail.com', '+890500001');
INSERT INTO all_flights.passanger (id, name, passport, mail, telephone) OVERRIDING SYSTEM VALUE VALUES (2, 'Passanger name 2', '1111-00000002', 'pass2@mail.com', '+890500002');
INSERT INTO all_flights.passanger (id, name, passport, mail, telephone) OVERRIDING SYSTEM VALUE VALUES (3, 'Passanger name 3', '1111-00000003', 'pass3@mail.com', '+890500003');
INSERT INTO all_flights.passanger (id, name, passport, mail, telephone) OVERRIDING SYSTEM VALUE VALUES (4, 'Passanger name 4', '1111-00000004', 'pass4@mail.com', '+890500004');
INSERT INTO all_flights.passanger (id, name, passport, mail, telephone) OVERRIDING SYSTEM VALUE VALUES (5, 'Passanger name 5', '1111-00000005', 'pass5@mail.com', '+890500005');
INSERT INTO all_flights.passanger (id, name, passport, mail, telephone) OVERRIDING SYSTEM VALUE VALUES (6, 'Passanger name 6', '1111-00000006', 'pass6@mail.com', '+890500006');


--
-- TOC entry 3455 (class 0 OID 16504)
-- Dependencies: 226
-- Data for Name: place; Type: TABLE DATA; Schema: all_flights; Owner: postgres
--

INSERT INTO all_flights.place (id, emp_status, type, cost, id_flight) OVERRIDING SYSTEM VALUE VALUES (2, true, 'econom', '1 000,00 ?', 2);
INSERT INTO all_flights.place (id, emp_status, type, cost, id_flight) OVERRIDING SYSTEM VALUE VALUES (3, false, 'bisnes', '2 000,00 ?', 2);
INSERT INTO all_flights.place (id, emp_status, type, cost, id_flight) OVERRIDING SYSTEM VALUE VALUES (4, false, 'econom', '1 000,00 ?', 2);
INSERT INTO all_flights.place (id, emp_status, type, cost, id_flight) OVERRIDING SYSTEM VALUE VALUES (5, true, 'econom', '1 000,00 ?', 3);
INSERT INTO all_flights.place (id, emp_status, type, cost, id_flight) OVERRIDING SYSTEM VALUE VALUES (6, true, 'econom', '1 000,00 ?', 3);
INSERT INTO all_flights.place (id, emp_status, type, cost, id_flight) OVERRIDING SYSTEM VALUE VALUES (7, true, 'econom', '1 000,00 ?', 3);
INSERT INTO all_flights.place (id, emp_status, type, cost, id_flight) OVERRIDING SYSTEM VALUE VALUES (8, true, 'econom', '1 000,00 ?', 3);
INSERT INTO all_flights.place (id, emp_status, type, cost, id_flight) OVERRIDING SYSTEM VALUE VALUES (9, false, 'econom', '1 000,00 ?', 3);
INSERT INTO all_flights.place (id, emp_status, type, cost, id_flight) OVERRIDING SYSTEM VALUE VALUES (10, false, 'econom', '1 000,00 ?', 3);
INSERT INTO all_flights.place (id, emp_status, type, cost, id_flight) OVERRIDING SYSTEM VALUE VALUES (11, false, 'bisnes', '2 000,00 ?', 3);
INSERT INTO all_flights.place (id, emp_status, type, cost, id_flight) OVERRIDING SYSTEM VALUE VALUES (12, false, 'bisnes', '2 000,00 ?', 3);
INSERT INTO all_flights.place (id, emp_status, type, cost, id_flight) OVERRIDING SYSTEM VALUE VALUES (13, false, 'bisnes', '2 000,00 ?', 4);
INSERT INTO all_flights.place (id, emp_status, type, cost, id_flight) OVERRIDING SYSTEM VALUE VALUES (14, false, 'bisnes', '2 000,00 ?', 4);
INSERT INTO all_flights.place (id, emp_status, type, cost, id_flight) OVERRIDING SYSTEM VALUE VALUES (15, true, 'bisnes', '2 000,00 ?', 4);
INSERT INTO all_flights.place (id, emp_status, type, cost, id_flight) OVERRIDING SYSTEM VALUE VALUES (16, true, 'bisnes', '2 000,00 ?', 4);
INSERT INTO all_flights.place (id, emp_status, type, cost, id_flight) OVERRIDING SYSTEM VALUE VALUES (17, true, 'econom', '1 000,00 ?', 4);
INSERT INTO all_flights.place (id, emp_status, type, cost, id_flight) OVERRIDING SYSTEM VALUE VALUES (18, true, 'econom', '1 000,00 ?', 4);
INSERT INTO all_flights.place (id, emp_status, type, cost, id_flight) OVERRIDING SYSTEM VALUE VALUES (19, true, 'econom', '1 000,00 ?', 4);


--
-- TOC entry 3450 (class 0 OID 16434)
-- Dependencies: 221
-- Data for Name: plane; Type: TABLE DATA; Schema: all_flights; Owner: postgres
--

INSERT INTO all_flights.plane (id, plane_num, creation_date, mileage, last_repair_date, id_brand, id_airline) OVERRIDING SYSTEM VALUE VALUES (1, '2345', '2000-12-01', 100, '2000-12-01', 1, 1);
INSERT INTO all_flights.plane (id, plane_num, creation_date, mileage, last_repair_date, id_brand, id_airline) OVERRIDING SYSTEM VALUE VALUES (2, '2346', '2000-12-02', 100, '2002-10-10', 1, 2);
INSERT INTO all_flights.plane (id, plane_num, creation_date, mileage, last_repair_date, id_brand, id_airline) OVERRIDING SYSTEM VALUE VALUES (4, '2347', '2004-01-03', 100, '2010-04-05', 3, 4);
INSERT INTO all_flights.plane (id, plane_num, creation_date, mileage, last_repair_date, id_brand, id_airline) OVERRIDING SYSTEM VALUE VALUES (5, '2348', '2005-06-07', 150, '2011-06-05', 3, 5);
INSERT INTO all_flights.plane (id, plane_num, creation_date, mileage, last_repair_date, id_brand, id_airline) OVERRIDING SYSTEM VALUE VALUES (3, '2349', '2000-12-02', 100, '2002-10-10', 1, 2);


--
-- TOC entry 3452 (class 0 OID 16462)
-- Dependencies: 223
-- Data for Name: schedule; Type: TABLE DATA; Schema: all_flights; Owner: postgres
--

INSERT INTO all_flights.schedule (id, periodic, arrive_date, departure_date, distance, id_airport) OVERRIDING SYSTEM VALUE VALUES (2, true, '2023-01-01', '2022-12-31', 1000, 1);
INSERT INTO all_flights.schedule (id, periodic, arrive_date, departure_date, distance, id_airport) OVERRIDING SYSTEM VALUE VALUES (3, false, '2023-01-02', '2022-01-02', 1000, 3);
INSERT INTO all_flights.schedule (id, periodic, arrive_date, departure_date, distance, id_airport) OVERRIDING SYSTEM VALUE VALUES (4, false, '2023-04-05', '2022-04-05', 1000, 2);
INSERT INTO all_flights.schedule (id, periodic, arrive_date, departure_date, distance, id_airport) OVERRIDING SYSTEM VALUE VALUES (6, false, '2022-06-08', '2022-06-08', 1010, 4);


--
-- TOC entry 3456 (class 0 OID 16514)
-- Dependencies: 227
-- Data for Name: ticket; Type: TABLE DATA; Schema: all_flights; Owner: postgres
--

INSERT INTO all_flights.ticket (id, id_flight, id_cost, id_passanger, id_cash_register, ticket_num, type_of_paying, payment_status, id_place, done_status) OVERRIDING SYSTEM VALUE VALUES (1, 2, 1, 1, 1, 'num1', true, true, 2, true);
INSERT INTO all_flights.ticket (id, id_flight, id_cost, id_passanger, id_cash_register, ticket_num, type_of_paying, payment_status, id_place, done_status) OVERRIDING SYSTEM VALUE VALUES (2, 2, 2, 1, 1, 'num2', true, false, 3, false);
INSERT INTO all_flights.ticket (id, id_flight, id_cost, id_passanger, id_cash_register, ticket_num, type_of_paying, payment_status, id_place, done_status) OVERRIDING SYSTEM VALUE VALUES (3, 2, 2, 2, 3, 'num3', false, true, 3, false);
INSERT INTO all_flights.ticket (id, id_flight, id_cost, id_passanger, id_cash_register, ticket_num, type_of_paying, payment_status, id_place, done_status) OVERRIDING SYSTEM VALUE VALUES (4, 2, 2, 2, 3, 'num3', false, true, 4, false);
INSERT INTO all_flights.ticket (id, id_flight, id_cost, id_passanger, id_cash_register, ticket_num, type_of_paying, payment_status, id_place, done_status) OVERRIDING SYSTEM VALUE VALUES (6, 3, 2, 2, 3, 'num6', false, true, 6, false);
INSERT INTO all_flights.ticket (id, id_flight, id_cost, id_passanger, id_cash_register, ticket_num, type_of_paying, payment_status, id_place, done_status) OVERRIDING SYSTEM VALUE VALUES (7, 3, 2, 2, 3, 'num7', false, true, 7, false);
INSERT INTO all_flights.ticket (id, id_flight, id_cost, id_passanger, id_cash_register, ticket_num, type_of_paying, payment_status, id_place, done_status) OVERRIDING SYSTEM VALUE VALUES (5, 3, 2, 2, 3, 'num5', false, true, 5, false);


--
-- TOC entry 3453 (class 0 OID 16472)
-- Dependencies: 224
-- Data for Name: transit; Type: TABLE DATA; Schema: all_flights; Owner: postgres
--

INSERT INTO all_flights.transit (id, id_airport, id_schedule, arrive_date, departure_date) OVERRIDING SYSTEM VALUE VALUES (5, 1, 2, '2022-12-01', '2022-12-01');
INSERT INTO all_flights.transit (id, id_airport, id_schedule, arrive_date, departure_date) OVERRIDING SYSTEM VALUE VALUES (6, 1, 3, '2022-03-01', '2022-03-01');
INSERT INTO all_flights.transit (id, id_airport, id_schedule, arrive_date, departure_date) OVERRIDING SYSTEM VALUE VALUES (8, 2, 4, '2024-01-06', '2024-01-05');
INSERT INTO all_flights.transit (id, id_airport, id_schedule, arrive_date, departure_date) OVERRIDING SYSTEM VALUE VALUES (11, 4, 6, '2024-01-06', '2024-01-05');


--
-- TOC entry 3478 (class 0 OID 0)
-- Dependencies: 229
-- Name: airline_id_seq; Type: SEQUENCE SET; Schema: all_flights; Owner: postgres
--

SELECT pg_catalog.setval('all_flights.airline_id_seq', 8, true);


--
-- TOC entry 3479 (class 0 OID 0)
-- Dependencies: 230
-- Name: airport_id_seq; Type: SEQUENCE SET; Schema: all_flights; Owner: postgres
--

SELECT pg_catalog.setval('all_flights.airport_id_seq', 7, true);


--
-- TOC entry 3480 (class 0 OID 0)
-- Dependencies: 231
-- Name: brand_id_seq; Type: SEQUENCE SET; Schema: all_flights; Owner: postgres
--

SELECT pg_catalog.setval('all_flights.brand_id_seq', 3, true);


--
-- TOC entry 3481 (class 0 OID 0)
-- Dependencies: 232
-- Name: cash_register_id_seq; Type: SEQUENCE SET; Schema: all_flights; Owner: postgres
--

SELECT pg_catalog.setval('all_flights.cash_register_id_seq', 6, true);


--
-- TOC entry 3482 (class 0 OID 0)
-- Dependencies: 233
-- Name: cost_id_seq; Type: SEQUENCE SET; Schema: all_flights; Owner: postgres
--

SELECT pg_catalog.setval('all_flights.cost_id_seq', 7, true);


--
-- TOC entry 3483 (class 0 OID 0)
-- Dependencies: 237
-- Name: crew_id_seq; Type: SEQUENCE SET; Schema: all_flights; Owner: postgres
--

SELECT pg_catalog.setval('all_flights.crew_id_seq', 9, true);


--
-- TOC entry 3484 (class 0 OID 0)
-- Dependencies: 236
-- Name: crew_member_id_seq; Type: SEQUENCE SET; Schema: all_flights; Owner: postgres
--

SELECT pg_catalog.setval('all_flights.crew_member_id_seq', 9, true);


--
-- TOC entry 3485 (class 0 OID 0)
-- Dependencies: 242
-- Name: flight_id_seq; Type: SEQUENCE SET; Schema: all_flights; Owner: postgres
--

SELECT pg_catalog.setval('all_flights.flight_id_seq', 5, true);


--
-- TOC entry 3486 (class 0 OID 0)
-- Dependencies: 238
-- Name: passanger_id_seq; Type: SEQUENCE SET; Schema: all_flights; Owner: postgres
--

SELECT pg_catalog.setval('all_flights.passanger_id_seq', 6, true);


--
-- TOC entry 3487 (class 0 OID 0)
-- Dependencies: 239
-- Name: place_id_seq; Type: SEQUENCE SET; Schema: all_flights; Owner: postgres
--

SELECT pg_catalog.setval('all_flights.place_id_seq', 19, true);


--
-- TOC entry 3488 (class 0 OID 0)
-- Dependencies: 234
-- Name: plane_id_seq; Type: SEQUENCE SET; Schema: all_flights; Owner: postgres
--

SELECT pg_catalog.setval('all_flights.plane_id_seq', 5, true);


--
-- TOC entry 3489 (class 0 OID 0)
-- Dependencies: 235
-- Name: schedule_id_seq; Type: SEQUENCE SET; Schema: all_flights; Owner: postgres
--

SELECT pg_catalog.setval('all_flights.schedule_id_seq', 6, true);


--
-- TOC entry 3490 (class 0 OID 0)
-- Dependencies: 241
-- Name: ticket_id_seq; Type: SEQUENCE SET; Schema: all_flights; Owner: postgres
--

SELECT pg_catalog.setval('all_flights.ticket_id_seq', 7, true);


--
-- TOC entry 3491 (class 0 OID 0)
-- Dependencies: 240
-- Name: transit_id_seq; Type: SEQUENCE SET; Schema: all_flights; Owner: postgres
--

SELECT pg_catalog.setval('all_flights.transit_id_seq', 11, true);


--
-- TOC entry 3247 (class 2606 OID 16405)
-- Name: airline airline_pkey; Type: CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.airline
    ADD CONSTRAINT airline_pkey PRIMARY KEY (id);


--
-- TOC entry 3251 (class 2606 OID 16415)
-- Name: airport airport_pkey; Type: CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.airport
    ADD CONSTRAINT airport_pkey PRIMARY KEY (id);


--
-- TOC entry 3249 (class 2606 OID 16410)
-- Name: brand brand_pkey; Type: CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.brand
    ADD CONSTRAINT brand_pkey PRIMARY KEY (id);


--
-- TOC entry 3239 (class 2606 OID 16572)
-- Name: brand capacity_chek; Type: CHECK CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE all_flights.brand
    ADD CONSTRAINT capacity_chek CHECK ((capacity > 0)) NOT VALID;


--
-- TOC entry 3253 (class 2606 OID 16420)
-- Name: cash_register cash_register_pkey; Type: CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.cash_register
    ADD CONSTRAINT cash_register_pkey PRIMARY KEY (id);


--
-- TOC entry 3257 (class 2606 OID 16430)
-- Name: cost cost_pkey; Type: CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.cost
    ADD CONSTRAINT cost_pkey PRIMARY KEY (id);


--
-- TOC entry 3263 (class 2606 OID 16455)
-- Name: crew_member crew_member_pkey; Type: CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.crew_member
    ADD CONSTRAINT crew_member_pkey PRIMARY KEY (id);


--
-- TOC entry 3283 (class 2606 OID 16552)
-- Name: crew crew_pkey; Type: CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.crew
    ADD CONSTRAINT crew_pkey PRIMARY KEY (id);


--
-- TOC entry 3243 (class 2606 OID 16594)
-- Name: schedule date_check; Type: CHECK CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE all_flights.schedule
    ADD CONSTRAINT date_check CHECK ((departure_date <= arrive_date)) NOT VALID;


--
-- TOC entry 3244 (class 2606 OID 24593)
-- Name: transit date_check; Type: CHECK CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE all_flights.transit
    ADD CONSTRAINT date_check CHECK ((departure_date <= arrive_date)) NOT VALID;


--
-- TOC entry 3245 (class 2606 OID 24602)
-- Name: flight flight_date_check; Type: CHECK CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE all_flights.flight
    ADD CONSTRAINT flight_date_check CHECK ((date_departure <= date_arrive)) NOT VALID;


--
-- TOC entry 3273 (class 2606 OID 16493)
-- Name: flight flight_pkey; Type: CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.flight
    ADD CONSTRAINT flight_pkey PRIMARY KEY (id);


--
-- TOC entry 3240 (class 2606 OID 16571)
-- Name: brand fuel_consumption_chek; Type: CHECK CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE all_flights.brand
    ADD CONSTRAINT fuel_consumption_chek CHECK ((fuel_consumption > 0)) NOT VALID;


--
-- TOC entry 3255 (class 2606 OID 16425)
-- Name: passanger passanger_pkey; Type: CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.passanger
    ADD CONSTRAINT passanger_pkey PRIMARY KEY (id);


--
-- TOC entry 3275 (class 2606 OID 16508)
-- Name: place place_pkey; Type: CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.place
    ADD CONSTRAINT place_pkey PRIMARY KEY (id);


--
-- TOC entry 3241 (class 2606 OID 16586)
-- Name: brand places_chek; Type: CHECK CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE all_flights.brand
    ADD CONSTRAINT places_chek CHECK ((amount_of_places > 0)) NOT VALID;


--
-- TOC entry 3266 (class 2606 OID 16466)
-- Name: schedule schedule_pkey; Type: CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (id);


--
-- TOC entry 3242 (class 2606 OID 16570)
-- Name: brand speed_chek; Type: CHECK CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE all_flights.brand
    ADD CONSTRAINT speed_chek CHECK ((speed > 0)) NOT VALID;


--
-- TOC entry 3281 (class 2606 OID 16580)
-- Name: ticket ticket_pkey; Type: CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.ticket
    ADD CONSTRAINT ticket_pkey PRIMARY KEY (id);


--
-- TOC entry 3271 (class 2606 OID 16476)
-- Name: transit transit_pkey; Type: CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.transit
    ADD CONSTRAINT transit_pkey PRIMARY KEY (id);


--
-- TOC entry 3261 (class 2606 OID 16438)
-- Name: plane Самолет_pkey; Type: CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.plane
    ADD CONSTRAINT "Самолет_pkey" PRIMARY KEY (id);


--
-- TOC entry 3284 (class 1259 OID 16600)
-- Name: fki_id_crew_member_fk; Type: INDEX; Schema: all_flights; Owner: postgres
--

CREATE INDEX fki_id_crew_member_fk ON all_flights.crew USING btree (id_crew_member);


--
-- TOC entry 3285 (class 1259 OID 24608)
-- Name: fki_id_flight_fk; Type: INDEX; Schema: all_flights; Owner: postgres
--

CREATE INDEX fki_id_flight_fk ON all_flights.crew USING btree (id_flight);


--
-- TOC entry 3267 (class 1259 OID 24599)
-- Name: fki_id_schedule_fk; Type: INDEX; Schema: all_flights; Owner: postgres
--

CREATE INDEX fki_id_schedule_fk ON all_flights.transit USING btree (id_schedule);


--
-- TOC entry 3264 (class 1259 OID 16461)
-- Name: fki_r; Type: INDEX; Schema: all_flights; Owner: postgres
--

CREATE INDEX fki_r ON all_flights.crew_member USING btree (id_airline);


--
-- TOC entry 3258 (class 1259 OID 16450)
-- Name: fki_код_авиакомпании; Type: INDEX; Schema: all_flights; Owner: postgres
--

CREATE INDEX "fki_код_авиакомпании" ON all_flights.plane USING btree (id_airline);


--
-- TOC entry 3268 (class 1259 OID 16482)
-- Name: fki_код_аэропорта; Type: INDEX; Schema: all_flights; Owner: postgres
--

CREATE INDEX "fki_код_аэропорта" ON all_flights.transit USING btree (id_airport);


--
-- TOC entry 3276 (class 1259 OID 16547)
-- Name: fki_код_кассы; Type: INDEX; Schema: all_flights; Owner: postgres
--

CREATE INDEX "fki_код_кассы" ON all_flights.ticket USING btree (id_cash_register);


--
-- TOC entry 3259 (class 1259 OID 16444)
-- Name: fki_код_марки; Type: INDEX; Schema: all_flights; Owner: postgres
--

CREATE INDEX "fki_код_марки" ON all_flights.plane USING btree (id_brand);


--
-- TOC entry 3277 (class 1259 OID 16541)
-- Name: fki_код_пассажира; Type: INDEX; Schema: all_flights; Owner: postgres
--

CREATE INDEX "fki_код_пассажира" ON all_flights.ticket USING btree (id_passanger);


--
-- TOC entry 3269 (class 1259 OID 16488)
-- Name: fki_код_расписания; Type: INDEX; Schema: all_flights; Owner: postgres
--

CREATE INDEX "fki_код_расписания" ON all_flights.transit USING btree (id_schedule);


--
-- TOC entry 3278 (class 1259 OID 16529)
-- Name: fki_код_рейса; Type: INDEX; Schema: all_flights; Owner: postgres
--

CREATE INDEX "fki_код_рейса" ON all_flights.ticket USING btree (id_flight);


--
-- TOC entry 3279 (class 1259 OID 16535)
-- Name: fki_код_стоимости; Type: INDEX; Schema: all_flights; Owner: postgres
--

CREATE INDEX "fki_код_стоимости" ON all_flights.ticket USING btree (id_cost);


--
-- TOC entry 3295 (class 2606 OID 16542)
-- Name: ticket Id_cash_register_fk; Type: FK CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.ticket
    ADD CONSTRAINT "Id_cash_register_fk" FOREIGN KEY (id_cash_register) REFERENCES all_flights.cash_register(id);


--
-- TOC entry 3296 (class 2606 OID 16530)
-- Name: ticket Id_cost_fk; Type: FK CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.ticket
    ADD CONSTRAINT "Id_cost_fk" FOREIGN KEY (id_cost) REFERENCES all_flights.cost(id);


--
-- TOC entry 3297 (class 2606 OID 16524)
-- Name: ticket Id_flight_fk; Type: FK CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.ticket
    ADD CONSTRAINT "Id_flight_fk" FOREIGN KEY (id_flight) REFERENCES all_flights.flight(id);


--
-- TOC entry 3298 (class 2606 OID 16536)
-- Name: ticket Id_passanger_fk; Type: FK CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.ticket
    ADD CONSTRAINT "Id_passanger_fk" FOREIGN KEY (id_passanger) REFERENCES all_flights.passanger(id);


--
-- TOC entry 3299 (class 2606 OID 16519)
-- Name: ticket Id_place_fk; Type: FK CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.ticket
    ADD CONSTRAINT "Id_place_fk" FOREIGN KEY (id_place) REFERENCES all_flights.place(id);


--
-- TOC entry 3286 (class 2606 OID 16445)
-- Name: plane fk_код_авиакомпании; Type: FK CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.plane
    ADD CONSTRAINT "fk_код_авиакомпании" FOREIGN KEY (id_airline) REFERENCES all_flights.airline(id);


--
-- TOC entry 3287 (class 2606 OID 16439)
-- Name: plane fk_код_марки; Type: FK CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.plane
    ADD CONSTRAINT "fk_код_марки" FOREIGN KEY (id_brand) REFERENCES all_flights.brand(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3288 (class 2606 OID 16456)
-- Name: crew_member id_airline_fk; Type: FK CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.crew_member
    ADD CONSTRAINT id_airline_fk FOREIGN KEY (id_airline) REFERENCES all_flights.airline(id);


--
-- TOC entry 3289 (class 2606 OID 16467)
-- Name: schedule id_airline_fk; Type: FK CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.schedule
    ADD CONSTRAINT id_airline_fk FOREIGN KEY (id_airport) REFERENCES all_flights.airport(id);


--
-- TOC entry 3290 (class 2606 OID 16477)
-- Name: transit id_airport_fk; Type: FK CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.transit
    ADD CONSTRAINT id_airport_fk FOREIGN KEY (id_airport) REFERENCES all_flights.airport(id);


--
-- TOC entry 3300 (class 2606 OID 16595)
-- Name: crew id_crew_member_fk; Type: FK CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.crew
    ADD CONSTRAINT id_crew_member_fk FOREIGN KEY (id_crew_member) REFERENCES all_flights.crew_member(id);


--
-- TOC entry 3294 (class 2606 OID 16509)
-- Name: place id_flight_fk; Type: FK CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.place
    ADD CONSTRAINT id_flight_fk FOREIGN KEY (id_flight) REFERENCES all_flights.flight(id);


--
-- TOC entry 3301 (class 2606 OID 24603)
-- Name: crew id_flight_fk; Type: FK CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.crew
    ADD CONSTRAINT id_flight_fk FOREIGN KEY (id_flight) REFERENCES all_flights.flight(id);


--
-- TOC entry 3292 (class 2606 OID 16494)
-- Name: flight id_plane_fk; Type: FK CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.flight
    ADD CONSTRAINT id_plane_fk FOREIGN KEY (id_plane) REFERENCES all_flights.plane(id);


--
-- TOC entry 3293 (class 2606 OID 16499)
-- Name: flight id_schedule_fk; Type: FK CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.flight
    ADD CONSTRAINT id_schedule_fk FOREIGN KEY (id_schedule) REFERENCES all_flights.schedule(id);


--
-- TOC entry 3291 (class 2606 OID 24594)
-- Name: transit id_schedule_fk; Type: FK CONSTRAINT; Schema: all_flights; Owner: postgres
--

ALTER TABLE ONLY all_flights.transit
    ADD CONSTRAINT id_schedule_fk FOREIGN KEY (id_schedule) REFERENCES all_flights.schedule(id);


-- Completed on 2023-03-21 14:23:16

--
-- PostgreSQL database dump complete
--

