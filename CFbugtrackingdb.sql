--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2024-03-31 23:31:05

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
-- TOC entry 863 (class 1247 OID 16501)
-- Name: error_action; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.error_action AS ENUM (
    'Назначение',
    'Решение',
    'Перепоручение',
    'Проверка',
    'Закрытие'
);


ALTER TYPE public.error_action OWNER TO postgres;

--
-- TOC entry 854 (class 1247 OID 16432)
-- Name: error_criticality; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.error_criticality AS ENUM (
    'Авария',
    'Критично',
    'Не критично',
    'Запрос на изменение'
);


ALTER TYPE public.error_criticality OWNER TO postgres;

--
-- TOC entry 848 (class 1247 OID 16411)
-- Name: error_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.error_status AS ENUM (
    'New',
    'Open',
    'Resolved',
    'Verified',
    'Closed'
);


ALTER TYPE public.error_status OWNER TO postgres;

--
-- TOC entry 851 (class 1247 OID 16422)
-- Name: error_urgency; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.error_urgency AS ENUM (
    'Очень срочно',
    'Срочно',
    'Не срочно',
    'Совсем не срочно'
);


ALTER TYPE public.error_urgency OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 16472)
-- Name: error_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.error_history (
    history_id integer NOT NULL,
    error_id integer NOT NULL,
    action_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    action public.error_action NOT NULL,
    comment text NOT NULL,
    actioned_by integer NOT NULL
);


ALTER TABLE public.error_history OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16471)
-- Name: error_history_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.error_history_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.error_history_history_id_seq OWNER TO postgres;

--
-- TOC entry 4823 (class 0 OID 0)
-- Dependencies: 219
-- Name: error_history_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.error_history_history_id_seq OWNED BY public.error_history.history_id;


--
-- TOC entry 218 (class 1259 OID 16456)
-- Name: errors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.errors (
    error_id integer NOT NULL,
    entry_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    short_description character varying(255) NOT NULL,
    detailed_description text NOT NULL,
    reported_by integer NOT NULL,
    status public.error_status DEFAULT 'New'::public.error_status NOT NULL,
    urgency public.error_urgency NOT NULL,
    criticality public.error_criticality NOT NULL
);


ALTER TABLE public.errors OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16455)
-- Name: errors_error_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.errors_error_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.errors_error_id_seq OWNER TO postgres;

--
-- TOC entry 4824 (class 0 OID 0)
-- Dependencies: 217
-- Name: errors_error_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.errors_error_id_seq OWNED BY public.errors.error_id;


--
-- TOC entry 216 (class 1259 OID 16400)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    account character varying(255) NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16399)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- TOC entry 4825 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 4660 (class 2604 OID 16475)
-- Name: error_history history_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.error_history ALTER COLUMN history_id SET DEFAULT nextval('public.error_history_history_id_seq'::regclass);


--
-- TOC entry 4657 (class 2604 OID 16459)
-- Name: errors error_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.errors ALTER COLUMN error_id SET DEFAULT nextval('public.errors_error_id_seq'::regclass);


--
-- TOC entry 4656 (class 2604 OID 16403)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 4663 (class 2606 OID 16499)
-- Name: users account_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT account_unique UNIQUE (account);


--
-- TOC entry 4671 (class 2606 OID 16480)
-- Name: error_history error_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.error_history
    ADD CONSTRAINT error_history_pkey PRIMARY KEY (history_id);


--
-- TOC entry 4669 (class 2606 OID 16465)
-- Name: errors errors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.errors
    ADD CONSTRAINT errors_pkey PRIMARY KEY (error_id);


--
-- TOC entry 4665 (class 2606 OID 16409)
-- Name: users users_account_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_account_key UNIQUE (account);


--
-- TOC entry 4667 (class 2606 OID 16407)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4673 (class 2606 OID 16486)
-- Name: error_history error_history_actioned_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.error_history
    ADD CONSTRAINT error_history_actioned_by_fkey FOREIGN KEY (actioned_by) REFERENCES public.users(user_id);


--
-- TOC entry 4674 (class 2606 OID 16481)
-- Name: error_history error_history_error_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.error_history
    ADD CONSTRAINT error_history_error_id_fkey FOREIGN KEY (error_id) REFERENCES public.errors(error_id);


--
-- TOC entry 4672 (class 2606 OID 16466)
-- Name: errors errors_reported_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.errors
    ADD CONSTRAINT errors_reported_by_fkey FOREIGN KEY (reported_by) REFERENCES public.users(user_id);


-- Completed on 2024-03-31 23:31:05

--
-- PostgreSQL database dump complete
--

