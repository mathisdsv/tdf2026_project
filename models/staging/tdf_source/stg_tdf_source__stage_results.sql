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
  -- Ajout une colonne "rider_name" : valeurs de "rider_href" (Prénom Nom)
  INITCAP(REPLACE(REPLACE(rider_href, 'rider/', ''), '-', ' ')) as rider_name,
  team,
  IFNULL(pnt, 0) AS pnt,
  time
FROM source
WHERE year >= 2015

