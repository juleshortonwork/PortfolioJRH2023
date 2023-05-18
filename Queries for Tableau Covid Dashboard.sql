--///--Queries for Tableau Covid Dashboard

---1

select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, 
SUM(cast(new_deaths as decimal))/SUM(cast(new_cases as decimal))*100 as DeathPercentage
from death
where continent is not null 
order by 1,2

--2
-- We take these out as they are not inluded in the above queries and want to stay consistent
-- European Union is part of Europe
--Highest Covid Deaths by Location

select location, SUM(cast(new_deaths as decimal)) as SumNewDeaths
from death
where (continent is null AND location not like '%income%' AND location not like '%Union%' AND location not like '%World%')
Group by location
order by SumNewDeaths desc

--3

---What locations had the highest percentage of covid at its peak?

select location, MAX(total_cases) as MaximumCount, population,
CAST(MAX(total_cases) as decimal(18,0))/cast(population as decimal(18,0))*100  as PeakCovidPercentage
from death
group by location, population
order by PeakCovidPercentage desc

--4

---What locations had the highest percentage of covid at its peak?

select location, population, date, MAX(total_cases) as MaximumCount, 
CAST(MAX(total_cases) as decimal(18,0))/cast(population as decimal(18,0))*100  as PeakCovidPercentage
from death
group by location, population, date
order by PeakCovidPercentage desc

--5
---Cumulative covid vaccination and covid death by continent and country
select death.continent, death.location, death.date, CAST(death.population as decimal) as population, CAST(vax.new_vaccinations as decimal) as new_vaccinations,
SUM(CAST(vax.new_vaccinations as decimal)) OVER (PARTITION BY death.location ORDER BY death.location, death.date) as CumulativeVaccinations, CAST(death.new_deaths as decimal) as new_deaths,
SUM(CAST(death.new_deaths as decimal)) OVER (PARTITION BY death.location ORDER BY death.location, death.date) as CumulativeDeaths
from [PORTFOLIO COVID]..vax
join [PORTFOLIO COVID]..death
on vax.location = death.location and vax.date = death.date
where death.continent is not null
order by 1,2,3

--6
--maybe one of last 3
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
