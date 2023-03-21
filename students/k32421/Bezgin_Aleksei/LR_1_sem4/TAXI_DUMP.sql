--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7
-- Dumped by pg_dump version 14.7

-- Started on 2023-03-03 12:24:09 MSK

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
-- TOC entry 3714 (class 1262 OID 16606)
-- Name: Taxi; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "Taxi" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C';


ALTER DATABASE "Taxi" OWNER TO postgres;

\connect "Taxi"

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
-- TOC entry 5 (class 2615 OID 16607)
-- Name: Такси; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "Такси";


ALTER SCHEMA "Такси" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 16619)
-- Name: Автомобиль; Type: TABLE; Schema: Такси; Owner: postgres
--

CREATE TABLE "Такси"."Автомобиль" (
    "Госномер" character varying(10) NOT NULL,
    "Собственник" character varying(50) NOT NULL,
    "Год_выпуска" integer NOT NULL,
    "Стоимость" integer NOT NULL,
    "Пробег" integer NOT NULL,
    "Тип_автомобиля" character varying(10) NOT NULL,
    "Статус" integer NOT NULL,
    "Дата_последнего_ТО" date NOT NULL,
    "Код_модели" integer NOT NULL,
    "Код_тарифа" integer NOT NULL,
    CONSTRAINT "Год_выпуска_chk" CHECK ((("Год_выпуска" > 1900) AND (("Год_выпуска")::numeric <= EXTRACT(year FROM now())))),
    CONSTRAINT "Госномер_chk" CHECK ((("Госномер")::text ~ '[АВЕКМНОРСТУХ][0-9]{3}[АВЕКМНОРСТУХ]{2}[0-9]{2,3}'::text)),
    CONSTRAINT "Дата_последнего_ТО_chk" CHECK (("Дата_последнего_ТО" <= now())),
    CONSTRAINT "Пробег_chk" CHECK (("Пробег" >= 0)),
    CONSTRAINT "Статус_chk" CHECK (("Статус" = ANY (ARRAY[0, 1]))),
    CONSTRAINT "Стоимость_chk" CHECK (("Стоимость" >= 0)),
    CONSTRAINT "Тип_автомобиля_chk" CHECK ((("Тип_автомобиля")::text = ANY (ARRAY['Седан'::text, 'Универсал'::text, 'Хэтчбек'::text, 'Лимузин'::text, 'Кроссовер'::text, 'Купе'::text, 'Кабриолет'::text, 'Пикап'::text, 'Фургон'::text, 'Минивэн'::text])))
);


ALTER TABLE "Такси"."Автомобиль" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16727)
-- Name: Аккаунт_в_приложении; Type: TABLE; Schema: Такси; Owner: postgres
--

CREATE TABLE "Такси"."Аккаунт_в_приложении" (
    "№_аккаунта" integer NOT NULL,
    "Телефон" character(12) NOT NULL,
    "Email" character varying(60),
    CONSTRAINT "Email_chk" CHECK ((("Email")::text ~ similar_to_escape('%@%\.%'::text)))
);


ALTER TABLE "Такси"."Аккаунт_в_приложении" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16682)
-- Name: Вызов; Type: TABLE; Schema: Такси; Owner: postgres
--

CREATE TABLE "Такси"."Вызов" (
    "№_вызова" integer NOT NULL,
    "Госномер_автомобиля" character varying(10) NOT NULL,
    "Таб_номер_диспетчера" integer NOT NULL,
    "Телефон_пассажира" character(12) NOT NULL,
    "Статус" character varying(10) NOT NULL,
    "Наценка" integer NOT NULL,
    "Дата" timestamp(0) without time zone DEFAULT (now())::timestamp without time zone NOT NULL,
    "Штрафные_минуты" integer NOT NULL,
    "Расстояние" real NOT NULL,
    "Откуда" character varying(60) NOT NULL,
    "Куда" character varying(60) NOT NULL,
    "Время_посадки" timestamp(0) without time zone NOT NULL,
    "Время_высадки" timestamp(0) without time zone NOT NULL,
    "Примечание" character(100),
    CONSTRAINT "Время_высадки_chk" CHECK (("Время_высадки" >= "Время_посадки")),
    CONSTRAINT "Время_посадки_chk" CHECK (("Время_посадки" <= "Время_высадки")),
    CONSTRAINT "Наценка_chk" CHECK (("Наценка" >= 0)),
    CONSTRAINT "Расстояние_chk" CHECK (("Расстояние" >= (0)::double precision)),
    CONSTRAINT "Статус_chk" CHECK ((("Статус")::text = ANY (ARRAY['Принят'::text, 'Ожидает'::text, 'В процессе'::text, 'Отменен'::text, 'Завершен'::text]))),
    CONSTRAINT "Штрафные_минуты_chk" CHECK (("Штрафные_минуты" >= 0))
);


ALTER TABLE "Такси"."Вызов" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16681)
-- Name: Вызов_№_вызова_seq; Type: SEQUENCE; Schema: Такси; Owner: postgres
--

CREATE SEQUENCE "Такси"."Вызов_№_вызова_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Такси"."Вызов_№_вызова_seq" OWNER TO postgres;

--
-- TOC entry 3715 (class 0 OID 0)
-- Dependencies: 217
-- Name: Вызов_№_вызова_seq; Type: SEQUENCE OWNED BY; Schema: Такси; Owner: postgres
--

ALTER SEQUENCE "Такси"."Вызов_№_вызова_seq" OWNED BY "Такси"."Вызов"."№_вызова";


--
-- TOC entry 226 (class 1259 OID 17542)
-- Name: Вызов_№_вызова_seq1; Type: SEQUENCE; Schema: Такси; Owner: postgres
--

ALTER TABLE "Такси"."Вызов" ALTER COLUMN "№_вызова" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "Такси"."Вызов_№_вызова_seq1"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 214 (class 1259 OID 16655)
-- Name: График_работы; Type: TABLE; Schema: Такси; Owner: postgres
--

CREATE TABLE "Такси"."График_работы" (
    "Госномер_автомобиля" character varying(10) NOT NULL,
    "Таб_номер_водителя" integer NOT NULL,
    "Код_смены" integer NOT NULL,
    "Статус_выхода" integer NOT NULL,
    "Примечание" character varying(100),
    "№_смены_водителя" integer NOT NULL,
    CONSTRAINT "Статус_выхода_chk" CHECK (("Статус_выхода" = ANY (ARRAY[0, 1])))
);


ALTER TABLE "Такси"."График_работы" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16865)
-- Name: График_работы_№_смены_водителя_seq; Type: SEQUENCE; Schema: Такси; Owner: postgres
--

