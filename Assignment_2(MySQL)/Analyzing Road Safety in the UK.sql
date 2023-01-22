Create database if not exists fsda;
use fsda;

-- Create table for Accident.csv data
CREATE TABLE IF NOT EXISTS `Accidents_2015` (
	`Accident_Index` VARCHAR(13) NOT NULL, 
	`Location_Easting_OSGR` int(50), 
	`Location_Northing_OSGR` DECIMAL(38, 0), 
	`Longitude` DECIMAL(38, 6), 
	`Latitude` DECIMAL(38, 6), 
	`Police_Force` DECIMAL(38, 0) NOT NULL, 
	`Accident_Severity` DECIMAL(38, 0) NOT NULL, 
	`Number_of_Vehicles` DECIMAL(38, 0) NOT NULL, 
	`Number_of_Casualties` DECIMAL(38, 0) NOT NULL, 
	`Date` VARCHAR(10) NOT NULL, 
	`Day_of_Week` DECIMAL(38, 0) NOT NULL, 
	`Time` TIME, 
	`Local_Authority_(District)` DECIMAL(38, 0) NOT NULL, 
	`Local_Authority_(Highway)` VARCHAR(9) NOT NULL, 
	`1st_Road_Class` DECIMAL(38, 0) NOT NULL, 
	`1st_Road_Number` DECIMAL(38, 0) NOT NULL, 
	`Road_Type` DECIMAL(38, 0) NOT NULL, 
	`Speed_limit` DECIMAL(38, 0) NOT NULL, 
	`Junction_Detail` DECIMAL(38, 0) NOT NULL, 
	`Junction_Control` DECIMAL(38, 0) NOT NULL, 
	`2nd_Road_Class` DECIMAL(38, 0) NOT NULL, 
	`2nd_Road_Number` DECIMAL(38, 0) NOT NULL, 
	`Pedestrian_Crossing-Human_Control` DECIMAL(38, 0) NOT NULL, 
	`Pedestrian_Crossing-Physical_Facilities` DECIMAL(38, 0) NOT NULL, 
	`Light_Conditions` DECIMAL(38, 0) NOT NULL, 
	`Weather_Conditions` DECIMAL(38, 0) NOT NULL, 
	`Road_Surface_Conditions` DECIMAL(38, 0) NOT NULL, 
	`Special_Conditions_at_Site` DECIMAL(38, 0) NOT NULL, 
	`Carriageway_Hazards` DECIMAL(38, 0) NOT NULL, 
	`Urban_or_Rural_Area` DECIMAL(38, 0) NOT NULL, 
	`Did_Police_Officer_Attend_Scene_of_Accident` DECIMAL(38, 0) NOT NULL, 
	`LSOA_of_Accident_Location` VARCHAR(9)
);

-- Create table for Vehicles_2015.csv data
CREATE TABLE IF NOT EXISTS `Vehicles_2015` (
	`Accident_Index` VARCHAR(13) NOT NULL, 
	`Vehicle_Reference` DECIMAL(38, 0) NOT NULL, 
	`Vehicle_Type` DECIMAL(38, 0) NOT NULL, 
	`Towing_and_Articulation` DECIMAL(38, 0) NOT NULL, 
	`Vehicle_Manoeuvre` DECIMAL(38, 0) NOT NULL, 
	`Vehicle_Location-Restricted_Lane` DECIMAL(38, 0) NOT NULL, 
	`Junction_Location` DECIMAL(38, 0) NOT NULL, 
	`Skidding_and_Overturning` DECIMAL(38, 0) NOT NULL, 
	`Hit_Object_in_Carriageway` DECIMAL(38, 0) NOT NULL, 
	`Vehicle_Leaving_Carriageway` DECIMAL(38, 0) NOT NULL, 
	`Hit_Object_off_Carriageway` DECIMAL(38, 0) NOT NULL, 
	`1st_Point_of_Impact` DECIMAL(38, 0) NOT NULL, 
	`Was_Vehicle_Left_Hand_Drive?` DECIMAL(38, 0) NOT NULL, 
	`Journey_Purpose_of_Driver` DECIMAL(38, 0) NOT NULL, 
	`Sex_of_Driver` DECIMAL(38, 0) NOT NULL, 
	`Age_of_Driver` DECIMAL(38, 0) NOT NULL, 
	`Age_Band_of_Driver` DECIMAL(38, 0) NOT NULL, 
	`Engine_Capacity_(CC)` DECIMAL(38, 0) NOT NULL, 
	`Propulsion_Code` DECIMAL(38, 0) NOT NULL, 
	`Age_of_Vehicle` DECIMAL(38, 0) NOT NULL, 
	`Driver_IMD_Decile` DECIMAL(38, 0) NOT NULL, 
	`Driver_Home_Area_Type` DECIMAL(38, 0) NOT NULL, 
	`Vehicle_IMD_Decile` DECIMAL(38, 0) NOT NULL
);

