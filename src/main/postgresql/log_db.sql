--
-- PostgreSQL database dump
--

-- Dumped from database version 11.6 (Ubuntu 11.6-1.pgdg18.04+1)
-- Dumped by pg_dump version 11.6 (Ubuntu 11.6-1.pgdg18.04+1)

-- Started on 2019-11-25 15:52:31 EET

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
-- TOC entry 6 (class 2615 OID 42763)
-- Name: log_db; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA log_db;


ALTER SCHEMA log_db OWNER TO postgres;

--
-- TOC entry 224 (class 1255 OID 42764)
-- Name: findbydest(character varying); Type: FUNCTION; Schema: log_db; Owner: postgres
--

CREATE FUNCTION log_db.findbydest(ip character varying) RETURNS TABLE(log_id bigint, dest_ip character varying)
    LANGUAGE sql
    AS $$ SELECT log_id,destination
FROM log_db.destinations AS destinations
WHERE destination = ip
$$;


ALTER FUNCTION log_db.findbydest(ip character varying) OWNER TO postgres;

--
-- TOC entry 225 (class 1255 OID 42765)
-- Name: findbysource(character varying); Type: FUNCTION; Schema: log_db; Owner: postgres
--

CREATE FUNCTION log_db.findbysource(ip character varying) RETURNS TABLE(log_id bigint, source_ip character varying)
    LANGUAGE sql
    AS $$ SELECT log_id,source_ip
FROM log_db.logs
WHERE source_ip = ip$$;


ALTER FUNCTION log_db.findbysource(ip character varying) OWNER TO postgres;

--
-- TOC entry 3029 (class 0 OID 0)
-- Dependencies: 225
-- Name: FUNCTION findbysource(ip character varying); Type: COMMENT; Schema: log_db; Owner: postgres
--

COMMENT ON FUNCTION log_db.findbysource(ip character varying) IS 'find logs by source ip';


