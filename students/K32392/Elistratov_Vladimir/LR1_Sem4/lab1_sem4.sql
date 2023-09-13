--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-04-03 21:00:43

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
-- TOC entry 3438 (class 1262 OID 18356)
-- Name: lab1_sem4; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE lab1_sem4 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';


ALTER DATABASE lab1_sem4 OWNER TO postgres;

\connect lab1_sem4

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
-- TOC entry 214 (class 1259 OID 18357)
-- Name: AdditionalServices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AdditionalServices" (
    "ID" text NOT NULL,
    "ASName" text NOT NULL,
    "AddMinAmount" integer NOT NULL,
    "AddMessAmount" integer NOT NULL,
    "AddGbtAmount" integer NOT NULL,
    "ASPrice" money NOT NULL,
    "PaymentFrequency" text NOT NULL,
    CONSTRAINT "AdditionalServices_ASPrice_check" CHECK ((("ASPrice")::numeric > (0)::numeric)),
    CONSTRAINT "AdditionalServices_AddGbtAmount_check" CHECK (("AddGbtAmount" >= 0)),
    CONSTRAINT "AdditionalServices_AddMessAmount_check" CHECK (("AddMessAmount" >= 0)),
    CONSTRAINT "AdditionalServices_AddMinAmount_check" CHECK (("AddMinAmount" >= 0)),
    CONSTRAINT "AdditionalServices_ID_check" CHECK ((char_length("ID") = 10)),
    CONSTRAINT "AdditionalServices_PaymentFrequency_check" CHECK ((char_length("PaymentFrequency") = 3))
);


ALTER TABLE public."AdditionalServices" OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 18370)
-- Name: AdditionalServices_Treaty_Rate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AdditionalServices_Treaty_Rate" (
    "AdditionalServices_ID" text NOT NULL,
    "Treaty_Rate_ID" text NOT NULL
);


ALTER TABLE public."AdditionalServices_Treaty_Rate" OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 18375)
-- Name: Call; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Call" (
    "ID" text NOT NULL,
    "ZoneCode" text NOT NULL,
    "RateID" text NOT NULL,
    "TreatyID" text NOT NULL,
    "Treaty_Rate_ID" text NOT NULL,
    "TargetPnoneNumber" text NOT NULL,
    "StartCallDate" date NOT NULL,
    "CallDuration" integer NOT NULL,
    "Price" money NOT NULL,
    "PaymentState" boolean NOT NULL,
    "PaymentDate" date NOT NULL,
    "DateOfActualPayment" date NOT NULL,
    CONSTRAINT "Call_ID_check" CHECK ((char_length("ID") = 10)),
    CONSTRAINT "Call_TargetPnoneNumber_check" CHECK (((char_length("TargetPnoneNumber") <= 21) AND (char_length("TargetPnoneNumber") > 10))),
    CONSTRAINT "Call_ZoneCode_check" CHECK ((char_length("ZoneCode") = 2)),
    CONSTRAINT "Call_check" CHECK (("PaymentDate" >= "StartCallDate")),
    CONSTRAINT "Call_check1" CHECK (("DateOfActualPayment" >= "StartCallDate"))
);


ALTER TABLE public."Call" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 18387)
-- Name: Rate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Rate" (
    "RateID" text NOT NULL,
    "RateName" text NOT NULL,
    "BaseMinAmount" integer NOT NULL,
    "BaseMessAmount" integer NOT NULL,
    "BaseGbtAmount" integer NOT NULL,
    "BasePrice" money NOT NULL,
    "MinPrice" money NOT NULL,
    CONSTRAINT "Rate_BaseGbtAmount_check" CHECK (("BaseGbtAmount" >= 0)),
    CONSTRAINT "Rate_BaseMessAmount_check" CHECK (("BaseMessAmount" >= 0)),
    CONSTRAINT "Rate_BaseMinAmount_check" CHECK (("BaseMinAmount" >= 0)),
    CONSTRAINT "Rate_BasePrice_check" CHECK ((("BasePrice")::numeric > (0)::numeric)),
    CONSTRAINT "Rate_MinPrice_check" CHECK ((("MinPrice")::numeric >= (0)::numeric)),
    CONSTRAINT "Rate_RateID_check" CHECK ((char_length("RateID") = 10)),
    CONSTRAINT "Rate_RateName_check" CHECK (((char_length("RateName") <= 30) AND (char_length("RateName") > 0)))
);


