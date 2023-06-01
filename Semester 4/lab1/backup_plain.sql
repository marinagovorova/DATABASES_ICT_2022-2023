--
-- PostgreSQL database dump
--

-- Dumped from database version 11.19
-- Dumped by pg_dump version 11.19

-- Started on 2023-03-21 20:54:52

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

SET default_with_oids = false;

--
-- TOC entry 203 (class 1259 OID 28131)
-- Name: buses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.buses (
    bus_id integer NOT NULL,
    model_id integer NOT NULL,
    bus_number integer NOT NULL
);


ALTER TABLE public.buses OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 28129)
-- Name: buses_bus_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.buses ALTER COLUMN bus_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.buses_bus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 212 (class 1259 OID 28217)
-- Name: drivers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.drivers (
    driver_id integer NOT NULL,
    full_name character varying(30) NOT NULL,
    telephone character varying(30) NOT NULL,
    email character varying(255) NOT NULL,
    passport character varying(30) NOT NULL,
    CONSTRAINT chk_email CHECK (((email)::text ~~ '%_@__%.__%'::text))
);


ALTER TABLE public.drivers OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 28215)
-- Name: drivers_driver_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.drivers ALTER COLUMN driver_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.drivers_driver_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 213 (class 1259 OID 28227)
-- Name: drivers_trips; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.drivers_trips (
    driver_id integer NOT NULL,
    trip_id integer NOT NULL
);


ALTER TABLE public.drivers_trips OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 28124)
-- Name: models; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.models (
    model_id integer NOT NULL,
    seating_capacity integer NOT NULL,
    manufacturer character varying(30) NOT NULL,
    model_name character varying(30) NOT NULL,
    weight integer NOT NULL
);


ALTER TABLE public.models OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 28122)
-- Name: models_model_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.models ALTER COLUMN model_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.models_model_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 196 (class 1259 OID 28092)
-- Name: passengers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.passengers (
    email character varying(255) NOT NULL,
    passport character varying(30) NOT NULL,
    full_name character varying(30) NOT NULL,
    telephone character varying(20) NOT NULL,
    CONSTRAINT chk_email CHECK (((email)::text ~~ '%_@__%.__%'::text)),
    CONSTRAINT passengers_telephone_check CHECK (((telephone)::text ~ '^\d{10}$'::text))
);


ALTER TABLE public.passengers OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 28200)
-- Name: routes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.routes (
    route_id integer NOT NULL,
    stop_id integer NOT NULL,
    schedule_id integer NOT NULL,
    stop_duration_in_minutes integer NOT NULL
);


ALTER TABLE public.routes OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 28198)
-- Name: routes_route_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.routes ALTER COLUMN route_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.routes_route_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 199 (class 1259 OID 28110)
-- Name: schedules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedules (
    schedule_id integer NOT NULL,
    departure_point character varying(255) NOT NULL,
    arrival_point character varying(255) NOT NULL,
    departure_time timestamp without time zone NOT NULL,
    arrival_time timestamp without time zone NOT NULL,
    type character varying(20) DEFAULT 'intercity'::character varying NOT NULL,
    CONSTRAINT schedules_check CHECK ((departure_time < arrival_time)),
    CONSTRAINT schedules_check1 CHECK ((arrival_time > departure_time)),
    CONSTRAINT schedules_type_check CHECK (((type)::text = ANY ((ARRAY['intercity'::character varying, 'international'::character varying])::text[])))
);


ALTER TABLE public.schedules OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 28108)
-- Name: schedules_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
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
-- TOC entry 197 (class 1259 OID 28101)
-- Name: seats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seats (
    seat_number integer NOT NULL,
    is_booked boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.seats OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 28189)
-- Name: stops; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stops (
    stop_id integer NOT NULL,
    stop_name character varying(255) NOT NULL,
    stop_address character varying(255) NOT NULL,
    stop_type character varying(255) DEFAULT 'unknown'::character varying NOT NULL
);


