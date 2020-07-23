-- ASSIGNMENT 2
-- DATABASE DESIGN 3972 - IUT
-- YOUR NAME:   Mahdi Alikhasi
-- YOUR STUDENT NUMBER:   9530483


---- Q2-a
create table city(
    ID varchar(10) NOT NULL PRIMARY KEY,
    name varchar(250) NOT NULL
);
create table employee(
    id varchar(10) NOT NULL PRIMARY KEY,
    firstName varchar(250) NOT NULL,
    lastName varchar(250) NOT NULL,
    cityID varchar(10) references city(ID),
    streetName varchar(250)
);
create table branch(
    ID varchar(10) NOT NULL PRIMARY KEY,
    name varchar(250) NOT NULL,
    cityID varchar(10) references city(ID)
);
create table branch_employee(
    employeeID varchar(10) references employee(ID) NOT NULL,
    branchID varchar(10) references branch(ID) NOT NULL,
    salary integer NOT NULL,
    PRIMARY KEY(employeeID, branchID)
);
create table leader(
    employeeID varchar(10) references employee(ID) NOT NULL,
    ID varchar(10) NOT NULL references employee(ID),
    PRIMARY KEY(employeeID, ID) 
);




---- Q2-b
select employee.firstName as "First Name", employee.lastName as "Last Name", city.name as "City Name", streetName as "Street Name"
from employee
inner join city on city.ID = employee.cityID
inner join branch_employee on branch_employee.employeeID = employee.ID
inner join branch on branch.ID = branch_employee.branchID
where branch.name = 'Main Branch' and branch_employee.salary > 20000000



---- Q2-c
select employee.firstName as "First Name", employee.lastName as "Last Name"
from employee
inner join city on city.ID = employee.cityID
inner join leader on leader.employeeID = employee.ID
where employee.cityID = (select cityID from employee where employee.ID = leader.ID) and employee.streetName = (select streetName from employee where employee.ID = leader.ID) 



---- Q2-d
WITH TABLE1(cityname, sumofsalary, id) AS
(
    select city.name, sum(branch_employee.salary) as "sumofsalary", employee.ID
    from employee
    inner join city on city.ID = employee.cityID
    inner join branch_employee on branch_employee.employeeID = employee.ID
    group by city.name, employee.ID
)
select TABLE1.cityname, count(TABLE1.cityname) as "employee count", sum(sumofsalary) as "Sum Of Salary"
from TABLE1 
group by TABLE1.cityname



---- Q2-e
(
select employee.firstName as "First Name", employee.lastName as "Last Name", employee.id
from employee
)

EXCEPT

(
select employee.firstName as "First Name", employee.lastName as "Last Name", employee.id
from employee
inner join branch_employee on branch_employee.employeeID = employee.ID
inner join branch on branch.ID = branch_employee.branchID
where branch.name = 'Main Branch'
)



---- Q2-f
WITH Table1(firstName, lastname, salary, id) AS (
    select employee.firstName, employee.lastName, sum(salary), employee.ID
    from employee
    inner join branch_employee on branch_employee.employeeID = employee.ID
    inner join branch on branch.ID = branch_employee.branchID
    group by employee.ID, employee.firstName,employee.lastName
)

select firstName, lastName from Table1 where salary < ALL
(
    select Table1.salary 
    from branch
    inner join branch_employee on branch_employee.branchID = branch.ID
    inner join Table1 on branch_employee.employeeID = Table1.id
    where branch.name = 'Main Branch'
)



---- Q2-g
WITH Table1(firstName, lastname, salary, id) AS (
    select employee.firstName, employee.lastName, sum(salary), employee.ID
    from employee
    inner join branch_employee on branch_employee.employeeID = employee.ID
    inner join branch on branch.ID = branch_employee.branchID
    group by employee.ID, employee.firstName,employee.lastName
), TABLE2(id, name, averageSalary) AS(
select branch.id, branch.name, avg(Table1.salary)
from branch
inner join branch_employee on branch_employee.branchID = branch.ID
inner join Table1 on Table1.id = branch_employee.employeeID
group by branch.id, branch.name)

select TABLE2.name as "Branch Name", employee.firstName, employee.lastName
from leader
inner join branch_employee on branch_employee.employeeID = leader.ID
inner join TABLE2 on TABLE2.id = branch_employee.branchID
inner join employee on employee.id = leader.id
where TABLE2.averageSalary > (select averageSalary from TABLE2 where name = 'Main Branch');


---- Q2-h
update branch_employee
set salary = 
    case 
    when branch_employee.salary * 1.05 > 30000000 then branch_employee.salary * 1.02
    else branch_employee.salary * 1.05
    end
from branch, leader
where branch.ID = branch_employee.branchID and branch.name = 'Main Branch' and leader.ID = branch_employee.employeeID;




---- Q2-i
create table employee(
    id varchar(10) NOT NULL PRIMARY KEY,
    firstName varchar(250) NOT NULL,
    lastName varchar(250) NOT NULL,
    cityID varchar(10) references city(ID),
    streetName varchar(250),
    leaderID varchar(10) references employee(id) 
);



---- Q4-e
CREATE VIEW leader_avg_employee AS(
WITH Table1(firstName, lastname, salary, id) AS (
    select employee.firstName, employee.lastName, sum(salary), employee.ID
    from employee
    inner join branch_employee on branch_employee.employeeID = employee.ID
    inner join branch on branch.ID = branch_employee.branchID
    group by employee.ID, employee.firstName,employee.lastName
)

select employee.firstName as ModirName, employee.lastName as ModirLastName, avg(salary) 
from leader
inner join employee on employee.ID = leader.ID
inner join Table1 on Table1.id = leader.employeeID
where leader.ID <> leader.employeeID
group by employee.firstName, employee.lastName)





---- Q5-a
with TABLE1 AS(
select store.store_id, actor.first_name, actor.last_name, actor.actor_id, count(actor.actor_id) as countof
from store
inner join inventory on inventory.store_id = store.store_id
inner join film on film.film_id = inventory.film_id
inner join film_actor on film_actor.film_id = film.film_id
inner join actor on actor.actor_id = film_actor.actor_id
group by store.store_id, actor.first_name, actor.last_name, actor.actor_id
order by store.store_id, countof DESC), MAXTABLE AS

(select store_id, max(countof) as maxof from TABLE1 group by store_id)

select MAXTABLE.store_id, TABLE1.first_name, TABLE1.last_name, TABLE1.countof
from MAXTABLE
inner join TABLE1 on TABLE1.store_id = MAXTABLE.store_id and TABLE1.countof = MAXTABLE.maxof





---- Q5-b
create MATERIALIZED view sale_category_store as(
select sum(amount), category.name, category.category_id, store.store_id
from rental
inner join payment on payment.rental_id = rental.rental_id
inner join inventory on rental.inventory_id = inventory.inventory_id
inner join store on store.store_id = inventory.store_id
inner join film on film.film_id = inventory.film_id
inner join film_category on film_category.film_id = film.film_id
inner join category on film_category.category_id = category.category_id
group by category.name, category.category_id, store.store_id
order by store_id, category_id)


REFRESH MATERIALIZED VIEW sale_category_store;
DROP MATERIALIZED VIEW sale_category_store;





---- Q5-c
alter table film
    add column temporal_rental_duration integer

update film
set temporal_rental_duration = rental_duration - 1
from language
where language.language_id = film.language_id and language.name = 'English'