CREATE SEQUENCE "Такси"."График_работы_№_смены_водителя_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Такси"."График_работы_№_смены_водителя_seq" OWNER TO postgres;

--
-- TOC entry 3716 (class 0 OID 0)
-- Dependencies: 224
-- Name: График_работы_№_смены_водителя_seq; Type: SEQUENCE OWNED BY; Schema: Такси; Owner: postgres
--

ALTER SEQUENCE "Такси"."График_работы_№_смены_водителя_seq" OWNED BY "Такси"."График_работы"."№_смены_водителя";


--
-- TOC entry 223 (class 1259 OID 16745)
-- Name: Данные_банковской_карты; Type: TABLE; Schema: Такси; Owner: postgres
--

CREATE TABLE "Такси"."Данные_банковской_карты" (
    "Номер_карты" character varying(18) NOT NULL,
    "№_аккаунта" integer NOT NULL,
    "Имя_владельца" character varying(50) NOT NULL,
    "Срок_действия" date NOT NULL,
    "CCV_код" character(3) NOT NULL,
    CONSTRAINT "CCV_код_chk" CHECK ((("CCV_код")::text ~ similar_to_escape('[0-9]{3}'::text))),
    CONSTRAINT "Имя_владельца_chk" CHECK ((("Имя_владельца")::text ~ similar_to_escape('[a-z A-Z]+'::text))),
    CONSTRAINT "Номер_карты_basic_chk" CHECK ((("Номер_карты")::text ~ '[0-9]+'::text)),
    CONSTRAINT "Номер_карты_chk" CHECK ((("Номер_карты")::text ~ '[0-9]{8,19}'::text)),
    CONSTRAINT "Срок_действия_chk" CHECK (("Срок_действия" > now()))
);


ALTER TABLE "Такси"."Данные_банковской_карты" OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16669)
-- Name: Должность; Type: TABLE; Schema: Такси; Owner: postgres
--

CREATE TABLE "Такси"."Должность" (
    "Код_должности" integer NOT NULL,
    "Название" character varying(50) NOT NULL,
    "Оклад" integer NOT NULL,
    "Количество_ставок" real NOT NULL,
    CONSTRAINT "Количество_ставок_chk" CHECK (("Количество_ставок" >= (0)::double precision)),
    CONSTRAINT "Оклад_chk" CHECK (("Оклад" >= 0))
);


ALTER TABLE "Такси"."Должность" OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16637)
-- Name: Модель; Type: TABLE; Schema: Такси; Owner: postgres
--

CREATE TABLE "Такси"."Модель" (
    "Код_модели" integer NOT NULL,
    "Название" character varying(50) NOT NULL,
    "Марка" character varying(30) NOT NULL,
    "Страна_производитель" character varying(60) NOT NULL,
    "Тех_характерсистики" text NOT NULL
);


ALTER TABLE "Такси"."Модель" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16714)
-- Name: Онлайн_заказ; Type: TABLE; Schema: Такси; Owner: postgres
--

CREATE TABLE "Такси"."Онлайн_заказ" (
    "№_вызова" integer NOT NULL,
    "№_аккаунта" integer NOT NULL,
    "Тип_оплаты" character varying(20) NOT NULL,
    "Статус_заказа" character varying(15) NOT NULL,
    "№_заказа" integer NOT NULL,
    CONSTRAINT "Статус_заказа_chk" CHECK ((("Статус_заказа")::text = ANY (ARRAY['Отменен'::text, 'Ожидает оплаты'::text, 'Оплачен'::text]))),
    CONSTRAINT "Тип_оплаты_chk" CHECK ((("Тип_оплаты")::text = ANY (ARRAY['Наличные'::text, 'Банковская карта'::text])))
);


ALTER TABLE "Такси"."Онлайн_заказ" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16879)
-- Name: Онлайн_заказ_№_заказа_seq; Type: SEQUENCE; Schema: Такси; Owner: postgres
--

CREATE SEQUENCE "Такси"."Онлайн_заказ_№_заказа_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Такси"."Онлайн_заказ_№_заказа_seq" OWNER TO postgres;

--
-- TOC entry 3717 (class 0 OID 0)
-- Dependencies: 225
-- Name: Онлайн_заказ_№_заказа_seq; Type: SEQUENCE OWNED BY; Schema: Такси; Owner: postgres
--

ALTER SEQUENCE "Такси"."Онлайн_заказ_№_заказа_seq" OWNED BY "Такси"."Онлайн_заказ"."№_заказа";


--
-- TOC entry 222 (class 1259 OID 16733)
-- Name: Пассажир; Type: TABLE; Schema: Такси; Owner: postgres
--

CREATE TABLE "Такси"."Пассажир" (
    "Телефон" character(12) NOT NULL,
    "Имя" character varying(50) NOT NULL,
    CONSTRAINT "Телефон_chk" CHECK (("Телефон" ~ similar_to_escape('\+[0-9]{11}'::text)))
);


ALTER TABLE "Такси"."Пассажир" OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16647)
-- Name: Смена; Type: TABLE; Schema: Такси; Owner: postgres
--

CREATE TABLE "Такси"."Смена" (
    "Код_смены" integer NOT NULL,
    "Дата" date NOT NULL,
    "Время_начала" time(0) without time zone NOT NULL,
    "Время_окончания" time(0) without time zone NOT NULL,
    CONSTRAINT "Время_начала_chk" CHECK (("Время_начала" <= "Время_окончания")),
    CONSTRAINT "Время_окончания_chk" CHECK (("Время_окончания" >= "Время_начала"))
);


ALTER TABLE "Такси"."Смена" OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16646)
-- Name: Смена_Код_смены_seq; Type: SEQUENCE; Schema: Такси; Owner: postgres
--

CREATE SEQUENCE "Такси"."Смена_Код_смены_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Такси"."Смена_Код_смены_seq" OWNER TO postgres;

--
-- TOC entry 3718 (class 0 OID 0)
-- Dependencies: 212
-- Name: Смена_Код_смены_seq; Type: SEQUENCE OWNED BY; Schema: Такси; Owner: postgres
--

ALTER SEQUENCE "Такси"."Смена_Код_смены_seq" OWNED BY "Такси"."Смена"."Код_смены";


--
-- TOC entry 215 (class 1259 OID 16661)
-- Name: Сотрудник; Type: TABLE; Schema: Такси; Owner: postgres
--

CREATE TABLE "Такси"."Сотрудник" (
    "Таб_номер" integer NOT NULL,
    "ФИО" character varying(50) NOT NULL,
    "Телефон" character(12) NOT NULL,
    "№_паспорта" character(10) NOT NULL,
    "Адрес" character varying(60) NOT NULL,
    "Код_должности" integer NOT NULL,
    CONSTRAINT "Телефон_chk" CHECK (("Телефон" ~ similar_to_escape('\+[0-9]{11}'::text))),
    CONSTRAINT "ФИО_chk" CHECK ((("ФИО")::text !~~ '%[0-9]%'::text)),
    CONSTRAINT "№_паспорта_chk" CHECK (("№_паспорта" ~ similar_to_escape('[0-9]{10}'::text)))
);


