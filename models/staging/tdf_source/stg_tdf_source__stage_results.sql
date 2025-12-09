WITH source AS (
  SELECT * FROM {{ source('tdf_source', 'stage_results') }}
)

SELECT
-- Remplace colonne : extrait tout après le chevron "»" (y compris les espaces)
  TRIM(SPLIT(stagetitle, '»')[OFFSET(1)]) AS stagetitle,
  year,
  stage,
  rnk,
  gc,
  timelag,
  bib,
  specialty,
  age,
  rider,
  rider_href,
  team,
  IFNULL(pnt, 0) AS pnt,
  time
FROM source

