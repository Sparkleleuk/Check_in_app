-- Table: public.subscriber

-- DROP TABLE public.subscriber;

CREATE TABLE public.subscriber
(
    id bigint NOT NULL DEFAULT nextval('subscriber_id_seq'::regclass),
    email character varying COLLATE pg_catalog."default",
    password character varying(20) COLLATE pg_catalog."default",
    first_name character varying COLLATE pg_catalog."default",
    last_name character varying COLLATE pg_catalog."default",
    city character varying(25) COLLATE pg_catalog."default",
    state character varying(2) COLLATE pg_catalog."default",
    zip_code character varying COLLATE pg_catalog."default",
    phone bigint,
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
    phone bigint,
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
    
-- Table: public.check_in

-- DROP TABLE public.check_in;

CREATE TABLE public.check_in
(
    relationship character varying(20) COLLATE pg_catalog."default",
    checkin_message character varying COLLATE pg_catalog."default",
    frequency character varying(20) COLLATE pg_catalog."default",
    schedule time with time zone,
    response_id bigint NOT NULL DEFAULT nextval('check_in_response_id_seq'::regclass),
    response_code integer REFERENCES response_ref(response_code),
    response_time timestamp with time zone,
    subscriber_id bigint,
    reg_user_id bigint,
    CONSTRAINT check_in_reg_user_id_fkey FOREIGN KEY (reg_user_id)
        REFERENCES public.registered_user (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT check_in_subscriber_id_fkey FOREIGN KEY (subscriber_id)
        REFERENCES public.subscriber (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.check_in
    OWNER to postgres;
    
-- Table: public.response_ref

-- DROP TABLE public.response_ref;

CREATE TABLE public.response_ref
(
    response_code integer,
    description character varying COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.response_ref
    OWNER to postgres;
