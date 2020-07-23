CREATE SEQUENCE role_id_seq;

CREATE TABLE role (
                id INTEGER NOT NULL DEFAULT nextval('role_id_seq'),
                name VARCHAR NOT NULL,
                CONSTRAINT role_pk PRIMARY KEY (id)
);


ALTER SEQUENCE role_id_seq OWNED BY role.id;

CREATE SEQUENCE gift_type_seq;

CREATE TABLE gift (
                type INTEGER NOT NULL DEFAULT nextval('gift_type_seq'),
                value INTEGER DEFAULT 0 NOT NULL,
                name VARCHAR NOT NULL,
                CONSTRAINT gift_pk PRIMARY KEY (type, value)
);


ALTER SEQUENCE gift_type_seq OWNED BY gift.type;

CREATE SEQUENCE city_id_seq;

CREATE TABLE city (
                id INTEGER NOT NULL DEFAULT nextval('city_id_seq'),
                name VARCHAR NOT NULL,
                CONSTRAINT city_pk PRIMARY KEY (id)
);


ALTER SEQUENCE city_id_seq OWNED BY city.id;

CREATE TABLE users (
                mobile VARCHAR NOT NULL,
                name VARCHAR NOT NULL,
                lastname VARCHAR NOT NULL,
                profit INTEGER NOT NULL,
                is_active BOOLEAN DEFAULT true NOT NULL,
                role_id INTEGER NOT NULL,
                city_id INTEGER NOT NULL,
                CONSTRAINT users_pk PRIMARY KEY (mobile)
);


CREATE TABLE gifted (
                type INTEGER NOT NULL,
                value INTEGER NOT NULL,
                mobile VARCHAR NOT NULL,
                CONSTRAINT gifted_pk PRIMARY KEY (type, value, mobile)
);


CREATE TABLE price_per_city (
                id INTEGER NOT NULL,
                price_per_kilometer INTEGER NOT NULL,
                CONSTRAINT price_per_city_pk PRIMARY KEY (id)
);


CREATE SEQUENCE default_comment_id_seq;

CREATE TABLE default_comment (
                id INTEGER NOT NULL DEFAULT nextval('default_comment_id_seq'),
                text VARCHAR NOT NULL,
                CONSTRAINT default_comment_pk PRIMARY KEY (id)
);


ALTER SEQUENCE default_comment_id_seq OWNED BY default_comment.id;

CREATE TABLE bookmark (
                lat REAL NOT NULL,
                lon REAL NOT NULL,
                passenger_mobile VARCHAR NOT NULL,
                title VARCHAR NOT NULL,
                CONSTRAINT bookmark_pk PRIMARY KEY (lat, lon, passenger_mobile)
);


CREATE TABLE car (
                pelak VARCHAR NOT NULL,
                color VARCHAR NOT NULL,
                year DATE NOT NULL,
                CONSTRAINT car_pk PRIMARY KEY (pelak)
);


CREATE TABLE own (
                pelak VARCHAR NOT NULL,
                mobile VARCHAR NOT NULL,
                CONSTRAINT own_pk PRIMARY KEY (pelak, mobile)
);


CREATE SEQUENCE travel_travel_id_seq;

CREATE TABLE travel (
                travel_id INTEGER NOT NULL DEFAULT nextval('travel_travel_id_seq'),
                start_point REAL NOT NULL,
                start_point_lon REAL NOT NULL,
                starttime TIMESTAMP NOT NULL,
                driver_mobile VARCHAR NOT NULL,
                passenger_mobile VARCHAR NOT NULL,
                destination_lat REAL NOT NULL,
                destination_lon REAL NOT NULL,
                type_of_payment CHAR NOT NULL,
                price INTEGER DEFAULT 0 NOT NULL,
                final_price INTEGER NOT NULL,
                city_id INTEGER NOT NULL,
                CONSTRAINT travel_pk PRIMARY KEY (travel_id)
);


ALTER SEQUENCE travel_travel_id_seq OWNED BY travel.travel_id;

CREATE SEQUENCE takhfif_id_seq;

CREATE TABLE takhfif (
                id INTEGER NOT NULL DEFAULT nextval('takhfif_id_seq'),
                time TIMESTAMP NOT NULL,
                travel_id INTEGER NOT NULL,
                price INTEGER DEFAULT 0 NOT NULL,
                code VARCHAR,
                CONSTRAINT takhfif_pk PRIMARY KEY (id)
);


ALTER SEQUENCE takhfif_id_seq OWNED BY takhfif.id;

CREATE TABLE travel_vote (
                travel_id INTEGER NOT NULL,
                from_id VARCHAR NOT NULL,
                star INTEGER,
                default_comment_id INTEGER NOT NULL,
                comment TEXT,
                to_id VARCHAR NOT NULL,
                CONSTRAINT travel_vote_pk PRIMARY KEY (travel_id, from_id)
);


CREATE TABLE travel_part (
                travel_id INTEGER NOT NULL,
                no INTEGER NOT NULL,
                lat REAL NOT NULL,
                lon REAL NOT NULL,
                rest_time INTEGER DEFAULT 0 NOT NULL,
                CONSTRAINT travel_part_pk PRIMARY KEY (travel_id, no)
);


ALTER TABLE users ADD CONSTRAINT role_user_fk
FOREIGN KEY (role_id)
REFERENCES role (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE gifted ADD CONSTRAINT gift_gifted_fk
FOREIGN KEY (type, value)
REFERENCES gift (type, value)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE price_per_city ADD CONSTRAINT city_price_per_city_fk
FOREIGN KEY (id)
REFERENCES city (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE travel ADD CONSTRAINT city_travel_fk
FOREIGN KEY (city_id)
REFERENCES city (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE users ADD CONSTRAINT city_users_fk
FOREIGN KEY (city_id)
REFERENCES city (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE bookmark ADD CONSTRAINT user_bookmark_fk
FOREIGN KEY (passenger_mobile)
REFERENCES users (mobile)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE travel ADD CONSTRAINT user_travel_fk
FOREIGN KEY (passenger_mobile)
REFERENCES users (mobile)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE own ADD CONSTRAINT user_own_fk
FOREIGN KEY (mobile)
REFERENCES users (mobile)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE travel ADD CONSTRAINT user_travel_fk1
FOREIGN KEY (driver_mobile)
REFERENCES users (mobile)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE travel_vote ADD CONSTRAINT user_travel_vote_fk
FOREIGN KEY (from_id)
REFERENCES users (mobile)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE travel_vote ADD CONSTRAINT user_travel_vote_fk1
FOREIGN KEY (to_id)
REFERENCES users (mobile)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE gifted ADD CONSTRAINT user_gifted_fk
FOREIGN KEY (mobile)
REFERENCES users (mobile)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE travel_vote ADD CONSTRAINT default_comment_vote_fk
FOREIGN KEY (default_comment_id)
REFERENCES default_comment (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE own ADD CONSTRAINT car_own_fk
FOREIGN KEY (pelak)
REFERENCES car (pelak)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE travel_part ADD CONSTRAINT travel_destination_fk
FOREIGN KEY (travel_id)
REFERENCES travel (travel_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE travel_vote ADD CONSTRAINT travel_vote_fk
FOREIGN KEY (travel_id)
REFERENCES travel (travel_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE takhfif ADD CONSTRAINT travel_takhfif_fk
FOREIGN KEY (travel_id)
REFERENCES travel (travel_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;