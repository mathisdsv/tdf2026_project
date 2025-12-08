with 

source as (

    select * from {{ source('tdf_source', 'rider_results') }}

),

renamed as (

    select
        riderhref,
        year,
        date,
        _result,
        unnamed__4,
        race,
        distance,
        pointspcs,
        pointsuci

    from source

)

select * from renamed