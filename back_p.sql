--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-05-02 13:44:26

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
-- TOC entry 222 (class 1259 OID 22736)
-- Name: audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.audit (
    code_aud integer NOT NULL,
    type_aud character varying(40),
    code_cors integer,
    capacity integer
);


ALTER TABLE public.audit OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 22731)
-- Name: corpus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.corpus (
    code_cor integer NOT NULL,
    adres character varying(30)
);


ALTER TABLE public.corpus OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 22670)
-- Name: direction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.direction (
    code_dir integer NOT NULL,
    name_dir character varying(20)
);


ALTER TABLE public.direction OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 22771)
-- Name: discipline; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discipline (
    code_dis integer NOT NULL,
    code_ed integer,
    hours_lb integer,
    hours_pr integer,
    name_dis character varying(30)
);


ALTER TABLE public.discipline OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 22776)
-- Name: discipline_op; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discipline_op (
    name_diss character varying(30) NOT NULL,
    code_diss integer,
    code_plan integer
);


ALTER TABLE public.discipline_op OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 22716)
-- Name: ed_student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ed_student (
    code_es integer NOT NULL,
    num_book integer,
    num_gr integer,
    cod_grs integer
);


ALTER TABLE public.ed_student OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 22675)
-- Name: educational; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.educational (
    code_ed integer NOT NULL,
    code_dirs integer,
    code_sub integer,
    name_ed character varying(25)
);


ALTER TABLE public.educational OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 22791)
-- Name: exam; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exam (
    code_ex integer NOT NULL,
    type_ex character varying(20),
    num_attempt integer,
    code_teach integer,
    grade integer,
    name_dis character varying(30),
    code_stud integer
);


ALTER TABLE public.exam OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 22751)
-- Name: exam_schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exam_schedule (
    code_exsh integer NOT NULL,
    ex_date date,
    name_ex character varying(30),
    code_auds integer,
    teacher_code integer,
    code_group integer
);


ALTER TABLE public.exam_schedule OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 22700)
-- Name: groupp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groupp (
    code_gr integer NOT NULL,
    date_beg date,
    date_end date,
    code_s integer,
    CONSTRAINT groupp_check CHECK ((date_end > date_beg))
);


ALTER TABLE public.groupp OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 22711)
-- Name: student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student (
    num_stub integer NOT NULL,
    name_s character varying(50),
    date_beg date
);


ALTER TABLE public.student OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 22665)
-- Name: subdivision; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subdivision (
    sub_code integer NOT NULL,
    sub_name character varying(30)
);


ALTER TABLE public.subdivision OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 22690)
-- Name: syllabus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.syllabus (
    code_syl integer NOT NULL,
    date_p date,
    code_eds integer
);


ALTER TABLE public.syllabus OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 22746)
-- Name: techer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.techer (
    code_teach integer NOT NULL,
    name_tech character varying(40),
    teach_title character varying(40)
);


ALTER TABLE public.techer OWNER TO postgres;

--
-- TOC entry 3418 (class 0 OID 22736)
-- Dependencies: 222
-- Data for Name: audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.audit (code_aud, type_aud, code_cors, capacity) FROM stdin;
\.


--
-- TOC entry 3417 (class 0 OID 22731)
-- Dependencies: 221
-- Data for Name: corpus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.corpus (code_cor, adres) FROM stdin;
\.


--
-- TOC entry 3411 (class 0 OID 22670)
-- Dependencies: 215
-- Data for Name: direction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.direction (code_dir, name_dir) FROM stdin;
\.


--
-- TOC entry 3421 (class 0 OID 22771)
-- Dependencies: 225
-- Data for Name: discipline; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discipline (code_dis, code_ed, hours_lb, hours_pr, name_dis) FROM stdin;
\.


--
-- TOC entry 3422 (class 0 OID 22776)
-- Dependencies: 226
-- Data for Name: discipline_op; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discipline_op (name_diss, code_diss, code_plan) FROM stdin;
\.


--
-- TOC entry 3416 (class 0 OID 22716)
-- Dependencies: 220
-- Data for Name: ed_student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ed_student (code_es, num_book, num_gr, cod_grs) FROM stdin;
\.


