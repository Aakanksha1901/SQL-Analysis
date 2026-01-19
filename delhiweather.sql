use delhiweather;
select * from raw_weather_aqi;

-- Show temperature, humidity, and AQI for each location and hour.
select a.location , a.time_ist , l.temp_c ,l.humidity , a.aqi_index
from delhiweather_aqi a
inner join delhi_weather_location l
on a.location = l.location;

-- Find the average AQI and average temperature per location per day.
select a.location , a.date_ist , avg(l.temp_c) as AvgTemperature , avg(a.aqi_index)
from delhiweather_aqi a
inner join delhi_weather_location l
on a.location = l.location
group by a.location , a.date_ist;


-- List weather conditions (condition_text) during high pollution events (AQI > 250).
select distinct condition_text as conditions  from delhiweather_aqi where aqi_index > 250;

-- Compare average AQI on clear vs cloudy days.
select condition_text as conditions ,avg(aqi_index) as avgAQI from delhiweather_aqi
where condition_text IN('Clear sky', 'Partly Cloudy')
group by condition_text;

-- Find locations where high wind speed (>15 kph) corresponds to lower AQI.
select l.location  , avg(a.aqi_index) as avgAQI
from delhi_weather_location l
inner join delhiweather_aqi a
on l.location = a.location
where l.windspeed_kph > 15
group by l.location
having avg(a.aqi_index) < (
      select avg(aqi_index)
      from delhiweather_aqi
	);
    

-- Aggregation & Comparison
-- Identify the most polluted location based on average AQI.
select location as Location , avg(aqi_index) as AvgAQI
from delhiweather_aqi
group by location
having avg(aqi_index) > (
      select avg(aqi_index)
      from delhiweather_aqi
);
    
-- Find the least polluted location based on average AQI.
SELECT 
    location,
    AVG(aqi_index) AS AvgAQI
FROM delhiweather_aqi
GROUP BY location
having avg(aqi_index) < (
      select avg(aqi_index)
      from delhiweather_aqi
      ) ;

-- Rank locations by average PM2.5 concentration.
select location , 
        avg(pm2_5) as averagePM2_5 ,
        Row_Number() OVER (ORDER BY AVG(pm2_5) desc) as Rank_pm25
from delhiweather_pm10
group by location;

-- Determine which location has the highest AQI variability.
select location ,
	   max(aqi_index) - min(aqi_index) as AQI_variability
from delhiweather_aqi
group by location
order by AQI_variability desc;
 
-- Find locations where average AQI is above the city-wide average (subquery).
select location , avg(aqi_index) AS avgAQi
from delhiweather_aqi
group by location
having avg(aqi_index) >
(select avg(aqi_index) from delhiweather_aqi) ;

--  Time-Series Logic
-- 	Find hour-wise average AQI (0–23).
select time_ist , avg(aqi_index) as AvgAQI
from delhiweather_aqi
GROUP BY time_ist;

-- Find hours where AQI was higher than the daily average AQI (subquery).
SELECT time_ist , avg(aqi_index) as AQI
from delhiweather_aqi 
group by time_ist
having avg(aqi_index) >
(SELECT AVG(aqi_index) from delhiweather_aqi) ;


-- Find the worst AQI hour for each location.
SELECT location , max(aqi_index) as worst_aqi
FROM delhiweather_aqi
GROUP BY location;
