WITH join_join AS (
select *
from {{ ref('join_with_type') }}
left join {{ ref('rider_full_info_for_join') }}
using (rider_name)
),

finish as(
select *
from join_join
)
select * from finish 