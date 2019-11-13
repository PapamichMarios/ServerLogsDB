--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5 (Ubuntu 11.5-1.pgdg18.04+1)
-- Dumped by pg_dump version 11.5 (Ubuntu 11.5-1.pgdg18.04+1)

-- Started on 2019-11-12 14:05:29 EET

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
-- TOC entry 6 (class 2615 OID 58466)
-- Name: LogDB; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "LogDB";


ALTER SCHEMA "LogDB" OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 195 (class 1259 OID 58467)
-- Name: HDFS; Type: TABLE; Schema: LogDB; Owner: postgres
--

CREATE TABLE "LogDB"."HDFS" (
    log_id integer NOT NULL,
    size integer
);


ALTER TABLE "LogDB"."HDFS" OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 58470)
-- Name: access; Type: TABLE; Schema: LogDB; Owner: postgres
--

CREATE TABLE "LogDB".access (
    "log_Id" integer NOT NULL,
    user_id character varying(50),
    http_method character varying(20),
    resource text,
    http_response character varying(20),
    size integer,
    referer text,
    user_agent text
);


ALTER TABLE "LogDB".access OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 58476)
-- Name: blocks; Type: TABLE; Schema: LogDB; Owner: postgres
--

CREATE TABLE "LogDB".blocks (
    log_id integer NOT NULL,
    destinations character varying(30) NOT NULL
);


ALTER TABLE "LogDB".blocks OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 58479)
-- Name: destinations; Type: TABLE; Schema: LogDB; Owner: postgres
--

CREATE TABLE "LogDB".destinations (
    log_id integer NOT NULL,
    destination character varying(20) NOT NULL
);


ALTER TABLE "LogDB".destinations OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 58482)
-- Name: logs; Type: TABLE; Schema: LogDB; Owner: postgres
--

CREATE TABLE "LogDB".logs (
    log_id integer NOT NULL,
    source_ip character varying(50),
    log_timestamp timestamp without time zone,
    type character varying(20)
);


ALTER TABLE "LogDB".logs OWNER TO postgres;

--
-- TOC entry 2817 (class 2606 OID 58486)
-- Name: HDFS HDFS_pkey; Type: CONSTRAINT; Schema: LogDB; Owner: postgres
--

ALTER TABLE ONLY "LogDB"."HDFS"
    ADD CONSTRAINT "HDFS_pkey" PRIMARY KEY (log_id);


--
-- TOC entry 2819 (class 2606 OID 58488)
-- Name: access access_pkey; Type: CONSTRAINT; Schema: LogDB; Owner: postgres
--

ALTER TABLE ONLY "LogDB".access
    ADD CONSTRAINT access_pkey PRIMARY KEY ("log_Id");


--
-- TOC entry 2821 (class 2606 OID 58490)
-- Name: blocks blocks_pkey; Type: CONSTRAINT; Schema: LogDB; Owner: postgres
--

ALTER TABLE ONLY "LogDB".blocks
    ADD CONSTRAINT blocks_pkey PRIMARY KEY (log_id, destinations);


--
-- TOC entry 2823 (class 2606 OID 58492)
-- Name: destinations destinations_pkey; Type: CONSTRAINT; Schema: LogDB; Owner: postgres
--

ALTER TABLE ONLY "LogDB".destinations
    ADD CONSTRAINT destinations_pkey PRIMARY KEY (log_id, destination);


--
-- TOC entry 2825 (class 2606 OID 58494)
-- Name: logs logs_pkey; Type: CONSTRAINT; Schema: LogDB; Owner: postgres
--

ALTER TABLE ONLY "LogDB".logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (log_id);


--
-- TOC entry 2826 (class 2606 OID 58495)
-- Name: HDFS hdfs_logid; Type: FK CONSTRAINT; Schema: LogDB; Owner: postgres
--

ALTER TABLE ONLY "LogDB"."HDFS"
    ADD CONSTRAINT hdfs_logid FOREIGN KEY (log_id) REFERENCES "LogDB".logs(log_id);


--
-- TOC entry 2828 (class 2606 OID 58500)
-- Name: blocks log_id; Type: FK CONSTRAINT; Schema: LogDB; Owner: postgres
--

ALTER TABLE ONLY "LogDB".blocks
    ADD CONSTRAINT log_id FOREIGN KEY (log_id) REFERENCES "LogDB"."HDFS"(log_id);


--
-- TOC entry 2829 (class 2606 OID 58505)
-- Name: destinations log_id; Type: FK CONSTRAINT; Schema: LogDB; Owner: postgres
--

ALTER TABLE ONLY "LogDB".destinations
    ADD CONSTRAINT log_id FOREIGN KEY (log_id) REFERENCES "LogDB"."HDFS"(log_id);


--
-- TOC entry 2827 (class 2606 OID 58510)
-- Name: access log_id; Type: FK CONSTRAINT; Schema: LogDB; Owner: postgres
--

ALTER TABLE ONLY "LogDB".access
    ADD CONSTRAINT log_id FOREIGN KEY ("log_Id") REFERENCES "LogDB".logs(log_id);


-- Completed on 2019-11-12 14:05:29 EET

--
-- PostgreSQL database dump complete
--

