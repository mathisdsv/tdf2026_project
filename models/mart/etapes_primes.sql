With popo as (
SELECT f.*, c.cash_prize_per_stage
FROM {{ ref('final_table') }} as f
full outer join  {{ ref('stg_tdf_source__cash_price') }} as c
ON c.position = f.rank
),

pupu as (
    SELECT
    rider_name,
    team, 
    year_year,
    SUM(IFNULL(cash_prize_per_stage, 0)) as cash_price_stage
    from popo
    group by rider_name, team, year_year
    ORDER BY rider_name, year_year ASC
)

SELECT * from pupu