--
-- TOC entry 3412 (class 0 OID 22675)
-- Dependencies: 216
-- Data for Name: educational; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.educational (code_ed, code_dirs, code_sub, name_ed) FROM stdin;
\.


--
-- TOC entry 3423 (class 0 OID 22791)
-- Dependencies: 227
-- Data for Name: exam; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exam (code_ex, type_ex, num_attempt, code_teach, grade, name_dis, code_stud) FROM stdin;
\.


--
-- TOC entry 3420 (class 0 OID 22751)
-- Dependencies: 224
-- Data for Name: exam_schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exam_schedule (code_exsh, ex_date, name_ex, code_auds, teacher_code, code_group) FROM stdin;
\.


--
-- TOC entry 3414 (class 0 OID 22700)
-- Dependencies: 218
-- Data for Name: groupp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.groupp (code_gr, date_beg, date_end, code_s) FROM stdin;
\.


--
-- TOC entry 3415 (class 0 OID 22711)
-- Dependencies: 219
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student (num_stub, name_s, date_beg) FROM stdin;
\.


--
-- TOC entry 3410 (class 0 OID 22665)
-- Dependencies: 214
-- Data for Name: subdivision; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subdivision (sub_code, sub_name) FROM stdin;
\.


--
-- TOC entry 3413 (class 0 OID 22690)
-- Dependencies: 217
-- Data for Name: syllabus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.syllabus (code_syl, date_p, code_eds) FROM stdin;
\.


--
-- TOC entry 3419 (class 0 OID 22746)
-- Dependencies: 223
-- Data for Name: techer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.techer (code_teach, name_tech, teach_title) FROM stdin;
\.


--
-- TOC entry 3242 (class 2606 OID 22740)
-- Name: audit audit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit
    ADD CONSTRAINT audit_pkey PRIMARY KEY (code_aud);


--
-- TOC entry 3240 (class 2606 OID 22735)
-- Name: corpus corpus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.corpus
    ADD CONSTRAINT corpus_pkey PRIMARY KEY (code_cor);


--
-- TOC entry 3228 (class 2606 OID 22674)
-- Name: direction direction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.direction
    ADD CONSTRAINT direction_pkey PRIMARY KEY (code_dir);


--
-- TOC entry 3250 (class 2606 OID 22780)
-- Name: discipline_op discipline_op_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discipline_op
    ADD CONSTRAINT discipline_op_pkey PRIMARY KEY (name_diss);


--
-- TOC entry 3248 (class 2606 OID 22775)
-- Name: discipline discipline_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discipline
    ADD CONSTRAINT discipline_pkey PRIMARY KEY (code_dis);


--
-- TOC entry 3238 (class 2606 OID 22720)
-- Name: ed_student ed_student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ed_student
    ADD CONSTRAINT ed_student_pkey PRIMARY KEY (code_es);


--
-- TOC entry 3230 (class 2606 OID 22679)
-- Name: educational educational_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educational
    ADD CONSTRAINT educational_pkey PRIMARY KEY (code_ed);


--
-- TOC entry 3252 (class 2606 OID 22795)
-- Name: exam exam_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exam
    ADD CONSTRAINT exam_pkey PRIMARY KEY (code_ex);


--
-- TOC entry 3246 (class 2606 OID 22755)
-- Name: exam_schedule exam_schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exam_schedule
    ADD CONSTRAINT exam_schedule_pkey PRIMARY KEY (code_exsh);


--
-- TOC entry 3234 (class 2606 OID 22705)
-- Name: groupp groupp_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupp
    ADD CONSTRAINT groupp_pkey PRIMARY KEY (code_gr);


--
-- TOC entry 3236 (class 2606 OID 22715)
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (num_stub);


--
-- TOC entry 3226 (class 2606 OID 22669)
-- Name: subdivision subdivision_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subdivision
    ADD CONSTRAINT subdivision_pkey PRIMARY KEY (sub_code);


--
-- TOC entry 3232 (class 2606 OID 22694)
-- Name: syllabus syllabus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.syllabus
    ADD CONSTRAINT syllabus_pkey PRIMARY KEY (code_syl);


--
-- TOC entry 3244 (class 2606 OID 22750)
-- Name: techer techer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.techer
    ADD CONSTRAINT techer_pkey PRIMARY KEY (code_teach);


