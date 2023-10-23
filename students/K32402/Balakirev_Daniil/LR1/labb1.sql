--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

-- Started on 2023-09-13 15:50:41

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
-- TOC entry 214 (class 1259 OID 16420)
-- Name: accident; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accident (
    accident_id integer NOT NULL,
    violation_id integer NOT NULL,
    inspector_id integer NOT NULL,
    registration_id integer NOT NULL,
    description character varying(255) NOT NULL,
    date_of_the_accident date NOT NULL,
    the_place character varying(255) NOT NULL
);


ALTER TABLE public.accident OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16472)
-- Name: car; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.car (
    "VIN" character varying(255) NOT NULL,
    year_of_release date NOT NULL,
    model_id integer NOT NULL
);


ALTER TABLE public.car OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16477)
-- Name: model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.model (
    model_id integer NOT NULL,
    stamp character varying(255) NOT NULL,
    model character varying(255) NOT NULL,
    engine_type character varying(255) NOT NULL,
    body_type character varying(255) NOT NULL,
    manufacture character varying(255) NOT NULL
);


ALTER TABLE public.model OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16500)
-- Name: owner; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.owner (
    "driver's_license_number" character varying(255) NOT NULL,
    "driver's_full_name" character varying(255) NOT NULL,
    telephone character varying(255) NOT NULL,
    address character varying(255) NOT NULL,
    status character varying(255) NOT NULL
);


ALTER TABLE public.owner OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16458)
-- Name: registered_car; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.registered_car (
    registration_id integer NOT NULL,
    "VIN" character varying(255) NOT NULL,
    branch_number integer NOT NULL,
    "owners's_full_name" character varying(255) NOT NULL,
    registration_number character varying(255) NOT NULL,
    date_of_registration date NOT NULL,
    "date_of_de-registration" date
);


ALTER TABLE public.registered_car OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16453)
-- Name: traffic_police_department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.traffic_police_department (
    branch_number_id integer NOT NULL,
    address character varying(255) NOT NULL
);


ALTER TABLE public.traffic_police_department OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16446)
-- Name: traffic_police_inspector; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.traffic_police_inspector (
    inspector_id integer NOT NULL,
    branch_number integer NOT NULL,
    full_name_of_the_inspector character varying(255) NOT NULL,
    "inspector's_postion" character varying(255) NOT NULL
);


ALTER TABLE public.traffic_police_inspector OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16439)
-- Name: type_of_violation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.type_of_violation (
    violation_id integer NOT NULL,
    the_amount_of_the_fine character varying(255) NOT NULL,
    type_of_violation character varying(255) NOT NULL,
    description_of_the_violation character varying(255) NOT NULL
);


ALTER TABLE public.type_of_violation OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16432)
-- Name: violation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.violation (
    violation_id integer NOT NULL,
    accident_id integer NOT NULL,
    inspector_id integer NOT NULL,
    registration_id integer NOT NULL,
    violation_code character varying(255) NOT NULL,
    place_of_violation character varying(255) NOT NULL,
    payment_status boolean NOT NULL,
    date_of_violation date NOT NULL
);


ALTER TABLE public.violation OWNER TO postgres;

--
-- TOC entry 3374 (class 0 OID 16420)
-- Dependencies: 214
-- Data for Name: accident; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.accident VALUES (1, 2, 3, 3, 'Лёгкое ДТП', '2023-04-12', 'Луговая ул., д. 2');
INSERT INTO public.accident VALUES (2, 3, 2, 2, 'Лёгкое ДТП', '2023-02-11', 'Максима Горького ул., д. 10');
INSERT INTO public.accident VALUES (3, 1, 1, 1, 'Лёгкое ДТП', '2023-03-01', 'Заречный пер., д. 19');


--
-- TOC entry 3380 (class 0 OID 16472)
-- Dependencies: 220
-- Data for Name: car; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.car VALUES ('WVGZZZ00000000000', '2022-01-01', 1);
INSERT INTO public.car VALUES ('WVGZZZ00000000001', '2010-01-01', 2);
INSERT INTO public.car VALUES ('WVGZZZ00000000002', '2021-01-01', 3);


