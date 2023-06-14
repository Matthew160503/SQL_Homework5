DROP DATABASE IF EXISTS gb_homework5;
CREATE DATABASE IF NOT EXISTS gb_homework5;
USE gb_homework5;

CREATE TABLE IF NOT EXISTS Cars
(
	Id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Car_name VARCHAR(30) NOT NULL,
    Cost INT NOT NULL
);

INSERT Cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);

SELECT * FROM Cars;

-- 1. Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов
DROP VIEW IF EXISTS low_cost_cars;
CREATE VIEW low_cost_cars(id, car, cost)
	AS SELECT *
		FROM Cars
	WHERE Cost < 25000;

SELECT * FROM low_cost_cars;

-- Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов 
ALTER VIEW low_cost_cars
	AS SELECT *
			FROM Cars
		WHERE Cost < 30000;

SELECT * FROM low_cost_cars;

-- Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”
DROP VIEW IF EXISTS only_audi_skoda;
CREATE VIEW only_audi_skoda(id, car, cost)
	AS SELECT *
			FROM Cars
		WHERE Car_name = 'Audi' or Car_name = 'Skoda';

SELECT * FROM only_audi_skoda;	

-- ЗАДАНИЕ 2, связанное со временем

CREATE TABLE IF NOT EXISTS Stations
(
	traind_id INT NOT NULL,
    station VARCHAR(40),
    station_time TIME
);

INSERT Stations
VALUES
		(110, 'San Francisco', '10:00:00'),
        (110, 'Redwood City', '10:54:00'),
        (110, 'Palo Alto', '11:02:00'),
        (110, 'San Jose', '12:35:00'),
        (120, 'San Francisco', '11:00:00'),
        (120, 'Palo Alto', '12:49:00'),
        (120, 'San Jose', '13:30:00');

SELECT * FROM Stations;

SELECT
	*,
	subtime(LEAD(station_time,1,station_time) OVER (PARTITION BY traind_id ORDER BY station_time), station_time) AS time_to_next_station
	FROM Stations;
