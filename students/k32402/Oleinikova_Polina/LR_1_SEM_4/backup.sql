--
-- PostgreSQL database dump
--

-- Dumped from database version 11.19
-- Dumped by pg_dump version 11.19

-- Started on 2023-03-20 10:30:16

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
-- TOC entry 2910 (class 1262 OID 16393)
-- Name: Accounting for tasks; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "Accounting for tasks" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Russian_Russia.1251' LC_CTYPE = 'Russian_Russia.1251';


ALTER DATABASE "Accounting for tasks" OWNER TO postgres;

\connect -reuse-previous=on "dbname='Accounting for tasks'"

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
-- TOC entry 6 (class 2615 OID 16394)
-- Name: accounting_for_tasks; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA accounting_for_tasks;


ALTER SCHEMA accounting_for_tasks OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 203 (class 1259 OID 16460)
-- Name: contract; Type: TABLE; Schema: accounting_for_tasks; Owner: postgres
--

CREATE TABLE accounting_for_tasks.contract (
    id_contract integer NOT NULL,
    id_staffing integer NOT NULL,
    id_employee integer NOT NULL
);


ALTER TABLE accounting_for_tasks.contract OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16500)
-- Name: control; Type: TABLE; Schema: accounting_for_tasks; Owner: postgres
--

CREATE TABLE accounting_for_tasks.control (
    id_control integer NOT NULL,
    id_task integer NOT NULL,
    date date NOT NULL,
    status integer NOT NULL,
    comment text NOT NULL
);


ALTER TABLE accounting_for_tasks.control OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 16395)
-- Name: department; Type: TABLE; Schema: accounting_for_tasks; Owner: postgres
--

CREATE TABLE accounting_for_tasks.department (
    id_departament integer NOT NULL,
    name character varying(40) NOT NULL,
    phone_number bigint NOT NULL
);


ALTER TABLE accounting_for_tasks.department OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16422)
-- Name: employee; Type: TABLE; Schema: accounting_for_tasks; Owner: postgres
--

CREATE TABLE accounting_for_tasks.employee (
    id_employee integer NOT NULL,
    fio character varying(50) NOT NULL
);


ALTER TABLE accounting_for_tasks.employee OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16514)
-- Name: employee_on_task; Type: TABLE; Schema: accounting_for_tasks; Owner: postgres
--

CREATE TABLE accounting_for_tasks.employee_on_task (
    id_employee_on_task integer NOT NULL,
    id_task integer NOT NULL,
    id_contract integer NOT NULL,
    status integer NOT NULL,
    reward integer NOT NULL
);


ALTER TABLE accounting_for_tasks.employee_on_task OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 16444)
-- Name: organization; Type: TABLE; Schema: accounting_for_tasks; Owner: postgres
--

CREATE TABLE accounting_for_tasks.organization (
    id_organization integer NOT NULL,
    name character varying(50) NOT NULL,
    address character varying(50) NOT NULL,
    phone_number bigint NOT NULL
);


ALTER TABLE accounting_for_tasks.organization OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 16400)
-- Name: position; Type: TABLE; Schema: accounting_for_tasks; Owner: postgres
--

CREATE TABLE accounting_for_tasks."position" (
    id_position integer NOT NULL,
    name character varying(20) NOT NULL,
    salary integer NOT NULL
);


ALTER TABLE accounting_for_tasks."position" OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16449)
-- Name: project; Type: TABLE; Schema: accounting_for_tasks; Owner: postgres
--

CREATE TABLE accounting_for_tasks.project (
    id_project integer NOT NULL,
    id_organization integer NOT NULL,
    leader integer NOT NULL,
    manager integer NOT NULL,
    date_start date NOT NULL,
    date_end date NOT NULL,
    name character varying(50) NOT NULL,
    code integer NOT NULL,
    price integer NOT NULL,
    execution character varying(20) NOT NULL,
    payment character varying(20) NOT NULL
);


ALTER TABLE accounting_for_tasks.project OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 16405)
-- Name: staffing; Type: TABLE; Schema: accounting_for_tasks; Owner: postgres
--

CREATE TABLE accounting_for_tasks.staffing (
    id_staffing integer NOT NULL,
    rate real NOT NULL,
    id_position integer NOT NULL,
    id_department integer NOT NULL
);


ALTER TABLE accounting_for_tasks.staffing OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16489)
-- Name: task; Type: TABLE; Schema: accounting_for_tasks; Owner: postgres
--

