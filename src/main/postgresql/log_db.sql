--
-- PostgreSQL database dump
--

-- Dumped from database version 11.6 (Ubuntu 11.6-1.pgdg18.04+1)
-- Dumped by pg_dump version 12.1 (Ubuntu 12.1-1.pgdg18.04+1)

-- Started on 2019-11-18 22:16:14 EET

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
-- TOC entry 8 (class 2615 OID 24676)
-- Name: log_db; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA log_db;


ALTER SCHEMA log_db OWNER TO postgres;

--
-- TOC entry 228 (class 1255 OID 24828)
-- Name: function1(timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: log_db; Owner: postgres
--

CREATE FUNCTION log_db.function1(time1 timestamp without time zone, time2 timestamp without time zone) RETURNS TABLE(time_stamp timestamp without time zone, total bigint)
    LANGUAGE sql
    AS $$	SELECT log_timestamp, COUNT(log_id)
	FROM "log_db".logs as logs
	WHERE logs.log_timestamp BETWEEN time1 AND time2
	GROUP BY logs.type, logs.log_timestamp
	ORDER BY logs.log_timestamp DESC
$$;


ALTER FUNCTION log_db.function1(time1 timestamp without time zone, time2 timestamp without time zone) OWNER TO postgres;

--
-- TOC entry 3012 (class 0 OID 0)
-- Dependencies: 228
-- Name: FUNCTION function1(time1 timestamp without time zone, time2 timestamp without time zone); Type: COMMENT; Schema: log_db; Owner: postgres
--

COMMENT ON FUNCTION log_db.function1(time1 timestamp without time zone, time2 timestamp without time zone) IS '1. Find the total logs per type that were created within a specified time range and sort them in a descending order. Please note that individual files may log actions of more than one type.';


--
-- TOC entry 226 (class 1255 OID 24871)
-- Name: function10(character varying); Type: FUNCTION; Schema: log_db; Owner: postgres
--

CREATE FUNCTION log_db.function10(firefox_version character varying) RETURNS TABLE(log_id integer)
    LANGUAGE sql
    AS $$	
SELECT log_id
FROM "log_db".access_log AS access_log
WHERE access_log.user_agent LIKE '%Firefox/' || firefox_version || '%'
$$;


ALTER FUNCTION log_db.function10(firefox_version character varying) OWNER TO postgres;

--
-- TOC entry 3013 (class 0 OID 0)
-- Dependencies: 226
-- Name: FUNCTION function10(firefox_version character varying); Type: COMMENT; Schema: log_db; Owner: postgres
--

COMMENT ON FUNCTION log_db.function10(firefox_version character varying) IS '10. Find access logs that specified a particular version of Firefox as their browser.';


--
-- TOC entry 231 (class 1255 OID 24881)
-- Name: function11(character varying, timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: log_db; Owner: postgres
--

CREATE FUNCTION log_db.function11(http_method_in character varying, time1 timestamp without time zone, time2 timestamp without time zone) RETURNS TABLE(ips character varying)
    LANGUAGE sql
    AS $$	
SELECT source_ip
FROM "log_db".logs as l INNER JOIN "log_db".access_log AS a ON l.log_id = a.log_id
WHERE http_method = http_method_in 
	AND log_timestamp BETWEEN time1 AND time2
$$;


ALTER FUNCTION log_db.function11(http_method_in character varying, time1 timestamp without time zone, time2 timestamp without time zone) OWNER TO postgres;

--
-- TOC entry 3014 (class 0 OID 0)
-- Dependencies: 231
-- Name: FUNCTION function11(http_method_in character varying, time1 timestamp without time zone, time2 timestamp without time zone); Type: COMMENT; Schema: log_db; Owner: postgres
--

COMMENT ON FUNCTION log_db.function11(http_method_in character varying, time1 timestamp without time zone, time2 timestamp without time zone) IS '11. Find IPs that have issued a particular HTTP method on a particular time range.';


--
-- TOC entry 227 (class 1255 OID 24873)
-- Name: function12(timestamp without time zone, timestamp without time zone, character varying, character varying); Type: FUNCTION; Schema: log_db; Owner: postgres
--

CREATE FUNCTION log_db.function12(time1 timestamp without time zone, time2 timestamp without time zone, http1 character varying, http2 character varying) RETURNS TABLE(source_ip character varying)
    LANGUAGE sql
    AS $$	
SELECT source_ip
FROM "log_db".access_log AS a, "log_db".logs AS l
WHERE a.log_id = l.log_id
	AND a.http_method = http1
	AND a.http_method = http2
	AND l.log_timestamp BETWEEN time1 AND time2
$$;


ALTER FUNCTION log_db.function12(time1 timestamp without time zone, time2 timestamp without time zone, http1 character varying, http2 character varying) OWNER TO postgres;

--
-- TOC entry 3015 (class 0 OID 0)
-- Dependencies: 227
-- Name: FUNCTION function12(time1 timestamp without time zone, time2 timestamp without time zone, http1 character varying, http2 character varying); Type: COMMENT; Schema: log_db; Owner: postgres
--

COMMENT ON FUNCTION log_db.function12(time1 timestamp without time zone, time2 timestamp without time zone, http1 character varying, http2 character varying) IS '12. Find IPs that have issued two particular HTTP methods on a particular time range.';


--
-- TOC entry 232 (class 1255 OID 24883)
-- Name: function13(timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: log_db; Owner: postgres
--

CREATE FUNCTION log_db.function13(time1 timestamp without time zone, time2 timestamp without time zone) RETURNS TABLE(ips character varying)
    LANGUAGE sql
    AS $$	
SELECT source_ip
FROM (
	SELECT source_ip, COUNT(DISTINCT(http_method)) as total
	FROM "log_db".logs AS L INNER JOIN "log_db".access_log AS A on L.log_id = A.log_id
	WHERE L.log_timestamp BETWEEN time1 AND time2
	GROUP BY source_ip) AS total_http_methods
WHERE total_http_methods.total >= 4
$$;


ALTER FUNCTION log_db.function13(time1 timestamp without time zone, time2 timestamp without time zone) OWNER TO postgres;

--
-- TOC entry 3016 (class 0 OID 0)
-- Dependencies: 232
-- Name: FUNCTION function13(time1 timestamp without time zone, time2 timestamp without time zone); Type: COMMENT; Schema: log_db; Owner: postgres
--

COMMENT ON FUNCTION log_db.function13(time1 timestamp without time zone, time2 timestamp without time zone) IS '13. Find IPs that have issued any four distinct HTTP methods on a particular time range.';


--
-- TOC entry 221 (class 1255 OID 24841)
-- Name: function2(date, date, character varying); Type: FUNCTION; Schema: log_db; Owner: postgres
--

CREATE FUNCTION log_db.function2(day1 date, day2 date, type_in character varying) RETURNS TABLE(day date, total_logs bigint)
    LANGUAGE sql
    AS $$	
SELECT log_timestamp::date AS day, COUNT(log_id) AS total_logs
	FROM "log_db".logs as logs
	WHERE logs.type = type_in AND
		logs.log_timestamp::date BETWEEN day1 AND day2
	GROUP BY day
	ORDER BY total_logs DESC
$$;


ALTER FUNCTION log_db.function2(day1 date, day2 date, type_in character varying) OWNER TO postgres;

--
-- TOC entry 3017 (class 0 OID 0)
-- Dependencies: 221
-- Name: FUNCTION function2(day1 date, day2 date, type_in character varying); Type: COMMENT; Schema: log_db; Owner: postgres
--

COMMENT ON FUNCTION log_db.function2(day1 date, day2 date, type_in character varying) IS '2. Find the total logs per day for a specific action type and time range.';


--
-- TOC entry 230 (class 1255 OID 32871)
-- Name: function3(timestamp without time zone); Type: FUNCTION; Schema: log_db; Owner: postgres
--

CREATE FUNCTION log_db.function3(time_in timestamp without time zone) RETURNS TABLE(ip character varying, type character varying, total bigint)
    LANGUAGE sql
    AS $$
	SELECT source_ip, type, MAX(count)
	FROM (
		SELECT source_ip, type, COUNT(*) AS count
		FROM "log_db".logs AS logs
		WHERE logs.log_timestamp::date = time_in
		GROUP BY source_ip, type) AS per_day
	GROUP BY source_ip, type
$$;


ALTER FUNCTION log_db.function3(time_in timestamp without time zone) OWNER TO postgres;

--
-- TOC entry 3018 (class 0 OID 0)
-- Dependencies: 230
-- Name: FUNCTION function3(time_in timestamp without time zone); Type: COMMENT; Schema: log_db; Owner: postgres
--

COMMENT ON FUNCTION log_db.function3(time_in timestamp without time zone) IS '3. Find the most common log per source IP for a specific day';


--
-- TOC entry 222 (class 1255 OID 24847)
-- Name: function4(); Type: FUNCTION; Schema: log_db; Owner: postgres
--

CREATE FUNCTION log_db.function4() RETURNS TABLE(block_id integer, total_logs numeric)
    LANGUAGE sql
    AS $$	
WITH actions AS (
	SELECT *
	FROM "log_db".logs AS l, "log_db".blocks AS b
	WHERE l.log_id = b.log_id)
	
SELECT block_id, AVG(total)
FROM (
	SELECT block_id, log_timestamp, COUNT(*) as total
	FROM actions
	GROUP BY block_id, log_timestamp) AS total_blocks
GROUP BY block_id
$$;


ALTER FUNCTION log_db.function4() OWNER TO postgres;

--
-- TOC entry 3019 (class 0 OID 0)
-- Dependencies: 222
-- Name: FUNCTION function4(); Type: COMMENT; Schema: log_db; Owner: postgres
--

COMMENT ON FUNCTION log_db.function4() IS '4. Find the top-5 Block IDs with regards to total number of actions per day for a specific date range (for types that Block ID is available).';


--
-- TOC entry 229 (class 1255 OID 24874)
-- Name: function5(); Type: FUNCTION; Schema: log_db; Owner: postgres
--

CREATE FUNCTION log_db.function5() RETURNS TABLE(referers character varying)
    LANGUAGE sql
    AS $$	
SELECT referer
FROM "log_db".access_log
WHERE ( 
	SELECT COUNT(resource)
	FROM "log_db".access_log
	GROUP BY referer) >=1
$$;


ALTER FUNCTION log_db.function5() OWNER TO postgres;

--
-- TOC entry 3020 (class 0 OID 0)
-- Dependencies: 229
-- Name: FUNCTION function5(); Type: COMMENT; Schema: log_db; Owner: postgres
--

COMMENT ON FUNCTION log_db.function5() IS '5. Find the referers (if any) that have led to more than one resources.';


--
-- TOC entry 223 (class 1255 OID 24864)
-- Name: function6(); Type: FUNCTION; Schema: log_db; Owner: postgres
--

CREATE FUNCTION log_db.function6() RETURNS TABLE(second_most_common text)
    LANGUAGE sql
    AS $$	
WITH most_common AS (
	SELECT resource, COUNT(resource) AS total_resources
	FROM "log_db".access_log AS access_log
	GROUP BY access_log.resource)

SELECT resource AS second_most_common
FROM "log_db".access_log AS access_log
WHERE EXISTS (
	SELECT resource, MAX(total_resources)
	FROM most_common
	WHERE EXISTS (
		SELECT resource, MAX(total_resources)
		FROM most_common
		GROUP BY resource)
	GROUP BY resource)
$$;


ALTER FUNCTION log_db.function6() OWNER TO postgres;

--
-- TOC entry 3021 (class 0 OID 0)
-- Dependencies: 223
-- Name: FUNCTION function6(); Type: COMMENT; Schema: log_db; Owner: postgres
--

COMMENT ON FUNCTION log_db.function6() IS '6. Find the 2nd–most–common resource requested.';


--
-- TOC entry 224 (class 1255 OID 24877)
-- Name: function7(double precision); Type: FUNCTION; Schema: log_db; Owner: postgres
--

CREATE FUNCTION log_db.function7(x double precision) RETURNS TABLE(log_id integer, user_id character varying, http_method character varying, resource text, http_response character varying, response_size integer, referer text, user_agent text)
    LANGUAGE sql
    AS $$	
SELECT *
FROM "log_db".access_log AS access_log
WHERE access_log.size < x
$$;


ALTER FUNCTION log_db.function7(x double precision) OWNER TO postgres;

--
-- TOC entry 3022 (class 0 OID 0)
-- Dependencies: 224
-- Name: FUNCTION function7(x double precision); Type: COMMENT; Schema: log_db; Owner: postgres
--

COMMENT ON FUNCTION log_db.function7(x double precision) IS '7. Find the access log (all fields) where the size is less than a specified number.';


--
-- TOC entry 225 (class 1255 OID 24867)
-- Name: function8(); Type: FUNCTION; Schema: log_db; Owner: postgres
--

CREATE FUNCTION log_db.function8() RETURNS TABLE(block integer)
    LANGUAGE sql
    AS $$	
SELECT block_id
FROM "log_db".logs AS l1, "log_db".blocks AS b
WHERE l1.log_id = b.log_id
	AND l1.type = 'served'
	AND b.block_id IN(
		SELECT block_id
		FROM "log_db".logs AS l2, "log_db".blocks AS b
		WHERE l2.log_id = b.log_id
			AND type = 'replicate'
			AND l1.log_timestamp::date = l2.log_timestamp::date)
$$;


ALTER FUNCTION log_db.function8() OWNER TO postgres;

--
-- TOC entry 3023 (class 0 OID 0)
-- Dependencies: 225
-- Name: FUNCTION function8(); Type: COMMENT; Schema: log_db; Owner: postgres
--

COMMENT ON FUNCTION log_db.function8() IS '8. Find the blocks that have been replicated the same day that they have also been served';


--
-- TOC entry 233 (class 1255 OID 32875)
-- Name: function9(); Type: FUNCTION; Schema: log_db; Owner: postgres
--

CREATE FUNCTION log_db.function9() RETURNS TABLE(block_id integer)
    LANGUAGE sql
    AS $$
	SELECT block_id
	FROM "log_db".logs AS l1, "log_db".blocks AS b
	WHERE l1.log_id = b.log_id 
		AND l1.type = 'served'
		AND b.block_id IN (
			SELECT block_id
			FROM "log_db".logs AS l2, "log_db".blocks AS b
			WHERE l2.log_id = b.log_id
				AND l2.type = 'replicate'
				AND l1.log_timestamp::date = l2.log_timestamp::date
				AND l1.log_timestamp::time = l2.log_timestamp::time)
$$;


ALTER FUNCTION log_db.function9() OWNER TO postgres;

--
-- TOC entry 3024 (class 0 OID 0)
-- Dependencies: 233
-- Name: FUNCTION function9(); Type: COMMENT; Schema: log_db; Owner: postgres
--

COMMENT ON FUNCTION log_db.function9() IS '9. Find the blocks that have been replicated the same day and hour that they have also been
served.';


SET default_tablespace = '';

--
-- TOC entry 197 (class 1259 OID 33014)
-- Name: access_log; Type: TABLE; Schema: log_db; Owner: postgres
--

CREATE TABLE log_db.access_log (
    log_id bigint NOT NULL,
    http_method character varying(8),
    http_response text,
    referer text,
    resource character varying(250),
    size integer,
    user_agent text,
    user_id character varying(50)
);


ALTER TABLE log_db.access_log OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 33098)
-- Name: blocks; Type: TABLE; Schema: log_db; Owner: postgres
--

CREATE TABLE log_db.blocks (
    block_id bigint NOT NULL,
    log_id bigint NOT NULL
);


ALTER TABLE log_db.blocks OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 33103)
-- Name: destinations; Type: TABLE; Schema: log_db; Owner: postgres
--

CREATE TABLE log_db.destinations (
    destination character varying(255) NOT NULL,
    log_id bigint NOT NULL
);


ALTER TABLE log_db.destinations OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 33108)
-- Name: hdfs_logs; Type: TABLE; Schema: log_db; Owner: postgres
--

