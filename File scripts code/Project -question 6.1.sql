# 6.1 Which artist is used in the most playlists?
 WITH 
  Playlist_Artist AS (SELECT p. NAME as name_playlist, t.name AS name_track, alb.title, art.name AS Name_Artist
 						FROM playlist p
 						left JOIN playlisttrack
 						ON p.playlistid=playlisttrack.playlistid
 						left join track t
 						ON playlisttrack.trackid=t.trackid
 						left join album alb
 						ON alb.albumid=t.albumid
 						left join artist art
 						ON alb.artistid=art.artistid)
 SELECT Name_Artist, count(*) as In_playlist
 	FROM Playlist_Artist
     GROUP BY Name_Artist
     ORDER BY In_playlist DESC LIMIT 10;