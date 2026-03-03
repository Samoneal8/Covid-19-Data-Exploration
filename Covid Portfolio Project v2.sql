Select*
From PortfolioProject..Coviddeaths
Where continent is not null
Order by 3,4

--Select*
--From PortfolioProject..Covidvaccinations
--Order by 3,4
-- Lets select the data we are going to be using for the project

Select Location, date, total_cases,new_cases, total_deaths, population
from PortfolioProject..Coviddeaths
order by 1,2


--Looking at Total Cases vs Total Deathes
-- Shows the likelihood of dying if you contract Covid in your country
Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..Coviddeaths
Where location like'%Namibia%'
and continent is not null
order by 1,2


--Looking at Total Cases vs Population
-- Shows what percentage of the population got Covid
Select Location, date,Population , total_cases, (total_cases/Population)*100 as DeathPercentage
from PortfolioProject..Coviddeaths
Where location like'%Namibia%'
order by 1,2


--Looking at countries with Highest Infection rate compared to Population

Select Location, Population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/Population))*100 as 
	PercentPopulationInfected
From PortfolioProject..Coviddeaths
--Where location like'%Namibia%'
Group by Location, Population
order by PercentPopulationInfected desc

--Showing Countries with Highest death Count per Population

Select Location,MAX(total_deaths) as TotalDeathCount
From PortfolioProject..Coviddeaths
--to convert total_deaths from float to interger MAX(cast(total_deaths as int))
--Where location like'%Namibia%'
Where continent is not null
Group by Location
order by TotalDeathCount desc

--LET'S BREAK THINGS DOWN BY CONTINENTS

Select location, MAX(total_deaths) as TotalDeathCount
From PortfolioProject..Coviddeaths
Where continent is null
Group by location
order by TotalDeathCount desc

--you can replace anything above group by with "continent"

--GLOBAL NUMBERS

Select date, SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(new_cases)*100 as
	DeathPercentage
from PortfolioProject..Coviddeaths
--Where location like '%Namibia%'
where continent is not null
Group By date
order by 1,2



Select SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(new_cases)*100 as
	DeathPercentage
from PortfolioProject..Coviddeaths
--Where location like '%Namibia%'
where continent is not null
--Group By date
order by 1,2

--Looking at total Population vs Vaccinations

Select dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations
,SUM(Cast(vac.new_vaccinations as int)) OVER (Partition by dea.location Order by dea.location,
	dea.date) as RollingPeopleVaccinated
--You can also say convert(int, vac.new_vaccinations)
From PortfolioProject..Coviddeaths dea
Join PortfolioProject..Covidvaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
Order by 2,3


--CTE
With PopvsVac (Continent, Location,Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations
,SUM(Cast(vac.new_vaccinations as int)) OVER (Partition by dea.location Order by dea.location,
	dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..Coviddeaths dea
Join PortfolioProject..Covidvaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--Order by 2,3
)
Select*, (RollingPeopleVaccinated/population)*100
From PopvsVac

--TEMP TABLE

DROP TABLE if exists #PercentPopulationVaccinated

Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations
,SUM(Cast(vac.new_vaccinations as int)) OVER (Partition by dea.location Order by dea.location,
	dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..Coviddeaths dea
Join PortfolioProject..Covidvaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
--Where dea.continent is not null
--Order by 2,3

Select*, (RollingPeopleVaccinated/population)*100
From #PercentPopulationVaccinated

--Creating View to sore data for later visualizations
DROP VIEW IF EXISTS PercentPopulationVaccinated;
GO

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations
,SUM(Cast(vac.new_vaccinations as float)) OVER (Partition by dea.location Order by dea.location,
	dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..Coviddeaths dea
Join PortfolioProject..Covidvaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--Order by 2,3

Select *
From PercentPopulationVaccinated