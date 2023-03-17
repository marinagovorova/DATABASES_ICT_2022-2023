--
-- PostgreSQL database dump
--

-- Dumped from database version 12.14
-- Dumped by pg_dump version 12.14

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


CREATE DATABASE automaster WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE automaster OWNER TO bill;

\connect automaster

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
-- Создание таблицы "Автомобиль"
--

CREATE TABLE public."Автомобиль" (
    "Госномер" character varying(9) NOT NULL,
    "Марка" character varying(50) NOT NULL,
    "Мощность" integer NOT NULL,
    "Страна_производителя" character varying(30) NOT NULL,
    "Год_выпуска" integer NOT NULL,
    "Цвет" character varying(20) NOT NULL,
    "ID_клиента" integer NOT NULL,
    CONSTRAINT "Автомобиль_Год_выпуска_check" CHECK ((("Год_выпуска" > 1000) AND ("Год_выпуска" < 9999))),
    CONSTRAINT "Автомобиль_Мощность_check" CHECK (("Мощность" > 0))
);

--
-- Год выпуска должен быть четырёхзначным числом, мощность не может быть нулём или отрицательной
-- Все поля здесь обязательны по заданию
--


ALTER TABLE public."Автомобиль" OWNER TO bill;

--
-- Создание таблицы "Вид_работы"
--

CREATE TABLE public."Вид_работы" (
    "ID_вида_работы" integer NOT NULL,
    "Название" character varying(150) NOT NULL,
    "Требуемый_разряд" character varying(50) NOT NULL,
    "Требуемая_специализация" character varying(50) NOT NULL,
    "Стоимость_работы" integer NOT NULL,
    CONSTRAINT "Вид_работы_Стоимость_работы_check" CHECK (("Стоимость_работы" >= 0))
);

--
-- Работу должен выполнять определённый мастер, она должна иметь определённую (неотрицательную!) стоимость
-- Поэтому все поля обязательны
--


ALTER TABLE public."Вид_работы" OWNER TO bill;

--
-- Здесь создаётся последовательность для генерации ID_вида_работы (задан тип SERIAL)
--

CREATE SEQUENCE public."Вид_работы_ID_вида_работы_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Вид_работы_ID_вида_работы_seq" OWNER TO bill;


ALTER SEQUENCE public."Вид_работы_ID_вида_работы_seq" OWNED BY public."Вид_работы"."ID_вида_работы";


--
-- Таблица со списком деталей
--

CREATE TABLE public."Деталь" (
    "ID_детали" integer NOT NULL,
    "Название" character varying(150) NOT NULL,
    "Стоимость" integer NOT NULL,
    CONSTRAINT "Деталь_Стоимость_check" CHECK (("Стоимость" >= 0))
);


ALTER TABLE public."Деталь" OWNER TO bill;

--
-- Тип данных ID_детали — SERIAL
--

CREATE SEQUENCE public."Деталь_ID_детали_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Деталь_ID_детали_seq" OWNER TO bill;


ALTER SEQUENCE public."Деталь_ID_детали_seq" OWNED BY public."Деталь"."ID_детали";


--
-- Таблица со списком должностей
--

CREATE TABLE public."Должность" (
    "ID_должности" integer NOT NULL,
    "Название_должности" character varying(50) NOT NULL,
    "Специализация" character varying(50),
    "Разряд" character varying(50),
    CONSTRAINT "Должность_Название_должности_check" CHECK ((("Название_должности")::text = ANY (ARRAY[('Мастер'::character varying)::text, ('Администратор'::character varying)::text])))
);

--
-- Специализация и разряд необязательны, так как существует должность администратора, который этими свойствами не обладает
-- Название_должности может быть только либо 'Администратор', либо 'Мастер'
--


ALTER TABLE public."Должность" OWNER TO bill;

--
-- ID_должности — SERIAL
--

CREATE SEQUENCE public."Должность_ID_должности_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Должность_ID_должности_seq" OWNER TO bill;


ALTER SEQUENCE public."Должность_ID_должности_seq" OWNED BY public."Должность"."ID_должности";


--
-- Таблица со всеми заказами по всем филиалам
--

CREATE TABLE public."Заказ" (
    "Номер_заказа" integer NOT NULL,
    "Дата_заказа" date DEFAULT CURRENT_DATE NOT NULL,
    "Госномер" character varying(9) NOT NULL,
    "ID_клиента" integer NOT NULL,
    "Табельный_номер" integer NOT NULL,
    "Планируемая_дата_окончания" date NOT NULL,
    "Фактическая_дата_окончания" date,
    CONSTRAINT "Заказ_check" CHECK (("Планируемая_дата_окончания" >= "Дата_заказа")),
    CONSTRAINT "Заказ_check1" CHECK (("Фактическая_дата_окончания" >= "Дата_заказа"))
);

--
-- Дату заказа можно сразу ставить текущей, так как предполагается, что заказ создаётся кнопкой в моменте
-- Ограничения: планируемая и фактическая дата окончания не может быть раньше даты заказа
--


ALTER TABLE public."Заказ" OWNER TO bill;

