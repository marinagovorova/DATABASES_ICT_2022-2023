--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7
-- Dumped by pg_dump version 14.7

-- Started on 2023-03-06 22:17:35

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
-- TOC entry 5 (class 2615 OID 16395)
-- Name: Restaurant_schema; Type: SCHEMA; Schema: -; Owner: diana
--

CREATE SCHEMA "Restaurant_schema";


ALTER SCHEMA "Restaurant_schema" OWNER TO diana;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 16412)
-- Name: Booking; Type: TABLE; Schema: Restaurant_schema; Owner: diana
--

CREATE TABLE "Restaurant_schema"."Booking" (
    booking_number integer NOT NULL,
    table_number integer NOT NULL,
    client_phone_num bigint NOT NULL,
    booking_date date NOT NULL,
    booking_time_from time(6) without time zone NOT NULL,
    booking_time_to time(6) without time zone,
    client_name character varying(15) NOT NULL,
    CONSTRAINT booking_check_1 CHECK ((booking_number > 0)),
    CONSTRAINT booking_check_11 CHECK (((client_name)::text ~ similar_to_escape('[А-ЯЁ]%'::text))),
    CONSTRAINT booking_check_3 CHECK ((client_phone_num > 0)),
    CONSTRAINT booking_check_5 CHECK (((booking_time_from >= '09:00:00'::time without time zone) AND (booking_time_from <= '22:00:00'::time without time zone))),
    CONSTRAINT booking_check_6 CHECK (((booking_time_to - booking_time_from) >= '00:45:00'::interval))
);


ALTER TABLE "Restaurant_schema"."Booking" OWNER TO diana;

--
-- TOC entry 223 (class 1259 OID 16550)
-- Name: Booking_booking_number_seq; Type: SEQUENCE; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE "Restaurant_schema"."Booking" ALTER COLUMN booking_number ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Restaurant_schema"."Booking_booking_number_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 217 (class 1259 OID 16500)
-- Name: Cooking_dish; Type: TABLE; Schema: Restaurant_schema; Owner: diana
--

CREATE TABLE "Restaurant_schema"."Cooking_dish" (
    id_employee integer NOT NULL,
    id_dish integer NOT NULL
);


ALTER TABLE "Restaurant_schema"."Cooking_dish" OWNER TO diana;

--
-- TOC entry 216 (class 1259 OID 16493)
-- Name: Dish; Type: TABLE; Schema: Restaurant_schema; Owner: diana
--

CREATE TABLE "Restaurant_schema"."Dish" (
    id_dish integer NOT NULL,
    dish_name character varying(40) NOT NULL,
    dish_category character varying(30) NOT NULL,
    dish_cost numeric(7,2) NOT NULL,
    dish_mass character varying(10),
    technological_card bytea,
    CONSTRAINT dish_check_1 CHECK ((id_dish > 0)),
    CONSTRAINT "dish_check_2 " CHECK ((dish_cost > (0)::numeric)),
    CONSTRAINT dish_check_3 CHECK (((dish_name)::text ~ similar_to_escape('[А-ЯЁ]%'::text))),
    CONSTRAINT dish_check_4 CHECK (((dish_category)::text ~ similar_to_escape('[А-ЯЁ]%'::text)))
);


ALTER TABLE "Restaurant_schema"."Dish" OWNER TO diana;

--
-- TOC entry 219 (class 1259 OID 16520)
-- Name: Dish_components; Type: TABLE; Schema: Restaurant_schema; Owner: diana
--

CREATE TABLE "Restaurant_schema"."Dish_components" (
    id_dish integer NOT NULL,
    id_ingredient integer NOT NULL,
    ingredient_volume character varying(20) NOT NULL,
    caloric_content_of_the_dish numeric(7,2),
    CONSTRAINT components_check_3 CHECK ((caloric_content_of_the_dish > (0)::numeric))
);


ALTER TABLE "Restaurant_schema"."Dish_components" OWNER TO diana;

--
-- TOC entry 224 (class 1259 OID 16563)
-- Name: Dish_id_dish_seq; Type: SEQUENCE; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE "Restaurant_schema"."Dish" ALTER COLUMN id_dish ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Restaurant_schema"."Dish_id_dish_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 213 (class 1259 OID 16441)
-- Name: Employee; Type: TABLE; Schema: Restaurant_schema; Owner: diana
--

CREATE TABLE "Restaurant_schema"."Employee" (
    id_employee integer NOT NULL,
    passport bigint NOT NULL,
    name character varying(15) NOT NULL,
    surname character varying(20) NOT NULL,
    patronymic character varying(20),
    id_post integer NOT NULL,
    CONSTRAINT employee_check_1 CHECK ((id_employee > 0)),
    CONSTRAINT employee_check_2 CHECK (((passport > 0) AND (passport < '10000000000'::bigint))),
    CONSTRAINT employee_check_3 CHECK (((name)::text ~ similar_to_escape('[А-ЯЁ]%'::text))),
    CONSTRAINT employee_check_4 CHECK (((surname)::text ~ similar_to_escape('[А-ЯЁ]%'::text))),
    CONSTRAINT employee_check_5 CHECK (((patronymic)::text ~ similar_to_escape('[А-ЯЁ]%'::text)))
);