ALTER TABLE public."Rate" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 18401)
-- Name: Subscriber; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Subscriber" (
    "FullName" text NOT NULL,
    "FullNameID" text NOT NULL,
    "Adress" text NOT NULL,
    CONSTRAINT "Subscriber_Adress_check" CHECK (((char_length("Adress") <= 100) AND (char_length("Adress") > 0))),
    CONSTRAINT "Subscriber_FullNameID_check" CHECK ((char_length("FullNameID") = 10)),
    CONSTRAINT "Subscriber_FullName_check" CHECK (((char_length("FullName") <= 50) AND (char_length("FullName") > 0)))
);


ALTER TABLE public."Subscriber" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 18411)
-- Name: ThirdPartyResources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ThirdPartyResources" (
    "ID" text NOT NULL,
    "TPRName" text NOT NULL,
    "Description" text NOT NULL,
    "Price" money NOT NULL,
    "PaymentFrequency" text NOT NULL,
    CONSTRAINT "ThirdPartyResources_Description_check" CHECK ((char_length("Description") <= 500)),
    CONSTRAINT "ThirdPartyResources_ID_check" CHECK ((char_length("ID") = 10)),
    CONSTRAINT "ThirdPartyResources_PaymentFrequency_check" CHECK ((char_length("PaymentFrequency") = 3)),
    CONSTRAINT "ThirdPartyResources_Price_check" CHECK ((("Price")::numeric > (0)::numeric)),
    CONSTRAINT "ThirdPartyResources_TPRName_check" CHECK (((char_length("TPRName") <= 30) AND (char_length("TPRName") > 0)))
);


ALTER TABLE public."ThirdPartyResources" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 18423)
-- Name: ThirdPartyResources_Treaty_Rate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ThirdPartyResources_Treaty_Rate" (
    "ThirdPartyResources_ID" text NOT NULL,
    "Treaty_Rate_ID" text NOT NULL
);


ALTER TABLE public."ThirdPartyResources_Treaty_Rate" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 18428)
-- Name: Treaty; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Treaty" (
    "ID" text NOT NULL,
    "PhoneNumber" text NOT NULL,
    "StartTreatyDate" date NOT NULL,
    "TreatyDuration" integer NOT NULL,
    "Balance" money NOT NULL,
    "FullNameID" text NOT NULL,
    CONSTRAINT "Treaty_ID_check" CHECK ((char_length("ID") = 10)),
    CONSTRAINT "Treaty_PhoneNumber_check" CHECK (((char_length("PhoneNumber") <= 18) AND (char_length("PhoneNumber") > 10))),
    CONSTRAINT "Treaty_StartTreatyDate_check" CHECK (("StartTreatyDate" <= CURRENT_DATE)),
    CONSTRAINT "Treaty_TreatyDuration_check" CHECK (("TreatyDuration" > 0))
);


ALTER TABLE public."Treaty" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 18441)
-- Name: Treaty_Rate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Treaty_Rate" (
    "ID" text NOT NULL,
    "RateConnectionDate" date NOT NULL,
    "Duration" integer NOT NULL,
    "TreatyID" text NOT NULL,
    "RateID" text NOT NULL,
    CONSTRAINT "Treaty_Rate_Duration_check" CHECK (("Duration" >= 0)),
    CONSTRAINT "Treaty_Rate_ID_check" CHECK ((char_length("ID") = 10)),
    CONSTRAINT "Treaty_Rate_RateConnectionDate_check" CHECK (("RateConnectionDate" <= CURRENT_DATE))
);


