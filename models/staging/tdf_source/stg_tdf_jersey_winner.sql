{{ config(materialized="view") }}

with source as (

    select *
    from {{ source('tdf_source', 'jersey_winner') }}

),

renamed as (

    select
        cast(year as int64)                as year,
        lower(jersey_type)                 as jersey_type,
        rider_name                         as rider_name
    from source
)

select *
from renamed