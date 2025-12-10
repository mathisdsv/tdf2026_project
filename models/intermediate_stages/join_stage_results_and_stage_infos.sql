{{ config(materialized="table") }}

WITH results AS (

    SELECT
        year,
        stage_number AS stage,
        stagetitle AS stage_title_raw,
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
        stage_title,
        year,
        stage_number,
        stage_date,
        avg_speed_kmh,
        distance_km,
        final_km_gradient,
        profile_score,
        vertical_meters,
        departure_city,
        arrival_city,
        startlist_quality_score,
        win_type
    FROM {{ ref('stg_tdf_source__stage_information') }}

),

cleaned_results AS (

    SELECT
        -- Stage title propre
        TRIM(stage_title_raw) AS stage_title,

        year,
        stage,
        rank,
        general_classement,
        timelag,
        n_dossard,
        specialty,
        age,

        -- Normalisation nom des coureurs
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

        -- Infos étape
        s.distance_km,
        s.avg_speed_kmh,
        s.final_km_gradient,
        s.profile_score,
        s.vertical_meters,
        s.startlist_quality_score,
        s.win_type

    FROM cleaned_results r
    LEFT JOIN stages s
        ON r.year = s.year
        AND r.stage = s.stage_number

)

SELECT *
FROM joined