ALTER TABLE public."Treaty_Rate" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 18455)
-- Name: Zone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Zone" (
    "ZoneCode" text NOT NULL,
    "Coefficient" numeric NOT NULL,
    "ZoneType" text NOT NULL,
    "ZoneName" text NOT NULL,
    "RateID" text NOT NULL,
    CONSTRAINT "Zone_Coefficient_check" CHECK (("Coefficient" > (0)::numeric)),
    CONSTRAINT "Zone_RateID_check" CHECK ((char_length("RateID") = 10)),
    CONSTRAINT "Zone_ZoneCode_check" CHECK (((char_length("ZoneCode") <= 4) AND (char_length("ZoneCode") >= 1))),
    CONSTRAINT "Zone_ZoneName_check" CHECK (((char_length("ZoneName") <= 30) AND (char_length("ZoneName") > 0))),
    CONSTRAINT "Zone_ZoneType_check" CHECK (((char_length("ZoneType") <= 15) AND (char_length("ZoneType") > 0)))
);


ALTER TABLE public."Zone" OWNER TO postgres;

--
-- TOC entry 3423 (class 0 OID 18357)
-- Dependencies: 214
-- Data for Name: AdditionalServices; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."AdditionalServices" ("ID", "ASName", "AddMinAmount", "AddMessAmount", "AddGbtAmount", "ASPrice", "PaymentFrequency") VALUES ('AS00000001', 'Dop Minutes Month Rate', 100, 0, 0, '111,00 ?', 'mon');
INSERT INTO public."AdditionalServices" ("ID", "ASName", "AddMinAmount", "AddMessAmount", "AddGbtAmount", "ASPrice", "PaymentFrequency") VALUES ('AS00000002', 'Dop Messages Month Rate', 0, 200, 0, '112,00 ?', 'mon');
INSERT INTO public."AdditionalServices" ("ID", "ASName", "AddMinAmount", "AddMessAmount", "AddGbtAmount", "ASPrice", "PaymentFrequency") VALUES ('AS00000003', 'Dop Gbt Month Rate', 0, 0, 15, '155,00 ?', 'mon');
INSERT INTO public."AdditionalServices" ("ID", "ASName", "AddMinAmount", "AddMessAmount", "AddGbtAmount", "ASPrice", "PaymentFrequency") VALUES ('AS00000004', 'Dop Gbt Week Rate', 0, 0, 15, '130,00 ?', 'wek');


--
-- TOC entry 3424 (class 0 OID 18370)
-- Dependencies: 215
-- Data for Name: AdditionalServices_Treaty_Rate; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."AdditionalServices_Treaty_Rate" ("AdditionalServices_ID", "Treaty_Rate_ID") VALUES ('AS00000002', 'TR00000004');
INSERT INTO public."AdditionalServices_Treaty_Rate" ("AdditionalServices_ID", "Treaty_Rate_ID") VALUES ('AS00000001', 'TR00000004');
INSERT INTO public."AdditionalServices_Treaty_Rate" ("AdditionalServices_ID", "Treaty_Rate_ID") VALUES ('AS00000004', 'TR00000003');


--
-- TOC entry 3425 (class 0 OID 18375)
-- Dependencies: 216
-- Data for Name: Call; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Call" ("ID", "ZoneCode", "RateID", "TreatyID", "Treaty_Rate_ID", "TargetPnoneNumber", "StartCallDate", "CallDuration", "Price", "PaymentState", "PaymentDate", "DateOfActualPayment") VALUES ('C000000001', '+7', 'R000000003', 'T000000001', 'TR00000001', '+7 (944) 845-13-99', '2022-03-30', 5, '0,00 ?', true, '2022-04-30', '2022-04-04');
INSERT INTO public."Call" ("ID", "ZoneCode", "RateID", "TreatyID", "Treaty_Rate_ID", "TargetPnoneNumber", "StartCallDate", "CallDuration", "Price", "PaymentState", "PaymentDate", "DateOfActualPayment") VALUES ('C000000002', '+7', 'R000000003', 'T000000001', 'TR00000001', '+7 (944) 845-13-99', '2022-04-02', 2, '0,00 ?', true, '2022-04-02', '2022-04-03');
INSERT INTO public."Call" ("ID", "ZoneCode", "RateID", "TreatyID", "Treaty_Rate_ID", "TargetPnoneNumber", "StartCallDate", "CallDuration", "Price", "PaymentState", "PaymentDate", "DateOfActualPayment") VALUES ('C000000003', '+7', 'R000000003', 'T000000001', 'TR00000001', '+7 (955) 689-66-18', '2022-04-02', 10, '0,00 ?', false, '2022-04-02', '3000-01-01');
INSERT INTO public."Call" ("ID", "ZoneCode", "RateID", "TreatyID", "Treaty_Rate_ID", "TargetPnoneNumber", "StartCallDate", "CallDuration", "Price", "PaymentState", "PaymentDate", "DateOfActualPayment") VALUES ('C000000004', '+7', 'R000000001', 'T000000004', 'TR00000004', '+7 (955) 689-66-18', '2022-04-05', 7, '0,00 ?', false, '2022-04-05', '3000-01-01');


