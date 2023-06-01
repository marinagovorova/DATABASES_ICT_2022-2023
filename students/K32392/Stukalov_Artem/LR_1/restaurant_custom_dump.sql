PGDMP  	    %    5                {         
   restaurant    14.3    14.3 ]    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16387 
   restaurant    DATABASE     _   CREATE DATABASE restaurant WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.UTF-8';
    DROP DATABASE restaurant;
             	   astukalov    false            �            1259    20321    bookings    TABLE     I  CREATE TABLE public.bookings (
    booking_id bigint NOT NULL,
    name_for_booking character varying(80),
    is_confirmed boolean NOT NULL,
    booking_datetime timestamp without time zone NOT NULL,
    table_id bigint NOT NULL,
    CONSTRAINT bookings_booking_datetime_check CHECK ((booking_datetime >= CURRENT_TIMESTAMP))
);
    DROP TABLE public.bookings;
       public         heap 	   astukalov    false            �            1259    20320    bookings_booking_id_seq    SEQUENCE     �   ALTER TABLE public.bookings ALTER COLUMN booking_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bookings_booking_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       	   astukalov    false    234            �            1259    20299    cooking_progress    TABLE     9  CREATE TABLE public.cooking_progress (
    dish_id bigint NOT NULL,
    order_id bigint NOT NULL,
    employee_id bigint NOT NULL,
    dish_count integer NOT NULL,
    is_ready boolean NOT NULL,
    guest_wishes character varying(200),
    CONSTRAINT cooking_progress_dish_count_check CHECK ((dish_count > 0))
);
 $   DROP TABLE public.cooking_progress;
       public         heap 	   astukalov    false            �            1259    20139    dish_categories    TABLE     w   CREATE TABLE public.dish_categories (
    dish_category_id bigint NOT NULL,
    name character varying(80) NOT NULL
);
 #   DROP TABLE public.dish_categories;
       public         heap 	   astukalov    false            �            1259    20138 $   dish_categories_dish_category_id_seq    SEQUENCE     �   ALTER TABLE public.dish_categories ALTER COLUMN dish_category_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.dish_categories_dish_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       	   astukalov    false    212            �            1259    20147    dishes    TABLE       CREATE TABLE public.dishes (
    dish_id bigint NOT NULL,
    dish_category_id bigint,
    name character varying(80) NOT NULL,
    price integer NOT NULL,
    recipe character varying(1200) NOT NULL,
    CONSTRAINT dishes_price_check CHECK ((price > 0))
);
    DROP TABLE public.dishes;
       public         heap 	   astukalov    false            �            1259    20146    dishes_dish_id_seq    SEQUENCE     �   ALTER TABLE public.dishes ALTER COLUMN dish_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.dishes_dish_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       	   astukalov    false    214            �            1259    20131 	   employees    TABLE     .  CREATE TABLE public.employees (
    employee_id bigint NOT NULL,
    pasport character varying(20) NOT NULL,
    fio character varying(120) NOT NULL,
    postition character varying(80) NOT NULL,
    category character varying(80) NOT NULL,
    salary integer NOT NULL,
    CONSTRAINT employees_category_check CHECK (((category)::text = ANY ((ARRAY['Кухня'::character varying, 'Обслуживание'::character varying, 'Администрация'::character varying])::text[]))),
    CONSTRAINT employees_salary_check CHECK ((salary >= 16242))
);
    DROP TABLE public.employees;
       public         heap 	   astukalov    false            �            1259    20130    employees_employee_id_seq    SEQUENCE     �   ALTER TABLE public.employees ALTER COLUMN employee_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.employees_employee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       	   astukalov    false    210            �            1259    20266    orders    TABLE     �  CREATE TABLE public.orders (
    order_id bigint NOT NULL,
    table_id bigint,
    employee_id bigint,
    open_datetime timestamp without time zone NOT NULL,
    close_datetime timestamp without time zone,
    is_paid boolean NOT NULL,
    CONSTRAINT orders_check CHECK ((close_datetime > open_datetime)),
    CONSTRAINT orders_close_datetime_check CHECK ((close_datetime >= CURRENT_TIMESTAMP)),
    CONSTRAINT orders_open_datetime_check CHECK ((open_datetime >= CURRENT_TIMESTAMP))
);
    DROP TABLE public.orders;
       public         heap 	   astukalov    false            �            1259    20265    orders_order_id_seq    SEQUENCE     �   ALTER TABLE public.orders ALTER COLUMN order_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.orders_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       	   astukalov    false    230            �            1259    20175    product_providers    TABLE     t   CREATE TABLE public.product_providers (
    provider_id bigint NOT NULL,
    name character varying(80) NOT NULL
);
 %   DROP TABLE public.product_providers;
       public         heap 	   astukalov    false            �            1259    20174 !   product_providers_provider_id_seq    SEQUENCE     �   ALTER TABLE public.product_providers ALTER COLUMN provider_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_providers_provider_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       	   astukalov    false    218            �            1259    20183    product_purchases    TABLE     8  CREATE TABLE public.product_purchases (
    product_purchase_id bigint NOT NULL,
    product_id bigint,
    provider_id bigint,
    volume integer NOT NULL,
    price integer NOT NULL,
    purchase_date date NOT NULL,
    expiration_date date NOT NULL,
    CONSTRAINT product_purchases_check CHECK ((expiration_date > purchase_date)),
    CONSTRAINT product_purchases_expiration_date_check CHECK ((expiration_date > CURRENT_DATE)),
    CONSTRAINT product_purchases_price_check CHECK ((price > 0)),
    CONSTRAINT product_purchases_volume_check CHECK ((volume > 0))
);
 %   DROP TABLE public.product_purchases;
       public         heap 	   astukalov    false            �            1259    20182 )   product_purchases_product_purchase_id_seq    SEQUENCE     �   ALTER TABLE public.product_purchases ALTER COLUMN product_purchase_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_purchases_product_purchase_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       	   astukalov    false    220            �            1259    20163    products    TABLE       CREATE TABLE public.products (
    product_id bigint NOT NULL,
    name character varying(80) NOT NULL,
    max_price integer NOT NULL,
    required_volume integer NOT NULL,
    calories integer NOT NULL,
    stock_volume integer NOT NULL,
    CONSTRAINT products_calories_check CHECK ((calories > 0)),
    CONSTRAINT products_max_price_check CHECK ((max_price > 0)),
    CONSTRAINT products_required_volume_check CHECK ((required_volume >= 0)),
    CONSTRAINT products_stock_volume_check CHECK ((stock_volume >= 0))
);
    DROP TABLE public.products;
       public         heap 	   astukalov    false            �            1259    20202    products_in_dishes    TABLE     �   CREATE TABLE public.products_in_dishes (
    dish_id bigint NOT NULL,
    product_id bigint NOT NULL,
    product_volume integer NOT NULL,
    CONSTRAINT products_in_dishes_product_volume_check CHECK ((product_volume > 0))
);
 &   DROP TABLE public.products_in_dishes;
       public         heap 	   astukalov    false            �            1259    20162    products_product_id_seq    SEQUENCE     �   ALTER TABLE public.products ALTER COLUMN product_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.products_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       	   astukalov    false    216            �            1259    20241 	   schedules    TABLE     �   CREATE TABLE public.schedules (
    schedule_id bigint NOT NULL,
    employee_id bigint NOT NULL,
    working_shift_id bigint NOT NULL
);
    DROP TABLE public.schedules;
       public         heap 	   astukalov    false            �            1259    20240    schedules_schedule_id_seq    SEQUENCE     �   ALTER TABLE public.schedules ALTER COLUMN schedule_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.schedules_schedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       	   astukalov    false    226            �            1259    20284    table_allocations    TABLE     i   CREATE TABLE public.table_allocations (
    table_id bigint NOT NULL,
    schedule_id bigint NOT NULL
);
 %   DROP TABLE public.table_allocations;
       public         heap 	   astukalov    false            �            1259    20259    tables    TABLE     �   CREATE TABLE public.tables (
    table_id bigint NOT NULL,
    places_count integer NOT NULL,
    location_features character varying(200),
    is_taken boolean NOT NULL,
    CONSTRAINT tables_places_count_check CHECK ((places_count > 0))
);
    DROP TABLE public.tables;
       public         heap 	   astukalov    false            �            1259    20258    tables_table_id_seq    SEQUENCE     �   ALTER TABLE public.tables ALTER COLUMN table_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tables_table_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       	   astukalov    false    228            �            1259    20218    workers_skills    TABLE     e   CREATE TABLE public.workers_skills (
    dish_id bigint NOT NULL,
    employee_id bigint NOT NULL
);
 "   DROP TABLE public.workers_skills;
       public         heap 	   astukalov    false            �            1259    20234    working_shifts    TABLE     
  CREATE TABLE public.working_shifts (
    working_shift_id bigint NOT NULL,
    start_datetime timestamp without time zone NOT NULL,
    end_datetime timestamp without time zone NOT NULL,
    CONSTRAINT working_shifts_check CHECK ((start_datetime < end_datetime))
);
 "   DROP TABLE public.working_shifts;
       public         heap 	   astukalov    false            �            1259    20233 #   working_shifts_working_shift_id_seq    SEQUENCE     �   ALTER TABLE public.working_shifts ALTER COLUMN working_shift_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.working_shifts_working_shift_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public       	   astukalov    false    224            �          0    20321    bookings 
   TABLE DATA           j   COPY public.bookings (booking_id, name_for_booking, is_confirmed, booking_datetime, table_id) FROM stdin;
    public       	   astukalov    false    234   �       �          0    20299    cooking_progress 
   TABLE DATA           n   COPY public.cooking_progress (dish_id, order_id, employee_id, dish_count, is_ready, guest_wishes) FROM stdin;
    public       	   astukalov    false    232   !�       y          0    20139    dish_categories 
   TABLE DATA           A   COPY public.dish_categories (dish_category_id, name) FROM stdin;
    public       	   astukalov    false    212   o�       {          0    20147    dishes 
   TABLE DATA           P   COPY public.dishes (dish_id, dish_category_id, name, price, recipe) FROM stdin;
    public       	   astukalov    false    214   ��       w          0    20131 	   employees 
   TABLE DATA           [   COPY public.employees (employee_id, pasport, fio, postition, category, salary) FROM stdin;
    public       	   astukalov    false    210   �       �          0    20266    orders 
   TABLE DATA           i   COPY public.orders (order_id, table_id, employee_id, open_datetime, close_datetime, is_paid) FROM stdin;
    public       	   astukalov    false    230   P�                 0    20175    product_providers 
   TABLE DATA           >   COPY public.product_providers (provider_id, name) FROM stdin;
    public       	   astukalov    false    218   ��       �          0    20183    product_purchases 
   TABLE DATA           �   COPY public.product_purchases (product_purchase_id, product_id, provider_id, volume, price, purchase_date, expiration_date) FROM stdin;
    public       	   astukalov    false    220   ܂       }          0    20163    products 
   TABLE DATA           h   COPY public.products (product_id, name, max_price, required_volume, calories, stock_volume) FROM stdin;
    public       	   astukalov    false    216   1�       �          0    20202    products_in_dishes 
   TABLE DATA           Q   COPY public.products_in_dishes (dish_id, product_id, product_volume) FROM stdin;
    public       	   astukalov    false    221   Ӄ       �          0    20241 	   schedules 
   TABLE DATA           O   COPY public.schedules (schedule_id, employee_id, working_shift_id) FROM stdin;
    public       	   astukalov    false    226   �       �          0    20284    table_allocations 
   TABLE DATA           B   COPY public.table_allocations (table_id, schedule_id) FROM stdin;
    public       	   astukalov    false    231   ;�       �          0    20259    tables 
   TABLE DATA           U   COPY public.tables (table_id, places_count, location_features, is_taken) FROM stdin;
    public       	   astukalov    false    228   g�       �          0    20218    workers_skills 
   TABLE DATA           >   COPY public.workers_skills (dish_id, employee_id) FROM stdin;
    public       	   astukalov    false    222   ��       �          0    20234    working_shifts 
   TABLE DATA           X   COPY public.working_shifts (working_shift_id, start_datetime, end_datetime) FROM stdin;
    public       	   astukalov    false    224   ل       �           0    0    bookings_booking_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.bookings_booking_id_seq', 1, true);
          public       	   astukalov    false    233            �           0    0 $   dish_categories_dish_category_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.dish_categories_dish_category_id_seq', 1, true);
          public       	   astukalov    false    211            �           0    0    dishes_dish_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.dishes_dish_id_seq', 1, true);
          public       	   astukalov    false    213            �           0    0    employees_employee_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.employees_employee_id_seq', 6, true);
          public       	   astukalov    false    209            �           0    0    orders_order_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.orders_order_id_seq', 1, true);
          public       	   astukalov    false    229            �           0    0 !   product_providers_provider_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.product_providers_provider_id_seq', 1, true);
          public       	   astukalov    false    217            �           0    0 )   product_purchases_product_purchase_id_seq    SEQUENCE SET     W   SELECT pg_catalog.setval('public.product_purchases_product_purchase_id_seq', 3, true);
          public       	   astukalov    false    219            �           0    0    products_product_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.products_product_id_seq', 3, true);
          public       	   astukalov    false    215            �           0    0    schedules_schedule_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.schedules_schedule_id_seq', 6, true);
          public       	   astukalov    false    225            �           0    0    tables_table_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.tables_table_id_seq', 5, true);
          public       	   astukalov    false    227            �           0    0 #   working_shifts_working_shift_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.working_shifts_working_shift_id_seq', 1, true);
          public       	   astukalov    false    223            �           2606    20326    bookings bookings_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (booking_id);
 @   ALTER TABLE ONLY public.bookings DROP CONSTRAINT bookings_pkey;
       public         	   astukalov    false    234            �           2606    20304 &   cooking_progress cooking_progress_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.cooking_progress
    ADD CONSTRAINT cooking_progress_pkey PRIMARY KEY (dish_id, order_id, employee_id);
 P   ALTER TABLE ONLY public.cooking_progress DROP CONSTRAINT cooking_progress_pkey;
       public         	   astukalov    false    232    232    232            �           2606    20145 (   dish_categories dish_categories_name_key 
   CONSTRAINT     c   ALTER TABLE ONLY public.dish_categories
    ADD CONSTRAINT dish_categories_name_key UNIQUE (name);
 R   ALTER TABLE ONLY public.dish_categories DROP CONSTRAINT dish_categories_name_key;
       public         	   astukalov    false    212            �           2606    20143 $   dish_categories dish_categories_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.dish_categories
    ADD CONSTRAINT dish_categories_pkey PRIMARY KEY (dish_category_id);
 N   ALTER TABLE ONLY public.dish_categories DROP CONSTRAINT dish_categories_pkey;
       public         	   astukalov    false    212            �           2606    20156    dishes dishes_name_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.dishes
    ADD CONSTRAINT dishes_name_key UNIQUE (name);
 @   ALTER TABLE ONLY public.dishes DROP CONSTRAINT dishes_name_key;
       public         	   astukalov    false    214            �           2606    20154    dishes dishes_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.dishes
    ADD CONSTRAINT dishes_pkey PRIMARY KEY (dish_id);
 <   ALTER TABLE ONLY public.dishes DROP CONSTRAINT dishes_pkey;
       public         	   astukalov    false    214            �           2606    20137    employees employees_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employee_id);
 B   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_pkey;
       public         	   astukalov    false    210            �           2606    20273    orders orders_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public         	   astukalov    false    230            �           2606    20181 ,   product_providers product_providers_name_key 
   CONSTRAINT     g   ALTER TABLE ONLY public.product_providers
    ADD CONSTRAINT product_providers_name_key UNIQUE (name);
 V   ALTER TABLE ONLY public.product_providers DROP CONSTRAINT product_providers_name_key;
       public         	   astukalov    false    218            �           2606    20179 (   product_providers product_providers_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.product_providers
    ADD CONSTRAINT product_providers_pkey PRIMARY KEY (provider_id);
 R   ALTER TABLE ONLY public.product_providers DROP CONSTRAINT product_providers_pkey;
       public         	   astukalov    false    218            �           2606    20191 (   product_purchases product_purchases_pkey 
   CONSTRAINT     w   ALTER TABLE ONLY public.product_purchases
    ADD CONSTRAINT product_purchases_pkey PRIMARY KEY (product_purchase_id);
 R   ALTER TABLE ONLY public.product_purchases DROP CONSTRAINT product_purchases_pkey;
       public         	   astukalov    false    220            �           2606    20207 *   products_in_dishes products_in_dishes_pkey 
   CONSTRAINT     y   ALTER TABLE ONLY public.products_in_dishes
    ADD CONSTRAINT products_in_dishes_pkey PRIMARY KEY (dish_id, product_id);
 T   ALTER TABLE ONLY public.products_in_dishes DROP CONSTRAINT products_in_dishes_pkey;
       public         	   astukalov    false    221    221            �           2606    20173    products products_name_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_name_key UNIQUE (name);
 D   ALTER TABLE ONLY public.products DROP CONSTRAINT products_name_key;
       public         	   astukalov    false    216            �           2606    20171    products products_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);
 @   ALTER TABLE ONLY public.products DROP CONSTRAINT products_pkey;
       public         	   astukalov    false    216            �           2606    20247 4   schedules schedules_employee_id_working_shift_id_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_employee_id_working_shift_id_key UNIQUE (employee_id, working_shift_id);
 ^   ALTER TABLE ONLY public.schedules DROP CONSTRAINT schedules_employee_id_working_shift_id_key;
       public         	   astukalov    false    226    226            �           2606    20245    schedules schedules_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_pkey PRIMARY KEY (schedule_id);
 B   ALTER TABLE ONLY public.schedules DROP CONSTRAINT schedules_pkey;
       public         	   astukalov    false    226            �           2606    20288 (   table_allocations table_allocations_pkey 
   CONSTRAINT     y   ALTER TABLE ONLY public.table_allocations
    ADD CONSTRAINT table_allocations_pkey PRIMARY KEY (table_id, schedule_id);
 R   ALTER TABLE ONLY public.table_allocations DROP CONSTRAINT table_allocations_pkey;
       public         	   astukalov    false    231    231            �           2606    20264    tables tables_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.tables
    ADD CONSTRAINT tables_pkey PRIMARY KEY (table_id);
 <   ALTER TABLE ONLY public.tables DROP CONSTRAINT tables_pkey;
       public         	   astukalov    false    228            �           2606    20222 "   workers_skills workers_skills_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.workers_skills
    ADD CONSTRAINT workers_skills_pkey PRIMARY KEY (dish_id, employee_id);
 L   ALTER TABLE ONLY public.workers_skills DROP CONSTRAINT workers_skills_pkey;
       public         	   astukalov    false    222    222            �           2606    20239 "   working_shifts working_shifts_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.working_shifts
    ADD CONSTRAINT working_shifts_pkey PRIMARY KEY (working_shift_id);
 L   ALTER TABLE ONLY public.working_shifts DROP CONSTRAINT working_shifts_pkey;
       public         	   astukalov    false    224            �           2606    20327    bookings bookings_table_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_table_id_fkey FOREIGN KEY (table_id) REFERENCES public.tables(table_id) ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.bookings DROP CONSTRAINT bookings_table_id_fkey;
       public       	   astukalov    false    4305    228    234            �           2606    20305 .   cooking_progress cooking_progress_dish_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cooking_progress
    ADD CONSTRAINT cooking_progress_dish_id_fkey FOREIGN KEY (dish_id) REFERENCES public.dishes(dish_id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.cooking_progress DROP CONSTRAINT cooking_progress_dish_id_fkey;
       public       	   astukalov    false    214    4283    232            �           2606    20315 2   cooking_progress cooking_progress_employee_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cooking_progress
    ADD CONSTRAINT cooking_progress_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.cooking_progress DROP CONSTRAINT cooking_progress_employee_id_fkey;
       public       	   astukalov    false    4275    232    210            �           2606    20310 /   cooking_progress cooking_progress_order_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cooking_progress
    ADD CONSTRAINT cooking_progress_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON DELETE CASCADE;
 Y   ALTER TABLE ONLY public.cooking_progress DROP CONSTRAINT cooking_progress_order_id_fkey;
       public       	   astukalov    false    230    4307    232            �           2606    20157 #   dishes dishes_dish_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.dishes
    ADD CONSTRAINT dishes_dish_category_id_fkey FOREIGN KEY (dish_category_id) REFERENCES public.dish_categories(dish_category_id) ON DELETE SET NULL;
 M   ALTER TABLE ONLY public.dishes DROP CONSTRAINT dishes_dish_category_id_fkey;
       public       	   astukalov    false    4279    214    212            �           2606    20274    orders orders_employee_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id) ON DELETE SET NULL;
 H   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_employee_id_fkey;
       public       	   astukalov    false    210    4275    230            �           2606    20279    orders orders_table_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_table_id_fkey FOREIGN KEY (table_id) REFERENCES public.tables(table_id) ON DELETE SET NULL;
 E   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_table_id_fkey;
       public       	   astukalov    false    228    4305    230            �           2606    20192 3   product_purchases product_purchases_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_purchases
    ADD CONSTRAINT product_purchases_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON DELETE SET NULL;
 ]   ALTER TABLE ONLY public.product_purchases DROP CONSTRAINT product_purchases_product_id_fkey;
       public       	   astukalov    false    4287    216    220            �           2606    20197 4   product_purchases product_purchases_provider_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_purchases
    ADD CONSTRAINT product_purchases_provider_id_fkey FOREIGN KEY (provider_id) REFERENCES public.product_providers(provider_id) ON DELETE SET NULL;
 ^   ALTER TABLE ONLY public.product_purchases DROP CONSTRAINT product_purchases_provider_id_fkey;
       public       	   astukalov    false    218    4291    220            �           2606    20208 2   products_in_dishes products_in_dishes_dish_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.products_in_dishes
    ADD CONSTRAINT products_in_dishes_dish_id_fkey FOREIGN KEY (dish_id) REFERENCES public.dishes(dish_id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.products_in_dishes DROP CONSTRAINT products_in_dishes_dish_id_fkey;
       public       	   astukalov    false    221    214    4283            �           2606    20213 5   products_in_dishes products_in_dishes_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.products_in_dishes
    ADD CONSTRAINT products_in_dishes_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON DELETE CASCADE;
 _   ALTER TABLE ONLY public.products_in_dishes DROP CONSTRAINT products_in_dishes_product_id_fkey;
       public       	   astukalov    false    221    4287    216            �           2606    20248 $   schedules schedules_employee_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id) ON DELETE CASCADE;
 N   ALTER TABLE ONLY public.schedules DROP CONSTRAINT schedules_employee_id_fkey;
       public       	   astukalov    false    210    226    4275            �           2606    20253 )   schedules schedules_working_shift_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_working_shift_id_fkey FOREIGN KEY (working_shift_id) REFERENCES public.working_shifts(working_shift_id) ON DELETE CASCADE;
 S   ALTER TABLE ONLY public.schedules DROP CONSTRAINT schedules_working_shift_id_fkey;
       public       	   astukalov    false    226    224    4299            �           2606    20294 4   table_allocations table_allocations_schedule_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.table_allocations
    ADD CONSTRAINT table_allocations_schedule_id_fkey FOREIGN KEY (schedule_id) REFERENCES public.schedules(schedule_id) ON DELETE CASCADE;
 ^   ALTER TABLE ONLY public.table_allocations DROP CONSTRAINT table_allocations_schedule_id_fkey;
       public       	   astukalov    false    4303    231    226            �           2606    20289 1   table_allocations table_allocations_table_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.table_allocations
    ADD CONSTRAINT table_allocations_table_id_fkey FOREIGN KEY (table_id) REFERENCES public.tables(table_id) ON DELETE CASCADE;
 [   ALTER TABLE ONLY public.table_allocations DROP CONSTRAINT table_allocations_table_id_fkey;
       public       	   astukalov    false    228    231    4305            �           2606    20223 *   workers_skills workers_skills_dish_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.workers_skills
    ADD CONSTRAINT workers_skills_dish_id_fkey FOREIGN KEY (dish_id) REFERENCES public.dishes(dish_id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.workers_skills DROP CONSTRAINT workers_skills_dish_id_fkey;
       public       	   astukalov    false    222    214    4283            �           2606    20228 .   workers_skills workers_skills_employee_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.workers_skills
    ADD CONSTRAINT workers_skills_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.workers_skills DROP CONSTRAINT workers_skills_employee_id_fkey;
       public       	   astukalov    false    4275    222    210            �   5   x�3�0���[.6\�za'g��������������������!W� ��      �   >   x�3�4B#�4��.l����>�/��䀙[/lW����֋M�/6_�aW� O�      y   #   x� ��1	Домашние
\.


���      {   c   x�3�4估���.l���b�Ŧ;.6х}@��w�� EAhXM��f��}�p��q^�ta�ņ;.��B5�T���ދ������b���� ��E      w   +  xڭ�AN�`��?��/PS�B�.�B��k�&�M4č+�X��^�͍|��
�� �0�͛7��Ñ�W�K�2T�!���Hb�Z�($�'�9J��15�a���$2XJ"�en��>ޠ3`l��������ݤ'E4AO%�ɕN�bǎ:�PO����bEDN����)Jl[��_:u�g�;R�\����⁭�̴��X�ӣk7�<�Yk��=C
A%s��k�|���f}������UA�!�#_�r-�],�y���
Ϻ���?����+^�����aհ3�WS
��c�O<�� ^�      �   ,   x�3�4�4�4202�50�54V04�22�20����L����� p�0         @   x�3�0.̿�pa߅-�/��t�[��/�+ E�^l��ta����^��M\1z\\\ a�#�      �   E   x�mʱ�0�Z��E�V���sD.��/.#{E2�>Q��?W'j�l5��P��V�*�&��~�E      }   �   x����0E��� 91i�a����;��QQDU�t��p�e����'f$=�`�[�gl����S#X��g��v�Pf/�'��8�z�Ǫk�5�*�1T-2��$�[�}wpBx��z�VI��6#�H��^(��sǝs�� V�      �      x�3�4�420����� ژH��qqq 7�      �   )   x�Ĺ 0��4L ��x�9"�P��(ߴ�/��I�f��      �      x�3�4�2bc 6�4�2�=... (�      �   ;   x�3�4⼰�bӅ}v_�qa���f {ׅ�6p�q���1�	�2�P�*F��� ��      �      x�3�4�2�4bc�=... "      �   '   x�3�4202�50�54V0��20 "d1C�W� ˓@     