ALTER TABLE "Restaurant_schema"."Employee" OWNER TO diana;

--
-- TOC entry 222 (class 1259 OID 16546)
-- Name: Employee_id_employee_seq; Type: SEQUENCE; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE "Restaurant_schema"."Employee" ALTER COLUMN id_employee ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Restaurant_schema"."Employee_id_employee_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 16515)
-- Name: Ingredient; Type: TABLE; Schema: Restaurant_schema; Owner: diana
--

CREATE TABLE "Restaurant_schema"."Ingredient" (
    id_ingredient integer NOT NULL,
    ingredient_name character varying(50) NOT NULL,
    expiration_date character varying(50) NOT NULL,
    ingredient_type character varying(50) NOT NULL,
    calorie_content_per_100_gr numeric(7,2),
    stock_balance character varying(20) NOT NULL,
    CONSTRAINT ingredient_check_1 CHECK ((id_ingredient > 0)),
    CONSTRAINT ingredient_check_2 CHECK ((calorie_content_per_100_gr > (0)::numeric)),
    CONSTRAINT ingredient_check_3 CHECK (((ingredient_name)::text ~ similar_to_escape('[А-ЯЁ]%'::text))),
    CONSTRAINT ingredient_check_4 CHECK (((ingredient_type)::text ~ similar_to_escape('[А-ЯЁ]%'::text)))
);


ALTER TABLE "Restaurant_schema"."Ingredient" OWNER TO diana;

--
-- TOC entry 227 (class 1259 OID 16609)
-- Name: Ingredient_id_ingredient_seq; Type: SEQUENCE; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE "Restaurant_schema"."Ingredient" ALTER COLUMN id_ingredient ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Restaurant_schema"."Ingredient_id_ingredient_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 215 (class 1259 OID 16458)
-- Name: Order; Type: TABLE; Schema: Restaurant_schema; Owner: diana
--

CREATE TABLE "Restaurant_schema"."Order" (
    id_order integer NOT NULL,
    id_employee integer NOT NULL,
    date_order date NOT NULL,
    status_order character varying(11) NOT NULL,
    price_order numeric(9,2) NOT NULL,
    table_number integer NOT NULL,
    CONSTRAINT order_check_1 CHECK ((price_order > (0)::numeric)),
    CONSTRAINT order_check_4 CHECK ((id_order > 0)),
    CONSTRAINT order_check_5 CHECK (((status_order)::text = ANY ((ARRAY['accepted'::character varying, 'in progress'::character varying, 'paid'::character varying])::text[])))
);


ALTER TABLE "Restaurant_schema"."Order" OWNER TO diana;

--
-- TOC entry 229 (class 1259 OID 16664)
-- Name: Order_fulfillment; Type: TABLE; Schema: Restaurant_schema; Owner: diana
--

CREATE TABLE "Restaurant_schema"."Order_fulfillment" (
    id_dish integer NOT NULL,
    id_order integer NOT NULL,
    id_employee integer NOT NULL,
    ready_status character varying(10) NOT NULL,
    order_notes text,
    CONSTRAINT order_ful_check_1 CHECK (((ready_status)::text = ANY ((ARRAY['в процессе'::character varying, 'готов'::character varying])::text[])))
);


ALTER TABLE "Restaurant_schema"."Order_fulfillment" OWNER TO diana;

--
-- TOC entry 221 (class 1259 OID 16545)
-- Name: Order_id_order_seq; Type: SEQUENCE; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE "Restaurant_schema"."Order" ALTER COLUMN id_order ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Restaurant_schema"."Order_id_order_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 214 (class 1259 OID 16446)
-- Name: Post; Type: TABLE; Schema: Restaurant_schema; Owner: diana
--

CREATE TABLE "Restaurant_schema"."Post" (
    id_post integer NOT NULL,
    post_name character varying(50) NOT NULL,
    qualific_requirements text NOT NULL,
    job_responsibilities text NOT NULL,
    salary numeric(9,2) NOT NULL,
    CONSTRAINT "post_check_1 " CHECK ((id_post > 0)),
    CONSTRAINT post_check_2 CHECK ((salary > (0)::numeric)),
    CONSTRAINT post_check_3 CHECK (((post_name)::text ~ similar_to_escape('[А-ЯЁ]%'::text)))
);


ALTER TABLE "Restaurant_schema"."Post" OWNER TO diana;

--
-- TOC entry 225 (class 1259 OID 16594)
-- Name: Post_id_post_seq; Type: SEQUENCE; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE "Restaurant_schema"."Post" ALTER COLUMN id_post ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Restaurant_schema"."Post_id_post_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 16535)
-- Name: Purchase; Type: TABLE; Schema: Restaurant_schema; Owner: diana
--

CREATE TABLE "Restaurant_schema"."Purchase" (
    id_purchase integer NOT NULL,
    id_ingredient integer NOT NULL,
    provider character varying(24) NOT NULL,
    purchase_date date NOT NULL,
    ingredient_price numeric(8,2) NOT NULL,
    stock_balance_from_purchase character varying(20) NOT NULL,
    purchase_volume character varying(20) NOT NULL,
    CONSTRAINT purchase_check_1 CHECK ((id_purchase > 0)),
    CONSTRAINT purchase_check_2 CHECK (((provider)::text ~ similar_to_escape('[А-ЯЁ]%'::text))),
    CONSTRAINT purchase_check_3 CHECK ((ingredient_price > (0)::numeric))
);


