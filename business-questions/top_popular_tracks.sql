-- Displaying top 3 the most popular tracks for each playlist

select *
from ((select track_id,
              pls.playlist_url,
              trc.track_popularity,
              DENSE_RANK() over (partition by trc.playlist_id order by track_popularity desc ) as Row_Id
       from denormalized_model.tracks trc
                JOIN denormalized_model.playlists pls on trc.playlist_id = pls.playlist_id)) as tp
where Row_Id <= 3