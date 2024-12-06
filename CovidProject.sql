use PortfolioProject;

select location ,date,total_cases,new_cases,total_deaths,population
from dbo.CovidDeath
order by 1,2;


--select * from ..CovidVaccination
--order by 3,4;



delete CovidDeath 
where total_cases = 0;

--Looking at Total Case VS Total Death , Death percentage at saudi arabia 

select location ,date,max(total_cases),total_deaths ,(total_deaths/total_cases)*100 as Death_Percentage 
from dbo.CovidDeath
order by 2,5 desc;

--Get countries with highest num. of cases rate compared to population 

select location ,population,max(total_cases) as HighestInfection ,max((total_cases/population))*100 as PercentPopulationInfected 
from dbo.CovidDeath
Group by location,population
order by  PercentPopulationInfected desc;

--Showing Countries with heighest death number 

select location ,max(total_deaths) as HighestDeath 
from dbo.CovidDeath
where continent is not null
Group by location
order by  2 desc;

--Group by Continent
select continent ,max(total_deaths) as HighestDeath 
from dbo.CovidDeath
where continent is not null
Group by continent
order by  2 desc;

--Global Number of total cases and total death

select date,sum(new_cases) as Total_of_new_cases,sum(new_deaths) as total_of_new_death
from ..CovidDeath
group by date 
order by  date ;

-- vaccination vs population

select death.continent,death.location,death.population,vaccin.new_vaccinations
from dbo.CovidDeath death
join dbo.CovidVaccination vaccin
on death.location=vaccin.location
and death.date=vaccin.date
where death.continent is not null
order by 1,2,3;

-- Using CTE 

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations)
as
(
Select death.continent, death.location, death.date, death.population, vaccin.new_vaccinations 
From ..CovidDeath death
Join ..CovidVaccination vaccin
	On death.location = vaccin.location
	and death.date = vaccin.date
where death.continent is not null 
)
Select *
From PopvsVac
order by 3 ;





