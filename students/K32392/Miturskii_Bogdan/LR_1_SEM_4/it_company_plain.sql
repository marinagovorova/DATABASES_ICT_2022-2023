--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-05-18 12:36:57 MSK

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
-- TOC entry 6 (class 2615 OID 16446)
-- Name: main; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA main;


ALTER SCHEMA main OWNER TO postgres;

--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16447)
-- Name: customer; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.customer (
    id integer NOT NULL,
    organization_name character varying(80) NOT NULL,
    organization_address character varying(80) NOT NULL,
    contacts character varying(12) NOT NULL,
    full_name character varying(70) NOT NULL
);


ALTER TABLE main.customer OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16450)
-- Name: customer_id_seq; Type: SEQUENCE; Schema: main; Owner: postgres
--

ALTER TABLE main.customer ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME main.customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 217 (class 1259 OID 16451)
-- Name: department; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.department (
    id integer NOT NULL,
    department_title text NOT NULL,
    telephone character varying(20) NOT NULL
);


ALTER TABLE main.department OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16454)
-- Name: department_id_seq; Type: SEQUENCE; Schema: main; Owner: postgres
--

ALTER TABLE main.department ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME main.department_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 219 (class 1259 OID 16455)
-- Name: employee; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.employee (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE main.employee OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16458)
-- Name: employee_id_seq; Type: SEQUENCE; Schema: main; Owner: postgres
--

ALTER TABLE main.employee ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME main.employee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 221 (class 1259 OID 16459)
-- Name: employee_position; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.employee_position (
    id integer NOT NULL,
    job_title text NOT NULL,
    salary money NOT NULL,
    category character varying(255) NOT NULL
);


ALTER TABLE main.employee_position OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16462)
-- Name: employee_position_id_seq; Type: SEQUENCE; Schema: main; Owner: postgres
--

ALTER TABLE main.employee_position ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME main.employee_position_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 223 (class 1259 OID 16469)
-- Name: implementation; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.implementation (
    id integer NOT NULL,
    id_task integer NOT NULL,
    id_employee integer NOT NULL,
    execution_status character varying(124) NOT NULL,
    due_date_from date NOT NULL,
    due_date_to date NOT NULL,
    reward money NOT NULL
);


ALTER TABLE main.implementation OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16472)
-- Name: implementation_id_seq; Type: SEQUENCE; Schema: main; Owner: postgres
--

ALTER TABLE main.implementation ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME main.implementation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 225 (class 1259 OID 16473)
-- Name: project; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.project (
    id integer NOT NULL,
    id_customer integer NOT NULL,
    id_manager integer NOT NULL,
    id_supervisor integer NOT NULL,
    title character varying(255) NOT NULL,
    due_date_from date NOT NULL,
    due_date_to date NOT NULL,
    execution_status character varying(124) NOT NULL,
    payment_state character varying(124) NOT NULL,
    price money NOT NULL,
    contracts_employees text[],
    contract_customer text
);


ALTER TABLE main.project OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16476)
-- Name: project_id_seq; Type: SEQUENCE; Schema: main; Owner: postgres
--

ALTER TABLE main.project ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME main.project_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 227 (class 1259 OID 16477)
-- Name: staffing_table; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.staffing_table (
    id integer NOT NULL,
    id_employee_position integer NOT NULL,
    id_employee integer NOT NULL,
    id_department integer NOT NULL,
    number_of_positions integer NOT NULL
);


ALTER TABLE main.staffing_table OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16480)
-- Name: staff_member_id_seq; Type: SEQUENCE; Schema: main; Owner: postgres
--

ALTER TABLE main.staffing_table ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME main.staff_member_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 229 (class 1259 OID 16481)
-- Name: task; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.task (
    id integer NOT NULL,
    id_project integer NOT NULL,
    comment text NOT NULL,
    price numeric(12,2) NOT NULL,
    due_date_from date NOT NULL,
    due_date_to date NOT NULL,
    execution_status character varying(30) NOT NULL,
    id_inspector integer NOT NULL,
    execution_schedule text,
    execution_control text
);


ALTER TABLE main.task OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16486)
-- Name: task_id_seq; Type: SEQUENCE; Schema: main; Owner: postgres
--

ALTER TABLE main.task ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME main.task_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3668 (class 0 OID 16447)
-- Dependencies: 215
-- Data for Name: customer; Type: TABLE DATA; Schema: main; Owner: postgres
--

