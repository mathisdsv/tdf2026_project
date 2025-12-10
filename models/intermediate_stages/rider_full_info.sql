WITH join_rider_stage AS (
select *
from {{ ref('per_Rider') }}
inner join {{ ref('join_stage_results_and_stage_infos') }}
using (rider_name)
),

propre AS ( 
select DISTINCT * except(win_type, startlist_quality_score,vertical_meters, profile_score, final_km_gradient, avg_speed_kmh, distance_km, time, points, general_classement, rank, stage_title, stage, year, age), 
AVG(age) OVER(PARTITION BY rider_name) as age_final,
from join_rider_stage
QUALIFY ROW_NUMBER() OVER(PARTITION BY rider_name ORDER BY age DESC) = 1
order by rider_name
),

ptit as(
SELECT *,  
CAST(age_final AS INT64) as age
from propre    
)

select * from ptit