--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-04-01 18:22:16

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
-- TOC entry 226 (class 1259 OID 16604)
-- Name: attestations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attestations (
    student_personnel_number integer NOT NULL,
    educator_personnel_number integer NOT NULL,
    disc_in_curr_id integer NOT NULL,
    mark character varying(10),
    attestation_id integer NOT NULL,
    attempt integer,
    CONSTRAINT attempt_check CHECK ((attempt = ANY (ARRAY[1, 2, 3]))),
    CONSTRAINT mark_check CHECK (((mark)::text = ANY ((ARRAY['5A'::character varying, '4B'::character varying, '4C'::character varying, '3D'::character varying, 'Зачёт'::character varying])::text[])))
);


ALTER TABLE public.attestations OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16492)
-- Name: auditoriums; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auditoriums (
    auditorium_id integer NOT NULL,
    venue_id integer NOT NULL,
    auditorium_capacity integer,
    auditorium_number integer,
    auditorium_type character varying(20),
    CONSTRAINT capacity_check CHECK ((auditorium_capacity > 0)),
    CONSTRAINT type_check CHECK (((auditorium_type)::text = ANY ((ARRAY['Лекционный зал'::character varying, 'Учебный класс'::character varying, 'Лаборантская'::character varying])::text[])))
);


ALTER TABLE public.auditoriums OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16502)
-- Name: curriculums; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.curriculums (
    curriculum_id integer NOT NULL,
    edu_prog_id integer NOT NULL,
    curriculum_admittance_year integer
);


ALTER TABLE public.curriculums OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16452)
-- Name: directions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directions (
    direction_id integer NOT NULL,
    direction_name character varying(100)
);


ALTER TABLE public.directions OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16562)
-- Name: disc_in_curr; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.disc_in_curr (
    disc_in_curr_id integer NOT NULL,
    curriculum_id integer NOT NULL,
    discipline_id integer NOT NULL
);


ALTER TABLE public.disc_in_curr OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16527)
-- Name: disciplines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.disciplines (
    discipline_id integer NOT NULL,
    discipline_name character varying(100),
    discipline_lecture_hours integer,
    discipline_practice_hours integer,
    discipline_lab_hours integer,
    discipline_attestation_type character varying(20),
    CONSTRAINT hours_check CHECK (((discipline_lecture_hours >= 0) AND (discipline_practice_hours >= 0) AND (discipline_lab_hours >= 0)))
);


ALTER TABLE public.disciplines OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16462)
-- Name: divisions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.divisions (
    division_id integer NOT NULL,
    venue_id integer NOT NULL,
    division_name character varying(100)
);


ALTER TABLE public.divisions OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16477)
-- Name: edu_progs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.edu_progs (
    edu_prog_id integer NOT NULL,
    direction_id integer NOT NULL,
    division_id integer NOT NULL,
    edu_prog_name character varying(100)
);


ALTER TABLE public.edu_progs OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16532)
-- Name: educators; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.educators (
    educator_personnel_number integer NOT NULL,
    division_id integer NOT NULL,
    educator_full_name character varying(100),
    educator_position character varying(100)
);


ALTER TABLE public.educators OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16624)
-- Name: schedule_rows; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedule_rows (
    st_group_id integer NOT NULL,
    educator_personnel_number integer NOT NULL,
    disc_in_curr_id integer NOT NULL,
    auditorium_id integer NOT NULL,
    schedule_date timestamp(0) with time zone,
    schedule_row_id integer NOT NULL
);


ALTER TABLE public.schedule_rows OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16512)
-- Name: st_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.st_groups (
    st_group_id integer NOT NULL,
    curriculum_id integer NOT NULL,
    st_group_number character varying(10),
    st_group_number_valid_since date,
    st_group_number_valid_till date,
    CONSTRAINT valid_check CHECK ((st_group_number_valid_since < st_group_number_valid_till))
);


