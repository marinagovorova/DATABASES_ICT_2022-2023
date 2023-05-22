--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

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

DROP DATABASE bankdatabase;
--
-- Name: bankdatabase; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE bankdatabase WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';


\connect bankdatabase

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

SET default_table_access_method = heap;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.accounts (
    account_id bigint NOT NULL,
    user_id bigint NOT NULL,
    currency character varying(20) NOT NULL,
    bik bigint NOT NULL,
    korr_account bigint NOT NULL,
    inn bigint NOT NULL,
    kpp bigint NOT NULL,
    balance real DEFAULT 0,
    created_at timestamp without time zone DEFAULT now(),
    closed_at timestamp without time zone,
    CONSTRAINT accounts_account_id_check CHECK ((account_id > 0)),
    CONSTRAINT accounts_balance_check CHECK ((balance >= (0)::double precision)),
    CONSTRAINT accounts_bik_check CHECK ((bik > 0)),
    CONSTRAINT accounts_inn_check CHECK ((inn > 0)),
    CONSTRAINT accounts_korr_account_check CHECK ((korr_account > 0)),
    CONSTRAINT accounts_kpp_check CHECK ((kpp > 0)),
    CONSTRAINT accounts_user_id_check CHECK ((user_id > 0))
);

COMMENT ON TABLE public.accounts IS 'Счета';
COMMENT ON COLUMN public.accounts.user_id IS 'Клиент';
COMMENT ON COLUMN public.accounts.currency IS 'Валюта';
COMMENT ON COLUMN public.accounts.bik IS 'БИК';
COMMENT ON COLUMN public.accounts.korr_account IS 'Корр. счет';
COMMENT ON COLUMN public.accounts.inn IS 'ИНН';
COMMENT ON COLUMN public.accounts.kpp IS 'КПП';
COMMENT ON COLUMN public.accounts.balance IS 'Баланс';
COMMENT ON COLUMN public.accounts.created_at IS 'Дата открытия';
COMMENT ON COLUMN public.accounts.closed_at IS 'Дата закрытия';


--
-- Name: accounts_account_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.accounts_account_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: accounts_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.accounts_account_id_seq OWNED BY public.accounts.account_id;


--
-- Name: capitalizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.capitalizations (
    capitalization_id bigint NOT NULL,
    deposit_id bigint NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    money real NOT NULL,
    CONSTRAINT capitalizations_capitalization_id_check CHECK ((capitalization_id > 0)),
    CONSTRAINT capitalizations_deposit_id_check CHECK ((deposit_id > 0)),
    CONSTRAINT capitalizations_money_check CHECK ((money > (0)::double precision))
);

COMMENT ON TABLE public.capitalizations IS 'Операция капитализации вклада';
COMMENT ON COLUMN public.capitalizations.deposit_id IS 'Номер вклада';
COMMENT ON COLUMN public.capitalizations.created_at IS 'Дата и время операции';
COMMENT ON COLUMN public.capitalizations.money IS 'Сумма операции';


--
-- Name: capitalizations_capitalization_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.capitalizations_capitalization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: capitalizations_capitalization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.capitalizations_capitalization_id_seq OWNED BY public.capitalizations.capitalization_id;


--
-- Name: cards; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cards (
    card_number bigint NOT NULL,
    account_id bigint NOT NULL,
    payment_system_id bigint NOT NULL,
    type_of_card_id bigint NOT NULL,
    cvv integer NOT NULL,
    expiration_date date,
    CONSTRAINT cards_account_id_check CHECK ((account_id > 0)),
    CONSTRAINT cards_card_number_check CHECK ((card_number > 0)),
    CONSTRAINT cards_cvv_check CHECK ((cvv > 0)),
    CONSTRAINT cards_payment_system_id_check CHECK ((payment_system_id > 0)),
    CONSTRAINT cards_type_of_card_id_check CHECK ((type_of_card_id > 0))
);

COMMENT ON TABLE public.cards IS 'Дебетовые карты';
COMMENT ON COLUMN public.cards.card_number IS 'Номер карты';
COMMENT ON COLUMN public.cards.account_id IS 'Номер счета';
COMMENT ON COLUMN public.cards.payment_system_id IS 'Платежная система';
COMMENT ON COLUMN public.cards.type_of_card_id IS 'Вид карты';
COMMENT ON COLUMN public.cards.cvv IS 'CVV';
COMMENT ON COLUMN public.cards.expiration_date IS 'Срок действия';


--
-- Name: cards_card_number_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cards_card_number_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cards_card_number_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cards_card_number_seq OWNED BY public.cards.card_number;


--
-- Name: cash_turnover; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cash_turnover (
    cash_turnover_id bigint NOT NULL,
    card_number bigint NOT NULL,
    in_out boolean NOT NULL,
    nfc boolean NOT NULL,
    address character varying(500) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    money real NOT NULL,
    CONSTRAINT cash_turnover_card_number_check CHECK ((card_number > 0)),
    CONSTRAINT cash_turnover_id_check CHECK ((cash_turnover_id > 0)),
    CONSTRAINT cash_turnover_money_check CHECK ((money > (0)::double precision))
);

COMMENT ON TABLE public.cash_turnover IS 'Выдача/внесение наличных';
COMMENT ON COLUMN public.cash_turnover.card_number IS 'Номер карты';
COMMENT ON COLUMN public.cash_turnover.in_out IS 'Пополнение/снятие';
COMMENT ON COLUMN public.cash_turnover.nfc IS 'Использование NFC';
COMMENT ON COLUMN public.cash_turnover.address IS 'Адрес проведения операции';
COMMENT ON COLUMN public.cash_turnover.created_at IS 'Дата и время операции';
COMMENT ON COLUMN public.cash_turnover.money IS 'Сумма операции';


--
-- Name: cash_turnover_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cash_turnover_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cash_turnover_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cash_turnover_id_seq OWNED BY public.cash_turnover.cash_turnover_id;