--
-- TOC entry 3426 (class 0 OID 18387)
-- Dependencies: 217
-- Data for Name: Rate; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Rate" ("RateID", "RateName", "BaseMinAmount", "BaseMessAmount", "BaseGbtAmount", "BasePrice", "MinPrice") VALUES ('R000000005', 'BigBlackRate', 300, 600, 45, '320,00 ?', '1,00 ?');
INSERT INTO public."Rate" ("RateID", "RateName", "BaseMinAmount", "BaseMessAmount", "BaseGbtAmount", "BasePrice", "MinPrice") VALUES ('R000000004', 'AllIn', 0, 100, 60, '200,00 ?', '5,00 ?');
INSERT INTO public."Rate" ("RateID", "RateName", "BaseMinAmount", "BaseMessAmount", "BaseGbtAmount", "BasePrice", "MinPrice") VALUES ('R000000003', 'Fikigu', 0, 100, 15, '120,00 ?', '227,00 ?');
INSERT INTO public."Rate" ("RateID", "RateName", "BaseMinAmount", "BaseMessAmount", "BaseGbtAmount", "BasePrice", "MinPrice") VALUES ('R000000002', 'Пырка', 1, 1, 1, '99,00 ?', '0,00 ?');
INSERT INTO public."Rate" ("RateID", "RateName", "BaseMinAmount", "BaseMessAmount", "BaseGbtAmount", "BasePrice", "MinPrice") VALUES ('R000000001', 'Бесперспективняк', 999, 999, 99, '222,00 ?', '999,00 ?');
INSERT INTO public."Rate" ("RateID", "RateName", "BaseMinAmount", "BaseMessAmount", "BaseGbtAmount", "BasePrice", "MinPrice") VALUES ('R000000006', 'Useless', 0, 0, 0, '33 333,00 ?', '999,00 ?');


--
-- TOC entry 3427 (class 0 OID 18401)
-- Dependencies: 218
-- Data for Name: Subscriber; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Subscriber" ("FullName", "FullNameID", "Adress") VALUES ('Куклов Антон Федотович', 'S000000001', 'Россия, г. Тамбов, Полевой пер., д. 18 кв.107');
INSERT INTO public."Subscriber" ("FullName", "FullNameID", "Adress") VALUES ('Бодрова Рада Ефремовна', 'S000000002', 'Россия, г. Хасавюрт, Мирная ул., д. 23 кв.54');
INSERT INTO public."Subscriber" ("FullName", "FullNameID", "Adress") VALUES ('Капустов Илья Петрович', 'S000000003', 'Россия, г. Набережные Челны, Колхозный пер., д. 8 кв.118');
INSERT INTO public."Subscriber" ("FullName", "FullNameID", "Adress") VALUES ('Лигачёва Полина Макаровна', 'S000000004', 'Россия, г. Казань, Луговой пер., д. 6 кв.128');
INSERT INTO public."Subscriber" ("FullName", "FullNameID", "Adress") VALUES ('Климушин Антон Тимофеевич', 'S000000005', 'Россия, г. Калуга, Интернациональная ул., д. 11 кв.149');


