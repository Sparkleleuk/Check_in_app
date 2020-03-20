-- Table: public.subscriber

-- DROP TABLE public.subscriber;

CREATE TABLE public.subscriber
(
    id bigint NOT NULL DEFAULT nextval('subscriber_id_seq'::regclass),
    email character varying COLLATE pg_catalog."default",
    password character varying(20) COLLATE pg_catalog."default",
    first_name character varying COLLATE pg_catalog."default",
    last_name character varying COLLATE pg_catalog."default",
    city character varying COLLATE pg_catalog."default",
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
    city character varying COLLATE pg_catalog."default",
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
    
-- Table: public.relationship

-- DROP TABLE public.relationship;

CREATE TABLE public.relationship
(
    id bigint NOT NULL DEFAULT nextval('relationship_id_seq'::regclass),
    relationship character varying COLLATE pg_catalog."default",
    checkin_message character varying COLLATE pg_catalog."default",
    schedule time with time zone,
    subscriber_id bigint NOT NULL DEFAULT nextval('relationship_subscriber_id_seq'::regclass),
    reg_user_id bigint NOT NULL DEFAULT nextval('relationship_reg_user_id_seq'::regclass),
    response_code integer,
    frequency character varying COLLATE pg_catalog."default",
    CONSTRAINT relationship_key PRIMARY KEY (id),
    CONSTRAINT relationship_frequency_fkey FOREIGN KEY (frequency)
        REFERENCES public.frequency_ref (frequency) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT relationship_reg_user_id_fkey FOREIGN KEY (reg_user_id)
        REFERENCES public.registered_user (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT relationship_response_code_fkey FOREIGN KEY (response_code)
        REFERENCES public.response_ref (response_code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT relationship_subscriber_id_fkey FOREIGN KEY (subscriber_id)
        REFERENCES public.subscriber (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;


-- Table: public.response_ref

-- DROP TABLE public.response_ref;

CREATE TABLE public.response_ref
(
    response_code integer NOT NULL,
    description character varying COLLATE pg_catalog."default",
    CONSTRAINT response_ref_key PRIMARY KEY (response_code)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.response_ref
    OWNER to postgres;
    
-- Table: public.frequency_ref

-- DROP TABLE public.frequency_ref;

CREATE TABLE public.frequency_ref
(
    frequency character varying COLLATE pg_catalog."default" NOT NULL,
    description character varying COLLATE pg_catalog."default",
    CONSTRAINT frequency_ref_pkey PRIMARY KEY (frequency)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.frequency_ref
    OWNER to postgres;
    
   
