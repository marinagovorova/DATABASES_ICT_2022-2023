--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-04-03 14:06:59

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
-- TOC entry 2 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3457 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- TOC entry 888 (class 1247 OID 24693)
-- Name: delivery_invoices_statuses; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.delivery_invoices_statuses AS (
	"Создан" text,
	"Оплачен" text,
	"Отменён" text
);


ALTER TYPE public.delivery_invoices_statuses OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16397)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    parent_category_id integer,
    name text NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16465)
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    patronymic text,
    phone text,
    email text
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24590)
-- Name: deliveries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deliveries (
    id integer NOT NULL,
    vendor_id integer NOT NULL,
    create_date timestamp without time zone,
    status_id integer DEFAULT 1 NOT NULL,
    employee_id integer NOT NULL,
    invoice_id integer DEFAULT 1 NOT NULL,
    finish_date timestamp without time zone
);


ALTER TABLE public.deliveries OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 24694)
-- Name: delivery_invoices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.delivery_invoices (
    id integer NOT NULL,
    amount integer NOT NULL,
    vendor_id integer NOT NULL,
    create_date timestamp without time zone NOT NULL,
    finish_date timestamp without time zone,
    status public.delivery_invoices_statuses
);


ALTER TABLE public.delivery_invoices OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24604)
-- Name: delivery_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.delivery_items (
    id integer NOT NULL,
    delivery_id integer NOT NULL,
    amount integer NOT NULL,
    product_id integer NOT NULL,
    cost numeric NOT NULL,
    remain integer
);


ALTER TABLE public.delivery_items OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 24596)
-- Name: delivery_statuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.delivery_statuses (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.delivery_statuses OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24576)
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    id integer NOT NULL,
    last_name text NOT NULL,
    first_name text NOT NULL,
    patronymic text
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 24707)
-- Name: order_invoices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_invoices (
    id integer NOT NULL,
    customer_id integer NOT NULL,
    amount numeric NOT NULL,
    create_date timestamp without time zone NOT NULL,
    finish_date timestamp without time zone,
    status_id integer NOT NULL
);


ALTER TABLE public.order_invoices OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16477)
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id integer NOT NULL,
    order_id integer NOT NULL,
    delivery_item_id integer NOT NULL,
    amount integer NOT NULL,
    cost numeric NOT NULL
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- TOC entry 3458 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE order_items; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.order_items IS 'позиция в чеке';


--
-- TOC entry 220 (class 1259 OID 16505)
-- Name: order_statuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_statuses (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.order_statuses OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16472)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    customer_id integer NOT NULL,
    status_id integer DEFAULT 1 NOT NULL,
    invoices_id integer DEFAULT 1 NOT NULL,
    create_date timestamp without time zone,
    finish_date timestamp without time zone
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 24647)
-- Name: payment_order_statuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_order_statuses (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.payment_order_statuses OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16404)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    category_id integer NOT NULL,
    description text,
    cost numeric NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 24583)
-- Name: vendors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendors (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.vendors OWNER TO postgres;

--
-- TOC entry 3438 (class 0 OID 16397)
-- Dependencies: 215
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, parent_category_id, name) FROM stdin;
1	\N	Смартфоны
2	\N	Планшеты
3	\N	Аудио
4	\N	Часы
5	\N	Комплектующие и переферия
6	\N	Ноутбуки
7	\N	Фотоаппараты
8	\N	Бытовая техника
9	\N	Разное
10	1	Apple
11	1	Samsung
12	1	Google
13	1	Аксессуары
\.


--
-- TOC entry 3440 (class 0 OID 16465)
-- Dependencies: 217
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (id, first_name, last_name, patronymic, phone, email) FROM stdin;
9	Венедикт	Огородников	Григорьевич	79919258269	venedikt07061963@mail.ru
8	Нонна	Корнева	Константиновна	79067138778	nonna4569@mail.ru
7	Максим	Счастливцев	Ильич	79614117232	maksim9545@hotmail.com
6	Константин	Снытко	Степанович	79517636816	konstantin15@mail.ru
5	Лариса	Малинова	Ефимовна	79981407750	larisa9753@hotmail.com
4	Настасья	Клепахова	Лаврентьевна	79465076675	nastasya16@outlook.com
3	Марьяна	Елагина	Вячеславовна	79906152624	maryana.elagina@mail.ru
2	Ксения	Зайкова	Севастьяновна	79881944526	kseniya9501@mail.ru
1	Иннокентий	Хорошавцев	Константинович	79596348032	innokentiy1994@gmail.com
\.


