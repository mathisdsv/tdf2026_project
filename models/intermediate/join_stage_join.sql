Select 
    * 
From {{ ref('stg_tdf_source__stage_information') }} AS stage_info
    Full Outer join {{ ref('stg_tdf_source__stage_results') }} AS stage_results  