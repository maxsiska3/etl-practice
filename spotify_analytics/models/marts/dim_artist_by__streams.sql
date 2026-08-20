select
    artist_name,
    sum(total_streams_million) as total_streams_million
from
    {{ ref('dim_artist__summary') }}
group by
    artist_name
order by
    total_streams_million desc, artist_name
limit 10