ALTER TABLE "Restaurant_schema"."Purchase" OWNER TO diana;

--
-- TOC entry 228 (class 1259 OID 16612)
-- Name: Purchase_id_purchase_seq; Type: SEQUENCE; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE "Restaurant_schema"."Purchase" ALTER COLUMN id_purchase ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Restaurant_schema"."Purchase_id_purchase_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 212 (class 1259 OID 16436)
-- Name: Shift; Type: TABLE; Schema: Restaurant_schema; Owner: diana
--

CREATE TABLE "Restaurant_schema"."Shift" (
    id_shift integer NOT NULL,
    shift_date date NOT NULL,
    start_time time(6) without time zone NOT NULL,
    end_time time(6) without time zone NOT NULL,
    CONSTRAINT shift_check_1 CHECK ((id_shift > 0)),
    CONSTRAINT shift_check_3 CHECK ((start_time >= '09:00:00'::time without time zone)),
    CONSTRAINT shift_check_4 CHECK ((((end_time - start_time) <= '10:00:00'::interval) AND ((end_time - start_time) >= '05:00:00'::interval) AND (end_time <= '23:45:00'::time without time zone)))
);


ALTER TABLE "Restaurant_schema"."Shift" OWNER TO diana;

--
-- TOC entry 230 (class 1259 OID 16687)
-- Name: Shift_allocation; Type: TABLE; Schema: Restaurant_schema; Owner: postgres
--

CREATE TABLE "Restaurant_schema"."Shift_allocation" (
    id_shift integer NOT NULL,
    id_employee integer NOT NULL,
    table_number integer NOT NULL
);


ALTER TABLE "Restaurant_schema"."Shift_allocation" OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16602)
-- Name: Shift_id_shift_seq; Type: SEQUENCE; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE "Restaurant_schema"."Shift" ALTER COLUMN id_shift ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Restaurant_schema"."Shift_id_shift_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 211 (class 1259 OID 16417)
-- Name: Table; Type: TABLE; Schema: Restaurant_schema; Owner: diana
--

CREATE TABLE "Restaurant_schema"."Table" (
    table_number integer NOT NULL,
    seats_number integer NOT NULL,
    table_location bytea,
    employment_status character varying(12) NOT NULL,
    CONSTRAINT table_check_1 CHECK ((table_number > 0)),
    CONSTRAINT table_check_2 CHECK (((seats_number > 0) AND (seats_number <= 6))),
    CONSTRAINT table_check_3 CHECK (((employment_status)::text = ANY ((ARRAY['свободен'::character varying, 'занят'::character varying, 'забронирован'::character varying])::text[])))
);


ALTER TABLE "Restaurant_schema"."Table" OWNER TO diana;

--
-- TOC entry 3435 (class 0 OID 16412)
-- Dependencies: 210
-- Data for Name: Booking; Type: TABLE DATA; Schema: Restaurant_schema; Owner: diana
--

INSERT INTO "Restaurant_schema"."Booking" OVERRIDING SYSTEM VALUE VALUES (1, 5, 89213456789, '2023-02-21', '19:00:00', NULL, 'Миша');
INSERT INTO "Restaurant_schema"."Booking" OVERRIDING SYSTEM VALUE VALUES (10, 6, 89213456715, '2023-02-22', '19:00:00', '21:00:00', 'Сергей');
INSERT INTO "Restaurant_schema"."Booking" OVERRIDING SYSTEM VALUE VALUES (11, 7, 89213456456, '2023-02-20', '21:00:00', NULL, 'Дарья');
INSERT INTO "Restaurant_schema"."Booking" OVERRIDING SYSTEM VALUE VALUES (12, 8, 89213456000, '2023-02-25', '12:30:00', '13:30:00', 'Маргарита');


--
-- TOC entry 3442 (class 0 OID 16500)
-- Dependencies: 217
-- Data for Name: Cooking_dish; Type: TABLE DATA; Schema: Restaurant_schema; Owner: diana
--

INSERT INTO "Restaurant_schema"."Cooking_dish" VALUES (2, 1);
INSERT INTO "Restaurant_schema"."Cooking_dish" VALUES (2, 2);
INSERT INTO "Restaurant_schema"."Cooking_dish" VALUES (2, 5);
INSERT INTO "Restaurant_schema"."Cooking_dish" VALUES (2, 4);
INSERT INTO "Restaurant_schema"."Cooking_dish" VALUES (6, 2);
INSERT INTO "Restaurant_schema"."Cooking_dish" VALUES (6, 5);
INSERT INTO "Restaurant_schema"."Cooking_dish" VALUES (6, 6);


--
-- TOC entry 3441 (class 0 OID 16493)
-- Dependencies: 216
-- Data for Name: Dish; Type: TABLE DATA; Schema: Restaurant_schema; Owner: diana
--

