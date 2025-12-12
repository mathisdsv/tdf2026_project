with source as (

    select *
    from {{ source('tdf_source', 'all_stage_information_with_type') }}

),

renamed as (

    select
        StageTitle as stage_title,
        Year as year,
        Stage as stage,
        Date as stage_date,
        Start_time as start_time,
        Avg__speed_winner as avg_speed_winner,
        Classification as classification,
        Race_category as race_category,
        Distance as distance_km,
        Points_scale as points_scale,
        UCI_scale as uci_scale,
        Parcours_type as parcours_type,
        Gradient_final_km as gradient_final_km,
        ProfileScore as profile_score,
        Vertical_meters as vertical_meters,
        Departure as departure_city,
        Arrival as arrival_city,
        Race_ranking as race_ranking,
        Startlist_quality_score as startlist_quality_score,
        Won_how as won_how,
        Avg__temperature as avg_temperature,
        Timelimit as time_limit
    from source
)

select *
from renamed