--
-- Номер_заказа — SERIAL
--

CREATE SEQUENCE public."Заказ_Номер_заказа_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Заказ_Номер_заказа_seq" OWNER TO bill;


ALTER SEQUENCE public."Заказ_Номер_заказа_seq" OWNED BY public."Заказ"."Номер_заказа";


--
-- Таблица с клиентами
--

CREATE TABLE public."Клиент" (
    "ID_клиента" integer NOT NULL,
    "Номер_страховки" character varying(10) NOT NULL,
    "Статус_владельца" boolean DEFAULT true NOT NULL,
    "Номер_телефона" character varying(15) NOT NULL,
    "ФИО" character varying(150) NOT NULL,
    "E-mail" character varying(255) NOT NULL
);

--
-- Статус_владельца = True по дефолту, так как в основном машину привозят именно они
--


ALTER TABLE public."Клиент" OWNER TO bill;

--
-- ID_клиента — SERIAL
--

CREATE SEQUENCE public."Клиент_ID_клиента_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Клиент_ID_клиента_seq" OWNER TO bill;


ALTER SEQUENCE public."Клиент_ID_клиента_seq" OWNED BY public."Клиент"."ID_клиента";


--
-- Состав_детали — сущность, поясняющая, сколько деталей, каких и кем предоставленных нужно для выполнения некоторой работы
--

CREATE TABLE public."Состав_детали" (
    "ID_состава_детали" integer NOT NULL,
    "ID_детали" integer NOT NULL,
    "ID_состава_заказа" integer NOT NULL,
    "Количество_деталей" integer NOT NULL,
    "Предоставлена_клиентом" boolean DEFAULT false NOT NULL,
    CONSTRAINT "Состав_детали_Количество_детал_check" CHECK (("Количество_деталей" >= 0))
);

--
-- Количество деталей не должно быть отрицательным
-- Будем считать, что чаще всего детали клиент не предоставляет (default value = false)
--


ALTER TABLE public."Состав_детали" OWNER TO bill;

--
-- ID_состава_детали — SERIAL
--

CREATE SEQUENCE public."Состав_детали_ID_состава_детали_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Состав_детали_ID_состава_детали_seq" OWNER TO bill;


ALTER SEQUENCE public."Состав_детали_ID_состава_детали_seq" OWNED BY public."Состав_детали"."ID_состава_детали";


--
-- Состав_заказа — сущность, определяющая, какие работы относятся к определённому заказу
--

CREATE TABLE public."Состав_заказа" (
    "ID_состава_заказа" integer NOT NULL,
    "Номер_заказа" integer NOT NULL,
    "Табельный_номер" integer,
    "ID_вида_работы" integer NOT NULL,
    "Дата_исполнения" date,
    "Статус_исполнения" character varying(50) DEFAULT 'Не назначен'::character varying NOT NULL,
    CONSTRAINT "Состав_заказа_Статус_исполнени_check" CHECK ((("Статус_исполнения")::text = ANY ((ARRAY['Не назначен'::character varying, 'Назначен'::character varying, 'В работе'::character varying, 'Завершён'::character varying])::text[])))
);


ALTER TABLE public."Состав_заказа" OWNER TO bill;

--
-- ID_состава_заказ — SERIAL
--

CREATE SEQUENCE public."Состав_заказа_ID_состава_заказа_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Состав_заказа_ID_состава_заказа_seq" OWNER TO bill;


ALTER SEQUENCE public."Состав_заказа_ID_состава_заказа_seq" OWNED BY public."Состав_заказа"."ID_состава_заказа";


--
-- Таблица сотрудников по всем филиалам
--

CREATE TABLE public."Сотрудник" (
    "Табельный_номер" integer NOT NULL,
    "ФИО" character varying(150) NOT NULL,
    "ID_автомастерской" integer NOT NULL,
    "Заработная_плата" integer DEFAULT 0,
    "ID_должности" integer NOT NULL,
    CONSTRAINT "Сотрудник_Заработная_плата_check" CHECK (("Заработная_плата" >= 0))
);

--
-- Все данные обязательны к заполнению (кроме заработной платы, её считаем потом, а если вносим, то неотрицательное число)
--


ALTER TABLE public."Сотрудник" OWNER TO bill;

--
-- Табельный номер также генерируется автоматически (SERIAL)
--

CREATE SEQUENCE public."Сотрудник_Табельный_номер_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Сотрудник_Табельный_номер_seq" OWNER TO bill;


ALTER SEQUENCE public."Сотрудник_Табельный_номер_seq" OWNED BY public."Сотрудник"."Табельный_номер";


--
-- Таблица всех автомастерских
--

CREATE TABLE public."Филиал" (
    "ID_автомастерской" integer NOT NULL,
    "Состояние" boolean DEFAULT true NOT NULL,
    "Адрес" character varying(255) NOT NULL
);

--
-- Состояние — открыт/закрыт, если вносим его в таблицу, то, вероятно, филиал уже открыт
--


ALTER TABLE public."Филиал" OWNER TO bill;

--
-- ID_автомастерской генерируется автоматически (SERIAL)
--