--
-- Name: deposits; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.deposits (
    deposit_id bigint NOT NULL,
    account_id bigint NOT NULL,
    type_of_deposit_id bigint NOT NULL,
    expected_closing_date date NOT NULL,
    CONSTRAINT deposits_account_id_check CHECK ((account_id > 0)),
    CONSTRAINT deposits_expected_closing_date_check CHECK ((expected_closing_date >= now())),
    CONSTRAINT deposits_id_check CHECK ((deposit_id > 0)),
    CONSTRAINT deposits_type_of_deposit_id_check CHECK ((type_of_deposit_id > 0))
);

COMMENT ON TABLE public.deposits IS 'Вклады';
COMMENT ON COLUMN public.deposits.account_id IS 'Номер счета';
COMMENT ON COLUMN public.deposits.type_of_deposit_id IS 'Вид вклада';
COMMENT ON COLUMN public.deposits.expected_closing_date IS 'Срок вклада';


--
-- Name: deposits_deposit_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.deposits_deposit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: deposits_deposit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.deposits_deposit_id_seq OWNED BY public.deposits.deposit_id;


--
-- Name: payment_systems; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_systems (
    payment_system_id bigint NOT NULL,
    name character varying(100) NOT NULL,
    CONSTRAINT payment_systems_payment_system_id_check CHECK ((payment_system_id > 0))
);

COMMENT ON TABLE public.payment_systems IS 'Платежные системы';
COMMENT ON COLUMN public.payment_systems.name IS 'Название';


--
-- Name: payment_systems_payment_system_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payment_systems_payment_system_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payment_systems_payment_system_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payment_systems_payment_system_id_seq OWNED BY public.payment_systems.payment_system_id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payments (
    payment_id bigint NOT NULL,
    retail_outlet_id bigint NOT NULL,
    card_number bigint NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    money real NOT NULL,
    CONSTRAINT payments_card_number_check CHECK ((card_number > 0)),
    CONSTRAINT payments_money_check CHECK ((money > (0)::double precision)),
    CONSTRAINT payments_payment_id_check CHECK ((payment_id > 0)),
    CONSTRAINT payments_retail_outlet_id_check CHECK ((retail_outlet_id > 0))
);

COMMENT ON TABLE public.payments IS 'Оплата товаров и услуг';
COMMENT ON COLUMN public.payments.retail_outlet_id IS 'Торговая точка';
COMMENT ON COLUMN public.payments.card_number IS 'Номер карты';
COMMENT ON COLUMN public.payments.created_at IS 'Дата и время операции';
COMMENT ON COLUMN public.payments.money IS 'Сумма операции';


--
-- Name: payments_for_service; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payments_for_service (
    payment_for_service_id bigint NOT NULL,
    card_number bigint NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    money real NOT NULL,
    CONSTRAINT payments_for_service_card_number_check CHECK ((card_number > 0)),
    CONSTRAINT payments_for_service_money_check CHECK ((money > (0)::double precision)),
    CONSTRAINT payments_for_service_payment_for_service_id_check CHECK ((payment_for_service_id > 0))
);

COMMENT ON TABLE public.payments_for_service IS 'Операция платы за обслуживание';
COMMENT ON COLUMN public.payments_for_service.card_number IS 'Номер карты';
COMMENT ON COLUMN public.payments_for_service.created_at IS 'Дата и время операции';
COMMENT ON COLUMN public.payments_for_service.money IS 'Сумма операции';


--
-- Name: payments_for_service_payment_for_service_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payments_for_service_payment_for_service_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payments_for_service_payment_for_service_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payments_for_service_payment_for_service_id_seq OWNED BY public.payments_for_service.payment_for_service_id;


--
-- Name: payments_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payments_payment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payments_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payments_payment_id_seq OWNED BY public.payments.payment_id;


--
-- Name: remittances; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.remittances (
    remittance_id bigint NOT NULL,
    in_account bigint NOT NULL,
    out_account bigint NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    money real NOT NULL,
    CONSTRAINT remittances_in_account_check CHECK ((in_account > 0)),
    CONSTRAINT remittances_money_check CHECK ((money > (0)::double precision)),
    CONSTRAINT remittances_out_account_check CHECK ((out_account > 0)),
    CONSTRAINT remittances_remittance_id_check CHECK ((remittance_id > 0))
);

COMMENT ON TABLE public.remittances IS 'Переводы';
COMMENT ON COLUMN public.remittances.in_account IS 'Счет зачисления';
COMMENT ON COLUMN public.remittances.out_account IS 'Счет списания';
COMMENT ON COLUMN public.remittances.created_at IS 'Дата и время операции';
COMMENT ON COLUMN public.remittances.money IS 'Сумма операции';


--
-- Name: remittances_remittance_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.remittances_remittance_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: remittances_remittance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.remittances_remittance_id_seq OWNED BY public.remittances.remittance_id;


--
-- Name: retail_outlets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.retail_outlets (
    retail_outlet_id bigint NOT NULL,
    name character varying(100) NOT NULL,
    CONSTRAINT retail_outlets_retail_outlet_id_check CHECK ((retail_outlet_id > 0))
);

COMMENT ON TABLE public.retail_outlets IS 'Торговые точки';
COMMENT ON COLUMN public.retail_outlets.name IS 'Название';


--
-- Name: retail_outlets_retail_outlet_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.retail_outlets_retail_outlet_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: retail_outlets_retail_outlet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.retail_outlets_retail_outlet_id_seq OWNED BY public.retail_outlets.retail_outlet_id;


--
-- Name: types_of_cards; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.types_of_cards (
    type_of_card_id bigint NOT NULL,
    name character varying(100) NOT NULL,
    service_fee integer DEFAULT 0,
    CONSTRAINT types_of_cards_service_fee_check CHECK ((service_fee >= 0)),
    CONSTRAINT types_of_cards_type_of_card_id_check CHECK ((type_of_card_id > 0))
);

COMMENT ON TABLE public.types_of_cards IS 'Виды дебетовых карт';
COMMENT ON COLUMN public.types_of_cards.name IS 'Название';
COMMENT ON COLUMN public.types_of_cards.service_fee IS 'Плата за обслуживание';


