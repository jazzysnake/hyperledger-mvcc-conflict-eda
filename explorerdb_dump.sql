--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4
-- Dumped by pg_dump version 10.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP INDEX public.transactions_txhash_idx;
DROP INDEX public.transactions_md5_idx;
DROP INDEX public.transactions_createdt_idx;
DROP INDEX public.transactions_channel_genesis_hash_idx;
DROP INDEX public.transactions_blockid_idx;
DROP INDEX public.channel_channel_hash_idx;
DROP INDEX public.channel_channel_genesis_hash_idx;
DROP INDEX public.blocks_createdt_idx;
DROP INDEX public.blocks_channel_genesis_hash_idx;
DROP INDEX public.blocks_blocknum_idx;
ALTER TABLE ONLY public.write_lock DROP CONSTRAINT write_lock_pkey;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_pkey;
ALTER TABLE ONLY public.peer_ref_channel DROP CONSTRAINT peer_ref_channel_pkey;
ALTER TABLE ONLY public.peer_ref_chaincode DROP CONSTRAINT peer_ref_chaincode_pkey;
ALTER TABLE ONLY public.peer DROP CONSTRAINT peer_pkey;
ALTER TABLE ONLY public.orderer DROP CONSTRAINT orderer_pkey;
ALTER TABLE ONLY public.channel DROP CONSTRAINT channel_pkey;
ALTER TABLE ONLY public.chaincodes DROP CONSTRAINT chaincodes_pkey;
ALTER TABLE ONLY public.blocks DROP CONSTRAINT blocks_pkey;
ALTER TABLE public.write_lock ALTER COLUMN write_lock DROP DEFAULT;
ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.transactions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.peer_ref_channel ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.peer_ref_chaincode ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.peer ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.orderer ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.channel ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.chaincodes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.blocks ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.write_lock_write_lock_seq;
DROP TABLE public.write_lock;
DROP SEQUENCE public.users_id_seq;
DROP TABLE public.users;
DROP SEQUENCE public.transactions_id_seq;
DROP TABLE public.transactions;
DROP SEQUENCE public.peer_ref_channel_id_seq;
DROP TABLE public.peer_ref_channel;
DROP SEQUENCE public.peer_ref_chaincode_id_seq;
DROP TABLE public.peer_ref_chaincode;
DROP SEQUENCE public.peer_id_seq;
DROP TABLE public.peer;
DROP SEQUENCE public.orderer_id_seq;
DROP TABLE public.orderer;
DROP SEQUENCE public.channel_id_seq;
DROP TABLE public.channel;
DROP SEQUENCE public.chaincodes_id_seq;
DROP TABLE public.chaincodes;
DROP SEQUENCE public.blocks_id_seq;
DROP TABLE public.blocks;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: blocks; Type: TABLE; Schema: public; Owner: hppoc
--

CREATE TABLE public.blocks (
    id integer NOT NULL,
    blocknum integer,
    datahash character varying(256) DEFAULT NULL::character varying,
    prehash character varying(256) DEFAULT NULL::character varying,
    txcount integer,
    createdt timestamp without time zone,
    prev_blockhash character varying(256) DEFAULT NULL::character varying,
    blockhash character varying(256) DEFAULT NULL::character varying,
    channel_genesis_hash character varying(256) DEFAULT NULL::character varying,
    blksize integer,
    network_name character varying(255)
);


ALTER TABLE public.blocks OWNER TO hppoc;

--
-- Name: blocks_id_seq; Type: SEQUENCE; Schema: public; Owner: hppoc
--

CREATE SEQUENCE public.blocks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blocks_id_seq OWNER TO hppoc;

--
-- Name: blocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hppoc
--

ALTER SEQUENCE public.blocks_id_seq OWNED BY public.blocks.id;


--
-- Name: chaincodes; Type: TABLE; Schema: public; Owner: hppoc
--

CREATE TABLE public.chaincodes (
    id integer NOT NULL,
    name character varying(255) DEFAULT NULL::character varying,
    version character varying(255) DEFAULT NULL::character varying,
    path character varying(255) DEFAULT NULL::character varying,
    channel_genesis_hash character varying(256) DEFAULT NULL::character varying,
    txcount integer DEFAULT 0,
    createdt timestamp without time zone,
    network_name character varying(255)
);


ALTER TABLE public.chaincodes OWNER TO hppoc;

--
-- Name: chaincodes_id_seq; Type: SEQUENCE; Schema: public; Owner: hppoc
--

CREATE SEQUENCE public.chaincodes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chaincodes_id_seq OWNER TO hppoc;

--
-- Name: chaincodes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hppoc
--

ALTER SEQUENCE public.chaincodes_id_seq OWNED BY public.chaincodes.id;


--
-- Name: channel; Type: TABLE; Schema: public; Owner: hppoc
--

CREATE TABLE public.channel (
    id integer NOT NULL,
    name character varying(256) DEFAULT NULL::character varying,
    blocks integer,
    trans integer,
    createdt timestamp without time zone,
    channel_genesis_hash character varying(256) DEFAULT NULL::character varying,
    channel_hash character varying(256) DEFAULT NULL::character varying,
    channel_config bytea,
    channel_block bytea,
    channel_tx bytea,
    channel_version character varying(256) DEFAULT NULL::character varying,
    network_name character varying(255)
);


ALTER TABLE public.channel OWNER TO hppoc;

--
-- Name: channel_id_seq; Type: SEQUENCE; Schema: public; Owner: hppoc
--

CREATE SEQUENCE public.channel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.channel_id_seq OWNER TO hppoc;

--
-- Name: channel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hppoc
--