-- Create table for Vehicles_TYPES.csv data
CREATE TABLE IF NOT EXISTS vehicle_types (
	code DECIMAL(38, 0) NOT NULL, 
	label VARCHAR(37) NOT NULL
);

-- LOAD DATA INTO ACCIDENT_2015 TABLE
Load data infile
'C:\\Users\\Dell\\OneDrive\\Desktop\\FSDA\\FSDA_SQL_Assignment-2\\Database Clinics - MySQL\\02.UK Road Safty Accidents 2015\\datasets\\Accidents_2015.csv'
into table ACCIDENTS_2015
FIELDS TERMINATED by ','
Enclosed by '"'
lines terminated by '\n'
IGNORE 1 ROWS;

Select count(*) from accidents_2015;

-- LOAD DATA INTO VEHICLES_2015 TABLE
Load data infile
'C:\\Users\\Dell\\OneDrive\\Desktop\\FSDA\\FSDA_SQL_Assignment-2\\Database Clinics - MySQL\\02.UK Road Safty Accidents 2015\\datasets\\Vehicles_2015.csv'
into table VEHICLES_2015
FIELDS TERMINATED by ','
Enclosed by '"'
lines terminated by '\n'
IGNORE 1 ROWS;

Select count(*) from VEHICLES_2015;

-- LOAD DATA INTO VEHICLE_TYPES TABLE
Load data infile
'C:\\Users\\Dell\\OneDrive\\Desktop\\FSDA\\FSDA_SQL_Assignment-2\\Database Clinics - MySQL\\02.UK Road Safty Accidents 2015\\datasets\\Vehicle_types.csv'
into table VEHICLE_TYPES
FIELDS TERMINATED by ','
Enclosed by '"'
lines terminated by '\n'
IGNORE 1 ROWS;

Select * from VEHICLE_TYPES;

-- Use aggregate functions in SQL and Python to answer the following sample questions:
--  1. Evaluate the median severity value of accidents caused by various Motorcycles.
--  2. Evaluate Accident Severity and Total Accidents per Vehicle Type
--  3. Calculate the Average Severity by vehicle type.
--  4. Calculate the Average Severity and Total Accidents by Motorcycle.

--  1. Evaluate the median severity value of accidents caused by various Motorcycles.

Select * from accidents_2015 limit 10;
Select * from VEHICLES_2015 limit 10;
Select * from VEHICLE_TYPES limit 10;

SELECT VT.LABEL AS `VEHICLE_TYPE`, avg(A.ACCIDENT_SEVERITY) AS `MEDIAN_SEVERITY`
FROM ACCIDENTS_2015 A
JOIN VEHICLES_2015 V ON A.ACCIDENT_INDEX = V.ACCIDENT_INDEX
JOIN VEHICLE_TYPES VT ON V.VEHICLE_TYPE = VT.`CODE`
group by 1
ORDER by 2;

--  2. Evaluate Accident Severity and Total Accidents per Vehicle Type
SELECT vt.LABEL AS 'Vehicle Type', a.accident_severity AS 'Severity', COUNT(vt.LABEL) AS 'Number of Accidents'
FROM Accidents_2015 a
JOIN Vehicles_2015 v ON a.accident_index = v.accident_index
JOIN vehicle_types vt ON v.vehicle_type = vt.`code`
GROUP BY 1
ORDER BY 2,3;

--  3. Calculate the Average Severity by vehicle type.
SELECT vt.label AS 'Vehicle Type', AVG(a.accident_severity) AS 'Average Severity', COUNT(vt.label) AS 'Number of Accidents'
FROM accidents_2015 a
INNER JOIN vehicles_2015 v ON a.accident_index = v.accident_index
INNER JOIN vehicle_types vt ON v.vehicle_type = vt.`code`
GROUP BY 1
ORDER BY 2,3;

--  4. Calculate the Average Severity and Total Accidents by Motorcycle.

SELECT vt.LABEL AS 'Vehicle Type', AVG(a.accident_severity) AS 'Average Severity', COUNT(vt.LABEL) AS 'Number of Accidents'
FROM Accidents_2015 a
JOIN Vehicles_2015 v ON a.accident_index = v.accident_index
JOIN vehicle_types vt ON v.vehicle_type = vt.`CODE`
WHERE vt.LABEL LIKE '%otorcycle%'
GROUP BY 1
ORDER BY 2,3;