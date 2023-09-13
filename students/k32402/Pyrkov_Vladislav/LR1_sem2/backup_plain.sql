--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

-- Started on 2023-09-13 12:49:35

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
-- TOC entry 217 (class 1259 OID 16430)
-- Name: classroom; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.classroom (
    classroom_number bigint NOT NULL,
    platform_address character varying(60) NOT NULL,
    classroom_type character varying(20) NOT NULL,
    CONSTRAINT classroom_classroom_type_check CHECK (((classroom_type)::text = ANY (ARRAY[('practice'::character varying)::text, ('lab'::character varying)::text, ('lecture'::character varying)::text])))
);


ALTER TABLE public.classroom OWNER TO postgres;

--
-- TOC entry 3342 (class 0 OID 16430)
-- Dependencies: 217
-- Data for Name: classroom; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.classroom (classroom_number, platform_address, classroom_type) FROM stdin;
2041	123 Main St	lecture
2042	123 Main St	practice
1013	789 Maple Ln	lecture
\.


--
-- TOC entry 3199 (class 2606 OID 16435)
-- Name: classroom classroom_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classroom
    ADD CONSTRAINT classroom_pkey PRIMARY KEY (classroom_number);


-- Completed on 2023-09-13 12:49:36

--
-- PostgreSQL database dump complete
--

