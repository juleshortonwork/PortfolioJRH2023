--///-- Query the data to verify
--select*
--from [PORTFOLIO COVID]..death
--order by 3,4

--select*
--from [PORTFOLIO COVID]..vax
--order by 3,4

--///-- Select the working data for covid death
--select location, date, total_cases, new_cases, total_deaths, population
--from [PORTFOLIO COVID]..death
--order by 1,2

--///-- Find total cases vs total deaths re: 

---If you contract covid in a given location on a given date, what is the likelihood of death? OR
---What percentage of covid cases are fatal in a given location on a given date?

select location, date, total_cases, total_deaths, 
cast(total_deaths as decimal(18,0))/cast(total_cases as decimal(18,0))*100  as DeathPercentage
from death
order by 1,2

select location, date, total_cases, total_deaths, 
cast(total_deaths as decimal(18,0))/cast(total_cases as decimal(18,0))*100  as DeathPercentage
from death
where location like '%unit%states%'
order by 1,2

--///-- Find total cases vs population re:

---What percent of people contracted covid by location and date?

select location, date, total_cases, population, 
cast(total_cases as decimal(18,0))/cast(population as decimal(18,0))*100  as CovidPercentage
from death
order by 1,2

select location, date, total_cases, population, 
cast(total_cases as decimal(18,0))/cast(population as decimal(18,0))*100  as CovidPercentage
from death
where location like '%unit%states%'
order by 1,2

--///-- Find locations with highest incidence of covid re:

---What locations had the highest percentage of covid at its peak?

select location, MAX(total_cases) as Maximum, population,
CAST(MAX(total_cases) as decimal(18,0))/cast(population as decimal(18,0))*100  as PeakCovidPercentage
from death
group by location, population
order by PeakCovidPercentage desc

--///-- Find countries with the highest covid mortality per population re:

---What countries had the highest covid death rates?

---highest death RATE (percent of population)
select location, MAX(total_deaths) as MaxMortality, population,
CAST(MAX(total_deaths) as decimal(18,0))/cast(population as decimal(18,0))*100  as PeakMortality
from death
where continent is not null
group by location, population
order by PeakMortality desc

---highest total deaths (total count)
select location, MAX(total_deaths) as MaxMortality, population
from death
where continent is not null
group by location, population
order by MaxMortality desc

--///-- Find continents with the highest covid mortality per population re:

---Which continents have the highest covid death rates?

---highest continental death RATE (percent of population)
select location, MAX(total_deaths) as ContinentMaxMortality, population,
CAST(MAX(total_deaths) as decimal(18,0))/cast(population as decimal(18,0))*100  as ContinentPeakMortalityPercent
from death
where (continent is null AND location not like '%income%' AND location not like '%Union%')
group by location, population
order by ContinentPeakMortalityPercent desc

---highest continental total deaths (total count)
select location, MAX(total_deaths) as ContinentMaxMortalityCount, population
from death
where (continent is null AND location not like '%income%' AND location not like '%Union%')
group by location, population
order by ContinentMaxMortalityCount desc

--///-- Find BREAK DOWN BY CONTINENT

---Africa

---highest African death RATE (percent of population)
select location, MAX(total_deaths) as AfricanMaxMortality, population,
CAST(MAX(total_deaths) as decimal(18,0))/cast(population as decimal(18,0))*100  as AfricanPeakMortalityPercent
from death
where continent = 'Africa'
group by location, population
order by AfricanPeakMortalityPercent desc

---highest African total deaths (total count)
select location, population, MAX(total_deaths) as AfricanMaxMortalityCount
from death
where continent = 'Africa'
group by location, population
order by AfricanMaxMortalityCount desc

---Asia

---highest Asian death RATE (percent of population)
select location, MAX(total_deaths) as AsianMaxMortality, population,
CAST(MAX(total_deaths) as decimal(18,0))/cast(population as decimal(18,0))*100  as AsianPeakMortalityPercent
from death
where continent = 'Asia'
group by location, population
order by AsianPeakMortalityPercent desc