--
-- TOC entry 226 (class 1255 OID 42766)
-- Name: function1(timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: log_db; Owner: postgres
--

CREATE FUNCTION log_db.function1(time1 timestamp without time zone, time2 timestamp without time zone) RETURNS TABLE(logtypes character varying, total bigint)
    LANGUAGE sql
    AS $$ SELECT logs.type, COUNT(log_id) as counts
		FROM "log_db".logs as logs
		WHERE logs.log_timestamp BETWEEN time1 AND time2
		GROUP BY logs.type
		ORDER BY counts DESC
$$;


ALTER FUNCTION log_db.function1(time1 timestamp without time zone, time2 timestamp without time zone) OWNER TO postgres;

--
-- TOC entry 3030 (class 0 OID 0)
-- Dependencies: 226
-- Name: FUNCTION function1(time1 timestamp without time zone, time2 timestamp without time zone); Type: COMMENT; Schema: log_db; Owner: postgres
--

COMMENT ON FUNCTION log_db.function1(time1 timestamp without time zone, time2 timestamp without time zone) IS '1. Find the total logs per type that were created within a specified time range and sort them in a descending order. Please note that individual files may log actions of more than one type.';


--
-- TOC entry 227 (class 1255 OID 42767)
-- Name: function10(character varying); Type: FUNCTION; Schema: log_db; Owner: postgres
--

CREATE FUNCTION log_db.function10(firefox_version character varying) RETURNS TABLE(log_id bigint)
    LANGUAGE sql
    AS $$	
SELECT log_id
FROM "log_db".access_log AS access_log
WHERE access_log.user_agent LIKE '%Firefox/' || firefox_version || '%'
$$;


ALTER FUNCTION log_db.function10(firefox_version character varying) OWNER TO postgres;

--
-- TOC entry 3031 (class 0 OID 0)
-- Dependencies: 227
-- Name: FUNCTION function10(firefox_version character varying); Type: COMMENT; Schema: log_db; Owner: postgres
--

COMMENT ON FUNCTION log_db.function10(firefox_version character varying) IS '10. Find access logs that specified a particular version of Firefox as their browser.';


--
-- TOC entry 228 (class 1255 OID 42768)
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
-- TOC entry 3032 (class 0 OID 0)
-- Dependencies: 228
-- Name: FUNCTION function11(http_method_in character varying, time1 timestamp without time zone, time2 timestamp without time zone); Type: COMMENT; Schema: log_db; Owner: postgres
--

COMMENT ON FUNCTION log_db.function11(http_method_in character varying, time1 timestamp without time zone, time2 timestamp without time zone) IS '11. Find IPs that have issued a particular HTTP method on a particular time range.';


--
-- TOC entry 229 (class 1255 OID 42769)
-- Name: function12(timestamp without time zone, timestamp without time zone, character varying, character varying); Type: FUNCTION; Schema: log_db; Owner: postgres
--

CREATE FUNCTION log_db.function12(time1 timestamp without time zone, time2 timestamp without time zone, http1 character varying, http2 character varying) RETURNS TABLE(source_ip character varying)
    LANGUAGE sql
    AS $$SELECT DISTINCT(ips.source_ip)
FROM (
	SELECT source_ip
	FROM "log_db".access_log AS a, "log_db".logs AS l
	WHERE (a.log_id = l.log_id
		AND a.http_method = http1
		AND l.log_timestamp BETWEEN time1 AND time2 ) AND EXISTS (
			SELECT source_ip
			FROM "log_db".access_log AS ac, "log_db".logs AS lg
			WHERE (ac.log_id = lg.log_id AND 
		   	   	   ac.http_method = http2 AND 
		   	   	   lg.log_timestamp BETWEEN time1 AND time2
				  )
			)
	) as ips
	
$$;


ALTER FUNCTION log_db.function12(time1 timestamp without time zone, time2 timestamp without time zone, http1 character varying, http2 character varying) OWNER TO postgres;

--
-- TOC entry 3033 (class 0 OID 0)
-- Dependencies: 229
-- Name: FUNCTION function12(time1 timestamp without time zone, time2 timestamp without time zone, http1 character varying, http2 character varying); Type: COMMENT; Schema: log_db; Owner: postgres
--

COMMENT ON FUNCTION log_db.function12(time1 timestamp without time zone, time2 timestamp without time zone, http1 character varying, http2 character varying) IS '12. Find IPs that have issued two particular HTTP methods on a particular time range.';


--
-- TOC entry 230 (class 1255 OID 42770)
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
-- TOC entry 3034 (class 0 OID 0)
-- Dependencies: 230
-- Name: FUNCTION function13(time1 timestamp without time zone, time2 timestamp without time zone); Type: COMMENT; Schema: log_db; Owner: postgres
--

COMMENT ON FUNCTION log_db.function13(time1 timestamp without time zone, time2 timestamp without time zone) IS '13. Find IPs that have issued any four distinct HTTP methods on a particular time range.';


--
-- TOC entry 231 (class 1255 OID 42771)
-- Name: function2(timestamp without time zone, timestamp without time zone, character varying); Type: FUNCTION; Schema: log_db; Owner: postgres
--

CREATE FUNCTION log_db.function2(day1 timestamp without time zone, day2 timestamp without time zone, type_in character varying) RETURNS TABLE(day date, total_logs bigint)
    LANGUAGE sql
    AS $$	
SELECT log_timestamp::date AS day, COUNT(log_id) AS total_logs
	FROM "log_db".logs as logs
	WHERE logs.type = type_in AND
		logs.log_timestamp BETWEEN day1 AND day2
	GROUP BY day
$$;


ALTER FUNCTION log_db.function2(day1 timestamp without time zone, day2 timestamp without time zone, type_in character varying) OWNER TO postgres;

--
-- TOC entry 3035 (class 0 OID 0)
-- Dependencies: 231
-- Name: FUNCTION function2(day1 timestamp without time zone, day2 timestamp without time zone, type_in character varying); Type: COMMENT; Schema: log_db; Owner: postgres
--

COMMENT ON FUNCTION log_db.function2(day1 timestamp without time zone, day2 timestamp without time zone, type_in character varying) IS '2. Find the total logs per day for a specific action type and time range.';


--
-- TOC entry 232 (class 1255 OID 42772)
-- Name: function3(timestamp without time zone); Type: FUNCTION; Schema: log_db; Owner: postgres
--

CREATE FUNCTION log_db.function3(time_in timestamp without time zone) RETURNS TABLE(ip character varying, type character varying, total bigint)
    LANGUAGE sql
    AS $$WITH counts AS (
		SELECT source_ip, type, COUNT(*) AS count
			FROM "log_db".logs AS logs
			WHERE logs.log_timestamp::date = time_in::date
			GROUP BY source_ip, type
)

SELECT counts.source_ip, counts.type, counts.count
FROM (
	SELECT source_ip, MAX(count) as maxcount
	FROM  counts 
	GROUP BY source_ip ) as maxcounts
	JOIN counts ON maxcounts.source_ip = counts.source_ip 
			   AND maxcounts.maxcount = counts.count
	

$$;


ALTER FUNCTION log_db.function3(time_in timestamp without time zone) OWNER TO postgres;

--
-- TOC entry 3036 (class 0 OID 0)
-- Dependencies: 232
-- Name: FUNCTION function3(time_in timestamp without time zone); Type: COMMENT; Schema: log_db; Owner: postgres
--

COMMENT ON FUNCTION log_db.function3(time_in timestamp without time zone) IS '3. Find the most common log per source IP for a specific day';


--
-- TOC entry 233 (class 1255 OID 42773)
-- Name: function4(date, date); Type: FUNCTION; Schema: log_db; Owner: postgres
--

CREATE FUNCTION log_db.function4(date1 date, date2 date) RETURNS TABLE(block_id character varying, average numeric)
    LANGUAGE sql
    AS $$WITH actions_in_daterange AS (
	SELECT COUNT(blocks.log_id) as actions, blocks.block_id
	FROM "log_db".blocks as blocks JOIN "log_db".logs as logs 
								     ON logs.log_id = blocks.log_id
	WHERE logs.log_timestamp::date BETWEEN date1 and date2
	GROUP BY block_id, logs.log_timestamp::date ) 
	
SELECT block_id, AVG(actions_in_daterange.actions) as avg_actions
FROM actions_in_daterange
GROUP BY block_id
ORDER BY avg_actions DESC
LIMIT 5$$;


ALTER FUNCTION log_db.function4(date1 date, date2 date) OWNER TO postgres;

--
-- TOC entry 234 (class 1255 OID 42774)
-- Name: function5(); Type: FUNCTION; Schema: log_db; Owner: postgres
--

CREATE FUNCTION log_db.function5() RETURNS TABLE(referers character varying)
    LANGUAGE sql
    AS $$	
SELECT referer
FROM "log_db".access_log
GROUP BY referer
HAVING COUNT(DISTINCT resource) > 1
$$;


ALTER FUNCTION log_db.function5() OWNER TO postgres;

--
-- TOC entry 3037 (class 0 OID 0)
-- Dependencies: 234
-- Name: FUNCTION function5(); Type: COMMENT; Schema: log_db; Owner: postgres
--

COMMENT ON FUNCTION log_db.function5() IS '5. Find the referers (if any) that have led to more than one resources.';


--
-- TOC entry 235 (class 1255 OID 42775)
-- Name: function6(); Type: FUNCTION; Schema: log_db; Owner: postgres
--

CREATE FUNCTION log_db.function6() RETURNS TABLE(second_most_common text)
    LANGUAGE sql
    AS $$	
WITH resources AS (
	SELECT resource, COUNT(resource) AS resource_count
	FROM "log_db".access_log AS access_log
	GROUP BY access_log.resource)

SELECT resource 
FROM resources
WHERE resource_count IN (
	SELECT Max(resource_count) 
	FROM resources
	WHERE resource_count < ( SELECT Max(resource_count) 
						 	 FROM resources)
	)
$$;


ALTER FUNCTION log_db.function6() OWNER TO postgres;

--
-- TOC entry 3038 (class 0 OID 0)
-- Dependencies: 235
-- Name: FUNCTION function6(); Type: COMMENT; Schema: log_db; Owner: postgres
--

COMMENT ON FUNCTION log_db.function6() IS '6. Find the 2nd–most–common resource requested.';


--
-- TOC entry 236 (class 1255 OID 42776)
-- Name: function7(double precision); Type: FUNCTION; Schema: log_db; Owner: postgres
--

CREATE FUNCTION log_db.function7(x double precision) RETURNS TABLE(log_id bigint, user_id character varying, http_method character varying, resource text, http_response character varying, response_size bigint, referer text, user_agent text)
    LANGUAGE sql
    AS $$	
SELECT *
FROM "log_db".access_log AS access_log
WHERE access_log.size < x
$$;


ALTER FUNCTION log_db.function7(x double precision) OWNER TO postgres;

--
-- TOC entry 3039 (class 0 OID 0)
-- Dependencies: 236
-- Name: FUNCTION function7(x double precision); Type: COMMENT; Schema: log_db; Owner: postgres
--

COMMENT ON FUNCTION log_db.function7(x double precision) IS '7. Find the access log (all fields) where the size is less than a specified number.';


--
-- TOC entry 237 (class 1255 OID 42777)
-- Name: function8(); Type: FUNCTION; Schema: log_db; Owner: postgres
--

CREATE FUNCTION log_db.function8() RETURNS TABLE(block character varying)
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
-- TOC entry 3040 (class 0 OID 0)
-- Dependencies: 237
-- Name: FUNCTION function8(); Type: COMMENT; Schema: log_db; Owner: postgres
--

COMMENT ON FUNCTION log_db.function8() IS '8. Find the blocks that have been replicated the same day that they have also been served';


--
-- TOC entry 238 (class 1255 OID 42778)
-- Name: function9(); Type: FUNCTION; Schema: log_db; Owner: postgres
--

CREATE FUNCTION log_db.function9() RETURNS TABLE(block_id character varying)
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
-- TOC entry 3041 (class 0 OID 0)
-- Dependencies: 238
-- Name: FUNCTION function9(); Type: COMMENT; Schema: log_db; Owner: postgres
--

COMMENT ON FUNCTION log_db.function9() IS '9. Find the blocks that have been replicated the same day and hour that they have also been
served.';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 197 (class 1259 OID 42779)
-- Name: access_log; Type: TABLE; Schema: log_db; Owner: postgres
--

CREATE TABLE log_db.access_log (
    log_id bigint NOT NULL,
    user_id character varying(50),
    http_method character varying(20) NOT NULL,
    resource text NOT NULL,
    http_response text NOT NULL,
    size bigint,
    referer text,
    user_agent text
);


ALTER TABLE log_db.access_log OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 42785)
-- Name: blocks; Type: TABLE; Schema: log_db; Owner: postgres
--