ALTER SEQUENCE public.channel_id_seq OWNED BY public.channel.id;


--
-- Name: orderer; Type: TABLE; Schema: public; Owner: hppoc
--

CREATE TABLE public.orderer (
    id integer NOT NULL,
    requests character varying(256) DEFAULT NULL::character varying,
    server_hostname character varying(256) DEFAULT NULL::character varying,
    createdt timestamp without time zone,
    network_name character varying(255)
);


ALTER TABLE public.orderer OWNER TO hppoc;

--
-- Name: orderer_id_seq; Type: SEQUENCE; Schema: public; Owner: hppoc
--

CREATE SEQUENCE public.orderer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orderer_id_seq OWNER TO hppoc;

--
-- Name: orderer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hppoc
--

ALTER SEQUENCE public.orderer_id_seq OWNED BY public.orderer.id;


--
-- Name: peer; Type: TABLE; Schema: public; Owner: hppoc
--

CREATE TABLE public.peer (
    id integer NOT NULL,
    org integer,
    channel_genesis_hash character varying(256) DEFAULT NULL::character varying,
    mspid character varying(256) DEFAULT NULL::character varying,
    requests character varying(256) DEFAULT NULL::character varying,
    events character varying(256) DEFAULT NULL::character varying,
    server_hostname character varying(256) DEFAULT NULL::character varying,
    createdt timestamp without time zone,
    peer_type character varying(256) DEFAULT NULL::character varying,
    network_name character varying(255)
);


ALTER TABLE public.peer OWNER TO hppoc;

--
-- Name: peer_id_seq; Type: SEQUENCE; Schema: public; Owner: hppoc
--

CREATE SEQUENCE public.peer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.peer_id_seq OWNER TO hppoc;

--
-- Name: peer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hppoc
--

ALTER SEQUENCE public.peer_id_seq OWNED BY public.peer.id;


--
-- Name: peer_ref_chaincode; Type: TABLE; Schema: public; Owner: hppoc
--

CREATE TABLE public.peer_ref_chaincode (
    id integer NOT NULL,
    peerid character varying(256) DEFAULT NULL::character varying,
    chaincodeid character varying(255) DEFAULT NULL::character varying,
    cc_version character varying(255) DEFAULT NULL::character varying,
    channelid character varying(256) DEFAULT NULL::character varying,
    createdt timestamp without time zone,
    network_name character varying(255)
);


ALTER TABLE public.peer_ref_chaincode OWNER TO hppoc;

--
-- Name: peer_ref_chaincode_id_seq; Type: SEQUENCE; Schema: public; Owner: hppoc
--

CREATE SEQUENCE public.peer_ref_chaincode_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.peer_ref_chaincode_id_seq OWNER TO hppoc;

--
-- Name: peer_ref_chaincode_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hppoc
--

ALTER SEQUENCE public.peer_ref_chaincode_id_seq OWNED BY public.peer_ref_chaincode.id;


--
-- Name: peer_ref_channel; Type: TABLE; Schema: public; Owner: hppoc
--

CREATE TABLE public.peer_ref_channel (
    id integer NOT NULL,
    createdt timestamp without time zone,
    peerid character varying(256),
    channelid character varying(256),
    peer_type character varying(256) DEFAULT NULL::character varying,
    network_name character varying(255)
);


ALTER TABLE public.peer_ref_channel OWNER TO hppoc;

--
-- Name: peer_ref_channel_id_seq; Type: SEQUENCE; Schema: public; Owner: hppoc
--

CREATE SEQUENCE public.peer_ref_channel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.peer_ref_channel_id_seq OWNER TO hppoc;

--
-- Name: peer_ref_channel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hppoc
--

ALTER SEQUENCE public.peer_ref_channel_id_seq OWNED BY public.peer_ref_channel.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: hppoc
--

CREATE TABLE public.transactions (
    id integer NOT NULL,
    blockid integer,
    txhash character varying(256) DEFAULT NULL::character varying,
    createdt timestamp without time zone,
    chaincodename character varying(255) DEFAULT NULL::character varying,
    status integer,
    creator_msp_id character varying(256) DEFAULT NULL::character varying,
    endorser_msp_id character varying(800) DEFAULT NULL::character varying,
    chaincode_id character varying(256) DEFAULT NULL::character varying,
    type character varying(256) DEFAULT NULL::character varying,
    read_set json,
    write_set json,
    channel_genesis_hash character varying(256) DEFAULT NULL::character varying,
    validation_code character varying(255) DEFAULT NULL::character varying,
    envelope_signature character varying,
    payload_extension character varying,
    creator_id_bytes character varying,
    creator_nonce character varying,
    chaincode_proposal_input character varying,
    tx_response character varying,
    payload_proposal_hash character varying,
    endorser_id_bytes character varying,
    endorser_signature character varying,
    network_name character varying(255)
);


ALTER TABLE public.transactions OWNER TO hppoc;

--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: hppoc
--

CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transactions_id_seq OWNER TO hppoc;

--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hppoc
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: hppoc
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    email character varying(255),
    "networkName" character varying(255) NOT NULL,
    "firstName" character varying(255),
    "lastName" character varying(255),
    password character varying(255),
    roles character varying(255),
    salt character varying(255),
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO hppoc;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: hppoc
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO hppoc;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hppoc
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: write_lock; Type: TABLE; Schema: public; Owner: hppoc
--

CREATE TABLE public.write_lock (
    write_lock integer NOT NULL
);


ALTER TABLE public.write_lock OWNER TO hppoc;

--
-- Name: write_lock_write_lock_seq; Type: SEQUENCE; Schema: public; Owner: hppoc
--