--
-- TOC entry 3428 (class 0 OID 18411)
-- Dependencies: 219
-- Data for Name: ThirdPartyResources; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."ThirdPartyResources" ("ID", "TPRName", "Description", "Price", "PaymentFrequency") VALUES ('TR00000001', 'Music', 'Добавляет возможность выбирать музыку на звонок', '100,00 ?', 'mon');
INSERT INTO public."ThirdPartyResources" ("ID", "TPRName", "Description", "Price", "PaymentFrequency") VALUES ('TR00000002', 'Telephone Food', 'Добавляет возможность заказывать еду по телефону', '50,00 ?', 'wek');


--
-- TOC entry 3429 (class 0 OID 18423)
-- Dependencies: 220
-- Data for Name: ThirdPartyResources_Treaty_Rate; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."ThirdPartyResources_Treaty_Rate" ("ThirdPartyResources_ID", "Treaty_Rate_ID") VALUES ('TR00000002', 'TR00000001');
INSERT INTO public."ThirdPartyResources_Treaty_Rate" ("ThirdPartyResources_ID", "Treaty_Rate_ID") VALUES ('TR00000001', 'TR00000001');
INSERT INTO public."ThirdPartyResources_Treaty_Rate" ("ThirdPartyResources_ID", "Treaty_Rate_ID") VALUES ('TR00000002', 'TR00000003');
INSERT INTO public."ThirdPartyResources_Treaty_Rate" ("ThirdPartyResources_ID", "Treaty_Rate_ID") VALUES ('TR00000001', 'TR00000003');


--
-- TOC entry 3430 (class 0 OID 18428)
-- Dependencies: 221
-- Data for Name: Treaty; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Treaty" ("ID", "PhoneNumber", "StartTreatyDate", "TreatyDuration", "Balance", "FullNameID") VALUES ('T000000004', '+7 (960) 275-58-80', '2017-12-04', 99, '155,00 ?', 'S000000001');
INSERT INTO public."Treaty" ("ID", "PhoneNumber", "StartTreatyDate", "TreatyDuration", "Balance", "FullNameID") VALUES ('T000000002', '+7 (944) 845-13-99', '2022-12-07', 99, '300,00 ?', 'S000000002');
INSERT INTO public."Treaty" ("ID", "PhoneNumber", "StartTreatyDate", "TreatyDuration", "Balance", "FullNameID") VALUES ('T000000003', '+7 (985) 328-18-98', '2020-07-15', 10, '99,00 ?', 'S000000003');
INSERT INTO public."Treaty" ("ID", "PhoneNumber", "StartTreatyDate", "TreatyDuration", "Balance", "FullNameID") VALUES ('T000000001', '+7 (930) 173-16-65', '2022-01-20', 5, '0,00 ?', 'S000000004');
INSERT INTO public."Treaty" ("ID", "PhoneNumber", "StartTreatyDate", "TreatyDuration", "Balance", "FullNameID") VALUES ('T000000005', '+7 (949) 408-14-51', '2019-01-21', 99, '-55,00 ?', 'S000000005');
INSERT INTO public."Treaty" ("ID", "PhoneNumber", "StartTreatyDate", "TreatyDuration", "Balance", "FullNameID") VALUES ('T000000006', '+7 (955) 689-66-18', '2021-05-22', 99, '-999,00 ?', 'S000000001');


--
-- TOC entry 3431 (class 0 OID 18441)
-- Dependencies: 222
-- Data for Name: Treaty_Rate; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Treaty_Rate" ("ID", "RateConnectionDate", "Duration", "TreatyID", "RateID") VALUES ('TR00000001', '2022-03-27', 5, 'T000000003', 'R000000001');
INSERT INTO public."Treaty_Rate" ("ID", "RateConnectionDate", "Duration", "TreatyID", "RateID") VALUES ('TR00000002', '2022-04-07', 5, 'T000000005', 'R000000002');
INSERT INTO public."Treaty_Rate" ("ID", "RateConnectionDate", "Duration", "TreatyID", "RateID") VALUES ('TR00000003', '2022-06-24', 10, 'T000000002', 'R000000003');
INSERT INTO public."Treaty_Rate" ("ID", "RateConnectionDate", "Duration", "TreatyID", "RateID") VALUES ('TR00000004', '2022-02-14', 5, 'T000000001', 'R000000004');
INSERT INTO public."Treaty_Rate" ("ID", "RateConnectionDate", "Duration", "TreatyID", "RateID") VALUES ('TR00000005', '2022-01-15', 5, 'T000000004', 'R000000005');