CREATE SEQUENCE public."Филиал_ID_автомастерской_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Филиал_ID_автомастерской_seq" OWNER TO bill;


ALTER SEQUENCE public."Филиал_ID_автомастерской_seq" OWNED BY public."Филиал"."ID_автомастерской";


--
-- Здесь в качестве значения по умолчанию ставится следующий элемент сгенерированной последовательности,
-- то есть обеспечивается автоматическая генерация значений
--

ALTER TABLE ONLY public."Вид_работы" ALTER COLUMN "ID_вида_работы" SET DEFAULT nextval('public."Вид_работы_ID_вида_работы_seq"'::regclass);


ALTER TABLE ONLY public."Деталь" ALTER COLUMN "ID_детали" SET DEFAULT nextval('public."Деталь_ID_детали_seq"'::regclass);


ALTER TABLE ONLY public."Должность" ALTER COLUMN "ID_должности" SET DEFAULT nextval('public."Должность_ID_должности_seq"'::regclass);


ALTER TABLE ONLY public."Заказ" ALTER COLUMN "Номер_заказа" SET DEFAULT nextval('public."Заказ_Номер_заказа_seq"'::regclass);


ALTER TABLE ONLY public."Клиент" ALTER COLUMN "ID_клиента" SET DEFAULT nextval('public."Клиент_ID_клиента_seq"'::regclass);


ALTER TABLE ONLY public."Состав_детали" ALTER COLUMN "ID_состава_детали" SET DEFAULT nextval('public."Состав_детали_ID_состава_детали_seq"'::regclass);


ALTER TABLE ONLY public."Состав_заказа" ALTER COLUMN "ID_состава_заказа" SET DEFAULT nextval('public."Состав_заказа_ID_состава_заказа_seq"'::regclass);


ALTER TABLE ONLY public."Сотрудник" ALTER COLUMN "Табельный_номер" SET DEFAULT nextval('public."Сотрудник_Табельный_номер_seq"'::regclass);


ALTER TABLE ONLY public."Филиал" ALTER COLUMN "ID_автомастерской" SET DEFAULT nextval('public."Филиал_ID_автомастерской_seq"'::regclass);


--
-- Заполнение таблиц данными
--

INSERT INTO public."Автомобиль" ("Госномер", "Марка", "Мощность", "Страна_производителя", "Год_выпуска", "Цвет", "ID_клиента") VALUES ('М119НХ33', 'Nissan', 150, 'Япония', 2016, 'Белый', 1);
INSERT INTO public."Автомобиль" ("Госномер", "Марка", "Мощность", "Страна_производителя", "Год_выпуска", "Цвет", "ID_клиента") VALUES ('О069НС09', 'Lada', 150, 'Россия', 2004, 'Чёрный', 2);
INSERT INTO public."Автомобиль" ("Госномер", "Марка", "Мощность", "Страна_производителя", "Год_выпуска", "Цвет", "ID_клиента") VALUES ('А913СС66', 'Volkswagen', 100, 'Германия', 1996, 'Чёрный', 3);
INSERT INTO public."Автомобиль" ("Госномер", "Марка", "Мощность", "Страна_производителя", "Год_выпуска", "Цвет", "ID_клиента") VALUES ('Н118СК43', 'Toyota', 100, 'Япония', 2008, 'Чёрный', 4);
INSERT INTO public."Автомобиль" ("Госномер", "Марка", "Мощность", "Страна_производителя", "Год_выпуска", "Цвет", "ID_клиента") VALUES ('К270МВ53', 'Nissan', 200, 'Япония', 2017, 'Белый', 5);
INSERT INTO public."Автомобиль" ("Госномер", "Марка", "Мощность", "Страна_производителя", "Год_выпуска", "Цвет", "ID_клиента") VALUES ('А597ОР96', 'Lada', 100, 'Россия', 1991, 'Красный', 6);


INSERT INTO public."Вид_работы" ("ID_вида_работы", "Название", "Требуемый_разряд", "Требуемая_специализация", "Стоимость_работы") VALUES (1, 'Замена масла и фильтра', 'I', 'Механик', 1000);
INSERT INTO public."Вид_работы" ("ID_вида_работы", "Название", "Требуемый_разряд", "Требуемая_специализация", "Стоимость_работы") VALUES (2, 'Ремонт тормозной системы', 'II', 'Механик', 2000);
INSERT INTO public."Вид_работы" ("ID_вида_работы", "Название", "Требуемый_разряд", "Требуемая_специализация", "Стоимость_работы") VALUES (3, 'Замена свечей зажигания', 'I', 'Диагност', 1500);
INSERT INTO public."Вид_работы" ("ID_вида_работы", "Название", "Требуемый_разряд", "Требуемая_специализация", "Стоимость_работы") VALUES (4, 'Установка дополнительного оборудования', 'III', 'Электромеханик', 3000);
INSERT INTO public."Вид_работы" ("ID_вида_работы", "Название", "Требуемый_разряд", "Требуемая_специализация", "Стоимость_работы") VALUES (5, 'Диагностика двигателя', 'II', 'Диагност', 2500);
INSERT INTO public."Вид_работы" ("ID_вида_работы", "Название", "Требуемый_разряд", "Требуемая_специализация", "Стоимость_работы") VALUES (6, 'Ремонт системы охлаждения', 'III', 'Механик', 3500);
INSERT INTO public."Вид_работы" ("ID_вида_работы", "Название", "Требуемый_разряд", "Требуемая_специализация", "Стоимость_работы") VALUES (7, 'Замена ремня ГРМ', 'IV', 'Механик', 5000);
INSERT INTO public."Вид_работы" ("ID_вида_работы", "Название", "Требуемый_разряд", "Требуемая_специализация", "Стоимость_работы") VALUES (8, 'Установка аудиосистемы', 'III', 'Электромеханик', 4000);


