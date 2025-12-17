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
,
finall as(
SELECT* except(has_any_jersey,has_gc),
IF(has_points = 1,25000,0) as prime_green_kit,
IF(has_mountain = 1,25000,0) as prime_mountain_kit,
IF(has_white = 1,20000,0) as prime_white_kit,
IF(has_combativity = 1, 20000,0)as prime_combatitivity 
FROM final
)
Select rider_name,year_year,team,specialty,categorie_age_coureur,categorie_poid_coureur,height_m,
SUM(cash_prize_final_rank_) as cash_prize_final_rank_,
SUM(cash_price_stage) as cash_price_stage,
SUM(prime_mountain_kit) as prime_mountain_kit,
SUM(prime_green_kit) as prime_green_kit,
SUM(prime_white_kit) as prime_white_kit,
SUM(prime_combatitivity) as prime_combatitivity,
AVG(efficiency) as efficiency,
AVG(win_rate) as win_rate
FROM finall
GROUP BY rider_name,year_year,team,specialty,categorie_age_coureur,categorie_poid_coureur,height_m
order by rider_name,year_year