CREATE TABLE log_db.hdfs_logs (
    log_id bigint NOT NULL,
    size integer
);


ALTER TABLE log_db.hdfs_logs OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 33081)
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: log_db; Owner: postgres
--

CREATE SEQUENCE log_db.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE log_db.hibernate_sequence OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 33134)
-- Name: logs; Type: TABLE; Schema: log_db; Owner: postgres
--

CREATE TABLE log_db.logs (
    log_id bigint NOT NULL,
    log_timestamp timestamp without time zone NOT NULL,
    source_ip character varying(50) NOT NULL,
    type character varying(20) NOT NULL
);


ALTER TABLE log_db.logs OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 33132)
-- Name: logs_log_id_seq; Type: SEQUENCE; Schema: log_db; Owner: postgres
--

CREATE SEQUENCE log_db.logs_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE log_db.logs_log_id_seq OWNER TO postgres;

--
-- TOC entry 3025 (class 0 OID 0)
-- Dependencies: 207
-- Name: logs_log_id_seq; Type: SEQUENCE OWNED BY; Schema: log_db; Owner: postgres
--

ALTER SEQUENCE log_db.logs_log_id_seq OWNED BY log_db.logs.log_id;


--
-- TOC entry 199 (class 1259 OID 33032)
-- Name: roles; Type: TABLE; Schema: log_db; Owner: postgres
--

