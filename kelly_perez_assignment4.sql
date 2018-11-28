-- QUESTION 1
DROP DATABASE scheduling;
CREATE DATABASE IF NOT EXISTS scheduling;
USE scheduling;
-- QUESTION 2
CREATE TABLE person (
person_id SMALLINT NOT NULL auto_increment,
first_name VARCHAR(30),
last_name VARCHAR(30),
CONSTRAINT pk_person_id
PRIMARY KEY(person_id)
);
-- QUESTION 3
CREATE TABLE building(
building_id SMALLINT NOT NULL auto_increment,
building_name VARCHAR(30),
CONSTRAINT pk_building_id
PRIMARY KEY(building_id)
);
-- QUESTION 4
CREATE TABLE room(
room_id SMALLINT NOT NULL auto_increment,
room_number SMALLINT,
building_id SMALLINT,
capacity INT,
CONSTRAINT pk_room_id
PRIMARY KEY(room_id)/*,
-- FOREIGN KEY(building_id)
-- REFERENCES building(building_id)*/ -- there was an error w foreign key
);
-- QUESTION 5
CREATE TABLE meeting(
meeting_id SMALLINT NOT NULL auto_increment,
meeting_start DATETIME,
meeting_end DATETIME,
room_id SMALLINT,
CONSTRAINT pk_meeting_id
PRIMARY KEY(meeting_id),
FOREIGN KEY(room_id)
REFERENCES room(room_id)
);
-- Question 6
CREATE TABLE person_meeting(
person_id SMALLINT,
meeting_id SMALLINT,
FOREIGN KEY (person_id)
REFERENCES person(person_id),
FOREIGN KEY(meeting_id)
REFERENCES meeting(meeting_id)
);
-- QUESTION 7 
INSERT INTO person(first_name, last_name) VALUES
('Tom', 'Hanks'),
('Anne', 'Hathaway'),
('Tom', 'Cruise'),
('Meryl', 'Streep'),
('Chris', 'Pratt'),
('Halle', 'Berry'),
('Robert', 'De Niro'),
('Julia', 'Roberts'),
('Denzel', 'Washington'),
('Melissa', 'McCarthy');
-- QUESTION 8
ALTER TABLE building
ADD building_type VARCHAR(30);

INSERT INTO building(building_type, building_name) VALUES
('Headquarters', 'Main Street Building');												
-- QUESTION 9
INSERT INTO room(room_number, building_id, capacity) VALUES
('100','1','5'),
('200','1' ,'4'),
('300','1','10'),
('10','2','4'),
('20','2','4');
-- QUESTION 10
INSERT INTO meeting(room_id, meeting_start, meeting_end) VALUES
('1', '2016-12-25 09:00:00', '2016-12-25 10:00:00'),
('1', '2016-12-25 10:00:00', '2016-12-25 12:00:00'),
('1', '2016-12-25 11:00:00', '2016-12-25 12:00:00'),
('2', '2016-12-25 09:00:00', '2016-12-25 10:00:00'),
('4', '2016-12-25 09:00:00', '2016-12-25 10:00:00'),
('5', '2016-12-25 14:00:00', '2016-12-25 16:00:00');
-- Question 11
INSERT INTO person_meeting(person_id, meeting_id) VALUES
('1', '1'),
('10','1'),
('1', '2'),
('2', '2'),
('3', '2'),
('4', '2'),
('5', '2'),
('6', '2'),
('7', '2'),
('8', '2'),
('9', '3'),
('10','3'),
('1', '4'),
('2', '4'),
('8', '5'),
('9', '5'),
('1', '6'),
('2', '6'),
('3', '6');
-- Question 12

SELECT
p.first_name AS "Person's first name",
p.last_name AS "Person's last name",
b.building_name AS "Building's name",
r.room_number AS "Room number",
m.meeting_start AS " Meeting start datetime",
m.meeting_end AS "Meeting end datetime" 
FROM meeting m, person p, building b, room r 
WHERE first_name = 'Tom' AND last_name = 'Hanks';
-- QUestion 13 Find all the people that are attending meeting ID 2
SELECT
p.first_name AS "Person's first name",
p.last_name AS "Person's last name",
b.building_name AS "Building's name",
r.room_number AS "Room number",
m.meeting_start AS " Meeting start datetime",
m.meeting_end AS "Meeting end datetime",
pm.meeting_id AS  "Person meeting ID"
FROM Person_meeting pm, meeting m, building b, room r, person p
WHERE pm.meeting_id = 2;
-- Question 14 
SELECT
p.first_name AS "Person's first name",
p.last_name AS "Person's last name",
b.building_name AS "Building's name",
r.room_number AS "Room number",
m.meeting_start AS " Meeting start datetime",
m.meeting_end AS "Meeting end datetime",
m.meeting_id AS  "Meeting ID"
FROM  meeting m, building b, room r, person p
WHERE b.building_name = 'Main Street Building';
-- Question 15
SELECT
meeting_id AS " Meeting ID",
SUM(capacity) AS Attendees 
FROM room r,meeting m
WHERE r.room_id = m.room_id 
GROUP BY meeting_id;
-- Question16 
SELECT
first_name AS "Person's first name",
last_name AS "Person's last name",
meeting_id AS  "Meeting ID",
meeting_start AS " Meeting start datetime",
meeting_end AS "Meeting end datetime"
FROM person_meeting intersection JOIN person
INNER JOIN meeting 
USING(meeting_id)
WHERE meeting_start <= '2016-12-25 12:00:00';