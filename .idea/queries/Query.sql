create database IF NOT EXISTS Practice;
use Practice;
CREATE TABLE users
(
    id         INT AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    email      VARCHAR(100) NOT NULL UNIQUE,
    gender     ENUM ('Male', 'Female', 'Other'),
    dob        DATE      DEFAULT (CURRENT_DATE),
    salary     DECIMAL(10, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

# DROP table users;

select *
from users;
show tables;
ALTER TABLE users
    ADD COLUMN is_Active BOOLEAN DEFAULT TRUE;
ALTER TABLE users
    DROP COLUMN is_Active;
ALTER TABLE users
    MODIFY name VARCHAR(150);
-- xxxxxxxxxxxxxxxxxx
SELECT name, gender
from users
WHERE gender <> 'Male'; -- != is also used for Not Equals to

SELECT *
from users
where dob > '1999-01-01';
SELECT *
from users
WHERE id <= 12 && gender != 'Male' && dob < '2000-01-01';

SELECT *
from users
WHERE gender = 'Male'
   OR salary > 50000
ORDER BY id DESC
LIMIT 5;
SELECT '50 000';
SELECT '50 000' + 0;
SELECT 'abc100' + 0;

SET GLOBAL sql_mode = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
-- Gloabl Mode enabled for Throwing Error

SELECT @sql_mode;
SELECT @@GLOBAL.sql_mode;
SELECT @@GLOBAL.sql_mode;

SELECT *
from users;
UPDATE users
SET gender = 'Female'
where (gender = 'Male' && salary > 45000)
ORDER BY id
LIMIT 3;

SELECT *
from users
where id = 5;
UPDATE users
SET salary = 70000
where id = 5;

-- increase salary by 10,000 for all uses who has salary less than 55,000
UPDATE users
SET salary= salary + 10000
where salary < 60000;

SELECT *
from users;
UPDATE users
SET gender = 'Other'
where salary < 62000;
SELECT *
from users
where gender = 'Other';

DELETE
from users
where salary < 65000;

ALTER TABLE users
    ADD COLUMN marriage ENUM ('Married' , 'Bachelor') DEFAULT 'Bachelor' NOT NULL;
SELECT *
FROM users;
UPDATE users
SET users.marriage = 'Married'
where gender = 'Female';


SELECT COUNT(*)
FROM users
WHERE gender = 'Male';
SELECT COUNT(*)
FROM users
WHERE gender = 'Female';


USE Practice;
SHOW TABLES;
SELECT MIN(users.salary), MAX(users.salary), COUNT(gender = 'Male') as male_C, COUNT(gender = 'Female')
from users;

SELECT users.gender, AVG(users.salary)
from users
GROUP BY gender;

SELECT id,
       users.gender,
       users.name,
       LOWER(users.name)                           as Low,
       CONCAT(LOWER(users.name), ' -- Radhika --') AS concat,
       LENGTH(users.name)                          as Len,
       NOW()                                       AS time,
       YEAR(dob)                                   as YOB
from users;

SELECT users.name, DATEDIFF(CURDATE(), users.dob) as StayedDays
FROM users;
-- Radha radha radha radha radha radha radha radha radha radha radha radha radha radha radha radha radha radha Radha Radha Radha
-- Radha Radha Radha Radha Radha Radha Radha Radha Radha Radha Radha Radha Radh Radha Radha Radha Radha Radha Radha Radha Radha Radha Radha Radha Radha
-- Radha Radha Radha Radha Radha Radha radha radha radha radha radha radha radha radha radha radha radha radha radha radha radha radha radha radha radha radha radha

SELECT name,
       TIMESTAMPDIFF(YEAR, dob, CURDATE())            AS years,
       TIMESTAMPDIFF(MONTH, dob, CURDATE())
           - TIMESTAMPDIFF(YEAR, dob, CURDATE()) * 12 AS months,
       TIMESTAMPDIFF(DAY,
                     DATE_ADD(
                             dob,
                             INTERVAL TIMESTAMPDIFF(YEAR, dob, CURDATE()) YEAR
                     ),
                     CURDATE()
       )                                              AS days
FROM users;

SELECT id, MOD(id, 2) as rem
from users
ORDER BY id;

SELECT id, name, IF(users.gender = 'Female', 'Yes', 'No')
from users;

Set autocommit = 0;
select *
from users;
delete
from users
where email = 'rohit.sharma@example.com';
ROLLBACK;

ALTER TABLE users
    ADD CONSTRAINT UNIQUE (id);

# WITH t AS (
#     SELECT id
#     FROM users
#     WHERE gender='Male' AND salary>45000
#     ORDER BY id
#     LIMIT 3
# )
# UPDATE users
#     JOIN t USING(id)
# SET gender='Female';
#

CREATE TABLE addresses
(
    id           INT AUTO_INCREMENT PRIMARY KEY,
    user_id      INT          NOT NULL,
    address_line VARCHAR(150) NOT NULL,
    city         VARCHAR(50)  NOT NULL,
    state        VARCHAR(50)  NOT NULL,
    country      VARCHAR(50)  NOT NULL DEFAULT 'India',
    pincode      VARCHAR(10)  NOT NULL,
    created_at   TIMESTAMP             DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);


# drop table addresses;
SELECT id
FROM users
ORDER BY id;
select *
FROM addresses;

-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx --
-- 1. List all users with their city and state.
SELECT users.id as ID, users.name As Name, addresses.city as City, addresses.state as State
FROM users
         JOIN addresses on users.id = addresses.user_id;

-- 2. Show users who live in Delhi.
SELECT u.id, u.name
from users as u
         join addresses a on u.id = a.user_id
where state = 'Delhi';

-- 3. Get users with salary > 50,000 and show their full address.
SELECT u.id as ID, u.name as Name, a.address_line
FROM users as u
         LEFT JOIN addresses as a on u.id = a.user_id
WHERE u.salary > 50000;
-- For this one JOIN Also worked , but Left join puts more stability on User's data right ? like only those have valid ids only that data comes right ?

-- 5. Find how many users live in each state.
SELECT COUNT(u.name) as Count, a.state as State
from users as u
         LEFT JOIN addresses a on u.id = a.user_id
GROUP BY a.state;

-- 6. Show the youngest user in each city.
SELECT u.id AS ID, u.name AS Name, a.city AS State
FROM users u
         LEFT JOIN addresses a ON u.id = a.user_id
WHERE u.created_at = (SELECT MAX(u2.created_at)
                      FROM users u2
                               LEFT JOIN addresses a2 ON u2.id = a2.user_id
                      WHERE a2.city = a.city);
-- i took help in 6th query

-- 7. List all female users with their city and sorted by salary descending.
SELECT u.name as Name, u.gender as Gender, a.city as City
from users u
         Join addresses a on u.id = a.user_id
ORDER BY u.salary DESC;

-- 8. Find users who do NOT have any address.
SELECT u.name as Name
FROM users as u
         LEFT JOIN addresses a on u.id = a.user_id
WHERE a.user_id != u.id;

-- 9. List users whose pincode starts with '11'.
SELECT u.name as Name, a.pincode as Pincode
from users u
         JOIN addresses a on u.id = a.user_id
WHERE a.pincode = '11%';

-- 10. Show total salary sum per city.
SELECT SUM(u.salary) as Salary, a.city as City
from users as u
         JOIN addresses a on u.id = a.user_id
GROUP BY a.city;

-- 11. Show users whose city name and gender both contain specific letters.
SELECT u.name as Name, u.gender as Gender, a.state as State
FROM users u
         JOIN addresses a on u.id = a.user_id
WHERE u.gender = '%m%'
  AND a.state = '%m%';

-- 12. Find users from Maharashtra earning above average salary.
SELECT u.name as Users, u.salary as Earnings
FROM users as u
         JOIN addresses a on u.id = a.user_id
WHERE u.salary > (SELECT AVG(salary) from users)
  AND a.state = 'Maharashtra';
SELECT u.name, u.salary
FROM users u
         JOIN addresses a ON u.id = a.user_id
WHERE u.salary > (SELECT AVG(salary) FROM users)
  AND a.state = 'Maharashtra';


-- 13. Show addresses for users born after the year 2000.
SELECT u.name as Users, a.address_line as Address
FROM users as u
         JOIN addresses a on u.id = a.user_id
WHERE YEAR(u.created_at) > 2000;

-- 14. List users and addresses where the state equals the city name’s state logic
SELECT u.name Users, a.address_line Address
FROM users u
         JOIN addresses a on u.id = a.user_id
WHERE a.city = a.state;

-- 15. Get the top 5 highest-paid users with their address.
SELECT u.name Users, a.address_line Address
FROM users u
         JOIN addresses a on u.id = a.user_id
ORDER BY u.salary DESC
LIMIT 5;

SHOW FUNCTION STATUS;
SHOW PLUGINS;

-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx --
CREATE TABLE if not exists adminuser
(
    id         INT AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(100)        NOT NULL,
    email      VARCHAR(100) UNIQUE NOT NULL,
    role       VARCHAR(50)         NOT NULL DEFAULT 'Admin',
    created_at TIMESTAMP                    DEFAULT CURRENT_TIMESTAMP
);

# DROP table adminuser;

SELECT name, email, 'Admin' as role
from adminuser
UNION
SELECT name, email, 'User' as role
from users;

ALTER TABLE users
    ADD COLUMN referred_id INT;

SELECT *
from users;

UPDATE users
SET referred_id = CASE
                      WHEN id % 2 = 0 THEN 2 -- Even IDs → 2
                      WHEN id % 2 = 1 THEN 1 -- Odd IDs → 1
                      ELSE referred_id -- No change
    END;

SELECT u.name as User_Name, u2.name as Referred_Name, u2.id as Referred_Names_ID, u.id as Referred_By_
from users u
         INNER JOIN users u2
where u2.referred_id = u.id;

SHOW INDEXES FROM users;
SHOW KEYS from users;

SHOW binary logs;
SHOW MASTER STATUS;
START SLAVE;

SELECT MAX(salary)
from users;
SELECT MAX(DISTINCT salary) as SecondHighestSalary
FROM users
WHERE salary < (SELECT MAX(salary) from users);

SELECT id, name, gender
from users
where salary > (SELECT AVG(salary) from users);

DELIMITER ?
CREATE PROCEDURE starter(IN any_state VARCHAR(255))
BEGIN
    USE Practice; -- use Practice in case if DB is not selected

    SELECT u.id           AS ID,
           u.name         AS Name,
           u.gender       AS Gender,
           a.address_line AS Address,
           a.city         AS City,
           a.state        AS State
    FROM users u
             JOIN addresses a ON u.id = a.user_id
    WHERE a.state = any_state
    GROUP BY u.id, u.name, u.gender, a.address_line, a.city, a.state;
END ?
DELIMITER ;