CREATE TABLE log_db.roles (
    id bigint NOT NULL,
    name character varying(60)
);


ALTER TABLE log_db.roles OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 33030)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: log_db; Owner: postgres
--

CREATE SEQUENCE log_db.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE log_db.roles_id_seq OWNER TO postgres;

--
-- TOC entry 3026 (class 0 OID 0)
-- Dependencies: 198
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: log_db; Owner: postgres
--

ALTER SEQUENCE log_db.roles_id_seq OWNED BY log_db.roles.id;


--
-- TOC entry 200 (class 1259 OID 33038)
-- Name: user_roles; Type: TABLE; Schema: log_db; Owner: postgres
--

CREATE TABLE log_db.user_roles (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE log_db.user_roles OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 33045)
-- Name: users; Type: TABLE; Schema: log_db; Owner: postgres
--

CREATE TABLE log_db.users (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255),
    username character varying(255) NOT NULL
);


ALTER TABLE log_db.users OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 33043)
-- Name: users_id_seq; Type: SEQUENCE; Schema: log_db; Owner: postgres
--

CREATE SEQUENCE log_db.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE log_db.users_id_seq OWNER TO postgres;

--
-- TOC entry 3027 (class 0 OID 0)
-- Dependencies: 201
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: log_db; Owner: postgres
--