ALTER TABLE "Такси"."Сотрудник" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16706)
-- Name: Тариф; Type: TABLE; Schema: Такси; Owner: postgres
--

CREATE TABLE "Такси"."Тариф" (
    "Код_тарифа" integer NOT NULL,
    "Наименование" character varying(30) NOT NULL,
    "Цена_за_км" integer NOT NULL,
    "Тип_автомобиля" character varying(20) NOT NULL,
    CONSTRAINT "Наименование_chk" CHECK ((("Наименование")::text = ANY (ARRAY['Эконом'::text, 'Базовый'::text, 'Семейный'::text, 'Бизнес'::text, 'Премиум'::text, 'Грузовой'::text]))),
    CONSTRAINT "Тип_автомобиля_chk" CHECK ((("Тип_автомобиля")::text = ANY (ARRAY['Седан'::text, 'Универсал'::text, 'Хэтчбек'::text, 'Лимузин'::text, 'Кроссовер'::text, 'Купе'::text, 'Кабриолет'::text, 'Пикап'::text, 'Фургон'::text, 'Минивэн'::text]))),
    CONSTRAINT "Цена_за_км_chk" CHECK (("Цена_за_км" >= 0))
);


ALTER TABLE "Такси"."Тариф" OWNER TO postgres;

--
-- TOC entry 3490 (class 2604 OID 16866)
-- Name: График_работы №_смены_водителя; Type: DEFAULT; Schema: Такси; Owner: postgres
--

ALTER TABLE ONLY "Такси"."График_работы" ALTER COLUMN "№_смены_водителя" SET DEFAULT nextval('"Такси"."График_работы_№_смены_водителя_seq"'::regclass);


--
-- TOC entry 3507 (class 2604 OID 16880)
-- Name: Онлайн_заказ №_заказа; Type: DEFAULT; Schema: Такси; Owner: postgres
--

ALTER TABLE ONLY "Такси"."Онлайн_заказ" ALTER COLUMN "№_заказа" SET DEFAULT nextval('"Такси"."Онлайн_заказ_№_заказа_seq"'::regclass);


--
-- TOC entry 3487 (class 2604 OID 16650)
-- Name: Смена Код_смены; Type: DEFAULT; Schema: Такси; Owner: postgres
--

ALTER TABLE ONLY "Такси"."Смена" ALTER COLUMN "Код_смены" SET DEFAULT nextval('"Такси"."Смена_Код_смены_seq"'::regclass);


--
-- TOC entry 3692 (class 0 OID 16619)
-- Dependencies: 210
-- Data for Name: Автомобиль; Type: TABLE DATA; Schema: Такси; Owner: postgres
--

INSERT INTO "Такси"."Автомобиль" ("Госномер", "Собственник", "Год_выпуска", "Стоимость", "Пробег", "Тип_автомобиля", "Статус", "Дата_последнего_ТО", "Код_модели", "Код_тарифа") VALUES ('Р467АО178', 'Иванов Иван Иванович', 2018, 753000, 100000, 'Седан', 1, '2022-04-15', 11, 101);
INSERT INTO "Такси"."Автомобиль" ("Госномер", "Собственник", "Год_выпуска", "Стоимость", "Пробег", "Тип_автомобиля", "Статус", "Дата_последнего_ТО", "Код_модели", "Код_тарифа") VALUES ('У121КЕ178', 'Автопарк', 2019, 1330000, 30000, 'Кабриолет', 1, '2023-01-31', 31, 506);
INSERT INTO "Такси"."Автомобиль" ("Госномер", "Собственник", "Год_выпуска", "Стоимость", "Пробег", "Тип_автомобиля", "Статус", "Дата_последнего_ТО", "Код_модели", "Код_тарифа") VALUES ('Х577УМ78', 'Сергеев Сергей Сергеевич', 2021, 928000, 36300, 'Хэтчбек', 1, '2022-07-11', 21, 203);
INSERT INTO "Такси"."Автомобиль" ("Госномер", "Собственник", "Год_выпуска", "Стоимость", "Пробег", "Тип_автомобиля", "Статус", "Дата_последнего_ТО", "Код_модели", "Код_тарифа") VALUES ('В853АМ78', 'Алексеев Алексей Алексеевич', 2015, 953000, 46700, 'Седан', 1, '2020-10-23', 51, 101);
INSERT INTO "Такси"."Автомобиль" ("Госномер", "Собственник", "Год_выпуска", "Стоимость", "Пробег", "Тип_автомобиля", "Статус", "Дата_последнего_ТО", "Код_модели", "Код_тарифа") VALUES ('С900СН178', 'Автопарк', 2018, 1190000, 110000, 'Фургон', 1, '2021-11-03', 41, 608);
INSERT INTO "Такси"."Автомобиль" ("Госномер", "Собственник", "Год_выпуска", "Стоимость", "Пробег", "Тип_автомобиля", "Статус", "Дата_последнего_ТО", "Код_модели", "Код_тарифа") VALUES ('А132ВТ178', 'Автопарк', 2019, 1580000, 51900, 'Пикап', 1, '2023-02-01', 22, 308);


--
-- TOC entry 3703 (class 0 OID 16727)
-- Dependencies: 221
-- Data for Name: Аккаунт_в_приложении; Type: TABLE DATA; Schema: Такси; Owner: postgres
--

INSERT INTO "Такси"."Аккаунт_в_приложении" ("№_аккаунта", "Телефон", "Email") VALUES (404, '+77523574123', 'pokerface@gmail.com');
INSERT INTO "Такси"."Аккаунт_в_приложении" ("№_аккаунта", "Телефон", "Email") VALUES (118, '+79565176230', 'alexthesurvivor@gmail.com');
INSERT INTO "Такси"."Аккаунт_в_приложении" ("№_аккаунта", "Телефон", "Email") VALUES (892, '+79136767287', 'howmuch@mail.ru');
INSERT INTO "Такси"."Аккаунт_в_приложении" ("№_аккаунта", "Телефон", "Email") VALUES (122, '+77773332004', 'michaelx@mbh.com');
INSERT INTO "Такси"."Аккаунт_в_приложении" ("№_аккаунта", "Телефон", "Email") VALUES (988, '+79145627465', 'smokeandtears@mail.ru');


