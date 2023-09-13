PGDMP     7    %                {            postgres    15.2    15.2 F    k           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            l           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            m           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            n           1262    5    postgres    DATABASE     ~   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Pakistan.1252';
    DROP DATABASE postgres;
                postgres    false            o           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    3438                        2615    17514    Аэропорт    SCHEMA     "   CREATE SCHEMA "Аэропорт";
     DROP SCHEMA "Аэропорт";
                postgres    false                        3079    16384 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false            p           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    2            �            1259    17515    airport    TABLE     �   CREATE TABLE "Аэропорт".airport (
    id bigint NOT NULL,
    city character varying(300) NOT NULL,
    name character varying(100) NOT NULL
);
 '   DROP TABLE "Аэропорт".airport;
       Аэропорт         heap    postgres    false    6            �            1259    17518    airport_id_seq    SEQUENCE     �   ALTER TABLE "Аэропорт".airport ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Аэропорт".airport_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999
    CACHE 1
);
            Аэропорт          postgres    false    215    6            �            1259    17519    aviacompany    TABLE     �   CREATE TABLE "Аэропорт".aviacompany (
    name character(40) NOT NULL,
    country character(40) NOT NULL,
    terminal character(40) NOT NULL,
    owner character(120) NOT NULL,
    licence_num character(40) NOT NULL
);
 +   DROP TABLE "Аэропорт".aviacompany;
       Аэропорт         heap    postgres    false    6            �            1259    17522    crew    TABLE       CREATE TABLE "Аэропорт".crew (
    id bigint NOT NULL,
    passport bigint NOT NULL,
    id_flight character(40) NOT NULL,
    health_check boolean NOT NULL,
    access boolean NOT NULL,
    health_check_date date NOT NULL,
    "id staff" bigint
);
 $   DROP TABLE "Аэропорт".crew;
       Аэропорт         heap    postgres    false    6            �            1259    17525    flight    TABLE     �   CREATE TABLE "Аэропорт".flight (
    id character(40) NOT NULL,
    date date NOT NULL,
    variant character(12) NOT NULL
);
 &   DROP TABLE "Аэропорт".flight;
       Аэропорт         heap    postgres    false    6            �            1259    17528 	   passenger    TABLE     �   CREATE TABLE "Аэропорт".passenger (
    passport character(40) NOT NULL,
    email character(40) NOT NULL,
    phone character(40) NOT NULL,
    full_name character(321) NOT NULL
);
 )   DROP TABLE "Аэропорт".passenger;
       Аэропорт         heap    postgres    false    6            �            1259    17537    schedule    TABLE     O  CREATE TABLE "Аэропорт".schedule (
    day character(40) NOT NULL,
    "Время прибытия" timestamp with time zone NOT NULL,
    "Время вылета" timestamp with time zone NOT NULL,
    airport_from bigint NOT NULL,
    airport_to bigint NOT NULL,
    plane bigint NOT NULL,
    id_flight bigint NOT NULL
);
 (   DROP TABLE "Аэропорт".schedule;
       Аэропорт         heap    postgres    false    6            �            1259    17546    ticket    TABLE     3  CREATE TABLE "Аэропорт".ticket (
    id character(40) NOT NULL,
    registration_status boolean NOT NULL,
    buy_date date NOT NULL,
    price integer NOT NULL,
    passport character(40) NOT NULL,
    seat bigint,
    plane bigint,
    "Касса" character(40),
    id_flight bigint NOT NULL
);
 &   DROP TABLE "Аэропорт".ticket;
       Аэропорт         heap    postgres    false    6            �            1259    17674    moscow_flights    VIEW     *  CREATE VIEW "Аэропорт".moscow_flights AS
 SELECT p.full_name,
    t.id_flight
   FROM ("Аэропорт".passenger p
     JOIN "Аэропорт".ticket t ON ((t.passport = p.passport)))
  WHERE ((t.registration_status = true) AND (t.buy_date >= date(now())) AND (t.buy_date <= date((now() + '7 days'::interval))) AND (EXISTS ( SELECT s.day,
            s."Время прибытия",
            s."Время вылета",
            s.airport_from,
            s.airport_to,
            s.plane,
            s.id_flight,
            a.id,
            a.city,
            a.name
           FROM ("Аэропорт".schedule s
             JOIN "Аэропорт".airport a ON ((s.airport_to = a.id)))
          WHERE ((s.id_flight = t.id_flight) AND ((a.city)::text = 'Москва'::text)))));
 -   DROP VIEW "Аэропорт".moscow_flights;
       Аэропорт          postgres    false    226    226    226    226    223    223    223    223    223    223    223    220    220    215    215    215    6            �            1259    17531    plane    TABLE     �   CREATE TABLE "Аэропорт".plane (
    number bigint NOT NULL,
    id_type bigint NOT NULL,
    fix_date date NOT NULL,
    mileage bigint NOT NULL,
    age date
);
 %   DROP TABLE "Аэропорт".plane;
       Аэропорт         heap    postgres    false    6            �            1259    17534 
   plane_type    TABLE     �   CREATE TABLE "Аэропорт".plane_type (
    id bigint NOT NULL,
    capacity bigint NOT NULL,
    load bigint NOT NULL,
    speed bigint NOT NULL,
    fuel_rate bigint NOT NULL,
    seat_number bigint NOT NULL,
    made "char" NOT NULL
);
 *   DROP TABLE "Аэропорт".plane_type;
       Аэропорт         heap    postgres    false    6            �            1259    17679    plane_type_flying_count    VIEW     t  CREATE VIEW "Аэропорт".plane_type_flying_count AS
 SELECT pt.id,
    pt.made,
    count(*) AS flying_count
   FROM (("Аэропорт".plane p
     JOIN "Аэропорт".plane_type pt ON ((p.id_type = pt.id)))
     JOIN "Аэропорт".ticket t ON ((t.plane = p.number)))
  WHERE (t.buy_date >= (CURRENT_DATE - '1 mon'::interval))
  GROUP BY pt.id, pt.made;
 6   DROP VIEW "Аэропорт".plane_type_flying_count;
       Аэропорт          postgres    false    221    221    222    222    226    226    6            �            1259    17540    seat    TABLE     �   CREATE TABLE "Аэропорт".seat (
    type character(10) NOT NULL,
    "row" character(2) NOT NULL,
    class character(20) NOT NULL,
    available boolean NOT NULL,
    id_flight character(40),
    id bigint NOT NULL
);
 $   DROP TABLE "Аэропорт".seat;
       Аэропорт         heap    postgres    false    6            �            1259    17543    staff    TABLE     �   CREATE TABLE "Аэропорт".staff (
    id bigint NOT NULL,
    company character(40) NOT NULL,
    phone integer,
    full_name character(120) NOT NULL,
    airport_id bigint NOT NULL
);
 %   DROP TABLE "Аэропорт".staff;
       Аэропорт         heap    postgres    false    6            �            1259    17549    ticket_office    TABLE     �   CREATE TABLE "Аэропорт".ticket_office (
    id character(40) NOT NULL,
    type character(40) NOT NULL,
    adress character(40) NOT NULL
);
 -   DROP TABLE "Аэропорт".ticket_office;
       Аэропорт         heap    postgres    false    6            �            1259    17552    transit    TABLE     �   CREATE TABLE "Аэропорт".transit (
    id bigint NOT NULL,
    id_airport bigint NOT NULL,
    fly_time time with time zone NOT NULL
);
 '   DROP TABLE "Аэропорт".transit;
       Аэропорт         heap    postgres    false    6            [          0    17515    airport 
   TABLE DATA           =   COPY "Аэропорт".airport (id, city, name) FROM stdin;
    Аэропорт          postgres    false    215   �`       ]          0    17519    aviacompany 
   TABLE DATA           ^   COPY "Аэропорт".aviacompany (name, country, terminal, owner, licence_num) FROM stdin;
    Аэропорт          postgres    false    217   |a       ^          0    17522    crew 
   TABLE DATA           x   COPY "Аэропорт".crew (id, passport, id_flight, health_check, access, health_check_date, "id staff") FROM stdin;
    Аэропорт          postgres    false    218   �b       _          0    17525    flight 
   TABLE DATA           ?   COPY "Аэропорт".flight (id, date, variant) FROM stdin;
    Аэропорт          postgres    false    219   �c       `          0    17528 	   passenger 
   TABLE DATA           R   COPY "Аэропорт".passenger (passport, email, phone, full_name) FROM stdin;
    Аэропорт          postgres    false    220   Ed       a          0    17531    plane 
   TABLE DATA           T   COPY "Аэропорт".plane (number, id_type, fix_date, mileage, age) FROM stdin;
    Аэропорт          postgres    false    221   ?e       b          0    17534 
   plane_type 
   TABLE DATA           i   COPY "Аэропорт".plane_type (id, capacity, load, speed, fuel_rate, seat_number, made) FROM stdin;
    Аэропорт          postgres    false    222   �f       c          0    17537    schedule 
   TABLE DATA           �   COPY "Аэропорт".schedule (day, "Время прибытия", "Время вылета", airport_from, airport_to, plane, id_flight) FROM stdin;
    Аэропорт          postgres    false    223   Ag       d          0    17540    seat 
   TABLE DATA           X   COPY "Аэропорт".seat (type, "row", class, available, id_flight, id) FROM stdin;
    Аэропорт          postgres    false    224   2h       e          0    17543    staff 
   TABLE DATA           V   COPY "Аэропорт".staff (id, company, phone, full_name, airport_id) FROM stdin;
    Аэропорт          postgres    false    225   �h       f          0    17546    ticket 
   TABLE DATA           �   COPY "Аэропорт".ticket (id, registration_status, buy_date, price, passport, seat, plane, "Касса", id_flight) FROM stdin;
    Аэропорт          postgres    false    226   �i       g          0    17549    ticket_office 
   TABLE DATA           E   COPY "Аэропорт".ticket_office (id, type, adress) FROM stdin;
    Аэропорт          postgres    false    227   5j       h          0    17552    transit 
   TABLE DATA           G   COPY "Аэропорт".transit (id, id_airport, fly_time) FROM stdin;
    Аэропорт          postgres    false    228   �j       q           0    0    airport_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('"Аэропорт".airport_id_seq', 21, true);
          Аэропорт          postgres    false    216            �           2606    17556    airport airport_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY "Аэропорт".airport
    ADD CONSTRAINT airport_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY "Аэропорт".airport DROP CONSTRAINT airport_pkey;
       Аэропорт            postgres    false    215            �           2606    17559    plane_type load > 0    CHECK CONSTRAINT     f   ALTER TABLE "Аэропорт".plane_type
    ADD CONSTRAINT "load > 0" CHECK ((load > 0)) NOT VALID;
 F   ALTER TABLE "Аэропорт".plane_type DROP CONSTRAINT "load > 0";
       Аэропорт          postgres    false    222    222            �           2606    17561    plane plane_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY "Аэропорт".plane
    ADD CONSTRAINT plane_pkey PRIMARY KEY (number);
 F   ALTER TABLE ONLY "Аэропорт".plane DROP CONSTRAINT plane_pkey;
       Аэропорт            postgres    false    221            �           2606    17562    ticket price > 0    CHECK CONSTRAINT     d   ALTER TABLE "Аэропорт".ticket
    ADD CONSTRAINT "price > 0" CHECK ((price > 0)) NOT VALID;
 C   ALTER TABLE "Аэропорт".ticket DROP CONSTRAINT "price > 0";
       Аэропорт          postgres    false    226    226            �           2606    17668    schedule schedule_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY "Аэропорт".schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (id_flight);
 L   ALTER TABLE ONLY "Аэропорт".schedule DROP CONSTRAINT schedule_pkey;
       Аэропорт            postgres    false    223            �           2606    17564    seat seat_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY "Аэропорт".seat
    ADD CONSTRAINT seat_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY "Аэропорт".seat DROP CONSTRAINT seat_pkey;
       Аэропорт            postgres    false    224            �           2606    17565    plane_type speed > 0    CHECK CONSTRAINT     h   ALTER TABLE "Аэропорт".plane_type
    ADD CONSTRAINT "speed > 0" CHECK ((speed > 0)) NOT VALID;
 G   ALTER TABLE "Аэропорт".plane_type DROP CONSTRAINT "speed > 0";
       Аэропорт          postgres    false    222    222            �           2606    17567    staff staff_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY "Аэропорт".staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY "Аэропорт".staff DROP CONSTRAINT staff_pkey;
       Аэропорт            postgres    false    225            �           2606    17569    transit transit_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY "Аэропорт".transit
    ADD CONSTRAINT transit_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY "Аэропорт".transit DROP CONSTRAINT transit_pkey;
       Аэропорт            postgres    false    228            �           2606    17571 )   aviacompany Авиакомпания_pkey 
   CONSTRAINT     w   ALTER TABLE ONLY "Аэропорт".aviacompany
    ADD CONSTRAINT "Авиакомпания_pkey" PRIMARY KEY (name);
 a   ALTER TABLE ONLY "Аэропорт".aviacompany DROP CONSTRAINT "Авиакомпания_pkey";
       Аэропорт            postgres    false    217            �           2606    17573    ticket Билет_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY "Аэропорт".ticket
    ADD CONSTRAINT "Билет_pkey" PRIMARY KEY (id);
 N   ALTER TABLE ONLY "Аэропорт".ticket DROP CONSTRAINT "Билет_pkey";
       Аэропорт            postgres    false    226            �           2606    17575    ticket_office Касса_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY "Аэропорт".ticket_office
    ADD CONSTRAINT "Касса_pkey" PRIMARY KEY (id);
 U   ALTER TABLE ONLY "Аэропорт".ticket_office DROP CONSTRAINT "Касса_pkey";
       Аэропорт            postgres    false    227            �           2606    17577    passenger Пассажир_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY "Аэропорт".passenger
    ADD CONSTRAINT "Пассажир_pkey" PRIMARY KEY (passport);
 W   ALTER TABLE ONLY "Аэропорт".passenger DROP CONSTRAINT "Пассажир_pkey";
       Аэропорт            postgres    false    220            �           2606    17581    flight Рейс_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY "Аэропорт".flight
    ADD CONSTRAINT "Рейс_pkey" PRIMARY KEY (id);
 L   ALTER TABLE ONLY "Аэропорт".flight DROP CONSTRAINT "Рейс_pkey";
       Аэропорт            postgres    false    219            �           2606    17583 '   plane_type Тип самолёта_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY "Аэропорт".plane_type
    ADD CONSTRAINT "Тип самолёта_pkey" PRIMARY KEY (id);
 _   ALTER TABLE ONLY "Аэропорт".plane_type DROP CONSTRAINT "Тип самолёта_pkey";
       Аэропорт            postgres    false    222            �           2606    17585    crew Экипаж_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY "Аэропорт".crew
    ADD CONSTRAINT "Экипаж_pkey" PRIMARY KEY (id);
 N   ALTER TABLE ONLY "Аэропорт".crew DROP CONSTRAINT "Экипаж_pkey";
       Аэропорт            postgres    false    218            �           1259    17686    flight_number_idx    INDEX     p   CREATE INDEX flight_number_idx ON "Аэропорт".schedule USING btree (day) WHERE (day = 'Monday'::bpchar);
 1   DROP INDEX "Аэропорт".flight_number_idx;
       Аэропорт            postgres    false    223    223            �           1259    17684    schedule_request_idx    INDEX     �   CREATE INDEX schedule_request_idx ON "Аэропорт".schedule USING btree (airport_from, airport_to, "Время прибытия", "Время вылета");
 4   DROP INDEX "Аэропорт".schedule_request_idx;
       Аэропорт            postgres    false    223    223    223    223            �           2606    17586    crew crew_id staff_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Аэропорт".crew
    ADD CONSTRAINT "crew_id staff_fkey" FOREIGN KEY ("id staff") REFERENCES "Аэропорт".staff(id) NOT VALID;
 O   ALTER TABLE ONLY "Аэропорт".crew DROP CONSTRAINT "crew_id staff_fkey";
       Аэропорт          postgres    false    3254    218    225            �           2606    17591    seat id рейса    FK CONSTRAINT     �   ALTER TABLE ONLY "Аэропорт".seat
    ADD CONSTRAINT "id рейса" FOREIGN KEY (id_flight) REFERENCES "Аэропорт".flight(id) NOT VALID;
 J   ALTER TABLE ONLY "Аэропорт".seat DROP CONSTRAINT "id рейса";
       Аэропорт          postgres    false    219    3240    224            �           2606    17596    schedule plane    FK CONSTRAINT     �   ALTER TABLE ONLY "Аэропорт".schedule
    ADD CONSTRAINT plane FOREIGN KEY (plane) REFERENCES "Аэропорт".plane(number) NOT VALID;
 D   ALTER TABLE ONLY "Аэропорт".schedule DROP CONSTRAINT plane;
       Аэропорт          postgres    false    223    221    3244            �           2606    17601    plane plane_id_type_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Аэропорт".plane
    ADD CONSTRAINT plane_id_type_fkey FOREIGN KEY (id_type) REFERENCES "Аэропорт".plane_type(id);
 N   ALTER TABLE ONLY "Аэропорт".plane DROP CONSTRAINT plane_id_type_fkey;
       Аэропорт          postgres    false    221    222    3246            �           2606    17606 #   schedule schedule_airport_from_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Аэропорт".schedule
    ADD CONSTRAINT schedule_airport_from_fkey FOREIGN KEY (airport_from) REFERENCES "Аэропорт".airport(id) NOT VALID;
 Y   ALTER TABLE ONLY "Аэропорт".schedule DROP CONSTRAINT schedule_airport_from_fkey;
       Аэропорт          postgres    false    3234    215    223            �           2606    17611 !   schedule schedule_airport_to_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Аэропорт".schedule
    ADD CONSTRAINT schedule_airport_to_fkey FOREIGN KEY (airport_to) REFERENCES "Аэропорт".airport(id) NOT VALID;
 W   ALTER TABLE ONLY "Аэропорт".schedule DROP CONSTRAINT schedule_airport_to_fkey;
       Аэропорт          postgres    false    223    215    3234            �           2606    17616    staff staff_airport_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Аэропорт".staff
    ADD CONSTRAINT staff_airport_id_fkey FOREIGN KEY (airport_id) REFERENCES "Аэропорт".airport(id) NOT VALID;
 Q   ALTER TABLE ONLY "Аэропорт".staff DROP CONSTRAINT staff_airport_id_fkey;
       Аэропорт          postgres    false    3234    225    215            �           2606    17669    ticket ticket_id_flight_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Аэропорт".ticket
    ADD CONSTRAINT ticket_id_flight_fkey FOREIGN KEY (id_flight) REFERENCES "Аэропорт".schedule(id_flight) NOT VALID;
 R   ALTER TABLE ONLY "Аэропорт".ticket DROP CONSTRAINT ticket_id_flight_fkey;
       Аэропорт          postgres    false    3249    226    223            �           2606    17626    ticket ticket_plane_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Аэропорт".ticket
    ADD CONSTRAINT ticket_plane_fkey FOREIGN KEY (plane) REFERENCES "Аэропорт".plane(number) NOT VALID;
 N   ALTER TABLE ONLY "Аэропорт".ticket DROP CONSTRAINT ticket_plane_fkey;
       Аэропорт          postgres    false    3244    221    226            �           2606    17631    ticket ticket_seat_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Аэропорт".ticket
    ADD CONSTRAINT ticket_seat_fkey FOREIGN KEY (seat) REFERENCES "Аэропорт".seat(id) NOT VALID;
 M   ALTER TABLE ONLY "Аэропорт".ticket DROP CONSTRAINT ticket_seat_fkey;
       Аэропорт          postgres    false    226    224    3252            �           2606    17636    transit transit_id_airport_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Аэропорт".transit
    ADD CONSTRAINT transit_id_airport_fkey FOREIGN KEY (id_airport) REFERENCES "Аэропорт".airport(id);
 U   ALTER TABLE ONLY "Аэропорт".transit DROP CONSTRAINT transit_id_airport_fkey;
       Аэропорт          postgres    false    228    3234    215            �           2606    17641    ticket Касса    FK CONSTRAINT     �   ALTER TABLE ONLY "Аэропорт".ticket
    ADD CONSTRAINT "Касса" FOREIGN KEY ("Касса") REFERENCES "Аэропорт".ticket_office(id) NOT VALID;
 I   ALTER TABLE ONLY "Аэропорт".ticket DROP CONSTRAINT "Касса";
       Аэропорт          postgres    false    227    226    3258            �           2606    17646 ;   ticket Паспортные данные пассажира    FK CONSTRAINT     �   ALTER TABLE ONLY "Аэропорт".ticket
    ADD CONSTRAINT "Паспортные данные пассажира" FOREIGN KEY (passport) REFERENCES "Аэропорт".passenger(passport) NOT VALID;
 s   ALTER TABLE ONLY "Аэропорт".ticket DROP CONSTRAINT "Паспортные данные пассажира";
       Аэропорт          postgres    false    3242    226    220            �           2606    17656    staff компания    FK CONSTRAINT     �   ALTER TABLE ONLY "Аэропорт".staff
    ADD CONSTRAINT "компания" FOREIGN KEY (company) REFERENCES "Аэропорт".aviacompany(name) NOT VALID;
 N   ALTER TABLE ONLY "Аэропорт".staff DROP CONSTRAINT "компания";
       Аэропорт          postgres    false    3236    225    217            [   �   x�u�;
�@��z�*f!g�T�l�b������Y�͎l���O�A�����W�9[��*(��\�BͩT��~���䑇/�{I��+���&��1#@tB�B�B�B�"�EL�1��y��^�և�Z��ӋD��sv�K�������9�y.>t�K�����      ]     x����n�0�g�)�*�8���h~���v�B�J-���i������� 5z��t'n[O�.A*�D&h<H����#4�I @�h2O�p�&��gWIF�.U�l��2�`�������'�9iu��q&v���Rea���Η9`%�{�8�#����[�l��.�He;�'��0�V׵�#ץ���i���ݨW��*�a�(�N$���r�
W�I�׀Q�9��̀Wyu�P�z��Д�P�8w:)���d�\I��x�Z� ���      ^   �   x���MJ�1���
/P�w����� �z�s�q�"�J_�I�_��@kµJH�Q6&\����2+x��꿋��,D�Ϣ��HՄ�RF�yA��8���=�`��F�ا������4<�K2�}��>�qG��0�E�k7��s�f�Gq�[�9z��0�^Z9.�5}����W'0��[+�%�믏� d
���]�����&�:t
�Mle���x����qߪ裐      _   �   x��ӱ
1�y��@$M[{7VTo��I8�=P|[��Hɔ���[JVvR���}~���`-�@�Q��@����v@ǂ�� #�2f3���f�/�!�1D�M6��E������3Y�1u�� �á����	bIp:#y�X� �� |G��K      `   �   x���=�0�9���U��fU�f����6b��^t2�X�9<��[��Ɠp��!�*~Vb)i}��U��� �0�
���b�"�(���\��Lw�%ې2m�/�
���b�⿼��Lw�%ېLe�����ޫ<Tم[\��%Z�4A�C��9n�%ې�����x����*U@v�#-�؊�'�a�jk��g�6$/���wY��{��* �ŵ�ш]��e�SJ�aG�      a   �  x�MS٭#1����D[>z���x��+x¡H�651������G~?S�%si�')�)Y�%q)�C��+��(R�����yґS\|!��D=�!�h!�o�=�%�mD��6	b�:!����M�/�6YA�x"�־�f�DL!p1�Jjh�N���ȪR�"ნ�qc��*�	�$Gވ�t,�~-��g
���-H���]L��T*u//���<Lw����]��b?���#1���6,/�í�-��ȷ"��N��r9��rkQ����,Z%�S��.� Dd$�b���q�ʽ4��R�@���e�:7G��o�9�ܙ:�quh�컟�Ƶ
��a[�C�_�^>��^6��[x^����W��-	�o�����\`��      b   V   x����0�x��v�4}�R&���Q���@�c�����X"x��I���q[C5�Q2�bYgTK�l��k��
�k�Av�������      c   �   x�����@�ݧ��`v�~�{ ;;I��c�ۻ^���PN���������2??)�fCU��6dG�ΘA�����lK����~*P�*!�csi�(�%kX�|-Pl3v�U`�����Lȗ�a���>� e8�u�?x�a���2�
j�����)��{<9�L"�x�S�r�`�ǃ�I��U+a�ǃ�.-�P���a��;P�i��oQϧ�      d   �   x�sM���ϭTPP�40���tq�qU@�%�.>��F�
�!�Siqf^jq1�<#�pO?�p4Ei�����(5�2Tp�I4Ϙ��3�y �k�1�+�Mp���B����g�˿&Ěg����� �-A�      e   �   x����
�0�盧�I�c�-� �]�4�@�B�����f�H�|�||�r���B�`<I��QZZ�b��� #*�=Ҁ�*+���C�ϳ��^��2"i��$��Q�
�R�OPJ#Z_Jeb.ی���o^��6/Ṕ�Z�����pQ(� �dpF�.|���5�Ak7J4�l�U4J:k�w��H���      f   �   x���1�0��9E.���		c�Ё�0v�	z՘�8S�'��O"��?`bA��E�mA����K24���z"�����^MIMێ��N�dR���������)�i~�����j39z"��$��۞DM��t��5%39z"L��!�v�V      g   �   x���K� ൜bN`���XZ�NS�t��DC)�����2��'_��6�#�k��N�X8I���R�o��]P���5軴�`Y��`�������M[����i`��g�tI��q�=-�#��s�ڦ.CW�h?J�W�p�3���K����e�      h   Q   x�m��	�0C�oy�B�#mf��s4���0��Щzh��Ɏ w$91�'.��%w�RF)�KtX|���n"� �\)A     