-- DATABASE DESIGN 3972 - IUT
-- YOUR NAME:   Mahdi Alikhasi
-- YOUR STUDENT NUMBER:   9530483


---- Q5-c
CREATE TABLE courses(
	ID int NOT NULL PRIMARY KEY,
	title varchar(250) NOT NULL,
	credit int NOT NULL	
);

CREATE TABLE terms(
	ID int NOT NULL PRIMARY KEY,
	semester varchar (250),
	year date,
	check (semester in('fall', 'spring'))
);

CREATE TABLE places(
	ID int NOT NULL PRIMARY KEY,
	title varchar(250) NOT NULL
);

CREATE TABLE times(
	ID int NOT NULL PRIMARY KEY,
	day varchar(50),
	CHECK (day in('SA', 'SU', 'MO', 'TU', 'TH', 'WE', 'FR')),
	time varchar(50)
);

CREATE TABLE teachers(
	ID int NOT NULL PRIMARY KEY,
	first_name varchar(200),
	last_name varchar(200)
);

CREATE TABLE available_courses(
	ID serial PRIMARY KEY NOT NULL,
	course_id int REFERENCES courses (ID),
	term_id int REFERENCES terms (ID),
	teacher_id int REFERENCES teachers (ID),
	place_id int REFERENCES places(ID),
	time_id int REFERENCES times(ID)
);

CREATE TABLE students(
	ID int NOT NULL PRIMARY KEY,
	first_name varchar(250),
	last_name varchar(250)
);

CREATE TABLE taken_courses(
	ID serial NOT NULL PRIMARY KEY,
	student_id int REFERENCES students(ID),
	available_courses_id int REFERENCES available_course(ID),
	grade float
);
---- Q7






---- Q10-a

select first_name, last_name, city
from customer
inner join address on customer.address_id = address.address_id
inner join city on address.city_id = city.city_id
inner join country on city.country_id = country.country_id
where country = 'Iran'




---- Q10-b

select distinct(title), description, release_year, rating, length, fulltext
from rental
inner join customer on rental.customer_id = customer.customer_id
inner join address on customer.address_id = address.address_id
inner join city on address.city_id = city.city_id
inner join country on city.country_id = country.country_id
inner join inventory on rental.inventory_id = inventory.inventory_id
inner join film on inventory.film_id = film.film_id
where country = 'Iran'
group by description, release_year, rating, length, fulltext, title




---- Q10-c

select actor.first_name, actor.last_name
from rental
inner join customer on rental.customer_id = customer.customer_id
inner join address on customer.address_id = address.address_id
inner join city on address.city_id = city.city_id
inner join country on city.country_id = country.country_id
inner join inventory on rental.inventory_id = inventory.inventory_id
inner join film on inventory.film_id = film.film_id
inner join film_actor on film.film_id = film_actor.film_id
inner join actor on film_actor.actor_id = actor.actor_id
where country = 'Iran'
group by actor.first_name, actor.last_name





---- Q10-d

select first_name, last_name, rental_date, return_date
from rental
inner join customer on rental.customer_id = customer.customer_id
inner join address on customer.address_id = address.address_id
inner join city on address.city_id = city.city_id
inner join country on city.country_id = country.country_id
where country = 'Iran' and date(rental_date) = date(return_date)