CREATE SEQUENCE public.write_lock_write_lock_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.write_lock_write_lock_seq OWNER TO hppoc;

--
-- Name: write_lock_write_lock_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hppoc
--

ALTER SEQUENCE public.write_lock_write_lock_seq OWNED BY public.write_lock.write_lock;


--
-- Name: blocks id; Type: DEFAULT; Schema: public; Owner: hppoc
--

ALTER TABLE ONLY public.blocks ALTER COLUMN id SET DEFAULT nextval('public.blocks_id_seq'::regclass);


--
-- Name: chaincodes id; Type: DEFAULT; Schema: public; Owner: hppoc
--

ALTER TABLE ONLY public.chaincodes ALTER COLUMN id SET DEFAULT nextval('public.chaincodes_id_seq'::regclass);


--
-- Name: channel id; Type: DEFAULT; Schema: public; Owner: hppoc
--

ALTER TABLE ONLY public.channel ALTER COLUMN id SET DEFAULT nextval('public.channel_id_seq'::regclass);


--
-- Name: orderer id; Type: DEFAULT; Schema: public; Owner: hppoc
--

ALTER TABLE ONLY public.orderer ALTER COLUMN id SET DEFAULT nextval('public.orderer_id_seq'::regclass);


--
-- Name: peer id; Type: DEFAULT; Schema: public; Owner: hppoc
--

ALTER TABLE ONLY public.peer ALTER COLUMN id SET DEFAULT nextval('public.peer_id_seq'::regclass);


--
-- Name: peer_ref_chaincode id; Type: DEFAULT; Schema: public; Owner: hppoc
--

ALTER TABLE ONLY public.peer_ref_chaincode ALTER COLUMN id SET DEFAULT nextval('public.peer_ref_chaincode_id_seq'::regclass);


--
-- Name: peer_ref_channel id; Type: DEFAULT; Schema: public; Owner: hppoc
--

ALTER TABLE ONLY public.peer_ref_channel ALTER COLUMN id SET DEFAULT nextval('public.peer_ref_channel_id_seq'::regclass);


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: hppoc
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: hppoc
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: write_lock write_lock; Type: DEFAULT; Schema: public; Owner: hppoc
--

ALTER TABLE ONLY public.write_lock ALTER COLUMN write_lock SET DEFAULT nextval('public.write_lock_write_lock_seq'::regclass);


--
-- Data for Name: blocks; Type: TABLE DATA; Schema: public; Owner: hppoc
--

COPY public.blocks (id, blocknum, datahash, prehash, txcount, createdt, prev_blockhash, blockhash, channel_genesis_hash, blksize, network_name) FROM stdin;
1	3	a4195550c32c9d5767a5bf80fe13b3a4f8b8c7979c4c13f4fe61d109f1288c1f	dc23aeef4c6f7d53ef75d35b9093573dd4aa9c08b4fdd5a4376b14518459ff12	1	2022-03-08 20:29:03.611		cc0ad539f2ed78474ba91c1a7f9bd4458b3098b221ff1d1e8d9ea94638bb5e24	d93141c41b382f12265e2f1be68f46dd6f99cf7129ac495fe4134d66b2c3115d	4	fabric
2	0	8f54ef476c58b4b6c70e3f4c528a6f1b6b1e9adafd41e1c8928cc1427117820a		1	2022-03-08 20:28:55		d93141c41b382f12265e2f1be68f46dd6f99cf7129ac495fe4134d66b2c3115d	d93141c41b382f12265e2f1be68f46dd6f99cf7129ac495fe4134d66b2c3115d	12	fabric
3	1	99344f6a719b7f891e82f8f503f04f94e4e4e8be902487cdc5e5c3a38d383595	d93141c41b382f12265e2f1be68f46dd6f99cf7129ac495fe4134d66b2c3115d	1	2022-03-08 20:29:02		9d5ca33ea1f7e4a1d7f425ebad06a7a01b3be15e668053de801f4c2d29bd3c8b	d93141c41b382f12265e2f1be68f46dd6f99cf7129ac495fe4134d66b2c3115d	13	fabric
4	2	e22eeea809e6477e15fdac082044e826dc2895e31be4e6a06bcea4457766d1fa	9d5ca33ea1f7e4a1d7f425ebad06a7a01b3be15e668053de801f4c2d29bd3c8b	1	2022-03-08 20:29:02		dc23aeef4c6f7d53ef75d35b9093573dd4aa9c08b4fdd5a4376b14518459ff12	d93141c41b382f12265e2f1be68f46dd6f99cf7129ac495fe4134d66b2c3115d	13	fabric
\.


--
-- Data for Name: chaincodes; Type: TABLE DATA; Schema: public; Owner: hppoc
--

COPY public.chaincodes (id, name, version, path, channel_genesis_hash, txcount, createdt, network_name) FROM stdin;
10	cbdc	1.0.0	/opt/contracts/cbdc	d93141c41b382f12265e2f1be68f46dd6f99cf7129ac495fe4134d66b2c3115d	0	2022-03-08 20:31:29.622	fabric
\.


--
-- Data for Name: channel; Type: TABLE DATA; Schema: public; Owner: hppoc
--

COPY public.channel (id, name, blocks, trans, createdt, channel_genesis_hash, channel_hash, channel_config, channel_block, channel_tx, channel_version, network_name) FROM stdin;
3	epengo-channel	4	4	2022-03-08 20:28:55	d93141c41b382f12265e2f1be68f46dd6f99cf7129ac495fe4134d66b2c3115d		\N	\N	\N	\N	fabric
\.


--
-- Data for Name: orderer; Type: TABLE DATA; Schema: public; Owner: hppoc
--

