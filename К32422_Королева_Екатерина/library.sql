--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

-- Started on 2023-05-29 15:44:35

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
-- TOC entry 6 (class 2615 OID 17564)
-- Name: library; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA library;


SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 17565)
-- Name: affiliate; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.affiliate (
    affiliate_id integer NOT NULL,
    affiliate_name character varying(35) NOT NULL,
    address character varying(35) NOT NULL,
    level character varying(20) NOT NULL
);


--
-- TOC entry 216 (class 1259 OID 17568)
-- Name: affiliate_affiliate_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.affiliate_affiliate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3523 (class 0 OID 0)
-- Dependencies: 216
-- Name: affiliate_affiliate_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.affiliate_affiliate_id_seq OWNED BY library.affiliate.affiliate_id;


--
-- TOC entry 217 (class 1259 OID 17569)
-- Name: book; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.book (
    book_id integer NOT NULL,
    title character varying(65) NOT NULL,
    volume_number integer NOT NULL,
    author character varying(35) NOT NULL,
    field_of_knowledge character varying(35) NOT NULL
);


--
-- TOC entry 218 (class 1259 OID 17572)
-- Name: book_book_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.book_book_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3524 (class 0 OID 0)
-- Dependencies: 218
-- Name: book_book_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.book_book_id_seq OWNED BY library.book.book_id;


--
-- TOC entry 219 (class 1259 OID 17573)
-- Name: card_index; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.card_index (
    card_index_id integer NOT NULL,
    book_id integer NOT NULL,
    publisher_id integer NOT NULL,
    incoming_id integer NOT NULL,
    publisher_type character varying(20) NOT NULL,
    translator character varying(35) NOT NULL,
    publish_year integer NOT NULL,
    copies_count integer NOT NULL,
    compiler character varying(35) NOT NULL
);


--
-- TOC entry 220 (class 1259 OID 17576)
-- Name: copy; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.copy (
    copy_id integer NOT NULL,
    status character varying(20) NOT NULL,
    retention_period date NOT NULL
);


--
-- TOC entry 221 (class 1259 OID 17579)
-- Name: copy_copy_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.copy_copy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3525 (class 0 OID 0)
-- Dependencies: 221
-- Name: copy_copy_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.copy_copy_id_seq OWNED BY library.copy.copy_id;


--
-- TOC entry 222 (class 1259 OID 17580)
-- Name: copy_storage; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.copy_storage (
    copy_storage_id integer NOT NULL,
    copy_id integer NOT NULL,
    storage_id integer NOT NULL,
    status character varying(20) NOT NULL,
    date_start date NOT NULL,
    date_end date NOT NULL
);


--
-- TOC entry 223 (class 1259 OID 17583)
-- Name: copy_storage_copy_storage_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.copy_storage_copy_storage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3526 (class 0 OID 0)
-- Dependencies: 223
-- Name: copy_storage_copy_storage_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.copy_storage_copy_storage_id_seq OWNED BY library.copy_storage.copy_storage_id;


--
-- TOC entry 224 (class 1259 OID 17584)
-- Name: employee; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.employee (
    employee_id integer NOT NULL,
    employee_full_name character varying(35) NOT NULL,
    affiliate_id integer NOT NULL,
    "position" character varying(20) NOT NULL,
    email character varying(45) NOT NULL,
    phone_number bigint NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 17587)
-- Name: employee_employee_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.employee_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3527 (class 0 OID 0)
-- Dependencies: 225
-- Name: employee_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.employee_employee_id_seq OWNED BY library.employee.employee_id;


--
-- TOC entry 226 (class 1259 OID 17588)
-- Name: incoming; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.incoming (
    incoming_id integer NOT NULL,
    copy_id integer NOT NULL,
    supplier_invoice_id integer NOT NULL,
    date date NOT NULL
);


--
-- TOC entry 227 (class 1259 OID 17591)
-- Name: incoming_incoming_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.incoming_incoming_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3528 (class 0 OID 0)
-- Dependencies: 227
-- Name: incoming_incoming_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.incoming_incoming_id_seq OWNED BY library.incoming.incoming_id;


--
-- TOC entry 228 (class 1259 OID 17592)
-- Name: publisher; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.publisher (
    publisher_id integer NOT NULL,
    publisher_name character varying(35) NOT NULL,
    city character varying(20) NOT NULL
);


--
-- TOC entry 229 (class 1259 OID 17595)
-- Name: publisher_publisher_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.publisher_publisher_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3529 (class 0 OID 0)
-- Dependencies: 229
-- Name: publisher_publisher_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.publisher_publisher_id_seq OWNED BY library.publisher.publisher_id;


--
-- TOC entry 230 (class 1259 OID 17596)
-- Name: reader; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.reader (
    reader_id integer NOT NULL,
    passport_details bigint NOT NULL,
    reader_full_name character varying(45) NOT NULL,
    email character varying(40) NOT NULL,
    address character varying(45) NOT NULL,
    phone_number bigint NOT NULL
);


--
-- TOC entry 231 (class 1259 OID 17599)
-- Name: reader_reader_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.reader_reader_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3530 (class 0 OID 0)
-- Dependencies: 231
-- Name: reader_reader_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.reader_reader_id_seq OWNED BY library.reader.reader_id;


--
-- TOC entry 232 (class 1259 OID 17600)
-- Name: registered_reader; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.registered_reader (
    registered_reader_id integer NOT NULL,
    reader_id integer NOT NULL,
    subscription_id integer NOT NULL,
    date_start date NOT NULL,
    date_end date NOT NULL
);


--
-- TOC entry 233 (class 1259 OID 17603)
-- Name: registered_reader_registered_reader_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.registered_reader_registered_reader_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3531 (class 0 OID 0)
-- Dependencies: 233
-- Name: registered_reader_registered_reader_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.registered_reader_registered_reader_id_seq OWNED BY library.registered_reader.registered_reader_id;


--
-- TOC entry 234 (class 1259 OID 17604)
-- Name: registering; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.registering (
    registering_id integer NOT NULL,
    employee_id integer NOT NULL,
    date date NOT NULL,
    copy_id integer NOT NULL
);


--
-- TOC entry 235 (class 1259 OID 17607)
-- Name: registering_registering_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.registering_registering_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3532 (class 0 OID 0)
-- Dependencies: 235
-- Name: registering_registering_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.registering_registering_id_seq OWNED BY library.registering.registering_id;


--
-- TOC entry 236 (class 1259 OID 17608)
-- Name: replace_document; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.replace_document (
    replace_document_id integer NOT NULL,
    employee_id integer NOT NULL,
    date date NOT NULL,
    document_pro_bono_based character varying(40) NOT NULL,
    document_replace_lost character varying(40) NOT NULL,
    document_equal_lost character varying(40) NOT NULL,
    copy_id integer NOT NULL
);


--
-- TOC entry 237 (class 1259 OID 17611)
-- Name: replace_document_replace_document_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.replace_document_replace_document_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3533 (class 0 OID 0)
-- Dependencies: 237
-- Name: replace_document_replace_document_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.replace_document_replace_document_id_seq OWNED BY library.replace_document.replace_document_id;


--
-- TOC entry 238 (class 1259 OID 17612)
-- Name: storage; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.storage (
    storage_id integer NOT NULL,
    shelf_number integer NOT NULL,
    rack_number integer NOT NULL,
    room_number integer NOT NULL
);


--
-- TOC entry 239 (class 1259 OID 17615)
-- Name: storage_storage_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.storage_storage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3534 (class 0 OID 0)
-- Dependencies: 239
-- Name: storage_storage_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.storage_storage_id_seq OWNED BY library.storage.storage_id;


--
-- TOC entry 240 (class 1259 OID 17616)
-- Name: subscription; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.subscription (
    subscription_id integer NOT NULL,
    employee_id integer NOT NULL,
    copy_id integer NOT NULL,
    date_subscribed date NOT NULL,
    date_return date NOT NULL,
    date_real_return date,
    status character varying(20) NOT NULL,
    penalty character varying(20)
);


--
-- TOC entry 241 (class 1259 OID 17619)
-- Name: subscription_subscription_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.subscription_subscription_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3535 (class 0 OID 0)
-- Dependencies: 241
-- Name: subscription_subscription_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.subscription_subscription_id_seq OWNED BY library.subscription.subscription_id;


--
-- TOC entry 242 (class 1259 OID 17620)
-- Name: supplier_invoice; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.supplier_invoice (
    supplier_invoice_id integer NOT NULL,
    supplier_name character varying(35) NOT NULL,
    date date NOT NULL
);


--
-- TOC entry 243 (class 1259 OID 17623)
-- Name: supplier_invoice_supplier_invoice_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.supplier_invoice_supplier_invoice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3536 (class 0 OID 0)
-- Dependencies: 243
-- Name: supplier_invoice_supplier_invoice_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.supplier_invoice_supplier_invoice_id_seq OWNED BY library.supplier_invoice.supplier_invoice_id;


--
-- TOC entry 244 (class 1259 OID 17624)
-- Name: write_off; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.write_off (
    write_off_id integer NOT NULL,
    employee_id integer NOT NULL,
    date date NOT NULL,
    full_price integer NOT NULL,
    reason character varying(35) NOT NULL,
    direction_after_write_off character varying(20) NOT NULL,
    copy_id integer NOT NULL
);


--
-- TOC entry 245 (class 1259 OID 17627)
-- Name: write_off_write_off_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.write_off_write_off_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3537 (class 0 OID 0)
-- Dependencies: 245
-- Name: write_off_write_off_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.write_off_write_off_id_seq OWNED BY library.write_off.write_off_id;


--
-- TOC entry 246 (class 1259 OID 17628)
-- Name: сard_Index_сard_Index_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library."сard_Index_сard_Index_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3538 (class 0 OID 0)
-- Dependencies: 246
-- Name: сard_Index_сard_Index_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library."сard_Index_сard_Index_id_seq" OWNED BY library.card_index.card_index_id;


--
-- TOC entry 3249 (class 2604 OID 17629)
-- Name: affiliate affiliate_id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.affiliate ALTER COLUMN affiliate_id SET DEFAULT nextval('library.affiliate_affiliate_id_seq'::regclass);


--
-- TOC entry 3250 (class 2604 OID 17630)
-- Name: book book_id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.book ALTER COLUMN book_id SET DEFAULT nextval('library.book_book_id_seq'::regclass);


--
-- TOC entry 3251 (class 2604 OID 17631)
-- Name: card_index card_index_id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.card_index ALTER COLUMN card_index_id SET DEFAULT nextval('library."сard_Index_сard_Index_id_seq"'::regclass);


--
-- TOC entry 3252 (class 2604 OID 17632)
-- Name: copy copy_id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.copy ALTER COLUMN copy_id SET DEFAULT nextval('library.copy_copy_id_seq'::regclass);


--
-- TOC entry 3253 (class 2604 OID 17633)
-- Name: copy_storage copy_storage_id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.copy_storage ALTER COLUMN copy_storage_id SET DEFAULT nextval('library.copy_storage_copy_storage_id_seq'::regclass);


