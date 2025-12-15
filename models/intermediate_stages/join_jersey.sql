{{ config(materialized='view') }}

with base as (

    select *
    from {{ ref('final_table') }}

),

jerseys as (

    select
        year,
        jersey_type,
        rider_name
    from {{ ref('stg_tdf_jersey_winner') }}

),

joined as (

    select
        b.*,

        -- infos maillot
        j.jersey_type as jersey_won,
        case
            when j.jersey_type is not null then 1
            else 0
        end as has_jersey

    from base b
    left join jerseys j
        on b.year_year = j.year
       and b.rider_name = j.rider_name

)

select *
from joined