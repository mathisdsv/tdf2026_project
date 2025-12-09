with 

source as (

    select * from {{ source('tdf_source', 'rider_information') }}

),

renamed as (

    select
        riderhref,
        year,
        weight,
        height,
        onedayraces as one_day_races,
        onedayraces_bar,
        gc as general_classement,
        gc_bar,
        tt as time_trial,
        tt_bar,
        sprint,
        sprint_bar,
        climber,
        climber_bar,
        hills,
        hills_bar,
        wins as nb_wins,
        grand_tours as grand_tours_participation,
        classics as classics_participation

    from source

),

cleaning as (
    select 
INITCAP(REPLACE(REPLACE(riderhref, 'rider/', ''), '-', ' ')) as rider_name,
year,
REPLACE(weight, 'kg','') as weight_kg,
REPLACE(height, 'm','') as height_m,
one_day_races,
general_classement,
time_trial,
sprint,
climber,
hills,
nb_wins, 
grand_tours_participation,
classics_participation
    from renamed
),


cleanshit as( 
    select *
from (
    select 
        *,
        -- On crée une colonne temporaire 'rang'
        ROW_NUMBER() OVER (PARTITION BY rider_name ORDER BY year DESC) as rang
    from cleaning
) as sub
where rang = 1  -- On ne garde que le 'vainqueur' (l'année la plus récente)
)

select * EXCEPT(rang) from cleanshit