--
-- TOC entry 3381 (class 0 OID 16477)
-- Dependencies: 221
-- Data for Name: model; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.model VALUES (1, 'BMW', 'M5', 'Бензин', 'Седан', 'Германия');
INSERT INTO public.model VALUES (2, 'Skoda', 'Octavia', 'Бензин', 'Седан', 'Чехия');
INSERT INTO public.model VALUES (3, 'Honda', 'Civic', 'Бензин', 'Хэтчбек', 'Япония');


--
-- TOC entry 3382 (class 0 OID 16500)
-- Dependencies: 222
-- Data for Name: owner; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.owner VALUES ('5604491942', 'Львов Герман Фёдорович', '+7 (953) 986-77-42', 'Колхозный пер., д. 19 кв.158', 'Владелец');
INSERT INTO public.owner VALUES ('5604919445', 'Кузнецов Богдан Михайлович', '+7 (953) 986-77-42', 'Рабочая ул., д. 15 кв.218', 'Владелец');
INSERT INTO public.owner VALUES ('5604919446', 'Калачев Михаил Григорьевич', '+7 (953) 986-77-42', 'Минская ул., д. 22 кв.202', 'Владелец');


--
-- TOC entry 3379 (class 0 OID 16458)
-- Dependencies: 219
-- Data for Name: registered_car; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.registered_car VALUES (1, 'WVGZZZ00000000000', 2, 'Львов Герман Фёдорович', 'У 447 ОО', '2023-01-01', '2023-01-01');
INSERT INTO public.registered_car VALUES (2, 'WVGZZZ00000000001', 3, 'Кузнецов Богдан Михайлович', 'А 960 АО', '2023-01-01', '2023-01-01');
INSERT INTO public.registered_car VALUES (3, 'WVGZZZ00000000002', 1, 'Калачев Михаил Григорьевич', 'М 376 У О', '2023-01-01', '2023-01-01');


--
-- TOC entry 3378 (class 0 OID 16453)
-- Dependencies: 218
-- Data for Name: traffic_police_department; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.traffic_police_department VALUES (1, 'Строителей ул., д. 1');
INSERT INTO public.traffic_police_department VALUES (2, 'Набережная ул., д. 15');
INSERT INTO public.traffic_police_department VALUES (3, 'Комсомольская ул., д. 7');


--
-- TOC entry 3377 (class 0 OID 16446)
-- Dependencies: 217
-- Data for Name: traffic_police_inspector; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.traffic_police_inspector VALUES (1, 1, 'Власов Михаил Александрович', 'Лейтенант');
INSERT INTO public.traffic_police_inspector VALUES (2, 2, 'Колесников Иван Германович', 'Лейтенант');
INSERT INTO public.traffic_police_inspector VALUES (3, 3, 'Крюков Дмитрий Георгиевич', 'Капитан');


--
-- TOC entry 3376 (class 0 OID 16439)
-- Dependencies: 216
-- Data for Name: type_of_violation; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.type_of_violation VALUES (1, '500₽', 'Лёгкое ДТП', 'Лёгкое ДТП');
INSERT INTO public.type_of_violation VALUES (2, '500₽', 'Лёгкое ДТП', 'Лёгкое ДТП');
INSERT INTO public.type_of_violation VALUES (3, '500₽', 'Лёгкое ДТП', 'Лёгкое ДТП');


--
-- TOC entry 3375 (class 0 OID 16432)
-- Dependencies: 215
-- Data for Name: violation; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.violation VALUES (1, 2, 2, 1, '09', 'Шоссе', false, '2023-07-08');
INSERT INTO public.violation VALUES (2, 3, 3, 2, '09', 'Шоссе', true, '2023-03-08');
INSERT INTO public.violation VALUES (3, 1, 1, 3, '09', 'Шоссе', true, '2023-05-22');


--
-- TOC entry 3207 (class 2606 OID 16431)
-- Name: accident accident_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accident
    ADD CONSTRAINT accident_pkey PRIMARY KEY (accident_id);


--
-- TOC entry 3219 (class 2606 OID 16476)
-- Name: car car_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car
    ADD CONSTRAINT car_pkey PRIMARY KEY ("VIN");