--
-- TOC entry 3446 (class 0 OID 24590)
-- Dependencies: 223
-- Data for Name: deliveries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deliveries (id, vendor_id, create_date, status_id, employee_id, invoice_id, finish_date) FROM stdin;
1	1	2023-01-01 10:00:00	1	1	1	2023-01-03 10:00:00
2	2	2023-02-01 11:00:00	1	2	1	2023-02-03 11:00:00
3	3	2023-03-01 12:00:00	1	3	1	2023-03-03 12:00:00
\.


--
-- TOC entry 3450 (class 0 OID 24694)
-- Dependencies: 228
-- Data for Name: delivery_invoices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.delivery_invoices (id, amount, vendor_id, create_date, finish_date, status) FROM stdin;
3	1	3	2023-03-01 13:00:00	\N	\N
2	1	2	2023-02-01 11:00:00	\N	\N
1	1	1	2023-01-01 10:00:00	\N	\N
\.


--
-- TOC entry 3448 (class 0 OID 24604)
-- Dependencies: 225
-- Data for Name: delivery_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.delivery_items (id, delivery_id, amount, product_id, cost, remain) FROM stdin;
9	1	10	9	5000	\N
8	3	10	8	68000	\N
7	2	10	7	35000	\N
6	2	10	6	85000	\N
5	2	10	5	45000	\N
4	1	10	4	60000	\N
3	1	10	3	65000	\N
2	1	10	2	82000	\N
1	1	10	1	90000	\N
\.


--
-- TOC entry 3447 (class 0 OID 24596)
-- Dependencies: 224
-- Data for Name: delivery_statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.delivery_statuses (id, name) FROM stdin;
5	Отменён
4	Завершён
3	Отправлен
2	В работе
1	Создан
\.


--
-- TOC entry 3444 (class 0 OID 24576)
-- Dependencies: 221
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employees (id, last_name, first_name, patronymic) FROM stdin;
3	Бичурин	Александр	Тимофеевич
2	Кашьялова	Василиса	Юрьевна
1	Гринин	Илья	Федорович
\.


--
-- TOC entry 3451 (class 0 OID 24707)
-- Dependencies: 229
-- Data for Name: order_invoices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_invoices (id, customer_id, amount, create_date, finish_date, status_id) FROM stdin;
3	7	100	2023-03-10 10:00:00	\N	1
2	4	100	2023-03-10 10:00:00	\N	1
1	1	100	2023-03-10 10:00:00	\N	1
\.


--
-- TOC entry 3442 (class 0 OID 16477)
-- Dependencies: 219
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, order_id, delivery_item_id, amount, cost) FROM stdin;
4	3	4	1	65000
3	3	3	1	70000
2	2	2	2	87000
1	1	1	1	95000
\.


--
-- TOC entry 3443 (class 0 OID 16505)
-- Dependencies: 220
-- Data for Name: order_statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_statuses (id, name) FROM stdin;
6	Отменён
5	Завершён
4	Отправлен
3	В работе
2	Оплачен
1	Создан
\.


--
-- TOC entry 3441 (class 0 OID 16472)
-- Dependencies: 218
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, customer_id, status_id, invoices_id, create_date, finish_date) FROM stdin;
1	1	1	1	2023-03-10 10:00:00	\N
2	4	1	2	2023-03-11 10:00:00	\N
3	7	1	3	2023-03-12 10:00:00	\N
\.


--
-- TOC entry 3449 (class 0 OID 24647)
-- Dependencies: 226
-- Data for Name: payment_order_statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_order_statuses (id, name) FROM stdin;
3	Оплачен
2	Отправлен
1	Создан
\.