INSERT INTO "Restaurant_schema"."Dish" OVERRIDING SYSTEM VALUE VALUES (1, 'Солянка', 'Суп', 430.00, '350 гр', NULL);
INSERT INTO "Restaurant_schema"."Dish" OVERRIDING SYSTEM VALUE VALUES (2, 'Яблочный пирог', 'Пироги', 90.00, '100 гр', NULL);
INSERT INTO "Restaurant_schema"."Dish" OVERRIDING SYSTEM VALUE VALUES (4, 'Груша в вине', 'Горячее', 440.00, '350 гр', NULL);
INSERT INTO "Restaurant_schema"."Dish" OVERRIDING SYSTEM VALUE VALUES (5, 'Паста с морепродуктами', 'Паста', 500.00, '400 гр', NULL);
INSERT INTO "Restaurant_schema"."Dish" OVERRIDING SYSTEM VALUE VALUES (6, 'Куриная грудка с пюре', 'Горячее', 380.00, '400 гр', NULL);


--
-- TOC entry 3444 (class 0 OID 16520)
-- Dependencies: 219
-- Data for Name: Dish_components; Type: TABLE DATA; Schema: Restaurant_schema; Owner: diana
--

INSERT INTO "Restaurant_schema"."Dish_components" VALUES (2, 1, '60 гр', 237.00);
INSERT INTO "Restaurant_schema"."Dish_components" VALUES (4, 2, '200 гр', 1684.00);
INSERT INTO "Restaurant_schema"."Dish_components" VALUES (5, 6, '250 гр', 752.00);
INSERT INTO "Restaurant_schema"."Dish_components" VALUES (6, 3, '200 гр', 1047.00);
INSERT INTO "Restaurant_schema"."Dish_components" VALUES (6, 4, '200 гр', 1047.00);
INSERT INTO "Restaurant_schema"."Dish_components" VALUES (6, 5, '50 мл', 1047.00);


--
-- TOC entry 3438 (class 0 OID 16441)
-- Dependencies: 213
-- Data for Name: Employee; Type: TABLE DATA; Schema: Restaurant_schema; Owner: diana
--

INSERT INTO "Restaurant_schema"."Employee" OVERRIDING SYSTEM VALUE VALUES (1, 1234345677, 'Григорий', 'Сергеев', 'Михайлович', 1);
INSERT INTO "Restaurant_schema"."Employee" OVERRIDING SYSTEM VALUE VALUES (2, 8793345607, 'Алексей', 'Ромашкин', 'Сергеевич', 3);
INSERT INTO "Restaurant_schema"."Employee" OVERRIDING SYSTEM VALUE VALUES (3, 4016345611, 'Олеся', 'Макмутова', 'Максимовна', 4);
INSERT INTO "Restaurant_schema"."Employee" OVERRIDING SYSTEM VALUE VALUES (4, 3004349690, 'Наталья', 'Усова', 'Алексеевна', 4);
INSERT INTO "Restaurant_schema"."Employee" OVERRIDING SYSTEM VALUE VALUES (5, 6700895743, 'Анастасия', 'Велесова', 'Андреевна', 5);
INSERT INTO "Restaurant_schema"."Employee" OVERRIDING SYSTEM VALUE VALUES (6, 4231564877, 'Александра', 'Боянь', 'Владимировна', 3);


--
-- TOC entry 3443 (class 0 OID 16515)
-- Dependencies: 218
-- Data for Name: Ingredient; Type: TABLE DATA; Schema: Restaurant_schema; Owner: diana
--

INSERT INTO "Restaurant_schema"."Ingredient" OVERRIDING SYSTEM VALUE VALUES (1, 'Яблоки', '1 неделя', 'Фрукты', 52.00, '3 кг');
INSERT INTO "Restaurant_schema"."Ingredient" OVERRIDING SYSTEM VALUE VALUES (2, 'Груши', '1 неделя', 'Фрукты', 42.00, '1 кг');
INSERT INTO "Restaurant_schema"."Ingredient" OVERRIDING SYSTEM VALUE VALUES (3, 'Курица', '2 дня', 'Птица', 237.00, '3 шт');
INSERT INTO "Restaurant_schema"."Ingredient" OVERRIDING SYSTEM VALUE VALUES (4, 'Картофель', '1 месяц', 'Овощи', 76.00, '1.5 кг');
INSERT INTO "Restaurant_schema"."Ingredient" OVERRIDING SYSTEM VALUE VALUES (5, 'Молоко', '4 дня', 'Кисломолочные продукты', 70.00, '6 л');
INSERT INTO "Restaurant_schema"."Ingredient" OVERRIDING SYSTEM VALUE VALUES (6, 'Макараны фузилли', '1 год', 'Макароны', 157.00, '5 пачек');


--
-- TOC entry 3440 (class 0 OID 16458)
-- Dependencies: 215
-- Data for Name: Order; Type: TABLE DATA; Schema: Restaurant_schema; Owner: diana
--

INSERT INTO "Restaurant_schema"."Order" OVERRIDING SYSTEM VALUE VALUES (2, 4, '2023-02-20', 'accepted', 1950.00, 1);
INSERT INTO "Restaurant_schema"."Order" OVERRIDING SYSTEM VALUE VALUES (3, 5, '2023-02-20', 'accepted', 3880.00, 3);
INSERT INTO "Restaurant_schema"."Order" OVERRIDING SYSTEM VALUE VALUES (4, 4, '2023-02-20', 'in progress', 1950.00, 1);
INSERT INTO "Restaurant_schema"."Order" OVERRIDING SYSTEM VALUE VALUES (5, 4, '2023-02-20', 'paid', 1950.00, 1);
INSERT INTO "Restaurant_schema"."Order" OVERRIDING SYSTEM VALUE VALUES (6, 4, '2023-02-20', 'accepted', 1950.00, 1);
INSERT INTO "Restaurant_schema"."Order" OVERRIDING SYSTEM VALUE VALUES (7, 4, '2023-02-20', 'accepted', 2500.00, 2);