INSERT INTO public."Деталь" ("ID_детали", "Название", "Стоимость") VALUES (1, 'Масляный фильтр', 500);
INSERT INTO public."Деталь" ("ID_детали", "Название", "Стоимость") VALUES (2, 'Тормозные колодки', 2000);
INSERT INTO public."Деталь" ("ID_детали", "Название", "Стоимость") VALUES (3, 'Свечи зажигания', 1000);
INSERT INTO public."Деталь" ("ID_детали", "Название", "Стоимость") VALUES (4, 'Провода высоковольтные', 1500);
INSERT INTO public."Деталь" ("ID_детали", "Название", "Стоимость") VALUES (5, 'Датчик температуры двигателя', 3000);
INSERT INTO public."Деталь" ("ID_детали", "Название", "Стоимость") VALUES (6, 'Радиатор охлаждения', 5000);
INSERT INTO public."Деталь" ("ID_детали", "Название", "Стоимость") VALUES (7, 'Ремень ГРМ', 4000);
INSERT INTO public."Деталь" ("ID_детали", "Название", "Стоимость") VALUES (8, 'Аудиосистема', 8000);


INSERT INTO public."Должность" ("ID_должности", "Название_должности", "Специализация", "Разряд") VALUES (1, 'Администратор', NULL, NULL);
INSERT INTO public."Должность" ("ID_должности", "Название_должности", "Специализация", "Разряд") VALUES (2, 'Мастер', 'Механик', 'I');
INSERT INTO public."Должность" ("ID_должности", "Название_должности", "Специализация", "Разряд") VALUES (3, 'Мастер', 'Механик', 'II');
INSERT INTO public."Должность" ("ID_должности", "Название_должности", "Специализация", "Разряд") VALUES (4, 'Мастер', 'Механик', 'III');
INSERT INTO public."Должность" ("ID_должности", "Название_должности", "Специализация", "Разряд") VALUES (5, 'Мастер', 'Механик', 'IV');
INSERT INTO public."Должность" ("ID_должности", "Название_должности", "Специализация", "Разряд") VALUES (6, 'Мастер', 'Электромеханик', 'I');
INSERT INTO public."Должность" ("ID_должности", "Название_должности", "Специализация", "Разряд") VALUES (7, 'Мастер', 'Электромеханик', 'II');
INSERT INTO public."Должность" ("ID_должности", "Название_должности", "Специализация", "Разряд") VALUES (8, 'Мастер', 'Электромеханик', 'III');
INSERT INTO public."Должность" ("ID_должности", "Название_должности", "Специализация", "Разряд") VALUES (9, 'Мастер', 'Электромеханик', 'IV');
INSERT INTO public."Должность" ("ID_должности", "Название_должности", "Специализация", "Разряд") VALUES (10, 'Мастер', 'Диагност', 'I');
INSERT INTO public."Должность" ("ID_должности", "Название_должности", "Специализация", "Разряд") VALUES (11, 'Мастер', 'Диагност', 'II');
INSERT INTO public."Должность" ("ID_должности", "Название_должности", "Специализация", "Разряд") VALUES (12, 'Мастер', 'Диагност', 'III');
INSERT INTO public."Должность" ("ID_должности", "Название_должности", "Специализация", "Разряд") VALUES (13, 'Мастер', 'Диагност', 'IV');


INSERT INTO public."Заказ" ("Номер_заказа", "Дата_заказа", "Госномер", "ID_клиента", "Табельный_номер", "Планируемая_дата_окончания", "Фактическая_дата_окончания") VALUES (1, '2023-02-10', 'М119НХ33', 1, 1, '2023-05-27', NULL);
INSERT INTO public."Заказ" ("Номер_заказа", "Дата_заказа", "Госномер", "ID_клиента", "Табельный_номер", "Планируемая_дата_окончания", "Фактическая_дата_окончания") VALUES (2, '2023-02-14', 'О069НС09', 2, 2, '2023-03-16', NULL);
INSERT INTO public."Заказ" ("Номер_заказа", "Дата_заказа", "Госномер", "ID_клиента", "Табельный_номер", "Планируемая_дата_окончания", "Фактическая_дата_окончания") VALUES (4, '2023-01-28', 'Н118СК43', 4, 2, '2023-03-28', NULL);
INSERT INTO public."Заказ" ("Номер_заказа", "Дата_заказа", "Госномер", "ID_клиента", "Табельный_номер", "Планируемая_дата_окончания", "Фактическая_дата_окончания") VALUES (5, '2023-01-24', 'К270МВ53', 5, 1, '2023-03-20', NULL);
INSERT INTO public."Заказ" ("Номер_заказа", "Дата_заказа", "Госномер", "ID_клиента", "Табельный_номер", "Планируемая_дата_окончания", "Фактическая_дата_окончания") VALUES (3, '2023-02-12', 'А913СС66', 3, 1, '2023-05-16', '2023-03-17');
INSERT INTO public."Заказ" ("Номер_заказа", "Дата_заказа", "Госномер", "ID_клиента", "Табельный_номер", "Планируемая_дата_окончания", "Фактическая_дата_окончания") VALUES (6, '2023-01-20', 'А597ОР96', 6, 2, '2023-05-20', '2023-03-18');