--
-- TOC entry 3432 (class 0 OID 18455)
-- Dependencies: 223
-- Data for Name: Zone; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Zone" ("ZoneCode", "Coefficient", "ZoneType", "ZoneName", "RateID") VALUES ('+7', 1, 'Internal', 'Russia', 'R000000001');
INSERT INTO public."Zone" ("ZoneCode", "Coefficient", "ZoneType", "ZoneName", "RateID") VALUES ('8', 1, 'Internal', 'Russia', 'R000000001');
INSERT INTO public."Zone" ("ZoneCode", "Coefficient", "ZoneType", "ZoneName", "RateID") VALUES ('+375', 1, 'FriendlyAbroad', 'Belarus', 'R000000002');
INSERT INTO public."Zone" ("ZoneCode", "Coefficient", "ZoneType", "ZoneName", "RateID") VALUES ('+86', 1.2, 'FriendlyAbroad', 'China', 'R000000002');
INSERT INTO public."Zone" ("ZoneCode", "Coefficient", "ZoneType", "ZoneName", "RateID") VALUES ('+1', 2, 'FarAbroad', 'Korea', 'R000000003');


--
-- TOC entry 3247 (class 2606 OID 18369)
-- Name: AdditionalServices AdditionalServices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AdditionalServices"
    ADD CONSTRAINT "AdditionalServices_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 3249 (class 2606 OID 18386)
-- Name: Call Call_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Call"
    ADD CONSTRAINT "Call_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 3257 (class 2606 OID 18440)
-- Name: Treaty PNI; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Treaty"
    ADD CONSTRAINT "PNI" UNIQUE ("PhoneNumber") INCLUDE ("PhoneNumber");


--
-- TOC entry 3251 (class 2606 OID 18400)
-- Name: Rate Rate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rate"
    ADD CONSTRAINT "Rate_pkey" PRIMARY KEY ("RateID");


--
-- TOC entry 3253 (class 2606 OID 18410)
-- Name: Subscriber Subscriber_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Subscriber"
    ADD CONSTRAINT "Subscriber_pkey" PRIMARY KEY ("FullNameID");


--
-- TOC entry 3255 (class 2606 OID 18422)
-- Name: ThirdPartyResources ThirdPartyResources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ThirdPartyResources"
    ADD CONSTRAINT "ThirdPartyResources_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 3261 (class 2606 OID 18452)
-- Name: Treaty_Rate Treaty_Rate_RateID_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Treaty_Rate"
    ADD CONSTRAINT "Treaty_Rate_RateID_key" UNIQUE ("RateID");


--
-- TOC entry 3263 (class 2606 OID 18454)
-- Name: Treaty_Rate Treaty_Rate_TreatyID_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Treaty_Rate"
    ADD CONSTRAINT "Treaty_Rate_TreatyID_key" UNIQUE ("TreatyID");


--
-- TOC entry 3265 (class 2606 OID 18450)
-- Name: Treaty_Rate Treaty_Rate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Treaty_Rate"
    ADD CONSTRAINT "Treaty_Rate_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 3259 (class 2606 OID 18438)
-- Name: Treaty Treaty_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Treaty"
    ADD CONSTRAINT "Treaty_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 3268 (class 2606 OID 18466)
-- Name: Zone Zone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Zone"
    ADD CONSTRAINT "Zone_pkey" PRIMARY KEY ("ZoneCode");


--
-- TOC entry 3266 (class 1259 OID 18527)
-- Name: Zone_RateID_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Zone_RateID_key" ON public."Zone" USING btree ("RateID");


--
-- TOC entry 3269 (class 2606 OID 18467)
-- Name: AdditionalServices_Treaty_Rate AdditionalServices_Treaty_Rate_AdditionalServices_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AdditionalServices_Treaty_Rate"
    ADD CONSTRAINT "AdditionalServices_Treaty_Rate_AdditionalServices_ID_fkey" FOREIGN KEY ("AdditionalServices_ID") REFERENCES public."AdditionalServices"("ID") NOT VALID;


