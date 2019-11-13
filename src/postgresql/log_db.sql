--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5 (Ubuntu 11.5-3.pgdg18.04+1)
-- Dumped by pg_dump version 12.0 (Ubuntu 12.0-2.pgdg18.04+1)

-- Started on 2019-11-13 19:30:52 EET

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
-- Name: LogDB; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "LogDB";


ALTER SCHEMA "LogDB" OWNER TO postgres;

--
-- TOC entry 215 (class 1255 OID 24828)
-- Name: function1(timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: LogDB; Owner: postgres
--

CREATE FUNCTION "LogDB".function1(time1 timestamp without time zone, time2 timestamp without time zone) RETURNS TABLE(time_stamp timestamp without time zone, total bigint)
    LANGUAGE sql
    AS $$	SELECT log_timestamp, COUNT(log_id)
	FROM "LogDB".logs as logs
	WHERE logs.log_timestamp BETWEEN time1 AND time2
	GROUP BY logs.type, logs.log_timestamp
	ORDER BY logs.log_timestamp DESC
$$;


ALTER FUNCTION "LogDB".function1(time1 timestamp without time zone, time2 timestamp without time zone) OWNER TO postgres;

--
-- TOC entry 2966 (class 0 OID 0)
-- Dependencies: 215
-- Name: FUNCTION function1(time1 timestamp without time zone, time2 timestamp without time zone); Type: COMMENT; Schema: LogDB; Owner: postgres
--

COMMENT ON FUNCTION "LogDB".function1(time1 timestamp without time zone, time2 timestamp without time zone) IS '1. Find the total logs per type that were created within a specified time range and sort them in a descending order. Please note that individual files may log actions of more than one type.';


--
-- TOC entry 219 (class 1255 OID 24871)
-- Name: function10(character varying); Type: FUNCTION; Schema: LogDB; Owner: postgres
--

CREATE FUNCTION "LogDB".function10(firefox_version character varying) RETURNS TABLE(log_id integer)
    LANGUAGE sql
    AS $$	
SELECT log_id
FROM "LogDB".access_log as access_log
WHERE access_log.user_agent LIKE '%Firefox/' || firefox_version || '%'
$$;


ALTER FUNCTION "LogDB".function10(firefox_version character varying) OWNER TO postgres;

--
-- TOC entry 2967 (class 0 OID 0)
-- Dependencies: 219
-- Name: FUNCTION function10(firefox_version character varying); Type: COMMENT; Schema: LogDB; Owner: postgres
--

COMMENT ON FUNCTION "LogDB".function10(firefox_version character varying) IS '10. Find access logs that specified a particular version of Firefox as their browser.';


--
-- TOC entry 223 (class 1255 OID 24881)
-- Name: function11(character varying, timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: LogDB; Owner: postgres
--

CREATE FUNCTION "LogDB".function11(http_method_in character varying, time1 timestamp without time zone, time2 timestamp without time zone) RETURNS TABLE(ips character varying)
    LANGUAGE sql
    AS $$	
SELECT source_ip
FROM "LogDB".logs as l INNER JOIN "LogDB".access_log AS a ON l.log_id = a.log_id
WHERE http_method = http_method_in 
	AND log_timestamp BETWEEN time1 AND time2
$$;


ALTER FUNCTION "LogDB".function11(http_method_in character varying, time1 timestamp without time zone, time2 timestamp without time zone) OWNER TO postgres;

--
-- TOC entry 2968 (class 0 OID 0)
-- Dependencies: 223
-- Name: FUNCTION function11(http_method_in character varying, time1 timestamp without time zone, time2 timestamp without time zone); Type: COMMENT; Schema: LogDB; Owner: postgres
--

COMMENT ON FUNCTION "LogDB".function11(http_method_in character varying, time1 timestamp without time zone, time2 timestamp without time zone) IS '11. Find IPs that have issued a particular HTTP method on a particular time range.';


--
-- TOC entry 220 (class 1255 OID 24873)
-- Name: function12(timestamp without time zone, timestamp without time zone, character varying, character varying); Type: FUNCTION; Schema: LogDB; Owner: postgres
--

CREATE FUNCTION "LogDB".function12(time1 timestamp without time zone, time2 timestamp without time zone, http1 character varying, http2 character varying) RETURNS TABLE(source_ip character varying)
    LANGUAGE sql
    AS $$	
SELECT source_ip
FROM "LogDB".access_log AS a, "LogDB".logs AS l
WHERE a.log_id = l.log_id
	AND a.http_method = http1
	AND a.http_method = http2
	AND l.log_timestamp BETWEEN time1 AND time2
$$;


ALTER FUNCTION "LogDB".function12(time1 timestamp without time zone, time2 timestamp without time zone, http1 character varying, http2 character varying) OWNER TO postgres;

--
-- TOC entry 2969 (class 0 OID 0)
-- Dependencies: 220
-- Name: FUNCTION function12(time1 timestamp without time zone, time2 timestamp without time zone, http1 character varying, http2 character varying); Type: COMMENT; Schema: LogDB; Owner: postgres
--

COMMENT ON FUNCTION "LogDB".function12(time1 timestamp without time zone, time2 timestamp without time zone, http1 character varying, http2 character varying) IS '12. Find IPs that have issued two particular HTTP methods on a particular time range.';


--
-- TOC entry 224 (class 1255 OID 24883)
-- Name: function13(timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: LogDB; Owner: postgres
--

CREATE FUNCTION "LogDB".function13(time1 timestamp without time zone, time2 timestamp without time zone) RETURNS TABLE(ips character varying)
    LANGUAGE sql
    AS $$	
SELECT source_ip
FROM (
	SELECT source_ip, COUNT(DISTINCT(http_method)) as total
	FROM "LogDB".logs AS L INNER JOIN "LogDB".access_log AS A on L.log_id = A.log_id
	WHERE L.log_timestamp BETWEEN time1 AND time2
	GROUP BY source_ip) AS total_http_methods
WHERE total_http_methods.total >= 4
$$;


ALTER FUNCTION "LogDB".function13(time1 timestamp without time zone, time2 timestamp without time zone) OWNER TO postgres;

--
-- TOC entry 2970 (class 0 OID 0)
-- Dependencies: 224
-- Name: FUNCTION function13(time1 timestamp without time zone, time2 timestamp without time zone); Type: COMMENT; Schema: LogDB; Owner: postgres
--

COMMENT ON FUNCTION "LogDB".function13(time1 timestamp without time zone, time2 timestamp without time zone) IS '13. Find IPs that have issued any four distinct HTTP methods on a particular time range.';


--
-- TOC entry 216 (class 1255 OID 24841)
-- Name: function2(date, date, character varying); Type: FUNCTION; Schema: LogDB; Owner: postgres
--

CREATE FUNCTION "LogDB".function2(day1 date, day2 date, type_in character varying) RETURNS TABLE(day date, total_logs bigint)
    LANGUAGE sql
    AS $$	
SELECT log_timestamp::date AS day, COUNT(log_id) AS total_logs
	FROM "LogDB".logs as logs
	WHERE logs.type = type_in AND
		logs.log_timestamp::date BETWEEN day1 AND day2
	GROUP BY day
	ORDER BY total_logs DESC
$$;


ALTER FUNCTION "LogDB".function2(day1 date, day2 date, type_in character varying) OWNER TO postgres;

--
-- TOC entry 2971 (class 0 OID 0)
-- Dependencies: 216
-- Name: FUNCTION function2(day1 date, day2 date, type_in character varying); Type: COMMENT; Schema: LogDB; Owner: postgres
--

COMMENT ON FUNCTION "LogDB".function2(day1 date, day2 date, type_in character varying) IS '2. Find the total logs per day for a specific action type and time range.';


--
-- TOC entry 214 (class 1255 OID 24847)
-- Name: function4(); Type: FUNCTION; Schema: LogDB; Owner: postgres
--

CREATE FUNCTION "LogDB".function4() RETURNS TABLE(block_id integer, total_logs numeric)
    LANGUAGE sql
    AS $$	
WITH actions AS (
	SELECT *
	FROM "LogDB".logs AS l, "LogDB".blocks AS b
	WHERE l.log_id = b.log_id)
	
SELECT block_id, AVG(total)
FROM (
	SELECT block_id, log_timestamp, COUNT(*) as total
	FROM actions
	GROUP BY block_id, log_timestamp) AS total_blocks
GROUP BY block_id
$$;


ALTER FUNCTION "LogDB".function4() OWNER TO postgres;

--
-- TOC entry 2972 (class 0 OID 0)
-- Dependencies: 214
-- Name: FUNCTION function4(); Type: COMMENT; Schema: LogDB; Owner: postgres
--

COMMENT ON FUNCTION "LogDB".function4() IS '4. Find the top-5 Block IDs with regards to total number of actions per day for a specific date range (for types that Block ID is available).';


--
-- TOC entry 221 (class 1255 OID 24874)
-- Name: function5(); Type: FUNCTION; Schema: LogDB; Owner: postgres
--

CREATE FUNCTION "LogDB".function5() RETURNS TABLE(referers character varying)
    LANGUAGE sql
    AS $$	
SELECT referer
FROM "LogDB".access_log
WHERE ( 
	SELECT COUNT(resource)
	FROM "LogDB".access_log
	GROUP BY referer) >=1
$$;


ALTER FUNCTION "LogDB".function5() OWNER TO postgres;

--
-- TOC entry 2973 (class 0 OID 0)
-- Dependencies: 221
-- Name: FUNCTION function5(); Type: COMMENT; Schema: LogDB; Owner: postgres
--

COMMENT ON FUNCTION "LogDB".function5() IS '5. Find the referers (if any) that have led to more than one resources.';


--
-- TOC entry 217 (class 1255 OID 24864)
-- Name: function6(); Type: FUNCTION; Schema: LogDB; Owner: postgres
--

CREATE FUNCTION "LogDB".function6() RETURNS TABLE(second_most_common text)
    LANGUAGE sql
    AS $$	
WITH most_common AS (
	SELECT resource, COUNT(resource) AS total_resources
	FROM "LogDB".access_log AS access_log
	GROUP BY access_log.resource)

SELECT resource AS second_most_common
FROM "LogDB".access_log AS access_log
WHERE EXISTS (
	SELECT resource, MAX(total_resources)
	FROM most_common
	WHERE EXISTS (
		SELECT resource, MAX(total_resources)
		FROM most_common
		GROUP BY resource)
	GROUP BY resource)
$$;


ALTER FUNCTION "LogDB".function6() OWNER TO postgres;

--
-- TOC entry 2974 (class 0 OID 0)
-- Dependencies: 217
-- Name: FUNCTION function6(); Type: COMMENT; Schema: LogDB; Owner: postgres
--

COMMENT ON FUNCTION "LogDB".function6() IS '6. Find the 2nd–most–common resource requested.';


--
-- TOC entry 222 (class 1255 OID 24877)
-- Name: function7(double precision); Type: FUNCTION; Schema: LogDB; Owner: postgres
--

CREATE FUNCTION "LogDB".function7(x double precision) RETURNS TABLE(log_id integer, user_id character varying, http_method character varying, resource text, http_response character varying, response_size integer, referer text, user_agent text)
    LANGUAGE sql
    AS $$	
SELECT *
FROM "LogDB".access_log AS access_log
WHERE access_log.size < x
$$;


ALTER FUNCTION "LogDB".function7(x double precision) OWNER TO postgres;

--
-- TOC entry 2975 (class 0 OID 0)
-- Dependencies: 222
-- Name: FUNCTION function7(x double precision); Type: COMMENT; Schema: LogDB; Owner: postgres
--

COMMENT ON FUNCTION "LogDB".function7(x double precision) IS '7. Find the access log (all fields) where the size is less than a specified number.';


--
-- TOC entry 218 (class 1255 OID 24867)
-- Name: function8(); Type: FUNCTION; Schema: LogDB; Owner: postgres
--

CREATE FUNCTION "LogDB".function8() RETURNS TABLE(block integer)
    LANGUAGE sql
    AS $$	
SELECT block_id
FROM "LogDB".logs AS l1, "LogDB".blocks AS b
WHERE l1.log_id = b.log_id
	AND l1.type = 'served'
	AND b.block_id IN(
		SELECT block_id
		FROM "LogDB".logs AS l2, "LogDB".blocks AS b
		WHERE l2.log_id = b.log_id
			AND type = 'replicate'
			AND l1.log_timestamp::date = l2.log_timestamp::date)
$$;


ALTER FUNCTION "LogDB".function8() OWNER TO postgres;

--
-- TOC entry 2976 (class 0 OID 0)
-- Dependencies: 218
-- Name: FUNCTION function8(); Type: COMMENT; Schema: LogDB; Owner: postgres
--

COMMENT ON FUNCTION "LogDB".function8() IS '8. Find the blocks that have been replicated the same day that they have also been served';


SET default_tablespace = '';

--
-- TOC entry 198 (class 1259 OID 24680)
-- Name: access_log; Type: TABLE; Schema: LogDB; Owner: postgres
--

CREATE TABLE "LogDB".access_log (
    log_id integer NOT NULL,
    user_id character varying(50),
    http_method character varying(8),
    resource character varying(250),
    http_response text,
    size integer,
    referer text,
    user_agent text
);


ALTER TABLE "LogDB".access_log OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 24686)
-- Name: blocks; Type: TABLE; Schema: LogDB; Owner: postgres
--

CREATE TABLE "LogDB".blocks (
    log_id integer NOT NULL,
    block_id integer NOT NULL
);


ALTER TABLE "LogDB".blocks OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 24689)
-- Name: destinations; Type: TABLE; Schema: LogDB; Owner: postgres
--

CREATE TABLE "LogDB".destinations (
    log_id integer NOT NULL,
    destination character varying(20) NOT NULL
);


ALTER TABLE "LogDB".destinations OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 24677)
-- Name: hdfs_logs; Type: TABLE; Schema: LogDB; Owner: postgres
--