--
-- TOC entry 3439 (class 0 OID 16404)
-- Dependencies: 216
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, category_id, description, cost, name) FROM stdin;
1	10	Дисплей Super Retina XDR с технологией ProMotion и быстрым, плавным откликом. Грандиозный апгрейд системы камер, открывающий совершенно новые возможности. A15 Bionic — самый быстрый чип для iPhone. И впечатляющее время работы без подзарядки. Всё это Pro.Хирургическая нержавеющая сталь, панель Ceramic Shield, надёжная защита от воды (IP68) — всё это невероятно красиво и исключительно прочно.	95000	iPhone 14 Pro Max
6	11	С новым Galaxy S23 Ultra каждый кадр – шедевр благодаря совершенно новому уровню четкости фото и видео в условиях слабой освещенности и невероятной детализации снимков на камеру 200МП. Самый мощный процессор в смартфоне Galaxy справится с задачами любой сложности: скорость – его стихия.\n	91000	Galaxy S23 Ultra
2	10	Новый волшебный способ взаимодействия с iPhone.\nНоваторские функции безопасности, призванные спасать жизни. Инновационная 48-мегапиксельная камера для потрясающей детализации. Все они оснащены новейшим чипом для смартфонов. С керамическим экраном, более прочным, чем стекло любого смартфона. Водонепроницаемость. Нержавеющая сталь хирургического класса.\n	87000	iPhone 14 Pro
3	10	iOS 16 позволяет настраивать экран блокировки новыми интересными способами. iPhone 14 plus имеет тот же суперскоростной чип, что и iPhone 13 Pro. A15 Bionic с 5-ядерным графическим процессором поддерживает все новейшие функции и делает игры с насыщенной графикой и приложения AR очень плавными. Обновленная внутренняя конструкция обеспечивает лучшую термическую эффективность.	70000	iPhone 14 Plus
4	10	Ваша фотография. Ваш шрифт. Ваши виджеты. Ваш iPhone.iOS 16 позволяет настраивать экран блокировки новыми интересными способами. Наложите фотографию на слои, чтобы она стала заметна.\nВыявление сбоев зовет на помощь, когда вы не можете. iPhone 14 может обнаружить серьезную автомобильную аварию, а затем позвонить в экстренную службу и сообщить своим контактам для экстренных случаев.	65000	iPhone 14
5	11	Складной смартфон Samsung Galaxy Z Flip 4, голубой поддерживает работу одной nano и одной электронной SIM-карты в сетях 2G-5G. Устройство основано на операционной системе Android 12, его высокую производительность обеспечивают восьмиядерный процессор Snapdragon максимальной частотой 3,18 ГГц, оперативная (8 Гб) и встроенная (128 Гб) память. В сложенном виде габариты модели уменьшаются до 84,9x71,9x15,9-17,1 мм.	49000	Galaxy Z Flip 4
7	11	Для всех поклонников Galaxy, которые создают и выражают свою индивидуальность. Samsung Galaxy S22 призван дать поклонникам по всему миру флагманские функции серии Galaxy S22. Стильный дизайн, который дополнит ваш образ. Возможности для занятий, которые вы так любите. Камера, чтобы запечатлеть все, что вас вдохновляет. Безупречная связь, которая делает все проще.	39000	Galaxy S22
8	12	Компания Google представила свой новый смартфон — Pixel 7 Pro. Это первый в мире модель с Android 13 из коробки (и он будут получать обновления безопасности в течение пяти лет) и единственный на базе однокристальной платформы Tensor G2. Новинка получила 6,7" экран с разрешением 3120 x 1440 пикселей и переменной частотой обновления от 10 до 120 Hz. Тип матрицы AMOLED, а сканер встроен под экран.\n	73000	Pixel 7 Pro
9	13	Разработанный Apple в дополнение к iPhone кожаный чехол с MagSafe - это восхитительный способ обеспечить вашему iPhone дополнительную защиту и добавить стиля. Изготовленная из специально выделанной кожи, внешняя поверхность мягкая на ощупь и со временем приобретает естественную патину. Чехол быстро встает на место и плотно прилегает к вашему iPhone, не добавляя объема. Благодаря встроенным магнитам, которые идеально подходят для iPhone, чехол обеспечивает волшебное прикрепление и отсоединение каждый раз.\n	7000	Leather case for iPhone
\.


--
-- TOC entry 3445 (class 0 OID 24583)
-- Dependencies: 222
-- Data for Name: vendors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vendors (id, name) FROM stdin;
1	ООО "Эпл"
2	ООО "Самсунг"
3	ООО "Гугл"
\.


