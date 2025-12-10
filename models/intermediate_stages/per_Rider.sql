WITH join_join AS (
select * except (year)
from {{ ref('stg_tdf_source__rider_results') }}
inner join {{ ref('stg_tdf_source__rider_information') }}
using (rider_name)
),
other as(
Select
rider_name,
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
AVG(nb_wins) as nb_wins,
AVG(grand_tours_participation) as grand_tours_participation,
AVG(classics_participation) as classics_participation,
AVG(one_day_races) as one_day_races
From join_join
GROUP BY rider_name
)
Select*,
ROUND(SAFE_DIVIDE(tot_pointsUCI,nb_races),2) as efficiency,
ROUND(SAFE_DIVIDE(nb_wins,nb_races)*100,2) as win_rate,
from other


