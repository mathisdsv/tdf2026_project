with 

source as (

    select * from {{ source('tdf_source', 'stage_results') }}

),

renamed as (

    select
        stagetitle,
        year,
        stage,
        rnk,
        gc,
        timelag,
        bib,
        h2h,
        specialty,
        age,
        rider,
        rider_href,
        team,
        pnt,
        time

    from source

)

select * from renamed