ALTER TABLE public.st_groups OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16547)
-- Name: st_in_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.st_in_group (
    student_personnel_number integer NOT NULL,
    student_id integer NOT NULL,
    st_group_id integer NOT NULL,
    student_in_group_since date,
    student_in_group_till date,
    student_status character varying(20)
);


ALTER TABLE public.st_in_group OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16522)
-- Name: students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.students (
    student_id integer NOT NULL,
    student_full_name character varying(100),
    student_birthyear integer,
    student_passport_data character varying(100)
);


ALTER TABLE public.students OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16457)
-- Name: venues; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venues (
    venue_id integer NOT NULL,
    venue_name character varying(100),
    venue_address character varying(100)
);


ALTER TABLE public.venues OWNER TO postgres;

--
-- TOC entry 3430 (class 0 OID 16604)
-- Dependencies: 226
-- Data for Name: attestations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attestations (student_personnel_number, educator_personnel_number, disc_in_curr_id, mark, attestation_id, attempt) FROM stdin;
333001	111111	2	5A	1	1
333001	111222	1	4B	2	1
333001	111333	3	5A	3	1
333001	111444	4	Зачёт	4	1
333002	111111	2	4B	5	2
333002	111222	1	4B	6	1
333002	111333	3	4C	7	1
333002	111444	4	Зачёт	8	1
333003	111111	2	5A	9	1
333003	111222	1	5A	10	1
333003	111333	3	5A	11	1
333003	111444	4	Зачёт	12	1
333004	111111	2	3D	13	2
333004	111222	1	3D	14	2
333004	111333	3	3D	15	2
333004	111555	4	Зачёт	16	1
333005	111111	2	5A	17	1
333005	111222	1	5A	18	1
333005	111333	3	5A	19	1
333005	111444	4	Зачёт	20	1
333006	111111	2	4C	21	1
333006	111222	1	4B	22	1
333006	111333	3	5A	23	1
333006	111444	4	Зачёт	24	1
\.


--
-- TOC entry 3422 (class 0 OID 16492)
-- Dependencies: 218
-- Data for Name: auditoriums; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auditoriums (auditorium_id, venue_id, auditorium_capacity, auditorium_number, auditorium_type) FROM stdin;
1	3	64	103	Лекционный зал
2	2	16	3414	Учебный класс
3	2	16	4303	Лаборантская
4	1	16	2414	Учебный класс
5	2	64	1220	Лекционный зал
6	3	16	353	Учебный класс
\.


--
-- TOC entry 3423 (class 0 OID 16502)
-- Dependencies: 219
-- Data for Name: curriculums; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.curriculums (curriculum_id, edu_prog_id, curriculum_admittance_year) FROM stdin;
1	1	2021
\.


--
-- TOC entry 3418 (class 0 OID 16452)
-- Dependencies: 214
-- Data for Name: directions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directions (direction_id, direction_name) FROM stdin;
1	Прикладная математика и информатика
2	Информационные системы и технологии
3	Информатика и вычислительная техника
4	Прикладная информатика
\.