CREATE TABLE log_db.blocks (
    block_id character varying(255) NOT NULL,
    log_id bigint NOT NULL
);


ALTER TABLE log_db.blocks OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 42788)
-- Name: destinations; Type: TABLE; Schema: log_db; Owner: postgres
--

CREATE TABLE log_db.destinations (
    log_id bigint NOT NULL,
    destination character varying(255) NOT NULL
);


ALTER TABLE log_db.destinations OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 42791)
-- Name: hdfs_logs; Type: TABLE; Schema: log_db; Owner: postgres
--

CREATE TABLE log_db.hdfs_logs (
    log_id bigint NOT NULL,
    size integer
);


ALTER TABLE log_db.hdfs_logs OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 42794)
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
-- TOC entry 202 (class 1259 OID 42796)
-- Name: logs; Type: TABLE; Schema: log_db; Owner: postgres
--

CREATE TABLE log_db.logs (
    log_id bigint NOT NULL,
    source_ip character varying(50) NOT NULL,
    log_timestamp timestamp without time zone NOT NULL,
    type character varying(20) NOT NULL
);


ALTER TABLE log_db.logs OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 42799)
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
-- TOC entry 3042 (class 0 OID 0)
-- Dependencies: 203
-- Name: logs_log_id_seq; Type: SEQUENCE OWNED BY; Schema: log_db; Owner: postgres
--

