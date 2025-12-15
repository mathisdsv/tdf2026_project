{{ config(materialized='view') }}

WITH base AS (

    SELECT *
    FROM {{ ref('prime_general_and_stage') }}

),

jerseys AS (

    SELECT
        year,
        rider_name,

        MAX(CASE WHEN jersey_type = 'gc' THEN 1 ELSE 0 END) AS has_gc,
        MAX(CASE WHEN jersey_type = 'points' THEN 1 ELSE 0 END) AS has_points,
        MAX(CASE WHEN jersey_type = 'mountain' THEN 1 ELSE 0 END) AS has_mountain,
        MAX(CASE WHEN jersey_type = 'white' THEN 1 ELSE 0 END) AS has_white,
        MAX(CASE WHEN jersey_type = 'combativity' THEN 1 ELSE 0 END) AS has_combativity

    FROM {{ ref('stg_tdf_jersey_winner') }}
    GROUP BY year, rider_name

),

final AS (

    SELECT
        b.*,

        IFNULL(j.has_gc, 0)           AS has_gc,
        IFNULL(j.has_points, 0)       AS has_points,
        IFNULL(j.has_mountain, 0)     AS has_mountain,
        IFNULL(j.has_white, 0)        AS has_white,
        IFNULL(j.has_combativity, 0)  AS has_combativity,

        -- indicateur global
        IF(
            IFNULL(j.has_gc, 0)
          + IFNULL(j.has_points, 0)
          + IFNULL(j.has_mountain, 0)
          + IFNULL(j.has_white, 0)
          + IFNULL(j.has_combativity, 0) > 0,
            1,
            0
        ) AS has_any_jersey

    FROM base b
    LEFT JOIN jerseys j
        ON b.year_year = j.year
       AND b.rider_name = j.rider_name

)

SELECT *
FROM final