COPY public.orderer (id, requests, server_hostname, createdt, network_name) FROM stdin;
\.


--
-- Data for Name: peer; Type: TABLE DATA; Schema: public; Owner: hppoc
--

COPY public.peer (id, org, channel_genesis_hash, mspid, requests, events, server_hostname, createdt, peer_type, network_name) FROM stdin;
1	\N	d93141c41b382f12265e2f1be68f46dd6f99cf7129ac495fe4134d66b2c3115d	FIOrgMSP	peer0fi:7051	\N	peer0fi:7051	\N	PEER	fabric
2	\N	d93141c41b382f12265e2f1be68f46dd6f99cf7129ac495fe4134d66b2c3115d	CentralBankOrgMSP	peer0cb:7051	\N	peer0cb:7051	\N	PEER	fabric
3	\N	d93141c41b382f12265e2f1be68f46dd6f99cf7129ac495fe4134d66b2c3115d	OrdererMSP	orderer0:7050	\N	orderer0:7050	\N	ORDERER	fabric
\.


--
-- Data for Name: peer_ref_chaincode; Type: TABLE DATA; Schema: public; Owner: hppoc
--

COPY public.peer_ref_chaincode (id, peerid, chaincodeid, cc_version, channelid, createdt, network_name) FROM stdin;
1	peer0fi:7051	cbdc	1.0.0	d93141c41b382f12265e2f1be68f46dd6f99cf7129ac495fe4134d66b2c3115d	\N	fabric
2	peer0cb:7051	cbdc	1.0.0	d93141c41b382f12265e2f1be68f46dd6f99cf7129ac495fe4134d66b2c3115d	\N	fabric
\.


--
-- Data for Name: peer_ref_channel; Type: TABLE DATA; Schema: public; Owner: hppoc
--

COPY public.peer_ref_channel (id, createdt, peerid, channelid, peer_type, network_name) FROM stdin;
1	\N	peer0fi:7051	d93141c41b382f12265e2f1be68f46dd6f99cf7129ac495fe4134d66b2c3115d	\N	fabric
2	\N	peer0cb:7051	d93141c41b382f12265e2f1be68f46dd6f99cf7129ac495fe4134d66b2c3115d	\N	fabric
3	\N	orderer0	d93141c41b382f12265e2f1be68f46dd6f99cf7129ac495fe4134d66b2c3115d	\N	fabric
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: hppoc
--

