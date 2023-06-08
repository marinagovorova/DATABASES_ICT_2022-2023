PGDMP     
    :                {            mobile_provider    14.7    14.7 B    Y           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            Z           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            [           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            \           1262    16394    mobile_provider    DATABASE     l   CREATE DATABASE mobile_provider WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_Europe.1251';
    DROP DATABASE mobile_provider;
                postgres    false            �            1259    16596    additional_services    TABLE       CREATE TABLE public.additional_services (
    id_add_serv integer NOT NULL,
    price real NOT NULL,
    payment_type character(1) NOT NULL,
    serv_name character varying NOT NULL,
    CONSTRAINT additional_services_price_check CHECK ((price > (0)::double precision))
);
 '   DROP TABLE public.additional_services;
       public         heap    postgres    false            �            1259    16595 #   additional_services_id_add_serv_seq    SEQUENCE     �   ALTER TABLE public.additional_services ALTER COLUMN id_add_serv ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.additional_services_id_add_serv_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000
    CACHE 1
);
            public          postgres    false    224            �            1259    16554    calls    TABLE     �  CREATE TABLE public.calls (
    id_call integer NOT NULL,
    id_cot integer NOT NULL,
    id_zone integer NOT NULL,
    payment_status boolean NOT NULL,
    payment_date date,
    act_payment_date date,
    payment_sum real,
    duration real NOT NULL,
    target_number bigint NOT NULL,
    call_date date NOT NULL,
    call_time time with time zone NOT NULL,
    CONSTRAINT "21st century dates" CHECK ((payment_date > '2000-01-01'::date)),
    CONSTRAINT "21st century dates for calls" CHECK ((call_date > '2000-01-01'::date)),
    CONSTRAINT "positive duration" CHECK ((duration > (0)::double precision)),
    CONSTRAINT "positive target number" CHECK ((target_number > 0))
);
    DROP TABLE public.calls;
       public         heap    postgres    false            �            1259    16553    calls_id_call_seq    SEQUENCE     �   ALTER TABLE public.calls ALTER COLUMN id_call ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.calls_id_call_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 10000000
    CACHE 1
);
            public          postgres    false    220            �            1259    16606 
   connection    TABLE     3  CREATE TABLE public.connection (
    id_cot integer NOT NULL,
    id_add_serv integer NOT NULL,
    begin_date date NOT NULL,
    end_date date NOT NULL,
    CONSTRAINT connection_begin_date_check CHECK ((begin_date > '2000-01-01'::date)),
    CONSTRAINT connection_check CHECK ((end_date > begin_date))
);
    DROP TABLE public.connection;
       public         heap    postgres    false            �            1259    16439 	   contracts    TABLE     �   CREATE TABLE public.contracts (
    id_contract integer NOT NULL,
    phone_num bigint NOT NULL,
    begin_date date NOT NULL,
    end_date date GENERATED ALWAYS AS ((begin_date + 365)) STORED NOT NULL
);
    DROP TABLE public.contracts;
       public         heap    postgres    false            �            1259    16438    contracts_id_contract_seq    SEQUENCE     �   ALTER TABLE public.contracts ALTER COLUMN id_contract ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.contracts_id_contract_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 10000
    CACHE 1
);
            public          postgres    false    211            �            1259    16533    contracts_on_tariffs    TABLE     t  CREATE TABLE public.contracts_on_tariffs (
    id_cot integer NOT NULL,
    id_tariff integer NOT NULL,
    id_contract integer NOT NULL,
    gb_remainder integer,
    sms_remainder integer,
    mins_remainder integer,
    begin_date date NOT NULL,
    end_date date NOT NULL,
    CONSTRAINT contracts_on_tariffs_begin_date_check CHECK ((begin_date > '2000-01-01'::date)),
    CONSTRAINT contracts_on_tariffs_check CHECK ((end_date > begin_date)),
    CONSTRAINT "positive gbs" CHECK ((gb_remainder > 0)),
    CONSTRAINT "positive mins" CHECK ((mins_remainder > 0)),
    CONSTRAINT "positive sms" CHECK ((sms_remainder > 0))
);
 (   DROP TABLE public.contracts_on_tariffs;
       public         heap    postgres    false            �            1259    16532    contracts_on_tariffs_id_cot_seq    SEQUENCE     �   ALTER TABLE public.contracts_on_tariffs ALTER COLUMN id_cot ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.contracts_on_tariffs_id_cot_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 100000
    CACHE 1
);
            public          postgres    false    218            �            1259    16581    external_resources    TABLE       CREATE TABLE public.external_resources (
    id_ext_res integer NOT NULL,
    id_cot integer NOT NULL,
    payment_type character(1) NOT NULL,
    res_name character varying(30) NOT NULL,
    price real NOT NULL,
    begin_date date NOT NULL,
    end_date date NOT NULL,
    CONSTRAINT external_resources_begin_date_check CHECK ((begin_date > '2000-01-01'::date)),
    CONSTRAINT external_resources_check CHECK ((end_date > begin_date)),
    CONSTRAINT external_resources_price_check CHECK ((price > (0)::double precision))
);
 &   DROP TABLE public.external_resources;
       public         heap    postgres    false            �            1259    16580 !   external_resources_id_ext_res_seq    SEQUENCE     �   ALTER TABLE public.external_resources ALTER COLUMN id_ext_res ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.external_resources_id_ext_res_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000
    CACHE 1
);
            public          postgres    false    222            �            1259    16489    tariffs    TABLE     
  CREATE TABLE public.tariffs (
    id_tariff integer NOT NULL,
    tariff_cost integer NOT NULL,
    base_gb integer,
    base_sms integer,
    base_mins integer,
    tariff_name character varying NOT NULL,
    CONSTRAINT "positive cost" CHECK ((tariff_cost > 0))
);
    DROP TABLE public.tariffs;
       public         heap    postgres    false            �            1259    16488    tariffs_id_tariff_seq    SEQUENCE     �   ALTER TABLE public.tariffs ALTER COLUMN id_tariff ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tariffs_id_tariff_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000
    CACHE 1
);
            public          postgres    false    214            �            1259    16421    users    TABLE       CREATE TABLE public.users (
    phone_num bigint NOT NULL,
    user_name character varying(50) NOT NULL,
    city character varying(30) NOT NULL,
    country character varying(20) NOT NULL,
    CONSTRAINT "positive phone number" CHECK (((phone_num)::numeric > (0)::numeric))
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    16478    users_phone_num_seq    SEQUENCE     �   ALTER TABLE public.users ALTER COLUMN phone_num ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_phone_num_seq
    START WITH 79000000000
    INCREMENT BY 1
    MINVALUE 79000000000
    MAXVALUE 79999999999
    CACHE 1
);
            public          postgres    false    209            �            1259    16498    zones    TABLE        CREATE TABLE public.zones (
    id_zone integer NOT NULL,
    country_prefix numeric(3,0) NOT NULL,
    price_per_minute real NOT NULL,
    country character varying(30) NOT NULL,
    CONSTRAINT "positive prefix" CHECK ((country_prefix > (0)::numeric))
);
    DROP TABLE public.zones;
       public         heap    postgres    false            �            1259    16497    zones_id_zone_seq    SEQUENCE     �   ALTER TABLE public.zones ALTER COLUMN id_zone ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.zones_id_zone_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 100
    CACHE 1
);
            public          postgres    false    216            U          0    16596    additional_services 
   TABLE DATA           Z   COPY public.additional_services (id_add_serv, price, payment_type, serv_name) FROM stdin;
    public          postgres    false    224   �\       Q          0    16554    calls 
   TABLE DATA           �   COPY public.calls (id_call, id_cot, id_zone, payment_status, payment_date, act_payment_date, payment_sum, duration, target_number, call_date, call_time) FROM stdin;
    public          postgres    false    220   �\       V          0    16606 
   connection 
   TABLE DATA           O   COPY public.connection (id_cot, id_add_serv, begin_date, end_date) FROM stdin;
    public          postgres    false    225   &_       H          0    16439 	   contracts 
   TABLE DATA           G   COPY public.contracts (id_contract, phone_num, begin_date) FROM stdin;
    public          postgres    false    211   x_       O          0    16533    contracts_on_tariffs 
   TABLE DATA           �   COPY public.contracts_on_tariffs (id_cot, id_tariff, id_contract, gb_remainder, sms_remainder, mins_remainder, begin_date, end_date) FROM stdin;
    public          postgres    false    218   �_       S          0    16581    external_resources 
   TABLE DATA           u   COPY public.external_resources (id_ext_res, id_cot, payment_type, res_name, price, begin_date, end_date) FROM stdin;
    public          postgres    false    222   E`       K          0    16489    tariffs 
   TABLE DATA           d   COPY public.tariffs (id_tariff, tariff_cost, base_gb, base_sms, base_mins, tariff_name) FROM stdin;
    public          postgres    false    214   �`       F          0    16421    users 
   TABLE DATA           D   COPY public.users (phone_num, user_name, city, country) FROM stdin;
    public          postgres    false    209   @a       M          0    16498    zones 
   TABLE DATA           S   COPY public.zones (id_zone, country_prefix, price_per_minute, country) FROM stdin;
    public          postgres    false    216   Ub       ]           0    0 #   additional_services_id_add_serv_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.additional_services_id_add_serv_seq', 4, true);
          public          postgres    false    223            ^           0    0    calls_id_call_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.calls_id_call_seq', 30, true);
          public          postgres    false    219            _           0    0    contracts_id_contract_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.contracts_id_contract_seq', 7, true);
          public          postgres    false    210            `           0    0    contracts_on_tariffs_id_cot_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.contracts_on_tariffs_id_cot_seq', 10, true);
          public          postgres    false    217            a           0    0 !   external_resources_id_ext_res_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.external_resources_id_ext_res_seq', 3, true);
          public          postgres    false    221            b           0    0    tariffs_id_tariff_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.tariffs_id_tariff_seq', 3, true);
          public          postgres    false    213            c           0    0    users_phone_num_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.users_phone_num_seq', 79000000004, true);
          public          postgres    false    212            d           0    0    zones_id_zone_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.zones_id_zone_seq', 5, true);
          public          postgres    false    215            �           2606    16517    contracts 21st century dates    CHECK CONSTRAINT     z   ALTER TABLE public.contracts
    ADD CONSTRAINT "21st century dates" CHECK ((begin_date > '2000-01-01'::date)) NOT VALID;
 C   ALTER TABLE public.contracts DROP CONSTRAINT "21st century dates";
       public          postgres    false    211    211            �           2606    24583 :   additional_services additional_services_payment_type_check    CHECK CONSTRAINT     �   ALTER TABLE public.additional_services
    ADD CONSTRAINT additional_services_payment_type_check CHECK ((payment_type = ANY (ARRAY['d'::bpchar, 'w'::bpchar, 'm'::bpchar, '1'::bpchar]))) NOT VALID;
 _   ALTER TABLE public.additional_services DROP CONSTRAINT additional_services_payment_type_check;
       public          postgres    false    224    224            �           2606    16604 ,   additional_services additional_services_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY public.additional_services
    ADD CONSTRAINT additional_services_pkey PRIMARY KEY (id_add_serv);
 V   ALTER TABLE ONLY public.additional_services DROP CONSTRAINT additional_services_pkey;
       public            postgres    false    224            �           2606    24590    calls calls_check    CHECK CONSTRAINT     g   ALTER TABLE public.calls
    ADD CONSTRAINT calls_check CHECK ((payment_date >= call_date)) NOT VALID;
 6   ALTER TABLE public.calls DROP CONSTRAINT calls_check;
       public          postgres    false    220    220    220    220            �           2606    24591    calls calls_check1    CHECK CONSTRAINT     o   ALTER TABLE public.calls
    ADD CONSTRAINT calls_check1 CHECK ((act_payment_date >= payment_date)) NOT VALID;
 7   ALTER TABLE public.calls DROP CONSTRAINT calls_check1;
       public          postgres    false    220    220    220    220            �           2606    24592    calls calls_payment_sum_check    CHECK CONSTRAINT     ~   ALTER TABLE public.calls
    ADD CONSTRAINT calls_payment_sum_check CHECK ((payment_sum >= (0)::double precision)) NOT VALID;
 B   ALTER TABLE public.calls DROP CONSTRAINT calls_payment_sum_check;
       public          postgres    false    220    220            �           2606    16565    calls calls_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.calls
    ADD CONSTRAINT calls_pkey PRIMARY KEY (id_call);
 :   ALTER TABLE ONLY public.calls DROP CONSTRAINT calls_pkey;
       public            postgres    false    220            �           2606    16542 .   contracts_on_tariffs contracts_on_tariffs_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.contracts_on_tariffs
    ADD CONSTRAINT contracts_on_tariffs_pkey PRIMARY KEY (id_cot);
 X   ALTER TABLE ONLY public.contracts_on_tariffs DROP CONSTRAINT contracts_on_tariffs_pkey;
       public            postgres    false    218            �           2606    16444    contracts contracts_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_pkey PRIMARY KEY (id_contract);
 B   ALTER TABLE ONLY public.contracts DROP CONSTRAINT contracts_pkey;
       public            postgres    false    211            �           2606    16518 $   contracts correct sequence for dates    CHECK CONSTRAINT     x   ALTER TABLE public.contracts
    ADD CONSTRAINT "correct sequence for dates" CHECK ((end_date > begin_date)) NOT VALID;
 K   ALTER TABLE public.contracts DROP CONSTRAINT "correct sequence for dates";
       public          postgres    false    211    211    211    211            �           2606    24584 8   external_resources external_resources_payment_type_check    CHECK CONSTRAINT     �   ALTER TABLE public.external_resources
    ADD CONSTRAINT external_resources_payment_type_check CHECK ((payment_type = ANY (ARRAY['d'::bpchar, 'w'::bpchar, 'm'::bpchar]))) NOT VALID;
 ]   ALTER TABLE public.external_resources DROP CONSTRAINT external_resources_payment_type_check;
       public          postgres    false    222    222            �           2606    16589 *   external_resources external_resources_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.external_resources
    ADD CONSTRAINT external_resources_pkey PRIMARY KEY (id_ext_res);
 T   ALTER TABLE ONLY public.external_resources DROP CONSTRAINT external_resources_pkey;
       public            postgres    false    222            �           2606    16510    tariffs positive gbs    CHECK CONSTRAINT     ^   ALTER TABLE public.tariffs
    ADD CONSTRAINT "positive gbs" CHECK ((base_gb > 0)) NOT VALID;
 ;   ALTER TABLE public.tariffs DROP CONSTRAINT "positive gbs";
       public          postgres    false    214    214            �           2606    16511    tariffs positive mins    CHECK CONSTRAINT     a   ALTER TABLE public.tariffs
    ADD CONSTRAINT "positive mins" CHECK ((base_mins > 0)) NOT VALID;
 <   ALTER TABLE public.tariffs DROP CONSTRAINT "positive mins";
       public          postgres    false    214    214            �           2606    16509    tariffs positive sms    CHECK CONSTRAINT     _   ALTER TABLE public.tariffs
    ADD CONSTRAINT "positive sms" CHECK ((base_sms > 0)) NOT VALID;
 ;   ALTER TABLE public.tariffs DROP CONSTRAINT "positive sms";
       public          postgres    false    214    214            �           2606    16496    tariffs tariffs_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.tariffs
    ADD CONSTRAINT tariffs_pkey PRIMARY KEY (id_tariff);
 >   ALTER TABLE ONLY public.tariffs DROP CONSTRAINT tariffs_pkey;
       public            postgres    false    214            �           2606    16470    users unique phone number 
   CONSTRAINT     y   ALTER TABLE ONLY public.users
    ADD CONSTRAINT "unique phone number" UNIQUE (phone_num) DEFERRABLE INITIALLY DEFERRED;
 E   ALTER TABLE ONLY public.users DROP CONSTRAINT "unique phone number";
       public            postgres    false    209            �           2606    16468    users users_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (phone_num);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    209            �           2606    16503    zones zones_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.zones
    ADD CONSTRAINT zones_pkey PRIMARY KEY (id_zone);
 :   ALTER TABLE ONLY public.zones DROP CONSTRAINT zones_pkey;
       public            postgres    false    216            �           2606    24581 "   zones zones_price_per_minute_check    CHECK CONSTRAINT     �   ALTER TABLE public.zones
    ADD CONSTRAINT zones_price_per_minute_check CHECK ((price_per_minute >= (0)::double precision)) NOT VALID;
 G   ALTER TABLE public.zones DROP CONSTRAINT zones_price_per_minute_check;
       public          postgres    false    216    216            �           2606    16566    calls calls_id_cot_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.calls
    ADD CONSTRAINT calls_id_cot_fkey FOREIGN KEY (id_cot) REFERENCES public.contracts_on_tariffs(id_cot) DEFERRABLE INITIALLY DEFERRED;
 A   ALTER TABLE ONLY public.calls DROP CONSTRAINT calls_id_cot_fkey;
       public          postgres    false    3244    220    218            �           2606    16571    calls calls_id_zone_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.calls
    ADD CONSTRAINT calls_id_zone_fkey FOREIGN KEY (id_zone) REFERENCES public.zones(id_zone) DEFERRABLE INITIALLY DEFERRED;
 B   ALTER TABLE ONLY public.calls DROP CONSTRAINT calls_id_zone_fkey;
       public          postgres    false    216    3242    220            �           2606    16616 &   connection connection_id_add_serv_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.connection
    ADD CONSTRAINT connection_id_add_serv_fkey FOREIGN KEY (id_add_serv) REFERENCES public.additional_services(id_add_serv) DEFERRABLE INITIALLY DEFERRED;
 P   ALTER TABLE ONLY public.connection DROP CONSTRAINT connection_id_add_serv_fkey;
       public          postgres    false    225    3250    224            �           2606    16611 !   connection connection_id_cot_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.connection
    ADD CONSTRAINT connection_id_cot_fkey FOREIGN KEY (id_cot) REFERENCES public.contracts_on_tariffs(id_cot) DEFERRABLE INITIALLY DEFERRED;
 K   ALTER TABLE ONLY public.connection DROP CONSTRAINT connection_id_cot_fkey;
       public          postgres    false    225    3244    218            �           2606    16548 :   contracts_on_tariffs contracts_on_tariffs_id_contract_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.contracts_on_tariffs
    ADD CONSTRAINT contracts_on_tariffs_id_contract_fkey FOREIGN KEY (id_contract) REFERENCES public.contracts(id_contract) DEFERRABLE INITIALLY DEFERRED;
 d   ALTER TABLE ONLY public.contracts_on_tariffs DROP CONSTRAINT contracts_on_tariffs_id_contract_fkey;
       public          postgres    false    218    211    3238            �           2606    16543 8   contracts_on_tariffs contracts_on_tariffs_id_tariff_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.contracts_on_tariffs
    ADD CONSTRAINT contracts_on_tariffs_id_tariff_fkey FOREIGN KEY (id_tariff) REFERENCES public.tariffs(id_tariff) DEFERRABLE INITIALLY DEFERRED;
 b   ALTER TABLE ONLY public.contracts_on_tariffs DROP CONSTRAINT contracts_on_tariffs_id_tariff_fkey;
       public          postgres    false    214    3240    218            �           2606    16483 "   contracts contracts_phone_num_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_phone_num_fkey FOREIGN KEY (phone_num) REFERENCES public.users(phone_num) MATCH FULL DEFERRABLE INITIALLY DEFERRED;
 L   ALTER TABLE ONLY public.contracts DROP CONSTRAINT contracts_phone_num_fkey;
       public          postgres    false    211    209    3236            �           2606    16590 1   external_resources external_resources_id_cot_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.external_resources
    ADD CONSTRAINT external_resources_id_cot_fkey FOREIGN KEY (id_cot) REFERENCES public.contracts_on_tariffs(id_cot) DEFERRABLE INITIALLY DEFERRED;
 [   ALTER TABLE ONLY public.external_resources DROP CONSTRAINT external_resources_id_cot_fkey;
       public          postgres    false    218    3244    222            U   d   x�3�4�,缰��֋�^쾰S�b��v �}vqsr�p^�pa��&��> �	���b��@iN#�C��/LT ��� �RuaW� Q27'      Q      x���k��0���\M�g�d-��ٿ�8E�i�rI����+^��+B�(�5�R�h�u����c]e����;�֐��a��kw�h]e⸒SwN]C�L�����<�ir��i�a��~p�+&�}�H}0��8��#\L�!6�u{�G��G��aZC�ȑ$C.a�U��1$2���:3幂���K�e��b��lX�"?����g�y[A���H~q��͹�U��:�]'M����k=������Yu@m�l��K8�ނ��������G����*�6�ẃ�*I�(�[P��Ch���o����פ�N�kH��4|i˺�}P^�K�佶��r�&��A���P�����5_C��I��sQ�K~��:v�]�'n�A�u
Qt�l�n�3!�J�	>���vΦ�_c�c�}<ԆO����V=��~a�R���%�}�f�L�0ּ�e�b8Z�Ij/�=��Y_I1Iu�Y��F:�*Ed�;�?݁Gl�}~��|rx ZU�ck�n��C�p�����O��=���X�      V   B   x�M��	�0Cѳ�K�%'��t�9�B�:|xh�B�:rm~9V�ڥ-�F�O:����2��p� 4T�      H   8   x�3�4�4�N##c]�2B�0DH�p#I!K� I#$L�̑$L�%b���� ˼i      O   u   x�u��1C��.� qX���s��~�T�"HVx�f!T]�#Q>�ïwI~�C�������qs�S�A�ž2���8_�K���l�m��k�)C5�ŒkU�^�#��|���/'w      S   }   x�3�4���0�¾/츰�bυ��/�T����{a�Ŧ[/l��t����� ���u�uM�L �˘�d��[/6^�a7H؜�
����[��m���k���i�l��,3�=... �E      K   ^   x�3�4400 p�煉�^�~a���\�q���� Ə�H��U( ��ta�ņ{�dӅ\Ɯ� cL��n ��¦��vr��qqq ��14      F     x�u�Mn�0���)r$Իp�$�"?j7lZ�E�&`�+��Q��4-9�&3�{~��~�߰�����k��p�:'X���˻D%�l<p]�`g��d:$�x��_"�ȸ^�%x�������5I)ю��3p_-X�}'��d	�0D�G��l���:�R����L��{�Ok��4!��H4�1���Z)��������i|Ī���E�qs�*�5��TK�	1���L��?���q� ��3�      M   \   x�3�4�4༰�¾��/���e�3�0��/l��
�j��r�p��B$'^�za7P��b3P���(e�ZV���^�q1z\\\ �f0�     