/* Using this dataset, show the SQL query to find the rolling 3 day average transaction amount for each day in January 2021. */

WITH date_convert AS (
	SELECT 
  		date(transaction_time) AS sale_date,
  		SUM(transaction_amount) AS daily_sale_amount
	FROM transactions
  	GROUP BY sale_date
  )

SELECT 
   sale_date, 
   daily_sale_amount,
   CASE WHEN COUNT(*) OVER (ORDER BY sale_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) = 3 
      THEN AVG(daily_sale_amount) OVER (ORDER BY sale_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
      ELSE 0
   END AS rolling_three_day_avg
FROM date_convert
ORDER BY sale_date