--
-- TOC entry 3236 (class 2606 OID 16504)
-- Name: order_items amount_chk; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.order_items
    ADD CONSTRAINT amount_chk CHECK ((amount > 0)) NOT VALID;


--
-- TOC entry 3233 (class 2606 OID 16425)
-- Name: categories categories_id_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.categories
    ADD CONSTRAINT categories_id_check CHECK ((id > 0)) NOT VALID;


--
-- TOC entry 3239 (class 2606 OID 16403)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 3237 (class 2606 OID 16503)
-- Name: order_items cost_chk; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.order_items
    ADD CONSTRAINT cost_chk CHECK ((cost > (0)::numeric)) NOT VALID;


--
-- TOC entry 3245 (class 2606 OID 16471)
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- TOC entry 3264 (class 2606 OID 24595)
-- Name: deliveries deliveries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deliveries
    ADD CONSTRAINT deliveries_pkey PRIMARY KEY (id);


--
-- TOC entry 3278 (class 2606 OID 24700)
-- Name: delivery_invoices delivery_invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_invoices
    ADD CONSTRAINT delivery_invoices_pkey PRIMARY KEY (id);


--
-- TOC entry 3271 (class 2606 OID 24602)
-- Name: delivery_statuses delivery_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_statuses
    ADD CONSTRAINT delivery_statuses_pkey PRIMARY KEY (id);


--
-- TOC entry 3260 (class 2606 OID 24582)
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- TOC entry 3256 (class 2606 OID 16483)
-- Name: order_items items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- TOC entry 3281 (class 2606 OID 24713)
-- Name: order_invoices order_invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_invoices
    ADD CONSTRAINT order_invoices_pkey PRIMARY KEY (id);


--
-- TOC entry 3258 (class 2606 OID 16511)
-- Name: order_statuses order_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_statuses
    ADD CONSTRAINT order_statuses_pkey PRIMARY KEY (id);


--
-- TOC entry 3251 (class 2606 OID 16476)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 3276 (class 2606 OID 24653)
-- Name: payment_order_statuses payment_order_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_order_statuses
    ADD CONSTRAINT payment_order_statuses_pkey PRIMARY KEY (id);


--
-- TOC entry 3234 (class 2606 OID 16502)
-- Name: products price_chk; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.products
    ADD CONSTRAINT price_chk CHECK ((cost > (0)::numeric)) NOT VALID;


--
-- TOC entry 3235 (class 2606 OID 16424)
-- Name: products product_id; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.products
    ADD CONSTRAINT product_id CHECK ((id > 0)) NOT VALID;


--
-- TOC entry 3243 (class 2606 OID 16410)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 3274 (class 2606 OID 24610)
-- Name: delivery_items vendor_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_items
    ADD CONSTRAINT vendor_items_pkey PRIMARY KEY (id);


--
-- TOC entry 3262 (class 2606 OID 24589)
-- Name: vendors vendors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendors
    ADD CONSTRAINT vendors_pkey PRIMARY KEY (id);


--
-- TOC entry 3279 (class 1259 OID 24725)
-- Name: fki_customer_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_customer_fkey ON public.order_invoices USING btree (customer_id);


--
-- TOC entry 3246 (class 1259 OID 16501)
-- Name: fki_customers_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_customers_fkey ON public.orders USING btree (customer_id);


--
-- TOC entry 3272 (class 1259 OID 24634)
-- Name: fki_deliveries_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_deliveries_fkey ON public.delivery_items USING btree (delivery_id);


--
-- TOC entry 3265 (class 1259 OID 24679)
-- Name: fki_deliveries_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_deliveries_id ON public.deliveries USING btree (invoice_id);


--
-- TOC entry 3266 (class 1259 OID 24628)
-- Name: fki_delivery_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_delivery_fkey ON public.deliveries USING btree (status_id);


--
-- TOC entry 3267 (class 1259 OID 24616)
-- Name: fki_employees_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_employees_fkey ON public.deliveries USING btree (employee_id);


--
-- TOC entry 3240 (class 1259 OID 16422)
-- Name: fki_fk_parent_category_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_parent_category_id ON public.categories USING btree (parent_category_id);


--
-- TOC entry 3247 (class 1259 OID 24719)
-- Name: fki_invoice_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_invoice_id ON public.orders USING btree (invoices_id);


