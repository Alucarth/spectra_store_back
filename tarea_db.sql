--
-- PostgreSQL database dump
--

-- Dumped from database version 13.11 (Debian 13.11-0+deb11u1)
-- Dumped by pg_dump version 13.11 (Debian 13.11-0+deb11u1)

-- Started on 2023-05-27 21:36:51 -04

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
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3053 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 213 (class 1255 OID 16463)
-- Name: func_compras_cliente(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.func_compras_cliente(_cliente_id integer) RETURNS TABLE(id integer, total numeric, fecha timestamp without time zone)
    LANGUAGE plpgsql
    AS $$

BEGIN
   RETURN QUERY
   select v.id, v.total, v.fecha from venta v
   inner join cliente c on c.id=v.cliente_id
   where c.id=_cliente_id;
END;
$$;


ALTER FUNCTION public.func_compras_cliente(_cliente_id integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 204 (class 1259 OID 16412)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    telefono integer DEFAULT 0 NOT NULL,
    email character varying(20)
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16410)
-- Name: cliente_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cliente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cliente_id_seq OWNER TO postgres;

--
-- TOC entry 3054 (class 0 OID 0)
-- Dependencies: 203
-- Name: cliente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cliente_id_seq OWNED BY public.cliente.id;


--
-- TOC entry 202 (class 1259 OID 16402)
-- Name: producto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.producto (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    precio numeric(10,2) DEFAULT 0 NOT NULL,
    cantidad integer DEFAULT 0 NOT NULL,
    categoria character varying(20)
);


ALTER TABLE public.producto OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 16400)
-- Name: producto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.producto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.producto_id_seq OWNER TO postgres;

--
-- TOC entry 3055 (class 0 OID 0)
-- Dependencies: 201
-- Name: producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.producto_id_seq OWNED BY public.producto.id;


--
-- TOC entry 210 (class 1259 OID 16454)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    usuario character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    rol character varying(255) NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16452)
-- Name: usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuario_id_seq OWNER TO postgres;

--
-- TOC entry 3056 (class 0 OID 0)
-- Dependencies: 209
-- Name: usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.id;


--
-- TOC entry 206 (class 1259 OID 16421)
-- Name: venta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venta (
    id integer NOT NULL,
    cliente_id integer NOT NULL,
    total numeric(10,2) DEFAULT 0 NOT NULL,
    fecha timestamp without time zone
);


ALTER TABLE public.venta OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16435)
-- Name: venta_detalle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venta_detalle (
    id integer NOT NULL,
    producto_id integer NOT NULL,
    venta_id integer NOT NULL,
    precio numeric(10,2) DEFAULT 0 NOT NULL
);


ALTER TABLE public.venta_detalle OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16433)
-- Name: venta_detalle_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.venta_detalle_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.venta_detalle_id_seq OWNER TO postgres;

--
-- TOC entry 3057 (class 0 OID 0)
-- Dependencies: 207
-- Name: venta_detalle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.venta_detalle_id_seq OWNED BY public.venta_detalle.id;


--
-- TOC entry 205 (class 1259 OID 16419)
-- Name: venta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.venta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.venta_id_seq OWNER TO postgres;

--
-- TOC entry 3058 (class 0 OID 0)
-- Dependencies: 205
-- Name: venta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.venta_id_seq OWNED BY public.venta.id;


--
-- TOC entry 2888 (class 2604 OID 16415)
-- Name: cliente id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente ALTER COLUMN id SET DEFAULT nextval('public.cliente_id_seq'::regclass);


--
-- TOC entry 2885 (class 2604 OID 16405)
-- Name: producto id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto ALTER COLUMN id SET DEFAULT nextval('public.producto_id_seq'::regclass);


--
-- TOC entry 2894 (class 2604 OID 16457)
-- Name: usuario id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id SET DEFAULT nextval('public.usuario_id_seq'::regclass);


--
-- TOC entry 2890 (class 2604 OID 16424)
-- Name: venta id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta ALTER COLUMN id SET DEFAULT nextval('public.venta_id_seq'::regclass);


--
-- TOC entry 2892 (class 2604 OID 16438)
-- Name: venta_detalle id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta_detalle ALTER COLUMN id SET DEFAULT nextval('public.venta_detalle_id_seq'::regclass);


