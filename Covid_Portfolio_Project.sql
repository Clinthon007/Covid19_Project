/*select * 
from Covid_Vaccinations
order by 3,4;
*/

SELECT *
FROM Covid_Deaths
WHERE continent IS NOT NULL
ORDER BY 3,4;

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM Covid_Deaths
ORDER BY 1,2;

--Looking At  Total Cases Vs Total Deaths (Focus On United States)
--Shows the likelihood of dying if it's contracted in 2019
SELECT 
      location,
	  date, 
	  total_cases, 
	  total_deaths, 
	  (CONVERT(FLOAT, total_deaths) / NULLIF(CONVERT(FLOAT, total_cases),0))*100 AS Death_Percentage
FROM 
    Covid_Deaths
WHERE
     location like '%states%'
AND continent IS NOT NULL
ORDER BY 1,2;

--Looking at Total Cases Vs aapopulation
-- Shows what Percentage of population got covid
SELECT 
      location,
	  date, 
	  total_cases, 
	  Population, 
	  (total_cases / Population)*100 AS Percentage_Population_Infected
FROM 
    Covid_Deaths
--WHERE location = 'United States'
ORDER BY 1,2;

--Looking at countries with Highest Infection Rate Compared to population

SELECT 
      location,
	  Population, 
	  MAX(total_cases) AS Highest_Infection_Count, 
	  MAX(total_cases / Population)*100 AS Percentage_Population_Infected
FROM 
    Covid_Deaths
--WHERE location = 'United States'
GROUP BY location, Population
ORDER BY Percentage_Population_Infected desc;


--Showing Countries with Highest Death Count per Population

SELECT location,
       MAX(cast(Total_deaths AS INT)) AS Total_Death_Count
FROM
    Covid_Deaths
WHERE 
     continent IS NOT NULL
GROUP BY location
ORDER BY Total_Death_Count DESC;


-- Showcasing Query By Continent

SELECT continent,
       MAX(cast(Total_deaths AS INT)) AS Total_Death_Count
FROM
    Covid_Deaths
WHERE 
     continent IS NOT NULL
GROUP BY continent
ORDER BY Total_Death_Count DESC;


/*select * 
from Covid_Vaccinations
order by 3,4;
*/

SELECT *
FROM Covid_Deaths
WHERE continent IS NOT NULL
ORDER BY 3,4;

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM Covid_Deaths
ORDER BY 1,2;

--Looking At  Total Cases Vs Total Deaths (Focus On United States)
--Shows the likelihood of dying if it's contracted in 2019
SELECT 
      location,
	  date, 
	  total_cases, 
	  total_deaths, 
	  (CONVERT(FLOAT, total_deaths) / NULLIF(CONVERT(FLOAT, total_cases),0))*100 AS Death_Percentage
FROM 
    Covid_Deaths
WHERE
     location like '%states%'
AND continent IS NOT NULL
ORDER BY 1,2;

--Looking at Total Cases Vs aapopulation
-- Shows what Percentage of population got covid
SELECT 
      location,
	  date, 
	  total_cases, 
	  Population, 
	  (total_cases / Population)*100 AS Percentage_Population_Infected
FROM 
    Covid_Deaths
--WHERE location = 'United States'
ORDER BY 1,2;

--Looking at countries with Highest Infection Rate Compared to population

SELECT 
      location,
	  Population, 
	  MAX(total_cases) AS Highest_Infection_Count, 
	  MAX(total_cases / Population)*100 AS Percentage_Population_Infected
FROM 
    Covid_Deaths
--WHERE location = 'United States'
GROUP BY location, Population
ORDER BY Percentage_Population_Infected desc;


--Showing Countries with Highest Death Count per Population

SELECT location,
       MAX(cast(Total_deaths AS INT)) AS Total_Death_Count
FROM
    Covid_Deaths
WHERE 
     continent IS NOT NULL
GROUP BY location
ORDER BY Total_Death_Count DESC;


-- Showing Continents with highest death count per population

SELECT continent,
       MAX(cast(Total_deaths AS INT)) AS Total_Death_Count
FROM
    Covid_Deaths
WHERE 
     continent IS NOT NULL
GROUP BY continent
ORDER BY Total_Death_Count DESC;


--GLOBAL NUMBERS

SELECT 
      SUM(new_cases) AS total_cases,
	  SUM(CAST(new_deaths AS INT)) AS total_deaths,
	  SUM(CAST(new_deaths AS INT)) / SUM(New_Cases) * 100 AS Death_Percentage
FROM 
    Covid_Deaths
WHERE
     continent IS NOT NULL
ORDER BY 1,2;

---------------------
SELECT 
      date,
      SUM(new_cases) AS total_cases,
	  SUM(CAST(new_deaths AS INT)) AS total_deaths,
	  SUM(CAST(new_deaths AS INT)) / SUM(New_Cases) * 100 AS Death_Percentage
FROM 
    Covid_Deaths
WHERE
     continent IS NOT NULL
GROUP BY date
ORDER BY 1,2;


-- Looking At Total Population Vs Vaccination

SELECT
      dea.continent,
	  dea.location,
	  dea.date,
	  dea.population,
	  vac.new_vaccinations,
	  SUM(CONVERT(INT, vac.new_vaccinations))
	  OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS Rolling_People_Vaccinated
FROM
    Covid_Deaths AS dea
JOIN Covid_Vaccinations AS vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE
     dea.continent IS NOT NULL
ORDER BY 2,3;


-- Using CTE to run further calculations on the new "Rolling_People_Vaccinated" created

WITH Pop_VS_Vac (Continent, Location, Date, Population, New_Vaccination, Rolling_people_Vaccinated)
AS
(
SELECT
      dea.continent,
	  dea.location,
	  dea.date,
	  dea.population,
	  vac.new_vaccinations,
	  SUM(CONVERT(INT, vac.new_vaccinations))
	  OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS Rolling_People_Vaccinated
FROM
    Covid_Deaths AS dea
JOIN Covid_Vaccinations AS vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE
     dea.continent IS NOT NULL
)
SELECT *,
        (Rolling_people_Vaccinated / Population) * 100
FROM Pop_VS_Vac;


--TEMP TABLE
DROP TABLE IF EXISTS #Percent_Population_Vaccinated
CREATE TABLE #Percent_Population_Vaccinated
(
Continent NVARCHAR(255),
Location NVARCHAR(255),
Date DATETIME,
Population NUMERIC,
New_vaccinations NUMERIC,
Rolling_People_Vaccinated NUMERIC
)
INSERT INTO #Percent_Population_Vaccinated
SELECT
      dea.continent,
	  dea.location,
	  dea.date,
	  dea.population,
	  vac.new_vaccinations,
	  SUM(CONVERT(INT, vac.new_vaccinations))
	  OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS Rolling_People_Vaccinated
FROM
    Covid_Deaths AS dea
JOIN Covid_Vaccinations AS vac
ON dea.location = vac.location
AND dea.date = vac.date
-- WHERE dea.continent IS NOT NULL

SELECT *,
        (Rolling_people_Vaccinated / Population) * 100
FROM #Percent_Population_Vaccinated;


-- Creating View to Store data for later Visualization

CREATE VIEW Percent_Population_Vaccinated AS
SELECT
      dea.continent,
	  dea.location,
	  dea.date,
	  dea.population,
	  vac.new_vaccinations,
	  SUM(CONVERT(INT, vac.new_vaccinations))
	  OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS Rolling_People_Vaccinated
FROM
    Covid_Deaths AS dea
JOIN Covid_Vaccinations AS vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE
     dea.continent IS NOT NULL;

Select *
from Percent_Population_Vaccinated
