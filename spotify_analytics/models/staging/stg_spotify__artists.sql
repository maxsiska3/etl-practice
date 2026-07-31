select
    Artist as artist_name,
    Sex as sex,
    Country as country,
    Langugage as language,
    "Primary Genre" as primary_genre,
    " Artist Type" as artist_type,
    "Total Streams (in millions)" as total_streams_million,
    COALESCE("Lead Streams (in millions)", 0) as lead_streams_million,
    COALESCE("Feature Streams (in millions)", 0) as feature_streams_million,
    COALESCE("Solo Streams (in millions)", 0) as solo_streams_million
from {{ ref('raw_spotify') }}
