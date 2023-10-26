PGDMP                          {            postgres    11.21    11.21 2    B           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            C           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            D           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            E           1262    13012    postgres    DATABASE     �   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Russian_Russia.1251' LC_CTYPE = 'Russian_Russia.1251';
    DROP DATABASE postgres;
             postgres    false            F           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                  postgres    false    2885                        2615    16401    publishing_office_scheme    SCHEMA     (   CREATE SCHEMA publishing_office_scheme;
 &   DROP SCHEMA publishing_office_scheme;
             postgres    false                        3079    16384 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                  false            G           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                       false    1            �            1259    16552    author    TABLE       CREATE TABLE publishing_office_scheme.author (
    author_id integer NOT NULL,
    email character varying(40) NOT NULL,
    first_name character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    patronymic_name character varying(20)
);
 ,   DROP TABLE publishing_office_scheme.author;
       publishing_office_scheme         postgres    false    8            �            1259    16559    book    TABLE     �   CREATE TABLE publishing_office_scheme.book (
    book_id integer NOT NULL,
    pages_count integer NOT NULL,
    category_id integer NOT NULL,
    publication_year date NOT NULL,
    name character varying(20) NOT NULL
);
 *   DROP TABLE publishing_office_scheme.book;
       publishing_office_scheme         postgres    false    8            �            1259    16576    book_author    TABLE     �   CREATE TABLE publishing_office_scheme.book_author (
    book_id integer NOT NULL,
    author_id integer NOT NULL,
    email character varying(40) NOT NULL,
    author_index integer NOT NULL,
    id integer NOT NULL
);
 1   DROP TABLE publishing_office_scheme.book_author;
       publishing_office_scheme         postgres    false    8            �            1259    16547    book_category    TABLE     �   CREATE TABLE publishing_office_scheme.book_category (
    category_id integer NOT NULL,
    name character varying(20) NOT NULL
);
 3   DROP TABLE publishing_office_scheme.book_category;
       publishing_office_scheme         postgres    false    8            �            1259    16564    circulation    TABLE       CREATE TABLE publishing_office_scheme.circulation (
    circulation_id integer NOT NULL,
    task_id integer NOT NULL,
    book_id integer NOT NULL,
    "ISBN" character varying(17) NOT NULL,
    price integer,
    type character varying(20) NOT NULL,
    date date NOT NULL
);
 1   DROP TABLE publishing_office_scheme.circulation;
       publishing_office_scheme         postgres    false    8            �            1259    16588    customer    TABLE     :  CREATE TABLE publishing_office_scheme.customer (
    customer_id integer NOT NULL,
    phone_number character varying(14) NOT NULL,
    address character varying(40) NOT NULL,
    first_name character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    patronymic_name character varying(20)
);
 .   DROP TABLE publishing_office_scheme.customer;
       publishing_office_scheme         postgres    false    8            �            1259    16581    order    TABLE     
  CREATE TABLE publishing_office_scheme."order" (
    order_id integer NOT NULL,
    customer_id integer NOT NULL,
    phone_number character varying(14) NOT NULL,
    task_id integer NOT NULL,
    book_id integer NOT NULL,
    "ISBN" character varying(17) NOT NULL,
    job_status character varying(11) DEFAULT 'в обработке'::character varying NOT NULL,
    payment_status character varying(14) DEFAULT 'ожидает оплаты'::character varying NOT NULL,
    deadline date,
    order_date date NOT NULL
);
 -   DROP TABLE publishing_office_scheme."order";
       publishing_office_scheme         postgres    false    8            �            1259    16569    technical_task    TABLE       CREATE TABLE publishing_office_scheme.technical_task (
    task_id integer NOT NULL,
    book_id integer NOT NULL,
    copies_number integer NOT NULL,
    is_illustration boolean NOT NULL,
    "ISBN" character varying(17) NOT NULL,
    binding_type character varying(20) NOT NULL
);
 4   DROP TABLE publishing_office_scheme.technical_task;
       publishing_office_scheme         postgres    false    8            9          0    16552    author 
   TABLE DATA               l   COPY publishing_office_scheme.author (author_id, email, first_name, last_name, patronymic_name) FROM stdin;
    publishing_office_scheme       postgres    false    198   �F       :          0    16559    book 
   TABLE DATA               k   COPY publishing_office_scheme.book (book_id, pages_count, category_id, publication_year, name) FROM stdin;
    publishing_office_scheme       postgres    false    199   �G       =          0    16576    book_author 
   TABLE DATA               d   COPY publishing_office_scheme.book_author (book_id, author_id, email, author_index, id) FROM stdin;
    publishing_office_scheme       postgres    false    202   MH       8          0    16547    book_category 
   TABLE DATA               L   COPY publishing_office_scheme.book_category (category_id, name) FROM stdin;
    publishing_office_scheme       postgres    false    197   �H       ;          0    16564    circulation 
   TABLE DATA               t   COPY publishing_office_scheme.circulation (circulation_id, task_id, book_id, "ISBN", price, type, date) FROM stdin;
    publishing_office_scheme       postgres    false    200   I       ?          0    16588    customer 
   TABLE DATA               �   COPY publishing_office_scheme.customer (customer_id, phone_number, address, first_name, last_name, patronymic_name) FROM stdin;
    publishing_office_scheme       postgres    false    204   ~I       >          0    16581    order 
   TABLE DATA               �   COPY publishing_office_scheme."order" (order_id, customer_id, phone_number, task_id, book_id, "ISBN", job_status, payment_status, deadline, order_date) FROM stdin;
    publishing_office_scheme       postgres    false    203   MJ       <          0    16569    technical_task 
   TABLE DATA               �   COPY publishing_office_scheme.technical_task (task_id, book_id, copies_number, is_illustration, "ISBN", binding_type) FROM stdin;
    publishing_office_scheme       postgres    false    201   �J       �
           2606    16558    author author_email_key 
   CONSTRAINT     e   ALTER TABLE ONLY publishing_office_scheme.author
    ADD CONSTRAINT author_email_key UNIQUE (email);
 S   ALTER TABLE ONLY publishing_office_scheme.author DROP CONSTRAINT author_email_key;
       publishing_office_scheme         postgres    false    198            �
           2606    16785    book_author author_index    CHECK CONSTRAINT     x   ALTER TABLE publishing_office_scheme.book_author
    ADD CONSTRAINT author_index CHECK ((author_index >= 0)) NOT VALID;
 O   ALTER TABLE publishing_office_scheme.book_author DROP CONSTRAINT author_index;
       publishing_office_scheme       postgres    false    202    202            �
           2606    16556    author author_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY publishing_office_scheme.author
    ADD CONSTRAINT author_pkey PRIMARY KEY (author_id);
 N   ALTER TABLE ONLY publishing_office_scheme.author DROP CONSTRAINT author_pkey;
       publishing_office_scheme         postgres    false    198            �
           2606    16580    book_author book_author_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY publishing_office_scheme.book_author
    ADD CONSTRAINT book_author_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY publishing_office_scheme.book_author DROP CONSTRAINT book_author_pkey;
       publishing_office_scheme         postgres    false    202            �
           2606    16551     book_category book_category_pkey 
   CONSTRAINT     y   ALTER TABLE ONLY publishing_office_scheme.book_category
    ADD CONSTRAINT book_category_pkey PRIMARY KEY (category_id);
 \   ALTER TABLE ONLY publishing_office_scheme.book_category DROP CONSTRAINT book_category_pkey;
       publishing_office_scheme         postgres    false    197            �
           2606    16563    book book_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY publishing_office_scheme.book
    ADD CONSTRAINT book_pkey PRIMARY KEY (book_id);
 J   ALTER TABLE ONLY publishing_office_scheme.book DROP CONSTRAINT book_pkey;
       publishing_office_scheme         postgres    false    199            �
           2606    16568    circulation circulation_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY publishing_office_scheme.circulation
    ADD CONSTRAINT circulation_pkey PRIMARY KEY (circulation_id);
 X   ALTER TABLE ONLY publishing_office_scheme.circulation DROP CONSTRAINT circulation_pkey;
       publishing_office_scheme         postgres    false    200            �
           2606    16594 "   customer customer_phone_number_key 
   CONSTRAINT     w   ALTER TABLE ONLY publishing_office_scheme.customer
    ADD CONSTRAINT customer_phone_number_key UNIQUE (phone_number);
 ^   ALTER TABLE ONLY publishing_office_scheme.customer DROP CONSTRAINT customer_phone_number_key;
       publishing_office_scheme         postgres    false    204            �
           2606    16592    customer customer_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY publishing_office_scheme.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);
 R   ALTER TABLE ONLY publishing_office_scheme.customer DROP CONSTRAINT customer_pkey;
       publishing_office_scheme         postgres    false    204            �
           2606    16786    order job_status    CHECK CONSTRAINT     �   ALTER TABLE publishing_office_scheme."order"
    ADD CONSTRAINT job_status CHECK (((job_status)::text = ANY (ARRAY[('in process'::character varying)::text, ('done'::character varying)::text]))) NOT VALID;
 I   ALTER TABLE publishing_office_scheme."order" DROP CONSTRAINT job_status;
       publishing_office_scheme       postgres    false    203    203            �
           2606    16587    order order_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY publishing_office_scheme."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (order_id);
 N   ALTER TABLE ONLY publishing_office_scheme."order" DROP CONSTRAINT order_pkey;
       publishing_office_scheme         postgres    false    203            �
           2606    16575 &   technical_task technical_task_ISBN_key 
   CONSTRAINT     w   ALTER TABLE ONLY publishing_office_scheme.technical_task
    ADD CONSTRAINT "technical_task_ISBN_key" UNIQUE ("ISBN");
 d   ALTER TABLE ONLY publishing_office_scheme.technical_task DROP CONSTRAINT "technical_task_ISBN_key";
       publishing_office_scheme         postgres    false    201            �
           2606    16573 "   technical_task technical_task_pkey 
   CONSTRAINT     w   ALTER TABLE ONLY publishing_office_scheme.technical_task
    ADD CONSTRAINT technical_task_pkey PRIMARY KEY (task_id);
 ^   ALTER TABLE ONLY publishing_office_scheme.technical_task DROP CONSTRAINT technical_task_pkey;
       publishing_office_scheme         postgres    false    201            �
           2606    16615    circulation ISBN    FK CONSTRAINT     �   ALTER TABLE ONLY publishing_office_scheme.circulation
    ADD CONSTRAINT "ISBN" FOREIGN KEY ("ISBN") REFERENCES publishing_office_scheme.technical_task("ISBN") NOT VALID;
 N   ALTER TABLE ONLY publishing_office_scheme.circulation DROP CONSTRAINT "ISBN";
       publishing_office_scheme       postgres    false    200    2727    201            �
           2606    16620 
   order ISBN    FK CONSTRAINT     �   ALTER TABLE ONLY publishing_office_scheme."order"
    ADD CONSTRAINT "ISBN" FOREIGN KEY ("ISBN") REFERENCES publishing_office_scheme.technical_task("ISBN") NOT VALID;
 J   ALTER TABLE ONLY publishing_office_scheme."order" DROP CONSTRAINT "ISBN";
       publishing_office_scheme       postgres    false    2727    201    203            �
           2606    16605    book_author author_id    FK CONSTRAINT     �   ALTER TABLE ONLY publishing_office_scheme.book_author
    ADD CONSTRAINT author_id FOREIGN KEY (author_id) REFERENCES publishing_office_scheme.author(author_id) NOT VALID;
 Q   ALTER TABLE ONLY publishing_office_scheme.book_author DROP CONSTRAINT author_id;
       publishing_office_scheme       postgres    false    2721    202    198            �
           2606    16600    book_author book_id    FK CONSTRAINT     �   ALTER TABLE ONLY publishing_office_scheme.book_author
    ADD CONSTRAINT book_id FOREIGN KEY (book_id) REFERENCES publishing_office_scheme.book(book_id) NOT VALID;
 O   ALTER TABLE ONLY publishing_office_scheme.book_author DROP CONSTRAINT book_id;
       publishing_office_scheme       postgres    false    202    199    2723            �
           2606    16625    technical_task book_id    FK CONSTRAINT     �   ALTER TABLE ONLY publishing_office_scheme.technical_task
    ADD CONSTRAINT book_id FOREIGN KEY (book_id) REFERENCES publishing_office_scheme.book(book_id);
 R   ALTER TABLE ONLY publishing_office_scheme.technical_task DROP CONSTRAINT book_id;
       publishing_office_scheme       postgres    false    2723    201    199            �
           2606    16630    circulation book_id    FK CONSTRAINT     �   ALTER TABLE ONLY publishing_office_scheme.circulation
    ADD CONSTRAINT book_id FOREIGN KEY (book_id) REFERENCES publishing_office_scheme.book(book_id) NOT VALID;
 O   ALTER TABLE ONLY publishing_office_scheme.circulation DROP CONSTRAINT book_id;
       publishing_office_scheme       postgres    false    2723    200    199            �
           2606    16635    order book_id    FK CONSTRAINT     �   ALTER TABLE ONLY publishing_office_scheme."order"
    ADD CONSTRAINT book_id FOREIGN KEY (book_id) REFERENCES publishing_office_scheme.book(book_id) NOT VALID;
 K   ALTER TABLE ONLY publishing_office_scheme."order" DROP CONSTRAINT book_id;
       publishing_office_scheme       postgres    false    2723    203    199            �
           2606    16595    book category_id    FK CONSTRAINT     �   ALTER TABLE ONLY publishing_office_scheme.book
    ADD CONSTRAINT category_id FOREIGN KEY (category_id) REFERENCES publishing_office_scheme.book_category(category_id) NOT VALID;
 L   ALTER TABLE ONLY publishing_office_scheme.book DROP CONSTRAINT category_id;
       publishing_office_scheme       postgres    false    199    197    2717            �
           2606    16640    order customer_id    FK CONSTRAINT     �   ALTER TABLE ONLY publishing_office_scheme."order"
    ADD CONSTRAINT customer_id FOREIGN KEY (customer_id) REFERENCES publishing_office_scheme.customer(customer_id) NOT VALID;
 O   ALTER TABLE ONLY publishing_office_scheme."order" DROP CONSTRAINT customer_id;
       publishing_office_scheme       postgres    false    204    203    2737            �
           2606    16610    book_author email    FK CONSTRAINT     �   ALTER TABLE ONLY publishing_office_scheme.book_author
    ADD CONSTRAINT email FOREIGN KEY (email) REFERENCES publishing_office_scheme.author(email) NOT VALID;
 M   ALTER TABLE ONLY publishing_office_scheme.book_author DROP CONSTRAINT email;
       publishing_office_scheme       postgres    false    198    2719    202            �
           2606    16645    order phone_number    FK CONSTRAINT     �   ALTER TABLE ONLY publishing_office_scheme."order"
    ADD CONSTRAINT phone_number FOREIGN KEY (phone_number) REFERENCES publishing_office_scheme.customer(phone_number) NOT VALID;
 P   ALTER TABLE ONLY publishing_office_scheme."order" DROP CONSTRAINT phone_number;
       publishing_office_scheme       postgres    false    203    204    2735            �
           2606    16650    circulation task_id    FK CONSTRAINT     �   ALTER TABLE ONLY publishing_office_scheme.circulation
    ADD CONSTRAINT task_id FOREIGN KEY (task_id) REFERENCES publishing_office_scheme.technical_task(task_id) NOT VALID;
 O   ALTER TABLE ONLY publishing_office_scheme.circulation DROP CONSTRAINT task_id;
       publishing_office_scheme       postgres    false    200    2729    201            �
           2606    16655    order task_id    FK CONSTRAINT     �   ALTER TABLE ONLY publishing_office_scheme."order"
    ADD CONSTRAINT task_id FOREIGN KEY (task_id) REFERENCES publishing_office_scheme.technical_task(task_id) NOT VALID;
 K   ALTER TABLE ONLY publishing_office_scheme."order" DROP CONSTRAINT task_id;
       publishing_office_scheme       postgres    false    203    2729    201            9   �   x�]�=�@D�c"����&$&�6n��nל��{|4�m޼dg� �T�{��:^����D{��̽���S�B�.��	�����-dRTZ%��ϵB�mנ��q0��5?���ʲ��<%ȃ��l�>��sg��2�Bkv�!떅G�R[uq�T|�w]c~V�^�      :   �   x�Mͻ
