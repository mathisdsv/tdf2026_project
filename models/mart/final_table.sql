WITH join_join AS (
select *
from {{ ref('join_with_type') }}
left join {{ ref('rider_full_info') }}
using (rider_name)
),

finish as(
select * except(year, stage_title, profile_score, time, classics_participation ),
year as year_year,
from join_join
order by year_year, stage, rank ASC

),

finish_2 as(
select 
rider_name,
CASE team
        -- --- WORLD TEAMS ACTUELS (Structures Continues) ---

        -- Team Visma | Lease a Bike (anc. LottoNL-Jumbo / Jumbo-Visma)
        WHEN 'Team LottoNL-Jumbo' THEN 'Team Visma | Lease a Bike'
        WHEN 'Jumbo-Visma' THEN 'Team Visma | Lease a Bike'
        WHEN 'Team Jumbo-Visma' THEN 'Team Visma | Lease a Bike'
        WHEN 'Team Visma | Lease a Bike' THEN 'Team Visma | Lease a Bike'

        -- INEOS Grenadiers (anc. Team Sky / Team Ineos)
        WHEN 'Team Sky' THEN 'INEOS Grenadiers'
        WHEN 'Team Ineos' THEN 'INEOS Grenadiers'
        WHEN 'INEOS Grenadiers' THEN 'INEOS Grenadiers'

        -- Bahrain Victorious (anc. Bahrain Merida / Bahrain-McLaren)
        WHEN 'Bahrain Merida' THEN 'Bahrain Victorious'
        WHEN 'Bahrain Merida Pro Cycling Team' THEN 'Bahrain Victorious'
        WHEN 'Bahrain - McLaren' THEN 'Bahrain Victorious'
        WHEN 'Bahrain Victorious' THEN 'Bahrain Victorious'
        WHEN 'Bahrain - Victorious' THEN 'Bahrain Victorious'


        -- Quick-Step Alpha Vinyl Team (anc. Quick-Step Floors / Deceuninck)
        WHEN 'Quick-Step Floors' THEN 'Soudal Quick-Step'
        WHEN 'Deceuninck - Quick Step' THEN 'Soudal Quick-Step'
        WHEN 'Quick-Step Alpha Vinyl Team' THEN 'Soudal Quick-Step'
        WHEN 'Soudal Quick-Step' THEN 'Soudal Quick-Step'

        -- Red Bull - BORA - hansgrohe (anc. Bora - Argon 18)
        WHEN 'Bora - Argon 18' THEN 'Red Bull - BORA - hansgrohe'
        WHEN 'BORA - hansgrohe' THEN 'Red Bull - BORA - hansgrohe'
        WHEN 'Red Bull - BORA - hansgrohe' THEN 'Red Bull - BORA - hansgrohe'

        -- Groupama - FDJ (anc. FDJ)
        WHEN 'FDJ' THEN 'Groupama - FDJ'
        WHEN 'Groupama - FDJ' THEN 'Groupama - FDJ'

        -- Team DSM (incl. Giant - Alpecin et Sunweb)
        WHEN 'Team Giant - Alpecin' THEN 'Team Picnic PostNL'
        WHEN 'Team Sunweb' THEN 'Team Picnic PostNL'
        WHEN 'Team dsm - firmenich' THEN 'Team Picnic PostNL'
        WHEN 'Team DSM' THEN 'Team Picnic PostNL'
        WHEN 'Team Picnic PostNL' THEN 'Team Picnic PostNL'
        WHEN 'Team Picnic PostNL' THEN 'Team Picnic PostNL'
        WHEN 'Team dsm-firmenich PostNL' THEN 'Team Picnic PostNL'


        -- UAE Team Emirates (anc. Lampre - Merida)
        WHEN 'Lampre - Merida' THEN 'UAE Team Emirates'
        WHEN 'UAE Team Emirates - XRG' THEN 'UAE Team Emirates'
        WHEN 'UAE Team Emirates' THEN 'UAE Team Emirates'

        -- Astana Qazaqstan Team
        WHEN 'Astana Pro Team' THEN 'Astana Qazaqstan Team'
        WHEN 'Astana - Premier Tech' THEN 'Astana Qazaqstan Team'
        WHEN 'XDS Astana Team' THEN 'Astana Qazaqstan Team'
        WHEN 'Astana Qazaqstan Team' THEN 'Astana Qazaqstan Team'

        -- Team Jayco AlUla (anc. Orica / Mitchelton)
        WHEN 'Orica GreenEDGE' THEN 'Team Jayco AlUla'
        WHEN 'ORICA-BikeExchange' THEN 'Team Jayco AlUla'
        WHEN 'ORICA-Scott' THEN 'Team Jayco AlUla'
        WHEN 'Mitchelton-Scott' THEN 'Team Jayco AlUla'
        WHEN 'Team BikeExchange - Jayco' THEN 'Team Jayco AlUla'
        WHEN 'Team Jayco AlUla' THEN 'Team Jayco AlUla'

        -- EF Education - EasyPost (anc. Cannondale / Drapac)
        WHEN 'Team Cannondale - Garmin' THEN 'EF Education - EasyPost'
        WHEN 'Cannondale - Drapac Pro Cycling Team' THEN 'EF Education - EasyPost'
        WHEN 'EF Pro Cycling' THEN 'EF Education - EasyPost'
        WHEN 'Team EF Education First - Drapac p/b Cannondale' THEN 'EF Education - EasyPost'
        WHEN 'EF Education - EasyPost' THEN 'EF Education - EasyPost'

        -- Intermarché - Wanty (anc. Wanty - Gobert)
        WHEN 'Wanty - Gobert Cycling Team' THEN 'Intermarché - Wanty'
        WHEN 'Intermarché - Wanty - Gobert Matériaux' THEN 'Intermarché - Wanty'
        WHEN 'Intermarché - Circus - Wanty' THEN 'Intermarché - Wanty'
        WHEN 'Intermarché - Wanty' THEN 'Intermarché - Wanty'
        WHEN 'Wanty - Groupe Gobert' THEN 'Intermarché - Wanty'

        -- Israel - Premier Tech (INCLUT KATUSHA)
        WHEN 'Israel Start-Up Nation' THEN 'Israel - Premier Tech'
        WHEN 'Israel - Premier Tech' THEN 'Israel - Premier Tech'
        WHEN 'Team Katusha' THEN 'Israel - Premier Tech'
        WHEN 'Team Katusha Alpecin' THEN 'Israel - Premier Tech'

        -- Decathlon AG2R La Mondiale Team (anc. AG2R)
        WHEN 'AG2R La Mondiale' THEN 'Decathlon AG2R La Mondiale Team'
        WHEN 'AG2R Citroën Team' THEN 'Decathlon AG2R La Mondiale Team'
        WHEN 'Decathlon AG2R La Mondiale Team' THEN 'Decathlon AG2R La Mondiale Team'

        -- Lidl - Trek (anc. Trek Factory Racing)
        WHEN 'Trek Factory Racing' THEN 'Lidl - Trek'
        WHEN 'Lidl - Trek' THEN 'Lidl - Trek'
        WHEN 'Trek - Segafredo' THEN 'Lidl - Trek'
        -- Lidl - Trek (anc. Trek Factory Racing)

        -- Movistar Team
        WHEN 'Movistar Team' THEN 'Movistar Team'

        -- Cofidis
        WHEN '"Cofidis, Solutions Crédits"' THEN 'Cofidis'
        WHEN 'Cofidis' THEN 'Cofidis'

        -- Lotto Dstny (Équipe belge)
        WHEN 'Lotto' THEN 'Lotto Dstny'
        WHEN 'Lotto Soudal' THEN 'Lotto Dstny'
        WHEN 'Lotto Dstny' THEN 'Lotto Dstny'

        -- Team Qhubeka NextHash
        WHEN 'MTN - Qhubeka' THEN 'Team Qhubeka NextHash'
        WHEN 'Team Dimension Data' THEN 'Team Qhubeka NextHash'
        WHEN 'Team Qhubeka NextHash' THEN 'Team Qhubeka NextHash'
        WHEN 'NTT Pro Cycling' THEN 'Team Qhubeka NextHash'

        -- Arkéa - B&B Hotels (Groupe français continu ET B&B Hôtels dissous)
        WHEN 'Bretagne - Séché Environnement' THEN 'Arkéa - B&B Hotels'
        WHEN 'Team Fortuneo - Samsic' THEN 'Arkéa - B&B Hotels'
        WHEN 'Team Arkéa Samsic' THEN 'Arkéa - B&B Hotels'
        WHEN 'Arkéa - B&B Hotels' THEN 'Arkéa - B&B Hotels'
        WHEN 'B&B Hotels - Vital Concept p/b KTM' THEN 'Arkéa - B&B Hotels' 
        WHEN 'B&B Hotels - KTM' THEN 'Arkéa - B&B Hotels' 
        WHEN 'B&B Hotels - KTM' THEN 'Arkéa - B&B Hotels' 
        WHEN 'B&B Hotels p/b KTM' THEN 'Arkéa - B&B Hotels' 

        -- Tinkoff Legacy
        WHEN 'Tinkoff - Saxo' THEN 'Tinkoff Legacy'
        WHEN 'Tinkoff' THEN 'Tinkoff Legacy'

        -- --- ÉQUIPES RÉCENTES OU SPÉCIFIQUES ---
        WHEN 'Uno-X Pro Cycling Team' THEN 'Uno-X Mobility'
        WHEN 'Uno-X Mobility' THEN 'Uno-X Mobility'

        WHEN 'BMC Racing Team' THEN 'Tudor Pro Cycling Team'
        WHEN 'CCC Team' THEN 'Tudor Pro Cycling Team' 
        WHEN 'IAM Cycling' THEN 'Tudor Pro Cycling Team'
        WHEN 'Tudor Pro Cycling Team' THEN 'Tudor Pro Cycling Team'
        -- 
        WHEN 'Alpecin - Deceuninck' THEN 'Alpecin'
        WHEN 'Alpecin - Fenix' THEN 'Alpecin'
        --
        WHEN 'Cofidis, Solutions Crédits' THEN 'Cofidis'
        WHEN 'Cofidis' THEN 'Cofidis'

        --
        WHEN 'EF Education - EasyPost' THEN 'EF Education - EasyPost'
        WHEN 'EF Education First' THEN 'EF Education - EasyPost'
        --
        WHEN 'Team Total Direct Energie' THEN 'Team TotalEnergie'
        WHEN 'Team TotalEnergies' THEN 'Team TotalEnergie'
        WHEN 'TotalEnergie' THEN 'Team TotalEnergie'
        WHEN 'Direct Energie' THEN 'Team TotalEnergie'
        WHEN 'Team TotalEnergies' THEN 'Team TotalEnergie'
        WHEN 'Team Europcar' THEN 'Team TotalEnergie'
        -- Par défaut, toute équipe non listée est conservée comme son propre groupe unifié
        ELSE team
    END AS team,

year_year,
stage,
rank,
points,
general_classement,
specialty,
age,
CASE
    WHEN age < 25 THEN 'Jeune'
    WHEN age >= 25 AND age < 30 THEN 'Prime'
    WHEN age >= 30 AND age < 35 THEN 'Expérimenté'
    WHEN age >= 35 AND age < 40 THEN 'Vétéran'
    ELSE 'Doyen'
  END as categorie_age_coureur,
parcours_type,
CASE
  WHEN parcours_type = "1" THEN 'Flat'
  WHEN parcours_type = "2" THEN 'Hills, flat finish'
  WHEN parcours_type = "3" THEN 'Hills, uphill finish'
  WHEN parcours_type = "4" THEN 'Mountains, flat finish'
  WHEN parcours_type = "5" THEN 'Mountains, uphill finish'
  ELSE NULL 
END AS parcours_category,
distance_km,
  CASE
    WHEN age < 25 THEN 'Jeune'
    WHEN age >= 25 AND age < 30 THEN 'Prime'
    WHEN age >= 30 AND age < 35 THEN 'Expérimenté'
    WHEN age >= 35 AND age < 40 THEN 'Vétéran'
    ELSE 'Doyen'
  END as categorie_age_coureur,
avg_speed_kmh,
final_km_gradient,
vertical_meters,
startlist_quality_score,
win_type,
nb_races,
nb_wins,
weight_kg,
CASE
  WHEN weight_kg < 60 THEN 'Plume'
  WHEN weight_kg >= 60 AND weight_kg < 68 THEN 'Fin'
  WHEN weight_kg >= 68 AND weight_kg < 76 THEN 'Athlétique'
  WHEN weight_kg >= 76 AND weight_kg <= 82 THEN 'Robuste'
  ELSE 'Massif'
END AS categorie_poid_coureur,
height_m,
grand_tours_participation, 
efficiency,
win_rate,
IF (rank=1,1,0) as victoire_etape

from finish 
)
select *
 from finish_2 