INSERT INTO public."Клиент" ("ID_клиента", "Номер_страховки", "Статус_владельца", "Номер_телефона", "ФИО", "E-mail") VALUES (1, 'JO61179849', true, '+79696231324', 'Белов Андрей Иванович', 'afqeevmtrg@hotmail.com');
INSERT INTO public."Клиент" ("ID_клиента", "Номер_страховки", "Статус_владельца", "Номер_телефона", "ФИО", "E-mail") VALUES (2, 'LB90312789', true, '+79320990849', 'Никитин Андрей Александрович', 'flzwiklocx@yahoo.com');
INSERT INTO public."Клиент" ("ID_клиента", "Номер_страховки", "Статус_владельца", "Номер_телефона", "ФИО", "E-mail") VALUES (3, 'IM64497399', true, '+79813283946', 'Белов Иван Александрович', 'gktsxmcsgj@hotmail.com');
INSERT INTO public."Клиент" ("ID_клиента", "Номер_страховки", "Статус_владельца", "Номер_телефона", "ФИО", "E-mail") VALUES (4, 'ID22670694', true, '+79192908060', 'Никитин Дмитрий Александрович', 'npeqymsqvw@yahoo.com');
INSERT INTO public."Клиент" ("ID_клиента", "Номер_страховки", "Статус_владельца", "Номер_телефона", "ФИО", "E-mail") VALUES (5, 'LR18662028', true, '+79396812195', 'Андреев Андрей Иванович', 'yasbpflncq@gmail.com');
INSERT INTO public."Клиент" ("ID_клиента", "Номер_страховки", "Статус_владельца", "Номер_телефона", "ФИО", "E-mail") VALUES (6, 'FG14429129', true, '+79894558942', 'Никитин Андрей Иванович', 'jyjpyeemxj@hotmail.com');


INSERT INTO public."Состав_детали" ("ID_состава_детали", "ID_детали", "ID_состава_заказа", "Количество_деталей", "Предоставлена_клиентом") VALUES (1, 1, 1, 1, false);
INSERT INTO public."Состав_детали" ("ID_состава_детали", "ID_детали", "ID_состава_заказа", "Количество_деталей", "Предоставлена_клиентом") VALUES (2, 3, 2, 2, false);
INSERT INTO public."Состав_детали" ("ID_состава_детали", "ID_детали", "ID_состава_заказа", "Количество_деталей", "Предоставлена_клиентом") VALUES (3, 2, 3, 1, false);
INSERT INTO public."Состав_детали" ("ID_состава_детали", "ID_детали", "ID_состава_заказа", "Количество_деталей", "Предоставлена_клиентом") VALUES (4, 5, 4, 1, false);
INSERT INTO public."Состав_детали" ("ID_состава_детали", "ID_детали", "ID_состава_заказа", "Количество_деталей", "Предоставлена_клиентом") VALUES (5, 8, 5, 5, true);
INSERT INTO public."Состав_детали" ("ID_состава_детали", "ID_детали", "ID_состава_заказа", "Количество_деталей", "Предоставлена_клиентом") VALUES (6, 7, 6, 1, true);
INSERT INTO public."Состав_детали" ("ID_состава_детали", "ID_детали", "ID_состава_заказа", "Количество_деталей", "Предоставлена_клиентом") VALUES (7, 7, 7, 1, false);
INSERT INTO public."Состав_детали" ("ID_состава_детали", "ID_детали", "ID_состава_заказа", "Количество_деталей", "Предоставлена_клиентом") VALUES (8, 2, 8, 1, false);
INSERT INTO public."Состав_детали" ("ID_состава_детали", "ID_детали", "ID_состава_заказа", "Количество_деталей", "Предоставлена_клиентом") VALUES (9, 4, 9, 1, false);
INSERT INTO public."Состав_детали" ("ID_состава_детали", "ID_детали", "ID_состава_заказа", "Количество_деталей", "Предоставлена_клиентом") VALUES (10, 6, 10, 1, false);
INSERT INTO public."Состав_детали" ("ID_состава_детали", "ID_детали", "ID_состава_заказа", "Количество_деталей", "Предоставлена_клиентом") VALUES (11, 1, 11, 1, true);
INSERT INTO public."Состав_детали" ("ID_состава_детали", "ID_детали", "ID_состава_заказа", "Количество_деталей", "Предоставлена_клиентом") VALUES (12, 2, 12, 1, false);


