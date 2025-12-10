WITH join_join AS (
select * except (year)
from {{ ref('stg_tdf_source__rider_results') }}
inner join {{ ref('stg_tdf_source__rider_information') }}
using (rider_name)
),
sec as(
select
rider_name,
year_year,
ROUND(SUM(distance),2) as tot_distance,
COUNT(Distinct distance) as nb_races,
SUM(pointspcs) as tot_pointsPCS,
SUM(pointsuci) as tot_pointsUCI,
AVG(CAST(weight_kg as FLOAT64)) as weight_kg,
AVG(CAST(height_m as FLOAT64)) as height_m,
AVG(time_trial) as time_trial,
AVG(sprint) as sprint,
AVG(climber) as climber,
AVG(hills) as hills,
AVG(one_day_races) as one_day_races
From join_join
GROUP BY rider_name,year_year
)
Select*
FROM sec
