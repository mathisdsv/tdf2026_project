with 

source as (

    select * from {{ source('tdf_source', 'cash_price') }}

),

renamed as (

    select
        position,
        cash_prize_per_stage,
        cash_prize_final_rank,
        green_kit_ranking,
        mountain_kit_winner,
        white_kit_ranking,
        daily_cash_prize__for_each_kit_,
        intermediate_sprint,
        competitiveness_daily,
        competitiveness_final,
        special_prize__henri_desgrange__plus_haut_col,
        special_prize__jacques_goddet___col_mythique

    from source

)

select * from renamed