INSERT INTO public."Состав_заказа" ("ID_состава_заказа", "Номер_заказа", "Табельный_номер", "ID_вида_работы", "Дата_исполнения", "Статус_исполнения") VALUES (1, 1, NULL, 1, NULL, 'Не назначен');
INSERT INTO public."Состав_заказа" ("ID_состава_заказа", "Номер_заказа", "Табельный_номер", "ID_вида_работы", "Дата_исполнения", "Статус_исполнения") VALUES (2, 1, NULL, 3, NULL, 'Не назначен');
INSERT INTO public."Состав_заказа" ("ID_состава_заказа", "Номер_заказа", "Табельный_номер", "ID_вида_работы", "Дата_исполнения", "Статус_исполнения") VALUES (3, 1, NULL, 2, NULL, 'Не назначен');
INSERT INTO public."Состав_заказа" ("ID_состава_заказа", "Номер_заказа", "Табельный_номер", "ID_вида_работы", "Дата_исполнения", "Статус_исполнения") VALUES (4, 2, 22, 5, NULL, 'Назначен');
INSERT INTO public."Состав_заказа" ("ID_состава_заказа", "Номер_заказа", "Табельный_номер", "ID_вида_работы", "Дата_исполнения", "Статус_исполнения") VALUES (5, 2, 12, 8, NULL, 'В работе');
INSERT INTO public."Состав_заказа" ("ID_состава_заказа", "Номер_заказа", "Табельный_номер", "ID_вида_работы", "Дата_исполнения", "Статус_исполнения") VALUES (6, 3, 9, 7, '2023-03-17', 'Завершён');
INSERT INTO public."Состав_заказа" ("ID_состава_заказа", "Номер_заказа", "Табельный_номер", "ID_вида_работы", "Дата_исполнения", "Статус_исполнения") VALUES (8, 4, NULL, 7, NULL, 'Не назначен');
INSERT INTO public."Состав_заказа" ("ID_состава_заказа", "Номер_заказа", "Табельный_номер", "ID_вида_работы", "Дата_исполнения", "Статус_исполнения") VALUES (7, 4, 6, 2, NULL, 'Назначен');
INSERT INTO public."Состав_заказа" ("ID_состава_заказа", "Номер_заказа", "Табельный_номер", "ID_вида_работы", "Дата_исполнения", "Статус_исполнения") VALUES (9, 5, 15, 4, NULL, 'Назначен');
INSERT INTO public."Состав_заказа" ("ID_состава_заказа", "Номер_заказа", "Табельный_номер", "ID_вида_работы", "Дата_исполнения", "Статус_исполнения") VALUES (10, 5, 7, 6, NULL, 'В работе');
INSERT INTO public."Состав_заказа" ("ID_состава_заказа", "Номер_заказа", "Табельный_номер", "ID_вида_работы", "Дата_исполнения", "Статус_исполнения") VALUES (11, 6, 4, 1, '2023-03-17', 'Завершён');
INSERT INTO public."Состав_заказа" ("ID_состава_заказа", "Номер_заказа", "Табельный_номер", "ID_вида_работы", "Дата_исполнения", "Статус_исполнения") VALUES (12, 6, 6, 2, '2023-03-19', 'Завершён');