--
-- Name: types_of_cards_type_of_card_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.types_of_cards_type_of_card_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: types_of_cards_type_of_card_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.types_of_cards_type_of_card_id_seq OWNED BY public.types_of_cards.type_of_card_id;


--
-- Name: types_of_deposits; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.types_of_deposits (
    type_of_deposit_id bigint NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(500) NOT NULL,
    percent integer NOT NULL,
    removable boolean NOT NULL,
    refillable boolean NOT NULL,
    minimal_period interval month NOT NULL,
    initial_balance bigint DEFAULT 0,
    CONSTRAINT types_of_deposits_initial_balance_check CHECK ((initial_balance >= 0)),
    CONSTRAINT types_of_deposits_percent_check CHECK ((percent > 0)),
    CONSTRAINT types_of_deposits_percent_check2 CHECK ((percent < 100)),
    CONSTRAINT types_of_deposits_type_of_deposit_id_check CHECK ((type_of_deposit_id > 0))
);

COMMENT ON TABLE public.types_of_deposits IS 'Виды вкладов';
COMMENT ON COLUMN public.types_of_deposits.name IS 'Название';
COMMENT ON COLUMN public.types_of_deposits.description IS 'Описание';
COMMENT ON COLUMN public.types_of_deposits.percent IS 'Начисляемый процент';
COMMENT ON COLUMN public.types_of_deposits.removable IS 'Частичное снятие';
COMMENT ON COLUMN public.types_of_deposits.refillable IS 'Пополнение';
COMMENT ON COLUMN public.types_of_deposits.minimal_period IS 'Минимальный срок';
COMMENT ON COLUMN public.types_of_deposits.initial_balance IS 'Минимальная сумма';


--
-- Name: types_of_deposits_type_of_deposit_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.types_of_deposits_type_of_deposit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: types_of_deposits_type_of_deposit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.types_of_deposits_type_of_deposit_id_seq OWNED BY public.types_of_deposits.type_of_deposit_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    user_id bigint NOT NULL,
    surname character varying(20) NOT NULL,
    firstname character varying(20) NOT NULL,
    patronymic character varying(20),
    birthday_at date NOT NULL,
    passport bigint NOT NULL,
    phone bigint NOT NULL,
    CONSTRAINT users_passport_check CHECK ((passport > 0)),
    CONSTRAINT users_phone_check CHECK ((phone > 0)),
    CONSTRAINT users_user_id_check CHECK ((user_id > 0))
);

COMMENT ON TABLE public.users IS 'Пользователи';
COMMENT ON COLUMN public.users.surname IS 'Фамилия';
COMMENT ON COLUMN public.users.firstname IS 'Имя';
COMMENT ON COLUMN public.users.patronymic IS 'Отчество';
COMMENT ON COLUMN public.users.birthday_at IS 'Дата рождения';
COMMENT ON COLUMN public.users.passport IS 'Серия и номер паспорта';
COMMENT ON COLUMN public.users.phone IS 'Номер телефона';


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: accounts account_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts ALTER COLUMN account_id SET DEFAULT nextval('public.accounts_account_id_seq'::regclass);


--
-- Name: capitalizations capitalization_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.capitalizations ALTER COLUMN capitalization_id SET DEFAULT nextval('public.capitalizations_capitalization_id_seq'::regclass);


--
-- Name: cards card_number; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cards ALTER COLUMN card_number SET DEFAULT nextval('public.cards_card_number_seq'::regclass);


--
-- Name: cash_turnover cash_turnover_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cash_turnover ALTER COLUMN cash_turnover_id SET DEFAULT nextval('public.cash_turnover_id_seq'::regclass);


--
-- Name: deposits deposit_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deposits ALTER COLUMN deposit_id SET DEFAULT nextval('public.deposits_deposit_id_seq'::regclass);


--
-- Name: payment_systems payment_system_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_systems ALTER COLUMN payment_system_id SET DEFAULT nextval('public.payment_systems_payment_system_id_seq'::regclass);


--
-- Name: payments payment_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments ALTER COLUMN payment_id SET DEFAULT nextval('public.payments_payment_id_seq'::regclass);


--
-- Name: payments_for_service payment_for_service_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments_for_service ALTER COLUMN payment_for_service_id SET DEFAULT nextval('public.payments_for_service_payment_for_service_id_seq'::regclass);


--
-- Name: remittances remittance_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.remittances ALTER COLUMN remittance_id SET DEFAULT nextval('public.remittances_remittance_id_seq'::regclass);


--
-- Name: retail_outlets retail_outlet_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.retail_outlets ALTER COLUMN retail_outlet_id SET DEFAULT nextval('public.retail_outlets_retail_outlet_id_seq'::regclass);


--
-- Name: types_of_cards type_of_card_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.types_of_cards ALTER COLUMN type_of_card_id SET DEFAULT nextval('public.types_of_cards_type_of_card_id_seq'::regclass);