--
-- TOC entry 3429 (class 0 OID 16562)
-- Dependencies: 225
-- Data for Name: disc_in_curr; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.disc_in_curr (disc_in_curr_id, curriculum_id, discipline_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	1	4
\.


--
-- TOC entry 3426 (class 0 OID 16527)
-- Dependencies: 222
-- Data for Name: disciplines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.disciplines (discipline_id, discipline_name, discipline_lecture_hours, discipline_practice_hours, discipline_lab_hours, discipline_attestation_type) FROM stdin;
1	Математика	100	100	\N	Экзамен
2	Физика	100	100	100	Экзамен
3	Программирование	100	100	100	Экзамен
4	Английский язык	\N	100	\N	Зачёт
\.


--
-- TOC entry 3420 (class 0 OID 16462)
-- Dependencies: 216
-- Data for Name: divisions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.divisions (division_id, venue_id, division_name) FROM stdin;
1	2	ФИТиП
2	1	ФИКТ
3	3	ИЛТ
4	2	ФПИКТ
\.


--
-- TOC entry 3421 (class 0 OID 16477)
-- Dependencies: 217
-- Data for Name: edu_progs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.edu_progs (edu_prog_id, direction_id, division_id, edu_prog_name) FROM stdin;
1	4	2	Мобильные и сетевые технологии
\.


--
-- TOC entry 3427 (class 0 OID 16532)
-- Dependencies: 223
-- Data for Name: educators; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.educators (educator_personnel_number, division_id, educator_full_name, educator_position) FROM stdin;
111111	2	Нестеров Сергей Сергеевич	Преподаватель физики
111222	2	Иванова Алиса Матвеевна	Преподаватель математики
111333	2	Гусев Вадим Андреевич	Преподаватель программирования
111444	2	Шестакова Виктория Глебовна	Преподаватель английского языка
111555	2	Муфалали Чипо Мубалу	Преподаватель английского языка
\.


--
-- TOC entry 3431 (class 0 OID 16624)
-- Dependencies: 227
-- Data for Name: schedule_rows; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schedule_rows (st_group_id, educator_personnel_number, disc_in_curr_id, auditorium_id, schedule_date, schedule_row_id) FROM stdin;
2	111111	2	5	2023-01-17 10:00:00+03	1
2	111222	1	5	2023-01-25 10:00:00+03	2
2	111333	3	6	2023-01-22 10:00:00+03	3
2	111444	4	2	2022-12-21 15:20:00+03	4
2	111555	4	2	2022-12-21 08:20:00+03	5
\.


--
-- TOC entry 3424 (class 0 OID 16512)
-- Dependencies: 220
-- Data for Name: st_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.st_groups (st_group_id, curriculum_id, st_group_number, st_group_number_valid_since, st_group_number_valid_till) FROM stdin;
1	1	K3141	2021-09-01	2022-09-01
2	1	K32391	2022-09-01	2023-09-01
\.


--
-- TOC entry 3428 (class 0 OID 16547)
-- Dependencies: 224
-- Data for Name: st_in_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.st_in_group (student_personnel_number, student_id, st_group_id, student_in_group_since, student_in_group_till, student_status) FROM stdin;
333001	2	2	2022-09-01	2023-09-01	учится
333002	3	2	2022-09-01	2023-09-01	учится
333003	4	2	2022-09-01	2023-09-01	учится
333004	6	2	2022-09-01	2023-09-01	учится
333005	7	2	2022-09-01	2023-09-01	учится
333006	8	2	2022-09-01	2023-09-01	учится
\.


--
-- TOC entry 3425 (class 0 OID 16522)
-- Dependencies: 221
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.students (student_id, student_full_name, student_birthyear, student_passport_data) FROM stdin;
1	Соловьев Максим Евгеньевич	2001	0000 000001
2	Поздняков Семён Давидович	2002	0000 000002
3	Киселева Варвара Павловна	2003	0000 000003
4	Богданова Мария Константиновна	2003	0000 000004
5	Павлова Анна Саввична	2000	0000 000005
6	Богданова Анастасия Константиновна	2003	0000 000006
7	Агеева Вероника Владиславовна	2002	0000 000007
8	Рябова Анна Тимофеевна	2002	0000 000008
9	Иванова Маргарита Егоровна	2000	0000 000009
10	Гордеев Руслан Егорович	2001	0000 000010
\.


--
-- TOC entry 3419 (class 0 OID 16457)
-- Dependencies: 215
-- Data for Name: venues; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.venues (venue_id, venue_name, venue_address) FROM stdin;
1	Кронверский	г. Санкт-Петербург, пр. Кронверский, 49
2	Ломоносова	г. Санкт-Петербург, ул. Ломоносова, 9
3	Биржевая	г. Санкт-Петербург, Биржевая линия, 14
\.


--
-- TOC entry 3255 (class 2606 OID 16815)
-- Name: attestations attestations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attestations
    ADD CONSTRAINT attestations_pkey PRIMARY KEY (attestation_id);


--
-- TOC entry 3239 (class 2606 OID 16496)
-- Name: auditoriums auditoriums_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditoriums
    ADD CONSTRAINT auditoriums_pkey PRIMARY KEY (auditorium_id);


--
-- TOC entry 3241 (class 2606 OID 16506)
-- Name: curriculums curriculums_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.curriculums
    ADD CONSTRAINT curriculums_pkey PRIMARY KEY (curriculum_id);


--
-- TOC entry 3231 (class 2606 OID 16456)
-- Name: directions directions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directions
    ADD CONSTRAINT directions_pkey PRIMARY KEY (direction_id);


--
-- TOC entry 3253 (class 2606 OID 16566)
-- Name: disc_in_curr disc_in_curr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disc_in_curr
    ADD CONSTRAINT disc_in_curr_pkey PRIMARY KEY (disc_in_curr_id);


--
-- TOC entry 3247 (class 2606 OID 16531)
-- Name: disciplines disciplines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplines
    ADD CONSTRAINT disciplines_pkey PRIMARY KEY (discipline_id);


--
-- TOC entry 3235 (class 2606 OID 16466)
-- Name: divisions divisions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.divisions
    ADD CONSTRAINT divisions_pkey PRIMARY KEY (division_id);


--
-- TOC entry 3237 (class 2606 OID 16481)
-- Name: edu_progs edu_progs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edu_progs
    ADD CONSTRAINT edu_progs_pkey PRIMARY KEY (edu_prog_id);


--
-- TOC entry 3249 (class 2606 OID 16536)
-- Name: educators educator_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educators
    ADD CONSTRAINT educator_pkey PRIMARY KEY (educator_personnel_number);


--
-- TOC entry 3257 (class 2606 OID 16817)
-- Name: schedule_rows schedule_rows_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_rows
    ADD CONSTRAINT schedule_rows_pkey PRIMARY KEY (schedule_row_id);


--
-- TOC entry 3243 (class 2606 OID 16516)
-- Name: st_groups st_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.st_groups
    ADD CONSTRAINT st_groups_pkey PRIMARY KEY (st_group_id);


--
-- TOC entry 3251 (class 2606 OID 16551)
-- Name: st_in_group st_in_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.st_in_group
    ADD CONSTRAINT st_in_group_pkey PRIMARY KEY (student_personnel_number);


--
-- TOC entry 3245 (class 2606 OID 16526)
-- Name: students student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT student_pkey PRIMARY KEY (student_id);


--
-- TOC entry 3233 (class 2606 OID 16461)
-- Name: venues venues_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venues
    ADD CONSTRAINT venues_pkey PRIMARY KEY (venue_id);


--
-- TOC entry 3269 (class 2606 OID 16619)
-- Name: attestations attestations_disc_in_curr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attestations
    ADD CONSTRAINT attestations_disc_in_curr_id_fkey FOREIGN KEY (disc_in_curr_id) REFERENCES public.disc_in_curr(disc_in_curr_id);


--
-- TOC entry 3270 (class 2606 OID 16614)
-- Name: attestations attestations_educator_personnel_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attestations
    ADD CONSTRAINT attestations_educator_personnel_number_fkey FOREIGN KEY (educator_personnel_number) REFERENCES public.educators(educator_personnel_number);


--
-- TOC entry 3271 (class 2606 OID 16609)
-- Name: attestations attestations_student_personnel_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attestations
    ADD CONSTRAINT attestations_student_personnel_number_fkey FOREIGN KEY (student_personnel_number) REFERENCES public.st_in_group(student_personnel_number);


--
-- TOC entry 3261 (class 2606 OID 16497)
-- Name: auditoriums auditoriums_venue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditoriums
    ADD CONSTRAINT auditoriums_venue_id_fkey FOREIGN KEY (venue_id) REFERENCES public.venues(venue_id);


--
-- TOC entry 3262 (class 2606 OID 16507)
-- Name: curriculums curriculums_edu_prog_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.curriculums
    ADD CONSTRAINT curriculums_edu_prog_id_fkey FOREIGN KEY (edu_prog_id) REFERENCES public.edu_progs(edu_prog_id);


--
-- TOC entry 3267 (class 2606 OID 16567)
-- Name: disc_in_curr disc_in_curr_curriculum_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disc_in_curr
    ADD CONSTRAINT disc_in_curr_curriculum_id_fkey FOREIGN KEY (curriculum_id) REFERENCES public.curriculums(curriculum_id);


--
-- TOC entry 3268 (class 2606 OID 16572)
-- Name: disc_in_curr disc_in_curr_discipline_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disc_in_curr
    ADD CONSTRAINT disc_in_curr_discipline_id_fkey FOREIGN KEY (discipline_id) REFERENCES public.disciplines(discipline_id);


--
-- TOC entry 3258 (class 2606 OID 16467)
-- Name: divisions divisions_venue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.divisions
    ADD CONSTRAINT divisions_venue_id_fkey FOREIGN KEY (venue_id) REFERENCES public.venues(venue_id);


--
-- TOC entry 3259 (class 2606 OID 16482)
-- Name: edu_progs edu_progs_direction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edu_progs
    ADD CONSTRAINT edu_progs_direction_id_fkey FOREIGN KEY (direction_id) REFERENCES public.directions(direction_id);


--
-- TOC entry 3260 (class 2606 OID 16487)
-- Name: edu_progs edu_progs_division_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edu_progs
    ADD CONSTRAINT edu_progs_division_id_fkey FOREIGN KEY (division_id) REFERENCES public.divisions(division_id);


--
-- TOC entry 3264 (class 2606 OID 16537)
-- Name: educators educator_division_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educators
    ADD CONSTRAINT educator_division_id_fkey FOREIGN KEY (division_id) REFERENCES public.divisions(division_id);


--
-- TOC entry 3272 (class 2606 OID 16644)
-- Name: schedule_rows schedule_rows_auditorium_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_rows
    ADD CONSTRAINT schedule_rows_auditorium_id_fkey FOREIGN KEY (auditorium_id) REFERENCES public.auditoriums(auditorium_id);


--
-- TOC entry 3273 (class 2606 OID 16639)
-- Name: schedule_rows schedule_rows_disc_in_curr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_rows
    ADD CONSTRAINT schedule_rows_disc_in_curr_id_fkey FOREIGN KEY (disc_in_curr_id) REFERENCES public.disc_in_curr(disc_in_curr_id);


--
-- TOC entry 3274 (class 2606 OID 16634)
-- Name: schedule_rows schedule_rows_educator_personnel_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_rows
    ADD CONSTRAINT schedule_rows_educator_personnel_number_fkey FOREIGN KEY (educator_personnel_number) REFERENCES public.educators(educator_personnel_number);


--
-- TOC entry 3275 (class 2606 OID 16629)
-- Name: schedule_rows schedule_rows_st_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_rows
    ADD CONSTRAINT schedule_rows_st_group_id_fkey FOREIGN KEY (st_group_id) REFERENCES public.st_groups(st_group_id);


--
-- TOC entry 3263 (class 2606 OID 16517)
-- Name: st_groups st_groups_curriculum_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.st_groups
    ADD CONSTRAINT st_groups_curriculum_id_fkey FOREIGN KEY (curriculum_id) REFERENCES public.curriculums(curriculum_id);


--
-- TOC entry 3265 (class 2606 OID 16557)
-- Name: st_in_group st_in_group_st_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.st_in_group
    ADD CONSTRAINT st_in_group_st_group_id_fkey FOREIGN KEY (st_group_id) REFERENCES public.st_groups(st_group_id);


--
-- TOC entry 3266 (class 2606 OID 16552)
-- Name: st_in_group st_in_group_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.st_in_group
    ADD CONSTRAINT st_in_group_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(student_id);


-- Completed on 2023-04-01 18:22:17

--
-- PostgreSQL database dump complete
--

