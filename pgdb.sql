PGDMP                         y            pdDB    13.2    13.2 ,    ?           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ?           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            ?           1262    16394    pdDB    DATABASE     c   CREATE DATABASE "pdDB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'French_Morocco.1252';
    DROP DATABASE "pdDB";
                postgres    false            ?            1255    16404    changestatus() 	   PROCEDURE     ?   CREATE PROCEDURE public.changestatus()
    LANGUAGE sql
    AS $$
UPDATE youcoders
SET is_accepted  = true
WHERE campus  = 'Youssoufia'
$$;
 &   DROP PROCEDURE public.changestatus();
       public          postgres    false            ?            1255    16465 
   countall()    FUNCTION     ?   CREATE FUNCTION public.countall() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
n INTEGER;

BEGIN
SELECT COUNT(*) INTO n FROM youcodersv2;



return n;

END
$$;
 !   DROP FUNCTION public.countall();
       public          postgres    false            ?            1255    16411    emp_stamp()    FUNCTION     ?   CREATE FUNCTION public.emp_stamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
       UPDATE youcoders SET is_accepted = false;
	   RETURN NEW;
    END;
$$;
 "   DROP FUNCTION public.emp_stamp();
       public          postgres    false            ?            1255    16466    lasttg()    FUNCTION     ?   CREATE FUNCTION public.lasttg() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
       UPDATE youcodersv2 SET nbr_competence  = 15;
       RETURN NEW;
    END;
