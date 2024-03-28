-- Track popularity in cumulative distribution partitioned for each playlist

select trc.track_popularity,
       trc.playlist_id,
       ROUND((CUME_DIST() over (partition by trc.playlist_id ORDER BY trc.track_popularity))::numeric, 3) as cume_dist
from denormalized_model.tracks trc