--
-- TOC entry 3700 (class 0 OID 16682)
-- Dependencies: 218
-- Data for Name: Вызов; Type: TABLE DATA; Schema: Такси; Owner: postgres
--

INSERT INTO "Такси"."Вызов" ("№_вызова", "Госномер_автомобиля", "Таб_номер_диспетчера", "Телефон_пассажира", "Статус", "Наценка", "Дата", "Штрафные_минуты", "Расстояние", "Откуда", "Куда", "Время_посадки", "Время_высадки", "Примечание") VALUES (2, 'С900СН178', 812631, '+73445627689', 'Отменен', 0, '2023-03-01 10:01:00', 0, 0, 'ул. Романова 30', 'ул. Выборгская 69', '2023-03-01 10:01:00', '2023-03-01 10:01:00', 'Заказ отменен из-за болезни водителя.                                                               ');
INSERT INTO "Такси"."Вызов" ("№_вызова", "Госномер_автомобиля", "Таб_номер_диспетчера", "Телефон_пассажира", "Статус", "Наценка", "Дата", "Штрафные_минуты", "Расстояние", "Откуда", "Куда", "Время_посадки", "Время_высадки", "Примечание") VALUES (1, 'Р467АО178', 732821, '+78008372346', 'Завершен', 90, '2023-03-01 07:15:00', 3, 14.5, 'ул. Пестеля 19', 'ул. Садовая 6', '2023-03-01 07:22:00', '2023-03-01 08:01:00', '                                                                                                    ');
INSERT INTO "Такси"."Вызов" ("№_вызова", "Госномер_автомобиля", "Таб_номер_диспетчера", "Телефон_пассажира", "Статус", "Наценка", "Дата", "Штрафные_минуты", "Расстояние", "Откуда", "Куда", "Время_посадки", "Время_высадки", "Примечание") VALUES (3, 'У121КЕ178', 356442, '+73445627689', 'Завершен', 200, '2023-03-01 19:37:00', 5, 19.2, 'ул. Красная 2', 'ул. Большая Морская 4', '2023-03-01 19:50:00', '2023-03-01 20:38:00', NULL);
INSERT INTO "Такси"."Вызов" ("№_вызова", "Госномер_автомобиля", "Таб_номер_диспетчера", "Телефон_пассажира", "Статус", "Наценка", "Дата", "Штрафные_минуты", "Расстояние", "Откуда", "Куда", "Время_посадки", "Время_высадки", "Примечание") VALUES (4, 'С900СН178', 732821, '+79136767287', 'Завершен', 0, '2023-03-02 06:59:00', 0, 23.7, 'ул. Фрунзе 88', 'ул. Декабристов 16', '2023-03-02 07:20:00', '2023-03-02 08:33:00', 'Перевозка видеооборудования.                                                                        ');
INSERT INTO "Такси"."Вызов" ("№_вызова", "Госномер_автомобиля", "Таб_номер_диспетчера", "Телефон_пассажира", "Статус", "Наценка", "Дата", "Штрафные_минуты", "Расстояние", "Откуда", "Куда", "Время_посадки", "Время_высадки", "Примечание") VALUES (5, 'А132ВТ178', 562322, '+79145627465', 'Принят', 0, '2023-03-02 18:22:00', 0, 6.9, 'ул. Мира 45', 'ул. Чаплыгина 53', '2023-03-02 18:22:00', '2023-03-02 18:22:00', 'Два детских кресла.                                                                                 ');
INSERT INTO "Такси"."Вызов" ("№_вызова", "Госномер_автомобиля", "Таб_номер_диспетчера", "Телефон_пассажира", "Статус", "Наценка", "Дата", "Штрафные_минуты", "Расстояние", "Откуда", "Куда", "Время_посадки", "Время_высадки", "Примечание") VALUES (6, 'В853АМ78', 562322, '+77773332004', 'Ожидает', 40, '2023-03-02 19:02:00', 5, 19.2, 'ул. Лопухина 68', 'ул. Малая Садовая 1', '2023-03-02 19:02:00', '2023-03-02 19:02:00', NULL);
INSERT INTO "Такси"."Вызов" ("№_вызова", "Госномер_автомобиля", "Таб_номер_диспетчера", "Телефон_пассажира", "Статус", "Наценка", "Дата", "Штрафные_минуты", "Расстояние", "Откуда", "Куда", "Время_посадки", "Время_высадки", "Примечание") VALUES (7, 'Х577УМ78', 732821, '+77523574123', 'Принят', 0, '2023-03-03 03:15:00', 0, 7.3, 'ул. Гвардейская 93', 'ул. Звездная 72', '2023-03-03 03:15:00', '2023-03-03 03:15:00', NULL);


--
-- TOC entry 3696 (class 0 OID 16655)
-- Dependencies: 214
-- Data for Name: График_работы; Type: TABLE DATA; Schema: Такси; Owner: postgres
--

INSERT INTO "Такси"."График_работы" ("Госномер_автомобиля", "Таб_номер_водителя", "Код_смены", "Статус_выхода", "Примечание", "№_смены_водителя") VALUES ('Р467АО178', 372122, 1, 1, NULL, 1);
INSERT INTO "Такси"."График_работы" ("Госномер_автомобиля", "Таб_номер_водителя", "Код_смены", "Статус_выхода", "Примечание", "№_смены_водителя") VALUES ('С900СН178', 561265, 2, 0, 'Заболел', 2);
INSERT INTO "Такси"."График_работы" ("Госномер_автомобиля", "Таб_номер_водителя", "Код_смены", "Статус_выхода", "Примечание", "№_смены_водителя") VALUES ('Х577УМ78', 132198, 2, 1, NULL, 3);
INSERT INTO "Такси"."График_работы" ("Госномер_автомобиля", "Таб_номер_водителя", "Код_смены", "Статус_выхода", "Примечание", "№_смены_водителя") VALUES ('У121КЕ178', 237652, 3, 1, NULL, 4);
INSERT INTO "Такси"."График_работы" ("Госномер_автомобиля", "Таб_номер_водителя", "Код_смены", "Статус_выхода", "Примечание", "№_смены_водителя") VALUES ('Р467АО178', 372122, 3, 1, NULL, 5);
INSERT INTO "Такси"."График_работы" ("Госномер_автомобиля", "Таб_номер_водителя", "Код_смены", "Статус_выхода", "Примечание", "№_смены_водителя") VALUES ('С900СН178', 813537, 4, 0, 'Семейные обстоятельства', 6);
INSERT INTO "Такси"."График_работы" ("Госномер_автомобиля", "Таб_номер_водителя", "Код_смены", "Статус_выхода", "Примечание", "№_смены_водителя") VALUES ('С900СН178', 561265, 4, 1, NULL, 7);
INSERT INTO "Такси"."График_работы" ("Госномер_автомобиля", "Таб_номер_водителя", "Код_смены", "Статус_выхода", "Примечание", "№_смены_водителя") VALUES ('Р467АО178', 372122, 5, 1, NULL, 8);
INSERT INTO "Такси"."График_работы" ("Госномер_автомобиля", "Таб_номер_водителя", "Код_смены", "Статус_выхода", "Примечание", "№_смены_водителя") VALUES ('С900СН178', 561265, 5, 1, NULL, 9);
INSERT INTO "Такси"."График_работы" ("Госномер_автомобиля", "Таб_номер_водителя", "Код_смены", "Статус_выхода", "Примечание", "№_смены_водителя") VALUES ('В853АМ78', 237652, 6, 1, NULL, 10);
INSERT INTO "Такси"."График_работы" ("Госномер_автомобиля", "Таб_номер_водителя", "Код_смены", "Статус_выхода", "Примечание", "№_смены_водителя") VALUES ('А132ВТ178', 813537, 6, 1, NULL, 11);
INSERT INTO "Такси"."График_работы" ("Госномер_автомобиля", "Таб_номер_водителя", "Код_смены", "Статус_выхода", "Примечание", "№_смены_водителя") VALUES ('Х577УМ78', 132198, 7, 1, NULL, 12);


