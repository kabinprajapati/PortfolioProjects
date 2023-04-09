use alex
select * from coviddeaths
select * from covidvaccinations

select location, MAX(cast(total_deaths as int))as totaldeathcount
from coviddeaths
where location is not null
group by location
order by totaldeathcount desc


select location, MAX(cast(total_deaths as float)) as totaldeathcount
from coviddeaths
where location = 'India'
-- group by location
-- order by totaldeathcount desc

SELECT  date, sum(new_cases) as total_cases,
sum(new_deaths) as total_deaths,
sum(new_deaths)/sum(new_cases)*100 as death_percentage
from coviddeaths
where continent is not null
-- group by date

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as float)) over (Partition by dea.location order by dea.location, dea.date) as per
from coviddeaths as dea
join covidvaccinations as vac
on dea.location = vac.location
and dea.date= vac.date
where dea.continent is not null
order by 2,3