--
-- TOC entry 3041 (class 0 OID 16412)
-- Dependencies: 204
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente (id, nombre, telefono, email) FROM stdin;
2	pepito de los palotes	1234589	a@a.com
1	pepito de los xd	11111	b@a.com
3	Cliente Nuevo	123456	c@c.com
\.


--
-- TOC entry 3039 (class 0 OID 16402)
-- Dependencies: 202
-- Data for Name: producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.producto (id, nombre, precio, cantidad, categoria) FROM stdin;
2	azucar	20.00	50	comida
3	pan	1.00	30	comida
1	galletas	15.00	23	comida
\.


--
-- TOC entry 3047 (class 0 OID 16454)
-- Dependencies: 210
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (id, nombre, usuario, password, email, rol) FROM stdin;
\.


--
-- TOC entry 3043 (class 0 OID 16421)
-- Dependencies: 206
-- Data for Name: venta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.venta (id, cliente_id, total, fecha) FROM stdin;
1	3	150.00	2023-05-28 00:10:55.756
2	3	150.00	2023-05-28 00:23:44.618
3	3	150.00	2023-05-28 00:32:52.779
4	3	150.00	2023-05-28 00:35:15.396
5	3	150.00	2023-05-28 00:38:28.907
6	3	150.00	2023-05-28 00:40:29.272
7	3	150.00	2023-05-28 00:46:49.528
8	3	150.00	2023-05-28 00:47:29.939
\.


--
-- TOC entry 3045 (class 0 OID 16435)
-- Dependencies: 208
-- Data for Name: venta_detalle; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.venta_detalle (id, producto_id, venta_id, precio) FROM stdin;
1	1	2	30.00
2	3	2	1.00
3	1	3	30.00
4	3	3	1.00
5	1	4	30.00
6	3	4	1.00
7	1	5	30.00
8	3	5	1.00
9	1	6	45.00
10	3	6	4.00
11	1	7	45.00
12	3	7	4.00
13	1	8	45.00
14	3	8	60.00
\.


--
-- TOC entry 3059 (class 0 OID 0)
-- Dependencies: 203
-- Name: cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cliente_id_seq', 3, true);


--
-- TOC entry 3060 (class 0 OID 0)
-- Dependencies: 201
-- Name: producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.producto_id_seq', 3, true);


--
-- TOC entry 3061 (class 0 OID 0)
-- Dependencies: 209
-- Name: usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_id_seq', 1, false);


--
-- TOC entry 3062 (class 0 OID 0)
-- Dependencies: 207
-- Name: venta_detalle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.venta_detalle_id_seq', 17, true);


--
-- TOC entry 3063 (class 0 OID 0)
-- Dependencies: 205
-- Name: venta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.venta_id_seq', 10, true);


--
-- TOC entry 2898 (class 2606 OID 16418)
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 2896 (class 2606 OID 16409)
-- Name: producto producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (id);


--
-- TOC entry 2904 (class 2606 OID 16462)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 2902 (class 2606 OID 16441)
-- Name: venta_detalle venta_detalle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta_detalle
    ADD CONSTRAINT venta_detalle_pkey PRIMARY KEY (id);


--
-- TOC entry 2900 (class 2606 OID 16427)
-- Name: venta venta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_pkey PRIMARY KEY (id);


--
-- TOC entry 2905 (class 2606 OID 16428)
-- Name: venta fk_venta_cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT fk_venta_cliente FOREIGN KEY (cliente_id) REFERENCES public.cliente(id);


--
-- TOC entry 2906 (class 2606 OID 16442)
-- Name: venta_detalle fk_venta_detalle_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta_detalle
    ADD CONSTRAINT fk_venta_detalle_producto FOREIGN KEY (producto_id) REFERENCES public.producto(id);


--
-- TOC entry 2907 (class 2606 OID 16447)
-- Name: venta_detalle fk_venta_detalle_venta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta_detalle
    ADD CONSTRAINT fk_venta_detalle_venta FOREIGN KEY (venta_id) REFERENCES public.venta(id);


-- Completed on 2023-05-27 21:36:52 -04

--
-- PostgreSQL database dump complete
--

