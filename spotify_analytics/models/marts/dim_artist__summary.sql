select
    artist_name,
    sex,
    country,
    language,
    primary_genre,
    artist_type,
    total_streams_million,
    lead_streams_million,
    feature_streams_million,
    solo_streams_million
from {{ ref('stg_spotify__artists') }}
