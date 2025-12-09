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
REPLACE(onedayraces_bar,"w","") as onedayraces_bar,
general_classement,
REPLACE(gc_bar,"w","") as gc_bar,
time_trial,
REPLACE(tt_bar,"w","") as tt_bar,
sprint,
REPLACE(sprint_bar,"w","") as sprint_bar,
climber,
REPLACE(climber_bar,"w","") as climber_bar,
hills,
REPLACE(hills_bar,"w","") as hills_bar,
nb_wins, 
grand_tours_participation,
classics_participation
        -- Tes transformations ici

    from renamed
)

select * from cleaning