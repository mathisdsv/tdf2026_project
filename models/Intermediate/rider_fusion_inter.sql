with 

rider_date as (

    select *
    from {{ ref('stg_tdf_source__rider_results') }}
    INNER JOIN {{ ref('stg_tdf_source__rider_information') }}
    USING(rider_name)

)

select * EXCEPT(year) from rider_date