1��z�)�J&���l��66Y7�S�E2���&�����x2@`4���:��IݾRxHk�F�i`���E=R$������'e~�I�8W���	Z\y��=��p�c��<�ߎ+��EuQJ?�s����*�      =   i   x�U�1�0D�z|�N��1l�%6
�=iS=i�0�c���1ޒ���2_bW�L��9tľ��XU�����Tf�V�q(HZ���_O����"z��-!      8   E   x�3�t)J�M�2�N�L�KN�M�L.����2���/*�/�2�tK�+I,��2�tI-IJ��r��qqq [=�      ;   S   x�E�1�@�z�#��dؿ�@	('E���h�g�	͋�Gy�*���>Ɖ�l�%:�ݜ��K���$��~���i�df?��k      ?   �   x�mϻ
�@�z�+��3��eDA�b��f��,&��Ŀw}T�-�B��+HH�d����j�B�H��Ɲ,̼��uC���B��_~��ae-���ދ2�ůJJ3�8I��/�������wM��UQ�&l*��w�|e�-w�=�]���i�gi�,��y��έ��:p�>=��R�jP�      >   u   x�E�1�0���>{e���9+j+�����_5a�'?��u����bT�AT�ż�B
��}�q�wڞu"SK�E����Rh�y�=b"5-
�!�B��e���~_'d'd��2�Ȃ�      <   i   x�E�A
�@D�u�]J�z&����Q$�L��Z>������ddO;���a�)�D�E�Sұ?��
TPN�|H�r�V5���w���8����)ؾ����޹��     