---highest Asian total deaths (total count)
select location, population, MAX(total_deaths) as AsianMaxMortalityCount
from death
where continent = 'Asia'
group by location, population
order by AsianMaxMortalityCount desc

---Europe

---highest European death RATE (percent of population)
select location, MAX(total_deaths) as EuropeanMaxMortality, population,
CAST(MAX(total_deaths) as decimal(18,0))/cast(population as decimal(18,0))*100  as EuropeanPeakMortalityPercent
from death
where continent = 'Europe'
group by location, population
order by EuropeanPeakMortalityPercent desc

---highest European total deaths (total count)
select location, population, MAX(total_deaths) as EuropeanMaxMortalityCount
from death
where continent = 'Europe'
group by location, population
order by EuropeanMaxMortalityCount desc

---Oceania

---highest Oceanian death RATE (percent of population)
select location, MAX(total_deaths) as OceanianMaxMortality, population,
CAST(MAX(total_deaths) as decimal(18,0))/cast(population as decimal(18,0))*100  as OceanianPeakMortalityPercent
from death
where continent = 'Oceania'
group by location, population
order by OceanianPeakMortalityPercent desc

---highest Oceania total deaths (total count)
select location, population, MAX(total_deaths) as OceanianMaxMortalityCount
from death
where continent = 'Oceania'
group by location, population
order by OceanianMaxMortalityCount desc

---North America

---highest North American death RATE (percent of population)
select location, MAX(total_deaths) as NorthAmericanMaxMortality, population,
CAST(MAX(total_deaths) as decimal(18,0))/cast(population as decimal(18,0))*100  as NorthAmericanPeakMortalityPercent
from death
where continent = 'North America'
group by location, population
order by NorthAmericanPeakMortalityPercent desc

---highest North American total deaths (total count)
select location, population, MAX(total_deaths) as NorthAmericanMaxMortalityCount
from death
where continent = 'North America'
group by location, population
order by NorthAmericanMaxMortalityCount desc

---South America

---highest South American death RATE (percent of population)
select location, MAX(total_deaths) as SouthAmericanMaxMortality, population,
CAST(MAX(total_deaths) as decimal(18,0))/cast(population as decimal(18,0))*100  as SouthAmericanPeakMortalityPercent
from death
where continent = 'South America'
group by location, population
order by SouthAmericanPeakMortalityPercent desc

---highest South American total deaths (total count)
select location, population, MAX(total_deaths) as SouthAmericanMaxMortalityCount
from death
where continent = 'South America'
group by location, population
order by SouthAmericanMaxMortalityCount desc

--///-- Find GLOBAL numbers

---Daily Global New Cases, New Deaths, and Percent New Deaths per Population

SELECT location, date, SUM(cast(new_cases as decimal(12,2))) as GlobalNewCases, SUM(cast(new_deaths as decimal(12,2))) as GlobalNewDeaths, population, SUM(cast(new_deaths as decimal(12,2)))/(cast(population as decimal(12,2)))*100 as GlobalDeathPercentage
FROM death
where location = 'World'
	AND new_cases >0
group by location, date, population
order by date

-------

--///-- Select the working data for covid vaccination

--select*
--from [PORTFOLIO COVID]..vax
--join [PORTFOLIO COVID]..death
--on vax.location = death.location and vax.date = death.date

--///-- Country population vs new vaccination

select death.continent, death.location, death.date, CAST(death.population as decimal) as population, CAST(vax.new_vaccinations as decimal) as new_vaccinations, CAST(death.new_deaths as decimal) as new_deaths, CAST(death.total_deaths as decimal) as total_deaths, CAST(vax.total_vaccinations as decimal) as total_vaccinations
from [PORTFOLIO COVID]..vax
join [PORTFOLIO COVID]..death
on vax.location = death.location and vax.date = death.date
where death.continent is not null
order by 1,2,3

---North America population, covid vaccination, and covid death

select death.continent, death.location, death.date, CAST(death.population as decimal) as population, CAST(vax.new_vaccinations as decimal) as new_vaccinations, CAST(death.new_deaths as decimal) as new_deaths, CAST(death.total_deaths as decimal) as total_deaths, CAST(vax.total_vaccinations as decimal) as total_vaccinations
from [PORTFOLIO COVID]..vax
join [PORTFOLIO COVID]..death
on vax.location = death.location and vax.date = death.date
where death.continent is not null
	AND death.continent = 'North America'