--
-- TOC entry 3454 (class 0 OID 16664)
-- Dependencies: 229
-- Data for Name: Order_fulfillment; Type: TABLE DATA; Schema: Restaurant_schema; Owner: diana
--

INSERT INTO "Restaurant_schema"."Order_fulfillment" VALUES (2, 2, 4, 'в процессе', NULL);
INSERT INTO "Restaurant_schema"."Order_fulfillment" VALUES (5, 3, 5, 'в процессе', NULL);
INSERT INTO "Restaurant_schema"."Order_fulfillment" VALUES (1, 4, 4, 'в процессе', 'Без оливок, без лимона - аллергия');
INSERT INTO "Restaurant_schema"."Order_fulfillment" VALUES (6, 5, 4, 'готов', NULL);
INSERT INTO "Restaurant_schema"."Order_fulfillment" VALUES (4, 5, 4, 'готов', NULL);
INSERT INTO "Restaurant_schema"."Order_fulfillment" VALUES (2, 6, 4, 'в процессе', 'Без корицы');
INSERT INTO "Restaurant_schema"."Order_fulfillment" VALUES (2, 7, 4, 'в процессе', NULL);
INSERT INTO "Restaurant_schema"."Order_fulfillment" VALUES (1, 7, 4, 'в процессе', NULL);


--
-- TOC entry 3439 (class 0 OID 16446)
-- Dependencies: 214
-- Data for Name: Post; Type: TABLE DATA; Schema: Restaurant_schema; Owner: diana
--

INSERT INTO "Restaurant_schema"."Post" OVERRIDING SYSTEM VALUE VALUES (1, 'Повар второго разряда', 'Повар должен владеть навыками первичной кулинарной обработки сырья, грамотно нарезать хлеб, потрошить птицу разделывать мясо и т. д.', 'Чистка овощей', 30000.00);
INSERT INTO "Restaurant_schema"."Post" OVERRIDING SYSTEM VALUE VALUES (3, 'Повар четвертого разряда', 'Он владеет технологией приготовления, знает о требованиях к качеству и срокам хранения продуктов и готовых блюд, умеет определять качество продуктов.', 'Повар готовит блюда средней сложности: салаты, бульоны, супы, вторые блюда.', 40000.00);
INSERT INTO "Restaurant_schema"."Post" OVERRIDING SYSTEM VALUE VALUES (4, 'Официант первой категории', 'Отработал в ресторане не менее 1 месяца (214 часов). Официант 2 категории  работает под наблюдением официанта 1 категории или помощника администратора.', 'Выполняет все виды работ: готовит столовую посуду и приборы, расставляет мебель в зале, сервирует столы, принимает заказы, подает блюда, разливает алкогольные напитки, готовит ресторан к завтракам. ', 25000.00);
INSERT INTO "Restaurant_schema"."Post" OVERRIDING SYSTEM VALUE VALUES (5, 'Официант второй категории', 'Отработал в ресторане не менее 6 месяцев. Работает в ресторане на постоянной основе. Обладает всеми необходимыми знаниями, умениями и навыками, характеризующими работу официанта.', 'Официант 1 категории занимается обучением официантов- стажёров и курирует работу официантов 2 категории.', 35000.00);


--
-- TOC entry 3445 (class 0 OID 16535)
-- Dependencies: 220
-- Data for Name: Purchase; Type: TABLE DATA; Schema: Restaurant_schema; Owner: diana
--

INSERT INTO "Restaurant_schema"."Purchase" OVERRIDING SYSTEM VALUE VALUES (1, 1, 'Закарян Борис', '2023-02-20', 65.00, '3 кг', '10 кг');
INSERT INTO "Restaurant_schema"."Purchase" OVERRIDING SYSTEM VALUE VALUES (2, 2, 'Закарян Борис', '2023-02-20', 90.00, '1 кг', '7 кг');
INSERT INTO "Restaurant_schema"."Purchase" OVERRIDING SYSTEM VALUE VALUES (3, 3, 'Дмитриев Максим', '2023-02-20', 150.00, '3 шт', '6 шт');
INSERT INTO "Restaurant_schema"."Purchase" OVERRIDING SYSTEM VALUE VALUES (4, 4, 'Закарян Борис', '2023-02-20', 30.00, '1.5 кг', '15 кг');
INSERT INTO "Restaurant_schema"."Purchase" OVERRIDING SYSTEM VALUE VALUES (5, 5, 'Севичев Егор', '2023-02-20', 68.00, '6 л', '10 л');
INSERT INTO "Restaurant_schema"."Purchase" OVERRIDING SYSTEM VALUE VALUES (6, 6, 'Севичев Егор', '2023-02-20', 65.00, '5 пачек', '11 пачек');


