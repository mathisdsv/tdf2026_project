With tablee as(
Select* 
From {{ ref('final_table') }}
WHERE stage = 21
)
,
table_2 as (
Select* except(rank,points,stage,avg_speed_kmh,final_km_gradient,vertical_meters,win_type,startlist_quality_score),
from tablee
order by year_year,general_classement
)
,
table_3 as(
Select* except(cash_prize_per_stage,green_kit_ranking,mountain_kit_winner,white_kit_ranking,daily_cash_prize__for_each_kit_,intermediate_sprint,competitiveness_daily,competitiveness_final,special_prize__henri_desgrange__plus_haut_col,special_prize__jacques_goddet___col_mythique,position),
from table_2
left join {{ ref('stg_tdf_source__cash_price') }} as cp
on table_2.general_classement=cp.position )
Select* except(cash_prize_final_rank),
ifnull(cash_prize_final_rank,0) as cash_prize_final_rank_
From table_3