--
-- TOC entry 3268 (class 1259 OID 24706)
-- Name: fki_invoices_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_invoices_fkey ON public.deliveries USING btree (invoice_id);


--
-- TOC entry 3252 (class 1259 OID 24685)
-- Name: fki_item_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_item_fkey ON public.order_items USING btree (delivery_item_id);


--
-- TOC entry 3248 (class 1259 OID 16518)
-- Name: fki_order_statuses_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_order_statuses_fkey ON public.orders USING btree (status_id);


--
-- TOC entry 3253 (class 1259 OID 16489)
-- Name: fki_orders_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_orders_fkey ON public.order_items USING btree (order_id);


--
-- TOC entry 3249 (class 1259 OID 24668)
-- Name: fki_payment_status_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_payment_status_fkey ON public.orders USING btree (invoices_id);


--
-- TOC entry 3254 (class 1259 OID 16495)
-- Name: fki_products_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_products_fkey ON public.order_items USING btree (delivery_item_id);


--
-- TOC entry 3269 (class 1259 OID 24622)
-- Name: fki_vendors_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_vendors_fkey ON public.deliveries USING btree (vendor_id);


--
-- TOC entry 3241 (class 1259 OID 16416)
-- Name: fki_а; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_а" ON public.products USING btree (category_id);


--
-- TOC entry 3295 (class 2606 OID 24720)
-- Name: order_invoices customer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_invoices
    ADD CONSTRAINT customer_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id) NOT VALID;


--
-- TOC entry 3284 (class 2606 OID 16496)
-- Name: orders customers_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT customers_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id) NOT VALID;


--
-- TOC entry 3293 (class 2606 OID 24629)
-- Name: delivery_items deliveries_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_items
    ADD CONSTRAINT deliveries_fkey FOREIGN KEY (delivery_id) REFERENCES public.deliveries(id) NOT VALID;


--
-- TOC entry 3289 (class 2606 OID 24623)
-- Name: deliveries delivery_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deliveries
    ADD CONSTRAINT delivery_fkey FOREIGN KEY (status_id) REFERENCES public.delivery_statuses(id) NOT VALID;


--
-- TOC entry 3290 (class 2606 OID 24611)
-- Name: deliveries employees_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deliveries
    ADD CONSTRAINT employees_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(id) NOT VALID;


--
-- TOC entry 3283 (class 2606 OID 16411)
-- Name: products fk_category_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fk_category_id FOREIGN KEY (category_id) REFERENCES public.categories(id) NOT VALID;


--
-- TOC entry 3282 (class 2606 OID 16417)
-- Name: categories fk_parent_category_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT fk_parent_category_id FOREIGN KEY (parent_category_id) REFERENCES public.categories(id) NOT VALID;


--
-- TOC entry 3285 (class 2606 OID 24714)
-- Name: orders invoice_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT invoice_id FOREIGN KEY (invoices_id) REFERENCES public.order_invoices(id) NOT VALID;


--
-- TOC entry 3291 (class 2606 OID 24701)
-- Name: deliveries invoices_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deliveries
    ADD CONSTRAINT invoices_fkey FOREIGN KEY (invoice_id) REFERENCES public.delivery_invoices(id) NOT VALID;


--
-- TOC entry 3287 (class 2606 OID 24680)
-- Name: order_items item_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT item_fkey FOREIGN KEY (delivery_item_id) REFERENCES public.delivery_items(id) NOT VALID;


--
-- TOC entry 3286 (class 2606 OID 16513)
-- Name: orders order_statuses_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT order_statuses_fkey FOREIGN KEY (status_id) REFERENCES public.order_statuses(id) NOT VALID;


--
-- TOC entry 3288 (class 2606 OID 16484)
-- Name: order_items orders_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT orders_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) NOT VALID;


--
-- TOC entry 3294 (class 2606 OID 24635)
-- Name: delivery_items products_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_items
    ADD CONSTRAINT products_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) NOT VALID;


--
-- TOC entry 3292 (class 2606 OID 24617)
-- Name: deliveries vendors_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deliveries
    ADD CONSTRAINT vendors_fkey FOREIGN KEY (vendor_id) REFERENCES public.vendors(id) NOT VALID;


-- Completed on 2023-04-03 14:06:59

--
-- PostgreSQL database dump complete
--