ALTER SEQUENCE log_db.users_id_seq OWNED BY log_db.users.id;


--
-- TOC entry 2853 (class 2604 OID 33137)
-- Name: logs log_id; Type: DEFAULT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.logs ALTER COLUMN log_id SET DEFAULT nextval('log_db.logs_log_id_seq'::regclass);


--
-- TOC entry 2851 (class 2604 OID 33035)
-- Name: roles id; Type: DEFAULT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.roles ALTER COLUMN id SET DEFAULT nextval('log_db.roles_id_seq'::regclass);


--
-- TOC entry 2852 (class 2604 OID 33048)
-- Name: users id; Type: DEFAULT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.users ALTER COLUMN id SET DEFAULT nextval('log_db.users_id_seq'::regclass);


--
-- TOC entry 2855 (class 2606 OID 33021)
-- Name: access_log access_log_pkey; Type: CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.access_log
    ADD CONSTRAINT access_log_pkey PRIMARY KEY (log_id);


--
-- TOC entry 2869 (class 2606 OID 33102)
-- Name: blocks blocks_pkey; Type: CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.blocks
    ADD CONSTRAINT blocks_pkey PRIMARY KEY (block_id, log_id);


--
-- TOC entry 2873 (class 2606 OID 33107)
-- Name: destinations destinations_pkey; Type: CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.destinations
    ADD CONSTRAINT destinations_pkey PRIMARY KEY (destination, log_id);


