-- ASSIGNMENT 3
-- DATABASE DESIGN 3972 - IUT
-- YOUR NAME:   Mahdi Alikhasi
-- YOUR STUDENT NUMBER:   9530483


---- Q3-a
create table country(
    id int primary key not null,
    name varchar(100) not null
);

create table state(
    id int primary key not null,
    name varchar(100) not null,
    country_id int references country(id)
);

create table city(
    id int primary key not null,
    name varchar(100) not null,
    state_id int references state(id)
);

create table airport(
    id varchar(3) primary key not null,
    name varchar(100) not null,
    city_id int references city(id),
    lat float,
    lan float
);

create table airline(
    id varchar(2) primary key not null,
    name varchar(100) not null
);

create table flight(
    id int primary key not null,
    start_date date not null,
    start_airport_id varchar(3) not null references airport(id),
    end_airport_id varchar(3) not null references airport(id),
    start_hour time,
    airline_id varchar(2) not null references airline(id),
    flight_number int,
    last_price int check(last_price > 0),
    last_capacity int check (last_capacity > 0)
);

create table price_capacity(
    flight_id int references flight(id),
    date timestamp,
    price int not null check(price > 0),
    capacity int not null check(capacity > 0),
    channel varchar(100) check(channel in('web service', 'airline system', 'phone')),
    primary key(flight_id, date)
);

create table passenger(
    id int primary key not null,
    first_name varchar(100) not null,
    last_name varchar(100) not null,
    age int check(age > 0 AND age < 150),
    gender varchar(10) check(gender in('male', 'female'))
);

create table ticket(
    id int primary key not null,
    flight_id int not null references flight(id),
    passenger_id int references passenger(id),
    seat int not null check(seat > 0),
    price int not null check(price > 0)
);

insert into airline(id, name) values ('K5', 'Aban Air');
insert into airline(id, name) values ('I3', 'ATA Airlines (Iran)');
insert into airline(id, name) values ('RV', 'Caspian Airlines');
insert into airline(id, name) values ('IR', 'Iran Air');
insert into airline(id, name) values ('EP', 'Iran Aseman Airlines');
insert into airline(id, name) values ('NV', 'Karun Airlines');
insert into airline(id, name) values ('Y9', 'Kish Air');
insert into airline(id, name) values ('W5', 'Mahan Air');
insert into airline(id, name) values ('PA', 'Parmiss Airlines (IPV)');

insert into country values (1, 'Iran');

insert into state values (1, 'Tehran', 1);
insert into state values (2, 'Isfahan', 1);
insert into state values (3, 'Alborz', 1);
insert into state values (4, 'Kerman', 1);
insert into state values (5, 'Khuzestan', 1);
insert into state values (6, 'Hormozgan', 1);
insert into state values (7, 'Markazi', 1);
insert into state values (8, 'Ardabil', 1);
insert into state values (9, 'Khorasan jonubi', 1);

insert into city values (1, 'Tehran', 1);
insert into city values (2, 'Isfahan', 2);
insert into city values (3, 'Karaj', 3);
insert into city values (4, 'Kerman', 4);
insert into city values (5, 'Bam', 4);
insert into city values (6, 'Abadan', 5);
insert into city values (7, 'Abu Musa', 6);
insert into city values (8, 'Ahvaz', 5);
insert into city values (9, 'Arak', 7);
insert into city values (10, 'Ardabil', 8);
insert into city values (11, 'Bandar Abbas', 6);
insert into city values (12, 'Bandar Lenge', 6);
insert into city values (13, 'Birjand', 9);