ALTER SEQUENCE log_db.logs_log_id_seq OWNED BY log_db.logs.log_id;


--
-- TOC entry 204 (class 1259 OID 42801)
-- Name: queries; Type: TABLE; Schema: log_db; Owner: postgres
--

CREATE TABLE log_db.queries (
    query_id bigint NOT NULL,
    log text NOT NULL
);


ALTER TABLE log_db.queries OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 42807)
-- Name: queries_query_id_seq; Type: SEQUENCE; Schema: log_db; Owner: postgres
--

CREATE SEQUENCE log_db.queries_query_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE log_db.queries_query_id_seq OWNER TO postgres;

--
-- TOC entry 3043 (class 0 OID 0)
-- Dependencies: 205
-- Name: queries_query_id_seq; Type: SEQUENCE OWNED BY; Schema: log_db; Owner: postgres
--

ALTER SEQUENCE log_db.queries_query_id_seq OWNED BY log_db.queries.query_id;


--
-- TOC entry 206 (class 1259 OID 42809)
-- Name: roles; Type: TABLE; Schema: log_db; Owner: postgres
--

CREATE TABLE log_db.roles (
    id bigint NOT NULL,
    name character varying(60) NOT NULL
);


ALTER TABLE log_db.roles OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 42812)
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
-- TOC entry 3044 (class 0 OID 0)
-- Dependencies: 207
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: log_db; Owner: postgres
--

