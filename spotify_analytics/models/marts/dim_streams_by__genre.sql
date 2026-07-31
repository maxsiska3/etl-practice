select
    ROUND(AVG(total_streams_million), 1) as average_per_million,
    primary_genre
from {{ ref('dim_artist__summary') }}
group by 
    primary_genre
having
    COUNT(primary_genre) >= 5
order by 
    average_per_million desc