--
-- TOC entry 3705 (class 0 OID 16745)
-- Dependencies: 223
-- Data for Name: Данные_банковской_карты; Type: TABLE DATA; Schema: Такси; Owner: postgres
--

INSERT INTO "Такси"."Данные_банковской_карты" ("Номер_карты", "№_аккаунта", "Имя_владельца", "Срок_действия", "CCV_код") VALUES ('234234765981', 988, 'Nickolay', '2024-09-01', '111');
INSERT INTO "Такси"."Данные_банковской_карты" ("Номер_карты", "№_аккаунта", "Имя_владельца", "Срок_действия", "CCV_код") VALUES ('6742176437962436', 892, 'Yuri', '2027-07-01', '453');
INSERT INTO "Такси"."Данные_банковской_карты" ("Номер_карты", "№_аккаунта", "Имя_владельца", "Срок_действия", "CCV_код") VALUES ('83632751672149', 404, 'Max', '2026-11-01', '013');


--
-- TOC entry 3698 (class 0 OID 16669)
-- Dependencies: 216
-- Data for Name: Должность; Type: TABLE DATA; Schema: Такси; Owner: postgres
--

INSERT INTO "Такси"."Должность" ("Код_должности", "Название", "Оклад", "Количество_ставок") VALUES (16, 'Водитель Категория B', 56000, 1);
INSERT INTO "Такси"."Должность" ("Код_должности", "Название", "Оклад", "Количество_ставок") VALUES (15, 'Водитель Категория B', 28000, 0.5);
INSERT INTO "Такси"."Должность" ("Код_должности", "Название", "Оклад", "Количество_ставок") VALUES (18, 'Водитель Категория C', 61000, 1);
INSERT INTO "Такси"."Должность" ("Код_должности", "Название", "Оклад", "Количество_ставок") VALUES (14, 'Диспетчер День', 39000, 1);
INSERT INTO "Такси"."Должность" ("Код_должности", "Название", "Оклад", "Количество_ставок") VALUES (17, 'Водитель Категория C', 30500, 0.5);
INSERT INTO "Такси"."Должность" ("Код_должности", "Название", "Оклад", "Количество_ставок") VALUES (13, 'Диспетчер День', 19500, 0.5);
INSERT INTO "Такси"."Должность" ("Код_должности", "Название", "Оклад", "Количество_ставок") VALUES (12, 'Диспетчер Ночь', 45000, 1);
INSERT INTO "Такси"."Должность" ("Код_должности", "Название", "Оклад", "Количество_ставок") VALUES (11, 'Диспетчер Ночь', 22500, 0.5);


--
-- TOC entry 3693 (class 0 OID 16637)
-- Dependencies: 211
-- Data for Name: Модель; Type: TABLE DATA; Schema: Такси; Owner: postgres
--

INSERT INTO "Такси"."Модель" ("Код_модели", "Название", "Марка", "Страна_производитель", "Тех_характерсистики") VALUES (11, 'Solaris', 'Hyundai', 'Южная Корея', 'Объем бака 50 л. Мощность двигателя 123 л.с. Клиренс 160 мм. 5 мест. ');
INSERT INTO "Такси"."Модель" ("Код_модели", "Название", "Марка", "Страна_производитель", "Тех_характерсистики") VALUES (21, 'Focus', 'Ford', 'США', 'Объем бака 55 л. Мощность двигателя 180 л.с. Клиренс 135 мм. 5 мест. ');
INSERT INTO "Такси"."Модель" ("Код_модели", "Название", "Марка", "Страна_производитель", "Тех_характерсистики") VALUES (22, 'Ranger', 'Ford', 'США', 'Объем бака 80 л. Мощность двигателя 207 л.с. Клиренс 300 мм. 5 мест. ');
INSERT INTO "Такси"."Модель" ("Код_модели", "Название", "Марка", "Страна_производитель", "Тех_характерсистики") VALUES (31, 'A3', 'Audi', 'Германия', 'Объем бака 50 л. Мощность двигателя 300 л.с. Клиренс 165 мм. 4 места. ');
INSERT INTO "Такси"."Модель" ("Код_модели", "Название", "Марка", "Страна_производитель", "Тех_характерсистики") VALUES (41, 'Master', 'Renault', 'Франция', 'Объем бака 100 л. Мощность двигателя 125 л.с. Клиренс 190 мм. 2 места. ');
INSERT INTO "Такси"."Модель" ("Код_модели", "Название", "Марка", "Страна_производитель", "Тех_характерсистики") VALUES (51, 'Vesta', 'Lada', 'Россия', 'Объем бака 55 л. Мощность двигателя 145 л.с. Клиренс 130 мм. 5 мест. ');


--
-- TOC entry 3702 (class 0 OID 16714)
-- Dependencies: 220
-- Data for Name: Онлайн_заказ; Type: TABLE DATA; Schema: Такси; Owner: postgres
--

INSERT INTO "Такси"."Онлайн_заказ" ("№_вызова", "№_аккаунта", "Тип_оплаты", "Статус_заказа", "№_заказа") VALUES (4, 892, 'Банковская карта', 'Оплачен', 1);
INSERT INTO "Такси"."Онлайн_заказ" ("№_вызова", "№_аккаунта", "Тип_оплаты", "Статус_заказа", "№_заказа") VALUES (5, 988, 'Наличные', 'Ожидает оплаты', 2);
INSERT INTO "Такси"."Онлайн_заказ" ("№_вызова", "№_аккаунта", "Тип_оплаты", "Статус_заказа", "№_заказа") VALUES (7, 404, 'Банковская карта', 'Оплачен', 3);


