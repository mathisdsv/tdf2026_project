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
        specialty,
        age,
        rider,
        rider_href,
        team,
        IFNULL(pnt, 0) as pnt,
        time,

        
    from source

)

select * from renamed