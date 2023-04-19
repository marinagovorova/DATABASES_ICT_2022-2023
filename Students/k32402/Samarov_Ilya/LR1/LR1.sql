--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-04-16 16:25:48

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
-- TOC entry 222 (class 1259 OID 21927)
-- Name: area; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.area (
    adres character varying(50) NOT NULL,
    namearea character varying(20),
    statusarea character varying(20)
);


ALTER TABLE public.area OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 21932)
-- Name: audience; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.audience (
    nomberaud integer NOT NULL,
    adres character varying(50),
    capacity integer,
    typeaud character varying(20),
    adress character varying(50)
);


ALTER TABLE public.audience OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 21967)
-- Name: clas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clas (
    nombergroup character varying(20) NOT NULL,
    codedisinsyll integer,
    typeclas character varying(20),
    dateed date,
    timebeg date,
    timeend date,
    nomberaud integer,
    nomberteach integer
);


ALTER TABLE public.clas OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 21847)
-- Name: direction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.direction (
    codedir integer NOT NULL,
    namedir character varying(20),
    qual character(18)
);


ALTER TABLE public.direction OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 21883)
-- Name: discipline; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discipline (
    codedis integer NOT NULL,
    namedis character varying(20)
);


ALTER TABLE public.discipline OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 21898)
-- Name: disciplineinsyll; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.disciplineinsyll (
    codedisinsyll integer NOT NULL,
    hours integer,
    hoursprac integer,
    hourslab integer,
    hoursleck integer,
    namedisis character varying(20),
    codesyll integer,
    codedis integer,
    CONSTRAINT disciplineinsyll_hours_check CHECK ((hours > 0)),
    CONSTRAINT disciplineinsyll_hourslab_check CHECK ((hourslab > 0)),
    CONSTRAINT disciplineinsyll_hoursprac_check CHECK ((hoursprac > 0))
);


ALTER TABLE public.disciplineinsyll OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 21867)
-- Name: educationalprogram; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.educationalprogram (
    codeep integer NOT NULL,
    codesub integer,
    adres character varying(50),
    codedir integer,
    openyear integer,
    CONSTRAINT educationalprogram_openyear_check CHECK ((openyear > 0))
);


ALTER TABLE public.educationalprogram OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 21916)
-- Name: groupp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groupp (
    nombergroup character varying(20) NOT NULL,
    codesyl integer,
    beginn date,
    ends date,
    cours integer,
    status character varying(20),
    codesylla integer,
    CONSTRAINT groupp_check CHECK ((ends > beginn))
);


ALTER TABLE public.groupp OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 21852)
-- Name: place; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.place (
    adres character varying(50) NOT NULL,
    namepl character varying(20),
    status character varying(20)
);


ALTER TABLE public.place OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 21947)
-- Name: student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student (
    numstud integer NOT NULL,
    namestud character varying(30)
);


ALTER TABLE public.student OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 21952)
-- Name: studingroup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.studingroup (
    numstud integer NOT NULL,
    nombergroup character varying(20),
    status character varying(20),
    ends date,
    begins date,
    nombersgroup character varying(20),
    numstudy integer
);


ALTER TABLE public.studingroup OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 21857)
-- Name: subdivision; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subdivision (
    codesub integer NOT NULL,
    adres character varying(50),
    namesub character(18),
    lownamesub character(5)
);


ALTER TABLE public.subdivision OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 21888)
-- Name: syllabus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.syllabus (
    codesyl integer NOT NULL,
    codeep integer,
    namesyll character varying(30),
    years integer,
    codeepr integer
);


ALTER TABLE public.syllabus OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 21942)
-- Name: teacher; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teacher (
    nomberteach integer NOT NULL,
    namet character(30),
    jobtitle character varying(20)
);


ALTER TABLE public.teacher OWNER TO postgres;

--
-- TOC entry 3420 (class 0 OID 21927)
-- Dependencies: 222
-- Data for Name: area; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.area (adres, namearea, statusarea) FROM stdin;
\.


--
-- TOC entry 3421 (class 0 OID 21932)
-- Dependencies: 223
-- Data for Name: audience; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.audience (nomberaud, adres, capacity, typeaud, adress) FROM stdin;
\.


--
-- TOC entry 3425 (class 0 OID 21967)
-- Dependencies: 227
-- Data for Name: clas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clas (nombergroup, codedisinsyll, typeclas, dateed, timebeg, timeend, nomberaud, nomberteach) FROM stdin;
\.