--
-- TOC entry 3704 (class 0 OID 16733)
-- Dependencies: 222
-- Data for Name: Пассажир; Type: TABLE DATA; Schema: Такси; Owner: postgres
--

INSERT INTO "Такси"."Пассажир" ("Телефон", "Имя") VALUES ('+79136767287', 'Юрий Д.');
INSERT INTO "Такси"."Пассажир" ("Телефон", "Имя") VALUES ('+79565176230', 'Алексей Н.');
INSERT INTO "Такси"."Пассажир" ("Телефон", "Имя") VALUES ('+79746733712', 'Екатерина Ш.');
INSERT INTO "Такси"."Пассажир" ("Телефон", "Имя") VALUES ('+77523574123', 'Максим К.');
INSERT INTO "Такси"."Пассажир" ("Телефон", "Имя") VALUES ('+78008372346', 'Мария П.');
INSERT INTO "Такси"."Пассажир" ("Телефон", "Имя") VALUES ('+77773332004', 'Михаил Х.');
INSERT INTO "Такси"."Пассажир" ("Телефон", "Имя") VALUES ('+79145627465', 'Николай С.');
INSERT INTO "Такси"."Пассажир" ("Телефон", "Имя") VALUES ('+73445627689', 'Илья Я.');


--
-- TOC entry 3695 (class 0 OID 16647)
-- Dependencies: 213
-- Data for Name: Смена; Type: TABLE DATA; Schema: Такси; Owner: postgres
--

INSERT INTO "Такси"."Смена" ("Код_смены", "Дата", "Время_начала", "Время_окончания") VALUES (1, '2023-03-01', '00:00:00', '08:00:00');
INSERT INTO "Такси"."Смена" ("Код_смены", "Дата", "Время_начала", "Время_окончания") VALUES (2, '2023-03-01', '08:00:00', '16:00:00');
INSERT INTO "Такси"."Смена" ("Код_смены", "Дата", "Время_начала", "Время_окончания") VALUES (3, '2023-03-01', '16:00:00', '24:00:00');
INSERT INTO "Такси"."Смена" ("Код_смены", "Дата", "Время_начала", "Время_окончания") VALUES (4, '2023-03-02', '00:00:00', '08:00:00');
INSERT INTO "Такси"."Смена" ("Код_смены", "Дата", "Время_начала", "Время_окончания") VALUES (5, '2023-03-02', '08:00:00', '16:00:00');
INSERT INTO "Такси"."Смена" ("Код_смены", "Дата", "Время_начала", "Время_окончания") VALUES (6, '2023-03-02', '16:00:00', '24:00:00');
INSERT INTO "Такси"."Смена" ("Код_смены", "Дата", "Время_начала", "Время_окончания") VALUES (7, '2023-03-03', '00:00:00', '08:00:00');
INSERT INTO "Такси"."Смена" ("Код_смены", "Дата", "Время_начала", "Время_окончания") VALUES (8, '2023-03-03', '08:00:00', '16:00:00');
INSERT INTO "Такси"."Смена" ("Код_смены", "Дата", "Время_начала", "Время_окончания") VALUES (9, '2023-03-03', '16:00:00', '24:00:00');


--
-- TOC entry 3697 (class 0 OID 16661)
-- Dependencies: 215
-- Data for Name: Сотрудник; Type: TABLE DATA; Schema: Такси; Owner: postgres
--

INSERT INTO "Такси"."Сотрудник" ("Таб_номер", "ФИО", "Телефон", "№_паспорта", "Адрес", "Код_должности") VALUES (372122, 'Иванов Иван Иванович', '+79132367239', '1263948532', 'ул. Приморская 14б, кв.4', 16);
INSERT INTO "Такси"."Сотрудник" ("Таб_номер", "ФИО", "Телефон", "№_паспорта", "Адрес", "Код_должности") VALUES (132198, 'Сергеев Сергей Сергеевич', '+79342453298', '8237326210', 'ул. Марата 3, кв.79', 16);
INSERT INTO "Такси"."Сотрудник" ("Таб_номер", "ФИО", "Телефон", "№_паспорта", "Адрес", "Код_должности") VALUES (237652, 'Алексеев Алексей Алексеевич', '+78235326572', '8109765011', 'ул. Ломоносова 13, кв.22', 15);
INSERT INTO "Такси"."Сотрудник" ("Таб_номер", "ФИО", "Телефон", "№_паспорта", "Адрес", "Код_должности") VALUES (561265, 'Петров Петр Петрович', '+78812512210', '6523652367', 'ул. Ленина 17, кв.95', 18);
INSERT INTO "Такси"."Сотрудник" ("Таб_номер", "ФИО", "Телефон", "№_паспорта", "Адрес", "Код_должности") VALUES (813537, 'Степанов Степан Степанович', '+78006263226', '9800121643', 'ул. Пушкина 53, кв.4', 15);
INSERT INTO "Такси"."Сотрудник" ("Таб_номер", "ФИО", "Телефон", "№_паспорта", "Адрес", "Код_должности") VALUES (732821, 'Краснова Кристина Константиновна', '+79017361001', '6370120356', 'ул. Блюхера 87, кв.123', 12);
INSERT INTO "Такси"."Сотрудник" ("Таб_номер", "ФИО", "Телефон", "№_паспорта", "Адрес", "Код_должности") VALUES (356442, 'Ульянова Ульяна Ульриховна', '+79136542513', '8723409425', 'ул. Шпалерная 77, кв.2', 13);
INSERT INTO "Такси"."Сотрудник" ("Таб_номер", "ФИО", "Телефон", "№_паспорта", "Адрес", "Код_должности") VALUES (562322, 'Никитина Наталья Никитична', '+79876234567', '9543668540', 'ул. Блохина 50, кв.63', 14);
INSERT INTO "Такси"."Сотрудник" ("Таб_номер", "ФИО", "Телефон", "№_паспорта", "Адрес", "Код_должности") VALUES (812631, 'Романов Роман Романович', '+78328745634', '3536325289', 'ул. Державина 15, кв.44', 14);


--
-- TOC entry 3701 (class 0 OID 16706)
-- Dependencies: 219
-- Data for Name: Тариф; Type: TABLE DATA; Schema: Такси; Owner: postgres
--