INSERT INTO public."Сотрудник" ("Табельный_номер", "ФИО", "ID_автомастерской", "Заработная_плата", "ID_должности") VALUES (1, 'Антипов Андрей Викторович', 1, 70000, 1);
INSERT INTO public."Сотрудник" ("Табельный_номер", "ФИО", "ID_автомастерской", "Заработная_плата", "ID_должности") VALUES (2, 'Кузьмин Аркадий Андреевич', 2, 70000, 1);
INSERT INTO public."Сотрудник" ("Табельный_номер", "ФИО", "ID_автомастерской", "Заработная_плата", "ID_должности") VALUES (3, 'Агеев Дмитрий Александрович', 1, 0, 2);
INSERT INTO public."Сотрудник" ("Табельный_номер", "ФИО", "ID_автомастерской", "Заработная_плата", "ID_должности") VALUES (4, 'Агеев Дмитрий Иванович', 2, 0, 2);
INSERT INTO public."Сотрудник" ("Табельный_номер", "ФИО", "ID_автомастерской", "Заработная_плата", "ID_должности") VALUES (5, 'Агеев Иван Александрович', 1, 0, 3);
INSERT INTO public."Сотрудник" ("Табельный_номер", "ФИО", "ID_автомастерской", "Заработная_плата", "ID_должности") VALUES (6, 'Агеев Иван Иванович', 2, 0, 3);
INSERT INTO public."Сотрудник" ("Табельный_номер", "ФИО", "ID_автомастерской", "Заработная_плата", "ID_должности") VALUES (7, 'Агеев Сергей Александрович', 1, 0, 4);
INSERT INTO public."Сотрудник" ("Табельный_номер", "ФИО", "ID_автомастерской", "Заработная_плата", "ID_должности") VALUES (8, 'Агеев Сергей Иванович', 2, 0, 4);
INSERT INTO public."Сотрудник" ("Табельный_номер", "ФИО", "ID_автомастерской", "Заработная_плата", "ID_должности") VALUES (9, 'Васин Дмитрий Александрович', 1, 0, 5);
INSERT INTO public."Сотрудник" ("Табельный_номер", "ФИО", "ID_автомастерской", "Заработная_плата", "ID_должности") VALUES (10, 'Васин Дмитрий Иванович', 2, 0, 5);
INSERT INTO public."Сотрудник" ("Табельный_номер", "ФИО", "ID_автомастерской", "Заработная_плата", "ID_должности") VALUES (11, 'Васин Иван Александрович', 1, 0, 6);
INSERT INTO public."Сотрудник" ("Табельный_номер", "ФИО", "ID_автомастерской", "Заработная_плата", "ID_должности") VALUES (12, 'Васин Иван Иванович', 2, 0, 6);
INSERT INTO public."Сотрудник" ("Табельный_номер", "ФИО", "ID_автомастерской", "Заработная_плата", "ID_должности") VALUES (13, 'Васин Сергей Александрович', 1, 0, 7);
INSERT INTO public."Сотрудник" ("Табельный_номер", "ФИО", "ID_автомастерской", "Заработная_плата", "ID_должности") VALUES (14, 'Васин Сергей Иванович', 2, 0, 7);
INSERT INTO public."Сотрудник" ("Табельный_номер", "ФИО", "ID_автомастерской", "Заработная_плата", "ID_должности") VALUES (15, 'Дорофеев Дмитрий Александрович', 1, 0, 8);
INSERT INTO public."Сотрудник" ("Табельный_номер", "ФИО", "ID_автомастерской", "Заработная_плата", "ID_должности") VALUES (16, 'Дорофеев Дмитрий Иванович', 2, 0, 8);
INSERT INTO public."Сотрудник" ("Табельный_номер", "ФИО", "ID_автомастерской", "Заработная_плата", "ID_должности") VALUES (17, 'Дорофеев Иван Александрович', 1, 0, 9);
INSERT INTO public."Сотрудник" ("Табельный_номер", "ФИО", "ID_автомастерской", "Заработная_плата", "ID_должности") VALUES (18, 'Дорофеев Иван Иванович', 2, 0, 9);
INSERT INTO public."Сотрудник" ("Табельный_номер", "ФИО", "ID_автомастерской", "Заработная_плата", "ID_должности") VALUES (19, 'Дорофеев Сергей Александрович', 1, 0, 10);
INSERT INTO public."Сотрудник" ("Табельный_номер", "ФИО", "ID_автомастерской", "Заработная_плата", "ID_должности") VALUES (20, 'Дорофеев Сергей Иванович', 2, 0, 10);
INSERT INTO public."Сотрудник" ("Табельный_номер", "ФИО", "ID_автомастерской", "Заработная_плата", "ID_должности") VALUES (21, 'Калинин Дмитрий Александрович', 1, 0, 11);
INSERT INTO public."Сотрудник" ("Табельный_номер", "ФИО", "ID_автомастерской", "Заработная_плата", "ID_должности") VALUES (22, 'Калинин Дмитрий Иванович', 2, 0, 11);
INSERT INTO public."Сотрудник" ("Табельный_номер", "ФИО", "ID_автомастерской", "Заработная_плата", "ID_должности") VALUES (23, 'Калинин Иван Александрович', 1, 0, 12);
INSERT INTO public."Сотрудник" ("Табельный_номер", "ФИО", "ID_автомастерской", "Заработная_плата", "ID_должности") VALUES (24, 'Калинин Иван Иванович', 2, 0, 12);
INSERT INTO public."Сотрудник" ("Табельный_номер", "ФИО", "ID_автомастерской", "Заработная_плата", "ID_должности") VALUES (25, 'Калинин Сергей Александрович', 1, 0, 13);
INSERT INTO public."Сотрудник" ("Табельный_номер", "ФИО", "ID_автомастерской", "Заработная_плата", "ID_должности") VALUES (26, 'Калинин Сергей Иванович', 2, 0, 13);


INSERT INTO public."Филиал" ("ID_автомастерской", "Состояние", "Адрес") VALUES (1, true, 'г. Санкт-Петербург, Тележная ул., 34В');
INSERT INTO public."Филиал" ("ID_автомастерской", "Состояние", "Адрес") VALUES (2, true, 'г. Санкт-Петербург, ш. Революции, 81');
INSERT INTO public."Филиал" ("ID_автомастерской", "Состояние", "Адрес") VALUES (3, false, 'г. Санкт-Петербург, Дальневосточный пр., 7');


SELECT pg_catalog.setval('public."Вид_работы_ID_вида_работы_seq"', 8, true);


SELECT pg_catalog.setval('public."Деталь_ID_детали_seq"', 8, true);