insert into airport values ('ABD', 'Abadan Airport', 6, 30.371099472, 48.2282981873);
insert into airport values ('AEU', 'Abumusa I.-Abumusa Island Airport', 7, 25.875699996948242, 55.03300094604492);
insert into airport values ('AWZ', 'Ahwaz Airport', 8, 31.337400436399996, 48.7620010376);
insert into airport values ('AJK', 'Arak Airport', 9, 34.138099670410156, 49.8473014831543);
insert into airport values ('ADU', 'Ardabil Airport', 10, 38.3256988525, 48.4244003296);
insert into airport values ('BXR', 'Bam Airport', 5, 29.084199905395508, 58.45000076293945);
insert into airport values ('BND', 'Bandar Abbas International Airport', 11, 27.218299865722656, 56.37779998779297);
insert into airport values ('BDH', 'Bandar Lengeh Airport', 12, 26.531999588, 54.824798584);
insert into airport values ('XBJ', 'Birjand Airport', 13, 32.898101806640625, 59.2661018371582);
insert into airport values ('IKA', 'Imam Khomeini International Airport', 1, 35.416099548339844, 51.152198791503906);
insert into airport values ('THR', 'Mehr Abad International Airport', 1, 35.6889, 51.3147);

insert into flight values (1, '2019-03-30', 'ABD', 'AEU', '12:00', 'K5', 3, 200000, 20);
insert into flight values (2, '2019-03-30', 'AWZ', 'AJK', '12:00', 'K5', 3, 300000, 20);
insert into flight values (3, '2019-03-30', 'ADU', 'BXR', '12:00', 'K5', 3, 400000, 36);
insert into flight values (4, '2019-03-30', 'BND', 'BDH', '12:00', 'I3', 3, 450000, 80);
insert into flight values (5, '2019-03-30', 'XBJ', 'AEU', '12:00', 'I3', 3, 250000, 40);
insert into flight values (6, '2019-03-30', 'AWZ', 'AEU', '12:00', 'I3', 3, 230000, 120);
insert into flight values (7, '2019-03-30', 'BDH', 'AEU', '12:00', 'I3', 3, 220000, 20);
insert into flight values (8, '2019-03-30', 'XBJ', 'AEU', '12:00', 'I3', 3, 600000, 20);
insert into flight values (9, '2019-03-30', 'ABD', 'BDH', '12:00', 'RV', 3, 700000, 30);
insert into flight values (10, '2019-03-30', 'BDH', 'AEU', '12:00', 'RV', 3, 250000, 20);
insert into flight values (11, '2019-03-30', 'AWZ', 'AEU', '12:00', 'IR', 3, 260000, 60);
insert into flight values (12, '2019-03-30', 'AJK', 'AWZ', '12:00', 'EP', 3, 290000, 20);
insert into flight values (13, '2019-03-30', 'ABD', 'AJK', '12:00', 'NV', 3, 650000, 30);
insert into flight values (14, '2019-03-30', 'AWZ', 'AEU', '12:00', 'Y9', 3, 200000, 20);
insert into flight values (15, '2019-03-30', 'ABD', 'AWZ', '12:00', 'Y9', 3, 200000, 20);
insert into flight values (16, '2019-03-30', 'AJK', 'BXR', '12:00', 'W5', 3, 200000, 20);
insert into flight values (17, '2019-03-30', 'AWZ', 'BXR', '12:00', 'PA', 3, 200000, 20);
insert into flight values (18, '2019-03-30', 'IKA', 'BXR', '12:00', 'W5', 3, 200000, 20);
insert into flight values (19, '2019-03-30', 'THR', 'BXR', '12:00', 'PA', 3, 200000, 20);