INSERT INTO "Такси"."Тариф" ("Код_тарифа", "Наименование", "Цена_за_км", "Тип_автомобиля") VALUES (101, 'Эконом', 30, 'Седан');
INSERT INTO "Такси"."Тариф" ("Код_тарифа", "Наименование", "Цена_за_км", "Тип_автомобиля") VALUES (102, 'Эконом', 40, 'Универсал');
INSERT INTO "Такси"."Тариф" ("Код_тарифа", "Наименование", "Цена_за_км", "Тип_автомобиля") VALUES (203, 'Базовый', 50, 'Хэтчбек');
INSERT INTO "Такси"."Тариф" ("Код_тарифа", "Наименование", "Цена_за_км", "Тип_автомобиля") VALUES (308, 'Семейный', 75, 'Пикап');
INSERT INTO "Такси"."Тариф" ("Код_тарифа", "Наименование", "Цена_за_км", "Тип_автомобиля") VALUES (409, 'Бизнес', 80, 'Минивэн');
INSERT INTO "Такси"."Тариф" ("Код_тарифа", "Наименование", "Цена_за_км", "Тип_автомобиля") VALUES (506, 'Премиум', 220, 'Кабриолет');
INSERT INTO "Такси"."Тариф" ("Код_тарифа", "Наименование", "Цена_за_км", "Тип_автомобиля") VALUES (504, 'Премиум', 250, 'Лимузин');
INSERT INTO "Такси"."Тариф" ("Код_тарифа", "Наименование", "Цена_за_км", "Тип_автомобиля") VALUES (608, 'Грузовой', 190, 'Фургон');
INSERT INTO "Такси"."Тариф" ("Код_тарифа", "Наименование", "Цена_за_км", "Тип_автомобиля") VALUES (607, 'Грузовой', 130, 'Пикап');
INSERT INTO "Такси"."Тариф" ("Код_тарифа", "Наименование", "Цена_за_км", "Тип_автомобиля") VALUES (306, 'Семейный', 45, 'Универсал');


--
-- TOC entry 3719 (class 0 OID 0)
-- Dependencies: 217
-- Name: Вызов_№_вызова_seq; Type: SEQUENCE SET; Schema: Такси; Owner: postgres
--

SELECT pg_catalog.setval('"Такси"."Вызов_№_вызова_seq"', 1, false);


--
-- TOC entry 3720 (class 0 OID 0)
-- Dependencies: 226
-- Name: Вызов_№_вызова_seq1; Type: SEQUENCE SET; Schema: Такси; Owner: postgres
--

SELECT pg_catalog.setval('"Такси"."Вызов_№_вызова_seq1"', 1, false);


--
-- TOC entry 3721 (class 0 OID 0)
-- Dependencies: 224
-- Name: График_работы_№_смены_водителя_seq; Type: SEQUENCE SET; Schema: Такси; Owner: postgres
--

SELECT pg_catalog.setval('"Такси"."График_работы_№_смены_водителя_seq"', 12, true);


--
-- TOC entry 3722 (class 0 OID 0)
-- Dependencies: 225
-- Name: Онлайн_заказ_№_заказа_seq; Type: SEQUENCE SET; Schema: Такси; Owner: postgres
--

SELECT pg_catalog.setval('"Такси"."Онлайн_заказ_№_заказа_seq"', 3, true);


--
-- TOC entry 3723 (class 0 OID 0)
-- Dependencies: 212
-- Name: Смена_Код_смены_seq; Type: SEQUENCE SET; Schema: Такси; Owner: postgres
--

SELECT pg_catalog.setval('"Такси"."Смена_Код_смены_seq"', 9, true);


--
-- TOC entry 3518 (class 2606 OID 17378)
-- Name: Автомобиль Госномер_pk; Type: CONSTRAINT; Schema: Такси; Owner: postgres
--

ALTER TABLE ONLY "Такси"."Автомобиль"
    ADD CONSTRAINT "Госномер_pk" PRIMARY KEY ("Госномер");


--
-- TOC entry 3528 (class 2606 OID 16675)
-- Name: Должность Код_должности_pk; Type: CONSTRAINT; Schema: Такси; Owner: postgres
--

ALTER TABLE ONLY "Такси"."Должность"
    ADD CONSTRAINT "Код_должности_pk" PRIMARY KEY ("Код_должности");


--
-- TOC entry 3520 (class 2606 OID 16644)
-- Name: Модель Код_модели_pk; Type: CONSTRAINT; Schema: Такси; Owner: postgres
--

ALTER TABLE ONLY "Такси"."Модель"
    ADD CONSTRAINT "Код_модели_pk" PRIMARY KEY ("Код_модели");


--
-- TOC entry 3522 (class 2606 OID 16654)
-- Name: Смена Код_смены_pk; Type: CONSTRAINT; Schema: Такси; Owner: postgres
--

ALTER TABLE ONLY "Такси"."Смена"
    ADD CONSTRAINT "Код_смены_pk" PRIMARY KEY ("Код_смены");


--
-- TOC entry 3532 (class 2606 OID 16713)
-- Name: Тариф Код_тарифа_pk; Type: CONSTRAINT; Schema: Такси; Owner: postgres
--

ALTER TABLE ONLY "Такси"."Тариф"
    ADD CONSTRAINT "Код_тарифа_pk" PRIMARY KEY ("Код_тарифа");


--
-- TOC entry 3540 (class 2606 OID 17396)
-- Name: Данные_банковской_карты Номер_карты_pk; Type: CONSTRAINT; Schema: Такси; Owner: postgres
--

ALTER TABLE ONLY "Такси"."Данные_банковской_карты"
    ADD CONSTRAINT "Номер_карты_pk" PRIMARY KEY ("Номер_карты");


--
-- TOC entry 3486 (class 2606 OID 17533)
-- Name: Модель Страна_производитель_chk; Type: CHECK CONSTRAINT; Schema: Такси; Owner: postgres
--

ALTER TABLE "Такси"."Модель"
    ADD CONSTRAINT "Страна_производитель_chk" CHECK ((("Страна_производитель")::text ~ similar_to_escape('[А-Я][А-Я а-я]+'::text))) NOT VALID;


--
-- TOC entry 3526 (class 2606 OID 16668)
-- Name: Сотрудник Таб_номер_pk; Type: CONSTRAINT; Schema: Такси; Owner: postgres
--

ALTER TABLE ONLY "Такси"."Сотрудник"
    ADD CONSTRAINT "Таб_номер_pk" PRIMARY KEY ("Таб_номер");


--
-- TOC entry 3538 (class 2606 OID 17495)
-- Name: Пассажир Телефон_pk; Type: CONSTRAINT; Schema: Такси; Owner: postgres
--

ALTER TABLE ONLY "Такси"."Пассажир"
    ADD CONSTRAINT "Телефон_pk" PRIMARY KEY ("Телефон");


--
-- TOC entry 3536 (class 2606 OID 16732)
-- Name: Аккаунт_в_приложении №_аккаунта_pk; Type: CONSTRAINT; Schema: Такси; Owner: postgres
--