--
-- TOC entry 3412 (class 0 OID 21847)
-- Dependencies: 214
-- Data for Name: direction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.direction (codedir, namedir, qual) FROM stdin;
\.


--
-- TOC entry 3416 (class 0 OID 21883)
-- Dependencies: 218
-- Data for Name: discipline; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discipline (codedis, namedis) FROM stdin;
\.


--
-- TOC entry 3418 (class 0 OID 21898)
-- Dependencies: 220
-- Data for Name: disciplineinsyll; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.disciplineinsyll (codedisinsyll, hours, hoursprac, hourslab, hoursleck, namedisis, codesyll, codedis) FROM stdin;
\.


--
-- TOC entry 3415 (class 0 OID 21867)
-- Dependencies: 217
-- Data for Name: educationalprogram; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.educationalprogram (codeep, codesub, adres, codedir, openyear) FROM stdin;
\.


--
-- TOC entry 3419 (class 0 OID 21916)
-- Dependencies: 221
-- Data for Name: groupp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.groupp (nombergroup, codesyl, beginn, ends, cours, status, codesylla) FROM stdin;
\.


--
-- TOC entry 3413 (class 0 OID 21852)
-- Dependencies: 215
-- Data for Name: place; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.place (adres, namepl, status) FROM stdin;
\.


--
-- TOC entry 3423 (class 0 OID 21947)
-- Dependencies: 225
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student (numstud, namestud) FROM stdin;
\.


--
-- TOC entry 3424 (class 0 OID 21952)
-- Dependencies: 226
-- Data for Name: studingroup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.studingroup (numstud, nombergroup, status, ends, begins, nombersgroup, numstudy) FROM stdin;
\.


--
-- TOC entry 3414 (class 0 OID 21857)
-- Dependencies: 216
-- Data for Name: subdivision; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subdivision (codesub, adres, namesub, lownamesub) FROM stdin;
\.


--
-- TOC entry 3417 (class 0 OID 21888)
-- Dependencies: 219
-- Data for Name: syllabus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.syllabus (codesyl, codeep, namesyll, years, codeepr) FROM stdin;
\.


--
-- TOC entry 3422 (class 0 OID 21942)
-- Dependencies: 224
-- Data for Name: teacher; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teacher (nomberteach, namet, jobtitle) FROM stdin;
\.


--
-- TOC entry 3246 (class 2606 OID 21931)
-- Name: area area_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_pkey PRIMARY KEY (adres);


--
-- TOC entry 3248 (class 2606 OID 21936)
-- Name: audience audience_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audience
    ADD CONSTRAINT audience_pkey PRIMARY KEY (nomberaud);


--
-- TOC entry 3256 (class 2606 OID 21971)
-- Name: clas clas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clas
    ADD CONSTRAINT clas_pkey PRIMARY KEY (nombergroup);


--
-- TOC entry 3230 (class 2606 OID 21851)
-- Name: direction direction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.direction
    ADD CONSTRAINT direction_pkey PRIMARY KEY (codedir);


--
-- TOC entry 3238 (class 2606 OID 21887)
-- Name: discipline discipline_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discipline
    ADD CONSTRAINT discipline_pkey PRIMARY KEY (codedis);


--
-- TOC entry 3242 (class 2606 OID 21905)
-- Name: disciplineinsyll disciplineinsyll_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplineinsyll
    ADD CONSTRAINT disciplineinsyll_pkey PRIMARY KEY (codedisinsyll);


--
-- TOC entry 3236 (class 2606 OID 21872)
-- Name: educationalprogram educationalprogram_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educationalprogram
    ADD CONSTRAINT educationalprogram_pkey PRIMARY KEY (codeep);


--
-- TOC entry 3244 (class 2606 OID 21921)
-- Name: groupp groupp_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupp
    ADD CONSTRAINT groupp_pkey PRIMARY KEY (nombergroup);


--
-- TOC entry 3232 (class 2606 OID 21856)
-- Name: place place_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.place
    ADD CONSTRAINT place_pkey PRIMARY KEY (adres);


--
-- TOC entry 3252 (class 2606 OID 21951)
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (numstud);


--
-- TOC entry 3254 (class 2606 OID 21956)
-- Name: studingroup studingroup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.studingroup
    ADD CONSTRAINT studingroup_pkey PRIMARY KEY (numstud);


