PGDMP  
        
            |            fastapi    16.3    16.3 "    -           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            .           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            /           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            0           1262    16411    fastapi    DATABASE     i   CREATE DATABASE fastapi WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE fastapi;
                postgres    false            �            1259    16436    users    TABLE     �   CREATE TABLE public.users (
    id integer NOT NULL,
    fname character varying NOT NULL,
    lname character varying NOT NULL,
    city character varying NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    16435    Users_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Users_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public."Users_id_seq";
       public          postgres    false    220            1           0    0    Users_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public."Users_id_seq" OWNED BY public.users.id;
          public          postgres    false    219            �            1259    16445    orders    TABLE     �   CREATE TABLE public.orders (
    order_id integer NOT NULL,
    user_id integer NOT NULL,
    item_id integer NOT NULL,
    quantity integer NOT NULL
);
    DROP TABLE public.orders;
       public         heap    postgres    false            �            1259    16444    orders_order_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.orders_order_id_seq;
       public          postgres    false    222            2           0    0    orders_order_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;
          public          postgres    false    221            �            1259    16425    posts    TABLE     �   CREATE TABLE public.posts (
    id integer NOT NULL,
    title character varying NOT NULL,
    content character varying NOT NULL,
    published boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);
    DROP TABLE public.posts;
       public         heap    postgres    false            �            1259    16424    posts_id_seq    SEQUENCE     �   CREATE SEQUENCE public.posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.posts_id_seq;
       public          postgres    false    218            3           0    0    posts_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;
          public          postgres    false    217            �            1259    16413    products    TABLE     �   CREATE TABLE public.products (
    name character varying NOT NULL,
    price integer NOT NULL,
    id integer NOT NULL,
    is_sale boolean DEFAULT false,
    inventory integer DEFAULT 0 NOT NULL
);
    DROP TABLE public.products;
       public         heap    postgres    false            �            1259    16412    products_Id_seq    SEQUENCE     �   CREATE SEQUENCE public."products_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public."products_Id_seq";
       public          postgres    false    216            4           0    0    products_Id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public."products_Id_seq" OWNED BY public.products.id;
          public          postgres    false    215            �           2604    16448    orders order_id    DEFAULT     r   ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);
 >   ALTER TABLE public.orders ALTER COLUMN order_id DROP DEFAULT;
       public          postgres    false    222    221    222            �           2604    16428    posts id    DEFAULT     d   ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);
 7   ALTER TABLE public.posts ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    218    218            �           2604    16416    products id    DEFAULT     l   ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public."products_Id_seq"'::regclass);
 :   ALTER TABLE public.products ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215    216            �           2604    16439    users id    DEFAULT     f   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public."Users_id_seq"'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    220    220            *          0    16445    orders 
   TABLE DATA           F   COPY public.orders (order_id, user_id, item_id, quantity) FROM stdin;
    public          postgres    false    222   �#       &          0    16425    posts 
   TABLE DATA           J   COPY public.posts (id, title, content, published, created_at) FROM stdin;
    public          postgres    false    218   $       $          0    16413    products 
   TABLE DATA           G   COPY public.products (name, price, id, is_sale, inventory) FROM stdin;
    public          postgres    false    216   %       (          0    16436    users 
   TABLE DATA           7   COPY public.users (id, fname, lname, city) FROM stdin;
    public          postgres    false    220   �%       5           0    0    Users_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public."Users_id_seq"', 6, true);
          public          postgres    false    219            6           0    0    orders_order_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.orders_order_id_seq', 4, true);
          public          postgres    false    221            7           0    0    posts_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.posts_id_seq', 7, true);
          public          postgres    false    217            8           0    0    products_Id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."products_Id_seq"', 10, true);
          public          postgres    false    215            �           2606    16443    users Users_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.users
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.users DROP CONSTRAINT "Users_pkey";
       public            postgres    false    220            �           2606    16450    orders orders_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public            postgres    false    222            �           2606    16434    posts posts_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.posts DROP CONSTRAINT posts_pkey;
       public            postgres    false    218            �           2606    16420    products products_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.products DROP CONSTRAINT products_pkey;
       public            postgres    false    216            �           2606    16456    orders product_id.fk    FK CONSTRAINT     x   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT "product_id.fk" FOREIGN KEY (item_id) REFERENCES public.products(id);
 @   ALTER TABLE ONLY public.orders DROP CONSTRAINT "product_id.fk";
       public          postgres    false    216    222    3467            �           2606    16451    orders user_id,fk    FK CONSTRAINT     r   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT "user_id,fk" FOREIGN KEY (user_id) REFERENCES public.users(id);
 =   ALTER TABLE ONLY public.orders DROP CONSTRAINT "user_id,fk";
       public          postgres    false    3471    222    220            *   #   x�3�4��4�2�4�4�4�2�4�L�b���� 5��      &   �   x�e��n�0�g��uhc�����%S�.��8p`7���#���M3��v����JЌ��z����+�F\gZa����_\�p�]g��2�	�w"����q/b��Js�'	)6�k�}@3e��_�`�J�J}P5(�6�VkYW�I5ϥn�P�Rd��݀⼿N���-�S���1�i�wX���!�)yǰ:�a�;�hJ���Jx[��,m��ZFK?Ts��S[W������OY�7�s      $   �   x�m���0��{��O`���2�bHHtd��")1��{�ĸ��󝟓�����Ѓ�\Ar��a�<++��Uc�� <T��{&4X�2���	�����ƣ{Ls߰�������1R��'d��AN%9�丛�Ə�iI0|��ӡ"�J��equ�����I�N�~��Xo��E6      (   y   x�5ʻ
�@����>���Db���,��l6Lv�^lg���(Z�G�)���W�7qᜒ�F5٢���&h&*��g�^vxؔz�9�-�,��
N�iQCM����ޕ��}�D���*�     