ALTER TABLE ONLY "Такси"."Аккаунт_в_приложении"
    ADD CONSTRAINT "№_аккаунта_pk" PRIMARY KEY ("№_аккаунта");


--
-- TOC entry 3530 (class 2606 OID 16695)
-- Name: Вызов №_вызова_pk; Type: CONSTRAINT; Schema: Такси; Owner: postgres
--

ALTER TABLE ONLY "Такси"."Вызов"
    ADD CONSTRAINT "№_вызова_pk" PRIMARY KEY ("№_вызова");


--
-- TOC entry 3534 (class 2606 OID 16886)
-- Name: Онлайн_заказ №_заказа_pk; Type: CONSTRAINT; Schema: Такси; Owner: postgres
--

ALTER TABLE ONLY "Такси"."Онлайн_заказ"
    ADD CONSTRAINT "№_заказа_pk" PRIMARY KEY ("№_заказа");


--
-- TOC entry 3524 (class 2606 OID 16872)
-- Name: График_работы №_смены_водителя_pk; Type: CONSTRAINT; Schema: Такси; Owner: postgres
--

ALTER TABLE ONLY "Такси"."График_работы"
    ADD CONSTRAINT "№_смены_водителя_pk" PRIMARY KEY ("№_смены_водителя");


--
-- TOC entry 3548 (class 2606 OID 17380)
-- Name: Вызов Госномер_fk; Type: FK CONSTRAINT; Schema: Такси; Owner: postgres
--

ALTER TABLE ONLY "Такси"."Вызов"
    ADD CONSTRAINT "Госномер_fk" FOREIGN KEY ("Госномер_автомобиля") REFERENCES "Такси"."Автомобиль"("Госномер");


--
-- TOC entry 3545 (class 2606 OID 17385)
-- Name: График_работы Госномер_fk; Type: FK CONSTRAINT; Schema: Такси; Owner: postgres
--

ALTER TABLE ONLY "Такси"."График_работы"
    ADD CONSTRAINT "Госномер_fk" FOREIGN KEY ("Госномер_автомобиля") REFERENCES "Такси"."Автомобиль"("Госномер");


--
-- TOC entry 3546 (class 2606 OID 16676)
-- Name: Сотрудник Код_должности_fk; Type: FK CONSTRAINT; Schema: Такси; Owner: postgres
--

ALTER TABLE ONLY "Такси"."Сотрудник"
    ADD CONSTRAINT "Код_должности_fk" FOREIGN KEY ("Код_должности") REFERENCES "Такси"."Должность"("Код_должности");


--
-- TOC entry 3541 (class 2606 OID 16848)
-- Name: Автомобиль Код_модели_fk; Type: FK CONSTRAINT; Schema: Такси; Owner: postgres
--

ALTER TABLE ONLY "Такси"."Автомобиль"
    ADD CONSTRAINT "Код_модели_fk" FOREIGN KEY ("Код_модели") REFERENCES "Такси"."Модель"("Код_модели") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3544 (class 2606 OID 16784)
-- Name: График_работы Код_смены_fk; Type: FK CONSTRAINT; Schema: Такси; Owner: postgres
--

ALTER TABLE ONLY "Такси"."График_работы"
    ADD CONSTRAINT "Код_смены_fk" FOREIGN KEY ("Код_смены") REFERENCES "Такси"."Смена"("Код_смены");


--
-- TOC entry 3542 (class 2606 OID 16853)
-- Name: Автомобиль Код_тарифа_fk; Type: FK CONSTRAINT; Schema: Такси; Owner: postgres
--

ALTER TABLE ONLY "Такси"."Автомобиль"
    ADD CONSTRAINT "Код_тарифа_fk" FOREIGN KEY ("Код_тарифа") REFERENCES "Такси"."Тариф"("Код_тарифа") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3543 (class 2606 OID 16779)
-- Name: График_работы Таб_номер_водителя_fk; Type: FK CONSTRAINT; Schema: Такси; Owner: postgres
--

ALTER TABLE ONLY "Такси"."График_работы"
    ADD CONSTRAINT "Таб_номер_водителя_fk" FOREIGN KEY ("Таб_номер_водителя") REFERENCES "Такси"."Сотрудник"("Таб_номер");


--
-- TOC entry 3547 (class 2606 OID 16701)
-- Name: Вызов Таб_номер_диспетчера_fk; Type: FK CONSTRAINT; Schema: Такси; Owner: postgres
--

ALTER TABLE ONLY "Такси"."Вызов"
    ADD CONSTRAINT "Таб_номер_диспетчера_fk" FOREIGN KEY ("Таб_номер_диспетчера") REFERENCES "Такси"."Сотрудник"("Таб_номер");


--
-- TOC entry 3551 (class 2606 OID 17497)
-- Name: Аккаунт_в_приложении Телефон_fk; Type: FK CONSTRAINT; Schema: Такси; Owner: postgres
--

ALTER TABLE ONLY "Такси"."Аккаунт_в_приложении"
    ADD CONSTRAINT "Телефон_fk" FOREIGN KEY ("Телефон") REFERENCES "Такси"."Пассажир"("Телефон");


--
-- TOC entry 3552 (class 2606 OID 16754)
-- Name: Данные_банковской_карты №_аккаунта_fk; Type: FK CONSTRAINT; Schema: Такси; Owner: postgres
--

ALTER TABLE ONLY "Такси"."Данные_банковской_карты"
    ADD CONSTRAINT "№_аккаунта_fk" FOREIGN KEY ("№_аккаунта") REFERENCES "Такси"."Аккаунт_в_приложении"("№_аккаунта");


--
-- TOC entry 3549 (class 2606 OID 16764)
-- Name: Онлайн_заказ №_аккаунта_fk; Type: FK CONSTRAINT; Schema: Такси; Owner: postgres
--

ALTER TABLE ONLY "Такси"."Онлайн_заказ"
    ADD CONSTRAINT "№_аккаунта_fk" FOREIGN KEY ("№_аккаунта") REFERENCES "Такси"."Аккаунт_в_приложении"("№_аккаунта");


--
-- TOC entry 3550 (class 2606 OID 16759)
-- Name: Онлайн_заказ №_вызова_fk; Type: FK CONSTRAINT; Schema: Такси; Owner: postgres
--

ALTER TABLE ONLY "Такси"."Онлайн_заказ"
    ADD CONSTRAINT "№_вызова_fk" FOREIGN KEY ("№_вызова") REFERENCES "Такси"."Вызов"("№_вызова");


-- Completed on 2023-03-03 12:24:09 MSK

--
-- PostgreSQL database dump complete
--

