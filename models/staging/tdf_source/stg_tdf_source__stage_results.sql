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
        pnt,
        time,

        IFNULL(pnt, 0) as pnt_clean
    from source

)

select * from renamed