--
-- TOC entry 3259 (class 2606 OID 22741)
-- Name: audit audit_code_cors_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit
    ADD CONSTRAINT audit_code_cors_fkey FOREIGN KEY (code_cors) REFERENCES public.corpus(code_cor);


--
-- TOC entry 3263 (class 2606 OID 22781)
-- Name: discipline_op discipline_op_code_diss_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discipline_op
    ADD CONSTRAINT discipline_op_code_diss_fkey FOREIGN KEY (code_diss) REFERENCES public.discipline(code_dis);


--
-- TOC entry 3264 (class 2606 OID 22786)
-- Name: discipline_op discipline_op_code_plan_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discipline_op
    ADD CONSTRAINT discipline_op_code_plan_fkey FOREIGN KEY (code_plan) REFERENCES public.syllabus(code_syl);


--
-- TOC entry 3257 (class 2606 OID 22726)
-- Name: ed_student ed_student_cod_grs_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ed_student
    ADD CONSTRAINT ed_student_cod_grs_fkey FOREIGN KEY (cod_grs) REFERENCES public.groupp(code_gr);


--
-- TOC entry 3258 (class 2606 OID 22721)
-- Name: ed_student ed_student_num_gr_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ed_student
    ADD CONSTRAINT ed_student_num_gr_fkey FOREIGN KEY (num_gr) REFERENCES public.student(num_stub);


--
-- TOC entry 3253 (class 2606 OID 22680)
-- Name: educational educational_code_dirs_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educational
    ADD CONSTRAINT educational_code_dirs_fkey FOREIGN KEY (code_dirs) REFERENCES public.direction(code_dir);


--
-- TOC entry 3254 (class 2606 OID 22685)
-- Name: educational educational_code_sub_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educational
    ADD CONSTRAINT educational_code_sub_fkey FOREIGN KEY (code_sub) REFERENCES public.subdivision(sub_code);


--
-- TOC entry 3265 (class 2606 OID 22801)
-- Name: exam exam_code_stud_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exam
    ADD CONSTRAINT exam_code_stud_fkey FOREIGN KEY (code_stud) REFERENCES public.ed_student(code_es);


--
-- TOC entry 3266 (class 2606 OID 22796)
-- Name: exam exam_code_teach_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exam
    ADD CONSTRAINT exam_code_teach_fkey FOREIGN KEY (code_teach) REFERENCES public.techer(code_teach);


--
-- TOC entry 3267 (class 2606 OID 22806)
-- Name: exam exam_name_dis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exam
    ADD CONSTRAINT exam_name_dis_fkey FOREIGN KEY (name_dis) REFERENCES public.discipline_op(name_diss);


--
-- TOC entry 3260 (class 2606 OID 22756)
-- Name: exam_schedule exam_schedule_code_auds_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exam_schedule
    ADD CONSTRAINT exam_schedule_code_auds_fkey FOREIGN KEY (code_auds) REFERENCES public.audit(code_aud);


--
-- TOC entry 3261 (class 2606 OID 22766)
-- Name: exam_schedule exam_schedule_code_group_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exam_schedule
    ADD CONSTRAINT exam_schedule_code_group_fkey FOREIGN KEY (code_group) REFERENCES public.groupp(code_gr);


--
-- TOC entry 3262 (class 2606 OID 22761)
-- Name: exam_schedule exam_schedule_teacher_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exam_schedule
    ADD CONSTRAINT exam_schedule_teacher_code_fkey FOREIGN KEY (teacher_code) REFERENCES public.techer(code_teach);


--
-- TOC entry 3256 (class 2606 OID 22706)
-- Name: groupp groupp_code_s_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupp
    ADD CONSTRAINT groupp_code_s_fkey FOREIGN KEY (code_s) REFERENCES public.syllabus(code_syl);


--
-- TOC entry 3255 (class 2606 OID 22695)
-- Name: syllabus syllabus_code_eds_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.syllabus
    ADD CONSTRAINT syllabus_code_eds_fkey FOREIGN KEY (code_eds) REFERENCES public.educational(code_ed);


-- Completed on 2023-05-02 13:44:27

--
-- PostgreSQL database dump complete
--

