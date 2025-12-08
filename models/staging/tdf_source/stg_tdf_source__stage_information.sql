with 

source as (

    select * from {{ source('tdf_source', 'stage_information') }}

),

renamed as (

    select

    from source

)

select * from renamed