--
-- Name: types_of_deposits type_of_deposit_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.types_of_deposits ALTER COLUMN type_of_deposit_id SET DEFAULT nextval('public.types_of_deposits_type_of_deposit_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.accounts (account_id, user_id, currency, bik, korr_account, inn, kpp, balance, created_at, closed_at) VALUES (8, 1008, 'RUB', 499891421, 767708826257377280, 8400231192, 712134374, 0, '2023-03-20 20:59:45.921653', NULL);
INSERT INTO public.accounts (account_id, user_id, currency, bik, korr_account, inn, kpp, balance, created_at, closed_at) VALUES (11, 1002, 'RUB', 292601058, 481120053472307200, 9411145356, 932626750, 0, '2023-03-20 20:59:45.921653', NULL);
INSERT INTO public.accounts (account_id, user_id, currency, bik, korr_account, inn, kpp, balance, created_at, closed_at) VALUES (5, 1005, 'RUB', 715100225, 184958250330902528, 1264561546, 604749868, 8178, '2023-03-20 20:59:45.921653', NULL);
INSERT INTO public.accounts (account_id, user_id, currency, bik, korr_account, inn, kpp, balance, created_at, closed_at) VALUES (1, 1001, 'RUB', 591731039, 346706729259860992, 1404612055, 260765666, 8228, '2023-03-20 20:59:45.921653', NULL);
INSERT INTO public.accounts (account_id, user_id, currency, bik, korr_account, inn, kpp, balance, created_at, closed_at) VALUES (4, 1004, 'RUB', 196242436, 227536073608902656, 5104831302, 571539492, 7948, '2023-03-20 20:59:45.921653', NULL);
INSERT INTO public.accounts (account_id, user_id, currency, bik, korr_account, inn, kpp, balance, created_at, closed_at) VALUES (7, 1007, 'RUB', 929291628, 776627963145224192, 7059468784, 118882167, 1362, '2023-03-20 20:59:45.921653', NULL);
INSERT INTO public.accounts (account_id, user_id, currency, bik, korr_account, inn, kpp, balance, created_at, closed_at) VALUES (3, 1003, 'RUB', 824449147, 352748740687090688, 1258368255, 682661582, 2882, '2023-03-20 20:59:45.921653', NULL);
INSERT INTO public.accounts (account_id, user_id, currency, bik, korr_account, inn, kpp, balance, created_at, closed_at) VALUES (12, 1005, 'RUB', 915962263, 276832715666973696, 1555084199, 180277873, 10, '2023-03-20 20:59:45.921653', NULL);
INSERT INTO public.accounts (account_id, user_id, currency, bik, korr_account, inn, kpp, balance, created_at, closed_at) VALUES (6, 1006, 'RUB', 105239847, 413554577544376321, 9748776026, 283810052, 2122, '2023-03-20 20:59:45.921653', NULL);
INSERT INTO public.accounts (account_id, user_id, currency, bik, korr_account, inn, kpp, balance, created_at, closed_at) VALUES (10, 1001, 'RUB', 184743352, 776627963145924192, 9920565600, 579837625, 9898, '2023-03-20 20:59:45.921653', NULL);
INSERT INTO public.accounts (account_id, user_id, currency, bik, korr_account, inn, kpp, balance, created_at, closed_at) VALUES (13, 1005, 'RUB', 182023823, 715698208383594496, 8033117404, 962073087, 2429, '2023-03-20 20:59:45.921653', NULL);
INSERT INTO public.accounts (account_id, user_id, currency, bik, korr_account, inn, kpp, balance, created_at, closed_at) VALUES (9, 1009, 'RUB', 564491538, 224519537363562496, 4163270577, 961499602, 4383, '2023-03-20 20:59:45.921653', NULL);
INSERT INTO public.accounts (account_id, user_id, currency, bik, korr_account, inn, kpp, balance, created_at, closed_at) VALUES (2, 1002, 'RUB', 567592410, 776627963145124192, 7693145261, 614293120, 1140, '2023-03-20 20:59:45.921653', NULL);
INSERT INTO public.accounts (account_id, user_id, currency, bik, korr_account, inn, kpp, balance, created_at, closed_at) VALUES (14, 1002, 'RUB', 246421530, 524734098810322944, 7750790048, 500106076, 0.0101170065, '2023-03-20 20:59:45.921653', NULL);
INSERT INTO public.accounts (account_id, user_id, currency, bik, korr_account, inn, kpp, balance, created_at, closed_at) VALUES (15, 1003, 'RUB', 985510713, 548534998839915520, 7681555595, 924725342, 10075.1875, '2023-03-20 20:59:45.921653', NULL);
INSERT INTO public.accounts (account_id, user_id, currency, bik, korr_account, inn, kpp, balance, created_at, closed_at) VALUES (16, 1003, 'RUB', 996388490, 145996352135976967, 5751759279, 595750776, 30376.564, '2023-03-20 20:59:45.921653', NULL);
INSERT INTO public.accounts (account_id, user_id, currency, bik, korr_account, inn, kpp, balance, created_at, closed_at) VALUES (17, 1004, 'RUB', 125499342, 774970428740290568, 4425790645, 339362742, 25187.969, '2023-03-20 20:59:45.921653', NULL);
INSERT INTO public.accounts (account_id, user_id, currency, bik, korr_account, inn, kpp, balance, created_at, closed_at) VALUES (18, 1004, 'RUB', 894654555, 534367697934728192, 6167889821, 784008799, 15188.282, '2023-03-20 20:59:45.921653', NULL);
INSERT INTO public.accounts (account_id, user_id, currency, bik, korr_account, inn, kpp, balance, created_at, closed_at) VALUES (19, 1004, 'RUB', 844284389, 758139909173454848, 7958829463, 985457131, 5088.011, '2023-03-20 20:59:45.921653', NULL);


--
-- Data for Name: capitalizations; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.capitalizations (capitalization_id, deposit_id, created_at, money) VALUES (1, 1, '2023-03-21 21:03:48.170912', 0.01);
INSERT INTO public.capitalizations (capitalization_id, deposit_id, created_at, money) VALUES (2, 2, '2023-03-21 21:03:48.170912', 25);
INSERT INTO public.capitalizations (capitalization_id, deposit_id, created_at, money) VALUES (3, 3, '2023-03-21 21:03:48.170912', 125);
INSERT INTO public.capitalizations (capitalization_id, deposit_id, created_at, money) VALUES (4, 4, '2023-03-21 21:03:48.170912', 62.5);
INSERT INTO public.capitalizations (capitalization_id, deposit_id, created_at, money) VALUES (5, 5, '2023-03-21 21:03:48.170912', 62.5);
INSERT INTO public.capitalizations (capitalization_id, deposit_id, created_at, money) VALUES (6, 6, '2023-03-21 21:03:48.170912', 29.166666);
INSERT INTO public.capitalizations (capitalization_id, deposit_id, created_at, money) VALUES (7, 1, '2023-03-21 21:03:52.823346', 5.833333e-05);
INSERT INTO public.capitalizations (capitalization_id, deposit_id, created_at, money) VALUES (8, 2, '2023-03-21 21:03:52.823346', 25.0625);
INSERT INTO public.capitalizations (capitalization_id, deposit_id, created_at, money) VALUES (9, 3, '2023-03-21 21:03:52.823346', 125.520836);
INSERT INTO public.capitalizations (capitalization_id, deposit_id, created_at, money) VALUES (10, 4, '2023-03-21 21:03:52.823346', 62.65625);
INSERT INTO public.capitalizations (capitalization_id, deposit_id, created_at, money) VALUES (11, 5, '2023-03-21 21:03:52.823346', 62.760418);
INSERT INTO public.capitalizations (capitalization_id, deposit_id, created_at, money) VALUES (12, 6, '2023-03-21 21:03:52.823346', 29.336805);
INSERT INTO public.capitalizations (capitalization_id, deposit_id, created_at, money) VALUES (13, 1, '2023-03-21 21:45:36.563468', 5.867361e-05);
INSERT INTO public.capitalizations (capitalization_id, deposit_id, created_at, money) VALUES (14, 2, '2023-03-21 21:45:36.563468', 25.125156);
INSERT INTO public.capitalizations (capitalization_id, deposit_id, created_at, money) VALUES (15, 3, '2023-03-21 21:45:36.563468', 126.04384);
INSERT INTO public.capitalizations (capitalization_id, deposit_id, created_at, money) VALUES (16, 4, '2023-03-21 21:45:36.563468', 62.81289);
INSERT INTO public.capitalizations (capitalization_id, deposit_id, created_at, money) VALUES (17, 5, '2023-03-21 21:45:36.563468', 63.02192);
INSERT INTO public.capitalizations (capitalization_id, deposit_id, created_at, money) VALUES (18, 6, '2023-03-21 21:45:36.563468', 29.507936);


--
-- Data for Name: cards; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.cards (card_number, account_id, payment_system_id, type_of_card_id, cvv, expiration_date) VALUES (4858443003042444, 1, 4, 11, 513, NULL);
INSERT INTO public.cards (card_number, account_id, payment_system_id, type_of_card_id, cvv, expiration_date) VALUES (4325492597540086, 10, 2, 5, 395, NULL);
INSERT INTO public.cards (card_number, account_id, payment_system_id, type_of_card_id, cvv, expiration_date) VALUES (4788927954158345, 2, 4, 10, 929, NULL);
INSERT INTO public.cards (card_number, account_id, payment_system_id, type_of_card_id, cvv, expiration_date) VALUES (4404394795473009, 11, 2, 11, 329, NULL);
INSERT INTO public.cards (card_number, account_id, payment_system_id, type_of_card_id, cvv, expiration_date) VALUES (4712227257286898, 3, 2, 1, 415, NULL);
INSERT INTO public.cards (card_number, account_id, payment_system_id, type_of_card_id, cvv, expiration_date) VALUES (4111194292302436, 4, 2, 1, 831, NULL);
INSERT INTO public.cards (card_number, account_id, payment_system_id, type_of_card_id, cvv, expiration_date) VALUES (5582651815776708, 5, 3, 4, 132, NULL);
INSERT INTO public.cards (card_number, account_id, payment_system_id, type_of_card_id, cvv, expiration_date) VALUES (4308268238089647, 12, 4, 9, 177, NULL);
INSERT INTO public.cards (card_number, account_id, payment_system_id, type_of_card_id, cvv, expiration_date) VALUES (5481196642315710, 13, 2, 10, 181, NULL);
INSERT INTO public.cards (card_number, account_id, payment_system_id, type_of_card_id, cvv, expiration_date) VALUES (6011008321403328, 6, 1, 7, 392, NULL);
INSERT INTO public.cards (card_number, account_id, payment_system_id, type_of_card_id, cvv, expiration_date) VALUES (5222830188437785, 7, 2, 1, 503, NULL);
INSERT INTO public.cards (card_number, account_id, payment_system_id, type_of_card_id, cvv, expiration_date) VALUES (5577386779412118, 8, 3, 8, 266, NULL);
INSERT INTO public.cards (card_number, account_id, payment_system_id, type_of_card_id, cvv, expiration_date) VALUES (4976693980888907, 9, 4, 7, 432, NULL);


--
-- Data for Name: cash_turnover; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.cash_turnover (cash_turnover_id, card_number, in_out, nfc, address, created_at, money) VALUES (1, 5481196642315710, true, true, 'Ap #625-4312 Enim Av.', '2023-03-21 23:01:16.093885', 6391);
INSERT INTO public.cash_turnover (cash_turnover_id, card_number, in_out, nfc, address, created_at, money) VALUES (2, 5222830188437785, true, false, '6907 Faucibus Av.', '2023-03-21 23:01:16.093885', 6124);
INSERT INTO public.cash_turnover (cash_turnover_id, card_number, in_out, nfc, address, created_at, money) VALUES (3, 4788927954158345, true, true, '780 Tellus Avenue', '2023-03-21 23:01:16.093885', 7860);
INSERT INTO public.cash_turnover (cash_turnover_id, card_number, in_out, nfc, address, created_at, money) VALUES (4, 6011008321403328, true, true, 'Ap #675-537 Molestie Avenue', '2023-03-21 23:01:16.093885', 5637);
INSERT INTO public.cash_turnover (cash_turnover_id, card_number, in_out, nfc, address, created_at, money) VALUES (5, 4712227257286898, true, false, 'Ap #783-6526 Non Road', '2023-03-21 23:01:16.093885', 9089);
INSERT INTO public.cash_turnover (cash_turnover_id, card_number, in_out, nfc, address, created_at, money) VALUES (6, 4111194292302436, true, true, 'Ap #983-2319 Luctus Ave', '2023-03-21 23:01:16.093885', 9448);
INSERT INTO public.cash_turnover (cash_turnover_id, card_number, in_out, nfc, address, created_at, money) VALUES (7, 4858443003042444, true, false, '500-820 Fermentum Ave', '2023-03-21 23:01:16.093885', 4028);
INSERT INTO public.cash_turnover (cash_turnover_id, card_number, in_out, nfc, address, created_at, money) VALUES (8, 4976693980888907, true, false, 'Ap #445-9720 Dignissim Ave', '2023-03-21 23:01:16.093885', 4288);
INSERT INTO public.cash_turnover (cash_turnover_id, card_number, in_out, nfc, address, created_at, money) VALUES (9, 5582651815776708, true, false, '2461 Eu Rd.', '2023-03-21 23:01:16.093885', 9678);
INSERT INTO public.cash_turnover (cash_turnover_id, card_number, in_out, nfc, address, created_at, money) VALUES (10, 4976693980888907, true, true, '6251 Tristique St.', '2023-03-21 23:01:16.093885', 6512);
INSERT INTO public.cash_turnover (cash_turnover_id, card_number, in_out, nfc, address, created_at, money) VALUES (11, 4976693980888907, false, true, '770-711 Fringilla. Rd.', '2023-03-21 23:01:16.093885', 477);
INSERT INTO public.cash_turnover (cash_turnover_id, card_number, in_out, nfc, address, created_at, money) VALUES (12, 4308268238089647, true, true, '444-5244 Fringilla Street', '2023-03-21 23:01:16.093885', 4240);
INSERT INTO public.cash_turnover (cash_turnover_id, card_number, in_out, nfc, address, created_at, money) VALUES (13, 5222830188437785, false, false, 'Ap #202-5701 Nec, Avenue', '2023-03-21 23:01:16.093885', 3499);
INSERT INTO public.cash_turnover (cash_turnover_id, card_number, in_out, nfc, address, created_at, money) VALUES (14, 6011008321403328, false, false, '405-6302 Natoque St.', '2023-03-21 23:01:16.093885', 2447);
INSERT INTO public.cash_turnover (cash_turnover_id, card_number, in_out, nfc, address, created_at, money) VALUES (15, 4788927954158345, true, true, '643-1299 Donec Av.', '2023-03-21 23:01:16.093885', 7893);


--
-- Data for Name: deposits; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.deposits (deposit_id, account_id, type_of_deposit_id, expected_closing_date) VALUES (1, 14, 2, '2023-06-20');
INSERT INTO public.deposits (deposit_id, account_id, type_of_deposit_id, expected_closing_date) VALUES (2, 15, 3, '2025-03-20');
INSERT INTO public.deposits (deposit_id, account_id, type_of_deposit_id, expected_closing_date) VALUES (3, 16, 1, '2024-03-20');
INSERT INTO public.deposits (deposit_id, account_id, type_of_deposit_id, expected_closing_date) VALUES (4, 17, 3, '2026-03-20');
INSERT INTO public.deposits (deposit_id, account_id, type_of_deposit_id, expected_closing_date) VALUES (5, 18, 1, '2023-06-20');
INSERT INTO public.deposits (deposit_id, account_id, type_of_deposit_id, expected_closing_date) VALUES (6, 19, 2, '2023-04-20');


--
-- Data for Name: payment_systems; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.payment_systems (payment_system_id, name) VALUES (1, 'Maestro');
INSERT INTO public.payment_systems (payment_system_id, name) VALUES (2, 'МИР');
INSERT INTO public.payment_systems (payment_system_id, name) VALUES (3, 'MasterCard');
INSERT INTO public.payment_systems (payment_system_id, name) VALUES (4, 'VISA');


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.payments (payment_id, retail_outlet_id, card_number, created_at, money) VALUES (1, 4, 5222830188437785, '2023-03-21 23:55:46.311901', 1263);
INSERT INTO public.payments (payment_id, retail_outlet_id, card_number, created_at, money) VALUES (2, 3, 4712227257286898, '2023-03-21 23:56:35.386301', 1707);
INSERT INTO public.payments (payment_id, retail_outlet_id, card_number, created_at, money) VALUES (3, 3, 4308268238089647, '2023-03-21 23:57:08.35444', 3830);
INSERT INTO public.payments (payment_id, retail_outlet_id, card_number, created_at, money) VALUES (4, 4, 6011008321403328, '2023-03-21 23:58:08.844465', 1868);
INSERT INTO public.payments (payment_id, retail_outlet_id, card_number, created_at, money) VALUES (5, 3, 4325492597540086, '2023-03-21 23:58:49.997165', 1602);
INSERT INTO public.payments (payment_id, retail_outlet_id, card_number, created_at, money) VALUES (6, 3, 5481196642315710, '2023-03-21 23:59:59.378677', 3882);
INSERT INTO public.payments (payment_id, retail_outlet_id, card_number, created_at, money) VALUES (7, 2, 4976693980888907, '2023-03-22 00:00:46.190846', 1240);
INSERT INTO public.payments (payment_id, retail_outlet_id, card_number, created_at, money) VALUES (8, 3, 4788927954158345, '2023-03-22 00:01:30.711293', 4533);


--
-- Data for Name: payments_for_service; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.payments_for_service (payment_for_service_id, card_number, created_at, money) VALUES (1, 4858443003042444, '2023-03-21 23:09:49.433517', 150);
INSERT INTO public.payments_for_service (payment_for_service_id, card_number, created_at, money) VALUES (2, 4788927954158345, '2023-03-21 23:09:49.433517', 40);
INSERT INTO public.payments_for_service (payment_for_service_id, card_number, created_at, money) VALUES (3, 5582651815776708, '2023-03-21 23:09:49.433517', 1000);
INSERT INTO public.payments_for_service (payment_for_service_id, card_number, created_at, money) VALUES (4, 4308268238089647, '2023-03-21 23:09:49.433517', 200);
INSERT INTO public.payments_for_service (payment_for_service_id, card_number, created_at, money) VALUES (5, 5481196642315710, '2023-03-21 23:09:49.433517', 40);
INSERT INTO public.payments_for_service (payment_for_service_id, card_number, created_at, money) VALUES (6, 6011008321403328, '2023-03-21 23:09:49.433517', 850);
INSERT INTO public.payments_for_service (payment_for_service_id, card_number, created_at, money) VALUES (7, 4976693980888907, '2023-03-21 23:09:49.433517', 850);
INSERT INTO public.payments_for_service (payment_for_service_id, card_number, created_at, money) VALUES (8, 4858443003042444, '2023-03-21 23:10:18.454695', 150);
INSERT INTO public.payments_for_service (payment_for_service_id, card_number, created_at, money) VALUES (9, 4788927954158345, '2023-03-21 23:10:18.454695', 40);
INSERT INTO public.payments_for_service (payment_for_service_id, card_number, created_at, money) VALUES (10, 5582651815776708, '2023-03-21 23:10:18.454695', 1000);
INSERT INTO public.payments_for_service (payment_for_service_id, card_number, created_at, money) VALUES (11, 4308268238089647, '2023-03-21 23:10:18.454695', 200);
INSERT INTO public.payments_for_service (payment_for_service_id, card_number, created_at, money) VALUES (12, 5481196642315710, '2023-03-21 23:10:18.454695', 40);
INSERT INTO public.payments_for_service (payment_for_service_id, card_number, created_at, money) VALUES (13, 6011008321403328, '2023-03-21 23:10:18.454695', 850);
INSERT INTO public.payments_for_service (payment_for_service_id, card_number, created_at, money) VALUES (14, 4976693980888907, '2023-03-21 23:10:18.454695', 850);


--
-- Data for Name: remittances; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.remittances (remittance_id, in_account, out_account, created_at, money) VALUES (1, 10, 2, '2023-03-21 23:33:48.567741', 10000);
INSERT INTO public.remittances (remittance_id, in_account, out_account, created_at, money) VALUES (2, 5, 6, '2023-03-21 23:33:48.567741', 500);
INSERT INTO public.remittances (remittance_id, in_account, out_account, created_at, money) VALUES (3, 6, 9, '2023-03-21 23:33:48.567741', 3000);
INSERT INTO public.remittances (remittance_id, in_account, out_account, created_at, money) VALUES (4, 1, 3, '2023-03-21 23:33:48.567741', 4500);
INSERT INTO public.remittances (remittance_id, in_account, out_account, created_at, money) VALUES (5, 10, 4, '2023-03-21 23:33:48.567741', 1500);


--
-- Data for Name: retail_outlets; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.retail_outlets (retail_outlet_id, name) VALUES (1, 'Пятерочка');
INSERT INTO public.retail_outlets (retail_outlet_id, name) VALUES (2, 'Лента');
INSERT INTO public.retail_outlets (retail_outlet_id, name) VALUES (3, 'Магнит');
INSERT INTO public.retail_outlets (retail_outlet_id, name) VALUES (4, 'Перекресток');
INSERT INTO public.retail_outlets (retail_outlet_id, name) VALUES (5, 'Дикси');


--
-- Data for Name: types_of_cards; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.types_of_cards (type_of_card_id, name, service_fee) VALUES (1, 'СберКарта Мир для пособий и пенсии', 0);
INSERT INTO public.types_of_cards (type_of_card_id, name, service_fee) VALUES (2, 'Детская СберКарта', 0);
INSERT INTO public.types_of_cards (type_of_card_id, name, service_fee) VALUES (3, 'СберКарта для иностранцев', 150);
INSERT INTO public.types_of_cards (type_of_card_id, name, service_fee) VALUES (4, 'Премиальная карта аэрофлота', 1000);
INSERT INTO public.types_of_cards (type_of_card_id, name, service_fee) VALUES (5, 'Классическая карта Подари жизнь', 40);
INSERT INTO public.types_of_cards (type_of_card_id, name, service_fee) VALUES (6, 'Золотая карта Подари жизнь', 300);
INSERT INTO public.types_of_cards (type_of_card_id, name, service_fee) VALUES (7, 'Платиновая карта Подари жизнь', 850);
INSERT INTO public.types_of_cards (type_of_card_id, name, service_fee) VALUES (8, 'Карта болельщика ЦСКА', 60);
INSERT INTO public.types_of_cards (type_of_card_id, name, service_fee) VALUES (9, 'СберКарта Тревел', 200);
INSERT INTO public.types_of_cards (type_of_card_id, name, service_fee) VALUES (10, 'Молодежная карта СберКарта', 40);
INSERT INTO public.types_of_cards (type_of_card_id, name, service_fee) VALUES (11, 'СберКарта', 150);


--
-- Data for Name: types_of_deposits; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.types_of_deposits (type_of_deposit_id, name, description, percent, removable, refillable, minimal_period, initial_balance) VALUES (1, 'Управляй+', 'Пополняйте и снимайте деньги до неснижаемого остатка в любое время, проценты при 
этом сохранятся. Начисленные проценты можно снять или перечислить на карту. Если 
оставлять проценты на вкладе, то каждый месяц они прибавляются к общей сумме и 
увеличивают доход в следующих периодах.', 5, true, true, '3 mons', 30000);
INSERT INTO public.types_of_deposits (type_of_deposit_id, name, description, percent, removable, refillable, minimal_period, initial_balance) VALUES (2, 'Накопительный счет', 'Копите и свободно распоряжайтесь деньгами — ежемесячное начисление процентов, 
возможность пополнять и снимать без ограничений. Для новых пользователей 
повышенная ставка.', 7, true, true, '00:00:00', 0);
INSERT INTO public.types_of_deposits (type_of_deposit_id, name, description, percent, removable, refillable, minimal_period, initial_balance) VALUES (3, 'Вклад Подари жизнь', 'Возможность помочь детям с тяжёлыми заболеваниями', 3, false, false, '1 year', 10000);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users (user_id, surname, firstname, patronymic, birthday_at, passport, phone) VALUES (1001, 'Григорьев', 'Егор', 'Львович', '1988-09-16', 8141632463, 70686825877);
INSERT INTO public.users (user_id, surname, firstname, patronymic, birthday_at, passport, phone) VALUES (1002, 'Николаева', 'София', 'Егоровна', '2007-08-10', 9254963741, 77005816892);
INSERT INTO public.users (user_id, surname, firstname, patronymic, birthday_at, passport, phone) VALUES (1003, 'Морозов', 'Максим', 'Артемьевич', '1977-05-01', 9665584463, 72447851910);
INSERT INTO public.users (user_id, surname, firstname, patronymic, birthday_at, passport, phone) VALUES (1004, 'Михайлова', 'Софья', 'Артемовна', '1971-05-24', 4719688424, 78747282322);
INSERT INTO public.users (user_id, surname, firstname, patronymic, birthday_at, passport, phone) VALUES (1005, 'Мельникова', 'Екатерина', 'Романовна', '1998-03-23', 1198152222, 74534179935);
INSERT INTO public.users (user_id, surname, firstname, patronymic, birthday_at, passport, phone) VALUES (1006, 'Волков', 'Григорий', 'Михайлович', '1985-10-10', 5288425315, 74576244992);
INSERT INTO public.users (user_id, surname, firstname, patronymic, birthday_at, passport, phone) VALUES (1007, 'Лазарев', 'Мирослав', 'Тихонович', '1975-11-10', 3245906119, 70820335928);
INSERT INTO public.users (user_id, surname, firstname, patronymic, birthday_at, passport, phone) VALUES (1008, 'Дубровин', 'Макар', 'Адамович', '1997-03-20', 6536728832, 73463017584);
INSERT INTO public.users (user_id, surname, firstname, patronymic, birthday_at, passport, phone) VALUES (1009, 'Леонтьева', 'Елизавета', 'Петровна', '1978-10-28', 2543791757, 73464657584);


--
-- Name: accounts_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.accounts_account_id_seq', 1, false);


--
-- Name: capitalizations_capitalization_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.capitalizations_capitalization_id_seq', 18, true);


--
-- Name: cards_card_number_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cards_card_number_seq', 1, false);


--
-- Name: cash_turnover_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cash_turnover_id_seq', 15, true);


--
-- Name: deposits_deposit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.deposits_deposit_id_seq', 1, false);


--
-- Name: payment_systems_payment_system_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.payment_systems_payment_system_id_seq', 1, false);


--
-- Name: payments_for_service_payment_for_service_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.payments_for_service_payment_for_service_id_seq', 14, true);


--
-- Name: payments_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.payments_payment_id_seq', 8, true);


--
-- Name: remittances_remittance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.remittances_remittance_id_seq', 5, true);


--
-- Name: retail_outlets_retail_outlet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.retail_outlets_retail_outlet_id_seq', 1, false);


--
-- Name: types_of_cards_type_of_card_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.types_of_cards_type_of_card_id_seq', 1, false);


--
-- Name: types_of_deposits_type_of_deposit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.types_of_deposits_type_of_deposit_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);


--
-- Name: accounts pk_account_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT pk_account_id PRIMARY KEY (account_id);


--
-- Name: capitalizations pk_capitalization_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.capitalizations
    ADD CONSTRAINT pk_capitalization_id PRIMARY KEY (capitalization_id);


--
-- Name: cards pk_card_number; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT pk_card_number PRIMARY KEY (card_number);


--
-- Name: cash_turnover pk_cash_turnover_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cash_turnover
    ADD CONSTRAINT pk_cash_turnover_id PRIMARY KEY (cash_turnover_id);


--
-- Name: deposits pk_deposit_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deposits
    ADD CONSTRAINT pk_deposit_id PRIMARY KEY (deposit_id);


--
-- Name: payments_for_service pk_payment_for_service_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments_for_service
    ADD CONSTRAINT pk_payment_for_service_id PRIMARY KEY (payment_for_service_id);


--
-- Name: payments pk_payment_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT pk_payment_id PRIMARY KEY (payment_id);


--
-- Name: payment_systems pk_payment_system_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_systems
    ADD CONSTRAINT pk_payment_system_id PRIMARY KEY (payment_system_id);


--
-- Name: remittances pk_remittance_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.remittances
    ADD CONSTRAINT pk_remittance_id PRIMARY KEY (remittance_id);


--
-- Name: retail_outlets pk_retail_outlet_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.retail_outlets
    ADD CONSTRAINT pk_retail_outlet_id PRIMARY KEY (retail_outlet_id);


--
-- Name: types_of_cards pk_type_of_card_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.types_of_cards
    ADD CONSTRAINT pk_type_of_card_id PRIMARY KEY (type_of_card_id);


--
-- Name: types_of_deposits pk_type_of_deposit_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.types_of_deposits
    ADD CONSTRAINT pk_type_of_deposit_id PRIMARY KEY (type_of_deposit_id);


--
-- Name: users pk_user_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT pk_user_id PRIMARY KEY (user_id);


--
-- Name: cards fk_account_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT fk_account_id FOREIGN KEY (account_id) REFERENCES public.accounts(account_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: deposits fk_account_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deposits
    ADD CONSTRAINT fk_account_id FOREIGN KEY (account_id) REFERENCES public.accounts(account_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: cash_turnover fk_card_number; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cash_turnover
    ADD CONSTRAINT fk_card_number FOREIGN KEY (card_number) REFERENCES public.cards(card_number) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: payments fk_card_number; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_card_number FOREIGN KEY (card_number) REFERENCES public.cards(card_number) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: payments_for_service fk_card_number; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments_for_service
    ADD CONSTRAINT fk_card_number FOREIGN KEY (card_number) REFERENCES public.cards(card_number) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: capitalizations fk_deposit_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.capitalizations
    ADD CONSTRAINT fk_deposit_id FOREIGN KEY (deposit_id) REFERENCES public.deposits(deposit_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: remittances fk_in_account; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.remittances
    ADD CONSTRAINT fk_in_account FOREIGN KEY (in_account) REFERENCES public.accounts(account_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: remittances fk_out_account; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.remittances
    ADD CONSTRAINT fk_out_account FOREIGN KEY (out_account) REFERENCES public.accounts(account_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: cards fk_payment_system_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT fk_payment_system_id FOREIGN KEY (payment_system_id) REFERENCES public.payment_systems(payment_system_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: payments fk_retail_outlet_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_retail_outlet_id FOREIGN KEY (retail_outlet_id) REFERENCES public.retail_outlets(retail_outlet_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: cards fk_type_of_card_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT fk_type_of_card_id FOREIGN KEY (type_of_card_id) REFERENCES public.types_of_cards(type_of_card_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: deposits fk_type_of_deposit_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deposits
    ADD CONSTRAINT fk_type_of_deposit_id FOREIGN KEY (type_of_deposit_id) REFERENCES public.types_of_deposits(type_of_deposit_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: accounts fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

