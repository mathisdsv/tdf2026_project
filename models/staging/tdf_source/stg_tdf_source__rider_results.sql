with 

source as (

    select * from {{ source('tdf_source', 'rider_results') }}

),

renamed as (

    select
        riderhref,
        year,
        result,
        race,
        distance,
        pointspcs,
        pointsuci

    from source

)

select * from renamed