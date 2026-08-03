select
    ROUND(AVG(total_streams_million), 1) as avg_streams_million,
    country
from {{ ref('dim_artist__summary') }}
group by
    country
having count(country) >= 5
order by
    avg_streams_million desc
