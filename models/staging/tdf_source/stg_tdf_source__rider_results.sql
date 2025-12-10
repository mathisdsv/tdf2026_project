with 

source as (

    select * from {{ source('tdf_source', 'rider_results') }}

),
-- CAST pour que les format soient ok et NULL enlevés sur les points

renamed as (

    select
        
        INITCAP(REPLACE(REPLACE(riderhref, 'rider/', ''), '-', ' ')) as rider_name,
        SAFE_CAST(year as INT64) as year_year,
        date_date,
        SAFE_CAST(result as INT64) as result,
        race,
        SAFE_CAST(distance as FLOAT64) as distance,
        IFNULL(pointspcs,0) as pointspcs,
        IFNULL(pointsuci,0) as pointsuci,

    from source
---Date_date supprimé car on va regrouper les résultats/points par années+date avec format bizarre
-- null supp pour distances et années après 2015
),
modif1 as (
    select 
    rider_name,
    year_year,
    result,
    race,
    distance,
    pointspcs,
    pointsuci,
    
    from renamed
)
select *
 from modif1