CREATE TABLE "LogDB".hdfs_logs (
    log_id integer NOT NULL,
    size integer
);


ALTER TABLE "LogDB".hdfs_logs OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 24692)
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
-- TOC entry 2829 (class 2606 OID 24696)
-- Name: hdfs_logs HDFS_pkey; Type: CONSTRAINT; Schema: LogDB; Owner: postgres
--

ALTER TABLE ONLY "LogDB".hdfs_logs
    ADD CONSTRAINT "HDFS_pkey" PRIMARY KEY (log_id);


--
-- TOC entry 2831 (class 2606 OID 24698)
-- Name: access_log access_pkey; Type: CONSTRAINT; Schema: LogDB; Owner: postgres
--

ALTER TABLE ONLY "LogDB".access_log
    ADD CONSTRAINT access_pkey PRIMARY KEY (log_id);


--
-- TOC entry 2833 (class 2606 OID 24702)
-- Name: destinations destinations_pkey; Type: CONSTRAINT; Schema: LogDB; Owner: postgres
--

ALTER TABLE ONLY "LogDB".destinations
    ADD CONSTRAINT destinations_pkey PRIMARY KEY (log_id, destination);


--
-- TOC entry 2835 (class 2606 OID 24704)
-- Name: logs logs_pkey; Type: CONSTRAINT; Schema: LogDB; Owner: postgres
--