--
-- TOC entry 3254 (class 2604 OID 17634)
-- Name: employee employee_id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.employee ALTER COLUMN employee_id SET DEFAULT nextval('library.employee_employee_id_seq'::regclass);


--
-- TOC entry 3255 (class 2604 OID 17635)
-- Name: incoming incoming_id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.incoming ALTER COLUMN incoming_id SET DEFAULT nextval('library.incoming_incoming_id_seq'::regclass);


--
-- TOC entry 3256 (class 2604 OID 17636)
-- Name: publisher publisher_id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.publisher ALTER COLUMN publisher_id SET DEFAULT nextval('library.publisher_publisher_id_seq'::regclass);


--
-- TOC entry 3257 (class 2604 OID 17637)
-- Name: reader reader_id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.reader ALTER COLUMN reader_id SET DEFAULT nextval('library.reader_reader_id_seq'::regclass);


--
-- TOC entry 3258 (class 2604 OID 17638)
-- Name: registered_reader registered_reader_id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.registered_reader ALTER COLUMN registered_reader_id SET DEFAULT nextval('library.registered_reader_registered_reader_id_seq'::regclass);


--
-- TOC entry 3259 (class 2604 OID 17639)
-- Name: registering registering_id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.registering ALTER COLUMN registering_id SET DEFAULT nextval('library.registering_registering_id_seq'::regclass);


--
-- TOC entry 3260 (class 2604 OID 17640)
-- Name: replace_document replace_document_id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.replace_document ALTER COLUMN replace_document_id SET DEFAULT nextval('library.replace_document_replace_document_id_seq'::regclass);


--
-- TOC entry 3261 (class 2604 OID 17641)
-- Name: storage storage_id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.storage ALTER COLUMN storage_id SET DEFAULT nextval('library.storage_storage_id_seq'::regclass);


--
-- TOC entry 3262 (class 2604 OID 17642)
-- Name: subscription subscription_id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.subscription ALTER COLUMN subscription_id SET DEFAULT nextval('library.subscription_subscription_id_seq'::regclass);


--
-- TOC entry 3263 (class 2604 OID 17643)
-- Name: supplier_invoice supplier_invoice_id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.supplier_invoice ALTER COLUMN supplier_invoice_id SET DEFAULT nextval('library.supplier_invoice_supplier_invoice_id_seq'::regclass);


--
-- TOC entry 3264 (class 2604 OID 17644)
-- Name: write_off write_off_id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.write_off ALTER COLUMN write_off_id SET DEFAULT nextval('library.write_off_write_off_id_seq'::regclass);