insert into price_capacity values (1, '2015-09-01T16:34:02', 200000, 20, 'airline system');
insert into price_capacity values (1, '2015-09-01T16:38:02', 250000, 30, 'airline system');
insert into price_capacity values (1, '2015-09-01T16:40:02', 260000, 30, 'airline system');
insert into price_capacity values (2, '2015-09-01T16:34:02', 300000, 20, 'airline system');
insert into price_capacity values (2, '2015-09-01T16:32:02', 350000, 20, 'airline system');
insert into price_capacity values (3, '2015-09-01T16:34:02', 400000, 36, 'airline system');
insert into price_capacity values (4, '2015-09-01T16:34:02', 450000, 80, 'airline system');
insert into price_capacity values (5, '2015-09-01T16:34:02', 250000, 40, 'airline system');
insert into price_capacity values (6, '2015-09-01T16:34:02', 230000, 120, 'airline system');
insert into price_capacity values (7, '2015-09-01T16:34:02', 220000, 20, 'airline system');
insert into price_capacity values (8, '2015-09-01T16:34:02', 600000, 20, 'airline system');
insert into price_capacity values (9, '2015-09-01T16:34:02', 700000, 30, 'airline system');
insert into price_capacity values (10,'2015-09-01T16:34:02', 250000, 20, 'airline system');
insert into price_capacity values (11,'2015-09-01T16:34:02', 260000, 60, 'airline system');
insert into price_capacity values (12,'2015-09-01T16:34:02', 290000, 20, 'airline system');
insert into price_capacity values (13,'2015-09-01T16:34:02', 650000, 30, 'airline system');
insert into price_capacity values (14,'2015-09-01T16:34:02', 200000, 20, 'airline system');
insert into price_capacity values (15,'2015-09-01T16:34:02', 200000, 20, 'airline system');
insert into price_capacity values (16,'2015-09-01T16:34:02', 200000, 20, 'airline system');
insert into price_capacity values (17,'2015-09-01T16:34:02', 200000, 20, 'airline system');


---- Q3-b
create view inter_State_flight_count as(
    select ststate.name as "Origin State", enstate.name as "Destination State", flight.start_date, count(*) as "Number of flight"
    from flight
    inner join airport stairport on stairport.id = flight.start_airport_id
    inner join airport enairport on enairport.id = flight.end_airport_id
    inner join city stcity on stcity.id = stairport.city_id
    inner join city encity on encity.id = enairport.city_id
    inner join state ststate on ststate.id = stcity.state_id
    inner join state enstate on enstate.id = encity.state_id
    group by "Origin State", "Destination State", flight.start_date
);

select * from inter_State_flight_count

---- Q3-c
create view last_price_capacity as (
    WITH flight_date as (
        select flight_id, max(date) as date
        from price_capacity
        group by flight_id
    )
    
    select flight.id, price_capacity.date, price_capacity.price, flight.last_price, price_capacity.capacity, flight.last_capacity, price_capacity.channel
    from price_capacity
    inner join flight_date on price_capacity.flight_id = flight_date.flight_id AND price_capacity.date = flight_date.date
    inner join flight on price_capacity.flight_id = flight.id
);

select * from last_price_capacity;

create view conflict_price as (
    select * from last_price_capacity where price <> last_price
);

select * from conflict_price;


---- Q3-d
create view org_airport as(
    WITH airport_list(id, name, lat, lan, city_id, city_name) as(
        select airport.id, airport.name, airport.lat, airport.lan, airport.city_id, city.name as city_name
        from airport
        inner join city on city.id = airport.city_id
        where airport.id IN(
            select distinct(flight.start_airport_id) from flight
        )
    ), city_count as(
        select city_name, city_id, count(*) as no from airport_list group by city_name, city_id
    )
    
    -- one air port
    select airport_list.id, airport_list.name, airport_list.lat, airport_list.lan, (NULL) as city_id , (NULL) as city_name
    from airport_list
    inner join city_count on city_count.city_id = airport_list.city_id
    where city_count.no = 1
    UNION
    select airport_list.id, airport_list.name, airport_list.lat, airport_list.lan, airport_list.city_id, airport_list.city_name
    from airport_list
    inner join city_count on city_count.city_id = airport_list.city_id
    where city_count.no > 1
);
select * from org_airport



---- Q3-e
create table backup_flight(
    id int not null,
    start_date date not null,
    start_airport_id varchar(3) not null references airport(id),
    end_airport_id varchar(3) not null references airport(id),
    start_hour time,
    airline_id varchar(2) not null references airline(id),
    flight_number int,
    last_price int check(last_price > 0),
    last_capacity int check (last_capacity > 0),
    modified timestamp not null,
    primary key(id, modified)
);

CREATE OR REPLACE FUNCTION log_last_flight()
  RETURNS trigger AS
$BODY$
BEGIN
 IF NEW <> OLD THEN
 INSERT INTO backup_flight
 VALUES(OLD.id,OLD.start_date, OLD.start_airport_id, OLD.end_airport_id, OLD.start_hour, OLD.airline_id, OLD.flight_number, OLD.last_price, OLD.last_capacity ,now());
 END IF;
 
 RETURN NEW;
