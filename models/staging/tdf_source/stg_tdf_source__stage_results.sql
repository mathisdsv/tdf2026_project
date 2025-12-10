WITH source AS (
  SELECT * FROM {{ source('tdf_source', 'stage_results') }}
)

SELECT
-- Remplace colonne : extrait tout après le chevron "»" (y compris les espaces)
  TRIM(SPLIT(stagetitle, '»')[OFFSET(1)]) AS stagetitle,
  SAFE_CAST(year AS INT64) AS year,
  SAFE_CAST(stage AS INT64) AS stage_number,
  SAFE_CAST(rnk AS INT64) AS rank,
  SAFE_CAST(gc AS INT64) AS general_classement,
  -- !!! Attention time et timelag forcés en type STRING pour éviter les conversions auto de BQ (A re caster et cleaner dans le bon type si nécessaire)
  SAFE_CAST(timelag AS STRING) AS timelag, 
  SAFE_CAST(bib AS INT64) AS n_dossard,
  SAFE_CAST(specialty AS STRING) AS specialty,
  SAFE_CAST(age AS INT64) AS age,
  -- Ajout une colonne "rider_name" : valeurs de "rider_href" (Prénom Nom)
  SAFE_CAST(INITCAP(REPLACE(REPLACE(rider_href, 'rider/', ''), '-', ' ')) AS STRING) AS rider_name,
  SAFE_CAST(team AS STRING) AS team,
  SAFE_CAST(IFNULL(pnt, 0) AS FLOAT64) AS points,
  -- !!! Attention time et timelag forcés en type STRING pour éviter les conversions auto de BQ (A re caster et cleaner dans le bon type si nécessaire)
  SAFE_CAST(time AS STRING) AS time
FROM source
WHERE year >= 2015