order by 1,2,3

---Cumulative covid vaccination and covid death by continent and country

select death.continent, death.location, death.date, CAST(death.population as decimal) as population, CAST(vax.new_vaccinations as decimal) as new_vaccinations,
SUM(CAST(vax.new_vaccinations as decimal)) OVER (PARTITION BY death.location ORDER BY death.location, death.date) as CumulativeVaccinations, CAST(death.new_deaths as decimal) as new_deaths,
SUM(CAST(death.new_deaths as decimal)) OVER (PARTITION BY death.location ORDER BY death.location, death.date) as CumulativeDeaths
from [PORTFOLIO COVID]..vax
join [PORTFOLIO COVID]..death
on vax.location = death.location and vax.date = death.date
where death.continent is not null
order by 1,2,3

---CTEs/ WITH statements to breakdown per population

WITH CumulativevsPop (continent, location, date, population, new_vaccinations, CumulativeVaccinations, new_deaths, CumulativeDeaths)
AS
(select death.continent, death.location, death.date, CAST(death.population as decimal) as population, CAST(vax.new_vaccinations as decimal) as new_vaccinations,
SUM(CAST(vax.new_vaccinations as decimal)) OVER (PARTITION BY death.location ORDER BY death.location, death.date) as CumulativeVaccinations, CAST(death.new_deaths as decimal) as new_deaths,
SUM(CAST(death.new_deaths as decimal)) OVER (PARTITION BY death.location ORDER BY death.location, death.date) as CumulativeDeaths
from [PORTFOLIO COVID]..vax
join [PORTFOLIO COVID]..death
on vax.location = death.location and vax.date = death.date
where death.continent is not null)

SELECT *, CumulativeVaccinations/population*100 as CumulativeVaxPercect, CumulativeDeaths/population*100 as CumulativeDeathPercent
FROM CumulativevsPop

---Temp Table to breakdown per population

DROP TABLE IF EXISTS #tempCumulativePopPercent
create table #tempCumulativePopPercent (continent varchar(50), location varchar(50), date date, population decimal, new_vaccinations decimal, CumulativeVaccinations decimal, new_deaths decimal, CumulativeDeaths decimal)
insert into #tempCumulativePopPercent
select death.continent, death.location, death.date, CAST(death.population as decimal) as population, CAST(vax.new_vaccinations as decimal) as new_vaccinations,
SUM(CAST(vax.new_vaccinations as decimal)) OVER (PARTITION BY death.location ORDER BY death.location, death.date) as CumulativeVaccinations, CAST(death.new_deaths as decimal) as new_deaths,
SUM(CAST(death.new_deaths as decimal)) OVER (PARTITION BY death.location ORDER BY death.location, death.date) as CumulativeDeaths
from [PORTFOLIO COVID]..vax
join [PORTFOLIO COVID]..death
on vax.location = death.location and vax.date = death.date
where death.continent is not null

SELECT *, CumulativeVaccinations/population*100 as PercectCumulativeVax, CumulativeDeaths/population*100 as PercentCumulativeDeath
FROM #tempCumulativePopPercent
order by 1,2,3

--///-- Creating views to store data for visualization

create view CumulativePopPercent 
as
select death.continent, death.location, death.date, CAST(death.population as decimal) as population, CAST(vax.new_vaccinations as decimal) as new_vaccinations,
SUM(CAST(vax.new_vaccinations as decimal)) OVER (PARTITION BY death.location ORDER BY death.location, death.date) as CumulativeVaccinations, CAST(death.new_deaths as decimal) as new_deaths,
SUM(CAST(death.new_deaths as decimal)) OVER (PARTITION BY death.location ORDER BY death.location, death.date) as CumulativeDeaths
from [PORTFOLIO COVID]..vax
join [PORTFOLIO COVID]..death
on vax.location = death.location and vax.date = death.date
where death.continent is not null