CREATE TABLE accounting_for_tasks.task (
    id_task integer NOT NULL,
    id_project integer NOT NULL,
    date_start date NOT NULL,
    date_end date NOT NULL,
    price integer NOT NULL,
    description text NOT NULL
);


ALTER TABLE accounting_for_tasks.task OWNER TO postgres;

--
-- TOC entry 2901 (class 0 OID 16460)
-- Dependencies: 203
-- Data for Name: contract; Type: TABLE DATA; Schema: accounting_for_tasks; Owner: postgres
--

INSERT INTO accounting_for_tasks.contract (id_contract, id_staffing, id_employee) VALUES (1, 1, 1);
INSERT INTO accounting_for_tasks.contract (id_contract, id_staffing, id_employee) VALUES (2, 3, 3);
INSERT INTO accounting_for_tasks.contract (id_contract, id_staffing, id_employee) VALUES (3, 2, 2);


--
-- TOC entry 2903 (class 0 OID 16500)
-- Dependencies: 205
-- Data for Name: control; Type: TABLE DATA; Schema: accounting_for_tasks; Owner: postgres
--

INSERT INTO accounting_for_tasks.control (id_control, id_task, date, status, comment) VALUES (2, 2, '2023-08-02', 0, 'еще ничего не сделано');
INSERT INTO accounting_for_tasks.control (id_control, id_task, date, status, comment) VALUES (1, 1, '2023-07-02', 100, 'правок нет');
INSERT INTO accounting_for_tasks.control (id_control, id_task, date, status, comment) VALUES (3, 3, '2023-07-23', 75, 'доделать');


--
-- TOC entry 2895 (class 0 OID 16395)
-- Dependencies: 197
-- Data for Name: department; Type: TABLE DATA; Schema: accounting_for_tasks; Owner: postgres
--

INSERT INTO accounting_for_tasks.department (id_departament, name, phone_number) VALUES (1, 'ДИС', 89128967277);
INSERT INTO accounting_for_tasks.department (id_departament, name, phone_number) VALUES (2, 'ДОД', 89218967277);
INSERT INTO accounting_for_tasks.department (id_departament, name, phone_number) VALUES (3, 'ДНИР', 89128989234);


--
-- TOC entry 2898 (class 0 OID 16422)
-- Dependencies: 200
-- Data for Name: employee; Type: TABLE DATA; Schema: accounting_for_tasks; Owner: postgres
--

