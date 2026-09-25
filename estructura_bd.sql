--
-- PostgreSQL database dump
--

\restrict 1jBapFGkPBwOespdtOkmgXs0MRO49Fg5aNErYY78C9UIXcQSWlVBwj5dFivA5gv

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-09-25 12:15:46

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

--
-- TOC entry 6 (class 2615 OID 16385)
-- Name: auth; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO postgres;

--
-- TOC entry 8 (class 2615 OID 16387)
-- Name: catalogo; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA catalogo;


ALTER SCHEMA catalogo OWNER TO postgres;

--
-- TOC entry 7 (class 2615 OID 16386)
-- Name: transacciones; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA transacciones;


ALTER SCHEMA transacciones OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 223 (class 1259 OID 16489)
-- Name: tipos_documento; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE auth.tipos_documento (
    id_tipo_documento integer NOT NULL,
    codigo character varying(5) NOT NULL,
    descripcion character varying(50) NOT NULL
);


ALTER TABLE auth.tipos_documento OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16488)
-- Name: tipos_documento_id_tipo_documento_seq; Type: SEQUENCE; Schema: auth; Owner: postgres
--

CREATE SEQUENCE auth.tipos_documento_id_tipo_documento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.tipos_documento_id_tipo_documento_seq OWNER TO postgres;

--
-- TOC entry 5052 (class 0 OID 0)
-- Dependencies: 222
-- Name: tipos_documento_id_tipo_documento_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: postgres
--

ALTER SEQUENCE auth.tipos_documento_id_tipo_documento_seq OWNED BY auth.tipos_documento.id_tipo_documento;


--
-- TOC entry 225 (class 1259 OID 16501)
-- Name: usuarios; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE auth.usuarios (
    id_usuario integer NOT NULL,
    id_tipo_documento integer NOT NULL,
    numero_documento character varying(20) NOT NULL,
    primer_nombre character varying(100) NOT NULL,
    segundo_nombre character varying(100),
    primer_apellido character varying(100) NOT NULL,
    segundo_apellido character varying(100),
    email character varying(150) NOT NULL,
    password text NOT NULL,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE auth.usuarios OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16500)
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE; Schema: auth; Owner: postgres
--

CREATE SEQUENCE auth.usuarios_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.usuarios_id_usuario_seq OWNER TO postgres;

--
-- TOC entry 5053 (class 0 OID 0)
-- Dependencies: 224
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: postgres
--

ALTER SEQUENCE auth.usuarios_id_usuario_seq OWNED BY auth.usuarios.id_usuario;


--
-- TOC entry 227 (class 1259 OID 16527)
-- Name: medicamentos; Type: TABLE; Schema: catalogo; Owner: postgres
--

CREATE TABLE catalogo.medicamentos (
    id_medicamento integer NOT NULL,
    nombre character varying(100) NOT NULL,
    presentacion character varying(100) NOT NULL,
    es_pos boolean DEFAULT true NOT NULL
);


ALTER TABLE catalogo.medicamentos OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16526)
-- Name: medicamentos_id_medicamento_seq; Type: SEQUENCE; Schema: catalogo; Owner: postgres
--

CREATE SEQUENCE catalogo.medicamentos_id_medicamento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE catalogo.medicamentos_id_medicamento_seq OWNER TO postgres;

--
-- TOC entry 5054 (class 0 OID 0)
-- Dependencies: 226
-- Name: medicamentos_id_medicamento_seq; Type: SEQUENCE OWNED BY; Schema: catalogo; Owner: postgres
--

ALTER SEQUENCE catalogo.medicamentos_id_medicamento_seq OWNED BY catalogo.medicamentos.id_medicamento;


--
-- TOC entry 229 (class 1259 OID 16539)
-- Name: solicitudes; Type: TABLE; Schema: transacciones; Owner: postgres
--

CREATE TABLE transacciones.solicitudes (
    id_solicitud integer NOT NULL,
    id_usuario integer NOT NULL,
    id_medicamento integer NOT NULL,
    cantidad integer DEFAULT 1 NOT NULL,
    estado character varying(20) DEFAULT 'Pendiente'::character varying,
    fecha_solicitud timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    numero_orden character varying(50),
    direccion character varying(200),
    telefono character varying(20),
    correo_electronico character varying(150)
);


ALTER TABLE transacciones.solicitudes OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16538)
-- Name: solicitudes_id_solicitud_seq; Type: SEQUENCE; Schema: transacciones; Owner: postgres
--