ALTER TABLE ONLY "LogDB".logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (log_id);


--
-- TOC entry 2836 (class 2606 OID 24705)
-- Name: hdfs_logs hdfs_logid; Type: FK CONSTRAINT; Schema: LogDB; Owner: postgres
--

ALTER TABLE ONLY "LogDB".hdfs_logs
    ADD CONSTRAINT hdfs_logid FOREIGN KEY (log_id) REFERENCES "LogDB".logs(log_id);


--
-- TOC entry 2838 (class 2606 OID 24710)
-- Name: blocks log_id; Type: FK CONSTRAINT; Schema: LogDB; Owner: postgres
--

ALTER TABLE ONLY "LogDB".blocks
    ADD CONSTRAINT log_id FOREIGN KEY (log_id) REFERENCES "LogDB".hdfs_logs(log_id);


--
-- TOC entry 2839 (class 2606 OID 24715)
-- Name: destinations log_id; Type: FK CONSTRAINT; Schema: LogDB; Owner: postgres
--

ALTER TABLE ONLY "LogDB".destinations
    ADD CONSTRAINT log_id FOREIGN KEY (log_id) REFERENCES "LogDB".hdfs_logs(log_id);


--
-- TOC entry 2837 (class 2606 OID 24720)
-- Name: access_log log_id; Type: FK CONSTRAINT; Schema: LogDB; Owner: postgres
--

ALTER TABLE ONLY "LogDB".access_log
    ADD CONSTRAINT log_id FOREIGN KEY (log_id) REFERENCES "LogDB".logs(log_id);


-- Completed on 2019-11-13 19:30:52 EET

--
-- PostgreSQL database dump complete
--

