
Select *
From PortfolioProject..CovidDeaths
Where continent is not null
Order by 3,4

-- Select Data we are going to use

Select location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
Where continent is not null
Order by 1,2


-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as "death_percentage"
From PortfolioProject..CovidDeaths
Where location like '%states%'
and continent is not null
Order by 1,2 


-- Total Cases vs Population
-- Shows what percentage of population infected with Covid

Select location, date, total_cases, population, (total_cases/population)*100 as "PercentPopulationInfected"
From PortfolioProject..CovidDeaths
Where location like '%states%'
Order by 1,2


-- Looking at Countries with Highest Infection Rate Compared to Population

Select location, max(total_cases) as HighestInfectionCount, population, max((total_cases/population))*100 as "PercentPopulationInfected"
From PortfolioProject..CovidDeaths
Group by location, population
Order by PercentPopulationInfected desc


-- Countries with Highest Death Count per Population

Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is not null
Group by location
Order by TotalDeathCount desc


-- GROUPING BY CONINENT

-- Showing continents with the highest death count per population

Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is not null
Group by continent
Order by TotalDeathCount desc

Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is null
Group by location
Order by TotalDeathCount desc



-- GLOBAL NUMBERS

Select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, 
	SUM(cast(new_deaths as int))/Sum(new_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
Where continent is not null
Group by date
Order by 1, 2

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, 
	SUM(cast(new_deaths as int))/Sum(new_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
Where continent is not null
Order by 1, 2