ALTER TABLE public.stops OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 28187)
-- Name: stops_stop_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.stops ALTER COLUMN stop_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.stops_stop_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 206 (class 1259 OID 28164)
-- Name: tickets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tickets (
    seat_number integer NOT NULL,
    passport character varying(30) NOT NULL,
    price integer NOT NULL,
    boarding_point character varying(255) NOT NULL,
    status character varying(20) NOT NULL,
    alighting_point character varying(255) NOT NULL,
    sales_type character varying(10) NOT NULL,
    trip_id integer NOT NULL,
    CONSTRAINT tickets_sales_type_check CHECK (((sales_type)::text = ANY ((ARRAY['online'::character varying, 'offline'::character varying])::text[]))),
    CONSTRAINT tickets_status_check CHECK (((status)::text = ANY ((ARRAY['paid'::character varying, 'unpaid'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE public.tickets OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 28143)
-- Name: trips; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trips (
    trip_id integer NOT NULL,
    departure_point character varying(255) NOT NULL,
    arrival_point character varying(255) NOT NULL,
    actual_departure_time timestamp without time zone NOT NULL,
    actual_arrival_time timestamp without time zone NOT NULL,
    schedule_id integer NOT NULL,
    bus_id integer NOT NULL,
    status character varying(20) NOT NULL,
    CONSTRAINT trips_check CHECK ((actual_arrival_time > actual_departure_time)),
    CONSTRAINT trips_check1 CHECK ((actual_arrival_time > actual_departure_time)),
    CONSTRAINT trips_status_check CHECK (((status)::text = ANY ((ARRAY['Pending'::character varying, 'In progress'::character varying, 'Completed'::character varying])::text[])))
);


ALTER TABLE public.trips OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 28141)
-- Name: trips_trip_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.trips ALTER COLUMN trip_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.trips_trip_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 2920 (class 0 OID 28131)
-- Dependencies: 203
-- Data for Name: buses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.buses (bus_id, model_id, bus_number) FROM stdin;
1	1	2001
2	1	2002
3	2	3001
4	2	3002
\.


--
-- TOC entry 2929 (class 0 OID 28217)
-- Dependencies: 212
-- Data for Name: drivers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.drivers (driver_id, full_name, telephone, email, passport) FROM stdin;
1	driver1	0987654321	driver1@example.com	876543210
2	driver2	0123456789	driver2@example.com	765432109
\.


--
-- TOC entry 2930 (class 0 OID 28227)
-- Dependencies: 213
-- Data for Name: drivers_trips; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.drivers_trips (driver_id, trip_id) FROM stdin;
1	1
2	2
\.


--
-- TOC entry 2918 (class 0 OID 28124)
-- Dependencies: 201
-- Data for Name: models; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.models (model_id, seating_capacity, manufacturer, model_name, weight) FROM stdin;
1	30	Toyota	Coaster	4000
2	80	Scania	Touring	12000
\.


--
-- TOC entry 2913 (class 0 OID 28092)
-- Dependencies: 196
-- Data for Name: passengers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.passengers (email, passport, full_name, telephone) FROM stdin;
email1@example.com	234567890	passenger1	0123456789
email2@example.com	345678901	passenger2	0987654321
email3@example.com	456789012	passenger3	0123456789
\.


--
-- TOC entry 2927 (class 0 OID 28200)
-- Dependencies: 210
-- Data for Name: routes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.routes (route_id, stop_id, schedule_id, stop_duration_in_minutes) FROM stdin;
1	1	2	30
2	2	1	15
3	1	2	45
4	2	1	30
\.


--
-- TOC entry 2916 (class 0 OID 28110)
-- Dependencies: 199
-- Data for Name: schedules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schedules (schedule_id, departure_point, arrival_point, departure_time, arrival_time, type) FROM stdin;
1	Hanoi	Danang	2023-03-26 08:00:00	2023-03-26 14:00:00	intercity
2	Hanoi	Bangkok	2023-03-27 10:00:00	2023-03-27 13:00:00	international
\.


--
-- TOC entry 2914 (class 0 OID 28101)
-- Dependencies: 197
-- Data for Name: seats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.seats (seat_number, is_booked, created_at) FROM stdin;
4	f	2023-03-21 20:44:57.096639
5	f	2023-03-21 20:44:57.096639
6	t	2023-03-21 20:44:57.096639
\.


--
-- TOC entry 2925 (class 0 OID 28189)
-- Dependencies: 208
-- Data for Name: stops; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stops (stop_id, stop_name, stop_address, stop_type) FROM stdin;
1	Stop 3	789 Oak Street	unknown
2	Stop 4	101 Main Street	unknown
\.


--
-- TOC entry 2923 (class 0 OID 28164)
-- Dependencies: 206
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tickets (seat_number, passport, price, boarding_point, status, alighting_point, sales_type, trip_id) FROM stdin;
6	234567890	150000	Hanoi	unpaid	Danang	online	1
5	345678901	200000	Hanoi	paid	Danang	offline	1
4	456789012	500000	Hanoi	unpaid	Bangkok	online	2
\.


--
-- TOC entry 2922 (class 0 OID 28143)
-- Dependencies: 205
-- Data for Name: trips; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trips (trip_id, departure_point, arrival_point, actual_departure_time, actual_arrival_time, schedule_id, bus_id, status) FROM stdin;
1	Hanoi	Danang	2023-03-26 08:05:00	2023-03-26 14:05:00	1	3	Pending
2	Hanoi	Bangkok	2023-03-27 10:05:00	2023-03-27 13:05:00	2	4	Pending
\.


--
-- TOC entry 2936 (class 0 OID 0)
-- Dependencies: 202
-- Name: buses_bus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.buses_bus_id_seq', 4, true);


--
-- TOC entry 2937 (class 0 OID 0)
-- Dependencies: 211
-- Name: drivers_driver_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.drivers_driver_id_seq', 2, true);


--
-- TOC entry 2938 (class 0 OID 0)
-- Dependencies: 200
-- Name: models_model_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.models_model_id_seq', 2, true);


--
-- TOC entry 2939 (class 0 OID 0)
-- Dependencies: 209
-- Name: routes_route_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.routes_route_id_seq', 4, true);


--
-- TOC entry 2940 (class 0 OID 0)
-- Dependencies: 198
-- Name: schedules_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schedules_schedule_id_seq', 2, true);


--
-- TOC entry 2941 (class 0 OID 0)
-- Dependencies: 207
-- Name: stops_stop_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stops_stop_id_seq', 2, true);


--
-- TOC entry 2942 (class 0 OID 0)
-- Dependencies: 204
-- Name: trips_trip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.trips_trip_id_seq', 2, true);


--
-- TOC entry 2767 (class 2606 OID 28135)
-- Name: buses buses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buses
    ADD CONSTRAINT buses_pkey PRIMARY KEY (bus_id);


--
-- TOC entry 2775 (class 2606 OID 28224)
-- Name: drivers drivers_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.drivers
    ADD CONSTRAINT drivers_email_key UNIQUE (email);


--
-- TOC entry 2777 (class 2606 OID 28226)
-- Name: drivers drivers_passport_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.drivers
    ADD CONSTRAINT drivers_passport_key UNIQUE (passport);


--
-- TOC entry 2779 (class 2606 OID 28222)
-- Name: drivers drivers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.drivers
    ADD CONSTRAINT drivers_pkey PRIMARY KEY (driver_id);


--
-- TOC entry 2781 (class 2606 OID 28231)
-- Name: drivers_trips drivers_trips_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.drivers_trips
    ADD CONSTRAINT drivers_trips_pkey PRIMARY KEY (driver_id, trip_id);


--
-- TOC entry 2765 (class 2606 OID 28128)
-- Name: models models_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.models
    ADD CONSTRAINT models_pkey PRIMARY KEY (model_id);


--
-- TOC entry 2757 (class 2606 OID 28100)
-- Name: passengers passengers_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passengers
    ADD CONSTRAINT passengers_email_key UNIQUE (email);


--
-- TOC entry 2759 (class 2606 OID 28098)
-- Name: passengers passengers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passengers
    ADD CONSTRAINT passengers_pkey PRIMARY KEY (passport);


--
-- TOC entry 2773 (class 2606 OID 28204)
-- Name: routes routes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.routes
    ADD CONSTRAINT routes_pkey PRIMARY KEY (route_id);


--
-- TOC entry 2763 (class 2606 OID 28121)
-- Name: schedules schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_pkey PRIMARY KEY (schedule_id);


--
-- TOC entry 2761 (class 2606 OID 28107)
-- Name: seats seats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seats
    ADD CONSTRAINT seats_pkey PRIMARY KEY (seat_number);


--
-- TOC entry 2771 (class 2606 OID 28197)
-- Name: stops stops_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stops
    ADD CONSTRAINT stops_pkey PRIMARY KEY (stop_id);


--
-- TOC entry 2769 (class 2606 OID 28153)
-- Name: trips trips_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trips
    ADD CONSTRAINT trips_pkey PRIMARY KEY (trip_id);


--
-- TOC entry 2782 (class 2606 OID 28136)
-- Name: buses buses_model_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buses
    ADD CONSTRAINT buses_model_id_fkey FOREIGN KEY (model_id) REFERENCES public.models(model_id) ON DELETE CASCADE;


--
-- TOC entry 2790 (class 2606 OID 28232)
-- Name: drivers_trips drivers_trips_driver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.drivers_trips
    ADD CONSTRAINT drivers_trips_driver_id_fkey FOREIGN KEY (driver_id) REFERENCES public.drivers(driver_id) ON DELETE CASCADE;


--
-- TOC entry 2791 (class 2606 OID 28237)
-- Name: drivers_trips drivers_trips_trip_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.drivers_trips
    ADD CONSTRAINT drivers_trips_trip_id_fkey FOREIGN KEY (trip_id) REFERENCES public.trips(trip_id) ON DELETE CASCADE;


--
-- TOC entry 2789 (class 2606 OID 28210)
-- Name: routes routes_schedule_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.routes
    ADD CONSTRAINT routes_schedule_id_fkey FOREIGN KEY (schedule_id) REFERENCES public.schedules(schedule_id);


--
-- TOC entry 2788 (class 2606 OID 28205)
-- Name: routes routes_stop_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.routes
    ADD CONSTRAINT routes_stop_id_fkey FOREIGN KEY (stop_id) REFERENCES public.stops(stop_id);


--
-- TOC entry 2786 (class 2606 OID 28177)
-- Name: tickets tickets_passport_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_passport_fkey FOREIGN KEY (passport) REFERENCES public.passengers(passport);


--
-- TOC entry 2787 (class 2606 OID 28182)
-- Name: tickets tickets_seat_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_seat_number_fkey FOREIGN KEY (seat_number) REFERENCES public.seats(seat_number);


--
-- TOC entry 2785 (class 2606 OID 28172)
-- Name: tickets tickets_trip_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_trip_id_fkey FOREIGN KEY (trip_id) REFERENCES public.trips(trip_id) ON DELETE CASCADE;


--
-- TOC entry 2784 (class 2606 OID 28159)
-- Name: trips trips_bus_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trips
    ADD CONSTRAINT trips_bus_id_fkey FOREIGN KEY (bus_id) REFERENCES public.buses(bus_id);


--
-- TOC entry 2783 (class 2606 OID 28154)
-- Name: trips trips_schedule_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trips
    ADD CONSTRAINT trips_schedule_id_fkey FOREIGN KEY (schedule_id) REFERENCES public.schedules(schedule_id);


-- Completed on 2023-03-21 20:54:52

--
-- PostgreSQL database dump complete
--