ALTER SEQUENCE log_db.roles_id_seq OWNED BY log_db.roles.id;


--
-- TOC entry 208 (class 1259 OID 42814)
-- Name: user_queries; Type: TABLE; Schema: log_db; Owner: postgres
--

CREATE TABLE log_db.user_queries (
    query_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE log_db.user_queries OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 42817)
-- Name: user_roles; Type: TABLE; Schema: log_db; Owner: postgres
--

CREATE TABLE log_db.user_roles (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE log_db.user_roles OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 42820)
-- Name: users; Type: TABLE; Schema: log_db; Owner: postgres
--

CREATE TABLE log_db.users (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    address character varying(255)
);


ALTER TABLE log_db.users OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 42826)
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
-- TOC entry 3045 (class 0 OID 0)
-- Dependencies: 211
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: log_db; Owner: postgres
--

ALTER SEQUENCE log_db.users_id_seq OWNED BY log_db.users.id;


--
-- TOC entry 2864 (class 2604 OID 42828)
-- Name: logs log_id; Type: DEFAULT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.logs ALTER COLUMN log_id SET DEFAULT nextval('log_db.logs_log_id_seq'::regclass);


--
-- TOC entry 2865 (class 2604 OID 42829)
-- Name: queries query_id; Type: DEFAULT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.queries ALTER COLUMN query_id SET DEFAULT nextval('log_db.queries_query_id_seq'::regclass);


--
-- TOC entry 2866 (class 2604 OID 42830)
-- Name: roles id; Type: DEFAULT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.roles ALTER COLUMN id SET DEFAULT nextval('log_db.roles_id_seq'::regclass);


--
-- TOC entry 2867 (class 2604 OID 42831)
-- Name: users id; Type: DEFAULT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.users ALTER COLUMN id SET DEFAULT nextval('log_db.users_id_seq'::regclass);


--
-- TOC entry 2869 (class 2606 OID 42833)
-- Name: access_log access_log_pkey; Type: CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.access_log
    ADD CONSTRAINT access_log_pkey PRIMARY KEY (log_id);


--
-- TOC entry 2871 (class 2606 OID 42835)
-- Name: blocks blocks_pkey; Type: CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.blocks
    ADD CONSTRAINT blocks_pkey PRIMARY KEY (block_id, log_id);


--
-- TOC entry 2873 (class 2606 OID 42837)
-- Name: destinations destinations_pkey; Type: CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.destinations
    ADD CONSTRAINT destinations_pkey PRIMARY KEY (destination, log_id);


--
-- TOC entry 2875 (class 2606 OID 42839)
-- Name: hdfs_logs hdfs_logs_pkey; Type: CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.hdfs_logs
    ADD CONSTRAINT hdfs_logs_pkey PRIMARY KEY (log_id);


--
-- TOC entry 2877 (class 2606 OID 42841)
-- Name: logs logs_pkey; Type: CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (log_id);


--
-- TOC entry 2880 (class 2606 OID 42843)
-- Name: queries queries_pkey; Type: CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.queries
    ADD CONSTRAINT queries_pkey PRIMARY KEY (query_id);


--
-- TOC entry 2882 (class 2606 OID 42845)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 2890 (class 2606 OID 42847)
-- Name: users uk_6dotkott2kjsp8vw4d0m25fb7; Type: CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.users
    ADD CONSTRAINT uk_6dotkott2kjsp8vw4d0m25fb7 UNIQUE (email);


