use world;

/* Count Cities in USA: Scenario: You've been tasked with conducting a demographic analysis of cities in the United States. 
Your first step is to determine the total number of cities within the country to provide a baseline for further analysis.
*/

select count(distinct name)
from city
where countrycode = 'usa';

/*
Country with Highest Life Expectancy: Scenario: 
As part of a global health initiative, you've been assigned to identify the country with the highest life expectancy. 
This information will be crucial for prioritising healthcare resources and interventions.   
*/

select name, LifeExpectancy
from country 
order by lifeexpectancy desc
limit 1;

/*
"New Year Promotion: Featuring Cities with 'New : 
Scenario: In anticipation of the upcoming New Year, your travel agency is gearing up for a special promotion featuring cities with names including the word 'New'.
You're tasked with swiftly compiling a list of all cities from around the world. 
This curated selection will be essential in creating promotional materials and enticing travellers with exciting destinations to kick off the New Year in style. 
*/

select * 
from city 
where name like '%new%';

/*
Display Columns with Limit (First 10 Rows): 
Scenario: You're tasked with providing a brief overview of the most populous cities in the world. 
To keep the report concise, you're instructed to list only the first 10 cities by population from the database. 
*/

select name as country, Population
from city 
order by population desc 
limit 10;

/*
Cities with Population Larger than 2,000,000: Scenario: 
A real estate developer is interested in cities with substantial population sizes for potential investment opportunities. 
You're tasked with identifying cities from the database with populations exceeding 2 million to focus their research efforts. 
*/

select * 
from city 
where population > 2000000
order by population
;


/*
Cities Beginning with 'Be' Prefix: 
Scenario: A travel blogger is planning a series of articles featuring cities with unique names. 
You're tasked with compiling a list of cities from the database that start with the prefix 'Be' to assist in the blogger's content creation process. 
*/

select *
from city 
where name like 'be%'
;

/*
Cities with Population Between 500,000-1,000,000: Scenario: 
An urban planning committee needs to identify mid-sized cities suitable for infrastructure development projects. 
You're tasked with identifying cities with populations ranging between 500,000 and 1 million to inform their decision-making process. 
*/

select *
from city 
where population between 500000 and 1000000
order by population
;

/*
Display Cities Sorted by Name in Ascending Order: Scenario: 
A geography teacher is preparing a lesson on alphabetical order using city names. 
You're tasked with providing a sorted list of cities from the database in ascending order by name to support the lesson plan.
*/

select distinct name 
from city 
order by name 
;

/*
Most Populated City: Scenario:
 A real estate investment firm is interested in cities with significant population densities for potential development projects. 
 You're tasked with identifying the most populated city from the database to guide their investment decisions and strategic planning. 
*/
select * 
from city 
order by population desc 
limit 5;

/*
City Name Frequency Analysis: 
Supporting Geography Education Scenario: In a geography class, students are learning about the distribution of city names around the world.
 The teacher, in preparation for a lesson on city name frequencies, wants to provide students with a list of unique city names sorted alphabetically,
 along with their respective counts of occurrences in the database. You're tasked with this sorted list to support the geography teacher.
*/

select name as Name,count(name) as frequency 
from city 
group by name
order by count(name) desc;

/*
City with the Lowest Population: Scenario: A census bureau is conducting an analysis of urban population distribution.
 You're tasked with identifying the city with the lowest population from the database to provide a comprehensive overview of demographic trends. 
*/

select * 
from city 
order by population  
limit 1;

/*
Country with Largest Population: Scenario: A global economic research institute requires data on countries with the largest populations for a comprehensive analysis. 
You're tasked with identifying the country with the highest population from the database to provide valuable insights into demographic trends. 
*/

select name, population 
from country  
order by population desc
limit 1;

/*
Capital of Spain: Scenario: A travel agency is organising tours across Europe and needs accurate information on capital cities. 
You're tasked with identifying the capital of Spain from the database to ensure itinerary accuracy and provide travellers with essential destination information. 
*/

select *
from country;
 




/*
Cities in Europe: Scenario: 
A European cultural exchange program is seeking to connect students with cities across the continent.
You're tasked with compiling a list of cities located in Europe from the database to facilitate program planning and student engagement. 
*/

select co.continent, c.name as City
from country as co
inner join city as c 
on co.code = c.countrycode
where continent like '%Europe%'
;

/*
Average Population by Country: 
Scenario: A demographic research team is conducting a comparative analysis of population distributions across countries. 
You're tasked with calculating the average population for each country from the database to provide valuable insights into global population trends. 
*/

select co.name, FORMAT(AVG(c.Population), 0) as AvgPopulation
from country as co
inner join city as c 
on co.code = c.countrycode
group by co.name;

/*
Capital Cities Population Comparison: Scenario: 
A statistical analysis firm is examining population distributions between capital cities worldwide. 
You're tasked with comparing the populations of capital cities from different countries to identify trends and patterns in urban demographics. 
*/

select co.name, c.name , c.population
from country as co
inner join city as c
on co.capital = c.ID
order by c.population;

/*
Countries with Low Population Density: 
Scenario: An agricultural research institute is studying countries with low population densities for potential agricultural development projects. 
You're tasked with identifying countries with sparse populations from the database to support the institute's research efforts. 
*/

select name, population, surfacearea , round(population/surfacearea) as LowPopDensity 
from country 
where round(population/surfacearea) >0
order by LowPopDensity ;

/*
Cities with High GDP per Capita: Scenario:
 An economic consulting firm is analysing cities with high GDP per capita for investment opportunities. 
 You're tasked with identifying cities with above-average GDP per capita from the database to assist the firm in identifying potential investment destinations. 
*/

select co.name, c.name , ROUND(co.GNP / co.Population, 2) AS GdpPerCapita
from city as c 
inner join country as co 
on c.countrycode = co.code
where (co.gnp / co.population) > (
select avg(gnp / population) 
from country 
WHERE Population > 0 AND GNP IS NOT NULL
);

SELECT 
    ci.Name AS City,co.Name AS Country,co.GNP,co.Population, ROUND(co.GNP / co.Population, 2) AS GdpPerCapita
FROM city ci
JOIN country co
 ON ci.CountryCode = co.Code
WHERE (co.GNP / co.Population) > (
    SELECT AVG(GNP / Population)
    FROM country
    WHERE Population > 0 AND GNP IS NOT NULL
)
ORDER BY GdpPerCapita DESC;




/*
Display Columns with Limit (Rows 31-40): 
Scenario: A market research firm requires detailed information on cities beyond the top rankings for a comprehensive analysis. 
You're tasked with providing data on cities ranked between 31st and 40th by population to ensure a thorough understanding of urban demographics. 
*/
SELECT 
    Name AS City,
    CountryCode,
    Population
FROM city
ORDER BY Population DESC
LIMIT 10 OFFSET 30;


/*

*/