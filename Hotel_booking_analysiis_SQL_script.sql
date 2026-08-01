CREATE DATABASE project1;
USE project1;

-- CREATION OF TABLE AND IMPORTATION OF HOTEL2018 DATASET
CREATE TABLE hotel2018 (
    hotel VARCHAR(20),
    is_canceled INT,
    lead_time INT,
    arrival_date_year INT,
    arrival_date_month VARCHAR(20),
    arrival_date_week_number INT,
    arrival_date_day_of_month INT,
    stays_in_weekend_nights INT,
    stays_in_week_nights INT,
    adults INT,
    children INT,
    babies INT,
    meal VARCHAR(20),
    country VARCHAR(10),
    market_segment VARCHAR(30),
    distribution_channel VARCHAR(30),
    is_repeated_guest INT,
    previous_cancellations INT,
    previous_bookings_not_canceled INT,
    reserved_room_type VARCHAR(10),
    assigned_room_type VARCHAR(10),
    booking_changes INT,
    deposit_type VARCHAR(30),
    agent VARCHAR(20),
    company VARCHAR(20),
    days_in_waiting_list INT,
    customer_type VARCHAR(30),
    adr DECIMAL(10,2),
    required_car_parking_spaces INT,
    total_of_special_requests INT,
    reservation_status VARCHAR(20),
    reservation_status_date VARCHAR(20)
);

SELECT * FROM hotel2018;

LOAD DATA LOCAL INFILE "C:\Users\paragon\Downloads\hotel_revenue_historical_full-2 - 2018.csv"
INTO TABLE hotel2018 FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n' IGNORE 1 ROWS;


-- CREATION OF TABLE AND IMPORTATION OF HOTEL2019 DATASET
CREATE TABLE hotel2019 (
    hotel VARCHAR(20),
    is_canceled INT,
    lead_time INT,
    arrival_date_year INT,
    arrival_date_month VARCHAR(20),
    arrival_date_week_number INT,
    arrival_date_day_of_month INT,
    stays_in_weekend_nights INT,
    stays_in_week_nights INT,
    adults INT,
    children INT,
    babies INT,
    meal VARCHAR(20),
    country VARCHAR(10),
    market_segment VARCHAR(30),
    distribution_channel VARCHAR(30),
    is_repeated_guest INT,
    previous_cancellations INT,
    previous_bookings_not_canceled INT,
    reserved_room_type VARCHAR(10),
    assigned_room_type VARCHAR(10),
    booking_changes INT,
    deposit_type VARCHAR(30),
    agent VARCHAR(20),
    company VARCHAR(20),
    days_in_waiting_list INT,
    customer_type VARCHAR(30),
    adr DECIMAL(10,2),
    required_car_parking_spaces INT,
    total_of_special_requests INT,
    reservation_status VARCHAR(20),
    reservation_status_date VARCHAR(20)
);

SELECT * FROM hotel2019;

LOAD DATA LOCAL INFILE "C:\Users\paragon\Downloads\hotel_revenue_historical_full-2 - 2019.csv"
INTO TABLE hotel2019 FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n' IGNORE 1 ROWS; 


-- CREATION OF TABLE AND IMPORTATION OF HOTEL2018 DATASET
CREATE TABLE hotel2020 (
    hotel VARCHAR(20),
    is_canceled INT,
    lead_time INT,
    arrival_date_year INT,
    arrival_date_month VARCHAR(20),
    arrival_date_week_number INT,
    arrival_date_day_of_month INT,
    stays_in_weekend_nights INT,
    stays_in_week_nights INT,
    adults INT,
    children INT,
    babies INT,
    meal VARCHAR(20),
    country VARCHAR(10),
    market_segment VARCHAR(30),
    distribution_channel VARCHAR(30),
    is_repeated_guest INT,
    previous_cancellations INT,
    previous_bookings_not_canceled INT,
    reserved_room_type VARCHAR(10),
    assigned_room_type VARCHAR(10),
    booking_changes INT,
    deposit_type VARCHAR(30),
    agent VARCHAR(20),
    company VARCHAR(20),
    days_in_waiting_list INT,
    customer_type VARCHAR(30),
    adr DECIMAL(10,2),
    required_car_parking_spaces INT,
    total_of_special_requests INT,
    reservation_status VARCHAR(20),
    reservation_status_date VARCHAR(20)
);

SELECT COUNT* FROM hotel2020;

LOAD DATA LOCAL INFILE "C:\Users\paragon\Downloads\hotel_revenue_historical_full-2 - 2020.csv"
INTO TABLE hotel2020 FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n' IGNORE 1 ROWS;


-- CREATION OF MEAL COST AND MARKET SEGEMENT TABLES

CREATE TABLE meal_cost (cost INT, meal VARCHAR(20));

CREATE TABLE market_segment (discount DOUBLE, market_segment VARCHAR(20));

-- MERGED 2018,2019,2020 DATASET PLUS JOINED OTHER TABLES AND CREATED A REVENUE COLUMN
WITH hotels AS (
SELECT * FROM hotel2018
UNION
SELECT * FROM hotel2019
UNION
SELECT * FROM hotel2020)

SELECT * FROM hotels
LEFT JOIN market_segment
ON hotels.market_segment = market_segment.market_segment
LEFT JOIN meal_cost
ON hotels.meal = meal_cost.meal;