SELECT pg_catalog.setval('public."Должность_ID_должности_seq"', 13, true);

 
SELECT pg_catalog.setval('public."Заказ_Номер_заказа_seq"', 6, true);


SELECT pg_catalog.setval('public."Клиент_ID_клиента_seq"', 6, true);


SELECT pg_catalog.setval('public."Состав_детали_ID_состава_детали_seq"', 12, true);


SELECT pg_catalog.setval('public."Состав_заказа_ID_состава_заказа_seq"', 12, true);


SELECT pg_catalog.setval('public."Сотрудник_Табельный_номер_seq"', 26, true);


SELECT pg_catalog.setval('public."Филиал_ID_автомастерской_seq"', 3, true);


--
-- Здесь идёт назначение PRIMARY KEY
--

ALTER TABLE ONLY public."Автомобиль"
    ADD CONSTRAINT "Автомобиль_pkey" PRIMARY KEY ("Госномер");


ALTER TABLE ONLY public."Вид_работы"
    ADD CONSTRAINT "Вид_работы_pkey" PRIMARY KEY ("ID_вида_работы");


ALTER TABLE ONLY public."Деталь"
    ADD CONSTRAINT "Деталь_pkey" PRIMARY KEY ("ID_детали");


ALTER TABLE ONLY public."Должность"
    ADD CONSTRAINT "Должность_pkey" PRIMARY KEY ("ID_должности");


ALTER TABLE ONLY public."Заказ"
    ADD CONSTRAINT "Заказ_pkey" PRIMARY KEY ("Номер_заказа");


ALTER TABLE ONLY public."Клиент"
    ADD CONSTRAINT "Клиент_pkey" PRIMARY KEY ("ID_клиента");


ALTER TABLE ONLY public."Состав_детали"
    ADD CONSTRAINT "Состав_детали_pkey" PRIMARY KEY ("ID_состава_детали");


ALTER TABLE ONLY public."Состав_заказа"
    ADD CONSTRAINT "Состав_заказа_pkey" PRIMARY KEY ("ID_состава_заказа");


ALTER TABLE ONLY public."Сотрудник"
    ADD CONSTRAINT "Сотрудник_pkey" PRIMARY KEY ("Табельный_номер");


ALTER TABLE ONLY public."Филиал"
    ADD CONSTRAINT "Филиал_pkey" PRIMARY KEY ("ID_автомастерской");


--
-- Определение FOREIGN KEYs
--

ALTER TABLE ONLY public."Автомобиль"
    ADD CONSTRAINT "Автомобиль_ID_клиента_fkey" FOREIGN KEY ("ID_клиента") REFERENCES public."Клиент"("ID_клиента");


ALTER TABLE ONLY public."Заказ"
    ADD CONSTRAINT "Заказ_ID_клиента_fkey" FOREIGN KEY ("ID_клиента") REFERENCES public."Клиент"("ID_клиента");


ALTER TABLE ONLY public."Заказ"
    ADD CONSTRAINT "Заказ_Госномер_fkey" FOREIGN KEY ("Госномер") REFERENCES public."Автомобиль"("Госномер");


ALTER TABLE ONLY public."Заказ"
    ADD CONSTRAINT "Заказ_Табельный_номер_fkey" FOREIGN KEY ("Табельный_номер") REFERENCES public."Сотрудник"("Табельный_номер");


ALTER TABLE ONLY public."Состав_детали"
    ADD CONSTRAINT "Состав_детали_ID_детали_fkey" FOREIGN KEY ("ID_детали") REFERENCES public."Деталь"("ID_детали");


ALTER TABLE ONLY public."Состав_детали"
    ADD CONSTRAINT "Состав_детали_ID_состава_заказа_fkey" FOREIGN KEY ("ID_состава_заказа") REFERENCES public."Состав_заказа"("ID_состава_заказа");


ALTER TABLE ONLY public."Состав_заказа"
    ADD CONSTRAINT "Состав_заказа_ID_вида_работы_fkey" FOREIGN KEY ("ID_вида_работы") REFERENCES public."Вид_работы"("ID_вида_работы");


ALTER TABLE ONLY public."Состав_заказа"
    ADD CONSTRAINT "Состав_заказа_Номер_заказа_fkey" FOREIGN KEY ("Номер_заказа") REFERENCES public."Заказ"("Номер_заказа");


ALTER TABLE ONLY public."Состав_заказа"
    ADD CONSTRAINT "Состав_заказа_Табельный_номер_fkey" FOREIGN KEY ("Табельный_номер") REFERENCES public."Сотрудник"("Табельный_номер");


ALTER TABLE ONLY public."Сотрудник"
    ADD CONSTRAINT "Сотрудник_ID_автомастерской_fkey" FOREIGN KEY ("ID_автомастерской") REFERENCES public."Филиал"("ID_автомастерской");


ALTER TABLE ONLY public."Сотрудник"
    ADD CONSTRAINT "Сотрудник_ID_должности_fkey" FOREIGN KEY ("ID_должности") REFERENCES public."Должность"("ID_должности");


--
-- PostgreSQL database dump complete
--

