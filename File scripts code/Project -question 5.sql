# Cau 5


 With no_of_country AS(
 SELECT c.customerid, CASE
 						WHEN cc.count_distinct =1 THEN 'Other'
 						ELSE c.country
 						END country,
                     CASE
 						WHEN cc.count_distinct=1 THEN 1
                         ELSE 0
                         END country_no
 FROM customer c
 JOIN (SELECT country, count(*) AS count_distinct
 		FROM customer c
         GROUP BY country) cc
 ON c.country=cc.country)
 SELECT noc.country,
 		COUNT(DISTINCT noc.customerid) AS total_customer,
         SUM(i.total) AS total_value_sale,
         ROUND(SUM(i.total)/COUNT(DISTINCT noc.customerid),2) avr_value_customer,
         ROUND(SUM(i.total)/COUNT(noc.customerid),2) avr_value_order
 	FROM no_of_country noc
     JOIN invoice i
     ON noc.customerid=i.customerid
     GROUP BY noc.country
     ORDER BY total_value_sale DESC;