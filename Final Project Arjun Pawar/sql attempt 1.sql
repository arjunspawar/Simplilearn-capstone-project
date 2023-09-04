# US Airlines Analysis

create database us_airlines;
use us_airlines;

create table airports(
  ident varchar(10) primary key,	
  type	varchar(25),
  name	varchar(50),
  latitude	DECIMAL(8,5),
  longitude	DECIMAL(8,5),
  elevation	float,
  scheduled_service	boolean,
  iata_code	varchar(10)
  );

select * from us_airlines.airlines;

select * from us_airlines.airports; 
select count(*) from us_airlines.airports; 
desc us_airlines.airports;

select * from us_airlines.runways;
select count(*) from us_airlines.master_dataset;
select * from us_airlines.master_dataset;

# 1. Determine the number of flights that are delayed on various days of the week.
select DayOfWeek,count(Airline) as number_of_delayed_flights
from us_airlines.airlines
where Delay=1
GROUP BY DayOfWeek
ORDER BY DayOfWeek; 

# 2. Find the number of delayed flights for different airlines
select Airline, count(delay) as number_of_delayed_flights
from us_airlines.airlines
where Delay=1
GROUP BY Airline
ORDER BY number_of_delayed_flights Desc; 

# 3. Determine how many delayed flights land at airports with at least 10 runways.
SELECT AirportTo, COUNT(*) AS count_of_delay, MAX(runway_count_dest_airport) AS runway_count
FROM us_airlines.master_dataset
WHERE runway_count_dest_airport > 10 AND Delay = 1
GROUP BY AirportTo;

# 4. Compare the number of delayed flights at airports higher than average elevation and those that are lower
#    than average elevation for both source and destination airports.

SELECT elevation_ft_source_airport, elevation_ft_dest_airport,COUNT(id) as num_delayed_flights
FROM us_airlines.master_dataset
WHERE elevation_ft_source_airport > (select avg(elevation_ft_source_airport) from us_airlines.master_dataset)
AND elevation_ft_dest_airport > (select avg(elevation_ft_dest_airport) from us_airlines.master_dataset)
GROUP BY elevation_ft_source_airport, elevation_ft_dest_airport
UNION
SELECT elevation_ft_source_airport, elevation_ft_dest_airport, COUNT(id) as num_delayed_flights
FROM us_airlines.master_dataset
WHERE elevation_ft_source_airport < (select avg(elevation_ft_source_airport) from us_airlines.master_dataset)
AND elevation_ft_dest_airport < (select avg(elevation_ft_dest_airport) from us_airlines.master_dataset)
GROUP BY elevation_ft_source_airport, elevation_ft_dest_airport;

select avg(elevation_ft_source_airport),COUNT(id) as num_delayed_flights
from us_airlines.master_dataset
where delay=1 and elevation_ft_source_airport < (select avg(elevation_ft_source_airport) 
                                                 from us_airlines.master_dataset);

