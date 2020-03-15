-- Table: public.subscriber

-- DROP TABLE public.subscriber;

CREATE TABLE public.subscriber
(
    id bigint NOT NULL DEFAULT nextval('subscriber_id_seq'::regclass),
    email character varying COLLATE pg_catalog."default",
    password character varying(10) COLLATE pg_catalog."default",
    first_name character varying COLLATE pg_catalog."default",
    last_name character varying COLLATE pg_catalog."default",
    city character varying(25) COLLATE pg_catalog."default",
    state character varying(2) COLLATE pg_catalog."default",
    zip_code character varying COLLATE pg_catalog."default",
    phone integer,
    CONSTRAINT subscriber_key PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.subscriber
    OWNER to postgres;
    
-- Table: public.registered_user

-- DROP TABLE public.registered_user;

CREATE TABLE public.registered_user
(
    id bigint NOT NULL DEFAULT nextval('registered_user_id_seq'::regclass),
    first_name character varying COLLATE pg_catalog."default",
    last_name character varying COLLATE pg_catalog."default",
    nickname character varying COLLATE pg_catalog."default",
    year_of_birth integer,
    phone integer,
    city character varying(25) COLLATE pg_catalog."default",
    state character varying(2) COLLATE pg_catalog."default",
    zip_code character varying COLLATE pg_catalog."default",
    CONSTRAINT registered_user_key PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.registered_user
    OWNER to postgres;
    
-- Table: public.checkin_request

-- DROP TABLE public.checkin_request;

CREATE TABLE public.checkin_request
(
    relationship character varying(20) COLLATE pg_catalog."default",
    message character varying COLLATE pg_catalog."default",
    frequency character varying(20) COLLATE pg_catalog."default",
    schedule time with time zone,
    subscriber_id bigint NOT NULL DEFAULT nextval('subscriber_to_registered_user_subscriber_id_seq'::regclass),
    reg_user_id bigint NOT NULL DEFAULT nextval('subscriber_to_registered_user_reg_user_id_seq'::regclass),
    checkin_id bigint NOT NULL DEFAULT nextval('checkin_request_checkin_id_seq'::regclass),
    CONSTRAINT checkin_request_key PRIMARY KEY (checkin_id),
    CONSTRAINT subscriber_to_registered_user_reg_user_id_fkey FOREIGN KEY (reg_user_id)
        REFERENCES public.registered_user (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT subscriber_to_registered_user_subscriber_id_fkey FOREIGN KEY (subscriber_id)
        REFERENCES public.subscriber (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.checkin_request
    OWNER to postgres;

-- Table: public.responses

-- DROP TABLE public.responses;

CREATE TABLE public.responses
(
    id bigint NOT NULL DEFAULT nextval('responses_id_seq'::regclass),
    response_code integer,
    "timestamp" timestamp without time zone,
    checkin_id bigint NOT NULL DEFAULT nextval('responses_checkin_id_seq'::regclass),
    CONSTRAINT responses_checkin_id_fkey FOREIGN KEY (checkin_id)
        REFERENCES public.checkin_request (checkin_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.responses
    OWNER to postgres;
   