--
-- TOC entry 3270 (class 2606 OID 18472)
-- Name: AdditionalServices_Treaty_Rate AdditionalServices_Treaty_Rate_Treaty_Rate_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AdditionalServices_Treaty_Rate"
    ADD CONSTRAINT "AdditionalServices_Treaty_Rate_Treaty_Rate_ID_fkey" FOREIGN KEY ("Treaty_Rate_ID") REFERENCES public."Treaty_Rate"("ID") NOT VALID;


--
-- TOC entry 3271 (class 2606 OID 18477)
-- Name: Call Call_RateID_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Call"
    ADD CONSTRAINT "Call_RateID_fkey1" FOREIGN KEY ("RateID") REFERENCES public."Treaty_Rate"("RateID") NOT VALID;


--
-- TOC entry 3272 (class 2606 OID 18482)
-- Name: Call Call_TreatyID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Call"
    ADD CONSTRAINT "Call_TreatyID_fkey" FOREIGN KEY ("TreatyID") REFERENCES public."Treaty_Rate"("TreatyID") NOT VALID;


--
-- TOC entry 3273 (class 2606 OID 18487)
-- Name: Call Call_ZoneCode_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Call"
    ADD CONSTRAINT "Call_ZoneCode_fkey" FOREIGN KEY ("ZoneCode") REFERENCES public."Zone"("ZoneCode") NOT VALID;


--
-- TOC entry 3278 (class 2606 OID 18512)
-- Name: Treaty_Rate R_Treaty_Rate; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Treaty_Rate"
    ADD CONSTRAINT "R_Treaty_Rate" FOREIGN KEY ("RateID") REFERENCES public."Rate"("RateID") NOT VALID;


--
-- TOC entry 3279 (class 2606 OID 18517)
-- Name: Treaty_Rate T_Treaty_Rate; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Treaty_Rate"
    ADD CONSTRAINT "T_Treaty_Rate" FOREIGN KEY ("TreatyID") REFERENCES public."Treaty"("ID") NOT VALID;


--
-- TOC entry 3275 (class 2606 OID 18497)
-- Name: ThirdPartyResources_Treaty_Rate ThirdPartyResources_Treaty_Rate_ThirdPartyResources_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ThirdPartyResources_Treaty_Rate"
    ADD CONSTRAINT "ThirdPartyResources_Treaty_Rate_ThirdPartyResources_ID_fkey" FOREIGN KEY ("ThirdPartyResources_ID") REFERENCES public."ThirdPartyResources"("ID") NOT VALID;


--
-- TOC entry 3276 (class 2606 OID 18502)
-- Name: ThirdPartyResources_Treaty_Rate ThirdPartyResources_Treaty_Rate_Treaty_Rate_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ThirdPartyResources_Treaty_Rate"
    ADD CONSTRAINT "ThirdPartyResources_Treaty_Rate_Treaty_Rate_ID_fkey" FOREIGN KEY ("Treaty_Rate_ID") REFERENCES public."Treaty_Rate"("ID") NOT VALID;


--
-- TOC entry 3277 (class 2606 OID 18507)
-- Name: Treaty Treaty_FullNameID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Treaty"
    ADD CONSTRAINT "Treaty_FullNameID_fkey" FOREIGN KEY ("FullNameID") REFERENCES public."Subscriber"("FullNameID") NOT VALID;


--
-- TOC entry 3274 (class 2606 OID 18492)
-- Name: Call Treaty_Rate_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Call"
    ADD CONSTRAINT "Treaty_Rate_ID" FOREIGN KEY ("Treaty_Rate_ID") REFERENCES public."Treaty_Rate"("ID") NOT VALID;


--
-- TOC entry 3280 (class 2606 OID 18522)
-- Name: Zone Zone_RateID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Zone"
    ADD CONSTRAINT "Zone_RateID_fkey" FOREIGN KEY ("RateID") REFERENCES public."Rate"("RateID");


-- Completed on 2023-04-03 21:00:43

--
-- PostgreSQL database dump complete
--