$$;
    DROP FUNCTION public.lasttg();
       public          postgres    false            ?            1255    16401 0   nbyoucoders(character varying, boolean, integer)    FUNCTION     V  CREATE FUNCTION public.nbyoucoders(ville character varying, status boolean, seuil integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
n INTEGER;
BEGIN
SELECT COUNT(*) INTO n FROM youcoders where is_accepted=status and campus = ville;
IF n < seuil THEN
RAISE EXCEPTION 'Trop de rattrapage (%) !', n;
ELSE
RETURN n;
END IF;
END
$$;
 Z   DROP FUNCTION public.nbyoucoders(ville character varying, status boolean, seuil integer);
       public          postgres    false            ?            1255    16402    percetage(integer)    FUNCTION       CREATE FUNCTION public.percetage(total integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
n INTEGER;
pe NUMERIC;
BEGIN
SELECT COUNT(*) INTO n FROM youcoders where campus='Youssoufia' and classe = 'FEBE';

pe = (total * n)/100;

return pe;

END
$$;
 /   DROP FUNCTION public.percetage(total integer);
       public          postgres    false            ?            1255    16403    stsameref(character varying)    FUNCTION     -  CREATE FUNCTION public.stsameref(student character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
sClasse VARCHAR;
n INTEGER;

BEGIN
SELECT classe INTO sClasse FROM youcoders where full_name=student;

SELECT COUNT(*) INTO n FROM youcoders where classe=sClasse;




return n;

END
$$;
 ;   DROP FUNCTION public.stsameref(student character varying);
       public          postgres    false            ?            1255    16407    updateclasse() 	   PROCEDURE     ?   CREATE PROCEDURE public.updateclasse()
    LANGUAGE sql
    AS $$
UPDATE youcoders
SET classe  = 'DATA BI'
WHERE nbr_competence=14 AND matricule LIKE '%2%'
$$;
 &   DROP PROCEDURE public.updateclasse();
       public          postgres    false            ?            1259    16416    campus    TABLE     g   CREATE TABLE public.campus (
    id integer NOT NULL,
    campusname character varying(15) NOT NULL
);
    DROP TABLE public.campus;
       public         heap    postgres    false            ?            1259    16414    campus_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.campus_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.campus_id_seq;
       public          postgres    false    202            ?           0    0    campus_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.campus_id_seq OWNED BY public.campus.id;
          public          postgres    false    201            ?            1259    16424    classe    TABLE     g   CREATE TABLE public.classe (
    id integer NOT NULL,
    classename character varying(15) NOT NULL
);
    DROP TABLE public.classe;
       public         heap    postgres    false            ?            1259    16422    classe_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.classe_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.classe_id_seq;
       public          postgres    false    204            ?           0    0    classe_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.classe_id_seq OWNED BY public.classe.id;
          public          postgres    false    203            ?            1259    16432    referentiel    TABLE     q   CREATE TABLE public.referentiel (
    id integer NOT NULL,
    referentielname character varying(15) NOT NULL
);
    DROP TABLE public.referentiel;
       public         heap    postgres    false            ?            1259    16430    referentiel_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.referentiel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.referentiel_id_seq;
       public          postgres    false    206            ?           0    0    referentiel_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.referentiel_id_seq OWNED BY public.referentiel.id;
          public          postgres    false    205            ?            1259    16395 	   youcoders    TABLE     G  CREATE TABLE public.youcoders (
    matricule character varying(4) NOT NULL,
    full_name character varying(15) NOT NULL,
    campus character varying(15) NOT NULL,
    classe character varying(15) NOT NULL,
    referentiel character varying(15) NOT NULL,
    nbr_competence numeric(5,0) DEFAULT 0,
    is_accepted boolean
);
    DROP TABLE public.youcoders;
       public         heap    postgres    false            ?            1259    16444    youcodersv2    TABLE       CREATE TABLE public.youcodersv2 (
    matricule character varying(4) NOT NULL,
    full_name character varying(15) NOT NULL,
    campus integer,
    classe integer,
    referentiel integer,
    nbr_competence numeric(5,0) DEFAULT 0,
    is_accepted boolean
);
    DROP TABLE public.youcodersv2;
       public         heap    postgres    false            ?           2604    16419 	   campus id    DEFAULT     f   ALTER TABLE ONLY public.campus ALTER COLUMN id SET DEFAULT nextval('public.campus_id_seq'::regclass);
 8   ALTER TABLE public.campus ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    202    201    202            @           2604    16427 	   classe id    DEFAULT     f   ALTER TABLE ONLY public.classe ALTER COLUMN id SET DEFAULT nextval('public.classe_id_seq'::regclass);
 8   ALTER TABLE public.classe ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    203    204    204            A           2604    16435    referentiel id    DEFAULT     p   ALTER TABLE ONLY public.referentiel ALTER COLUMN id SET DEFAULT nextval('public.referentiel_id_seq'::regclass);
 =   ALTER TABLE public.referentiel ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    206    205    206            ?          0    16416    campus 
   TABLE DATA           0   COPY public.campus (id, campusname) FROM stdin;
    public          postgres    false    202   ?3       ?          0    16424    classe 
   TABLE DATA           0   COPY public.classe (id, classename) FROM stdin;
    public          postgres    false    204   4       ?          0    16432    referentiel 
   TABLE DATA           :   COPY public.referentiel (id, referentielname) FROM stdin;
    public          postgres    false    206   J4       ?          0    16395 	   youcoders 
   TABLE DATA           s   COPY public.youcoders (matricule, full_name, campus, classe, referentiel, nbr_competence, is_accepted) FROM stdin;
    public          postgres    false    200   m4       ?          0    16444    youcodersv2 
   TABLE DATA           u   COPY public.youcodersv2 (matricule, full_name, campus, classe, referentiel, nbr_competence, is_accepted) FROM stdin;
    public          postgres    false    207   [5       ?           0    0    campus_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.campus_id_seq', 1, false);
          public          postgres    false    201            ?           0    0    classe_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.classe_id_seq', 1, false);
          public          postgres    false    203            ?           0    0    referentiel_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.referentiel_id_seq', 1, false);
          public          postgres    false    205            F           2606    16421    campus campus_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.campus
    ADD CONSTRAINT campus_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.campus DROP CONSTRAINT campus_pkey;
       public            postgres    false    202            H           2606    16429    classe classe_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.classe
    ADD CONSTRAINT classe_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.classe DROP CONSTRAINT classe_pkey;
       public            postgres    false    204            J           2606    16437    referentiel referentiel_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.referentiel
    ADD CONSTRAINT referentiel_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.referentiel DROP CONSTRAINT referentiel_pkey;
       public            postgres    false    206            D           2606    16400    youcoders youcoders_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.youcoders
    ADD CONSTRAINT youcoders_pkey PRIMARY KEY (matricule);
 B   ALTER TABLE ONLY public.youcoders DROP CONSTRAINT youcoders_pkey;
       public            postgres    false    200            L           2606    16449    youcodersv2 youcodersv2_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.youcodersv2
    ADD CONSTRAINT youcodersv2_pkey PRIMARY KEY (matricule);
 F   ALTER TABLE ONLY public.youcodersv2 DROP CONSTRAINT youcodersv2_pkey;
       public            postgres    false    207            P           2620    16412    youcoders emp_stamp    TRIGGER     l   CREATE TRIGGER emp_stamp AFTER INSERT ON public.youcoders FOR EACH ROW EXECUTE FUNCTION public.emp_stamp();
 ,   DROP TRIGGER emp_stamp ON public.youcoders;
       public          postgres    false    213    200            Q           2620    16467    youcodersv2 lasttg    TRIGGER     h   CREATE TRIGGER lasttg AFTER INSERT ON public.youcodersv2 FOR EACH ROW EXECUTE FUNCTION public.lasttg();
 +   DROP TRIGGER lasttg ON public.youcodersv2;
       public          postgres    false    215    207            M           2606    16450    youcodersv2 fk_campus    FK CONSTRAINT     t   ALTER TABLE ONLY public.youcodersv2
    ADD CONSTRAINT fk_campus FOREIGN KEY (campus) REFERENCES public.campus(id);
 ?   ALTER TABLE ONLY public.youcodersv2 DROP CONSTRAINT fk_campus;
       public          postgres    false    207    202    2886            N           2606    16455    youcodersv2 fk_classe    FK CONSTRAINT     t   ALTER TABLE ONLY public.youcodersv2
    ADD CONSTRAINT fk_classe FOREIGN KEY (classe) REFERENCES public.classe(id);
 ?   ALTER TABLE ONLY public.youcodersv2 DROP CONSTRAINT fk_classe;
       public          postgres    false    207    2888    204            O           2606    16460    youcodersv2 fk_referentiel    FK CONSTRAINT     ?   ALTER TABLE ONLY public.youcodersv2
    ADD CONSTRAINT fk_referentiel FOREIGN KEY (referentiel) REFERENCES public.referentiel(id);
 D   ALTER TABLE ONLY public.youcodersv2 DROP CONSTRAINT fk_referentiel;
       public          postgres    false    206    2890    207            ?      x?3?tLOL?,?????? Z5      ?      x?3???OI?
V?JML.?????? @/N      ?      x?3?tvt?????? ??      ?   ?   x?}?MK?@E?7??A?2I???$3???
???A?t????N?A??s7???6i?????;G<r??Vk???F?6y&????=_?"?3??3????R??_^???7|"?pi??wO?be????:?W{B?N?rM?j??h?s?Fx?b??_?'?f9???I?????~???aA?ޙ<???䓤??h????a?7????a????RV????? > ?v?      ?   9   x?012??v?u?Qp?p?4?@S?? CKN'WgGOTq#K?Ĥ?|d?=... ;?D     