--
-- TOC entry 3437 (class 0 OID 16436)
-- Dependencies: 212
-- Data for Name: Shift; Type: TABLE DATA; Schema: Restaurant_schema; Owner: diana
--

INSERT INTO "Restaurant_schema"."Shift" OVERRIDING SYSTEM VALUE VALUES (6, '2023-02-20', '09:00:00', '17:00:00');
INSERT INTO "Restaurant_schema"."Shift" OVERRIDING SYSTEM VALUE VALUES (7, '2023-02-20', '17:00:00', '23:00:00');
INSERT INTO "Restaurant_schema"."Shift" OVERRIDING SYSTEM VALUE VALUES (8, '2023-02-21', '09:00:00', '17:00:00');
INSERT INTO "Restaurant_schema"."Shift" OVERRIDING SYSTEM VALUE VALUES (9, '2023-02-21', '16:00:00', '23:00:00');
INSERT INTO "Restaurant_schema"."Shift" OVERRIDING SYSTEM VALUE VALUES (10, '2023-02-22', '09:00:00', '17:00:00');
INSERT INTO "Restaurant_schema"."Shift" OVERRIDING SYSTEM VALUE VALUES (11, '2023-02-22', '17:00:00', '23:00:00');
INSERT INTO "Restaurant_schema"."Shift" OVERRIDING SYSTEM VALUE VALUES (12, '2023-02-23', '09:00:00', '17:00:00');
INSERT INTO "Restaurant_schema"."Shift" OVERRIDING SYSTEM VALUE VALUES (13, '2023-02-23', '15:00:00', '23:00:00');


--
-- TOC entry 3455 (class 0 OID 16687)
-- Dependencies: 230
-- Data for Name: Shift_allocation; Type: TABLE DATA; Schema: Restaurant_schema; Owner: postgres
--

INSERT INTO "Restaurant_schema"."Shift_allocation" VALUES (7, 3, 1);
INSERT INTO "Restaurant_schema"."Shift_allocation" VALUES (7, 4, 3);
INSERT INTO "Restaurant_schema"."Shift_allocation" VALUES (7, 4, 5);
INSERT INTO "Restaurant_schema"."Shift_allocation" VALUES (8, 1, 1);
INSERT INTO "Restaurant_schema"."Shift_allocation" VALUES (8, 1, 3);


--
-- TOC entry 3436 (class 0 OID 16417)
-- Dependencies: 211
-- Data for Name: Table; Type: TABLE DATA; Schema: Restaurant_schema; Owner: diana
--

INSERT INTO "Restaurant_schema"."Table" VALUES (1, 4, NULL, 'занят');
INSERT INTO "Restaurant_schema"."Table" VALUES (2, 4, NULL, 'свободен');
INSERT INTO "Restaurant_schema"."Table" VALUES (3, 2, NULL, 'свободен');
INSERT INTO "Restaurant_schema"."Table" VALUES (4, 2, NULL, 'свободен');
INSERT INTO "Restaurant_schema"."Table" VALUES (5, 6, NULL, 'забронирован');
INSERT INTO "Restaurant_schema"."Table" VALUES (6, 2, NULL, 'забронирован');
INSERT INTO "Restaurant_schema"."Table" VALUES (7, 4, NULL, 'забронирован');
INSERT INTO "Restaurant_schema"."Table" VALUES (8, 4, NULL, 'забронирован');


--
-- TOC entry 3461 (class 0 OID 0)
-- Dependencies: 223
-- Name: Booking_booking_number_seq; Type: SEQUENCE SET; Schema: Restaurant_schema; Owner: diana
--

SELECT pg_catalog.setval('"Restaurant_schema"."Booking_booking_number_seq"', 12, true);


--
-- TOC entry 3462 (class 0 OID 0)
-- Dependencies: 224
-- Name: Dish_id_dish_seq; Type: SEQUENCE SET; Schema: Restaurant_schema; Owner: diana
--

SELECT pg_catalog.setval('"Restaurant_schema"."Dish_id_dish_seq"', 6, true);


--
-- TOC entry 3463 (class 0 OID 0)
-- Dependencies: 222
-- Name: Employee_id_employee_seq; Type: SEQUENCE SET; Schema: Restaurant_schema; Owner: diana
--

SELECT pg_catalog.setval('"Restaurant_schema"."Employee_id_employee_seq"', 6, true);


--
-- TOC entry 3464 (class 0 OID 0)
-- Dependencies: 227
-- Name: Ingredient_id_ingredient_seq; Type: SEQUENCE SET; Schema: Restaurant_schema; Owner: diana
--

SELECT pg_catalog.setval('"Restaurant_schema"."Ingredient_id_ingredient_seq"', 6, true);


--
-- TOC entry 3465 (class 0 OID 0)
-- Dependencies: 221
-- Name: Order_id_order_seq; Type: SEQUENCE SET; Schema: Restaurant_schema; Owner: diana
--

SELECT pg_catalog.setval('"Restaurant_schema"."Order_id_order_seq"', 7, true);


--
-- TOC entry 3466 (class 0 OID 0)
-- Dependencies: 225
-- Name: Post_id_post_seq; Type: SEQUENCE SET; Schema: Restaurant_schema; Owner: diana
--

