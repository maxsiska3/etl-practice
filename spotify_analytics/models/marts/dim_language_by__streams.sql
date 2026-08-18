select
    language,
    sum(total_streams_million) as total_streams_million
from
    {{ ref('dim_artist__summary') }}
group by
    language
order by
    total_streams_million desc
limit 5
