--
-- PostgreSQL database dump
--

\restrict F5CpZdjqYtL9iaHHqI2MG2SuEKumvNDq9p8dNe5GiJgcoOnxg1v6Juq7EfZDugV

-- Dumped from database version 17.7
-- Dumped by pg_dump version 17.7

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP INDEX IF EXISTS public.ix_users_email;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS public.users ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.users_id_seq;
DROP TABLE IF EXISTS public.users;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: users; Type: TABLE; Schema: public; Owner: vscode
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(120) NOT NULL,
    password_hash character varying(255) NOT NULL,
    is_verified boolean NOT NULL,
    created_at timestamp without time zone NOT NULL,
    verified_at timestamp without time zone
);


ALTER TABLE public.users OWNER TO vscode;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: vscode
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO vscode;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vscode
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: vscode
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: vscode
--

COPY public.users (id, email, password_hash, is_verified, created_at, verified_at) FROM stdin;
2	ciscostudent561@yahoo.com	pbkdf2:sha256:1000000$6876tEs6AvMTpVBe$37c527b84df0a9f12d8a105371aa996e44808620ba50390f5bf4746b693dd6a4	t	2025-12-26 16:00:22.59779	2025-12-26 16:04:42.243935
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vscode
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: vscode
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: ix_users_email; Type: INDEX; Schema: public; Owner: vscode
--

CREATE UNIQUE INDEX ix_users_email ON public.users USING btree (email);


--
-- PostgreSQL database dump complete
--

\unrestrict F5CpZdjqYtL9iaHHqI2MG2SuEKumvNDq9p8dNe5GiJgcoOnxg1v6Juq7EfZDugV