--
-- TOC entry 2877 (class 2606 OID 33112)
-- Name: hdfs_logs hdfs_logs_pkey; Type: CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.hdfs_logs
    ADD CONSTRAINT hdfs_logs_pkey PRIMARY KEY (log_id);


--
-- TOC entry 2879 (class 2606 OID 33139)
-- Name: logs logs_pkey; Type: CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (log_id);


--
-- TOC entry 2857 (class 2606 OID 33037)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 2863 (class 2606 OID 33057)
-- Name: users uk_6dotkott2kjsp8vw4d0m25fb7; Type: CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.users
    ADD CONSTRAINT uk_6dotkott2kjsp8vw4d0m25fb7 UNIQUE (email);


--
-- TOC entry 2871 (class 2606 OID 33114)
-- Name: blocks uk_fu9bsi6kyy6pi528yqpot4xtq; Type: CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.blocks
    ADD CONSTRAINT uk_fu9bsi6kyy6pi528yqpot4xtq UNIQUE (log_id);


--
-- TOC entry 2859 (class 2606 OID 33055)
-- Name: roles uk_nb4h0p6txrmfc0xbrd1kglp9t; Type: CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.roles
    ADD CONSTRAINT uk_nb4h0p6txrmfc0xbrd1kglp9t UNIQUE (name);


