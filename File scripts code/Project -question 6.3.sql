# 6.3 Do protected vs non-protected media types have an effect on popularity?
 WITH pt AS (
 SELECT il.trackid, mt.song, mt.name_media media_type, sum(il.quantity) unit_sold
 FROM invoiceline il
 		LEFT JOIN (SELECT t.trackid, t.name song, mt.name name_media
 			FROM track t
 			LEFT JOIN mediaType mt
 			ON t.mediatypeid=mt.mediatypeid ) mt
			ON il.trackid=mt.trackid      
 		GROUP BY il.trackid)
 SELECT 
 	media_type, sum(unit_sold) track_sold
 FROM pt
 GROUP BY 1
 ORDER BY 2 DESC;