--
-- TOC entry 3234 (class 2606 OID 21861)
-- Name: subdivision subdivision_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subdivision
    ADD CONSTRAINT subdivision_pkey PRIMARY KEY (codesub);


--
-- TOC entry 3240 (class 2606 OID 21892)
-- Name: syllabus syllabus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.syllabus
    ADD CONSTRAINT syllabus_pkey PRIMARY KEY (codesyl);


--
-- TOC entry 3250 (class 2606 OID 21946)
-- Name: teacher teacher_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher
    ADD CONSTRAINT teacher_pkey PRIMARY KEY (nomberteach);


--
-- TOC entry 3264 (class 2606 OID 21937)
-- Name: audience audience_adress_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audience
    ADD CONSTRAINT audience_adress_fkey FOREIGN KEY (adress) REFERENCES public.area(adres);


--
-- TOC entry 3267 (class 2606 OID 21982)
-- Name: clas clas_nomberaud_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clas
    ADD CONSTRAINT clas_nomberaud_fkey FOREIGN KEY (nomberaud) REFERENCES public.audience(nomberaud);


--
-- TOC entry 3268 (class 2606 OID 21972)
-- Name: clas clas_nombergroup_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clas
    ADD CONSTRAINT clas_nombergroup_fkey FOREIGN KEY (nombergroup) REFERENCES public.groupp(nombergroup);


--
-- TOC entry 3269 (class 2606 OID 21977)
-- Name: clas clas_nomberteach_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clas
    ADD CONSTRAINT clas_nomberteach_fkey FOREIGN KEY (nomberteach) REFERENCES public.teacher(nomberteach);


--
-- TOC entry 3261 (class 2606 OID 21911)
-- Name: disciplineinsyll disciplineinsyll_codedis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplineinsyll
    ADD CONSTRAINT disciplineinsyll_codedis_fkey FOREIGN KEY (codedis) REFERENCES public.discipline(codedis);


--
-- TOC entry 3262 (class 2606 OID 21906)
-- Name: disciplineinsyll disciplineinsyll_codesyll_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplineinsyll
    ADD CONSTRAINT disciplineinsyll_codesyll_fkey FOREIGN KEY (codesyll) REFERENCES public.syllabus(codesyl);


--
-- TOC entry 3258 (class 2606 OID 21878)
-- Name: educationalprogram educationalprogram_codedir_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educationalprogram
    ADD CONSTRAINT educationalprogram_codedir_fkey FOREIGN KEY (codedir) REFERENCES public.direction(codedir);


--
-- TOC entry 3259 (class 2606 OID 21873)
-- Name: educationalprogram educationalprogram_codesub_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educationalprogram
    ADD CONSTRAINT educationalprogram_codesub_fkey FOREIGN KEY (codesub) REFERENCES public.subdivision(codesub);


--
-- TOC entry 3263 (class 2606 OID 21922)
-- Name: groupp groupp_codesylla_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupp
    ADD CONSTRAINT groupp_codesylla_fkey FOREIGN KEY (codesylla) REFERENCES public.syllabus(codesyl);


--
-- TOC entry 3265 (class 2606 OID 21957)
-- Name: studingroup studingroup_nombersgroup_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.studingroup
    ADD CONSTRAINT studingroup_nombersgroup_fkey FOREIGN KEY (nombersgroup) REFERENCES public.groupp(nombergroup);


--
-- TOC entry 3266 (class 2606 OID 21962)
-- Name: studingroup studingroup_numstudy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.studingroup
    ADD CONSTRAINT studingroup_numstudy_fkey FOREIGN KEY (numstudy) REFERENCES public.student(numstud);


--
-- TOC entry 3257 (class 2606 OID 21862)
-- Name: subdivision subdivision_adres_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subdivision
    ADD CONSTRAINT subdivision_adres_fkey FOREIGN KEY (adres) REFERENCES public.place(adres);


--
-- TOC entry 3260 (class 2606 OID 21893)
-- Name: syllabus syllabus_codeepr_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.syllabus
    ADD CONSTRAINT syllabus_codeepr_fkey FOREIGN KEY (codeepr) REFERENCES public.educationalprogram(codeep);


-- Completed on 2023-04-16 16:25:48

--
-- PostgreSQL database dump complete
--

