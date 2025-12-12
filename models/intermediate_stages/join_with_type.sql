{{ config(materialized="table") }}

WITH results AS (

    SELECT
        year,
        stage_number AS stage,
        stage_title AS stage_title_raw,

        rank,
        general_classement,
        timelag,
        n_dossard,
        specialty,
        age,
        rider_name,
        team,
        points,
        time
    FROM {{ ref('stg_tdf_source__stage_results') }}

),

stages AS (

    SELECT
        year,
        stage_number,
        profile_score,
        distance_km,
        avg_speed_kmh,
        final_km_gradient,
        vertical_meters,
        startlist_quality_score,
        win_type
    FROM {{ ref('stg_tdf_source__stage_information') }}

),

with_type AS (

    SELECT
        year,
        stage AS stage_number,
        ANY_VALUE(parcours_type) AS parcours_type
    FROM {{ ref('clean_info_with_type') }}
    GROUP BY year, stage

),

cleaned_results AS (

    SELECT
        TRIM(stage_title_raw) AS stage_title,

        year,
        stage,
        rank,
        general_classement,
        timelag,
        n_dossard,
        specialty,
        age,

        INITCAP(REPLACE(REPLACE(rider_name, 'rider/', ''), '-', ' ')) AS rider_name,

        team,
        points,
        time
    FROM results

),

joined AS (

    SELECT
        r.year,
        r.stage,
        r.stage_title,

        -- Infos coureurs
        r.rank,
        r.general_classement,
        r.specialty,
        r.age,
        r.rider_name,
        r.team,
        r.points,
        r.time,

        s.profile_score,
        wt.parcours_type,
        s.distance_km,
        s.avg_speed_kmh,
        s.final_km_gradient,
        s.vertical_meters,
        s.startlist_quality_score,
        s.win_type

    FROM cleaned_results r
    LEFT JOIN stages s
        ON r.year = s.year
       AND r.stage = s.stage_number

    LEFT JOIN with_type wt
        ON r.year = wt.year
       AND r.stage = wt.stage_number

)

SELECT *
FROM joined