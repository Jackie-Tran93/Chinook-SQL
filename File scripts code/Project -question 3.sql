WITH unit_track_sold AS (
  	     SELECT il.*
             FROM Invoiceline il 
    		   JOIN invoice i 
  		     ON il.InvoiceId = i.InvoiceId 
  		  WHERE  i.BillingCountry = 'USA')

   SELECT g.name AS genre_name,
          COUNT(uts.invoicelineid) AS track_sold,
          ROUND(CAST(COUNT(uts.invoicelineid) AS FLOAT)*100/(SELECT COUNT(*)
                                                               FROM unit_track_sold AS uts),2) AS percent_genre
	FROM unit_track_sold uts
	JOIN track t
    ON uts.trackid = t.trackid
	JOIN genre g
    ON t.genreid = g.genreid
	GROUP BY genre_name
	ORDER BY track_sold DESC
	LIMIT 10;