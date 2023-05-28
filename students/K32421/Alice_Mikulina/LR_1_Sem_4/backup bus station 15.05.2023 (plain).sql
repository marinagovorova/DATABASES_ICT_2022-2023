--
-- PostgreSQL database dump
--

-- Dumped from database version 11.19
-- Dumped by pg_dump version 11.19

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
-- Name: bs; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA bs;


ALTER SCHEMA bs OWNER TO postgres;

--
-- Name: update_seat_number(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_seat_number() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  seat_number INT;
BEGIN
  SELECT num_seat INTO seat_number FROM bs.seat WHERE id = NEW.seat_id;
  NEW.seat_number := seat_number;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_seat_number() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: bus; Type: TABLE; Schema: bs; Owner: postgres
--

CREATE TABLE bs.bus (
    number integer NOT NULL,
    type_id integer NOT NULL,
    state_num character(128) NOT NULL,
    manufacture_year integer NOT NULL,
    CONSTRAINT manufacture_year_constraint CHECK ((manufacture_year >= 1920))
);


ALTER TABLE bs.bus OWNER TO postgres;

--
-- Name: bus_number_seq; Type: SEQUENCE; Schema: bs; Owner: postgres
--

ALTER TABLE bs.bus ALTER COLUMN number ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME bs.bus_number_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: bus_stop; Type: TABLE; Schema: bs; Owner: postgres
--

CREATE TABLE bs.bus_stop (
    id integer NOT NULL,
    address character varying(256) NOT NULL,
    name character varying(128) NOT NULL
);


ALTER TABLE bs.bus_stop OWNER TO postgres;

--
-- Name: bus_stop_id_seq; Type: SEQUENCE; Schema: bs; Owner: postgres
--

ALTER TABLE bs.bus_stop ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME bs.bus_stop_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: bus_type; Type: TABLE; Schema: bs; Owner: postgres
--

CREATE TABLE bs.bus_type (
    id integer NOT NULL,
    size character varying(20) DEFAULT 'average'::character varying NOT NULL,
    luggage_compartment character varying(3) NOT NULL,
    toilet character varying(3) NOT NULL,
    num_seats integer NOT NULL,
    brand character varying(128),
    manufacturer character varying(128),
    manufacturer_country character varying(128),
    CONSTRAINT bus_type_luggage_compartment_check CHECK (((luggage_compartment)::text = ANY ((ARRAY['yes'::character varying, 'no'::character varying])::text[]))),
    CONSTRAINT bus_type_size_check CHECK (((size)::text = ANY ((ARRAY['very small'::character varying, 'small'::character varying, 'average'::character varying, 'big'::character varying, 'very big'::character varying])::text[]))),
    CONSTRAINT bus_type_toilet_check CHECK (((toilet)::text = ANY ((ARRAY['yes'::character varying, 'no'::character varying])::text[])))
);


ALTER TABLE bs.bus_type OWNER TO postgres;

--
-- Name: bus_type_id_seq; Type: SEQUENCE; Schema: bs; Owner: postgres
--

ALTER TABLE bs.bus_type ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME bs.bus_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: crew; Type: TABLE; Schema: bs; Owner: postgres
--

CREATE TABLE bs.crew (
    id integer NOT NULL,
    med_exam_date timestamp without time zone NOT NULL,
    admission_status character varying(3) NOT NULL,
    driver_id integer NOT NULL,
    CONSTRAINT crew_admission_status_check CHECK (((admission_status)::text = ANY ((ARRAY['yes'::character varying, 'no'::character varying])::text[])))
);


ALTER TABLE bs.crew OWNER TO postgres;

--
-- Name: crew_id_seq; Type: SEQUENCE; Schema: bs; Owner: postgres
--

ALTER TABLE bs.crew ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME bs.crew_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: driver; Type: TABLE; Schema: bs; Owner: postgres
--

CREATE TABLE bs.driver (
    id integer NOT NULL,
    full_name character(128) NOT NULL,
    passport character(256) NOT NULL,
    phone_number bigint,
    e_mail character(128)
);


ALTER TABLE bs.driver OWNER TO postgres;

--
-- Name: driver_id_seq; Type: SEQUENCE; Schema: bs; Owner: postgres
--

ALTER TABLE bs.driver ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME bs.driver_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: flight; Type: TABLE; Schema: bs; Owner: postgres
--

CREATE TABLE bs.flight (
    number integer NOT NULL,
    date timestamp without time zone NOT NULL,
    departure_time time without time zone NOT NULL,
    arrival_time time without time zone NOT NULL,
    status character(128),
    bus_num integer NOT NULL,
    crew_id integer NOT NULL,
    route_id integer NOT NULL,
    CONSTRAINT arrival_departure_time_constraint CHECK ((departure_time < arrival_time)),
    CONSTRAINT flight_date_check CHECK ((date >= '2010-01-01 00:00:00'::timestamp without time zone))
);


ALTER TABLE bs.flight OWNER TO postgres;

--
-- Name: flight_number_seq; Type: SEQUENCE; Schema: bs; Owner: postgres
--

ALTER TABLE bs.flight ALTER COLUMN number ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME bs.flight_number_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: passenger; Type: TABLE; Schema: bs; Owner: postgres
--

CREATE TABLE bs.passenger (
    id integer NOT NULL,
    full_name character(128) NOT NULL,
    passport character(256) NOT NULL,
    phone_number bigint,
    e_mail character(128)
);


ALTER TABLE bs.passenger OWNER TO postgres;

--
-- Name: passenger_id_seq; Type: SEQUENCE; Schema: bs; Owner: postgres
--

ALTER TABLE bs.passenger ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME bs.passenger_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: route; Type: TABLE; Schema: bs; Owner: postgres
--

CREATE TABLE bs.route (
    id integer NOT NULL,
    weekdays text[] NOT NULL,
    distance_status character varying(13) NOT NULL,
    departure_time time without time zone NOT NULL,
    travel_time interval NOT NULL,
    departure_point character varying(128) NOT NULL,
    arrival_point character varying(128) NOT NULL,
    distance integer NOT NULL,
    CONSTRAINT distance_constraint CHECK ((distance > 0)),
    CONSTRAINT route_departure_time_check CHECK (((departure_time >= '00:00:00'::time without time zone) AND (departure_time <= '23:59:59'::time without time zone))),
    CONSTRAINT route_distance_status_check CHECK (((distance_status)::text = ANY ((ARRAY['urban'::character varying, 'suburban'::character varying, 'intercity'::character varying, 'international'::character varying])::text[]))),
    CONSTRAINT travel_time_constraint CHECK ((travel_time > '00:00:00'::interval))
);


ALTER TABLE bs.route OWNER TO postgres;

--
-- Name: route_id_seq; Type: SEQUENCE; Schema: bs; Owner: postgres
--

ALTER TABLE bs.route ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME bs.route_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: seat; Type: TABLE; Schema: bs; Owner: postgres
--

CREATE TABLE bs.seat (
    id integer NOT NULL,
    num_seat integer NOT NULL,
    taken_status character varying(3) NOT NULL,
    flight_id integer NOT NULL,
    CONSTRAINT seat_taken_status_check CHECK (((taken_status)::text = ANY ((ARRAY['yes'::character varying, 'no'::character varying])::text[])))
);


ALTER TABLE bs.seat OWNER TO postgres;

--
-- Name: seat_id_seq; Type: SEQUENCE; Schema: bs; Owner: postgres
--

ALTER TABLE bs.seat ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME bs.seat_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ticket; Type: TABLE; Schema: bs; Owner: postgres
--

CREATE TABLE bs.ticket (
    number integer NOT NULL,
    departure_time time without time zone NOT NULL,
    arrival_time time without time zone NOT NULL,
    cancellation_status character(3) NOT NULL,
    purchase_type character(7) NOT NULL,
    flight_num integer NOT NULL,
    passenger_id integer NOT NULL,
    departure_stop_id integer NOT NULL,
    arrival_stop_id integer NOT NULL,
    cost integer NOT NULL,
    seat_id integer NOT NULL,
    seat_number integer NOT NULL,
    CONSTRAINT departure_arrival_stops_constraint CHECK ((departure_stop_id <> arrival_stop_id)),
    CONSTRAINT ticket_cancellation_status_check CHECK ((cancellation_status = ANY (ARRAY['yes'::bpchar, 'no'::bpchar]))),
    CONSTRAINT ticket_purchase_type_check CHECK ((purchase_type = ANY (ARRAY['online'::bpchar, 'offline'::bpchar]))),
    CONSTRAINT time_constraint CHECK ((departure_time < arrival_time))
);


ALTER TABLE bs.ticket OWNER TO postgres;

--
-- Name: ticket_number_seq; Type: SEQUENCE; Schema: bs; Owner: postgres
--

ALTER TABLE bs.ticket ALTER COLUMN number ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME bs.ticket_number_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: way_stop; Type: TABLE; Schema: bs; Owner: postgres
--

CREATE TABLE bs.way_stop (
    id integer NOT NULL,
    global_id integer NOT NULL,
    route_id integer NOT NULL,
    departure_time time without time zone NOT NULL,
    arrival_time time without time zone NOT NULL,
    duration interval NOT NULL,
    CONSTRAINT arrival_departure_constraint CHECK ((arrival_time <= departure_time)),
    CONSTRAINT duration_constraint CHECK ((duration >= '00:00:00'::interval)),
    CONSTRAINT way_stop_departure_time_check CHECK (((departure_time >= '00:00:00'::time without time zone) AND (departure_time <= '23:59:59'::time without time zone))),
    CONSTRAINT way_stop_departure_time_check1 CHECK (((departure_time >= '00:00:00'::time without time zone) AND (departure_time <= '23:59:59'::time without time zone)))
);


ALTER TABLE bs.way_stop OWNER TO postgres;

--
-- Name: way_stop_id_seq; Type: SEQUENCE; Schema: bs; Owner: postgres
--

ALTER TABLE bs.way_stop ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME bs.way_stop_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: bus; Type: TABLE DATA; Schema: bs; Owner: postgres
--

INSERT INTO bs.bus (number, type_id, state_num, manufacture_year) OVERRIDING SYSTEM VALUE VALUES (1, 1, 'ABC123                                                                                                                          ', 2015);
INSERT INTO bs.bus (number, type_id, state_num, manufacture_year) OVERRIDING SYSTEM VALUE VALUES (2, 3, 'XYZ789                                                                                                                          ', 2018);
INSERT INTO bs.bus (number, type_id, state_num, manufacture_year) OVERRIDING SYSTEM VALUE VALUES (3, 4, 'GHI456                                                                                                                          ', 2020);
INSERT INTO bs.bus (number, type_id, state_num, manufacture_year) OVERRIDING SYSTEM VALUE VALUES (4, 5, 'JKL321                                                                                                                          ', 2016);
INSERT INTO bs.bus (number, type_id, state_num, manufacture_year) OVERRIDING SYSTEM VALUE VALUES (5, 6, 'MNO654                                                                                                                          ', 2019);
INSERT INTO bs.bus (number, type_id, state_num, manufacture_year) OVERRIDING SYSTEM VALUE VALUES (6, 7, 'PQR987                                                                                                                          ', 2017);
INSERT INTO bs.bus (number, type_id, state_num, manufacture_year) OVERRIDING SYSTEM VALUE VALUES (7, 8, 'STU246                                                                                                                          ', 2014);
INSERT INTO bs.bus (number, type_id, state_num, manufacture_year) OVERRIDING SYSTEM VALUE VALUES (8, 9, 'VWX369                                                                                                                          ', 2013);
INSERT INTO bs.bus (number, type_id, state_num, manufacture_year) OVERRIDING SYSTEM VALUE VALUES (9, 10, 'YUI852                                                                                                                          ', 2012);
INSERT INTO bs.bus (number, type_id, state_num, manufacture_year) OVERRIDING SYSTEM VALUE VALUES (10, 11, 'ZXC741                                                                                                                          ', 2011);
INSERT INTO bs.bus (number, type_id, state_num, manufacture_year) OVERRIDING SYSTEM VALUE VALUES (11, 12, 'POI098                                                                                                                          ', 2010);
INSERT INTO bs.bus (number, type_id, state_num, manufacture_year) OVERRIDING SYSTEM VALUE VALUES (12, 13, 'LKJ765                                                                                                                          ', 2009);
INSERT INTO bs.bus (number, type_id, state_num, manufacture_year) OVERRIDING SYSTEM VALUE VALUES (13, 14, 'HGF432                                                                                                                          ', 2008);
INSERT INTO bs.bus (number, type_id, state_num, manufacture_year) OVERRIDING SYSTEM VALUE VALUES (14, 15, 'EDC159                                                                                                                          ', 2007);
INSERT INTO bs.bus (number, type_id, state_num, manufacture_year) OVERRIDING SYSTEM VALUE VALUES (15, 16, 'QAZ246                                                                                                                          ', 2006);
INSERT INTO bs.bus (number, type_id, state_num, manufacture_year) OVERRIDING SYSTEM VALUE VALUES (16, 17, 'WSX369                                                                                                                          ', 2005);
INSERT INTO bs.bus (number, type_id, state_num, manufacture_year) OVERRIDING SYSTEM VALUE VALUES (17, 18, 'RFV852                                                                                                                          ', 2004);


--
-- Data for Name: bus_stop; Type: TABLE DATA; Schema: bs; Owner: postgres
--

INSERT INTO bs.bus_stop (id, address, name) OVERRIDING SYSTEM VALUE VALUES (1, '123 Main St.', 'Main St. and 1st Ave.');
INSERT INTO bs.bus_stop (id, address, name) OVERRIDING SYSTEM VALUE VALUES (2, '456 Elm St.', 'Elm St. and 2nd Ave.');
INSERT INTO bs.bus_stop (id, address, name) OVERRIDING SYSTEM VALUE VALUES (3, '789 Oak St.', 'Oak St. and 3rd Ave.');
INSERT INTO bs.bus_stop (id, address, name) OVERRIDING SYSTEM VALUE VALUES (4, '1011 Maple St.', 'Maple St. and 4th Ave.');
INSERT INTO bs.bus_stop (id, address, name) OVERRIDING SYSTEM VALUE VALUES (5, '1213 Pine St.', 'Pine St. and 5th Ave.');
INSERT INTO bs.bus_stop (id, address, name) OVERRIDING SYSTEM VALUE VALUES (6, '1415 Cedar St.', 'Cedar St. and 6th Ave.');
INSERT INTO bs.bus_stop (id, address, name) OVERRIDING SYSTEM VALUE VALUES (7, '1617 Birch St.', 'Birch St. and 7th Ave.');
INSERT INTO bs.bus_stop (id, address, name) OVERRIDING SYSTEM VALUE VALUES (8, '1819 Walnut St.', 'Walnut St. and 8th Ave.');
INSERT INTO bs.bus_stop (id, address, name) OVERRIDING SYSTEM VALUE VALUES (9, '2021 Cherry St.', 'Cherry St. and 9th Ave.');
INSERT INTO bs.bus_stop (id, address, name) OVERRIDING SYSTEM VALUE VALUES (10, '2223 Poplar St.', 'Poplar St. and 10th Ave.');
INSERT INTO bs.bus_stop (id, address, name) OVERRIDING SYSTEM VALUE VALUES (11, '2425 Chestnut St.', 'Chestnut St. and 11th Ave.');
INSERT INTO bs.bus_stop (id, address, name) OVERRIDING SYSTEM VALUE VALUES (12, '2627 Spruce St.', 'Spruce St. and 12th Ave.');
INSERT INTO bs.bus_stop (id, address, name) OVERRIDING SYSTEM VALUE VALUES (13, '2829 Sycamore St.', 'Sycamore St. and 13th Ave.');
INSERT INTO bs.bus_stop (id, address, name) OVERRIDING SYSTEM VALUE VALUES (14, '3031 Pine St.', 'Pine St. and 14th Ave.');
INSERT INTO bs.bus_stop (id, address, name) OVERRIDING SYSTEM VALUE VALUES (15, '3233 Maple St.', 'Maple St. and 15th Ave.');
INSERT INTO bs.bus_stop (id, address, name) OVERRIDING SYSTEM VALUE VALUES (16, '3435 Oak St.', 'Oak St. and 16th Ave.');
INSERT INTO bs.bus_stop (id, address, name) OVERRIDING SYSTEM VALUE VALUES (17, '3637 Elm St.', 'Elm St. and 17th Ave.');
INSERT INTO bs.bus_stop (id, address, name) OVERRIDING SYSTEM VALUE VALUES (18, '3839 Main St.', 'Main St. and 18th Ave.');
INSERT INTO bs.bus_stop (id, address, name) OVERRIDING SYSTEM VALUE VALUES (19, '4041 Walnut St.', 'Walnut St. and 19th Ave.');
INSERT INTO bs.bus_stop (id, address, name) OVERRIDING SYSTEM VALUE VALUES (20, '4243 Cherry St.', 'Cherry St. and 20th Ave.');


--
-- Data for Name: bus_type; Type: TABLE DATA; Schema: bs; Owner: postgres
--

INSERT INTO bs.bus_type (id, size, luggage_compartment, toilet, num_seats, brand, manufacturer, manufacturer_country) OVERRIDING SYSTEM VALUE VALUES (1, 'big', 'yes', 'yes', 50, 'Mercedes', 'Daimler AG', 'Germany');
INSERT INTO bs.bus_type (id, size, luggage_compartment, toilet, num_seats, brand, manufacturer, manufacturer_country) OVERRIDING SYSTEM VALUE VALUES (3, 'average', 'yes', 'yes', 30, 'Volvo', 'Volvo Buses', 'Sweden');
INSERT INTO bs.bus_type (id, size, luggage_compartment, toilet, num_seats, brand, manufacturer, manufacturer_country) OVERRIDING SYSTEM VALUE VALUES (4, 'small', 'no', 'no', 20, 'Volkswagen', 'Volkswagen Commercial Vehicles', 'Germany');
INSERT INTO bs.bus_type (id, size, luggage_compartment, toilet, num_seats, brand, manufacturer, manufacturer_country) OVERRIDING SYSTEM VALUE VALUES (5, 'very big', 'yes', 'yes', 75, 'Scania', 'Scania AB', 'Sweden');
INSERT INTO bs.bus_type (id, size, luggage_compartment, toilet, num_seats, brand, manufacturer, manufacturer_country) OVERRIDING SYSTEM VALUE VALUES (6, 'average', 'no', 'no', 40, 'MAN', 'MAN Truck & Bus', 'Germany');
INSERT INTO bs.bus_type (id, size, luggage_compartment, toilet, num_seats, brand, manufacturer, manufacturer_country) OVERRIDING SYSTEM VALUE VALUES (7, 'big', 'yes', 'yes', 55, 'Iveco', 'Iveco Bus', 'Italy');
INSERT INTO bs.bus_type (id, size, luggage_compartment, toilet, num_seats, brand, manufacturer, manufacturer_country) OVERRIDING SYSTEM VALUE VALUES (8, 'average', 'yes', 'no', 35, 'Neoplan', 'Neoplan Bus GmbH', 'Germany');
INSERT INTO bs.bus_type (id, size, luggage_compartment, toilet, num_seats, brand, manufacturer, manufacturer_country) OVERRIDING SYSTEM VALUE VALUES (9, 'small', 'no', 'no', 25, 'Opel', 'Opel/Vauxhall', 'Germany');
INSERT INTO bs.bus_type (id, size, luggage_compartment, toilet, num_seats, brand, manufacturer, manufacturer_country) OVERRIDING SYSTEM VALUE VALUES (10, 'very small', 'no', 'no', 15, 'Peugeot', 'Peugeot S.A.', 'France');
INSERT INTO bs.bus_type (id, size, luggage_compartment, toilet, num_seats, brand, manufacturer, manufacturer_country) OVERRIDING SYSTEM VALUE VALUES (11, 'big', 'yes', 'yes', 60, 'Setra', 'Setra Buses and Coaches', 'Germany');
INSERT INTO bs.bus_type (id, size, luggage_compartment, toilet, num_seats, brand, manufacturer, manufacturer_country) OVERRIDING SYSTEM VALUE VALUES (12, 'average', 'yes', 'yes', 30, 'Van Hool', 'Van Hool N.V.', 'Belgium');
INSERT INTO bs.bus_type (id, size, luggage_compartment, toilet, num_seats, brand, manufacturer, manufacturer_country) OVERRIDING SYSTEM VALUE VALUES (13, 'big', 'yes', 'yes', 65, 'Dennis', 'Dennis Specialist Vehicles', 'United Kingdom');
INSERT INTO bs.bus_type (id, size, luggage_compartment, toilet, num_seats, brand, manufacturer, manufacturer_country) OVERRIDING SYSTEM VALUE VALUES (14, 'average', 'no', 'no', 40, 'Ashok Leyland', 'Ashok Leyland Limited', 'India');
INSERT INTO bs.bus_type (id, size, luggage_compartment, toilet, num_seats, brand, manufacturer, manufacturer_country) OVERRIDING SYSTEM VALUE VALUES (15, 'very big', 'yes', 'yes', 80, 'MCI', 'Motor Coach Industries', 'Canada');
INSERT INTO bs.bus_type (id, size, luggage_compartment, toilet, num_seats, brand, manufacturer, manufacturer_country) OVERRIDING SYSTEM VALUE VALUES (16, 'average', 'yes', 'yes', 35, 'Orion', 'Orion Bus Industries', 'Canada');
INSERT INTO bs.bus_type (id, size, luggage_compartment, toilet, num_seats, brand, manufacturer, manufacturer_country) OVERRIDING SYSTEM VALUE VALUES (17, 'very small', 'no', 'no', 12, 'Isuzu', 'Isuzu Motors', 'Japan');
INSERT INTO bs.bus_type (id, size, luggage_compartment, toilet, num_seats, brand, manufacturer, manufacturer_country) OVERRIDING SYSTEM VALUE VALUES (18, 'big', 'yes', 'yes', 70, 'Bova', 'Bova', 'Netherlands');


--
-- Data for Name: crew; Type: TABLE DATA; Schema: bs; Owner: postgres
--

INSERT INTO bs.crew (id, med_exam_date, admission_status, driver_id) OVERRIDING SYSTEM VALUE VALUES (1, '2022-01-01 10:00:00', 'yes', 1);
INSERT INTO bs.crew (id, med_exam_date, admission_status, driver_id) OVERRIDING SYSTEM VALUE VALUES (2, '2022-01-02 11:00:00', 'no', 2);
INSERT INTO bs.crew (id, med_exam_date, admission_status, driver_id) OVERRIDING SYSTEM VALUE VALUES (3, '2022-01-03 12:00:00', 'yes', 3);
INSERT INTO bs.crew (id, med_exam_date, admission_status, driver_id) OVERRIDING SYSTEM VALUE VALUES (4, '2022-01-04 13:00:00', 'yes', 4);
INSERT INTO bs.crew (id, med_exam_date, admission_status, driver_id) OVERRIDING SYSTEM VALUE VALUES (5, '2022-01-05 14:00:00', 'no', 5);
INSERT INTO bs.crew (id, med_exam_date, admission_status, driver_id) OVERRIDING SYSTEM VALUE VALUES (6, '2022-01-06 15:00:00', 'no', 6);
INSERT INTO bs.crew (id, med_exam_date, admission_status, driver_id) OVERRIDING SYSTEM VALUE VALUES (7, '2022-01-07 16:00:00', 'yes', 7);
INSERT INTO bs.crew (id, med_exam_date, admission_status, driver_id) OVERRIDING SYSTEM VALUE VALUES (8, '2022-01-08 17:00:00', 'yes', 8);
INSERT INTO bs.crew (id, med_exam_date, admission_status, driver_id) OVERRIDING SYSTEM VALUE VALUES (9, '2022-01-09 18:00:00', 'yes', 9);
INSERT INTO bs.crew (id, med_exam_date, admission_status, driver_id) OVERRIDING SYSTEM VALUE VALUES (10, '2022-01-10 19:00:00', 'no', 10);
INSERT INTO bs.crew (id, med_exam_date, admission_status, driver_id) OVERRIDING SYSTEM VALUE VALUES (11, '2022-01-11 20:00:00', 'yes', 11);
INSERT INTO bs.crew (id, med_exam_date, admission_status, driver_id) OVERRIDING SYSTEM VALUE VALUES (12, '2022-01-12 21:00:00', 'no', 12);
INSERT INTO bs.crew (id, med_exam_date, admission_status, driver_id) OVERRIDING SYSTEM VALUE VALUES (13, '2022-01-13 22:00:00', 'yes', 13);
INSERT INTO bs.crew (id, med_exam_date, admission_status, driver_id) OVERRIDING SYSTEM VALUE VALUES (14, '2022-01-14 23:00:00', 'yes', 14);
INSERT INTO bs.crew (id, med_exam_date, admission_status, driver_id) OVERRIDING SYSTEM VALUE VALUES (15, '2022-01-15 10:00:00', 'no', 15);
INSERT INTO bs.crew (id, med_exam_date, admission_status, driver_id) OVERRIDING SYSTEM VALUE VALUES (16, '2022-01-16 01:00:00', 'yes', 16);


--
-- Data for Name: driver; Type: TABLE DATA; Schema: bs; Owner: postgres
--

INSERT INTO bs.driver (id, full_name, passport, phone_number, e_mail) OVERRIDING SYSTEM VALUE VALUES (1, 'Ivanov Matvey Sergeevich                                                                                                        ', '0987 654321, given in Saratov oblast                                                                                                                                                                                                                            ', 89198358347, 'mrjoulin@yandex.ru                                                                                                              ');
INSERT INTO bs.driver (id, full_name, passport, phone_number, e_mail) OVERRIDING SYSTEM VALUE VALUES (2, 'Ivan Ivanov                                                                                                                     ', '1234567890                                                                                                                                                                                                                                                      ', 79123456789, 'ivanov@mail.com                                                                                                                 ');
INSERT INTO bs.driver (id, full_name, passport, phone_number, e_mail) OVERRIDING SYSTEM VALUE VALUES (3, 'Dmitry Petrov                                                                                                                   ', '0987654321                                                                                                                                                                                                                                                      ', 79234567890, 'petrov@mail.com                                                                                                                 ');
INSERT INTO bs.driver (id, full_name, passport, phone_number, e_mail) OVERRIDING SYSTEM VALUE VALUES (4, 'Sergey Sidorov                                                                                                                  ', '1111111111                                                                                                                                                                                                                                                      ', 79345678901, 'sidorov@mail.com                                                                                                                ');
INSERT INTO bs.driver (id, full_name, passport, phone_number, e_mail) OVERRIDING SYSTEM VALUE VALUES (5, 'Maria Ivanova                                                                                                                   ', '2222222222                                                                                                                                                                                                                                                      ', 79456789012, 'ivanova@mail.com                                                                                                                ');
INSERT INTO bs.driver (id, full_name, passport, phone_number, e_mail) OVERRIDING SYSTEM VALUE VALUES (6, 'Anna Petrova                                                                                                                    ', '3333333333                                                                                                                                                                                                                                                      ', 79567890123, 'petrova@mail.com                                                                                                                ');
INSERT INTO bs.driver (id, full_name, passport, phone_number, e_mail) OVERRIDING SYSTEM VALUE VALUES (7, 'Olga Sidorova                                                                                                                   ', '4444444444                                                                                                                                                                                                                                                      ', 79678901234, 'sidorova@mail.com                                                                                                               ');
INSERT INTO bs.driver (id, full_name, passport, phone_number, e_mail) OVERRIDING SYSTEM VALUE VALUES (8, 'Pavel Ivanov                                                                                                                    ', '5555555555                                                                                                                                                                                                                                                      ', 79789012345, 'pavel@mail.com                                                                                                                  ');
INSERT INTO bs.driver (id, full_name, passport, phone_number, e_mail) OVERRIDING SYSTEM VALUE VALUES (9, 'Maxim Petrov                                                                                                                    ', '6666666666                                                                                                                                                                                                                                                      ', 79890123456, 'maxim@mail.com                                                                                                                  ');
INSERT INTO bs.driver (id, full_name, passport, phone_number, e_mail) OVERRIDING SYSTEM VALUE VALUES (10, 'Irina Sidorova                                                                                                                  ', '7777777777                                                                                                                                                                                                                                                      ', 79901234567, 'irina@mail.com                                                                                                                  ');
INSERT INTO bs.driver (id, full_name, passport, phone_number, e_mail) OVERRIDING SYSTEM VALUE VALUES (11, 'Elena Ivanova                                                                                                                   ', '8888888888                                                                                                                                                                                                                                                      ', 70012345678, 'elena@mail.com                                                                                                                  ');
INSERT INTO bs.driver (id, full_name, passport, phone_number, e_mail) OVERRIDING SYSTEM VALUE VALUES (12, 'Nikita Petrov                                                                                                                   ', '9999999999                                                                                                                                                                                                                                                      ', 70123456789, 'nikita@mail.com                                                                                                                 ');
INSERT INTO bs.driver (id, full_name, passport, phone_number, e_mail) OVERRIDING SYSTEM VALUE VALUES (13, 'Vladimir Sidorov                                                                                                                ', '0000000001                                                                                                                                                                                                                                                      ', 70234567890, 'vladimir@mail.com                                                                                                               ');
INSERT INTO bs.driver (id, full_name, passport, phone_number, e_mail) OVERRIDING SYSTEM VALUE VALUES (14, 'Alexey Ivanov                                                                                                                   ', '0000000002                                                                                                                                                                                                                                                      ', 70345678901, 'alexey@mail.com                                                                                                                 ');
INSERT INTO bs.driver (id, full_name, passport, phone_number, e_mail) OVERRIDING SYSTEM VALUE VALUES (15, 'Svetlana Petrova                                                                                                                ', '0000000003                                                                                                                                                                                                                                                      ', 70456789012, 'svetlana@mail.com                                                                                                               ');
INSERT INTO bs.driver (id, full_name, passport, phone_number, e_mail) OVERRIDING SYSTEM VALUE VALUES (16, 'Ekaterina Sidorova                                                                                                              ', '0000000004                                                                                                                                                                                                                                                      ', 70567890123, 'ekaterina@mail.com                                                                                                              ');


--
-- Data for Name: flight; Type: TABLE DATA; Schema: bs; Owner: postgres
--

INSERT INTO bs.flight (number, date, departure_time, arrival_time, status, bus_num, crew_id, route_id) OVERRIDING SYSTEM VALUE VALUES (8, '2022-01-01 00:00:00', '10:00:00', '12:00:00', 'scheduled                                                                                                                       ', 1, 1, 1);
INSERT INTO bs.flight (number, date, departure_time, arrival_time, status, bus_num, crew_id, route_id) OVERRIDING SYSTEM VALUE VALUES (9, '2022-01-02 00:00:00', '12:00:00', '14:00:00', 'scheduled                                                                                                                       ', 2, 2, 2);
INSERT INTO bs.flight (number, date, departure_time, arrival_time, status, bus_num, crew_id, route_id) OVERRIDING SYSTEM VALUE VALUES (10, '2022-01-03 00:00:00', '14:00:00', '16:00:00', 'scheduled                                                                                                                       ', 3, 3, 3);
INSERT INTO bs.flight (number, date, departure_time, arrival_time, status, bus_num, crew_id, route_id) OVERRIDING SYSTEM VALUE VALUES (11, '2022-01-04 00:00:00', '16:00:00', '18:00:00', 'scheduled                                                                                                                       ', 4, 4, 4);
INSERT INTO bs.flight (number, date, departure_time, arrival_time, status, bus_num, crew_id, route_id) OVERRIDING SYSTEM VALUE VALUES (12, '2022-01-05 00:00:00', '18:00:00', '20:00:00', 'scheduled                                                                                                                       ', 5, 5, 5);
INSERT INTO bs.flight (number, date, departure_time, arrival_time, status, bus_num, crew_id, route_id) OVERRIDING SYSTEM VALUE VALUES (13, '2022-01-06 00:00:00', '20:00:00', '22:00:00', 'scheduled                                                                                                                       ', 6, 6, 6);
INSERT INTO bs.flight (number, date, departure_time, arrival_time, status, bus_num, crew_id, route_id) OVERRIDING SYSTEM VALUE VALUES (14, '2022-01-07 00:00:00', '22:00:00', '23:00:00', 'scheduled                                                                                                                       ', 7, 7, 7);
INSERT INTO bs.flight (number, date, departure_time, arrival_time, status, bus_num, crew_id, route_id) OVERRIDING SYSTEM VALUE VALUES (15, '2022-01-08 00:00:00', '00:00:00', '02:00:00', 'scheduled                                                                                                                       ', 8, 8, 1);
INSERT INTO bs.flight (number, date, departure_time, arrival_time, status, bus_num, crew_id, route_id) OVERRIDING SYSTEM VALUE VALUES (16, '2022-01-09 00:00:00', '02:00:00', '04:00:00', 'scheduled                                                                                                                       ', 9, 9, 2);
INSERT INTO bs.flight (number, date, departure_time, arrival_time, status, bus_num, crew_id, route_id) OVERRIDING SYSTEM VALUE VALUES (17, '2022-01-10 00:00:00', '04:00:00', '06:00:00', 'scheduled                                                                                                                       ', 10, 10, 3);
INSERT INTO bs.flight (number, date, departure_time, arrival_time, status, bus_num, crew_id, route_id) OVERRIDING SYSTEM VALUE VALUES (18, '2022-01-11 00:00:00', '06:00:00', '08:00:00', 'scheduled                                                                                                                       ', 11, 11, 4);
INSERT INTO bs.flight (number, date, departure_time, arrival_time, status, bus_num, crew_id, route_id) OVERRIDING SYSTEM VALUE VALUES (19, '2022-01-12 00:00:00', '08:00:00', '10:00:00', 'scheduled                                                                                                                       ', 12, 12, 5);
INSERT INTO bs.flight (number, date, departure_time, arrival_time, status, bus_num, crew_id, route_id) OVERRIDING SYSTEM VALUE VALUES (20, '2022-01-13 00:00:00', '10:00:00', '12:00:00', 'scheduled                                                                                                                       ', 13, 13, 6);
INSERT INTO bs.flight (number, date, departure_time, arrival_time, status, bus_num, crew_id, route_id) OVERRIDING SYSTEM VALUE VALUES (21, '2022-01-14 00:00:00', '12:00:00', '14:00:00', 'scheduled                                                                                                                       ', 14, 14, 7);
INSERT INTO bs.flight (number, date, departure_time, arrival_time, status, bus_num, crew_id, route_id) OVERRIDING SYSTEM VALUE VALUES (22, '2022-01-15 00:00:00', '14:00:00', '16:00:00', 'scheduled                                                                                                                       ', 15, 15, 1);
INSERT INTO bs.flight (number, date, departure_time, arrival_time, status, bus_num, crew_id, route_id) OVERRIDING SYSTEM VALUE VALUES (23, '2022-01-16 00:00:00', '16:00:00', '18:00:00', 'scheduled                                                                                                                       ', 16, 16, 2);
INSERT INTO bs.flight (number, date, departure_time, arrival_time, status, bus_num, crew_id, route_id) OVERRIDING SYSTEM VALUE VALUES (24, '2022-01-17 00:00:00', '18:00:00', '20:00:00', 'scheduled                                                                                                                       ', 17, 1, 3);
INSERT INTO bs.flight (number, date, departure_time, arrival_time, status, bus_num, crew_id, route_id) OVERRIDING SYSTEM VALUE VALUES (25, '2022-01-18 00:00:00', '20:00:00', '22:00:00', 'scheduled                                                                                                                       ', 1, 2, 4);


--
-- Data for Name: passenger; Type: TABLE DATA; Schema: bs; Owner: postgres
--

INSERT INTO bs.passenger (id, full_name, passport, phone_number, e_mail) OVERRIDING SYSTEM VALUE VALUES (1, 'Mikulina Alice Romanovna                                                                                                        ', '6117 002651, given in Ryazan oblast                                                                                                                                                                                                                             ', 89036417779, 'alisa.mikulina@yandex.ru                                                                                                        ');
INSERT INTO bs.passenger (id, full_name, passport, phone_number, e_mail) OVERRIDING SYSTEM VALUE VALUES (2, 'Pankova Christina Sergeevna                                                                                                     ', '1234 567890, given in Moscow oblast                                                                                                                                                                                                                             ', 89772852541, 'punkris@yandex.ru                                                                                                               ');


--
-- Data for Name: route; Type: TABLE DATA; Schema: bs; Owner: postgres
--

INSERT INTO bs.route (id, weekdays, distance_status, departure_time, travel_time, departure_point, arrival_point, distance) OVERRIDING SYSTEM VALUE VALUES (1, '{Monday,Wednesday,Friday}', 'urban', '08:00:00', '01:30:00', 'City Center', 'Suburbia', 30);
INSERT INTO bs.route (id, weekdays, distance_status, departure_time, travel_time, departure_point, arrival_point, distance) OVERRIDING SYSTEM VALUE VALUES (2, '{Tuesday,Thursday}', 'suburban', '09:30:00', '02:00:00', 'Suburbia', 'City Center', 40);
INSERT INTO bs.route (id, weekdays, distance_status, departure_time, travel_time, departure_point, arrival_point, distance) OVERRIDING SYSTEM VALUE VALUES (3, '{Monday,Wednesday,Friday,Sunday}', 'intercity', '13:00:00', '03:30:00', 'City A', 'City B', 200);
INSERT INTO bs.route (id, weekdays, distance_status, departure_time, travel_time, departure_point, arrival_point, distance) OVERRIDING SYSTEM VALUE VALUES (4, '{Tuesday,Thursday,Saturday}', 'intercity', '10:00:00', '04:00:00', 'City B', 'City C', 250);
INSERT INTO bs.route (id, weekdays, distance_status, departure_time, travel_time, departure_point, arrival_point, distance) OVERRIDING SYSTEM VALUE VALUES (5, '{Monday,Wednesday,Friday,Sunday}', 'international', '06:00:00', '10:00:00', 'City A', 'City D', 1000);
INSERT INTO bs.route (id, weekdays, distance_status, departure_time, travel_time, departure_point, arrival_point, distance) OVERRIDING SYSTEM VALUE VALUES (6, '{Tuesday,Thursday,Saturday}', 'international', '12:00:00', '12:00:00', 'City C', 'City D', 1500);
INSERT INTO bs.route (id, weekdays, distance_status, departure_time, travel_time, departure_point, arrival_point, distance) OVERRIDING SYSTEM VALUE VALUES (7, '{Monday}', 'urban', '07:30:00', '00:45:00', 'City Center', 'Business District', 10);


--
-- Data for Name: seat; Type: TABLE DATA; Schema: bs; Owner: postgres
--

INSERT INTO bs.seat (id, num_seat, taken_status, flight_id) OVERRIDING SYSTEM VALUE VALUES (1, 1, 'yes', 23);
INSERT INTO bs.seat (id, num_seat, taken_status, flight_id) OVERRIDING SYSTEM VALUE VALUES (2, 2, 'no', 23);
INSERT INTO bs.seat (id, num_seat, taken_status, flight_id) OVERRIDING SYSTEM VALUE VALUES (3, 3, 'yes', 23);
INSERT INTO bs.seat (id, num_seat, taken_status, flight_id) OVERRIDING SYSTEM VALUE VALUES (4, 4, 'no', 23);
INSERT INTO bs.seat (id, num_seat, taken_status, flight_id) OVERRIDING SYSTEM VALUE VALUES (5, 5, 'yes', 23);
INSERT INTO bs.seat (id, num_seat, taken_status, flight_id) OVERRIDING SYSTEM VALUE VALUES (6, 6, 'no', 23);
INSERT INTO bs.seat (id, num_seat, taken_status, flight_id) OVERRIDING SYSTEM VALUE VALUES (7, 7, 'yes', 23);
INSERT INTO bs.seat (id, num_seat, taken_status, flight_id) OVERRIDING SYSTEM VALUE VALUES (8, 8, 'no', 23);
INSERT INTO bs.seat (id, num_seat, taken_status, flight_id) OVERRIDING SYSTEM VALUE VALUES (9, 9, 'yes', 23);
INSERT INTO bs.seat (id, num_seat, taken_status, flight_id) OVERRIDING SYSTEM VALUE VALUES (10, 10, 'no', 23);
INSERT INTO bs.seat (id, num_seat, taken_status, flight_id) OVERRIDING SYSTEM VALUE VALUES (11, 11, 'yes', 23);
INSERT INTO bs.seat (id, num_seat, taken_status, flight_id) OVERRIDING SYSTEM VALUE VALUES (12, 12, 'no', 23);


--
-- Data for Name: ticket; Type: TABLE DATA; Schema: bs; Owner: postgres
--

INSERT INTO bs.ticket (number, departure_time, arrival_time, cancellation_status, purchase_type, flight_num, passenger_id, departure_stop_id, arrival_stop_id, cost, seat_id, seat_number) OVERRIDING SYSTEM VALUE VALUES (1, '09:30:00', '11:30:00', 'no ', 'online ', 23, 1, 3, 16, 400, 1, 1);
INSERT INTO bs.ticket (number, departure_time, arrival_time, cancellation_status, purchase_type, flight_num, passenger_id, departure_stop_id, arrival_stop_id, cost, seat_id, seat_number) OVERRIDING SYSTEM VALUE VALUES (2, '09:30:00', '11:30:00', 'no ', 'online ', 23, 1, 3, 16, 400, 3, 3);
INSERT INTO bs.ticket (number, departure_time, arrival_time, cancellation_status, purchase_type, flight_num, passenger_id, departure_stop_id, arrival_stop_id, cost, seat_id, seat_number) OVERRIDING SYSTEM VALUE VALUES (3, '09:30:00', '11:30:00', 'no ', 'offline', 23, 1, 3, 16, 400, 5, 5);
INSERT INTO bs.ticket (number, departure_time, arrival_time, cancellation_status, purchase_type, flight_num, passenger_id, departure_stop_id, arrival_stop_id, cost, seat_id, seat_number) OVERRIDING SYSTEM VALUE VALUES (4, '09:30:00', '11:30:00', 'no ', 'online ', 23, 1, 3, 16, 400, 7, 7);
INSERT INTO bs.ticket (number, departure_time, arrival_time, cancellation_status, purchase_type, flight_num, passenger_id, departure_stop_id, arrival_stop_id, cost, seat_id, seat_number) OVERRIDING SYSTEM VALUE VALUES (5, '09:30:00', '11:30:00', 'no ', 'offline', 23, 1, 3, 16, 400, 9, 9);
INSERT INTO bs.ticket (number, departure_time, arrival_time, cancellation_status, purchase_type, flight_num, passenger_id, departure_stop_id, arrival_stop_id, cost, seat_id, seat_number) OVERRIDING SYSTEM VALUE VALUES (6, '09:30:00', '11:30:00', 'no ', 'online ', 23, 1, 3, 16, 400, 11, 11);


--
-- Data for Name: way_stop; Type: TABLE DATA; Schema: bs; Owner: postgres
--

INSERT INTO bs.way_stop (id, global_id, route_id, departure_time, arrival_time, duration) OVERRIDING SYSTEM VALUE VALUES (1, 1, 1, '08:12:00', '08:10:00', '00:02:00');
INSERT INTO bs.way_stop (id, global_id, route_id, departure_time, arrival_time, duration) OVERRIDING SYSTEM VALUE VALUES (3, 5, 6, '14:40:00', '14:20:00', '00:20:00');


--
-- Name: bus_number_seq; Type: SEQUENCE SET; Schema: bs; Owner: postgres
--

SELECT pg_catalog.setval('bs.bus_number_seq', 17, true);


--
-- Name: bus_stop_id_seq; Type: SEQUENCE SET; Schema: bs; Owner: postgres
--

SELECT pg_catalog.setval('bs.bus_stop_id_seq', 20, true);


--
-- Name: bus_type_id_seq; Type: SEQUENCE SET; Schema: bs; Owner: postgres
--

SELECT pg_catalog.setval('bs.bus_type_id_seq', 18, true);


--
-- Name: crew_id_seq; Type: SEQUENCE SET; Schema: bs; Owner: postgres
--

SELECT pg_catalog.setval('bs.crew_id_seq', 16, true);


--
-- Name: driver_id_seq; Type: SEQUENCE SET; Schema: bs; Owner: postgres
--

SELECT pg_catalog.setval('bs.driver_id_seq', 16, true);


--
-- Name: flight_number_seq; Type: SEQUENCE SET; Schema: bs; Owner: postgres
--

SELECT pg_catalog.setval('bs.flight_number_seq', 25, true);


--
-- Name: passenger_id_seq; Type: SEQUENCE SET; Schema: bs; Owner: postgres
--

SELECT pg_catalog.setval('bs.passenger_id_seq', 2, true);


--
-- Name: route_id_seq; Type: SEQUENCE SET; Schema: bs; Owner: postgres
--

SELECT pg_catalog.setval('bs.route_id_seq', 7, true);


--
-- Name: seat_id_seq; Type: SEQUENCE SET; Schema: bs; Owner: postgres
--

SELECT pg_catalog.setval('bs.seat_id_seq', 12, true);


--
-- Name: ticket_number_seq; Type: SEQUENCE SET; Schema: bs; Owner: postgres
--

SELECT pg_catalog.setval('bs.ticket_number_seq', 6, true);


--
-- Name: way_stop_id_seq; Type: SEQUENCE SET; Schema: bs; Owner: postgres
--

SELECT pg_catalog.setval('bs.way_stop_id_seq', 3, true);


--
-- Name: bus bus_number_pkey; Type: CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.bus
    ADD CONSTRAINT bus_number_pkey PRIMARY KEY (number);


--
-- Name: bus_stop bus_stop_pkey; Type: CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.bus_stop
    ADD CONSTRAINT bus_stop_pkey PRIMARY KEY (id);


--
-- Name: bus_type bus_type_pkey; Type: CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.bus_type
    ADD CONSTRAINT bus_type_pkey PRIMARY KEY (id);


--
-- Name: crew crew_pkey; Type: CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.crew
    ADD CONSTRAINT crew_pkey PRIMARY KEY (id);


--
-- Name: driver driver_pkey; Type: CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.driver
    ADD CONSTRAINT driver_pkey PRIMARY KEY (id);


--
-- Name: flight flight_pkey; Type: CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.flight
    ADD CONSTRAINT flight_pkey PRIMARY KEY (number);


--
-- Name: passenger passenger_pkey; Type: CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.passenger
    ADD CONSTRAINT passenger_pkey PRIMARY KEY (id);


--
-- Name: route route_pkey; Type: CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.route
    ADD CONSTRAINT route_pkey PRIMARY KEY (id);


--
-- Name: seat seat_pkey; Type: CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.seat
    ADD CONSTRAINT seat_pkey PRIMARY KEY (id);


--
-- Name: ticket ticket_pkey; Type: CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.ticket
    ADD CONSTRAINT ticket_pkey PRIMARY KEY (number);


--
-- Name: driver unique_d_email; Type: CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.driver
    ADD CONSTRAINT unique_d_email UNIQUE (e_mail);


--
-- Name: driver unique_d_passport; Type: CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.driver
    ADD CONSTRAINT unique_d_passport UNIQUE (passport);


--
-- Name: driver unique_d_phone; Type: CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.driver
    ADD CONSTRAINT unique_d_phone UNIQUE (phone_number);


--
-- Name: passenger unique_p_email; Type: CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.passenger
    ADD CONSTRAINT unique_p_email UNIQUE (e_mail);


--
-- Name: passenger unique_p_passport; Type: CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.passenger
    ADD CONSTRAINT unique_p_passport UNIQUE (passport);


--
-- Name: passenger unique_p_phone; Type: CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.passenger
    ADD CONSTRAINT unique_p_phone UNIQUE (phone_number);


--
-- Name: way_stop way_stop_pkey; Type: CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.way_stop
    ADD CONSTRAINT way_stop_pkey PRIMARY KEY (id);


--
-- Name: ticket seatnumbertrigger; Type: TRIGGER; Schema: bs; Owner: postgres
--

CREATE TRIGGER seatnumbertrigger BEFORE INSERT ON bs.ticket FOR EACH ROW EXECUTE PROCEDURE public.update_seat_number();


--
-- Name: bus bus_type_id_fkey; Type: FK CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.bus
    ADD CONSTRAINT bus_type_id_fkey FOREIGN KEY (type_id) REFERENCES bs.bus_type(id);


--
-- Name: crew crew_driver_id_fkey; Type: FK CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.crew
    ADD CONSTRAINT crew_driver_id_fkey FOREIGN KEY (driver_id) REFERENCES bs.driver(id);


--
-- Name: flight flight_bus_num_fkey; Type: FK CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.flight
    ADD CONSTRAINT flight_bus_num_fkey FOREIGN KEY (bus_num) REFERENCES bs.bus(number);


--
-- Name: flight flight_crew_id_fkey; Type: FK CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.flight
    ADD CONSTRAINT flight_crew_id_fkey FOREIGN KEY (crew_id) REFERENCES bs.crew(id);


--
-- Name: flight flight_route_id_fkey; Type: FK CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.flight
    ADD CONSTRAINT flight_route_id_fkey FOREIGN KEY (route_id) REFERENCES bs.route(id);


--
-- Name: seat seat_flight_id_fkey; Type: FK CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.seat
    ADD CONSTRAINT seat_flight_id_fkey FOREIGN KEY (flight_id) REFERENCES bs.flight(number);


--
-- Name: ticket ticket_arrival_stop_id_fkey; Type: FK CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.ticket
    ADD CONSTRAINT ticket_arrival_stop_id_fkey FOREIGN KEY (arrival_stop_id) REFERENCES bs.bus_stop(id);


--
-- Name: ticket ticket_departure_stop_id_fkey; Type: FK CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.ticket
    ADD CONSTRAINT ticket_departure_stop_id_fkey FOREIGN KEY (departure_stop_id) REFERENCES bs.bus_stop(id);


--
-- Name: ticket ticket_flight_num_fkey; Type: FK CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.ticket
    ADD CONSTRAINT ticket_flight_num_fkey FOREIGN KEY (flight_num) REFERENCES bs.flight(number);


--
-- Name: ticket ticket_passenger_id_fkey; Type: FK CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.ticket
    ADD CONSTRAINT ticket_passenger_id_fkey FOREIGN KEY (passenger_id) REFERENCES bs.passenger(id);


--
-- Name: ticket ticket_seat_id_fkey; Type: FK CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.ticket
    ADD CONSTRAINT ticket_seat_id_fkey FOREIGN KEY (seat_id) REFERENCES bs.seat(id);


--
-- Name: way_stop way_stop_global_id_fkey; Type: FK CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.way_stop
    ADD CONSTRAINT way_stop_global_id_fkey FOREIGN KEY (global_id) REFERENCES bs.bus_stop(id);


--
-- Name: way_stop way_stop_route_id_fkey; Type: FK CONSTRAINT; Schema: bs; Owner: postgres
--

ALTER TABLE ONLY bs.way_stop
    ADD CONSTRAINT way_stop_route_id_fkey FOREIGN KEY (route_id) REFERENCES bs.route(id);


--
-- PostgreSQL database dump complete
--

