Select g.*, e.cash_price_stage
from {{ ref('Classement_general_prime') }} as g 
left join {{ ref('etapes_primes') }} as e
using (rider_name)