INSERT INTO accounting_for_tasks.employee (id_employee, fio) VALUES (1, 'Иванов Иван Иванович');
INSERT INTO accounting_for_tasks.employee (id_employee, fio) VALUES (2, 'Сергеев Сергей Сергеевич');
INSERT INTO accounting_for_tasks.employee (id_employee, fio) VALUES (3, 'Олейникова Полина Леонидовна');
INSERT INTO accounting_for_tasks.employee (id_employee, fio) VALUES (4, 'Алексеев Алексей Алексеевич
');


--
-- TOC entry 2904 (class 0 OID 16514)
-- Dependencies: 206
-- Data for Name: employee_on_task; Type: TABLE DATA; Schema: accounting_for_tasks; Owner: postgres
--

INSERT INTO accounting_for_tasks.employee_on_task (id_employee_on_task, id_task, id_contract, status, reward) VALUES (1, 1, 1, 1, 10000);
INSERT INTO accounting_for_tasks.employee_on_task (id_employee_on_task, id_task, id_contract, status, reward) VALUES (2, 2, 2, 0, 6000);


--
-- TOC entry 2899 (class 0 OID 16444)
-- Dependencies: 201
-- Data for Name: organization; Type: TABLE DATA; Schema: accounting_for_tasks; Owner: postgres
--

INSERT INTO accounting_for_tasks.organization (id_organization, name, address, phone_number) VALUES (1, 'ИТМО', 'Кронверский 49', 89128989898);
INSERT INTO accounting_for_tasks.organization (id_organization, name, address, phone_number) VALUES (2, 'СПБПУ', 'Политехническая 29', 89128083697);


--
-- TOC entry 2896 (class 0 OID 16400)
-- Dependencies: 198
-- Data for Name: position; Type: TABLE DATA; Schema: accounting_for_tasks; Owner: postgres
--

INSERT INTO accounting_for_tasks."position" (id_position, name, salary) VALUES (2, 'руководитель', 250000);
INSERT INTO accounting_for_tasks."position" (id_position, name, salary) VALUES (1, 'программист', 150000);
INSERT INTO accounting_for_tasks."position" (id_position, name, salary) VALUES (3, 'лаборант', 45000);


--
-- TOC entry 2900 (class 0 OID 16449)
-- Dependencies: 202
-- Data for Name: project; Type: TABLE DATA; Schema: accounting_for_tasks; Owner: postgres
--

INSERT INTO accounting_for_tasks.project (id_project, id_organization, leader, manager, date_start, date_end, name, code, price, execution, payment) VALUES (1, 1, 3, 2, '2023-06-03', '2024-07-03', 'my.itmo', 1, 1000000, 'в процессе', 'не оплачено');
INSERT INTO accounting_for_tasks.project (id_project, id_organization, leader, manager, date_start, date_end, name, code, price, execution, payment) VALUES (2, 2, 3, 2, '2023-07-01', '2024-07-01', 'ису', 2, 1000000, 'готово', 'оплачено');


--
-- TOC entry 2897 (class 0 OID 16405)
-- Dependencies: 199
-- Data for Name: staffing; Type: TABLE DATA; Schema: accounting_for_tasks; Owner: postgres
--

INSERT INTO accounting_for_tasks.staffing (id_staffing, rate, id_position, id_department) VALUES (1, 20, 3, 1);
INSERT INTO accounting_for_tasks.staffing (id_staffing, rate, id_position, id_department) VALUES (2, 10, 2, 1);
INSERT INTO accounting_for_tasks.staffing (id_staffing, rate, id_position, id_department) VALUES (3, 5, 1, 1);


--
-- TOC entry 2902 (class 0 OID 16489)
-- Dependencies: 204
-- Data for Name: task; Type: TABLE DATA; Schema: accounting_for_tasks; Owner: postgres
--

INSERT INTO accounting_for_tasks.task (id_task, id_project, date_start, date_end, price, description) VALUES (1, 1, '2023-06-03', '2023-07-03', 10000, 'страница персоналий');
INSERT INTO accounting_for_tasks.task (id_task, id_project, date_start, date_end, price, description) VALUES (2, 1, '2023-07-03', '2023-08-03', 10000, 'страница расписания');
INSERT INTO accounting_for_tasks.task (id_task, id_project, date_start, date_end, price, description) VALUES (3, 1, '2023-08-03', '2023-09-25', 15000, 'страница заявок');


--
-- TOC entry 2751 (class 2606 OID 16464)
-- Name: contract contarct_pkey; Type: CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE ONLY accounting_for_tasks.contract
    ADD CONSTRAINT contarct_pkey PRIMARY KEY (id_contract);


--
-- TOC entry 2758 (class 2606 OID 16507)
-- Name: control control_pkey; Type: CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE ONLY accounting_for_tasks.control
    ADD CONSTRAINT control_pkey PRIMARY KEY (id_control);


--
-- TOC entry 2726 (class 2606 OID 16542)
-- Name: project date_end; Type: CHECK CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE accounting_for_tasks.project
    ADD CONSTRAINT date_end CHECK ((date_end > date_start)) NOT VALID;


--
-- TOC entry 2911 (class 0 OID 0)
-- Dependencies: 2726
-- Name: CONSTRAINT date_end ON project; Type: COMMENT; Schema: accounting_for_tasks; Owner: postgres
--

COMMENT ON CONSTRAINT date_end ON accounting_for_tasks.project IS 'Дата конца больше даты начала';


--
-- TOC entry 2728 (class 2606 OID 16544)
-- Name: task date_end; Type: CHECK CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE accounting_for_tasks.task
    ADD CONSTRAINT date_end CHECK ((date_end > date_start)) NOT VALID;


--
-- TOC entry 2912 (class 0 OID 0)
-- Dependencies: 2728
-- Name: CONSTRAINT date_end ON task; Type: COMMENT; Schema: accounting_for_tasks; Owner: postgres
--

COMMENT ON CONSTRAINT date_end ON accounting_for_tasks.task IS 'дата конца больше даты начала';


--
-- TOC entry 2734 (class 2606 OID 16399)
-- Name: department departament_pkey; Type: CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE ONLY accounting_for_tasks.department
    ADD CONSTRAINT departament_pkey PRIMARY KEY (id_departament);


--
-- TOC entry 2761 (class 2606 OID 16518)
-- Name: employee_on_task employee_on_task_pkey; Type: CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE ONLY accounting_for_tasks.employee_on_task
    ADD CONSTRAINT employee_on_task_pkey PRIMARY KEY (id_employee_on_task);


--
-- TOC entry 2742 (class 2606 OID 16426)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE ONLY accounting_for_tasks.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (id_employee);


--
-- TOC entry 2744 (class 2606 OID 16448)
-- Name: organization organization_pkey; Type: CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE ONLY accounting_for_tasks.organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (id_organization);


--
-- TOC entry 2722 (class 2606 OID 16537)
-- Name: department phone_number; Type: CHECK CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE accounting_for_tasks.department
    ADD CONSTRAINT phone_number CHECK (((phone_number > '9999999999'::bigint) AND (phone_number < '100000000000'::bigint))) NOT VALID;


--
-- TOC entry 2913 (class 0 OID 0)
-- Dependencies: 2722
-- Name: CONSTRAINT phone_number ON department; Type: COMMENT; Schema: accounting_for_tasks; Owner: postgres
--

COMMENT ON CONSTRAINT phone_number ON accounting_for_tasks.department IS 'телефонный номер в 11 цифр';


--
-- TOC entry 2725 (class 2606 OID 16540)
-- Name: organization phone_number; Type: CHECK CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE accounting_for_tasks.organization
    ADD CONSTRAINT phone_number CHECK (((phone_number > '9999999999'::bigint) AND (phone_number < '100000000000'::bigint))) NOT VALID;


--
-- TOC entry 2914 (class 0 OID 0)
-- Dependencies: 2725
-- Name: CONSTRAINT phone_number ON organization; Type: COMMENT; Schema: accounting_for_tasks; Owner: postgres
--

COMMENT ON CONSTRAINT phone_number ON accounting_for_tasks.organization IS 'телефонный номер в 11 цифр';


--
-- TOC entry 2736 (class 2606 OID 16404)
-- Name: position position_pkey; Type: CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE ONLY accounting_for_tasks."position"
    ADD CONSTRAINT position_pkey PRIMARY KEY (id_position);


--
-- TOC entry 2727 (class 2606 OID 16543)
-- Name: project price; Type: CHECK CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE accounting_for_tasks.project
    ADD CONSTRAINT price CHECK ((price > 0)) NOT VALID;


--
-- TOC entry 2915 (class 0 OID 0)
-- Dependencies: 2727
-- Name: CONSTRAINT price ON project; Type: COMMENT; Schema: accounting_for_tasks; Owner: postgres
--

COMMENT ON CONSTRAINT price ON accounting_for_tasks.project IS 'положительная цена';


--
-- TOC entry 2729 (class 2606 OID 16545)
-- Name: task price; Type: CHECK CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE accounting_for_tasks.task
    ADD CONSTRAINT price CHECK ((price > 0)) NOT VALID;


--
-- TOC entry 2916 (class 0 OID 0)
-- Dependencies: 2729
-- Name: CONSTRAINT price ON task; Type: COMMENT; Schema: accounting_for_tasks; Owner: postgres
--

COMMENT ON CONSTRAINT price ON accounting_for_tasks.task IS 'положительная цена';


--
-- TOC entry 2749 (class 2606 OID 16453)
-- Name: project project_pkey; Type: CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE ONLY accounting_for_tasks.project
    ADD CONSTRAINT project_pkey PRIMARY KEY (id_project);


--
-- TOC entry 2724 (class 2606 OID 16551)
-- Name: staffing rate; Type: CHECK CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE accounting_for_tasks.staffing
    ADD CONSTRAINT rate CHECK ((rate > (0)::double precision)) NOT VALID;


--
-- TOC entry 2917 (class 0 OID 0)
-- Dependencies: 2724
-- Name: CONSTRAINT rate ON staffing; Type: COMMENT; Schema: accounting_for_tasks; Owner: postgres
--

COMMENT ON CONSTRAINT rate ON accounting_for_tasks.staffing IS 'положительная ставка';


--
-- TOC entry 2731 (class 2606 OID 16538)
-- Name: employee_on_task reward; Type: CHECK CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE accounting_for_tasks.employee_on_task
    ADD CONSTRAINT reward CHECK ((reward > 0)) NOT VALID;


--
-- TOC entry 2918 (class 0 OID 0)
-- Dependencies: 2731
-- Name: CONSTRAINT reward ON employee_on_task; Type: COMMENT; Schema: accounting_for_tasks; Owner: postgres
--

COMMENT ON CONSTRAINT reward ON accounting_for_tasks.employee_on_task IS 'положительное вознаграждение';


--
-- TOC entry 2723 (class 2606 OID 16541)
-- Name: position salary; Type: CHECK CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE accounting_for_tasks."position"
    ADD CONSTRAINT salary CHECK ((salary > 0)) NOT VALID;


--
-- TOC entry 2919 (class 0 OID 0)
-- Dependencies: 2723
-- Name: CONSTRAINT salary ON "position"; Type: COMMENT; Schema: accounting_for_tasks; Owner: postgres
--

COMMENT ON CONSTRAINT salary ON accounting_for_tasks."position" IS 'положительная зарплата';


--
-- TOC entry 2740 (class 2606 OID 16409)
-- Name: staffing staffing_pkey; Type: CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE ONLY accounting_for_tasks.staffing
    ADD CONSTRAINT staffing_pkey PRIMARY KEY (id_staffing);


--
-- TOC entry 2732 (class 2606 OID 16539)
-- Name: employee_on_task status; Type: CHECK CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE accounting_for_tasks.employee_on_task
    ADD CONSTRAINT status CHECK (((status = 0) OR (status = 1))) NOT VALID;


--
-- TOC entry 2920 (class 0 OID 0)
-- Dependencies: 2732
-- Name: CONSTRAINT status ON employee_on_task; Type: COMMENT; Schema: accounting_for_tasks; Owner: postgres
--

COMMENT ON CONSTRAINT status ON accounting_for_tasks.employee_on_task IS 'статус равен 0 или 1';


--
-- TOC entry 2730 (class 2606 OID 16550)
-- Name: control status; Type: CHECK CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE accounting_for_tasks.control
    ADD CONSTRAINT status CHECK (((status >= 0) AND (status <= 100))) NOT VALID;


--
-- TOC entry 2921 (class 0 OID 0)
-- Dependencies: 2730
-- Name: CONSTRAINT status ON control; Type: COMMENT; Schema: accounting_for_tasks; Owner: postgres
--

COMMENT ON CONSTRAINT status ON accounting_for_tasks.control IS 'статус в процентах (максимум 100,  минимум 0)';


--
-- TOC entry 2756 (class 2606 OID 16493)
-- Name: task task_pkey; Type: CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE ONLY accounting_for_tasks.task
    ADD CONSTRAINT task_pkey PRIMARY KEY (id_task);


--
-- TOC entry 2745 (class 1259 OID 16482)
-- Name: fki_e; Type: INDEX; Schema: accounting_for_tasks; Owner: postgres
--

CREATE INDEX fki_e ON accounting_for_tasks.project USING btree (leader);


--
-- TOC entry 2762 (class 1259 OID 16524)
-- Name: fki_id_contract; Type: INDEX; Schema: accounting_for_tasks; Owner: postgres
--

CREATE INDEX fki_id_contract ON accounting_for_tasks.employee_on_task USING btree (id_contract);


--
-- TOC entry 2737 (class 1259 OID 16421)
-- Name: fki_id_department; Type: INDEX; Schema: accounting_for_tasks; Owner: postgres
--

CREATE INDEX fki_id_department ON accounting_for_tasks.staffing USING btree (id_department);


--
-- TOC entry 2752 (class 1259 OID 16476)
-- Name: fki_id_employee; Type: INDEX; Schema: accounting_for_tasks; Owner: postgres
--

CREATE INDEX fki_id_employee ON accounting_for_tasks.contract USING btree (id_employee);


--
-- TOC entry 2746 (class 1259 OID 16459)
-- Name: fki_id_organization; Type: INDEX; Schema: accounting_for_tasks; Owner: postgres
--

CREATE INDEX fki_id_organization ON accounting_for_tasks.project USING btree (id_organization);


--
-- TOC entry 2738 (class 1259 OID 16415)
-- Name: fki_id_position; Type: INDEX; Schema: accounting_for_tasks; Owner: postgres
--

CREATE INDEX fki_id_position ON accounting_for_tasks.staffing USING btree (id_position);


--
-- TOC entry 2754 (class 1259 OID 16499)
-- Name: fki_id_project; Type: INDEX; Schema: accounting_for_tasks; Owner: postgres
--

CREATE INDEX fki_id_project ON accounting_for_tasks.task USING btree (id_project);


--
-- TOC entry 2753 (class 1259 OID 16470)
-- Name: fki_id_staffing; Type: INDEX; Schema: accounting_for_tasks; Owner: postgres
--

CREATE INDEX fki_id_staffing ON accounting_for_tasks.contract USING btree (id_staffing);


--
-- TOC entry 2759 (class 1259 OID 16513)
-- Name: fki_id_task; Type: INDEX; Schema: accounting_for_tasks; Owner: postgres
--

CREATE INDEX fki_id_task ON accounting_for_tasks.control USING btree (id_task);


--
-- TOC entry 2747 (class 1259 OID 16488)
-- Name: fki_manager; Type: INDEX; Schema: accounting_for_tasks; Owner: postgres
--

CREATE INDEX fki_manager ON accounting_for_tasks.project USING btree (manager);


--
-- TOC entry 2772 (class 2606 OID 16519)
-- Name: employee_on_task id_contract; Type: FK CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE ONLY accounting_for_tasks.employee_on_task
    ADD CONSTRAINT id_contract FOREIGN KEY (id_contract) REFERENCES accounting_for_tasks.contract(id_contract) NOT VALID;


--
-- TOC entry 2764 (class 2606 OID 16416)
-- Name: staffing id_department; Type: FK CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE ONLY accounting_for_tasks.staffing
    ADD CONSTRAINT id_department FOREIGN KEY (id_department) REFERENCES accounting_for_tasks.department(id_departament) NOT VALID;


--
-- TOC entry 2769 (class 2606 OID 16471)
-- Name: contract id_employee; Type: FK CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE ONLY accounting_for_tasks.contract
    ADD CONSTRAINT id_employee FOREIGN KEY (id_employee) REFERENCES accounting_for_tasks.employee(id_employee) NOT VALID;


--
-- TOC entry 2765 (class 2606 OID 16454)
-- Name: project id_organization; Type: FK CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE ONLY accounting_for_tasks.project
    ADD CONSTRAINT id_organization FOREIGN KEY (id_organization) REFERENCES accounting_for_tasks.organization(id_organization) NOT VALID;


--
-- TOC entry 2763 (class 2606 OID 16410)
-- Name: staffing id_position; Type: FK CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE ONLY accounting_for_tasks.staffing
    ADD CONSTRAINT id_position FOREIGN KEY (id_position) REFERENCES accounting_for_tasks."position"(id_position) NOT VALID;


--
-- TOC entry 2770 (class 2606 OID 16494)
-- Name: task id_project; Type: FK CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE ONLY accounting_for_tasks.task
    ADD CONSTRAINT id_project FOREIGN KEY (id_project) REFERENCES accounting_for_tasks.project(id_project) NOT VALID;


--
-- TOC entry 2768 (class 2606 OID 16465)
-- Name: contract id_staffing; Type: FK CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE ONLY accounting_for_tasks.contract
    ADD CONSTRAINT id_staffing FOREIGN KEY (id_staffing) REFERENCES accounting_for_tasks.staffing(id_staffing) NOT VALID;


--
-- TOC entry 2771 (class 2606 OID 16508)
-- Name: control id_task; Type: FK CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE ONLY accounting_for_tasks.control
    ADD CONSTRAINT id_task FOREIGN KEY (id_task) REFERENCES accounting_for_tasks.task(id_task) NOT VALID;


--
-- TOC entry 2773 (class 2606 OID 16525)
-- Name: employee_on_task id_task; Type: FK CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE ONLY accounting_for_tasks.employee_on_task
    ADD CONSTRAINT id_task FOREIGN KEY (id_task) REFERENCES accounting_for_tasks.task(id_task) NOT VALID;


--
-- TOC entry 2766 (class 2606 OID 16477)
-- Name: project leader; Type: FK CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE ONLY accounting_for_tasks.project
    ADD CONSTRAINT leader FOREIGN KEY (leader) REFERENCES accounting_for_tasks.contract(id_contract) NOT VALID;


--
-- TOC entry 2767 (class 2606 OID 16483)
-- Name: project manager; Type: FK CONSTRAINT; Schema: accounting_for_tasks; Owner: postgres
--

ALTER TABLE ONLY accounting_for_tasks.project
    ADD CONSTRAINT manager FOREIGN KEY (manager) REFERENCES accounting_for_tasks.contract(id_contract) NOT VALID;


-- Completed on 2023-03-20 10:30:16

--
-- PostgreSQL database dump complete
--