--
-- TOC entry 2884 (class 2606 OID 42849)
-- Name: roles uk_nb4h0p6txrmfc0xbrd1kglp9t; Type: CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.roles
    ADD CONSTRAINT uk_nb4h0p6txrmfc0xbrd1kglp9t UNIQUE (name);


--
-- TOC entry 2892 (class 2606 OID 42851)
-- Name: users uk_r43af9ap4edm43mmtq01oddj6; Type: CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.users
    ADD CONSTRAINT uk_r43af9ap4edm43mmtq01oddj6 UNIQUE (username);


--
-- TOC entry 2886 (class 2606 OID 42853)
-- Name: user_queries user_queries_pkey; Type: CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.user_queries
    ADD CONSTRAINT user_queries_pkey PRIMARY KEY (query_id, user_id);


--
-- TOC entry 2888 (class 2606 OID 42855)
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (user_id, role_id);


--
-- TOC entry 2894 (class 2606 OID 42857)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 2878 (class 1259 OID 42858)
-- Name: timestamp_index; Type: INDEX; Schema: log_db; Owner: postgres
--

CREATE INDEX timestamp_index ON log_db.logs USING btree (log_timestamp);


--
-- TOC entry 2895 (class 2606 OID 42859)
-- Name: access_log fk8ne3u3l4xxei9axa3n8gg8no1; Type: FK CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.access_log
    ADD CONSTRAINT fk8ne3u3l4xxei9axa3n8gg8no1 FOREIGN KEY (log_id) REFERENCES log_db.logs(log_id);


--
-- TOC entry 2901 (class 2606 OID 42864)
-- Name: user_roles fkh8ciramu9cc9q3qcqiv4ue8a6; Type: FK CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.user_roles
    ADD CONSTRAINT fkh8ciramu9cc9q3qcqiv4ue8a6 FOREIGN KEY (role_id) REFERENCES log_db.roles(id);


--
-- TOC entry 2902 (class 2606 OID 42869)
-- Name: user_roles fkhfh9dx7w3ubf1co1vdev94g3f; Type: FK CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.user_roles
    ADD CONSTRAINT fkhfh9dx7w3ubf1co1vdev94g3f FOREIGN KEY (user_id) REFERENCES log_db.users(id);


--
-- TOC entry 2896 (class 2606 OID 42874)
-- Name: blocks fkhlqb7anx4xxn833j433vic1kg; Type: FK CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.blocks
    ADD CONSTRAINT fkhlqb7anx4xxn833j433vic1kg FOREIGN KEY (log_id) REFERENCES log_db.hdfs_logs(log_id);


--
-- TOC entry 2899 (class 2606 OID 42879)
-- Name: user_queries fkj1rfetxfu4hwawxr6qfdjdf1y; Type: FK CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.user_queries
    ADD CONSTRAINT fkj1rfetxfu4hwawxr6qfdjdf1y FOREIGN KEY (user_id) REFERENCES log_db.users(id);


--
-- TOC entry 2897 (class 2606 OID 42884)
-- Name: destinations fkjanbg521j1nipeu1n1nb4g9ai; Type: FK CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.destinations
    ADD CONSTRAINT fkjanbg521j1nipeu1n1nb4g9ai FOREIGN KEY (log_id) REFERENCES log_db.hdfs_logs(log_id);


--
-- TOC entry 2900 (class 2606 OID 42889)
-- Name: user_queries fkmmxi9cv1y16nn8bmahf3q6v2n; Type: FK CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.user_queries
    ADD CONSTRAINT fkmmxi9cv1y16nn8bmahf3q6v2n FOREIGN KEY (query_id) REFERENCES log_db.queries(query_id);


--
-- TOC entry 2898 (class 2606 OID 42894)
-- Name: hdfs_logs fkt4qs0t7t9jp8wyhs6pekim48y; Type: FK CONSTRAINT; Schema: log_db; Owner: postgres
--

ALTER TABLE ONLY log_db.hdfs_logs
    ADD CONSTRAINT fkt4qs0t7t9jp8wyhs6pekim48y FOREIGN KEY (log_id) REFERENCES log_db.logs(log_id);


-- Completed on 2019-11-25 15:52:31 EET

--
-- PostgreSQL database dump complete
--