INSERT INTO main.customer OVERRIDING SYSTEM VALUE VALUES (1, 'ABC Company', '123 Main Street, City A', '+12345678901', 'John Smith');
INSERT INTO main.customer OVERRIDING SYSTEM VALUE VALUES (2, 'XYZ Corporation', '456 Elm Street, City B', '+23456789012', 'Jane Doe');
INSERT INTO main.customer OVERRIDING SYSTEM VALUE VALUES (3, '123 Industries', '789 Oak Avenue, City C', '+34567890123', 'Michael Johnson');
INSERT INTO main.customer OVERRIDING SYSTEM VALUE VALUES (4, 'Acme Corporation', '321 Pine Road, City D', '+45678901234', 'Emily Davis');
INSERT INTO main.customer OVERRIDING SYSTEM VALUE VALUES (5, 'Global Enterprises', '654 Maple Lane, City E', '+56789012345', 'Daniel Wilson');
INSERT INTO main.customer OVERRIDING SYSTEM VALUE VALUES (6, 'Sunshine Company', '987 Cedar Court, City F', '+67890123456', 'Olivia Brown');
INSERT INTO main.customer OVERRIDING SYSTEM VALUE VALUES (7, 'Tech Solutions', '246 Birch Street, City G', '+78901234567', 'Matthew Taylor');
INSERT INTO main.customer OVERRIDING SYSTEM VALUE VALUES (8, 'Innovative Innovations', '579 Spruce Avenue, City H', '+89012345678', 'Sophia Martinez');
INSERT INTO main.customer OVERRIDING SYSTEM VALUE VALUES (9, 'Globe Corporation', '802 Walnut Road, City I', '+90123456789', 'William Anderson');
INSERT INTO main.customer OVERRIDING SYSTEM VALUE VALUES (10, 'Best Products', '135 Cherry Lane, City J', '+01234567890', 'Isabella Thomas');
INSERT INTO main.customer OVERRIDING SYSTEM VALUE VALUES (11, 'Quick Services', '468 Pine Street, City K', '+11111111111', 'Joseph Garcia');
INSERT INTO main.customer OVERRIDING SYSTEM VALUE VALUES (12, 'Star Enterprises', '791 Oak Road, City L', '+22222222222', 'Emma Rodriguez');
INSERT INTO main.customer OVERRIDING SYSTEM VALUE VALUES (13, 'First Class Company', '124 Cedar Avenue, City M', '+33333333333', 'David Lopez');
INSERT INTO main.customer OVERRIDING SYSTEM VALUE VALUES (14, 'Dynamic Solutions', '457 Birch Lane, City N', '+44444444444', 'Mia Lee');
INSERT INTO main.customer OVERRIDING SYSTEM VALUE VALUES (15, 'Innovative Technologies', '780 Maple Road, City O', '+55555555555', 'Andrew Hernandez');
INSERT INTO main.customer OVERRIDING SYSTEM VALUE VALUES (16, 'Golden Corporation', '013 Elm Street, City P', '+66666666666', 'Abigail Clark');
INSERT INTO main.customer OVERRIDING SYSTEM VALUE VALUES (17, 'Prime Industries', '346 Spruce Lane, City Q', '+77777777777', 'James Lewis');
INSERT INTO main.customer OVERRIDING SYSTEM VALUE VALUES (18, 'Progressive Company', '579 Oak Court, City R', '+88888888888', 'Charlotte Walker');
INSERT INTO main.customer OVERRIDING SYSTEM VALUE VALUES (19, 'Master Solutions', '802 Cedar Road, City S', '+99999999999', 'Joshua Hall');
INSERT INTO main.customer OVERRIDING SYSTEM VALUE VALUES (20, 'Elite Services', '135 Pine Avenue, City T', '+00000000000', 'Sofia Green');


--
-- TOC entry 3670 (class 0 OID 16451)
-- Dependencies: 217
-- Data for Name: department; Type: TABLE DATA; Schema: main; Owner: postgres
--

INSERT INTO main.department OVERRIDING SYSTEM VALUE VALUES (1, 'Sales Department', '+12345678901');
INSERT INTO main.department OVERRIDING SYSTEM VALUE VALUES (2, 'Engineering Department', '+23456789012');
INSERT INTO main.department OVERRIDING SYSTEM VALUE VALUES (3, 'Human Resources Department', '+34567890123');
INSERT INTO main.department OVERRIDING SYSTEM VALUE VALUES (4, 'Finance Department', '+45678901234');


--
-- TOC entry 3672 (class 0 OID 16455)
-- Dependencies: 219
-- Data for Name: employee; Type: TABLE DATA; Schema: main; Owner: postgres
--

INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (1, 'John Doe');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (2, 'Jane Smith');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (3, 'Michael Johnson');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (4, 'Emily Davis');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (5, 'Daniel Wilson');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (6, 'Olivia Brown');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (7, 'Matthew Taylor');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (8, 'Sophia Martinez');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (9, 'William Anderson');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (10, 'Isabella Thomas');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (11, 'Joseph Garcia');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (12, 'Emma Rodriguez');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (13, 'David Lopez');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (14, 'Mia Lee');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (15, 'Andrew Hernandez');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (16, 'Abigail Clark');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (17, 'James Lewis');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (18, 'Charlotte Walker');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (19, 'Joshua Hall');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (20, 'Sofia Green');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (21, 'Christopher Young');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (22, 'Ava Martinez');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (23, 'Benjamin Thompson');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (24, 'Harper White');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (25, 'Logan King');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (26, 'Ella Scott');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (27, 'Samuel Adams');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (28, 'Grace Carter');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (29, 'Ryan Hill');
INSERT INTO main.employee OVERRIDING SYSTEM VALUE VALUES (30, 'Chloe Wright');


--
-- TOC entry 3674 (class 0 OID 16459)
-- Dependencies: 221
-- Data for Name: employee_position; Type: TABLE DATA; Schema: main; Owner: postgres
--

INSERT INTO main.employee_position OVERRIDING SYSTEM VALUE VALUES (1, 'Manager', '$60,000.00', 'Management');
INSERT INTO main.employee_position OVERRIDING SYSTEM VALUE VALUES (2, 'Software Engineer', '$50,000.00', 'Technical');
INSERT INTO main.employee_position OVERRIDING SYSTEM VALUE VALUES (3, 'Sales Representative', '$40,000.00', 'Sales');
INSERT INTO main.employee_position OVERRIDING SYSTEM VALUE VALUES (4, 'Human Resources Specialist', '$45,000.00', 'Human Resources');
INSERT INTO main.employee_position OVERRIDING SYSTEM VALUE VALUES (5, 'Accountant', '$55,000.00', 'Finance');
INSERT INTO main.employee_position OVERRIDING SYSTEM VALUE VALUES (6, 'Marketing Coordinator', '$40,000.00', 'Marketing');


--
-- TOC entry 3676 (class 0 OID 16469)
-- Dependencies: 223
-- Data for Name: implementation; Type: TABLE DATA; Schema: main; Owner: postgres
--

INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (11, 1, 10, 'Not started', '2023-05-18', '2023-05-25', '$482.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (12, 2, 13, 'Cancelled', '2023-05-18', '2023-05-25', '$701.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (13, 3, 28, 'Cancelled', '2023-05-18', '2023-06-14', '$560.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (14, 4, 30, 'Completed with errors', '2023-05-18', '2023-05-24', '$36.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (15, 5, 2, 'Cancelled', '2023-05-18', '2023-06-17', '$627.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (16, 6, 30, 'Cancelled', '2023-05-18', '2023-06-09', '$14.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (17, 7, 17, 'In progress', '2023-05-18', '2023-06-10', '$676.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (18, 8, 13, 'Cancelled', '2023-05-18', '2023-05-23', '$169.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (19, 9, 13, 'In progress', '2023-05-18', '2023-06-09', '$816.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (20, 10, 15, 'Not started', '2023-05-18', '2023-06-03', '$761.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (21, 11, 8, 'Cancelled', '2023-05-18', '2023-05-20', '$905.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (22, 12, 6, 'Completed successfully', '2023-05-18', '2023-06-04', '$834.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (23, 13, 28, 'In progress', '2023-05-18', '2023-05-21', '$878.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (24, 14, 13, 'Not started', '2023-05-18', '2023-06-09', '$462.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (25, 15, 28, 'Completed successfully', '2023-05-18', '2023-06-08', '$534.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (26, 16, 17, 'Not started', '2023-05-18', '2023-06-11', '$398.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (27, 17, 13, 'Completed successfully', '2023-05-18', '2023-05-23', '$795.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (28, 18, 30, 'Not started', '2023-05-18', '2023-05-22', '$489.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (29, 19, 23, 'Completed with errors', '2023-05-18', '2023-06-07', '$645.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (30, 20, 16, 'Completed with errors', '2023-05-18', '2023-05-21', '$959.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (31, 21, 7, 'Cancelled', '2023-05-18', '2023-05-23', '$831.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (32, 22, 24, 'Cancelled', '2023-05-18', '2023-05-24', '$848.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (33, 23, 23, 'In progress', '2023-05-18', '2023-06-09', '$312.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (34, 24, 7, 'Not started', '2023-05-18', '2023-06-05', '$824.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (35, 25, 7, 'Cancelled', '2023-05-18', '2023-05-23', '$188.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (36, 26, 16, 'Completed successfully', '2023-05-18', '2023-05-20', '$691.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (37, 27, 21, 'In progress', '2023-05-18', '2023-05-30', '$692.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (38, 28, 11, 'Completed with errors', '2023-05-18', '2023-05-31', '$140.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (39, 29, 26, 'Not started', '2023-05-18', '2023-05-29', '$227.00');
INSERT INTO main.implementation OVERRIDING SYSTEM VALUE VALUES (40, 30, 28, 'Not started', '2023-05-18', '2023-05-30', '$845.00');


--
-- TOC entry 3678 (class 0 OID 16473)
-- Dependencies: 225
-- Data for Name: project; Type: TABLE DATA; Schema: main; Owner: postgres
--

INSERT INTO main.project OVERRIDING SYSTEM VALUE VALUES (1, 7, 18, 28, 'Project A', '2023-05-20', '2023-06-20', 'In progress', 'In progress', '$5,000.00', '{"Contract A","Contract B"}', 'Customer Contract A');
INSERT INTO main.project OVERRIDING SYSTEM VALUE VALUES (2, 13, 23, 9, 'Project B', '2023-06-01', '2023-07-01', 'Completed successfully', 'Received', '$8,000.00', '{"Contract C"}', 'Customer Contract B');
INSERT INTO main.project OVERRIDING SYSTEM VALUE VALUES (3, 19, 7, 21, 'Project C', '2023-07-10', '2023-08-10', 'Completed with errors', 'Not sent', '$6,000.00', '{"Contract D"}', 'Customer Contract C');
INSERT INTO main.project OVERRIDING SYSTEM VALUE VALUES (4, 9, 6, 4, 'Project D', '2023-06-15', '2023-07-15', 'Cancelled', 'Received', '$7,000.00', '{"Contract E"}', 'Customer Contract D');
INSERT INTO main.project OVERRIDING SYSTEM VALUE VALUES (5, 14, 12, 20, 'Project E', '2023-07-05', '2023-08-05', 'Not started', 'In progress', '$5,500.00', '{"Contract F"}', 'Customer Contract E');
INSERT INTO main.project OVERRIDING SYSTEM VALUE VALUES (6, 18, 20, 9, 'Project F', '2023-06-25', '2023-07-25', 'In progress', 'Not sent', '$4,500.00', '{"Contract G"}', 'Customer Contract F');
INSERT INTO main.project OVERRIDING SYSTEM VALUE VALUES (7, 3, 3, 13, 'Project G', '2023-06-12', '2023-07-12', 'Completed successfully', 'Received', '$9,000.00', '{"Contract H"}', 'Customer Contract G');
INSERT INTO main.project OVERRIDING SYSTEM VALUE VALUES (8, 19, 19, 15, 'Project H', '2023-07-08', '2023-08-08', 'In progress', 'Not sent', '$7,500.00', '{"Contract I"}', 'Customer Contract H');
INSERT INTO main.project OVERRIDING SYSTEM VALUE VALUES (9, 1, 23, 24, 'Project I', '2023-07-15', '2023-08-15', 'Not started', 'In progress', '$6,000.00', '{"Contract J"}', 'Customer Contract I');
INSERT INTO main.project OVERRIDING SYSTEM VALUE VALUES (10, 3, 28, 24, 'Project J', '2023-06-18', '2023-07-18', 'In progress', 'Received', '$6,500.00', '{"Contract K"}', 'Customer Contract J');


--
-- TOC entry 3680 (class 0 OID 16477)
-- Dependencies: 227
-- Data for Name: staffing_table; Type: TABLE DATA; Schema: main; Owner: postgres
--

INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (1, 1, 1, 1, 2);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (2, 2, 2, 2, 1);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (3, 3, 3, 3, 1);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (4, 4, 4, 4, 1);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (5, 5, 5, 1, 2);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (6, 6, 6, 2, 1);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (7, 1, 7, 3, 1);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (8, 2, 8, 4, 1);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (9, 3, 9, 1, 2);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (10, 4, 10, 2, 1);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (11, 5, 11, 3, 1);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (12, 6, 12, 4, 1);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (13, 1, 13, 1, 2);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (14, 2, 14, 2, 1);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (15, 3, 15, 3, 1);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (16, 4, 16, 4, 1);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (17, 5, 17, 1, 2);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (18, 6, 18, 2, 1);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (19, 1, 19, 3, 1);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (20, 2, 20, 4, 1);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (21, 3, 21, 1, 2);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (22, 4, 22, 2, 1);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (23, 5, 23, 3, 1);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (24, 6, 24, 4, 1);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (25, 1, 25, 1, 2);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (26, 2, 26, 2, 1);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (27, 3, 27, 3, 1);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (28, 4, 28, 4, 1);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (29, 5, 29, 1, 2);
INSERT INTO main.staffing_table OVERRIDING SYSTEM VALUE VALUES (30, 6, 30, 2, 1);


--
-- TOC entry 3682 (class 0 OID 16481)
-- Dependencies: 229
-- Data for Name: task; Type: TABLE DATA; Schema: main; Owner: postgres
--

INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (1, 8, 'Comment A', 1000.00, '2023-05-20', '2023-05-25', 'In progress', 9, 'Schedule A', 'Control A');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (2, 3, 'Comment B', 1500.00, '2023-05-21', '2023-05-26', 'Completed successfully', 24, 'Schedule B', 'Control B');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (3, 9, 'Comment C', 1200.00, '2023-05-22', '2023-05-27', 'Completed with errors', 8, 'Schedule C', 'Control C');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (4, 3, 'Comment D', 800.00, '2023-05-23', '2023-05-28', 'Cancelled', 18, 'Schedule D', 'Control D');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (5, 10, 'Comment E', 1100.00, '2023-05-24', '2023-05-29', 'Not started', 12, 'Schedule E', 'Control E');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (6, 6, 'Comment F', 1300.00, '2023-05-25', '2023-05-30', 'In progress', 22, 'Schedule F', 'Control F');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (7, 1, 'Comment G', 900.00, '2023-05-26', '2023-05-31', 'Completed successfully', 10, 'Schedule G', 'Control G');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (8, 2, 'Comment H', 1400.00, '2023-05-27', '2023-06-01', 'In progress', 5, 'Schedule H', 'Control H');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (9, 7, 'Comment I', 1000.00, '2023-05-28', '2023-06-02', 'Not started', 29, 'Schedule I', 'Control I');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (10, 4, 'Comment J', 1200.00, '2023-05-29', '2023-06-03', 'Completed successfully', 10, 'Schedule J', 'Control J');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (11, 7, 'Comment K', 800.00, '2023-05-30', '2023-06-04', 'Cancelled', 22, 'Schedule K', 'Control K');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (12, 4, 'Comment L', 1100.00, '2023-05-31', '2023-06-05', 'In progress', 26, 'Schedule L', 'Control L');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (13, 1, 'Comment M', 1300.00, '2023-06-01', '2023-06-06', 'Not started', 29, 'Schedule M', 'Control M');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (14, 5, 'Comment N', 900.00, '2023-06-02', '2023-06-07', 'Completed successfully', 30, 'Schedule N', 'Control N');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (15, 5, 'Comment O', 1400.00, '2023-06-03', '2023-06-08', 'In progress', 11, 'Schedule O', 'Control O');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (16, 7, 'Comment P', 1000.00, '2023-06-04', '2023-06-09', 'Not started', 12, 'Schedule P', 'Control P');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (17, 2, 'Comment Q', 1200.00, '2023-06-05', '2023-06-10', 'Completed successfully', 28, 'Schedule Q', 'Control Q');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (18, 10, 'Comment R', 800.00, '2023-06-06', '2023-06-11', 'Cancelled', 8, 'Schedule R', 'Control R');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (19, 7, 'Comment S', 1100.00, '2023-06-07', '2023-06-12', 'In progress', 5, 'Schedule S', 'Control S');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (20, 5, 'Comment T', 1300.00, '2023-06-08', '2023-06-13', 'Not started', 14, 'Schedule T', 'Control T');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (21, 8, 'Comment U', 900.00, '2023-06-09', '2023-06-14', 'Completed successfully', 1, 'Schedule U', 'Control U');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (22, 7, 'Comment V', 1400.00, '2023-06-10', '2023-06-15', 'In progress', 4, 'Schedule V', 'Control V');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (23, 7, 'Comment W', 1000.00, '2023-06-11', '2023-06-16', 'Not started', 10, 'Schedule W', 'Control W');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (24, 7, 'Comment X', 1200.00, '2023-06-12', '2023-06-17', 'Completed successfully', 19, 'Schedule X', 'Control X');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (25, 4, 'Comment Y', 800.00, '2023-06-13', '2023-06-18', 'Cancelled', 9, 'Schedule Y', 'Control Y');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (26, 7, 'Comment Z', 1100.00, '2023-06-14', '2023-06-19', 'In progress', 10, 'Schedule Z', 'Control Z');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (27, 3, 'Comment AA', 1300.00, '2023-06-15', '2023-06-20', 'Not started', 21, 'Schedule AA', 'Control AA');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (28, 1, 'Comment BB', 900.00, '2023-06-16', '2023-06-21', 'Completed successfully', 29, 'Schedule BB', 'Control BB');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (29, 8, 'Comment CC', 1400.00, '2023-06-17', '2023-06-22', 'In progress', 15, 'Schedule CC', 'Control CC');
INSERT INTO main.task OVERRIDING SYSTEM VALUE VALUES (30, 9, 'Comment DD', 1000.00, '2023-06-18', '2023-06-23', 'Not started', 27, 'Schedule DD', 'Control DD');


--
-- TOC entry 3690 (class 0 OID 0)
-- Dependencies: 216
-- Name: customer_id_seq; Type: SEQUENCE SET; Schema: main; Owner: postgres
--

SELECT pg_catalog.setval('main.customer_id_seq', 12, true);


--
-- TOC entry 3691 (class 0 OID 0)
-- Dependencies: 218
-- Name: department_id_seq; Type: SEQUENCE SET; Schema: main; Owner: postgres
--

SELECT pg_catalog.setval('main.department_id_seq', 10, true);


--
-- TOC entry 3692 (class 0 OID 0)
-- Dependencies: 220
-- Name: employee_id_seq; Type: SEQUENCE SET; Schema: main; Owner: postgres
--

SELECT pg_catalog.setval('main.employee_id_seq', 9, true);


--
-- TOC entry 3693 (class 0 OID 0)
-- Dependencies: 222
-- Name: employee_position_id_seq; Type: SEQUENCE SET; Schema: main; Owner: postgres
--

SELECT pg_catalog.setval('main.employee_position_id_seq', 10, true);


--
-- TOC entry 3694 (class 0 OID 0)
-- Dependencies: 224
-- Name: implementation_id_seq; Type: SEQUENCE SET; Schema: main; Owner: postgres
--

SELECT pg_catalog.setval('main.implementation_id_seq', 40, true);


--
-- TOC entry 3695 (class 0 OID 0)
-- Dependencies: 226
-- Name: project_id_seq; Type: SEQUENCE SET; Schema: main; Owner: postgres
--

SELECT pg_catalog.setval('main.project_id_seq', 9, true);


--
-- TOC entry 3696 (class 0 OID 0)
-- Dependencies: 228
-- Name: staff_member_id_seq; Type: SEQUENCE SET; Schema: main; Owner: postgres
--

SELECT pg_catalog.setval('main.staff_member_id_seq', 10, true);


--
-- TOC entry 3697 (class 0 OID 0)
-- Dependencies: 230
-- Name: task_id_seq; Type: SEQUENCE SET; Schema: main; Owner: postgres
--

SELECT pg_catalog.setval('main.task_id_seq', 10, true);


--
-- TOC entry 3476 (class 2606 OID 16623)
-- Name: department correct_telephone; Type: CHECK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE main.department
    ADD CONSTRAINT correct_telephone CHECK (((telephone)::text ~~ like_escape('+___________'::text, ''::text))) NOT VALID;


--
-- TOC entry 3490 (class 2606 OID 16494)
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (id);


--
-- TOC entry 3486 (class 2606 OID 16487)
-- Name: task date_check; Type: CHECK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE main.task
    ADD CONSTRAINT date_check CHECK ((due_date_from <= due_date_to)) NOT VALID;


--
-- TOC entry 3481 (class 2606 OID 16488)
-- Name: project date_check; Type: CHECK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE main.project
    ADD CONSTRAINT date_check CHECK ((due_date_from <= due_date_to)) NOT VALID;


--
-- TOC entry 3478 (class 2606 OID 16495)
-- Name: implementation date_check; Type: CHECK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE main.implementation
    ADD CONSTRAINT date_check CHECK ((due_date_from <= due_date_to)) NOT VALID;


--
-- TOC entry 3492 (class 2606 OID 16497)
-- Name: department department_pkey; Type: CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (id);


--
-- TOC entry 3494 (class 2606 OID 16499)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (id);


--
-- TOC entry 3496 (class 2606 OID 16501)
-- Name: employee_position employee_position_pkey; Type: CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.employee_position
    ADD CONSTRAINT employee_position_pkey PRIMARY KEY (id);


--
-- TOC entry 3482 (class 2606 OID 16625)
-- Name: project execution_status_check; Type: CHECK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE main.project
    ADD CONSTRAINT execution_status_check CHECK ((((execution_status)::character varying)::text = ANY ((ARRAY['In progress'::character varying, 'Completed successfully'::character varying, 'Completed with errors'::character varying, 'Cancelled'::character varying, 'Not started'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 3479 (class 2606 OID 16627)
-- Name: implementation execution_status_check; Type: CHECK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE main.implementation
    ADD CONSTRAINT execution_status_check CHECK ((((execution_status)::character varying)::text = ANY ((ARRAY['In progress'::character varying, 'Completed successfully'::character varying, 'Completed with errors'::character varying, 'Cancelled'::character varying, 'Not started'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 3487 (class 2606 OID 16630)
-- Name: task execution_status_check; Type: CHECK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE main.task
    ADD CONSTRAINT execution_status_check CHECK ((((execution_status)::character varying)::text = ANY (ARRAY[('In progress'::character varying)::text, ('Completed successfully'::character varying)::text, ('Completed with errors'::character varying)::text, ('Cancelled'::character varying)::text, ('Not started'::character varying)::text]))) NOT VALID;


--
-- TOC entry 3498 (class 2606 OID 16508)
-- Name: implementation implementation_pkey; Type: CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.implementation
    ADD CONSTRAINT implementation_pkey PRIMARY KEY (id);


--
-- TOC entry 3485 (class 2606 OID 16628)
-- Name: staffing_table only_positive_number_of_positions; Type: CHECK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE main.staffing_table
    ADD CONSTRAINT only_positive_number_of_positions CHECK (((number_of_positions)::numeric >= (0)::numeric)) NOT VALID;


--
-- TOC entry 3488 (class 2606 OID 16489)
-- Name: task only_positive_price; Type: CHECK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE main.task
    ADD CONSTRAINT only_positive_price CHECK (((price)::numeric >= (0)::numeric)) NOT VALID;


--
-- TOC entry 3483 (class 2606 OID 16511)
-- Name: project only_positive_price; Type: CHECK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE main.project
    ADD CONSTRAINT only_positive_price CHECK (((price)::numeric >= (0)::numeric)) NOT VALID;


--
-- TOC entry 3480 (class 2606 OID 16514)
-- Name: implementation only_positive_reward; Type: CHECK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE main.implementation
    ADD CONSTRAINT only_positive_reward CHECK (((reward)::numeric >= (0)::numeric)) NOT VALID;


--
-- TOC entry 3477 (class 2606 OID 16510)
-- Name: employee_position only_positive_salary; Type: CHECK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE main.employee_position
    ADD CONSTRAINT only_positive_salary CHECK (((salary)::numeric >= (0)::numeric)) NOT VALID;


--
-- TOC entry 3484 (class 2606 OID 16626)
-- Name: project payment_state; Type: CHECK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE main.project
    ADD CONSTRAINT payment_state CHECK ((((payment_state)::character varying)::text = ANY ((ARRAY['In progress'::character varying, 'Received'::character varying, 'Not sent'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 3504 (class 2606 OID 16513)
-- Name: project project_pkey; Type: CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.project
    ADD CONSTRAINT project_pkey PRIMARY KEY (id);


--
-- TOC entry 3512 (class 2606 OID 16516)
-- Name: staffing_table staff_member_pkey; Type: CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.staffing_table
    ADD CONSTRAINT staff_member_pkey PRIMARY KEY (id);


--
-- TOC entry 3515 (class 2606 OID 16518)
-- Name: task task_pkey; Type: CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.task
    ADD CONSTRAINT task_pkey PRIMARY KEY (id);


--
-- TOC entry 3475 (class 2606 OID 16519)
-- Name: customer telephone_check; Type: CHECK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE main.customer
    ADD CONSTRAINT telephone_check CHECK (((contacts)::text ~~ like_escape('+___________'::text, ''::text))) NOT VALID;


--
-- TOC entry 3499 (class 1259 OID 16521)
-- Name: fki_customer_fk; Type: INDEX; Schema: main; Owner: postgres
--

CREATE INDEX fki_customer_fk ON main.project USING btree (id_customer);


--
-- TOC entry 3505 (class 1259 OID 16522)
-- Name: fki_department_fk; Type: INDEX; Schema: main; Owner: postgres
--

CREATE INDEX fki_department_fk ON main.staffing_table USING btree (id_department);


--
-- TOC entry 3506 (class 1259 OID 16523)
-- Name: fki_employee_fk; Type: INDEX; Schema: main; Owner: postgres
--

CREATE INDEX fki_employee_fk ON main.staffing_table USING btree (id_employee);


--
-- TOC entry 3507 (class 1259 OID 16524)
-- Name: fki_employee_position_fk; Type: INDEX; Schema: main; Owner: postgres
--

CREATE INDEX fki_employee_position_fk ON main.staffing_table USING btree (id_employee_position);


--
-- TOC entry 3508 (class 1259 OID 16525)
-- Name: fki_id_department_fk; Type: INDEX; Schema: main; Owner: postgres
--

CREATE INDEX fki_id_department_fk ON main.staffing_table USING btree (id_department);


--
-- TOC entry 3509 (class 1259 OID 16526)
-- Name: fki_id_emplyee_fk; Type: INDEX; Schema: main; Owner: postgres
--

CREATE INDEX fki_id_emplyee_fk ON main.staffing_table USING btree (id_employee);


--
-- TOC entry 3510 (class 1259 OID 16527)
-- Name: fki_id_job_title_fk; Type: INDEX; Schema: main; Owner: postgres
--

CREATE INDEX fki_id_job_title_fk ON main.staffing_table USING btree (id_employee_position);


--
-- TOC entry 3500 (class 1259 OID 16528)
-- Name: fki_id_manager_fk; Type: INDEX; Schema: main; Owner: postgres
--

CREATE INDEX fki_id_manager_fk ON main.project USING btree (id_manager);


--
-- TOC entry 3513 (class 1259 OID 16529)
-- Name: fki_id_project_fk; Type: INDEX; Schema: main; Owner: postgres
--

CREATE INDEX fki_id_project_fk ON main.task USING btree (id_project);


--
-- TOC entry 3501 (class 1259 OID 16530)
-- Name: fki_id_supervisor_fk; Type: INDEX; Schema: main; Owner: postgres
--

CREATE INDEX fki_id_supervisor_fk ON main.project USING btree (id_supervisor);


--
-- TOC entry 3502 (class 1259 OID 16532)
-- Name: fki_n; Type: INDEX; Schema: main; Owner: postgres
--

CREATE INDEX fki_n ON main.project USING btree (id_manager);


--
-- TOC entry 3518 (class 2606 OID 16534)
-- Name: project id_customer_fk; Type: FK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.project
    ADD CONSTRAINT id_customer_fk FOREIGN KEY (id_customer) REFERENCES main.customer(id) NOT VALID;


--
-- TOC entry 3521 (class 2606 OID 16539)
-- Name: staffing_table id_department_fk; Type: FK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.staffing_table
    ADD CONSTRAINT id_department_fk FOREIGN KEY (id_department) REFERENCES main.department(id) NOT VALID;


--
-- TOC entry 3522 (class 2606 OID 16544)
-- Name: staffing_table id_employee_fk; Type: FK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.staffing_table
    ADD CONSTRAINT id_employee_fk FOREIGN KEY (id_employee) REFERENCES main.employee(id) NOT VALID;


--
-- TOC entry 3516 (class 2606 OID 16618)
-- Name: implementation id_employee_fk; Type: FK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.implementation
    ADD CONSTRAINT id_employee_fk FOREIGN KEY (id_employee) REFERENCES main.employee(id) NOT VALID;


--
-- TOC entry 3523 (class 2606 OID 16554)
-- Name: staffing_table id_employee_position_fk; Type: FK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.staffing_table
    ADD CONSTRAINT id_employee_position_fk FOREIGN KEY (id_employee_position) REFERENCES main.employee_position(id) NOT VALID;


--
-- TOC entry 3524 (class 2606 OID 16603)
-- Name: task id_inspector_fk; Type: FK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.task
    ADD CONSTRAINT id_inspector_fk FOREIGN KEY (id_inspector) REFERENCES main.employee(id) NOT VALID;


--
-- TOC entry 3519 (class 2606 OID 16608)
-- Name: project id_manager_fk; Type: FK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.project
    ADD CONSTRAINT id_manager_fk FOREIGN KEY (id_manager) REFERENCES main.employee(id) NOT VALID;


--
-- TOC entry 3525 (class 2606 OID 16564)
-- Name: task id_project_fk; Type: FK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.task
    ADD CONSTRAINT id_project_fk FOREIGN KEY (id_project) REFERENCES main.project(id) NOT VALID;


--
-- TOC entry 3520 (class 2606 OID 16613)
-- Name: project id_supervisor_fk; Type: FK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.project
    ADD CONSTRAINT id_supervisor_fk FOREIGN KEY (id_supervisor) REFERENCES main.employee(id) NOT VALID;


--
-- TOC entry 3517 (class 2606 OID 16584)
-- Name: implementation id_task_fk; Type: FK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.implementation
    ADD CONSTRAINT id_task_fk FOREIGN KEY (id_task) REFERENCES main.task(id) NOT VALID;


--
-- TOC entry 3689 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2023-05-18 12:36:57 MSK

--
-- PostgreSQL database dump complete
--

