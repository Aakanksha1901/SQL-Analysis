create database phising;
use phising;

select * from phishing_url;

-- Display all URLs marked as phishing.
select * from phishing_url where label = 1 ;

-- Count the total number of URLs in the dataset.
select count(*) as Total_urls from phishing_url;

-- Find how many URLs belong to each source.
select source, count(*) as Total_urls from phishing_url 
group by source;

-- Count phishing and legitimate URLs separately.
SELECT
    SUM(CASE WHEN label = 1 THEN 1 ELSE 0 END) AS phishing_count ,
    SUM(CASE WHEN label = 0 THEN 1 ELSE 0 END) AS legitimate_count
from phishing_url;

-- List all distinct sources.
select distinct source from phishing_url;

-- Find the percentage of phishing URLs in the dataset.
select    
     round(avg(label) * 100, 2) as Phishing_Percentage
     from phishing_url;


-- Show the top 10 longest URLs.
select url , LENGTH(url) as url_length
from phishing_url
ORDER BY url_length DESC
LIMIT 10;


-- Find URLs that use an IP address instead of a domain.

-- Count URLs that start with https.
select count(*) as https_urlcount
from phishing_url 
where url like 'https%' ;

-- Find the number of URLs per source ordered by count (descending).
select source , count(*) as Total_url
from phishing_url
group by source
order by total_url desc;

-- Find the number of phishing URLs per source.
select source , 
	   SUM(CASE WHEN label = 1 THEN 1 ELSE 0 END) as Phishing_count
from phishing_url
group by source
order by Phishing_count;

-- show sources that have more phishing URLs than legitimate URLs.
SELECT source FROM phishing_url
GROUP BY source 
HAVING
SUM(CASE WHEN label = 1 THEN 1 ELSE 0 END) >
SUM(CASE WHEN label = 0 THEN 1 ELSE 0 END) ;

-- Calculate the phishing rate (percentage) per source.
select source ,
	   ROUND(AVG(label) * 100 , 2) as phishing_percentage
FROM phishing_url
GROUP BY source ;


-- Find the average URL length for phishing vs legitimate URLs.
SELECT
CASE 
  WHEN label = 1 THEN 'Phishing'
        ELSE 'Legitimate'
    END AS url_type,
    AVG(LENGTH(url)) AS average_url_length
FROM phishing_url
GROUP BY label;

-- Display the top 5 most common domain extensions (.com, .net, etc.).
-- select url as most_common_domains from phishing_url
-- where url
-- like '%'

-- Find sources where total URLs exceed the overall average URL count per source.

-- Identify URLs whose length is greater than the average URL length.

-- Show the percentage contribution of each source to total URLs.
select source, 
	   ROUND(count(*)*100/ (SELECT COUNT(*) from phishing_url), 2) as Percentage
FROM phishing_url
GROUP BY source;


-- Find URLs containing suspicious keywords like login, verify, or secure.
SELECT url FROM phishing_url
where 
     url LIKE '%login%'
  OR url LIKE '%verify%'
  OR url LIKE '%secure%' ;

-- Rank sources based on phishing URL count.
select Row_Number() OVER (ORDER BY COUNT(source) desc ) as Rank_source ,
       source ,
       count(*) AS url_count
FROM phishing_url
GROUP BY source ;




-- Find URLs longer than the average URL length.
SELECT * FROM phishing_url
WHERE LENGTH(URL) >
	  (SELECT AVG(LENGTH(URL)) FROM phishing_url) ;

-- Show sources whose phishing count is greater than the average phishing count.
SELECT source 
FROM phishing_url
group by source
having avg(label) >
(SELECT (AVG(label)) from phishing_url);

-- Find URLs from sources that have more than 10,000 total URLs.
SELECT source 
FROM phishing_url
group by source
having count(*) > 10000;

-- Identify sources contributing above-average phishing URLs.
SELECT source
FROM phishing_url
GROUP by source 
having avg(label) >
(SELECT AVG(label) FROM phishing_url);


-- Find URLs where the source has the maximum phishing count.


WITH phishing_counts AS (
    SELECT
        source,
        SUM(CASE WHEN label = 1 THEN 1 ELSE 0 END) AS phishing_count
    FROM phishing_url
    GROUP BY source
),
max_source AS (
    SELECT source
    FROM phishing_counts
    WHERE phishing_count = (SELECT MAX(phishing_count) FROM phishing_counts)
)
SELECT *
FROM phishing_url
WHERE source IN (SELECT source FROM max_source);