--
-- TOC entry 2875 (class 2606 OID 33116)
-- Name: destinations uk_on2bkidfv80t8717ds1aqqmo6; Type: CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.destinations
    ADD CONSTRAINT uk_on2bkidfv80t8717ds1aqqmo6 UNIQUE (log_id);


--
-- TOC entry 2865 (class 2606 OID 33059)
-- Name: users uk_r43af9ap4edm43mmtq01oddj6; Type: CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.users
    ADD CONSTRAINT uk_r43af9ap4edm43mmtq01oddj6 UNIQUE (username);


--
-- TOC entry 2861 (class 2606 OID 33042)
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (user_id, role_id);


--
-- TOC entry 2867 (class 2606 OID 33053)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 2880 (class 2606 OID 33140)
-- Name: access_log fk8ne3u3l4xxei9axa3n8gg8no1; Type: FK CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.access_log
    ADD CONSTRAINT fk8ne3u3l4xxei9axa3n8gg8no1 FOREIGN KEY (log_id) REFERENCES log_db.logs(log_id);


--
-- TOC entry 2881 (class 2606 OID 33065)
-- Name: user_roles fkh8ciramu9cc9q3qcqiv4ue8a6; Type: FK CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.user_roles
    ADD CONSTRAINT fkh8ciramu9cc9q3qcqiv4ue8a6 FOREIGN KEY (role_id) REFERENCES log_db.roles(id);


--
-- TOC entry 2882 (class 2606 OID 33070)
-- Name: user_roles fkhfh9dx7w3ubf1co1vdev94g3f; Type: FK CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.user_roles
    ADD CONSTRAINT fkhfh9dx7w3ubf1co1vdev94g3f FOREIGN KEY (user_id) REFERENCES log_db.users(id);


--
-- TOC entry 2883 (class 2606 OID 33117)
-- Name: blocks fkhlqb7anx4xxn833j433vic1kg; Type: FK CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.blocks
    ADD CONSTRAINT fkhlqb7anx4xxn833j433vic1kg FOREIGN KEY (log_id) REFERENCES log_db.hdfs_logs(log_id);


--
-- TOC entry 2884 (class 2606 OID 33122)
-- Name: destinations fkjanbg521j1nipeu1n1nb4g9ai; Type: FK CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.destinations
    ADD CONSTRAINT fkjanbg521j1nipeu1n1nb4g9ai FOREIGN KEY (log_id) REFERENCES log_db.hdfs_logs(log_id);


--
-- TOC entry 2885 (class 2606 OID 33145)
-- Name: hdfs_logs fkt4qs0t7t9jp8wyhs6pekim48y; Type: FK CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.hdfs_logs
    ADD CONSTRAINT fkt4qs0t7t9jp8wyhs6pekim48y FOREIGN KEY (log_id) REFERENCES log_db.logs(log_id);


-- Completed on 2019-11-18 22:16:14 EET

--
-- PostgreSQL database dump complete
--