--
-- TOC entry 3221 (class 2606 OID 16483)
-- Name: model model_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model
    ADD CONSTRAINT model_pkey PRIMARY KEY (model_id);


--
-- TOC entry 3223 (class 2606 OID 16506)
-- Name: owner owner_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.owner
    ADD CONSTRAINT owner_pkey PRIMARY KEY ("driver's_license_number");


--
-- TOC entry 3204 (class 2606 OID 16508)
-- Name: violation payment_status; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.violation
    ADD CONSTRAINT payment_status CHECK (((payment_status = true) OR (payment_status = false))) NOT VALID;


--
-- TOC entry 3217 (class 2606 OID 16464)
-- Name: registered_car registered_car_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registered_car
    ADD CONSTRAINT registered_car_pkey PRIMARY KEY (registration_id);


--
-- TOC entry 3215 (class 2606 OID 16457)
-- Name: traffic_police_department traffic_police_department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traffic_police_department
    ADD CONSTRAINT traffic_police_department_pkey PRIMARY KEY (branch_number_id);


--
-- TOC entry 3213 (class 2606 OID 16452)
-- Name: traffic_police_inspector traffic_police_inspector_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traffic_police_inspector
    ADD CONSTRAINT traffic_police_inspector_pkey PRIMARY KEY (inspector_id);


--
-- TOC entry 3211 (class 2606 OID 16445)
-- Name: type_of_violation type_of_violation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.type_of_violation
    ADD CONSTRAINT type_of_violation_pkey PRIMARY KEY (violation_id);


--
-- TOC entry 3205 (class 2606 OID 16507)
-- Name: type_of_violation violation_id; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.type_of_violation
    ADD CONSTRAINT violation_id CHECK ((violation_id > 0)) NOT VALID;


--
-- TOC entry 3209 (class 2606 OID 16438)
-- Name: violation violation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.violation
    ADD CONSTRAINT violation_pkey PRIMARY KEY (violation_id);


--
-- TOC entry 3229 (class 2606 OID 16519)
-- Name: registered_car FK_VIN; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registered_car
    ADD CONSTRAINT "FK_VIN" FOREIGN KEY ("VIN") REFERENCES public.car("VIN") NOT VALID;


--
-- TOC entry 3225 (class 2606 OID 16569)
-- Name: violation FK_accident_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.violation
    ADD CONSTRAINT "FK_accident_id" FOREIGN KEY (accident_id) REFERENCES public.accident(accident_id) NOT VALID;


--
-- TOC entry 3230 (class 2606 OID 16524)
-- Name: registered_car FK_brunch_number; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registered_car
    ADD CONSTRAINT "FK_brunch_number" FOREIGN KEY (branch_number) REFERENCES public.traffic_police_department(branch_number_id) NOT VALID;


--
-- TOC entry 3224 (class 2606 OID 16564)
-- Name: accident FK_inspector_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accident
    ADD CONSTRAINT "FK_inspector_id" FOREIGN KEY (inspector_id) REFERENCES public.traffic_police_inspector(inspector_id) NOT VALID;


--
-- TOC entry 3226 (class 2606 OID 16574)
-- Name: violation FK_inspector_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.violation
    ADD CONSTRAINT "FK_inspector_id" FOREIGN KEY (inspector_id) REFERENCES public.traffic_police_inspector(inspector_id) NOT VALID;


--
-- TOC entry 3227 (class 2606 OID 16579)
-- Name: violation FK_registaration_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.violation
    ADD CONSTRAINT "FK_registaration_id" FOREIGN KEY (registration_id) REFERENCES public.registered_car(registration_id) NOT VALID;


--
-- TOC entry 3228 (class 2606 OID 16509)
-- Name: traffic_police_inspector fk_branch_number; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traffic_police_inspector
    ADD CONSTRAINT fk_branch_number FOREIGN KEY (branch_number) REFERENCES public.traffic_police_department(branch_number_id) NOT VALID;


--
-- TOC entry 3231 (class 2606 OID 16514)
-- Name: car fk_model_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car
    ADD CONSTRAINT fk_model_id FOREIGN KEY (model_id) REFERENCES public.model(model_id) NOT VALID;


-- Completed on 2023-09-13 15:50:42

--
-- PostgreSQL database dump complete
--