SELECT pg_catalog.setval('"Restaurant_schema"."Post_id_post_seq"', 5, true);


--
-- TOC entry 3467 (class 0 OID 0)
-- Dependencies: 228
-- Name: Purchase_id_purchase_seq; Type: SEQUENCE SET; Schema: Restaurant_schema; Owner: diana
--

SELECT pg_catalog.setval('"Restaurant_schema"."Purchase_id_purchase_seq"', 6, true);


--
-- TOC entry 3468 (class 0 OID 0)
-- Dependencies: 226
-- Name: Shift_id_shift_seq; Type: SEQUENCE SET; Schema: Restaurant_schema; Owner: diana
--

SELECT pg_catalog.setval('"Restaurant_schema"."Shift_id_shift_seq"', 13, true);


--
-- TOC entry 3256 (class 2606 OID 16430)
-- Name: Booking Booking_pkey; Type: CONSTRAINT; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE ONLY "Restaurant_schema"."Booking"
    ADD CONSTRAINT "Booking_pkey" PRIMARY KEY (booking_number);


--
-- TOC entry 3270 (class 2606 OID 16504)
-- Name: Cooking_dish Cooking_dish_pkey; Type: CONSTRAINT; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE ONLY "Restaurant_schema"."Cooking_dish"
    ADD CONSTRAINT "Cooking_dish_pkey" PRIMARY KEY (id_employee, id_dish);


--
-- TOC entry 3274 (class 2606 OID 16524)
-- Name: Dish_components Dish_components_pkey; Type: CONSTRAINT; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE ONLY "Restaurant_schema"."Dish_components"
    ADD CONSTRAINT "Dish_components_pkey" PRIMARY KEY (id_dish, id_ingredient);


--
-- TOC entry 3268 (class 2606 OID 16499)
-- Name: Dish Dish_pkey; Type: CONSTRAINT; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE ONLY "Restaurant_schema"."Dish"
    ADD CONSTRAINT "Dish_pkey" PRIMARY KEY (id_dish);


--
-- TOC entry 3262 (class 2606 OID 16445)
-- Name: Employee Employee_pkey; Type: CONSTRAINT; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE ONLY "Restaurant_schema"."Employee"
    ADD CONSTRAINT "Employee_pkey" PRIMARY KEY (id_employee);


--
-- TOC entry 3272 (class 2606 OID 16519)
-- Name: Ingredient Ingredient_pkey; Type: CONSTRAINT; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE ONLY "Restaurant_schema"."Ingredient"
    ADD CONSTRAINT "Ingredient_pkey" PRIMARY KEY (id_ingredient);


--
-- TOC entry 3278 (class 2606 OID 16670)
-- Name: Order_fulfillment Order_fulfillment_pkey; Type: CONSTRAINT; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE ONLY "Restaurant_schema"."Order_fulfillment"
    ADD CONSTRAINT "Order_fulfillment_pkey" PRIMARY KEY (id_dish, id_order, id_employee);


--
-- TOC entry 3266 (class 2606 OID 16462)
-- Name: Order Order_pkey; Type: CONSTRAINT; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE ONLY "Restaurant_schema"."Order"
    ADD CONSTRAINT "Order_pkey" PRIMARY KEY (id_order);


--
-- TOC entry 3264 (class 2606 OID 16452)
-- Name: Post Post_pkey; Type: CONSTRAINT; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE ONLY "Restaurant_schema"."Post"
    ADD CONSTRAINT "Post_pkey" PRIMARY KEY (id_post);


--
-- TOC entry 3276 (class 2606 OID 16539)
-- Name: Purchase Purchase_pkey; Type: CONSTRAINT; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE ONLY "Restaurant_schema"."Purchase"
    ADD CONSTRAINT "Purchase_pkey" PRIMARY KEY (id_purchase);


--
-- TOC entry 3280 (class 2606 OID 16691)
-- Name: Shift_allocation Shift_allocation_pkey; Type: CONSTRAINT; Schema: Restaurant_schema; Owner: postgres
--

ALTER TABLE ONLY "Restaurant_schema"."Shift_allocation"
    ADD CONSTRAINT "Shift_allocation_pkey" PRIMARY KEY (id_shift, id_employee, table_number);


--
-- TOC entry 3260 (class 2606 OID 16440)
-- Name: Shift Shift_pkey; Type: CONSTRAINT; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE ONLY "Restaurant_schema"."Shift"
    ADD CONSTRAINT "Shift_pkey" PRIMARY KEY (id_shift);


--
-- TOC entry 3258 (class 2606 OID 16423)
-- Name: Table Table_pkey; Type: CONSTRAINT; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE ONLY "Restaurant_schema"."Table"
    ADD CONSTRAINT "Table_pkey" PRIMARY KEY (table_number);


--
-- TOC entry 3281 (class 2606 OID 16431)
-- Name: Booking Booking_fk; Type: FK CONSTRAINT; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE ONLY "Restaurant_schema"."Booking"
    ADD CONSTRAINT "Booking_fk" FOREIGN KEY (table_number) REFERENCES "Restaurant_schema"."Table"(table_number) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3285 (class 2606 OID 16505)
