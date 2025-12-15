{{ config(materialized='view') }}

WITH base AS (

    SELECT *
    FROM {{ ref('final_table') }}

),

jerseys AS (

    SELECT
        year,
        rider_name,

        -- maillots
        MAX(CASE WHEN jersey_type = 'gc' THEN 1 ELSE 0 END) AS has_gc,
        MAX(CASE WHEN jersey_type = 'points' THEN 1 ELSE 0 END) AS has_points,
        MAX(CASE WHEN jersey_type = 'mountain' THEN 1 ELSE 0 END) AS has_mountain,
        MAX(CASE WHEN jersey_type = 'white' THEN 1 ELSE 0 END) AS has_white,
        MAX(CASE WHEN jersey_type = 'combativity' THEN 1 ELSE 0 END) AS has_combativity

    FROM {{ ref('stg_tdf_jersey_winner') }}
    GROUP BY year, rider_name

),

joined AS (

    SELECT
        b.*,

        j.has_gc,
        j.has_points,
        j.has_mountain,
        j.has_white,
        j.has_combativity,

        -- indicateur global
        CASE
            WHEN GREATEST(
                COALESCE(j.has_gc, 0),
                COALESCE(j.has_points, 0),
                COALESCE(j.has_mountain, 0),
                COALESCE(j.has_white, 0),
                COALESCE(j.has_combativity, 0)
            ) = 1 THEN 1
            ELSE 0
        END AS has_any_jersey

    FROM base b
    LEFT JOIN jerseys j
        ON b.year_year = j.year
       AND b.rider_name = j.rider_name
)

SELECT *
FROM joined