WITH join_join AS (
select *
from {{ ref('join_with_type') }}
left join {{ ref('rider_full_info_for_join') }}
using (rider_name)
),

finish as(
select * except(year, stage_title, profile_score, time, classics_participation ),
year as year_year,
from join_join
order by year_year, stage, rank ASC

),

finish_2 as(
select 
rider_name,
team,
year_year,
stage,
rank,
points,
general_classement,
specialty,
age,
parcours_type,
CASE
  WHEN parcours_type = "1" THEN 'Flat'
  WHEN parcours_type = "2" THEN 'Hills, flat finish'
  WHEN parcours_type = "3" THEN 'Hills, uphill finish'
  WHEN parcours_type = "4" THEN 'Mountains, flat finish'
  WHEN parcours_type = "5" THEN 'Mountains, uphill finish'
  ELSE NULL 
END AS parcours_category,
distance_km,
avg_speed_kmh,
final_km_gradient,
vertical_meters,
startlist_quality_score,
win_type,
nb_races,
nb_wins,
weight_kg,
height_m,
grand_tours_participation, 
efficiency,
win_rate,

from finish 
)

select * from finish_2 