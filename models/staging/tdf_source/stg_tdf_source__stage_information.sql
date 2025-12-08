with 

source as (

    select * from {{ source('tdf_source', 'stage_information') }}

),

renamed as (

    select
        stagetitle,
        year,
        stage,
        date,
        start_time,
        avg__speed_winner,
        classification,
        race_category,
        distance,
        points_scale,
        uci_scale,
        parcours_type,
        gradient_final_km,
        profilescore,
        vertical_meters,
        departure,
        arrival,
        race_ranking,
        startlist_quality_score,
        won_how,
        avg__temperature

    from source

)

select * from renamed