END;
$BODY$

LANGUAGE plpgsql VOLATILE
COST 100;

CREATE TRIGGER backup_flight_trigger BEFORE UPDATE ON flight
FOR EACH ROW EXECUTE PROCEDURE log_last_flight();



---- Q3-f
CREATE OR REPLACE FUNCTION update_flight_price()
  RETURNS trigger AS
$BODY$
BEGIN
 
 UPDATE flight set
    last_price = NEW.price,
    last_capacity = NEW.capacity
 where id = NEW.flight_id ;
 RETURN NEW;
END;
$BODY$

LANGUAGE plpgsql VOLATILE
COST 100;

CREATE TRIGGER update_flight_trigger AFTER INSERT ON price_capacity
FOR EACH ROW EXECUTE PROCEDURE update_flight_price();



---- Q3-g
BEGIN;
UPDATE flight set
last_price = 200000,
last_capacity = 20
where id = 1 ;
insert into price_capacity values (1, '2020-09-01T16:34:02', 200000, 20, 'airline system');
END;


---- Q3-h
CREATE FUNCTION check_flight_is_done(integer) RETURNS BOOLEAN AS $$
    select CAST(flight.start_date + flight.start_hour AS timestamp) < now() from flight where flight.id = $1
$$ LANGUAGE SQL;

create table flight_history(
    id int primary key not null,
    start_date date not null,
    start_airport_id varchar(3) not null references airport(id),
    end_airport_id varchar(3) not null references airport(id),
    start_hour time,
    airline_id varchar(2) not null references airline(id),
    flight_number int
);

CREATE OR REPLACE FUNCTION remove_flight() RETURNS void AS
$BODY$
    BEGIN
    insert into flight_history
        select id,start_date,start_airport_id,end_airport_id,start_hour,airline_id,flight_number from flight where check_flight_is_done(flight.id) = true;
        
    delete from price_capacity where check_flight_is_done(price_capacity.flight_id) = true; 
    delete from flight where check_flight_is_done(flight.id) = true;
    
    END;
$BODY$

LANGUAGE plpgsql VOLATILE
COST 100;




---- Q3-i
CREATE ROLE operator;
GRANT UPDATE ON flight TO operator;
GRANT INSERT ON flight TO operator;
GRANT DELETE ON flight TO operator;
GRANT SELECT ON flight TO operator;
GRANT UPDATE ON price_capacity TO operator;
GRANT INSERT ON price_capacity TO operator;
GRANT DELETE ON price_capacity TO operator;
GRANT SELECT ON price_capacity TO operator;
GRANT UPDATE ON passenger TO operator;
GRANT INSERT ON passenger TO operator;
GRANT DELETE ON passenger TO operator;
GRANT SELECT ON passenger TO operator;
GRANT UPDATE ON ticket TO operator;
GRANT INSERT ON ticket TO operator;
GRANT DELETE ON ticket TO operator;
GRANT SELECT ON ticket TO operator;
GRANT SELECT ON inter_State_flight_count TO operator;
GRANT SELECT ON last_price_capacity TO operator;
GRANT SELECT ON conflict_price TO operator;
GRANT SELECT ON org_airport TO operator;
GRANT SELECT ON backup_flight TO operator;
GRANT SELECT ON flight_history TO operator;





---- Q4
CREATE OR REPLACE RECURSIVE VIEW view_fibo(column1, column2) AS(
    values(0, 1)
    union
    SELECT column2, column1 + column2 from view_fibo where column2 < 60
    
);

select column1 from view_fibo;








---- Q5-b
SELECT st.staff_id, customer.first_name, customer.last_name
FROM staff st
INNER JOIN rental rt USING (staff_id)
INNER JOIN customer on customer.customer_id = rt.customer_id
INNER JOIN address on customer.address_id = address.address_id
INNER JOIN city on address.city_id = city.city_id
INNER JOIN country co ON co.country_id = city.country_id
WHERE co.country = 'Italy'