-- Name: Cooking_dish Cooking_dish_fk1; Type: FK CONSTRAINT; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE ONLY "Restaurant_schema"."Cooking_dish"
    ADD CONSTRAINT "Cooking_dish_fk1" FOREIGN KEY (id_employee) REFERENCES "Restaurant_schema"."Employee"(id_employee) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3286 (class 2606 OID 16510)
-- Name: Cooking_dish Cooking_dish_fk2; Type: FK CONSTRAINT; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE ONLY "Restaurant_schema"."Cooking_dish"
    ADD CONSTRAINT "Cooking_dish_fk2" FOREIGN KEY (id_dish) REFERENCES "Restaurant_schema"."Dish"(id_dish) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3287 (class 2606 OID 16525)
-- Name: Dish_components Dish_components_fk1; Type: FK CONSTRAINT; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE ONLY "Restaurant_schema"."Dish_components"
    ADD CONSTRAINT "Dish_components_fk1" FOREIGN KEY (id_dish) REFERENCES "Restaurant_schema"."Dish"(id_dish) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3288 (class 2606 OID 16530)
-- Name: Dish_components Dish_components_fk2; Type: FK CONSTRAINT; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE ONLY "Restaurant_schema"."Dish_components"
    ADD CONSTRAINT "Dish_components_fk2" FOREIGN KEY (id_ingredient) REFERENCES "Restaurant_schema"."Ingredient"(id_ingredient) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3282 (class 2606 OID 16453)
-- Name: Employee Employee_fk; Type: FK CONSTRAINT; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE ONLY "Restaurant_schema"."Employee"
    ADD CONSTRAINT "Employee_fk" FOREIGN KEY (id_post) REFERENCES "Restaurant_schema"."Post"(id_post) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3283 (class 2606 OID 16463)
-- Name: Order Order_fk; Type: FK CONSTRAINT; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE ONLY "Restaurant_schema"."Order"
    ADD CONSTRAINT "Order_fk" FOREIGN KEY (id_employee) REFERENCES "Restaurant_schema"."Employee"(id_employee) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3284 (class 2606 OID 16468)
-- Name: Order Order_fk1; Type: FK CONSTRAINT; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE ONLY "Restaurant_schema"."Order"
    ADD CONSTRAINT "Order_fk1" FOREIGN KEY (table_number) REFERENCES "Restaurant_schema"."Table"(table_number) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3289 (class 2606 OID 16540)
-- Name: Purchase Purchase_fk1; Type: FK CONSTRAINT; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE ONLY "Restaurant_schema"."Purchase"
    ADD CONSTRAINT "Purchase_fk1" FOREIGN KEY (id_ingredient) REFERENCES "Restaurant_schema"."Ingredient"(id_ingredient) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3293 (class 2606 OID 16692)
-- Name: Shift_allocation Shift_allocation_fk1; Type: FK CONSTRAINT; Schema: Restaurant_schema; Owner: postgres
--

ALTER TABLE ONLY "Restaurant_schema"."Shift_allocation"
    ADD CONSTRAINT "Shift_allocation_fk1" FOREIGN KEY (id_shift) REFERENCES "Restaurant_schema"."Shift"(id_shift) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3294 (class 2606 OID 16697)
-- Name: Shift_allocation Shift_allocation_fk2; Type: FK CONSTRAINT; Schema: Restaurant_schema; Owner: postgres
--

ALTER TABLE ONLY "Restaurant_schema"."Shift_allocation"
    ADD CONSTRAINT "Shift_allocation_fk2" FOREIGN KEY (id_employee) REFERENCES "Restaurant_schema"."Employee"(id_employee) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3295 (class 2606 OID 16702)
-- Name: Shift_allocation Shift_allocation_fk3; Type: FK CONSTRAINT; Schema: Restaurant_schema; Owner: postgres
--

ALTER TABLE ONLY "Restaurant_schema"."Shift_allocation"
    ADD CONSTRAINT "Shift_allocation_fk3" FOREIGN KEY (table_number) REFERENCES "Restaurant_schema"."Table"(table_number) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3290 (class 2606 OID 16671)
-- Name: Order_fulfillment order_ful_fk_1; Type: FK CONSTRAINT; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE ONLY "Restaurant_schema"."Order_fulfillment"
    ADD CONSTRAINT order_ful_fk_1 FOREIGN KEY (id_dish) REFERENCES "Restaurant_schema"."Dish"(id_dish) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3291 (class 2606 OID 16676)
-- Name: Order_fulfillment order_ful_fk_2; Type: FK CONSTRAINT; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE ONLY "Restaurant_schema"."Order_fulfillment"
    ADD CONSTRAINT order_ful_fk_2 FOREIGN KEY (id_order) REFERENCES "Restaurant_schema"."Order"(id_order) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3292 (class 2606 OID 16681)
-- Name: Order_fulfillment order_ful_fk_3; Type: FK CONSTRAINT; Schema: Restaurant_schema; Owner: diana
--

ALTER TABLE ONLY "Restaurant_schema"."Order_fulfillment"
    ADD CONSTRAINT order_ful_fk_3 FOREIGN KEY (id_employee) REFERENCES "Restaurant_schema"."Employee"(id_employee) ON UPDATE RESTRICT ON DELETE RESTRICT;


-- Completed on 2023-03-06 22:17:36

--
-- PostgreSQL database dump complete
--

