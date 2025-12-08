with 

source as (

    select * from {{ source('tdf_source', 'rider_information') }}

),

renamed as (

    select
        riderhref,
        year,
        weight,
        height,
        onedayraces,
        onedayraces_bar,
        gc,
        gc_bar,
        tt,
        tt_bar,
        sprint,
        sprint_bar,
        climber,
        climber_bar,
        hills,
        hills_bar,
        wins,
        grand_tours,
        classics

    from source

)

select * from renamed