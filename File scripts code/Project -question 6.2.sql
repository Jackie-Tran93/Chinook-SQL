# 6.2 How many tracks have been purchased vs not purchased?
 SELECT 
 		(SELECT count(*) From track) AS Total, 
 		COUNT(DISTINCT i.TrackID) AS TracksPurchased, 
         (SELECT count(*) From track) -cast(COUNT(DISTINCT i.TrackID)as float) AS NotTracksPurchased
 FROM InvoiceLine i;