CREATE SEQUENCE transacciones.solicitudes_id_solicitud_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE transacciones.solicitudes_id_solicitud_seq OWNER TO postgres;

--
-- TOC entry 5055 (class 0 OID 0)
-- Dependencies: 228
-- Name: solicitudes_id_solicitud_seq; Type: SEQUENCE OWNED BY; Schema: transacciones; Owner: postgres
--

ALTER SEQUENCE transacciones.solicitudes_id_solicitud_seq OWNED BY transacciones.solicitudes.id_solicitud;


--
-- TOC entry 4874 (class 2604 OID 16492)
-- Name: tipos_documento id_tipo_documento; Type: DEFAULT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.tipos_documento ALTER COLUMN id_tipo_documento SET DEFAULT nextval('auth.tipos_documento_id_tipo_documento_seq'::regclass);


--
-- TOC entry 4875 (class 2604 OID 16504)
-- Name: usuarios id_usuario; Type: DEFAULT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('auth.usuarios_id_usuario_seq'::regclass);


--
-- TOC entry 4877 (class 2604 OID 16530)
-- Name: medicamentos id_medicamento; Type: DEFAULT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.medicamentos ALTER COLUMN id_medicamento SET DEFAULT nextval('catalogo.medicamentos_id_medicamento_seq'::regclass);


--
-- TOC entry 4879 (class 2604 OID 16542)
-- Name: solicitudes id_solicitud; Type: DEFAULT; Schema: transacciones; Owner: postgres
--

ALTER TABLE ONLY transacciones.solicitudes ALTER COLUMN id_solicitud SET DEFAULT nextval('transacciones.solicitudes_id_solicitud_seq'::regclass);


--
-- TOC entry 4884 (class 2606 OID 16499)
-- Name: tipos_documento tipos_documento_codigo_key; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.tipos_documento
    ADD CONSTRAINT tipos_documento_codigo_key UNIQUE (codigo);


--
-- TOC entry 4886 (class 2606 OID 16497)
-- Name: tipos_documento tipos_documento_pkey; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.tipos_documento
    ADD CONSTRAINT tipos_documento_pkey PRIMARY KEY (id_tipo_documento);


--
-- TOC entry 4888 (class 2606 OID 16520)
-- Name: usuarios uq_documento_usuario; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.usuarios
    ADD CONSTRAINT uq_documento_usuario UNIQUE (id_tipo_documento, numero_documento);


--
-- TOC entry 4890 (class 2606 OID 16518)
-- Name: usuarios usuarios_email_key; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (email);


--
-- TOC entry 4892 (class 2606 OID 16516)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 4894 (class 2606 OID 16537)
-- Name: medicamentos medicamentos_pkey; Type: CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.medicamentos
    ADD CONSTRAINT medicamentos_pkey PRIMARY KEY (id_medicamento);


--
-- TOC entry 4896 (class 2606 OID 16551)
-- Name: solicitudes solicitudes_pkey; Type: CONSTRAINT; Schema: transacciones; Owner: postgres
--

ALTER TABLE ONLY transacciones.solicitudes
    ADD CONSTRAINT solicitudes_pkey PRIMARY KEY (id_solicitud);


--
-- TOC entry 4897 (class 2606 OID 16521)
-- Name: usuarios fk_usuario_tipo_documento; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.usuarios
    ADD CONSTRAINT fk_usuario_tipo_documento FOREIGN KEY (id_tipo_documento) REFERENCES auth.tipos_documento(id_tipo_documento);


--
-- TOC entry 4898 (class 2606 OID 16557)
-- Name: solicitudes fk_solicitud_medicamento; Type: FK CONSTRAINT; Schema: transacciones; Owner: postgres
--

ALTER TABLE ONLY transacciones.solicitudes
    ADD CONSTRAINT fk_solicitud_medicamento FOREIGN KEY (id_medicamento) REFERENCES catalogo.medicamentos(id_medicamento);


--
-- TOC entry 4899 (class 2606 OID 16552)
-- Name: solicitudes fk_solicitud_usuario; Type: FK CONSTRAINT; Schema: transacciones; Owner: postgres
--

ALTER TABLE ONLY transacciones.solicitudes
    ADD CONSTRAINT fk_solicitud_usuario FOREIGN KEY (id_usuario) REFERENCES auth.usuarios(id_usuario);


-- Completed on 2026-09-25 12:15:46

--
-- PostgreSQL database dump complete
--

\unrestrict 1jBapFGkPBwOespdtOkmgXs0MRO49Fg5aNErYY78C9UIXcQSWlVBwj5dFivA5gv

