# Hotel-booking-Analysis

## Project Overview
This project analyzes hotel booking data to answer key business questions raised by stakeholders. Using SQL for data preparation and Power BI for visualization, the project explores revenue trends, seasonality, and parking demand to provide data-driven insights and recommendations. The business questions are as follow;
- Is our hotel revenue growing per year, and the revenue should be segmented by hotel type?
- Considering guest with personal car, should increasing parking lot be considered?
- Show a trend with focus on average daily rate and hotel to explore seasonality

## Data Source
The dataset was sourced from kaggle website and downloaded as CSV file. It consists of five tables with `hotel_revenue_historical_2018`, `hotel_revenue_historical_2019` and `hotel_revenue_historical_2020` having same number of columns (32) and schemas, with 21996, 79264, 40687 as number of rows respectively. The `meal_cost` and `market_segement` tables have 2 columns each and 5, 8 as number of rows respectively.

## Tools
- MySQL – Database creation and table joins
- Power BI – Data modeling, DAX measures, dashboard development, and visualization

## Data Preparation
- The dataset was downloaded to local storage and then imported into MySQL after a database and table had been created.
```sql
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

```

- The  `hotel_revenue_historical_2018`, `hotel_revenue_historical_2019` and `hotel_revenue_historical_2020` tables were imported into MySQL server using LOCAL DATA LOCAL INFILE while `meal_cost` and `market_segment` tables were imported using MySQL Workbench's Table Data Import Wizard. This method of importation was chosen over others because the dataset has large number of rows and this method supports easy importation of large dataset.
- The UNION operator was used to combine the three yearly hotel booking tables into a single dataset. The combined dataset was wrapped in a Common Table Expression (CTE) and joined to the `meal_cost` and `market_segment` tables using LEFT JOIN..

```Sql
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
```

- The query was thereafter copied and exported to Power BI for further analysis and visualization.

## Data Analysis
- A calculated revenue field was created using the Power query Editor inside Power BI

<img width="662" height="278" alt="Capture 11" src="https://github.com/user-attachments/assets/c0910a84-8c4a-4b2b-a212-6c7250f69eea" />

- DAX measures were created for `total_nights`, `parking_request_rate`, `growth_rate`, `total_revenue` and `previous_revenue`


    <img width="609" height="67" alt="Capture totla nyt" src="https://github.com/user-attachments/assets/ad0465d3-3cc3-430d-8e40-2ccda33b214f" />

   <img width="559" height="79" alt="Capture parking" src="https://github.com/user-attachments/assets/e44445ef-79be-492e-b997-fe61b2444209" />

   <img width="600" height="73" alt="Capture growth" src="https://github.com/user-attachments/assets/ab8e8ad7-f29f-4def-8b00-815850743235" />

   <img width="262" height="63" alt="Capture total revenue" src="https://github.com/user-attachments/assets/9e70036e-0b0d-4e32-9ddc-a590525c57b5" />

   <img width="596" height="68" alt="Capture previous" src="https://github.com/user-attachments/assets/1af90e19-b1d5-4c4e-a0e8-cc7fca2fcb25" />

- Analysis was carried out to compare revenue, growth rate and Hotel types across years and Quarters.

<img width="858" height="449" alt="Capture" src="https://github.com/user-attachments/assets/f4cc0051-8de9-4001-be10-f373b6f6086b" />

A trend analysis to show revenue by hotel type across the years

<img width="849" height="179" alt="Capture" src="https://github.com/user-attachments/assets/0a59acbd-0235-4867-9554-aaf59150f929" />

A matrix visual was used to display the parking_request_rate, showing very low demand for parking space.
<img width="452" height="160" alt="Capture" src="https://github.com/user-attachments/assets/9bfa3873-fb09-4b18-b990-f21865f6c414" />

## Key Findings
- Quarter 4 data for 2020 was unavailable. To ensure a fair comparison, annual revenue growth rate was calculated using only Quarter 1 - Quarter 3 data across all years. Revenue increased from $844,423 in 2018 to $4,263,638 in 2019 (405% growth) before declining by 18% to $3,512,222 in 2020. Despite the decline, 2020 revenue remained 315% higher than the 2018 baseline.
- At Resort Hotel, only Quarter 3 has consistently exceeded $500000 revenue across all the years and also the Quarter with the highest revenue across all Hotel types with an average of $1,376,334 per year.
- At Resort Hotel, there was same significant percentage drop in revenue (67%) between Quarter 3 and Quarter 4 across the years.
- For most of the times across the years, revenue increases progressively from the beginning of the year to Quarter 3 before starting to decline toward the end of the year. 
-  With the overall percentage of parking request rate at 2.36% and none of the parking request rate across hotels and years exceeded 5%, indicating no much demand for parking space relative to total night. Therefore, there is no need for increasing or expanding parking lot. 

## Recommendations
- Maximize revenue during Quarter 3 (Peak season) by implementing dynamic pricing and engage in promotional campaigns and marketing before the start of Quarter 3 to drive early bookings. Ensure adequate staffing and operational readiness to maintain service quality.
- Introduce off-season promotions, seasonal discounts, corporate packages, and tourism partnerships to reduce the sharp decline in Quarter 4 revenue.
- An investigation should be carried out on 2020 revenue decline. Management should examine booking cancellations, customer behaviour changes and external factors that might have caused the drop in revenue.
- Maintain current parking capacity and focus should be shifted to ensuring quality service and customer satisfaction.
- Complete data should be ensured to improve the accuracy of growth assessment and reliable planning.

## Limitation
- The absence of Quarter 4 data for 2020 limits the accuracy of year-over-year growth comparisons and reduces the completeness of seasonal trend analysis.