--
-- TOC entry 3486 (class 0 OID 17565)
-- Dependencies: 215
-- Data for Name: affiliate; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (1, 'Филиал имени Пушкина', 'ул. Литературная, 1', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (2, 'Филиал имени Лермонтова', 'пр. Поэтический, 5', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (3, 'Филиал имени Толстого', 'ул. Прозаическая, 10', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (4, 'Филиал имени Достоевского', 'пл. Романовская, 3', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (5, 'Филиал имени Чехова', 'ул. Драматическая, 7', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (6, 'Филиал имени Гоголя', 'пр. Сатирический, 2', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (7, 'Филиал имени Тургенева', 'ул. Реалистическая, 9', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (8, 'Филиал имени Чуковского', 'пр. Детский, 4', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (9, 'Филиал имени Пастернака', 'ул. Лирическая, 12', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (10, 'Филиал имени Блока', 'пр. Символический, 8', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (11, 'Филиал имени Маяковского', 'ул. Революционная, 6', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (12, 'Филиал имени Есенина', 'пр. Лирический, 3', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (13, 'Филиал имени Ахматовой', 'ул. Эмоциональная, 15', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (14, 'Филиал имени Бродского', 'пр. Метафорический, 7', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (15, 'Филиал имени Паустовского', 'ул. Автобиографическая, 10', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (16, 'Филиал имени Фета', 'пр. Лирический, 2', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (17, 'Филиал имени Гумилева', 'ул. Метафорическая, 8', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (18, 'Филиал имени Ерофеева', 'пр. Сатирический, 3', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (19, 'Филиал имени Андреева', 'ул. Драматическая, 9', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (20, 'Филиал имени Фадеева', 'пр. Реалистический, 6', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (21, 'Филиал имени Бунина', 'ул. Литературная, 4', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (22, 'Филиал имени Шолохова', 'пр. Эпический, 5', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (23, 'Филиал имени Солженицына', 'ул. Историческая, 11', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (24, 'Филиал имени Булгакова', 'пр. Фантастический, 9', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (25, 'Филиал имени Айтматова', 'ул. Реалистическая, 7', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (26, 'Филиал имени Крылова', 'пр. Сатирический, 6', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (27, 'Филиал имени Гайдара', 'ул. Детская, 10', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (28, 'Филиал имени Успенского', 'пр. Фантастический, 8', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (29, 'Филиал имени Аксакова', 'ул. Литературная, 3', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (30, 'Филиал имени Островского', 'пр. Драматический, 10', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (31, 'Филиал имени Чернышевского', 'ул. Реалистическая, 5', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (32, 'Филиал имени Грибоедова', 'пр. Сатирический, 7', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (33, 'Филиал имени Ломоносова', 'ул. Поэтическая, 9', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (34, 'Филиал имени Фета', 'пр. Лирический, 2', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (35, 'Филиал имени Горького', 'ул. Реалистическая, 8', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (36, 'Филиал имени Бальмонта', 'пр. Символический, 4', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (37, 'Филиал имени Есенина', 'ул. Лирическая, 7', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (38, 'Филиал имени Ахматовой', 'пр. Эмоциональный, 3', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (39, 'Филиал имени Бродского', 'ул. Метафорическая, 6', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (40, 'Филиал имени Паустовского', 'пр. Автобиографический, 8', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (41, 'Филиал имени Фета', 'ул. Лирическая, 2', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (42, 'Филиал имени Гумилева', 'пр. Метафорический, 7', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (43, 'Филиал имени Ерофеева', 'ул. Сатирическая, 5', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (44, 'Филиал имени Андреева', 'пр. Драматический, 4', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (45, 'Филиал имени Фадеева', 'ул. Реалистическая, 10', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (46, 'Филиал имени Бунина', 'пр. Литературный, 9', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (47, 'Филиал имени Шолохова', 'ул. Эпическая, 6', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (48, 'Филиал имени Солженицына', 'пр. Исторический, 5', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (49, 'Филиал имени Булгакова', 'ул. Фантастическая, 3', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (50, 'Филиал имени Айтматова', 'пр. Реалистический, 8', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (51, 'Филиал имени Крылова', 'ул. Сатирическая, 9', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (52, 'Филиал имени Гайдара', 'пр. Детский, 7', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (53, 'Филиал имени Успенского', 'ул. Фантастическая, 6', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (54, 'Филиал имени Аксакова', 'пр. Литературный, 5', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (55, 'Филиал имени Островского', 'ул. Драматическая, 8', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (56, 'Филиал имени Чернышевского', 'пр. Реалистический, 4', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (57, 'Филиал имени Грибоедова', 'ул. Сатирическая, 7', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (58, 'Филиал имени Ломоносова', 'пр. Поэтический, 6', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (59, 'Филиал имени Фета', 'ул. Лирическая, 4', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (60, 'Филиал имени Горького', 'пр. Реалистический, 7', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (61, 'Филиал имени Бальмонта', 'ул. Символическая, 5', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (62, 'Филиал имени Есенина', 'пр. Лирический, 6', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (63, 'Филиал имени Ахматовой', 'ул. Эмоциональная, 4', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (64, 'Филиал имени Бродского', 'пр. Метафорический, 5', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (65, 'Филиал имени Паустовского', 'ул. Автобиографическая, 7', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (66, 'Филиал имени Фета', 'пр. Лирический, 3', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (67, 'Филиал имени Гумилева', 'ул. Метафорическая, 4', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (68, 'Филиал имени Ерофеева', 'пр. Сатирический, 6', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (69, 'Филиал имени Андреева', 'ул. Драматическая, 5', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (70, 'Филиал имени Фадеева', 'пр. Реалистический, 9', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (71, 'Филиал имени Бунина', 'ул. Литературная, 8', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (72, 'Филиал имени Шолохова', 'пр. Эпический, 4', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (73, 'Филиал имени Солженицына', 'ул. Историческая, 7', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (74, 'Филиал имени Булгакова', 'пр. Фантастический, 5', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (75, 'Филиал имени Айтматова', 'ул. Реалистическая, 6', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (76, 'Филиал имени Крылова', 'пр. Сатирический, 5', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (77, 'Филиал имени Гайдара', 'ул. Детская, 9', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (78, 'Филиал имени Успенского', 'пр. Фантастический, 4', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (79, 'Филиал имени Аксакова', 'ул. Литературная, 6', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (80, 'Филиал имени Островского', 'пр. Драматический, 7', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (81, 'Филиал имени Чернышевского', 'ул. Реалистическая, 3', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (82, 'Филиал имени Грибоедова', 'пр. Сатирический, 4', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (83, 'Филиал имени Ломоносова', 'ул. Поэтическая, 5', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (84, 'Филиал имени Фета', 'пр. Лирический, 2', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (85, 'Филиал имени Горького', 'ул. Реалистическая, 6', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (86, 'Филиал имени Бальмонта', 'пр. Символический, 3', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (87, 'Филиал имени Есенина', 'ул. Лирическая, 4', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (88, 'Филиал имени Ахматовой', 'пр. Эмоциональная, 2', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (89, 'Филиал имени Бродского', 'ул. Метафорическая, 3', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (90, 'Филиал имени Паустовского', 'пр. Автобиографический, 6', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (91, 'Филиал имени Фета', 'ул. Лирическая, 1', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (92, 'Филиал имени Гумилева', 'пр. Метафорический, 2', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (93, 'Филиал имени Ерофеева', 'ул. Сатирическая, 4', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (94, 'Филиал имени Андреева', 'пр. Драматический, 3', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (95, 'Филиал имени Фадеева', 'ул. Реалистическая, 8', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (96, 'Филиал имени Бунина', 'пр. Литературный, 7', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (97, 'Филиал имени Шолохова', 'ул. Эпическая, 3', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (98, 'Филиал имени Солженицына', 'пр. Исторический, 4', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (99, 'Филиал имени Булгакова', 'ул. Фантастическая, 2', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (100, 'Филиал имени Айтматова', 'пр. Реалистический, 7', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (101, 'Филиал имени Крылова', 'ул. Сатирическая, 8', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (102, 'Филиал имени Гайдара', 'пр. Детский, 6', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (103, 'Филиал имени Успенского', 'ул. Фантастическая, 5', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (104, 'Филиал имени Аксакова', 'пр. Литературный, 4', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (105, 'Филиал имени Островского', 'ул. Драматическая, 7', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (106, 'Филиал имени Чернышевского', 'пр. Реалистический, 2', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (107, 'Филиал имени Грибоедова', 'ул. Сатирическая, 3', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (108, 'Филиал имени Ломоносова', 'пр. Поэтический, 4', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (109, 'Филиал имени Фета', 'ул. Лирическая, 1', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (110, 'Филиал имени Горького', 'пр. Реалистический, 5', 'Средний');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (111, 'Филиал имени Бальмонта', 'ул. Символическая, 3', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (112, 'Филиал имени Есенина', 'пр. Лирический, 2', 'Низкий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (113, 'Филиал имени Ахматовой', 'ул. Эмоциональная, 3', 'Высокий');
INSERT INTO library.affiliate (affiliate_id, affiliate_name, address, level) VALUES (114, 'Филиал имени Бродского', 'пр. Метафорический, 2', 'Средний');


--
-- TOC entry 3488 (class 0 OID 17569)
-- Dependencies: 217
-- Data for Name: book; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (1, 'Война и мир', 1, 'Лев Толстой', 'Литература');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (2, 'Война и мир', 2, 'Лев Толстой', 'Литература');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (3, 'Преступление и наказание', 1, 'Федор Достоевский', 'Литература');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (4, 'Властелин колец', 1, 'Дж. Р. Р. Толкиен', 'Фантазия');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (5, 'Властелин колец', 2, 'Дж. Р. Р. Толкиен', 'Фантазия');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (6, 'Властелин колец', 3, 'Дж. Р. Р. Толкиен', 'Фантазия');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (7, 'Гарри Поттер и философский камень', 1, 'Дж. К. Роулинг', 'Фантазия');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (8, 'Гарри Поттер и Тайная комната', 2, 'Дж. К. Роулинг', 'Фантазия');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (9, 'Гарри Поттер и узник Азкабана', 3, 'Дж. К. Роулинг', 'Фантазия');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (10, '1984', 1, 'Джордж Оруэлл', 'Научная фантастика');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (11, 'Скотный двор', 1, 'Джордж Оруэлл', 'Политическая сатира');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (12, 'Теория относительности', 1, 'Альберт Эйнштейн', 'Физика');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (13, 'Основные концепции математики', 1, 'Р. Д. Кумар', 'Математика');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (14, 'Путешествие в центр Земли', 1, 'Жюль Верн', 'Научная фантастика');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (15, 'Вокруг света за 80 дней', 1, 'Жюль Верн', 'Приключения');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (16, 'C# для начинающих', 1, 'Джон Смит', 'Программирование на C#');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (17, 'Основы C#', 1, 'Питер Джонсон', 'Программирование на C#');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (18, 'C# и .NET: Подробное руководство', 1, 'Марк Майкл', 'Программирование на C#');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (19, 'Эффективное программирование на C#', 1, 'Стив Мартин', 'Программирование на C#');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (20, 'Изучаем C# через примеры', 1, 'Лилия Петрова', 'Программирование на C#');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (21, 'C# в деталях', 1, 'Александр Смирнов', 'Программирование на C#');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (22, 'C# и ASP.NET: разработка веб-приложений', 1, 'Михаил Семенов', 'Программирование на C#');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (23, 'Проектирование приложений на C#', 1, 'Анна Иванова', 'Программирование на C#');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (24, 'C# и Unity: Создание игр', 1, 'Владимир Козлов', 'Программирование на C#');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (25, 'C# для профессионалов', 1, 'Игорь Николаев', 'Программирование на C#');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (26, 'C# и Entity Framework: Работа с базами данных', 1, 'Ольга Сергеева', 'Программирование на C#');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (27, 'C# и Visual Studio: Советы и трюки', 1, 'Денис Петров', 'Программирование на C#');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (28, 'C# и WPF: Разработка графических интерфейсов', 1, 'Елена Волкова', 'Программирование на C#');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (29, 'C# и Xamarin: Мобильная разработка', 1, 'Сергей Ковалев', 'Программирование на C#');
INSERT INTO library.book (book_id, title, volume_number, author, field_of_knowledge) VALUES (30, 'C# и Machine Learning: Введение в Искусственный Интеллект', 1, 'Антон Чернов', 'Программирование на C#');


--
-- TOC entry 3490 (class 0 OID 17573)
-- Dependencies: 219
-- Data for Name: card_index; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.card_index (card_index_id, book_id, publisher_id, incoming_id, publisher_type, translator, publish_year, copies_count, compiler) VALUES (1, 11, 11, 11, 'Электронный', 'Николай Некрасов', 2022, 55, 'Николаев Николай');
INSERT INTO library.card_index (card_index_id, book_id, publisher_id, incoming_id, publisher_type, translator, publish_year, copies_count, compiler) VALUES (2, 12, 12, 12, 'Печатный', 'Анна Ахматова', 2021, 60, 'Андреев Андрей');
INSERT INTO library.card_index (card_index_id, book_id, publisher_id, incoming_id, publisher_type, translator, publish_year, copies_count, compiler) VALUES (3, 13, 13, 13, 'Электронный', 'Марина Цветаева', 2020, 65, 'Маринов Марин');
INSERT INTO library.card_index (card_index_id, book_id, publisher_id, incoming_id, publisher_type, translator, publish_year, copies_count, compiler) VALUES (4, 14, 14, 14, 'Печатный', 'Борис Пастернак', 2019, 70, 'Борисов Борис');
INSERT INTO library.card_index (card_index_id, book_id, publisher_id, incoming_id, publisher_type, translator, publish_year, copies_count, compiler) VALUES (5, 15, 15, 15, 'Электронный', 'Владимир Набоков', 2018, 75, 'Владимиров Владимир');
INSERT INTO library.card_index (card_index_id, book_id, publisher_id, incoming_id, publisher_type, translator, publish_year, copies_count, compiler) VALUES (6, 16, 16, 16, 'Печатный', 'Евгений Евтушенко', 2017, 80, 'Евгеньев Евгений');
INSERT INTO library.card_index (card_index_id, book_id, publisher_id, incoming_id, publisher_type, translator, publish_year, copies_count, compiler) VALUES (7, 17, 17, 17, 'Электронный', 'Иосиф Бродский', 2016, 85, 'Иосифов Иосиф');
INSERT INTO library.card_index (card_index_id, book_id, publisher_id, incoming_id, publisher_type, translator, publish_year, copies_count, compiler) VALUES (8, 18, 18, 18, 'Печатный', 'Виктор Цой', 2015, 90, 'Викторов Виктор');
INSERT INTO library.card_index (card_index_id, book_id, publisher_id, incoming_id, publisher_type, translator, publish_year, copies_count, compiler) VALUES (9, 19, 19, 19, 'Электронный', 'Сергей Есенин', 2014, 95, 'Сергеев Сергей');
INSERT INTO library.card_index (card_index_id, book_id, publisher_id, incoming_id, publisher_type, translator, publish_year, copies_count, compiler) VALUES (11, 6, 6, 6, 'Печатный', 'Федор Достоевский', 2018, 35, 'Ульянов Ульян');
INSERT INTO library.card_index (card_index_id, book_id, publisher_id, incoming_id, publisher_type, translator, publish_year, copies_count, compiler) VALUES (12, 7, 7, 7, 'Электронный', 'Максим Горький', 2017, 40, 'Сергеев Сергей');
INSERT INTO library.card_index (card_index_id, book_id, publisher_id, incoming_id, publisher_type, translator, publish_year, copies_count, compiler) VALUES (13, 8, 8, 8, 'Печатный', 'Алексей Толстой', 2016, 45, 'Алексеев Алексей');
INSERT INTO library.card_index (card_index_id, book_id, publisher_id, incoming_id, publisher_type, translator, publish_year, copies_count, compiler) VALUES (14, 9, 9, 9, 'Электронный', 'Иван Тургенев', 2015, 50, 'Ильин Илья');
INSERT INTO library.card_index (card_index_id, book_id, publisher_id, incoming_id, publisher_type, translator, publish_year, copies_count, compiler) VALUES (15, 1, 1, 1, 'Печатный', 'Александр Пушкин', 2023, 10, 'Иванов Иван');
INSERT INTO library.card_index (card_index_id, book_id, publisher_id, incoming_id, publisher_type, translator, publish_year, copies_count, compiler) VALUES (16, 2, 2, 2, 'Печатный', 'Михаил Лермонтов', 2022, 15, 'Петров Петр');
INSERT INTO library.card_index (card_index_id, book_id, publisher_id, incoming_id, publisher_type, translator, publish_year, copies_count, compiler) VALUES (17, 3, 3, 3, 'Электронный', 'Николай Гоголь', 2021, 20, 'Сидоров Сидор');
INSERT INTO library.card_index (card_index_id, book_id, publisher_id, incoming_id, publisher_type, translator, publish_year, copies_count, compiler) VALUES (18, 4, 4, 4, 'Печатный', 'Антон Чехов', 2020, 25, 'Смирнов Смирно');
INSERT INTO library.card_index (card_index_id, book_id, publisher_id, incoming_id, publisher_type, translator, publish_year, copies_count, compiler) VALUES (19, 5, 5, 5, 'Электронный', 'Лев Толстой', 2019, 30, 'Федоров Федор');


--
-- TOC entry 3491 (class 0 OID 17576)
-- Dependencies: 220
-- Data for Name: copy; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.copy (copy_id, status, retention_period) VALUES (1, 'выданный', '2023-05-01');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (2, 'возвращенный', '2023-04-18');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (3, 'просроченный', '2023-03-20');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (4, 'выданный', '2023-02-15');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (5, 'возвращенный', '2023-01-10');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (6, 'просроченный', '2022-12-05');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (7, 'выданный', '2022-11-01');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (8, 'возвращенный', '2022-10-20');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (9, 'просроченный', '2022-09-15');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (10, 'выданный', '2022-08-10');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (11, 'возвращенный', '2022-07-05');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (12, 'просроченный', '2022-06-01');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (13, 'выданный', '2022-05-20');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (14, 'возвращенный', '2022-04-15');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (15, 'просроченный', '2022-03-10');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (16, 'выданный', '2022-02-05');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (17, 'возвращенный', '2022-01-01');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (18, 'просроченный', '2021-12-20');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (19, 'выданный', '2021-11-15');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (20, 'возвращенный', '2021-10-10');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (21, 'просроченный', '2021-09-05');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (22, 'выданный', '2021-08-01');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (23, 'возвращенный', '2021-07-20');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (24, 'просроченный', '2021-06-15');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (25, 'выданный', '2021-05-10');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (26, 'возвращенный', '2021-04-05');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (27, 'просроченный', '2021-03-01');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (28, 'выданный', '2021-02-20');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (29, 'возвращенный', '2021-01-15');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (30, 'просроченный', '2020-12-10');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (31, 'выданный', '2023-06-01');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (32, 'возвращенный', '2023-05-01');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (33, 'просроченный', '2023-04-01');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (34, 'выданный', '2023-06-02');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (35, 'возвращенный', '2023-05-02');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (36, 'просроченный', '2023-04-02');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (37, 'выданный', '2023-06-03');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (38, 'возвращенный', '2023-05-03');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (39, 'просроченный', '2023-04-03');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (40, 'выданный', '2023-06-04');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (41, 'возвращенный', '2023-05-04');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (42, 'просроченный', '2023-04-04');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (43, 'выданный', '2023-06-05');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (44, 'возвращенный', '2023-05-05');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (45, 'просроченный', '2023-04-05');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (46, 'выданный', '2023-06-06');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (47, 'возвращенный', '2023-05-06');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (48, 'просроченный', '2023-04-06');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (49, 'выданный', '2023-06-07');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (50, 'возвращенный', '2023-05-07');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (51, 'просроченный', '2023-04-07');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (52, 'выданный', '2023-06-08');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (53, 'возвращенный', '2023-05-08');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (54, 'просроченный', '2023-04-08');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (55, 'выданный', '2023-06-09');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (56, 'возвращенный', '2023-05-09');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (57, 'просроченный', '2023-04-09');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (58, 'выданный', '2023-06-10');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (59, 'возвращенный', '2023-05-10');
INSERT INTO library.copy (copy_id, status, retention_period) VALUES (60, 'просроченный', '2023-04-10');


--
-- TOC entry 3493 (class 0 OID 17580)
-- Dependencies: 222
-- Data for Name: copy_storage; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (1, 1, 1, 'выданный', '2023-05-01', '2023-06-01');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (2, 2, 2, 'возвращенный', '2023-05-02', '2023-06-02');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (3, 3, 3, 'просроченный', '2023-05-03', '2023-06-03');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (4, 60, 4, 'выданный', '2023-05-04', '2023-06-04');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (5, 5, 5, 'возвращенный', '2023-05-05', '2023-06-05');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (6, 6, 6, 'просроченный', '2023-05-06', '2023-06-06');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (7, 7, 7, 'выданный', '2023-05-07', '2023-06-07');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (8, 58, 8, 'возвращенный', '2023-05-08', '2023-06-08');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (9, 9, 9, 'просроченный', '2023-05-09', '2023-06-09');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (10, 10, 10, 'выданный', '2023-05-10', '2023-06-10');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (11, 11, 1, 'возвращенный', '2023-05-11', '2023-06-11');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (12, 12, 2, 'просроченный', '2023-05-12', '2023-06-12');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (13, 13, 3, 'выданный', '2023-05-13', '2023-06-13');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (14, 14, 4, 'возвращенный', '2023-05-14', '2023-06-14');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (15, 15, 5, 'просроченный', '2023-05-15', '2023-06-15');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (16, 16, 6, 'выданный', '2023-05-16', '2023-06-16');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (17, 17, 7, 'возвращенный', '2023-05-17', '2023-06-17');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (18, 18, 8, 'просроченный', '2023-05-18', '2023-06-18');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (19, 19, 9, 'выданный', '2023-05-19', '2023-06-19');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (20, 20, 10, 'возвращенный', '2023-04-20', '2023-05-20');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (21, 21, 1, 'просроченный', '2023-04-21', '2023-05-21');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (22, 22, 2, 'выданный', '2023-04-22', '2023-05-22');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (23, 23, 3, 'возвращенный', '2023-04-23', '2023-05-23');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (24, 24, 4, 'просроченный', '2023-04-24', '2023-05-24');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (25, 25, 5, 'выданный', '2023-04-25', '2023-05-25');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (26, 26, 6, 'возвращенный', '2023-04-26', '2023-05-26');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (27, 27, 7, 'просроченный', '2023-04-27', '2023-05-27');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (28, 28, 8, 'выданный', '2023-04-28', '2023-05-28');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (29, 29, 9, 'возвращенный', '2023-04-29', '2023-05-29');
INSERT INTO library.copy_storage (copy_storage_id, copy_id, storage_id, status, date_start, date_end) VALUES (30, 30, 10, 'просроченный', '2023-04-30', '2023-05-30');


--
-- TOC entry 3495 (class 0 OID 17584)
-- Dependencies: 224
-- Data for Name: employee; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.employee (employee_id, employee_full_name, affiliate_id, "position", email, phone_number) VALUES (1, 'Иванов Иван Иванович', 1, 'Библиотекарь', 'ivanov@mail.com', 79000000001);
INSERT INTO library.employee (employee_id, employee_full_name, affiliate_id, "position", email, phone_number) VALUES (2, 'Петров Петр Петрович', 2, 'Администратор', 'petrov@mail.com', 79000000002);
INSERT INTO library.employee (employee_id, employee_full_name, affiliate_id, "position", email, phone_number) VALUES (3, 'Сидоров Сидр Сидорович', 3, 'Технический персонал', 'sidorov@mail.com', 79000000003);
INSERT INTO library.employee (employee_id, employee_full_name, affiliate_id, "position", email, phone_number) VALUES (4, 'Смирнов Александр Иванович', 4, 'Библиотекарь', 'smirnov@mail.com', 79000000004);
INSERT INTO library.employee (employee_id, employee_full_name, affiliate_id, "position", email, phone_number) VALUES (5, 'Кузнецов Николай Петрович', 5, 'Библиотекарь', 'kuznetsov@mail.com', 79000000005);
INSERT INTO library.employee (employee_id, employee_full_name, affiliate_id, "position", email, phone_number) VALUES (6, 'Попов Дмитрий Сергеевич', 6, 'Администратор', 'popov@mail.com', 79000000006);
INSERT INTO library.employee (employee_id, employee_full_name, affiliate_id, "position", email, phone_number) VALUES (7, 'Васильев Василий Иванович', 7, 'Технический персонал', 'vasiliev@mail.com', 79000000007);
INSERT INTO library.employee (employee_id, employee_full_name, affiliate_id, "position", email, phone_number) VALUES (8, 'Павлов Павел Павлович', 8, 'Библиотекарь', 'pavlov@mail.com', 79000000008);
INSERT INTO library.employee (employee_id, employee_full_name, affiliate_id, "position", email, phone_number) VALUES (9, 'Семенов Семен Семенович', 9, 'Библиотекарь', 'semenov@mail.com', 79000000009);
INSERT INTO library.employee (employee_id, employee_full_name, affiliate_id, "position", email, phone_number) VALUES (10, 'Голубев Геннадий Петрович', 10, 'Администратор', 'golubev@mail.com', 79000000010);
INSERT INTO library.employee (employee_id, employee_full_name, affiliate_id, "position", email, phone_number) VALUES (11, 'Зайцев Захар Борисович', 11, 'Технический персонал', 'zaytsev@mail.com', 79000000011);
INSERT INTO library.employee (employee_id, employee_full_name, affiliate_id, "position", email, phone_number) VALUES (12, 'Киселев Кирилл Владимирович', 12, 'Библиотекарь', 'kiselev@mail.com', 79000000012);
INSERT INTO library.employee (employee_id, employee_full_name, affiliate_id, "position", email, phone_number) VALUES (13, 'Ильин Илья Ильич', 13, 'Библиотекарь', 'ilin@mail.com', 79000000013);
INSERT INTO library.employee (employee_id, employee_full_name, affiliate_id, "position", email, phone_number) VALUES (14, 'Гусев Геннадий Сергеевич', 14, 'Администратор', 'gusev@mail.com', 79000000014);
INSERT INTO library.employee (employee_id, employee_full_name, affiliate_id, "position", email, phone_number) VALUES (15, 'Титов Тимур Тимурович', 15, 'Технический персонал', 'titov@mail.com', 79000000015);


--
-- TOC entry 3497 (class 0 OID 17588)
-- Dependencies: 226
-- Data for Name: incoming; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.incoming (incoming_id, copy_id, supplier_invoice_id, date) VALUES (1, 1, 1, '2023-05-01');
INSERT INTO library.incoming (incoming_id, copy_id, supplier_invoice_id, date) VALUES (2, 2, 2, '2023-05-02');
INSERT INTO library.incoming (incoming_id, copy_id, supplier_invoice_id, date) VALUES (3, 3, 3, '2023-05-03');
INSERT INTO library.incoming (incoming_id, copy_id, supplier_invoice_id, date) VALUES (4, 60, 4, '2023-05-04');
INSERT INTO library.incoming (incoming_id, copy_id, supplier_invoice_id, date) VALUES (5, 5, 5, '2023-05-05');
INSERT INTO library.incoming (incoming_id, copy_id, supplier_invoice_id, date) VALUES (6, 6, 6, '2023-05-06');
INSERT INTO library.incoming (incoming_id, copy_id, supplier_invoice_id, date) VALUES (7, 7, 7, '2023-05-07');
INSERT INTO library.incoming (incoming_id, copy_id, supplier_invoice_id, date) VALUES (8, 58, 8, '2023-05-08');
INSERT INTO library.incoming (incoming_id, copy_id, supplier_invoice_id, date) VALUES (9, 9, 9, '2023-05-09');
INSERT INTO library.incoming (incoming_id, copy_id, supplier_invoice_id, date) VALUES (10, 10, 10, '2023-05-10');
INSERT INTO library.incoming (incoming_id, copy_id, supplier_invoice_id, date) VALUES (11, 11, 1, '2023-05-11');
INSERT INTO library.incoming (incoming_id, copy_id, supplier_invoice_id, date) VALUES (12, 12, 2, '2023-05-12');
INSERT INTO library.incoming (incoming_id, copy_id, supplier_invoice_id, date) VALUES (13, 13, 3, '2023-05-13');
INSERT INTO library.incoming (incoming_id, copy_id, supplier_invoice_id, date) VALUES (14, 14, 4, '2023-05-14');
INSERT INTO library.incoming (incoming_id, copy_id, supplier_invoice_id, date) VALUES (15, 15, 5, '2023-05-15');
INSERT INTO library.incoming (incoming_id, copy_id, supplier_invoice_id, date) VALUES (16, 16, 6, '2023-05-16');
INSERT INTO library.incoming (incoming_id, copy_id, supplier_invoice_id, date) VALUES (17, 17, 7, '2023-05-17');
INSERT INTO library.incoming (incoming_id, copy_id, supplier_invoice_id, date) VALUES (18, 18, 8, '2023-05-18');
INSERT INTO library.incoming (incoming_id, copy_id, supplier_invoice_id, date) VALUES (19, 19, 9, '2023-05-19');


--
-- TOC entry 3499 (class 0 OID 17592)
-- Dependencies: 228
-- Data for Name: publisher; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.publisher (publisher_id, publisher_name, city) VALUES (1, 'Издательство Альфа', 'Москва');
INSERT INTO library.publisher (publisher_id, publisher_name, city) VALUES (2, 'Издательский Дом Бета', 'Санкт-Петербург');
INSERT INTO library.publisher (publisher_id, publisher_name, city) VALUES (3, 'Издательство Гамма', 'Екатеринбург');
INSERT INTO library.publisher (publisher_id, publisher_name, city) VALUES (4, 'Издательство Дельта', 'Новосибирск');
INSERT INTO library.publisher (publisher_id, publisher_name, city) VALUES (5, 'Издательский Клуб Эпсилон', 'Красноярск');
INSERT INTO library.publisher (publisher_id, publisher_name, city) VALUES (6, 'Издательство Зета', 'Владивосток');
INSERT INTO library.publisher (publisher_id, publisher_name, city) VALUES (7, 'Издательство Иота', 'Казань');
INSERT INTO library.publisher (publisher_id, publisher_name, city) VALUES (8, 'Издательский Дом Каппа', 'Нижний Новгород');
INSERT INTO library.publisher (publisher_id, publisher_name, city) VALUES (9, 'Издательство Лямбда', 'Калининград');
INSERT INTO library.publisher (publisher_id, publisher_name, city) VALUES (10, 'Издательский Клуб Мю', 'Самара');
INSERT INTO library.publisher (publisher_id, publisher_name, city) VALUES (11, 'Издательство Ню', 'Омск');
INSERT INTO library.publisher (publisher_id, publisher_name, city) VALUES (12, 'Издательский Дом Кси', 'Челябинск');
INSERT INTO library.publisher (publisher_id, publisher_name, city) VALUES (13, 'Издательство Омикрон', 'Уфа');
INSERT INTO library.publisher (publisher_id, publisher_name, city) VALUES (14, 'Издательский Клуб Пи', 'Ростов-на-Дону');
INSERT INTO library.publisher (publisher_id, publisher_name, city) VALUES (15, 'Издательство Ро', 'Пермь');
INSERT INTO library.publisher (publisher_id, publisher_name, city) VALUES (16, 'Издательский Дом Сигма', 'Волгоград');
INSERT INTO library.publisher (publisher_id, publisher_name, city) VALUES (17, 'Издательство Тау', 'Ульяновск');
INSERT INTO library.publisher (publisher_id, publisher_name, city) VALUES (18, 'Издательский Клуб Фи', 'Тюмень');
INSERT INTO library.publisher (publisher_id, publisher_name, city) VALUES (19, 'Издательство Хи', 'Ижевск');
INSERT INTO library.publisher (publisher_id, publisher_name, city) VALUES (20, 'Издательский Дом Ци', 'Томск');
INSERT INTO library.publisher (publisher_id, publisher_name, city) VALUES (21, 'Издательство Чи', 'Барнаул');


--
-- TOC entry 3501 (class 0 OID 17596)
-- Dependencies: 230
-- Data for Name: reader; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.reader (reader_id, passport_details, reader_full_name, email, address, phone_number) VALUES (1, 1234567890, 'Иванов Иван Иванович', 'ivanov@example.com', 'Москва, ул. Пушкина, д.10', 987654321);
INSERT INTO library.reader (reader_id, passport_details, reader_full_name, email, address, phone_number) VALUES (2, 9876543210, 'Петров Петр Петрович', 'petrov@example.com', 'Санкт-Петербург, пр. Невский, д.20', 123456789);
INSERT INTO library.reader (reader_id, passport_details, reader_full_name, email, address, phone_number) VALUES (3, 2468135790, 'Сидоров Сидор Сидорович', 'sidorov@example.com', 'Екатеринбург, ул. Ленина, д.30', 456789123);
INSERT INTO library.reader (reader_id, passport_details, reader_full_name, email, address, phone_number) VALUES (4, 1357924680, 'Смирнова Анна Владимировна', 'smirnova@example.com', 'Новосибирск, ул. Гоголя, д.40', 789123456);
INSERT INTO library.reader (reader_id, passport_details, reader_full_name, email, address, phone_number) VALUES (5, 3692581470, 'Иванова Екатерина Игоревна', 'ivanova@example.com', 'Казань, ул. Кирова, д.50', 321654987);
INSERT INTO library.reader (reader_id, passport_details, reader_full_name, email, address, phone_number) VALUES (6, 8024675913, 'Попова Ольга Александровна', 'popova@example.com', 'Ростов-на-Дону, ул. Лермонтова, д.60', 654987321);
INSERT INTO library.reader (reader_id, passport_details, reader_full_name, email, address, phone_number) VALUES (7, 9513572864, 'Сергеев Сергей Сергеевич', 'sergeev@example.com', 'Уфа, ул. Мира, д.70', 987321654);
INSERT INTO library.reader (reader_id, passport_details, reader_full_name, email, address, phone_number) VALUES (8, 6745192836, 'Кузнецова Анастасия Ивановна', 'kuznetsova@example.com', 'Волгоград, ул. Победы, д.80', 321987654);
INSERT INTO library.reader (reader_id, passport_details, reader_full_name, email, address, phone_number) VALUES (9, 2753918465, 'Александров Александр Александрович', 'alexandrov@example.com', 'Пермь, ул. Комсомольская, д.90', 654321987);
INSERT INTO library.reader (reader_id, passport_details, reader_full_name, email, address, phone_number) VALUES (10, 1486239757, 'Николаева Елена Андреевна', 'nikolaeva@example.com', 'Воронеж, ул. Ленинградская, д.100', 987654321);


--
-- TOC entry 3503 (class 0 OID 17600)
-- Dependencies: 232
-- Data for Name: registered_reader; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (1, 1, 1, '2023-01-01', '2023-01-31');
INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (2, 2, 2, '2023-02-01', '2023-02-28');
INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (3, 3, 3, '2023-03-01', '2023-03-31');
INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (4, 4, 4, '2023-04-01', '2023-04-30');
INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (5, 5, 5, '2023-01-15', '2023-02-14');
INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (6, 6, 6, '2023-02-15', '2023-03-17');
INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (7, 7, 7, '2023-03-15', '2023-04-14');
INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (8, 8, 8, '2023-04-15', '2023-05-15');
INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (9, 9, 9, '2023-01-10', '2023-02-09');
INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (10, 10, 10, '2023-02-10', '2023-03-12');
INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (11, 1, 11, '2023-03-10', '2023-04-09');
INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (12, 2, 12, '2023-04-10', '2023-05-10');
INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (13, 3, 13, '2023-01-05', '2023-02-04');
INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (14, 4, 14, '2023-02-05', '2023-03-07');
INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (15, 5, 15, '2023-03-05', '2023-04-04');
INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (16, 6, 16, '2023-04-05', '2023-05-05');
INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (17, 7, 17, '2023-01-20', '2023-02-19');
INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (18, 8, 18, '2023-02-20', '2023-03-22');
INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (19, 9, 19, '2023-03-20', '2023-04-19');
INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (20, 10, 20, '2023-04-20', '2023-05-20');
INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (21, 1, 21, '2023-01-25', '2023-02-24');
INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (22, 2, 22, '2023-02-25', '2023-03-27');
INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (23, 3, 23, '2023-03-25', '2023-04-24');
INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (24, 4, 24, '2023-04-25', '2023-05-25');
INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (25, 7, 27, '2023-03-30', '2023-04-29');
INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (26, 8, 28, '2023-04-30', '2023-05-30');
INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (27, 9, 29, '2023-01-12', '2023-02-11');
INSERT INTO library.registered_reader (registered_reader_id, reader_id, subscription_id, date_start, date_end) VALUES (28, 10, 30, '2023-02-12', '2023-03-14');


--
-- TOC entry 3505 (class 0 OID 17604)
-- Dependencies: 234
-- Data for Name: registering; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (1, 1, '2023-01-12', 30);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (2, 7, '2023-03-05', 45);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (3, 5, '2022-12-12', 15);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (4, 9, '2022-11-20', 5);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (5, 2, '2023-02-28', 50);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (6, 6, '2022-09-15', 10);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (7, 8, '2022-08-07', 38);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (8, 3, '2023-05-10', 9);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (9, 13, '2023-04-22', 18);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (10, 14, '2022-10-01', 25);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (11, 11, '2022-07-14', 48);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (12, 12, '2023-04-01', 33);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (13, 10, '2022-06-25', 54);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (14, 4, '2022-05-30', 6);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (15, 15, '2022-07-20', 21);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (16, 2, '2023-01-05', 35);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (17, 3, '2022-09-10', 60);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (18, 6, '2023-03-15', 11);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (19, 4, '2022-08-08', 40);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (20, 1, '2023-02-27', 51);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (21, 8, '2022-10-15', 14);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (22, 10, '2022-12-07', 39);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (23, 12, '2023-05-18', 8);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (24, 14, '2023-04-12', 20);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (25, 13, '2022-06-12', 26);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (26, 15, '2022-11-14', 49);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (27, 9, '2023-03-20', 34);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (28, 7, '2022-05-05', 55);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (29, 5, '2022-04-30', 7);
INSERT INTO library.registering (registering_id, employee_id, date, copy_id) VALUES (30, 11, '2022-07-10', 22);


--
-- TOC entry 3507 (class 0 OID 17608)
-- Dependencies: 236
-- Data for Name: replace_document; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.replace_document (replace_document_id, employee_id, date, document_pro_bono_based, document_replace_lost, document_equal_lost, copy_id) VALUES (1, 3, '2022-12-20', 'Протокол №25', 'Приказ №42', 'Заявление №10', 10);
INSERT INTO library.replace_document (replace_document_id, employee_id, date, document_pro_bono_based, document_replace_lost, document_equal_lost, copy_id) VALUES (2, 5, '2023-03-15', 'Распоряжение №15', 'Уведомление №20', 'Протокол №30', 25);
INSERT INTO library.replace_document (replace_document_id, employee_id, date, document_pro_bono_based, document_replace_lost, document_equal_lost, copy_id) VALUES (3, 1, '2023-01-05', 'Заявление №3', 'Протокол №23', 'Приказ №45', 40);
INSERT INTO library.replace_document (replace_document_id, employee_id, date, document_pro_bono_based, document_replace_lost, document_equal_lost, copy_id) VALUES (4, 9, '2023-02-18', 'Уведомление №9', 'Распоряжение №18', 'Протокол №52', 52);
INSERT INTO library.replace_document (replace_document_id, employee_id, date, document_pro_bono_based, document_replace_lost, document_equal_lost, copy_id) VALUES (5, 12, '2022-11-30', 'Приказ №12', 'Заявление №31', 'Уведомление №6', 6);
INSERT INTO library.replace_document (replace_document_id, employee_id, date, document_pro_bono_based, document_replace_lost, document_equal_lost, copy_id) VALUES (6, 7, '2023-03-19', 'Документ поддержка №57', 'Документ замена №23', 'Документ эквивалент №45', 23);
INSERT INTO library.replace_document (replace_document_id, employee_id, date, document_pro_bono_based, document_replace_lost, document_equal_lost, copy_id) VALUES (7, 5, '2023-02-20', 'Документ защита №68', 'Документ обновление №34', 'Документ заменитель №52', 45);
INSERT INTO library.replace_document (replace_document_id, employee_id, date, document_pro_bono_based, document_replace_lost, document_equal_lost, copy_id) VALUES (8, 13, '2023-01-15', 'Документ обеспечение №12', 'Документ восстановление №78', 'Документ аналог №39', 12);
INSERT INTO library.replace_document (replace_document_id, employee_id, date, document_pro_bono_based, document_replace_lost, document_equal_lost, copy_id) VALUES (9, 9, '2022-11-30', 'Документ сопровождение №83', 'Документ реконструкция №47', 'Документ схожий №28', 53);
INSERT INTO library.replace_document (replace_document_id, employee_id, date, document_pro_bono_based, document_replace_lost, document_equal_lost, copy_id) VALUES (10, 3, '2022-12-17', 'Документ обслуживание №46', 'Документ преобразование №32', 'Документ идентичный №15', 33);
INSERT INTO library.replace_document (replace_document_id, employee_id, date, document_pro_bono_based, document_replace_lost, document_equal_lost, copy_id) VALUES (11, 15, '2023-04-07', 'Документ служба №24', 'Документ модернизация №51', 'Документ подобный №58', 59);
INSERT INTO library.replace_document (replace_document_id, employee_id, date, document_pro_bono_based, document_replace_lost, document_equal_lost, copy_id) VALUES (12, 1, '2023-03-23', 'Документ сервис №36', 'Документ обновление №19', 'Документ равнозначный №22', 6);
INSERT INTO library.replace_document (replace_document_id, employee_id, date, document_pro_bono_based, document_replace_lost, document_equal_lost, copy_id) VALUES (13, 11, '2022-10-11', 'Документ обслуживание №74', 'Документ реорганизация №11', 'Документ сходный №41', 17);
INSERT INTO library.replace_document (replace_document_id, employee_id, date, document_pro_bono_based, document_replace_lost, document_equal_lost, copy_id) VALUES (14, 2, '2023-01-30', 'Документ поддержка №38', 'Документ замена №56', 'Документ аналогичный №31', 25);
INSERT INTO library.replace_document (replace_document_id, employee_id, date, document_pro_bono_based, document_replace_lost, document_equal_lost, copy_id) VALUES (15, 14, '2022-11-15', 'Документ обеспечение №81', 'Документ восстановление №14', 'Документ идентичный №67', 35);


--
-- TOC entry 3509 (class 0 OID 17612)
-- Dependencies: 238
-- Data for Name: storage; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (1, 1, 1, 101);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (2, 1, 2, 101);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (3, 2, 1, 101);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (4, 2, 2, 101);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (5, 3, 1, 101);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (6, 3, 2, 101);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (7, 4, 1, 101);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (8, 4, 2, 101);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (9, 5, 1, 101);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (10, 5, 2, 101);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (11, 1, 1, 102);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (12, 1, 2, 102);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (13, 2, 1, 102);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (14, 2, 2, 102);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (15, 3, 1, 102);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (16, 3, 2, 102);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (17, 4, 1, 102);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (18, 4, 2, 102);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (19, 5, 1, 102);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (20, 5, 2, 102);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (21, 1, 1, 103);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (22, 1, 2, 103);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (23, 2, 1, 103);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (24, 2, 2, 103);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (25, 3, 1, 103);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (26, 3, 2, 103);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (27, 4, 1, 103);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (28, 4, 2, 103);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (29, 5, 1, 103);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (30, 5, 2, 103);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (31, 1, 1, 104);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (32, 1, 2, 104);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (33, 2, 1, 104);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (34, 2, 2, 104);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (35, 3, 1, 104);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (36, 3, 2, 104);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (37, 4, 1, 104);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (38, 4, 2, 104);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (39, 5, 1, 104);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (40, 5, 2, 104);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (41, 1, 1, 105);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (42, 1, 2, 105);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (43, 2, 1, 105);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (44, 2, 2, 105);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (45, 3, 1, 105);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (46, 3, 2, 105);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (47, 4, 1, 105);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (48, 4, 2, 105);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (49, 5, 1, 105);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (50, 5, 2, 105);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (51, 1, 1, 106);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (52, 1, 2, 106);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (53, 2, 1, 106);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (54, 2, 2, 106);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (55, 3, 1, 106);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (56, 3, 2, 106);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (57, 4, 1, 106);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (58, 4, 2, 106);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (59, 5, 1, 106);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (60, 5, 2, 106);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (61, 1, 1, 107);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (62, 1, 2, 107);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (63, 2, 1, 107);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (64, 2, 2, 107);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (65, 3, 1, 107);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (66, 3, 2, 107);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (67, 4, 1, 107);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (68, 4, 2, 107);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (69, 5, 1, 107);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (70, 5, 2, 107);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (71, 1, 1, 108);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (72, 1, 2, 108);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (73, 2, 1, 108);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (74, 2, 2, 108);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (75, 3, 1, 108);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (76, 3, 2, 108);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (77, 4, 1, 108);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (78, 4, 2, 108);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (79, 5, 1, 108);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (80, 5, 2, 108);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (81, 1, 1, 109);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (82, 1, 2, 109);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (83, 2, 1, 109);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (84, 2, 2, 109);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (85, 3, 1, 109);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (86, 3, 2, 109);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (87, 4, 1, 109);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (88, 4, 2, 109);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (89, 5, 1, 109);
INSERT INTO library.storage (storage_id, shelf_number, rack_number, room_number) VALUES (90, 5, 2, 109);


--
-- TOC entry 3511 (class 0 OID 17616)
-- Dependencies: 240
-- Data for Name: subscription; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (1, 1, 1, '2023-01-01', '2023-01-31', NULL, 'активный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (2, 2, 2, '2023-02-01', '2023-02-28', NULL, 'неактивный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (3, 3, 3, '2023-03-01', '2023-03-31', NULL, 'активный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (4, 4, 4, '2023-04-01', '2023-04-30', NULL, 'активный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (5, 5, 5, '2023-05-01', '2023-05-31', NULL, 'неактивный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (6, 6, 6, '2022-06-01', '2022-06-30', NULL, 'активный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (7, 7, 7, '2022-07-01', '2022-07-31', NULL, 'активный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (8, 8, 8, '2022-08-01', '2022-08-31', NULL, 'неактивный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (9, 9, 9, '2022-09-01', '2022-09-30', NULL, 'активный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (10, 10, 10, '2022-10-01', '2022-10-31', NULL, 'активный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (11, 11, 11, '2022-11-01', '2022-11-30', NULL, 'неактивный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (12, 12, 12, '2022-12-01', '2022-12-31', NULL, 'активный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (13, 13, 13, '2022-01-01', '2024-01-31', NULL, 'активный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (14, 14, 14, '2022-02-01', '2024-02-28', NULL, 'неактивный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (15, 15, 15, '2022-03-01', '2024-03-31', NULL, 'активный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (16, 1, 16, '2023-01-01', '2023-01-31', NULL, 'активный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (17, 2, 17, '2023-02-01', '2023-02-28', NULL, 'неактивный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (18, 3, 18, '2023-03-01', '2023-03-31', NULL, 'активный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (19, 4, 19, '2023-04-01', '2023-04-30', NULL, 'активный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (20, 5, 20, '2023-05-01', '2023-05-19', NULL, 'неактивный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (21, 6, 21, '2023-01-01', '2023-01-31', NULL, 'активный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (22, 7, 22, '2023-02-01', '2023-02-28', NULL, 'активный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (23, 8, 23, '2023-03-01', '2023-03-31', NULL, 'неактивный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (24, 9, 24, '2023-04-01', '2023-04-30', NULL, 'активный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (25, 10, 25, '2023-05-01', '2023-05-19', NULL, 'активный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (26, 11, 26, '2023-01-01', '2023-01-31', NULL, 'неактивный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (27, 12, 27, '2023-02-01', '2023-02-28', NULL, 'активный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (28, 13, 28, '2023-03-01', '2023-03-31', NULL, 'активный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (29, 14, 29, '2023-04-01', '2023-04-30', NULL, 'неактивный', NULL);
INSERT INTO library.subscription (subscription_id, employee_id, copy_id, date_subscribed, date_return, date_real_return, status, penalty) VALUES (30, 15, 30, '2023-05-01', '2023-05-19', NULL, 'активный', NULL);


--
-- TOC entry 3513 (class 0 OID 17620)
-- Dependencies: 242
-- Data for Name: supplier_invoice; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.supplier_invoice (supplier_invoice_id, supplier_name, date) VALUES (1, 'ООО "Книжный мир"', '2023-05-10');
INSERT INTO library.supplier_invoice (supplier_invoice_id, supplier_name, date) VALUES (2, 'ИП Иванов', '2023-05-11');
INSERT INTO library.supplier_invoice (supplier_invoice_id, supplier_name, date) VALUES (3, 'АО "Успех"', '2023-05-12');
INSERT INTO library.supplier_invoice (supplier_invoice_id, supplier_name, date) VALUES (4, 'ИП Петров', '2023-05-13');
INSERT INTO library.supplier_invoice (supplier_invoice_id, supplier_name, date) VALUES (5, 'ООО "Книжный салон"', '2023-05-14');
INSERT INTO library.supplier_invoice (supplier_invoice_id, supplier_name, date) VALUES (6, 'АО "Деловая литература"', '2023-05-15');
INSERT INTO library.supplier_invoice (supplier_invoice_id, supplier_name, date) VALUES (7, 'ИП Сидоров', '2023-05-16');
INSERT INTO library.supplier_invoice (supplier_invoice_id, supplier_name, date) VALUES (8, 'ООО "Партнеры по книгам"', '2023-05-17');
INSERT INTO library.supplier_invoice (supplier_invoice_id, supplier_name, date) VALUES (9, 'АО "Прогресс"', '2023-05-18');
INSERT INTO library.supplier_invoice (supplier_invoice_id, supplier_name, date) VALUES (10, 'ИП Новиков', '2023-05-19');


--
-- TOC entry 3515 (class 0 OID 17624)
-- Dependencies: 244
-- Data for Name: write_off; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.write_off (write_off_id, employee_id, date, full_price, reason, direction_after_write_off, copy_id) VALUES (1, 1, '2023-05-01', 500, 'Повреждение', 'Склад', 1);
INSERT INTO library.write_off (write_off_id, employee_id, date, full_price, reason, direction_after_write_off, copy_id) VALUES (2, 2, '2023-04-01', 600, 'Потеря', 'Утилизация', 2);
INSERT INTO library.write_off (write_off_id, employee_id, date, full_price, reason, direction_after_write_off, copy_id) VALUES (3, 3, '2023-03-01', 700, 'Износ', 'Утилизация', 3);
INSERT INTO library.write_off (write_off_id, employee_id, date, full_price, reason, direction_after_write_off, copy_id) VALUES (4, 4, '2023-02-01', 800, 'Повреждение', 'Склад', 4);
INSERT INTO library.write_off (write_off_id, employee_id, date, full_price, reason, direction_after_write_off, copy_id) VALUES (5, 5, '2023-01-01', 900, 'Потеря', 'Утилизация', 5);
INSERT INTO library.write_off (write_off_id, employee_id, date, full_price, reason, direction_after_write_off, copy_id) VALUES (6, 3, '2022-12-20', 500, 'Повреждение', 'Утилизация', 10);
INSERT INTO library.write_off (write_off_id, employee_id, date, full_price, reason, direction_after_write_off, copy_id) VALUES (7, 5, '2023-03-15', 300, 'Потеря', 'Перепродажа', 25);
INSERT INTO library.write_off (write_off_id, employee_id, date, full_price, reason, direction_after_write_off, copy_id) VALUES (8, 1, '2023-01-05', 700, 'Повреждение', 'Перепродажа', 40);
INSERT INTO library.write_off (write_off_id, employee_id, date, full_price, reason, direction_after_write_off, copy_id) VALUES (9, 9, '2023-02-18', 1000, 'Потеря', 'Утилизация', 52);
INSERT INTO library.write_off (write_off_id, employee_id, date, full_price, reason, direction_after_write_off, copy_id) VALUES (10, 12, '2022-11-30', 600, 'Повреждение', 'Перепродажа', 6);
INSERT INTO library.write_off (write_off_id, employee_id, date, full_price, reason, direction_after_write_off, copy_id) VALUES (11, 7, '2023-04-01', 800, 'Повреждение', 'Утилизация', 15);
INSERT INTO library.write_off (write_off_id, employee_id, date, full_price, reason, direction_after_write_off, copy_id) VALUES (12, 2, '2023-03-20', 400, 'Потеря', 'Перепродажа', 30);
INSERT INTO library.write_off (write_off_id, employee_id, date, full_price, reason, direction_after_write_off, copy_id) VALUES (13, 8, '2023-01-28', 500, 'Повреждение', 'Утилизация', 45);
INSERT INTO library.write_off (write_off_id, employee_id, date, full_price, reason, direction_after_write_off, copy_id) VALUES (14, 14, '2022-12-10', 700, 'Потеря', 'Перепродажа', 57);
INSERT INTO library.write_off (write_off_id, employee_id, date, full_price, reason, direction_after_write_off, copy_id) VALUES (15, 4, '2023-02-05', 600, 'Повреждение', 'Утилизация', 9);
INSERT INTO library.write_off (write_off_id, employee_id, date, full_price, reason, direction_after_write_off, copy_id) VALUES (16, 6, '2022-11-20', 800, 'Повреждение', 'Перепродажа', 24);
INSERT INTO library.write_off (write_off_id, employee_id, date, full_price, reason, direction_after_write_off, copy_id) VALUES (17, 10, '2023-04-16', 1000, 'Потеря', 'Утилизация', 39);
INSERT INTO library.write_off (write_off_id, employee_id, date, full_price, reason, direction_after_write_off, copy_id) VALUES (18, 13, '2023-01-02', 400, 'Повреждение', 'Перепродажа', 53);
INSERT INTO library.write_off (write_off_id, employee_id, date, full_price, reason, direction_after_write_off, copy_id) VALUES (19, 7, '2023-03-01', 500, 'Повреждение', 'Утилизация', 7);
INSERT INTO library.write_off (write_off_id, employee_id, date, full_price, reason, direction_after_write_off, copy_id) VALUES (20, 11, '2022-12-15', 900, 'Потеря', 'Перепродажа', 26);
INSERT INTO library.write_off (write_off_id, employee_id, date, full_price, reason, direction_after_write_off, copy_id) VALUES (21, 5, '2023-02-12', 600, 'Повреждение', 'Утилизация', 41);
INSERT INTO library.write_off (write_off_id, employee_id, date, full_price, reason, direction_after_write_off, copy_id) VALUES (22, 15, '2023-04-20', 700, 'Повреждение', 'Перепродажа', 55);
INSERT INTO library.write_off (write_off_id, employee_id, date, full_price, reason, direction_after_write_off, copy_id) VALUES (23, 1, '2023-03-25', 800, 'Потеря', 'Утилизация', 10);
INSERT INTO library.write_off (write_off_id, employee_id, date, full_price, reason, direction_after_write_off, copy_id) VALUES (24, 9, '2023-01-10', 900, 'Повреждение', 'Перепродажа', 25);
INSERT INTO library.write_off (write_off_id, employee_id, date, full_price, reason, direction_after_write_off, copy_id) VALUES (25, 12, '2022-12-05', 1000, 'Повреждение', 'Утилизация', 40);


--
-- TOC entry 3539 (class 0 OID 0)
-- Dependencies: 216
-- Name: affiliate_affiliate_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.affiliate_affiliate_id_seq', 114, true);


--
-- TOC entry 3540 (class 0 OID 0)
-- Dependencies: 218
-- Name: book_book_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.book_book_id_seq', 30, true);


--
-- TOC entry 3541 (class 0 OID 0)
-- Dependencies: 221
-- Name: copy_copy_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.copy_copy_id_seq', 60, true);


--
-- TOC entry 3542 (class 0 OID 0)
-- Dependencies: 223
-- Name: copy_storage_copy_storage_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.copy_storage_copy_storage_id_seq', 30, true);


--
-- TOC entry 3543 (class 0 OID 0)
-- Dependencies: 225
-- Name: employee_employee_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.employee_employee_id_seq', 15, true);


--
-- TOC entry 3544 (class 0 OID 0)
-- Dependencies: 227
-- Name: incoming_incoming_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.incoming_incoming_id_seq', 19, true);


--
-- TOC entry 3545 (class 0 OID 0)
-- Dependencies: 229
-- Name: publisher_publisher_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.publisher_publisher_id_seq', 21, true);


--
-- TOC entry 3546 (class 0 OID 0)
-- Dependencies: 231
-- Name: reader_reader_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.reader_reader_id_seq', 10, true);


--
-- TOC entry 3547 (class 0 OID 0)
-- Dependencies: 233
-- Name: registered_reader_registered_reader_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.registered_reader_registered_reader_id_seq', 28, true);


--
-- TOC entry 3548 (class 0 OID 0)
-- Dependencies: 235
-- Name: registering_registering_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.registering_registering_id_seq', 30, true);


--
-- TOC entry 3549 (class 0 OID 0)
-- Dependencies: 237
-- Name: replace_document_replace_document_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.replace_document_replace_document_id_seq', 15, true);


--
-- TOC entry 3550 (class 0 OID 0)
-- Dependencies: 239
-- Name: storage_storage_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.storage_storage_id_seq', 90, true);


--
-- TOC entry 3551 (class 0 OID 0)
-- Dependencies: 241
-- Name: subscription_subscription_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.subscription_subscription_id_seq', 30, true);


--
-- TOC entry 3552 (class 0 OID 0)
-- Dependencies: 243
-- Name: supplier_invoice_supplier_invoice_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.supplier_invoice_supplier_invoice_id_seq', 10, true);


--
-- TOC entry 3553 (class 0 OID 0)
-- Dependencies: 245
-- Name: write_off_write_off_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.write_off_write_off_id_seq', 25, true);


--
-- TOC entry 3554 (class 0 OID 0)
-- Dependencies: 246
-- Name: сard_Index_сard_Index_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library."сard_Index_сard_Index_id_seq"', 19, true);


--
-- TOC entry 3291 (class 2606 OID 17646)
-- Name: affiliate affiliate_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.affiliate
    ADD CONSTRAINT affiliate_pkey PRIMARY KEY (affiliate_id);


--
-- TOC entry 3293 (class 2606 OID 17648)
-- Name: book book_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.book
    ADD CONSTRAINT book_pkey PRIMARY KEY (book_id);


--
-- TOC entry 3266 (class 2606 OID 17649)
-- Name: card_index ch_copies_count; Type: CHECK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE library.card_index
    ADD CONSTRAINT ch_copies_count CHECK ((copies_count >= 0)) NOT VALID;


--
-- TOC entry 3274 (class 2606 OID 17650)
-- Name: incoming ch_date; Type: CHECK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE library.incoming
    ADD CONSTRAINT ch_date CHECK ((date <= now())) NOT VALID;


--
-- TOC entry 3278 (class 2606 OID 17651)
-- Name: registering ch_date; Type: CHECK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE library.registering
    ADD CONSTRAINT ch_date CHECK ((date <= now())) NOT VALID;


--
-- TOC entry 3279 (class 2606 OID 17652)
-- Name: replace_document ch_date; Type: CHECK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE library.replace_document
    ADD CONSTRAINT ch_date CHECK ((date <= now())) NOT VALID;


--
-- TOC entry 3287 (class 2606 OID 17653)
-- Name: supplier_invoice ch_date; Type: CHECK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE library.supplier_invoice
    ADD CONSTRAINT ch_date CHECK ((date <= now())) NOT VALID;


--
-- TOC entry 3288 (class 2606 OID 17654)
-- Name: write_off ch_date; Type: CHECK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE library.write_off
    ADD CONSTRAINT ch_date CHECK ((date <= now())) NOT VALID;


--
-- TOC entry 3276 (class 2606 OID 17655)
-- Name: registered_reader ch_date_end; Type: CHECK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE library.registered_reader
    ADD CONSTRAINT ch_date_end CHECK ((date_end > date_start)) NOT VALID;


--
-- TOC entry 3270 (class 2606 OID 17656)
-- Name: copy_storage ch_date_end; Type: CHECK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE library.copy_storage
    ADD CONSTRAINT ch_date_end CHECK ((date_end > date_start)) NOT VALID;


--
-- TOC entry 3283 (class 2606 OID 17657)
-- Name: subscription ch_date_real_return; Type: CHECK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE library.subscription
    ADD CONSTRAINT ch_date_real_return CHECK (((date_real_return IS NULL) OR (date_real_return > date_subscribed))) NOT VALID;


--
-- TOC entry 3284 (class 2606 OID 17658)
-- Name: subscription ch_date_return; Type: CHECK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE library.subscription
    ADD CONSTRAINT ch_date_return CHECK ((date_return > date_subscribed)) NOT VALID;


--
-- TOC entry 3277 (class 2606 OID 17659)
-- Name: registered_reader ch_date_start; Type: CHECK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE library.registered_reader
    ADD CONSTRAINT ch_date_start CHECK ((date_start <= now())) NOT VALID;


--
-- TOC entry 3271 (class 2606 OID 17660)
-- Name: copy_storage ch_date_start; Type: CHECK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE library.copy_storage
    ADD CONSTRAINT ch_date_start CHECK ((date_start <= now())) NOT VALID;


--
-- TOC entry 3285 (class 2606 OID 17661)
-- Name: subscription ch_date_subscribed; Type: CHECK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE library.subscription
    ADD CONSTRAINT ch_date_subscribed CHECK ((date_subscribed <= now())) NOT VALID;


--
-- TOC entry 3289 (class 2606 OID 17662)
-- Name: write_off ch_full_price; Type: CHECK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE library.write_off
    ADD CONSTRAINT ch_full_price CHECK ((full_price > 0)) NOT VALID;


--
-- TOC entry 3275 (class 2606 OID 17663)
-- Name: reader ch_phone_number; Type: CHECK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE library.reader
    ADD CONSTRAINT ch_phone_number CHECK ((phone_number > 0)) NOT VALID;


--
-- TOC entry 3273 (class 2606 OID 17664)
-- Name: employee ch_phone_number; Type: CHECK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE library.employee
    ADD CONSTRAINT ch_phone_number CHECK ((phone_number > 0)) NOT VALID;


--
-- TOC entry 3267 (class 2606 OID 17665)
-- Name: card_index ch_publish_year; Type: CHECK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE library.card_index
    ADD CONSTRAINT ch_publish_year CHECK ((publish_year > 0)) NOT VALID;


--
-- TOC entry 3268 (class 2606 OID 17666)
-- Name: card_index ch_publisher_type; Type: CHECK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE library.card_index
    ADD CONSTRAINT ch_publisher_type CHECK (((publisher_type)::text = ANY (ARRAY[('Электронный'::character varying)::text, ('Печатный'::character varying)::text]))) NOT VALID;


--
-- TOC entry 3280 (class 2606 OID 17667)
-- Name: storage ch_rack_number; Type: CHECK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE library.storage
    ADD CONSTRAINT ch_rack_number CHECK ((rack_number > 0)) NOT VALID;


--
-- TOC entry 3281 (class 2606 OID 17668)
-- Name: storage ch_room_number; Type: CHECK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE library.storage
    ADD CONSTRAINT ch_room_number CHECK ((room_number > 0)) NOT VALID;


--
-- TOC entry 3282 (class 2606 OID 17669)
-- Name: storage ch_shelf_number; Type: CHECK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE library.storage
    ADD CONSTRAINT ch_shelf_number CHECK ((shelf_number > 0)) NOT VALID;


--
-- TOC entry 3269 (class 2606 OID 17670)
-- Name: copy ch_status; Type: CHECK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE library.copy
    ADD CONSTRAINT ch_status CHECK (((status)::text = ANY (ARRAY[('выданный'::character varying)::text, ('возвращенный'::character varying)::text, ('просроченный'::character varying)::text]))) NOT VALID;


--
-- TOC entry 3272 (class 2606 OID 17671)
-- Name: copy_storage ch_status; Type: CHECK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE library.copy_storage
    ADD CONSTRAINT ch_status CHECK (((status)::text = ANY (ARRAY[('выданный'::character varying)::text, ('возвращенный'::character varying)::text, ('просроченный'::character varying)::text]))) NOT VALID;


--
-- TOC entry 3286 (class 2606 OID 17672)
-- Name: subscription ch_status; Type: CHECK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE library.subscription
    ADD CONSTRAINT ch_status CHECK (((status)::text = ANY (ARRAY[('активный'::character varying)::text, ('неактивный'::character varying)::text, ('истекший'::character varying)::text]))) NOT VALID;


--
-- TOC entry 3265 (class 2606 OID 17673)
-- Name: book ch_volume_number; Type: CHECK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE library.book
    ADD CONSTRAINT ch_volume_number CHECK ((volume_number > 0)) NOT VALID;


--
-- TOC entry 3299 (class 2606 OID 17675)
-- Name: copy copy_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.copy
    ADD CONSTRAINT copy_pkey PRIMARY KEY (copy_id);


--
-- TOC entry 3301 (class 2606 OID 17677)
-- Name: copy_storage copy_storage_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.copy_storage
    ADD CONSTRAINT copy_storage_pkey PRIMARY KEY (copy_storage_id);


--
-- TOC entry 3303 (class 2606 OID 17679)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_id);


--
-- TOC entry 3305 (class 2606 OID 17681)
-- Name: incoming incoming_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.incoming
    ADD CONSTRAINT incoming_pkey PRIMARY KEY (incoming_id);


--
-- TOC entry 3307 (class 2606 OID 17683)
-- Name: publisher publisher_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.publisher
    ADD CONSTRAINT publisher_pkey PRIMARY KEY (publisher_id);


--
-- TOC entry 3309 (class 2606 OID 17685)
-- Name: reader reader_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.reader
    ADD CONSTRAINT reader_pkey PRIMARY KEY (reader_id);


--
-- TOC entry 3311 (class 2606 OID 17687)
-- Name: registered_reader registered_reader_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.registered_reader
    ADD CONSTRAINT registered_reader_pkey PRIMARY KEY (registered_reader_id);


--
-- TOC entry 3313 (class 2606 OID 17689)
-- Name: registering registering_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.registering
    ADD CONSTRAINT registering_pkey PRIMARY KEY (registering_id);


--
-- TOC entry 3315 (class 2606 OID 17691)
-- Name: replace_document replace_document_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.replace_document
    ADD CONSTRAINT replace_document_pkey PRIMARY KEY (replace_document_id);


--
-- TOC entry 3317 (class 2606 OID 17693)
-- Name: storage storage_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.storage
    ADD CONSTRAINT storage_pkey PRIMARY KEY (storage_id);


--
-- TOC entry 3321 (class 2606 OID 17695)
-- Name: subscription subscription_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.subscription
    ADD CONSTRAINT subscription_pkey PRIMARY KEY (subscription_id);


--
-- TOC entry 3323 (class 2606 OID 17697)
-- Name: supplier_invoice supplier_invoice_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.supplier_invoice
    ADD CONSTRAINT supplier_invoice_pkey PRIMARY KEY (supplier_invoice_id);


--
-- TOC entry 3295 (class 2606 OID 17699)
-- Name: book un_book; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.book
    ADD CONSTRAINT un_book UNIQUE (title, volume_number);


--
-- TOC entry 3319 (class 2606 OID 17701)
-- Name: storage un_storage; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.storage
    ADD CONSTRAINT un_storage UNIQUE (shelf_number, rack_number, room_number);


--
-- TOC entry 3325 (class 2606 OID 17703)
-- Name: write_off write_off_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.write_off
    ADD CONSTRAINT write_off_pkey PRIMARY KEY (write_off_id);


--
-- TOC entry 3297 (class 2606 OID 17705)
-- Name: card_index сard_Index_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.card_index
    ADD CONSTRAINT "сard_Index_pkey" PRIMARY KEY (card_index_id);


--
-- TOC entry 3331 (class 2606 OID 17706)
-- Name: employee affiliate_id_fkey; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.employee
    ADD CONSTRAINT affiliate_id_fkey FOREIGN KEY (affiliate_id) REFERENCES library.affiliate(affiliate_id) ON UPDATE CASCADE NOT VALID;


--
-- TOC entry 3326 (class 2606 OID 17711)
-- Name: card_index book_id_fkey; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.card_index
    ADD CONSTRAINT book_id_fkey FOREIGN KEY (book_id) REFERENCES library.book(book_id) ON UPDATE CASCADE NOT VALID;


--
-- TOC entry 3332 (class 2606 OID 17716)
-- Name: incoming copy_id_fkey; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.incoming
    ADD CONSTRAINT copy_id_fkey FOREIGN KEY (copy_id) REFERENCES library.copy(copy_id) ON UPDATE CASCADE NOT VALID;


--
-- TOC entry 3329 (class 2606 OID 17721)
-- Name: copy_storage copy_id_fkey; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.copy_storage
    ADD CONSTRAINT copy_id_fkey FOREIGN KEY (copy_id) REFERENCES library.copy(copy_id) ON UPDATE CASCADE NOT VALID;


--
-- TOC entry 3340 (class 2606 OID 17726)
-- Name: subscription copy_id_fkey; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.subscription
    ADD CONSTRAINT copy_id_fkey FOREIGN KEY (copy_id) REFERENCES library.copy(copy_id) ON UPDATE CASCADE NOT VALID;


--
-- TOC entry 3342 (class 2606 OID 17731)
-- Name: write_off copy_id_fkey; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.write_off
    ADD CONSTRAINT copy_id_fkey FOREIGN KEY (copy_id) REFERENCES library.copy(copy_id) ON UPDATE CASCADE NOT VALID;


--
-- TOC entry 3336 (class 2606 OID 17736)
-- Name: registering copy_id_fkey; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.registering
    ADD CONSTRAINT copy_id_fkey FOREIGN KEY (copy_id) REFERENCES library.copy(copy_id) ON UPDATE CASCADE NOT VALID;


--
-- TOC entry 3338 (class 2606 OID 17741)
-- Name: replace_document copy_id_fkey; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.replace_document
    ADD CONSTRAINT copy_id_fkey FOREIGN KEY (copy_id) REFERENCES library.copy(copy_id) ON UPDATE CASCADE NOT VALID;


--
-- TOC entry 3341 (class 2606 OID 17746)
-- Name: subscription employee_id_fkey; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.subscription
    ADD CONSTRAINT employee_id_fkey FOREIGN KEY (employee_id) REFERENCES library.employee(employee_id) ON UPDATE CASCADE NOT VALID;


--
-- TOC entry 3339 (class 2606 OID 17751)
-- Name: replace_document employee_id_fkey; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.replace_document
    ADD CONSTRAINT employee_id_fkey FOREIGN KEY (employee_id) REFERENCES library.employee(employee_id) ON UPDATE CASCADE NOT VALID;


--
-- TOC entry 3343 (class 2606 OID 17756)
-- Name: write_off employee_id_fkey; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.write_off
    ADD CONSTRAINT employee_id_fkey FOREIGN KEY (employee_id) REFERENCES library.employee(employee_id) ON UPDATE CASCADE NOT VALID;


--
-- TOC entry 3337 (class 2606 OID 17761)
-- Name: registering employee_id_fkey; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.registering
    ADD CONSTRAINT employee_id_fkey FOREIGN KEY (employee_id) REFERENCES library.employee(employee_id) ON UPDATE CASCADE NOT VALID;


--
-- TOC entry 3327 (class 2606 OID 17766)
-- Name: card_index incoming_id_fkey; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.card_index
    ADD CONSTRAINT incoming_id_fkey FOREIGN KEY (incoming_id) REFERENCES library.incoming(incoming_id) ON UPDATE CASCADE NOT VALID;


--
-- TOC entry 3328 (class 2606 OID 17771)
-- Name: card_index publisher_id_fkey; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.card_index
    ADD CONSTRAINT publisher_id_fkey FOREIGN KEY (publisher_id) REFERENCES library.publisher(publisher_id) ON UPDATE CASCADE NOT VALID;


--
-- TOC entry 3334 (class 2606 OID 17776)
-- Name: registered_reader reader_id_fkey; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.registered_reader
    ADD CONSTRAINT reader_id_fkey FOREIGN KEY (reader_id) REFERENCES library.reader(reader_id) ON UPDATE CASCADE NOT VALID;


--
-- TOC entry 3330 (class 2606 OID 17781)
-- Name: copy_storage storage_id_fkey; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.copy_storage
    ADD CONSTRAINT storage_id_fkey FOREIGN KEY (storage_id) REFERENCES library.storage(storage_id) ON UPDATE CASCADE NOT VALID;


--
-- TOC entry 3335 (class 2606 OID 17786)
-- Name: registered_reader subscription_id_fkey; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.registered_reader
    ADD CONSTRAINT subscription_id_fkey FOREIGN KEY (subscription_id) REFERENCES library.subscription(subscription_id) ON UPDATE CASCADE NOT VALID;


--
-- TOC entry 3333 (class 2606 OID 17791)
-- Name: incoming supplier_invoice_id_fkey; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.incoming
    ADD CONSTRAINT supplier_invoice_id_fkey FOREIGN KEY (supplier_invoice_id) REFERENCES library.supplier_invoice(supplier_invoice_id) ON UPDATE CASCADE NOT VALID;


-- Completed on 2023-05-29 15:44:35

--
-- PostgreSQL database dump complete
--

