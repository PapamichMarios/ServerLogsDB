PGDMP     8    5            
    w            postgres     11.5 (Ubuntu 11.5-1.pgdg18.04+1)     11.5 (Ubuntu 11.5-1.pgdg18.04+1)     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �           1262    13130    postgres    DATABASE     z   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
    DROP DATABASE postgres;
             postgres    false            �           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                  postgres    false    2956            �           0    0    postgres    DATABASE PROPERTIES     J   ALTER DATABASE postgres SET search_path TO '$user', 'public', 'topology';
                  postgres    false    2956                        2615    58466    LogDB    SCHEMA        CREATE SCHEMA "LogDB";
    DROP SCHEMA "LogDB";
             postgres    false            �            1259    58467    HDFS    TABLE     O   CREATE TABLE "LogDB"."HDFS" (
    log_id integer NOT NULL,
    size integer
);
    DROP TABLE "LogDB"."HDFS";
       LogDB         postgres    false    6            �            1259    58470    access    TABLE     �   CREATE TABLE "LogDB".access (
    "log_Id" integer NOT NULL,
    user_id character varying(50),
    http_method character varying(20),
    resource text,
    http_response character varying(20),
    size integer,
    referer text,
    user_agent text
);
    DROP TABLE "LogDB".access;
       LogDB         postgres    false    6            �            1259    58476    blocks    TABLE     n   CREATE TABLE "LogDB".blocks (
    log_id integer NOT NULL,
    destinations character varying(30) NOT NULL
);
    DROP TABLE "LogDB".blocks;
       LogDB         postgres    false    6            �            1259    58479    destinations    TABLE     s   CREATE TABLE "LogDB".destinations (
    log_id integer NOT NULL,
    destination character varying(20) NOT NULL
);
 !   DROP TABLE "LogDB".destinations;
       LogDB         postgres    false    6            �            1259    58482    logs    TABLE     �   CREATE TABLE "LogDB".logs (
    log_id integer NOT NULL,
    source_ip character varying(50),
    log_timestamp timestamp without time zone,
    type character varying(20)
);
    DROP TABLE "LogDB".logs;
       LogDB         postgres    false    6                       2606    58486    HDFS HDFS_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY "LogDB"."HDFS"
    ADD CONSTRAINT "HDFS_pkey" PRIMARY KEY (log_id);
 =   ALTER TABLE ONLY "LogDB"."HDFS" DROP CONSTRAINT "HDFS_pkey";
       LogDB         postgres    false    195                       2606    58488    access access_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY "LogDB".access
    ADD CONSTRAINT access_pkey PRIMARY KEY ("log_Id");
 =   ALTER TABLE ONLY "LogDB".access DROP CONSTRAINT access_pkey;
       LogDB         postgres    false    196                       2606    58490    blocks blocks_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY "LogDB".blocks
    ADD CONSTRAINT blocks_pkey PRIMARY KEY (log_id, destinations);
 =   ALTER TABLE ONLY "LogDB".blocks DROP CONSTRAINT blocks_pkey;
       LogDB         postgres    false    197    197                       2606    58492    destinations destinations_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY "LogDB".destinations
    ADD CONSTRAINT destinations_pkey PRIMARY KEY (log_id, destination);
 I   ALTER TABLE ONLY "LogDB".destinations DROP CONSTRAINT destinations_pkey;
       LogDB         postgres    false    198    198            	           2606    58494    logs logs_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY "LogDB".logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (log_id);
 9   ALTER TABLE ONLY "LogDB".logs DROP CONSTRAINT logs_pkey;
       LogDB         postgres    false    199            
           2606    58495    HDFS hdfs_logid    FK CONSTRAINT     t   ALTER TABLE ONLY "LogDB"."HDFS"
    ADD CONSTRAINT hdfs_logid FOREIGN KEY (log_id) REFERENCES "LogDB".logs(log_id);
 <   ALTER TABLE ONLY "LogDB"."HDFS" DROP CONSTRAINT hdfs_logid;
       LogDB       postgres    false    2825    195    199                       2606    58500    blocks log_id    FK CONSTRAINT     r   ALTER TABLE ONLY "LogDB".blocks
    ADD CONSTRAINT log_id FOREIGN KEY (log_id) REFERENCES "LogDB"."HDFS"(log_id);
 8   ALTER TABLE ONLY "LogDB".blocks DROP CONSTRAINT log_id;
       LogDB       postgres    false    197    2817    195                       2606    58505    destinations log_id    FK CONSTRAINT     x   ALTER TABLE ONLY "LogDB".destinations
    ADD CONSTRAINT log_id FOREIGN KEY (log_id) REFERENCES "LogDB"."HDFS"(log_id);
 >   ALTER TABLE ONLY "LogDB".destinations DROP CONSTRAINT log_id;
       LogDB       postgres    false    198    2817    195                       2606    58510    access log_id    FK CONSTRAINT     r   ALTER TABLE ONLY "LogDB".access
    ADD CONSTRAINT log_id FOREIGN KEY ("log_Id") REFERENCES "LogDB".logs(log_id);
 8   ALTER TABLE ONLY "LogDB".access DROP CONSTRAINT log_id;
       LogDB       postgres    false    199    196    2825           