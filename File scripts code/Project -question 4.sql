# Cau 4 Analyzing Employee Sales Performance
 WITH 
 	total_sold AS (SELECT c.supportrepid, SUM(i.total) AS total_sum
                      FROM customer c
                      JOIN invoice  i
                      ON c.customerid =i.customerid
                      GROUP BY c.supportrepid)
 SELECT CONCAT(e.firstname, ' ', e.lastname) AS 	full_name,title,country, ts.total_sum
   FROM employee e 
   JOIN total_sold ts
     ON e.EmployeeId = ts.supportrepid
     ORDER BY total_sum DESC ;