COPY public.transactions (id, blockid, txhash, createdt, chaincodename, status, creator_msp_id, endorser_msp_id, chaincode_id, type, read_set, write_set, channel_genesis_hash, validation_code, envelope_signature, payload_extension, creator_id_bytes, creator_nonce, chaincode_proposal_input, tx_response, payload_proposal_hash, endorser_id_bytes, endorser_signature, network_name) FROM stdin;
6	3	4c3ae31d8b4940d46697e74bf05b590818808a7648a9f2d68550e27fa68a2917	2022-03-08 20:29:03.611	lscc	200	CentralBankOrgMSP	{"CentralBankOrgMSP"}		ENDORSER_TRANSACTION	[\n  {\n    "chaincode": "lscc",\n    "set": [\n      {\n        "key": "cbdc"\n      }\n    ]\n  }\n]	[\n  {\n    "chaincode": "lscc",\n    "set": [\n      {\n        "key": "cbdc",\n        "is_delete": false,\n        "value": "\\n\\u0004cbdc\\u0012\\u00051.0.0\\u001a\\u0004escc\\"\\u0004vscc*3\\u0012\\f\\u0012\\n\\b\\u0002\\u0012\\u0002\\b\\u0000\\u0012\\u0002\\b\\u0001\\u001a\\u0015\\u0012\\u0013\\n\\u0011CentralBankOrgMSP\\u001a\\f\\u0012\\n\\n\\bFIOrgMSP2D\\n �2��\\u00199\\n��B��P؝@i�\\u001a���-�\\u000b�#�޻Ӏ\\u0012 ���{\\"\\u001d��8�&vP\\u0011\\bu\\"\\u0015VBv��ߑ>~f���;: 7��~S�.�κ�$sK>k[�\\b�\\t9�T$�uv-��B7\\u0012\\f\\u0012\\n\\b\\u0001\\u0012\\u0002\\b\\u0000\\u0012\\u0002\\b\\u0001\\u001a\\u0017\\u0012\\u0015\\n\\u0011CentralBankOrgMSP\\u0010\\u0001\\u001a\\u000e\\u0012\\f\\n\\bFIOrgMSP\\u0010\\u0001"\n      }\n    ]\n  }\n]	d93141c41b382f12265e2f1be68f46dd6f99cf7129ac495fe4134d66b2c3115d	VALID	304522100253900008700720000909800002300968000901802200581003800620930000130018879100013006700056	1261240736363	-----BEGIN CERTIFICATE-----\nMIIB8DCCAZagAwIBAgIRALfdvshw/+0+P8H4DVqkXy8wCgYIKoZIzj0EAwIwVzEL\nMAkGA1UEBhMCVVMxEzARBgNVBAgTCkNhbGlmb3JuaWExFjAUBgNVBAcTDVNhbiBG\ncmFuY2lzY28xCzAJBgNVBAoTAmNiMQ4wDAYDVQQDEwVjYS5jYjAeFw0yMjAzMDcx\nNDAxMDBaFw0zMjAzMDQxNDAxMDBaME0xCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpD\nYWxpZm9ybmlhMRYwFAYDVQQHEw1TYW4gRnJhbmNpc2NvMREwDwYDVQQDDAhBZG1p\nbkBjYjBZMBMGByqGSM49AgEGCCqGSM49AwEHA0IABPZYyvurduiqZvQkVG9UQ70J\n+mVqqlCVXwNbtfdJDLB5vrG2fVW56HkRBbKxQdHYxT4vG9VL1odvvrxQucTHbuCj\nTTBLMA4GA1UdDwEB/wQEAwIHgDAMBgNVHRMBAf8EAjAAMCsGA1UdIwQkMCKAINjd\n6t5bsN/2ydjmgv+JN2es5XNuUdtT5f7sfQDEnNfmMAoGCCqGSM49BAMCA0gAMEUC\nIQD+53YXZdYEp1+I6DuPvMEex/Zos/wsX3KkiuYPkuhr2QIgaPfejogzK5URJ5Za\n44Of0/v2pduobPEpQW7XJrw6YAs=\n-----END CERTIFICATE-----\n	0746160002200062107100260200270290	6465700079,6570650670063686100650,0138112012463626463053103003000,12012082122801228101512130114365074726104261000726705350001200846490726705350,65736363,76736363	\N	8f3c61777c70fbe269bf7e82bc8fa713342fea518cbadebe05b6ccbd4540b5aa	\N	304522100057550044055000041190007004303400099000002204205509800953808500000370000050650096036260	fabric
7	0	3ea1fb0848d44be9d30fa0c73145508798514220c065ca596c9d5d4a5f61a01b	2022-03-08 20:28:55		\N	OrdererMSP	{}		CONFIG	{\n  "version": 0,\n  "groups": {\n    "Application": {\n      "version": 0,\n      "groups": {\n        "CentralBankOrg": {\n          "version": 0,\n          "groups": {},\n          "values": {},\n          "policies": {},\n          "mod_policy": ""\n        },\n        "FIOrg": {\n          "version": 0,\n          "groups": {},\n          "values": {},\n          "policies": {},\n          "mod_policy": ""\n        }\n      },\n      "values": {},\n      "policies": {},\n      "mod_policy": ""\n    }\n  },\n  "values": {\n    "Consortium": {\n      "mod_policy": "",\n      "version": 0,\n      "value": {\n        "name": ""\n      }\n    }\n  },\n  "policies": {},\n  "mod_policy": ""\n}	{\n  "version": 0,\n  "groups": {\n    "Application": {\n      "version": 1,\n      "groups": {\n        "CentralBankOrg": {\n          "version": 0,\n          "groups": {},\n          "values": {},\n          "policies": {},\n          "mod_policy": ""\n        },\n        "FIOrg": {\n          "version": 0,\n          "groups": {},\n          "values": {},\n          "policies": {},\n          "mod_policy": ""\n        }\n      },\n      "values": {\n        "Capabilities": {\n          "mod_policy": "Admins",\n          "version": 0,\n          "value": {\n            "capabilities": {\n              "V1_4_2": {}\n            }\n          }\n        }\n      },\n      "policies": {\n        "Readers": {\n          "version": 0,\n          "mod_policy": "Admins",\n          "policy": {\n            "type": 3,\n            "typeString": "IMPLICIT_META",\n            "value": {\n              "sub_policy": "Readers",\n              "rule": 0,\n              "ruleString": "ANY"\n            }\n          }\n        },\n        "Writers": {\n          "version": 0,\n          "mod_policy": "Admins",\n          "policy": {\n            "type": 3,\n            "typeString": "IMPLICIT_META",\n            "value": {\n              "sub_policy": "Writers",\n              "rule": 0,\n              "ruleString": "ANY"\n            }\n          }\n        },\n        "Admins": {\n          "version": 0,\n          "mod_policy": "Admins",\n          "policy": {\n            "type": 3,\n            "typeString": "IMPLICIT_META",\n            "value": {\n              "sub_policy": "Admins",\n              "rule": 2,\n              "ruleString": "MAJORITY"\n            }\n          }\n        }\n      },\n      "mod_policy": "Admins"\n    }\n  },\n  "values": {\n    "Consortium": {\n      "mod_policy": "",\n      "version": 0,\n      "value": {\n        "name": "SampleConsortium"\n      }\n    }\n  },\n  "policies": {},\n  "mod_policy": ""\n}	d93141c41b382f12265e2f1be68f46dd6f99cf7129ac495fe4134d66b2c3115d		30452210024004900473103504234690707500079063006900000220800570000073008300096120003310616805300160		-----BEGIN CERTIFICATE-----\nMIICDTCCAbSgAwIBAgIRALnYEz2slB9OLPPfFiJ/4zUwCgYIKoZIzj0EAwIwaTEL\nMAkGA1UEBhMCVVMxEzARBgNVBAgTCkNhbGlmb3JuaWExFjAUBgNVBAcTDVNhbiBG\ncmFuY2lzY28xFDASBgNVBAoTC2V4YW1wbGUuY29tMRcwFQYDVQQDEw5jYS5leGFt\ncGxlLmNvbTAeFw0yMjAzMDcxNDAxMDBaFw0zMjAzMDQxNDAxMDBaMFkxCzAJBgNV\nBAYTAlVTMRMwEQYDVQQIEwpDYWxpZm9ybmlhMRYwFAYDVQQHEw1TYW4gRnJhbmNp\nc2NvMR0wGwYDVQQDExRvcmRlcmVyMC5leGFtcGxlLmNvbTBZMBMGByqGSM49AgEG\nCCqGSM49AwEHA0IABOLklc8wOfCqoUGOyR2ygiLv5UH5eiLUM9qIjkNFfaWCwlIT\nKu8Pe65nU2zICFOst4Xk2Fe6dS2TW7JSl+jXhkKjTTBLMA4GA1UdDwEB/wQEAwIH\ngDAMBgNVHRMBAf8EAjAAMCsGA1UdIwQkMCKAIMma0uk7KL5ihk2AfqWEf8Hz8wIr\ndST+Zmp0dje3KD/wMAoGCCqGSM49BAMCA0cAMEQCIEyg2vSWV1tbnzKcBNv/VGqX\n0M9nQnKG94d2PpfTCpnYAiAyXSLYoHSYE4+aFbsbvjZ2iI15FnObuLRoO5HbvF7g\nnQ==\n-----END CERTIFICATE-----\n	5235346072001900072690000055052300		\N				fabric
8	1	980fc4a9e39c7ffcc19ab59cef10c72ab6375db235fa0d820c512c466a9ce6f5	2022-03-08 20:29:02		\N	OrdererMSP	{}		CONFIG	{\n  "version": 0,\n  "groups": {\n    "Application": {\n      "version": 1,\n      "groups": {\n        "CentralBankOrg": {\n          "version": 0,\n          "groups": {},\n          "values": {\n            "MSP": {\n              "mod_policy": "",\n              "version": 0,\n              "value": {\n                "type": 0,\n                "config": {\n                  "name": "",\n                  "root_certs": [],\n                  "intermediate_certs": [],\n                  "admins": [],\n                  "revocation_list": [],\n                  "signing_identity": {},\n                  "organizational_unit_identifiers": [],\n                  "tls_root_certs": [],\n                  "tls_intermediate_certs": []\n                }\n              }\n            }\n          },\n          "policies": {\n            "Readers": {\n              "version": 0,\n              "mod_policy": "",\n              "policy": {}\n            },\n            "Writers": {\n              "version": 0,\n              "mod_policy": "",\n              "policy": {}\n            },\n            "Admins": {\n              "version": 0,\n              "mod_policy": "",\n              "policy": {}\n            }\n          },\n          "mod_policy": ""\n        }\n      },\n      "values": {},\n      "policies": {},\n      "mod_policy": "Admins"\n    }\n  },\n  "values": {},\n  "policies": {},\n  "mod_policy": ""\n}	{\n  "version": 0,\n  "groups": {\n    "Application": {\n      "version": 1,\n      "groups": {\n        "CentralBankOrg": {\n          "version": 1,\n          "groups": {},\n          "values": {\n            "MSP": {\n              "mod_policy": "",\n              "version": 0,\n              "value": {\n                "type": 0,\n                "config": {\n                  "name": "",\n                  "root_certs": [],\n                  "intermediate_certs": [],\n                  "admins": [],\n                  "revocation_list": [],\n                  "signing_identity": {},\n                  "organizational_unit_identifiers": [],\n                  "tls_root_certs": [],\n                  "tls_intermediate_certs": []\n                }\n              }\n            },\n            "AnchorPeers": {\n              "mod_policy": "Admins",\n              "version": 0,\n              "value": {\n                "anchor_peers": [\n                  {\n                    "host": "peer0cb",\n                    "port": 7051\n                  }\n                ]\n              }\n            }\n          },\n          "policies": {\n            "Readers": {\n              "version": 0,\n              "mod_policy": "",\n              "policy": {}\n            },\n            "Writers": {\n              "version": 0,\n              "mod_policy": "",\n              "policy": {}\n            },\n            "Admins": {\n              "version": 0,\n              "mod_policy": "",\n              "policy": {}\n            }\n          },\n          "mod_policy": "Admins"\n        }\n      },\n      "values": {},\n      "policies": {},\n      "mod_policy": "Admins"\n    }\n  },\n  "values": {},\n  "policies": {},\n  "mod_policy": ""\n}	d93141c41b382f12265e2f1be68f46dd6f99cf7129ac495fe4134d66b2c3115d		3045221000310045666700520093009200906598910058033390002200008210018005708533001000750270280000000		-----BEGIN CERTIFICATE-----\nMIICDTCCAbSgAwIBAgIRALnYEz2slB9OLPPfFiJ/4zUwCgYIKoZIzj0EAwIwaTEL\nMAkGA1UEBhMCVVMxEzARBgNVBAgTCkNhbGlmb3JuaWExFjAUBgNVBAcTDVNhbiBG\ncmFuY2lzY28xFDASBgNVBAoTC2V4YW1wbGUuY29tMRcwFQYDVQQDEw5jYS5leGFt\ncGxlLmNvbTAeFw0yMjAzMDcxNDAxMDBaFw0zMjAzMDQxNDAxMDBaMFkxCzAJBgNV\nBAYTAlVTMRMwEQYDVQQIEwpDYWxpZm9ybmlhMRYwFAYDVQQHEw1TYW4gRnJhbmNp\nc2NvMR0wGwYDVQQDExRvcmRlcmVyMC5leGFtcGxlLmNvbTBZMBMGByqGSM49AgEG\nCCqGSM49AwEHA0IABOLklc8wOfCqoUGOyR2ygiLv5UH5eiLUM9qIjkNFfaWCwlIT\nKu8Pe65nU2zICFOst4Xk2Fe6dS2TW7JSl+jXhkKjTTBLMA4GA1UdDwEB/wQEAwIH\ngDAMBgNVHRMBAf8EAjAAMCsGA1UdIwQkMCKAIMma0uk7KL5ihk2AfqWEf8Hz8wIr\ndST+Zmp0dje3KD/wMAoGCCqGSM49BAMCA0cAMEQCIEyg2vSWV1tbnzKcBNv/VGqX\n0M9nQnKG94d2PpfTCpnYAiAyXSLYoHSYE4+aFbsbvjZ2iI15FnObuLRoO5HbvF7g\nnQ==\n-----END CERTIFICATE-----\n	4507617007400360210056062004900410		\N				fabric
9	2	e7876b557e072def1963b9beca431bc4b0a68f973db613d419ca18a8cc0d88d5	2022-03-08 20:29:02		\N	OrdererMSP	{}		CONFIG	{\n  "version": 0,\n  "groups": {\n    "Application": {\n      "version": 1,\n      "groups": {\n        "FIOrg": {\n          "version": 0,\n          "groups": {},\n          "values": {\n            "MSP": {\n              "mod_policy": "",\n              "version": 0,\n              "value": {\n                "type": 0,\n                "config": {\n                  "name": "",\n                  "root_certs": [],\n                  "intermediate_certs": [],\n                  "admins": [],\n                  "revocation_list": [],\n                  "signing_identity": {},\n                  "organizational_unit_identifiers": [],\n                  "tls_root_certs": [],\n                  "tls_intermediate_certs": []\n                }\n              }\n            }\n          },\n          "policies": {\n            "Writers": {\n              "version": 0,\n              "mod_policy": "",\n              "policy": {}\n            },\n            "Admins": {\n              "version": 0,\n              "mod_policy": "",\n              "policy": {}\n            },\n            "Readers": {\n              "version": 0,\n              "mod_policy": "",\n              "policy": {}\n            }\n          },\n          "mod_policy": ""\n        }\n      },\n      "values": {},\n      "policies": {},\n      "mod_policy": "Admins"\n    }\n  },\n  "values": {},\n  "policies": {},\n  "mod_policy": ""\n}	{\n  "version": 0,\n  "groups": {\n    "Application": {\n      "version": 1,\n      "groups": {\n        "FIOrg": {\n          "version": 1,\n          "groups": {},\n          "values": {\n            "MSP": {\n              "mod_policy": "",\n              "version": 0,\n              "value": {\n                "type": 0,\n                "config": {\n                  "name": "",\n                  "root_certs": [],\n                  "intermediate_certs": [],\n                  "admins": [],\n                  "revocation_list": [],\n                  "signing_identity": {},\n                  "organizational_unit_identifiers": [],\n                  "tls_root_certs": [],\n                  "tls_intermediate_certs": []\n                }\n              }\n            },\n            "AnchorPeers": {\n              "mod_policy": "Admins",\n              "version": 0,\n              "value": {\n                "anchor_peers": [\n                  {\n                    "host": "peer0fi",\n                    "port": 7051\n                  }\n                ]\n              }\n            }\n          },\n          "policies": {\n            "Admins": {\n              "version": 0,\n              "mod_policy": "",\n              "policy": {}\n            },\n            "Readers": {\n              "version": 0,\n              "mod_policy": "",\n              "policy": {}\n            },\n            "Writers": {\n              "version": 0,\n              "mod_policy": "",\n              "policy": {}\n            }\n          },\n          "mod_policy": "Admins"\n        }\n      },\n      "values": {},\n      "policies": {},\n      "mod_policy": "Admins"\n    }\n  },\n  "values": {},\n  "policies": {},\n  "mod_policy": ""\n}	d93141c41b382f12265e2f1be68f46dd6f99cf7129ac495fe4134d66b2c3115d		3045221004629043085896160400069430000965102730240000002200000009877013000010450066004006600080000		-----BEGIN CERTIFICATE-----\nMIICDTCCAbSgAwIBAgIRALnYEz2slB9OLPPfFiJ/4zUwCgYIKoZIzj0EAwIwaTEL\nMAkGA1UEBhMCVVMxEzARBgNVBAgTCkNhbGlmb3JuaWExFjAUBgNVBAcTDVNhbiBG\ncmFuY2lzY28xFDASBgNVBAoTC2V4YW1wbGUuY29tMRcwFQYDVQQDEw5jYS5leGFt\ncGxlLmNvbTAeFw0yMjAzMDcxNDAxMDBaFw0zMjAzMDQxNDAxMDBaMFkxCzAJBgNV\nBAYTAlVTMRMwEQYDVQQIEwpDYWxpZm9ybmlhMRYwFAYDVQQHEw1TYW4gRnJhbmNp\nc2NvMR0wGwYDVQQDExRvcmRlcmVyMC5leGFtcGxlLmNvbTBZMBMGByqGSM49AgEG\nCCqGSM49AwEHA0IABOLklc8wOfCqoUGOyR2ygiLv5UH5eiLUM9qIjkNFfaWCwlIT\nKu8Pe65nU2zICFOst4Xk2Fe6dS2TW7JSl+jXhkKjTTBLMA4GA1UdDwEB/wQEAwIH\ngDAMBgNVHRMBAf8EAjAAMCsGA1UdIwQkMCKAIMma0uk7KL5ihk2AfqWEf8Hz8wIr\ndST+Zmp0dje3KD/wMAoGCCqGSM49BAMCA0cAMEQCIEyg2vSWV1tbnzKcBNv/VGqX\n0M9nQnKG94d2PpfTCpnYAiAyXSLYoHSYE4+aFbsbvjZ2iI15FnObuLRoO5HbvF7g\nnQ==\n-----END CERTIFICATE-----\n	0009536675402000005106374590006811		\N				fabric
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: hppoc
--

COPY public.users (id, username, email, "networkName", "firstName", "lastName", password, roles, salt, "createdAt", "updatedAt") FROM stdin;
1	exploreradmin	\N	fabric	\N	\N	$2b$10$qYE5kCuso7bd4NQ8hrWlVemhhLGxgSJWfy7wcMr00dFdign84uKN.	admin	$2b$10$qYE5kCuso7bd4NQ8hrWlVe	2022-03-08 20:31:26.999	2022-03-08 20:31:26.999
\.


--
-- Data for Name: write_lock; Type: TABLE DATA; Schema: public; Owner: hppoc
--

COPY public.write_lock (write_lock) FROM stdin;
\.


--
-- Name: blocks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hppoc
--

SELECT pg_catalog.setval('public.blocks_id_seq', 4, true);


--
-- Name: chaincodes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hppoc
--

SELECT pg_catalog.setval('public.chaincodes_id_seq', 10, true);


--
-- Name: channel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hppoc
--

SELECT pg_catalog.setval('public.channel_id_seq', 3, true);


--
-- Name: orderer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hppoc
--

SELECT pg_catalog.setval('public.orderer_id_seq', 1, false);


--
-- Name: peer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hppoc
--

SELECT pg_catalog.setval('public.peer_id_seq', 3, true);


--
-- Name: peer_ref_chaincode_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hppoc
--

SELECT pg_catalog.setval('public.peer_ref_chaincode_id_seq', 2, true);


--
-- Name: peer_ref_channel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hppoc
--

SELECT pg_catalog.setval('public.peer_ref_channel_id_seq', 3, true);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hppoc
--

SELECT pg_catalog.setval('public.transactions_id_seq', 9, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hppoc
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: write_lock_write_lock_seq; Type: SEQUENCE SET; Schema: public; Owner: hppoc
--

SELECT pg_catalog.setval('public.write_lock_write_lock_seq', 2, false);


--
-- Name: blocks blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: hppoc
--

ALTER TABLE ONLY public.blocks
    ADD CONSTRAINT blocks_pkey PRIMARY KEY (id);


--
-- Name: chaincodes chaincodes_pkey; Type: CONSTRAINT; Schema: public; Owner: hppoc
--

ALTER TABLE ONLY public.chaincodes
    ADD CONSTRAINT chaincodes_pkey PRIMARY KEY (id);


--
-- Name: channel channel_pkey; Type: CONSTRAINT; Schema: public; Owner: hppoc
--

ALTER TABLE ONLY public.channel
    ADD CONSTRAINT channel_pkey PRIMARY KEY (id);


--
-- Name: orderer orderer_pkey; Type: CONSTRAINT; Schema: public; Owner: hppoc
--

ALTER TABLE ONLY public.orderer
    ADD CONSTRAINT orderer_pkey PRIMARY KEY (id);


--
-- Name: peer peer_pkey; Type: CONSTRAINT; Schema: public; Owner: hppoc
--

ALTER TABLE ONLY public.peer
    ADD CONSTRAINT peer_pkey PRIMARY KEY (id);


--
-- Name: peer_ref_chaincode peer_ref_chaincode_pkey; Type: CONSTRAINT; Schema: public; Owner: hppoc
--

ALTER TABLE ONLY public.peer_ref_chaincode
    ADD CONSTRAINT peer_ref_chaincode_pkey PRIMARY KEY (id);


--
-- Name: peer_ref_channel peer_ref_channel_pkey; Type: CONSTRAINT; Schema: public; Owner: hppoc
--

ALTER TABLE ONLY public.peer_ref_channel
    ADD CONSTRAINT peer_ref_channel_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: hppoc
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: hppoc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: write_lock write_lock_pkey; Type: CONSTRAINT; Schema: public; Owner: hppoc
--

ALTER TABLE ONLY public.write_lock
    ADD CONSTRAINT write_lock_pkey PRIMARY KEY (write_lock);


--
-- Name: blocks_blocknum_idx; Type: INDEX; Schema: public; Owner: hppoc
--

CREATE INDEX blocks_blocknum_idx ON public.blocks USING btree (blocknum);


--
-- Name: blocks_channel_genesis_hash_idx; Type: INDEX; Schema: public; Owner: hppoc
--

CREATE INDEX blocks_channel_genesis_hash_idx ON public.blocks USING btree (channel_genesis_hash);


--
-- Name: blocks_createdt_idx; Type: INDEX; Schema: public; Owner: hppoc
--

CREATE INDEX blocks_createdt_idx ON public.blocks USING btree (createdt);


--
-- Name: channel_channel_genesis_hash_idx; Type: INDEX; Schema: public; Owner: hppoc
--

CREATE INDEX channel_channel_genesis_hash_idx ON public.channel USING btree (channel_genesis_hash);


--
-- Name: channel_channel_hash_idx; Type: INDEX; Schema: public; Owner: hppoc
--

CREATE INDEX channel_channel_hash_idx ON public.channel USING btree (channel_hash);


--
-- Name: transactions_blockid_idx; Type: INDEX; Schema: public; Owner: hppoc
--

CREATE INDEX transactions_blockid_idx ON public.transactions USING btree (blockid);


--
-- Name: transactions_channel_genesis_hash_idx; Type: INDEX; Schema: public; Owner: hppoc
--

CREATE INDEX transactions_channel_genesis_hash_idx ON public.transactions USING btree (channel_genesis_hash);


--
-- Name: transactions_createdt_idx; Type: INDEX; Schema: public; Owner: hppoc
--

CREATE INDEX transactions_createdt_idx ON public.transactions USING btree (createdt);


--
-- Name: transactions_md5_idx; Type: INDEX; Schema: public; Owner: hppoc
--

CREATE INDEX transactions_md5_idx ON public.transactions USING btree (md5((chaincode_proposal_input)::text));


--
-- Name: transactions_txhash_idx; Type: INDEX; Schema: public; Owner: hppoc
--

CREATE INDEX transactions_txhash_idx ON public.transactions USING btree (txhash);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

