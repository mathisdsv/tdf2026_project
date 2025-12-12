Select
rider_name, 
nb_races, 
nb_wins, 
weight_kg,
height_m,
grand_tours_participation,
classics_participation, 
efficiency,
win_rate,
specialty,
team,
age,
from {{ ref('rider_full_info') }}