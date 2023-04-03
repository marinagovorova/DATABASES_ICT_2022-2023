PGDMP                         {            postgres    15.2    15.2 V    ~           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    5    postgres    DATABASE     |   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE postgres;
                postgres    false            �           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    3457                        3079    16384 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false            �           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    2            x           1247    24693    delivery_invoices_statuses    TYPE     {   CREATE TYPE public.delivery_invoices_statuses AS (
	"Создан" text,
	"Оплачен" text,
	"Отменён" text
);
 -   DROP TYPE public.delivery_invoices_statuses;
       public          postgres    false            �            1259    16397 
   categories    TABLE     t   CREATE TABLE public.categories (
    id integer NOT NULL,
    parent_category_id integer,
    name text NOT NULL
);
    DROP TABLE public.categories;
       public         heap    postgres    false            �            1259    16465 	   customers    TABLE     �   CREATE TABLE public.customers (
    id integer NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    patronymic text,
    phone text,
    email text
);
    DROP TABLE public.customers;
       public         heap    postgres    false            �            1259    24590 
   deliveries    TABLE     -  CREATE TABLE public.deliveries (
    id integer NOT NULL,
    vendor_id integer NOT NULL,
    create_date timestamp without time zone,
    status_id integer DEFAULT 1 NOT NULL,
    employee_id integer NOT NULL,
    invoice_id integer DEFAULT 1 NOT NULL,
    finish_date timestamp without time zone
);
    DROP TABLE public.deliveries;
       public         heap    postgres    false            �            1259    24694    delivery_invoices    TABLE       CREATE TABLE public.delivery_invoices (
    id integer NOT NULL,
    amount integer NOT NULL,
    vendor_id integer NOT NULL,
    create_date timestamp without time zone NOT NULL,
    finish_date timestamp without time zone,
    status public.delivery_invoices_statuses
);
 %   DROP TABLE public.delivery_invoices;
       public         heap    postgres    false    888            �            1259    24604    delivery_items    TABLE     �   CREATE TABLE public.delivery_items (
    id integer NOT NULL,
    delivery_id integer NOT NULL,
    amount integer NOT NULL,
    product_id integer NOT NULL,
    cost numeric NOT NULL,
    remain integer
);
 "   DROP TABLE public.delivery_items;
       public         heap    postgres    false            �            1259    24596    delivery_statuses    TABLE     [   CREATE TABLE public.delivery_statuses (
    id integer NOT NULL,
    name text NOT NULL
);
 %   DROP TABLE public.delivery_statuses;
       public         heap    postgres    false            �            1259    24576 	   employees    TABLE     �   CREATE TABLE public.employees (
    id integer NOT NULL,
    last_name text NOT NULL,
    first_name text NOT NULL,
    patronymic text
);
    DROP TABLE public.employees;
       public         heap    postgres    false            �            1259    24707    order_invoices    TABLE       CREATE TABLE public.order_invoices (
    id integer NOT NULL,
    customer_id integer NOT NULL,
    amount numeric NOT NULL,
    create_date timestamp without time zone NOT NULL,
    finish_date timestamp without time zone,
    status_id integer NOT NULL
);
 "   DROP TABLE public.order_invoices;
       public         heap    postgres    false            �            1259    16477    order_items    TABLE     �   CREATE TABLE public.order_items (
    id integer NOT NULL,
    order_id integer NOT NULL,
    delivery_item_id integer NOT NULL,
    amount integer NOT NULL,
    cost numeric NOT NULL
);
    DROP TABLE public.order_items;
       public         heap    postgres    false            �           0    0    TABLE order_items    COMMENT     E   COMMENT ON TABLE public.order_items IS 'позиция в чеке';
          public          postgres    false    219            �            1259    16505    order_statuses    TABLE     X   CREATE TABLE public.order_statuses (
    id integer NOT NULL,
    name text NOT NULL
);
 "   DROP TABLE public.order_statuses;
       public         heap    postgres    false            �            1259    16472    orders    TABLE     
  CREATE TABLE public.orders (
    id integer NOT NULL,
    customer_id integer NOT NULL,
    status_id integer DEFAULT 1 NOT NULL,
    invoices_id integer DEFAULT 1 NOT NULL,
    create_date timestamp without time zone,
    finish_date timestamp without time zone
);
    DROP TABLE public.orders;
       public         heap    postgres    false            �            1259    24647    payment_order_statuses    TABLE     `   CREATE TABLE public.payment_order_statuses (
    id integer NOT NULL,
    name text NOT NULL
);
 *   DROP TABLE public.payment_order_statuses;
       public         heap    postgres    false            �            1259    16404    products    TABLE     �   CREATE TABLE public.products (
    id integer NOT NULL,
    category_id integer NOT NULL,
    description text,
    cost numeric NOT NULL,
    name text NOT NULL
);
    DROP TABLE public.products;
       public         heap    postgres    false            �            1259    24583    vendors    TABLE     Q   CREATE TABLE public.vendors (
    id integer NOT NULL,
    name text NOT NULL
);
    DROP TABLE public.vendors;
       public         heap    postgres    false            n          0    16397 
   categories 
   TABLE DATA           B   COPY public.categories (id, parent_category_id, name) FROM stdin;
    public          postgres    false    215   �d       p          0    16465 	   customers 
   TABLE DATA           X   COPY public.customers (id, first_name, last_name, patronymic, phone, email) FROM stdin;
    public          postgres    false    217   �e       v          0    24590 
   deliveries 
   TABLE DATA           q   COPY public.deliveries (id, vendor_id, create_date, status_id, employee_id, invoice_id, finish_date) FROM stdin;
    public          postgres    false    223   �g       z          0    24694    delivery_invoices 
   TABLE DATA           d   COPY public.delivery_invoices (id, amount, vendor_id, create_date, finish_date, status) FROM stdin;
    public          postgres    false    228   �g       x          0    24604    delivery_items 
   TABLE DATA           [   COPY public.delivery_items (id, delivery_id, amount, product_id, cost, remain) FROM stdin;
    public          postgres    false    225   6h       w          0    24596    delivery_statuses 
   TABLE DATA           5   COPY public.delivery_statuses (id, name) FROM stdin;
    public          postgres    false    224   �h       t          0    24576 	   employees 
   TABLE DATA           J   COPY public.employees (id, last_name, first_name, patronymic) FROM stdin;
    public          postgres    false    221   i       {          0    24707    order_invoices 
   TABLE DATA           f   COPY public.order_invoices (id, customer_id, amount, create_date, finish_date, status_id) FROM stdin;
    public          postgres    false    229   �i       r          0    16477    order_items 
   TABLE DATA           S   COPY public.order_items (id, order_id, delivery_item_id, amount, cost) FROM stdin;
    public          postgres    false    219   �i       s          0    16505    order_statuses 
   TABLE DATA           2   COPY public.order_statuses (id, name) FROM stdin;
    public          postgres    false    220   j       q          0    16472    orders 
   TABLE DATA           c   COPY public.orders (id, customer_id, status_id, invoices_id, create_date, finish_date) FROM stdin;
    public          postgres    false    218   �j       y          0    24647    payment_order_statuses 
   TABLE DATA           :   COPY public.payment_order_statuses (id, name) FROM stdin;
    public          postgres    false    226   �j       o          0    16404    products 
   TABLE DATA           L   COPY public.products (id, category_id, description, cost, name) FROM stdin;
    public          postgres    false    216   #k       u          0    24583    vendors 
   TABLE DATA           +   COPY public.vendors (id, name) FROM stdin;
    public          postgres    false    222   u       �           2606    16504    order_items amount_chk    CHECK CONSTRAINT     ]   ALTER TABLE public.order_items
    ADD CONSTRAINT amount_chk CHECK ((amount > 0)) NOT VALID;
 ;   ALTER TABLE public.order_items DROP CONSTRAINT amount_chk;
       public          postgres    false    219    219            �           2606    16425    categories categories_id_check    CHECK CONSTRAINT     a   ALTER TABLE public.categories
    ADD CONSTRAINT categories_id_check CHECK ((id > 0)) NOT VALID;
 C   ALTER TABLE public.categories DROP CONSTRAINT categories_id_check;
       public          postgres    false    215    215            �           2606    16403    categories categories_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_pkey;
       public            postgres    false    215            �           2606    16503    order_items cost_chk    CHECK CONSTRAINT     d   ALTER TABLE public.order_items
    ADD CONSTRAINT cost_chk CHECK ((cost > (0)::numeric)) NOT VALID;
 9   ALTER TABLE public.order_items DROP CONSTRAINT cost_chk;
       public          postgres    false    219    219            �           2606    16471    customers customers_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.customers DROP CONSTRAINT customers_pkey;
       public            postgres    false    217            �           2606    24595    deliveries deliveries_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.deliveries
    ADD CONSTRAINT deliveries_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.deliveries DROP CONSTRAINT deliveries_pkey;
       public            postgres    false    223            �           2606    24700 (   delivery_invoices delivery_invoices_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.delivery_invoices
    ADD CONSTRAINT delivery_invoices_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.delivery_invoices DROP CONSTRAINT delivery_invoices_pkey;
       public            postgres    false    228            �           2606    24602 (   delivery_statuses delivery_statuses_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.delivery_statuses
    ADD CONSTRAINT delivery_statuses_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.delivery_statuses DROP CONSTRAINT delivery_statuses_pkey;
       public            postgres    false    224            �           2606    24582    employees employees_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_pkey;
       public            postgres    false    221            �           2606    16483    order_items items_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.order_items DROP CONSTRAINT items_pkey;
       public            postgres    false    219            �           2606    24713 "   order_invoices order_invoices_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.order_invoices
    ADD CONSTRAINT order_invoices_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.order_invoices DROP CONSTRAINT order_invoices_pkey;
       public            postgres    false    229            �           2606    16511 "   order_statuses order_statuses_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.order_statuses
    ADD CONSTRAINT order_statuses_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.order_statuses DROP CONSTRAINT order_statuses_pkey;
       public            postgres    false    220            �           2606    16476    orders orders_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public            postgres    false    218            �           2606    24653 2   payment_order_statuses payment_order_statuses_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.payment_order_statuses
    ADD CONSTRAINT payment_order_statuses_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.payment_order_statuses DROP CONSTRAINT payment_order_statuses_pkey;
       public            postgres    false    226            �           2606    16502    products price_chk    CHECK CONSTRAINT     b   ALTER TABLE public.products
    ADD CONSTRAINT price_chk CHECK ((cost > (0)::numeric)) NOT VALID;
 7   ALTER TABLE public.products DROP CONSTRAINT price_chk;
       public          postgres    false    216    216            �           2606    16424    products product_id    CHECK CONSTRAINT     V   ALTER TABLE public.products
    ADD CONSTRAINT product_id CHECK ((id > 0)) NOT VALID;
 8   ALTER TABLE public.products DROP CONSTRAINT product_id;
       public          postgres    false    216    216            �           2606    16410    products products_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.products DROP CONSTRAINT products_pkey;
       public            postgres    false    216            �           2606    24610     delivery_items vendor_items_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.delivery_items
    ADD CONSTRAINT vendor_items_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.delivery_items DROP CONSTRAINT vendor_items_pkey;
       public            postgres    false    225            �           2606    24589    vendors vendors_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.vendors
    ADD CONSTRAINT vendors_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.vendors DROP CONSTRAINT vendors_pkey;
       public            postgres    false    222            �           1259    24725    fki_customer_fkey    INDEX     S   CREATE INDEX fki_customer_fkey ON public.order_invoices USING btree (customer_id);
 %   DROP INDEX public.fki_customer_fkey;
       public            postgres    false    229            �           1259    16501    fki_customers_fkey    INDEX     L   CREATE INDEX fki_customers_fkey ON public.orders USING btree (customer_id);
 &   DROP INDEX public.fki_customers_fkey;
       public            postgres    false    218            �           1259    24634    fki_deliveries_fkey    INDEX     U   CREATE INDEX fki_deliveries_fkey ON public.delivery_items USING btree (delivery_id);
 '   DROP INDEX public.fki_deliveries_fkey;
       public            postgres    false    225            �           1259    24679    fki_deliveries_id    INDEX     N   CREATE INDEX fki_deliveries_id ON public.deliveries USING btree (invoice_id);
 %   DROP INDEX public.fki_deliveries_id;
       public            postgres    false    223            �           1259    24628    fki_delivery_fkey    INDEX     M   CREATE INDEX fki_delivery_fkey ON public.deliveries USING btree (status_id);
 %   DROP INDEX public.fki_delivery_fkey;
       public            postgres    false    223            �           1259    24616    fki_employees_fkey    INDEX     P   CREATE INDEX fki_employees_fkey ON public.deliveries USING btree (employee_id);
 &   DROP INDEX public.fki_employees_fkey;
       public            postgres    false    223            �           1259    16422    fki_fk_parent_category_id    INDEX     ^   CREATE INDEX fki_fk_parent_category_id ON public.categories USING btree (parent_category_id);
 -   DROP INDEX public.fki_fk_parent_category_id;
       public            postgres    false    215            �           1259    24719    fki_invoice_id    INDEX     H   CREATE INDEX fki_invoice_id ON public.orders USING btree (invoices_id);
 "   DROP INDEX public.fki_invoice_id;
       public            postgres    false    218            �           1259    24706    fki_invoices_fkey    INDEX     N   CREATE INDEX fki_invoices_fkey ON public.deliveries USING btree (invoice_id);
 %   DROP INDEX public.fki_invoices_fkey;
       public            postgres    false    223            �           1259    24685    fki_item_fkey    INDEX     Q   CREATE INDEX fki_item_fkey ON public.order_items USING btree (delivery_item_id);
 !   DROP INDEX public.fki_item_fkey;
       public            postgres    false    219            �           1259    16518    fki_order_statuses_fkey    INDEX     O   CREATE INDEX fki_order_statuses_fkey ON public.orders USING btree (status_id);
 +   DROP INDEX public.fki_order_statuses_fkey;
       public            postgres    false    218            �           1259    16489    fki_orders_fkey    INDEX     K   CREATE INDEX fki_orders_fkey ON public.order_items USING btree (order_id);
 #   DROP INDEX public.fki_orders_fkey;
       public            postgres    false    219            �           1259    24668    fki_payment_status_fkey    INDEX     Q   CREATE INDEX fki_payment_status_fkey ON public.orders USING btree (invoices_id);
 +   DROP INDEX public.fki_payment_status_fkey;
       public            postgres    false    218            �           1259    16495    fki_products_fkey    INDEX     U   CREATE INDEX fki_products_fkey ON public.order_items USING btree (delivery_item_id);
 %   DROP INDEX public.fki_products_fkey;
       public            postgres    false    219            �           1259    24622    fki_vendors_fkey    INDEX     L   CREATE INDEX fki_vendors_fkey ON public.deliveries USING btree (vendor_id);
 $   DROP INDEX public.fki_vendors_fkey;
       public            postgres    false    223            �           1259    16416    fki_а    INDEX     D   CREATE INDEX "fki_а" ON public.products USING btree (category_id);
    DROP INDEX public."fki_а";
       public            postgres    false    216            �           2606    24720    order_invoices customer_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_invoices
    ADD CONSTRAINT customer_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id) NOT VALID;
 F   ALTER TABLE ONLY public.order_invoices DROP CONSTRAINT customer_fkey;
       public          postgres    false    217    229    3245            �           2606    16496    orders customers_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT customers_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id) NOT VALID;
 ?   ALTER TABLE ONLY public.orders DROP CONSTRAINT customers_fkey;
       public          postgres    false    218    217    3245            �           2606    24629    delivery_items deliveries_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.delivery_items
    ADD CONSTRAINT deliveries_fkey FOREIGN KEY (delivery_id) REFERENCES public.deliveries(id) NOT VALID;
 H   ALTER TABLE ONLY public.delivery_items DROP CONSTRAINT deliveries_fkey;
       public          postgres    false    3264    225    223            �           2606    24623    deliveries delivery_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.deliveries
    ADD CONSTRAINT delivery_fkey FOREIGN KEY (status_id) REFERENCES public.delivery_statuses(id) NOT VALID;
 B   ALTER TABLE ONLY public.deliveries DROP CONSTRAINT delivery_fkey;
       public          postgres    false    223    224    3271            �           2606    24611    deliveries employees_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.deliveries
    ADD CONSTRAINT employees_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(id) NOT VALID;
 C   ALTER TABLE ONLY public.deliveries DROP CONSTRAINT employees_fkey;
       public          postgres    false    3260    223    221            �           2606    16411    products fk_category_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.products
    ADD CONSTRAINT fk_category_id FOREIGN KEY (category_id) REFERENCES public.categories(id) NOT VALID;
 A   ALTER TABLE ONLY public.products DROP CONSTRAINT fk_category_id;
       public          postgres    false    215    3239    216            �           2606    16417     categories fk_parent_category_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT fk_parent_category_id FOREIGN KEY (parent_category_id) REFERENCES public.categories(id) NOT VALID;
 J   ALTER TABLE ONLY public.categories DROP CONSTRAINT fk_parent_category_id;
       public          postgres    false    3239    215    215            �           2606    24714    orders invoice_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT invoice_id FOREIGN KEY (invoices_id) REFERENCES public.order_invoices(id) NOT VALID;
 ;   ALTER TABLE ONLY public.orders DROP CONSTRAINT invoice_id;
       public          postgres    false    229    218    3281            �           2606    24701    deliveries invoices_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.deliveries
    ADD CONSTRAINT invoices_fkey FOREIGN KEY (invoice_id) REFERENCES public.delivery_invoices(id) NOT VALID;
 B   ALTER TABLE ONLY public.deliveries DROP CONSTRAINT invoices_fkey;
       public          postgres    false    223    3278    228            �           2606    24680    order_items item_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT item_fkey FOREIGN KEY (delivery_item_id) REFERENCES public.delivery_items(id) NOT VALID;
 ?   ALTER TABLE ONLY public.order_items DROP CONSTRAINT item_fkey;
       public          postgres    false    219    3274    225            �           2606    16513    orders order_statuses_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT order_statuses_fkey FOREIGN KEY (status_id) REFERENCES public.order_statuses(id) NOT VALID;
 D   ALTER TABLE ONLY public.orders DROP CONSTRAINT order_statuses_fkey;
       public          postgres    false    220    3258    218            �           2606    16484    order_items orders_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT orders_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) NOT VALID;
 A   ALTER TABLE ONLY public.order_items DROP CONSTRAINT orders_fkey;
       public          postgres    false    219    3251    218            �           2606    24635    delivery_items products_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.delivery_items
    ADD CONSTRAINT products_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) NOT VALID;
 F   ALTER TABLE ONLY public.delivery_items DROP CONSTRAINT products_fkey;
       public          postgres    false    216    3243    225            �           2606    24617    deliveries vendors_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.deliveries
    ADD CONSTRAINT vendors_fkey FOREIGN KEY (vendor_id) REFERENCES public.vendors(id) NOT VALID;
 A   ALTER TABLE ONLY public.deliveries DROP CONSTRAINT vendors_fkey;
       public          postgres    false    222    3262    223            n   �   x�P�jQ�o�� 䩉ZZ���ڤ6�
b��)(j�@H�����8����?rny,ogfg��\0�����5�J\5����8##^�SK�n�N�����z#�O�>�p��N���D7������Y�s�ʳ��Pr2ƞ�ri�G6f^F߭ڐU��2�CSSd�![�K\�T�L�6�C�\	/�1pAg2y{���_ާ��P\��;+��;.1-�I�cR<����.      p   �  x�u��j�@��Wc���w~��,�H���N�w�i�B�������m����fߨ��j
-B�������o]����ӎ�~��}�N�!��-���Җ���[��K��ᦐU�;�]��i��7�Om3�N���g���6�>D�>J�%��¯h��
9��0��M�4/+�+�:笐����'������_�&*��W!��t p�U\p���`S�Λ��B��w�(���f�@���,Ќ�h�a?�&mɵ*U�k;7_X�h��d�xh"x7	�0T����xT���ȵ�9��Y3�F��/Z�J�+����_�VF^��<گ��K���VJK�,��K�ո;]L����F��i|7�������k��5���1=\ U�z��Ύ�=i�ZR���v��߂�m�H(���xUq#�Y;�]��F�|�a�}<�OU����dl�:6����8UYT9�8׵5���ƈ��0�'�,�~'�      v   I   x�M˱	�@C�ښ"$XRw���s�b�	���1J�N�]̕����(ԿJp�F�D8ܿKh�G�D����      z   ?   x�3�4�4�4202�5 "CCc+ ��".#��T�,o�"o�	�yC���|� �)�      x   R   x�5��� ��RLdl0��T��눐�w�w�N6SD��؁���B�,�Oq�d�LF����K1�MQB���ή����~}�      w   Y   x�%�=@@ �z�)�@��6�Qiit7@l�¼Y��fì7�^j��ʎS�}���)\�+�a̒l�X������K����o8m      t   ~   x�%�K
�@�o#���0t���ZI 8����F�I��U�[�ʠ����B�秆D�S4^ތL:x��|�O�Njuvc�87���3M>�jg���ڸ/?�׃\}��H�q���U��mf�      {   6   x�3�4�440�4202�50�54P04�2 !�?NC.#N�
9�+����� ���      r   2   x�3�4�4�4�43500�2�ACNsψ-@\.CN������� 
r      s   b   x�%ʻ�0E�ڞ�	��N�0���!�A@D�d�������Uz<p�2�sCX`q���QS��(F��Y�s�eGH�q�b�V%aC��3)�]��/CcC(      q   :   x�3�4C##c]c]CC+���2�4I"�Q��9́��i#�=... $�x      y   @   x�3�0����/l��~a녽\F@��M�_l����&�HА����.l��(��+F��� *�"A      o   �	  x��X�n[�}&�b�'���7�i� bX~!b�&�P�lj�$ʖ�J6a�A�4I��O)�<��_�t��g�9�����A�ù���k���T
����;�c۷C����~hԟ5�5��'Lrb���'/���2)��6�����;���Mc#c;�er������NJ���k��nl,��d(���N��~�˄���Xl�8424���`{r:��v�\YډXs\r[��7�+�h��Ȕ�BVMa���]��7�N���s��l��U�kq�����{l�H��wM8�sfF�'mӸ�d�Yw���39�\�i�7����g"��s�Û���XvȺ�-�`�}'g�5�k�,F�������T���9}1R"ۊ#�8�u�a��-WL���7��a�[�t�I��������%onk$�X�Hk�zb��O�m|� �c9�;#/�2�ȏ�2҈���f���s@�t�k��\�\�T*�	V�S;*���`Β:1۵����nu�|��찦@� {���;��3DE�ʀd (�f�_����f &����v@2�S]��8K�u��$����_	)��W�T�!��Y,���e��������VZ����8P�T�_폂��3�KA�Ѯ5g@�Hu��Aj�G���� ��YK� ���zγ�ɹ��E"W��2�E̓QmWL�8.�Q$GBB���fa3 6�^���~p�*h�Ld��F����~��� �� &.��~��=Y�b!-�d'����E^Zf��Է�FI�
��"���!ݕh`Ɣ���b�g��!��4W6��I	�R�T6�%��MS��+K�eX��)1� ����S�A��j@�.;G�(������2 "�0��Z��s�@:l7�ϔ��`Vh_@W�3l)ZN�SL��pN<��ǜ���P�!
o�MsB�M�n�� ��2P��|�kJ���6����~Chv<� )m��c�����C���EO`�����9(�̶���O��OC�p	�
�g$��2uT�@j<��m�ٻ��U�ju���9}p�6�b7�HA���2�i�
�y�ެӈ�'�rY���`-��e��(��<&z������S�l=0D*
�jA���"�uc�?kSN�rJ����Ny���F���d�aO���Ʌ|�1.��*�������M�_ R�*p(��Q߉�B'�����fi���Yٿ凲�&��\G��7E U�TR����m��uE쐇J�a�`ށ���GZ�;U;M|� ��G�8��r�t��L����]e�q'��e��+V���Su1<a_�WM	���L�"�v��� 1DSA����m�����L�� �bCG�&!f�^eVaV���3k+�[_:�ɻ��ڼn,��^Tf���^����[�����c�i�2��k�����<�B�.��i�S�9zR���'adC��X��5"��tg���X�]�U�j�����-H��@���ط��ɋ�a(Vƞ����V%@�j>:�o<2A���P�)m���d��u��k���O�:Ȝ+�Q��oU��������c�+'��	{R��vCvp5:4˥`C��r�<+���$�����U��Q�X�^PM�̨��N���o
�T�J��+&���1�~ʆ*� ��P C�������z �jis)X/X<)V6s�c��N(�WM�^'�  ��hZ�t��U�p�ՉN�l��&�\�cZ�H{����T	�S^^,��juA����f�hf�8����A�[����͐��]�[Ɍf6@i2�Jc�*u)q��Nb�c�7V3�����~��n�
��l��፠���мR����_2�>�Q���{y��E*Z0���뛨��$��x˔�o-j�*�9]����rays��U-n�jA�@��'������{u])�m���K���a֮o�c<0�o��̺JH�ouYk�_�`|?�	JJk� ��x�*��T���!!�A~)F]3�8-�ר��摰[��������*��	Ʃco��4��&��K�ň���?�$���hA�	d�Po>�?4�U��3�R��P�4k����b
�|:qr���\�s$}t�b��M�@F>}%�����8�vT�
q���$��]��&t���k[;���O�?��K_�x���c���/�9(7�r����uM;������۝'�4�#/�ȴX��e�2�ܩ=ޭ}S7K������,�\��Yb���ʧ�V��,W�%�v������;�+͕{T[��a���|-\NP<��n��ס=a�w%
=��҅��̬Y{���f���!��YW^)�O�4��o��#h}� c�U��Ֆ*��x��4S���C�^�e�6��ǌQ�Z1T�~��4��^��?ր��?ӭ�\����R��<�,�wȧ��f�o��4�*�ot4�v]�������K�����Y�Z�oF-��q]�xr����FQ���kϞ��׵�u�0�X|X.��b��=      u   9   x�3�0�.�����n%.#���.��x��������2��b�A�c���� ,�$     