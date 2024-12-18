
WITH clean AS (SELECT *
FROM `turing_data_analytics.rfm`
WHERE CustomerID IS NOT NULL
AND Quantity > 0
AND UnitPrice > 0),
date_select AS (SELECT *
FROM clean
WHERE InvoiceDate BETWEEN '2010-12-01' AND '2011-11-30'),
fm AS (SELECT CustomerID, Country, MAX(CAST(InvoiceDate AS  DATE)) AS last_purchase_date,
COUNT(DISTINCT InvoiceDate) AS frequency,
SUM(Quantity*UnitPrice) AS monetary
FROM date_select
GROUP BY CustomerID, Country),
r as (SELECT *, DATE_DIFF(CAST('2011-12-01' AS DATE), last_purchase_date, DAY) AS recency
FROM fm),
percentiles as (SELECT *,
a.prnct[offset(25)] AS r25,
a.prnct[offset(50)] AS r50,
a.prnct[offset(75)] AS r75,
b.prnct[offset(25)] AS f25,
b.prnct[offset(50)] AS f50,
b.prnct[offset(75)] AS f75,
c.prnct[offset(25)] AS m25,
c.prnct[offset(50)] AS m50,
c.prnct[offset(75)] AS m75,
FROM r, (SELECT APPROX_QUANTILES(recency, 100) prnct FROM r) a,
(SELECT APPROX_QUANTILES(frequency, 100) prnct FROM r) b,
(SELECT APPROX_QUANTILES(monetary, 100) prnct FROM r) c),
rfm AS (SELECT *, CAST(ROUND((f_score + m_score) / 2, 0) AS INT64) AS fm_score
FROM (SELECT *, CASE WHEN monetary <= m25 THEN 1
WHEN monetary <= m50 AND monetary > m25 THEN 2
WHEN monetary <= m75 AND monetary > m50 THEN 3
WHEN monetary > m75 THEN 4
END AS m_score,
CASE WHEN frequency <= f25 THEN 1
WHEN frequency <= f50 AND frequency > f25 THEN 2
WHEN frequency <= f75 AND frequency > f50 THEN 3
WHEN frequency > f75 THEN 4
END AS f_score,
CASE WHEN recency <= r25 THEN 4
WHEN recency <= r50 AND recency > r25 THEN 3
WHEN recency <= r75 AND recency > r50 THEN 2
WHEN recency > r75 THEN 1
END AS r_score, 
FROM percentiles))
SELECT CustomerID, Country, recency, frequency, monetary, r_score, f_score, m_score, fm_score,
CASE WHEN r_score = 4 AND fm_score = 4 THEN 'Best Customers'
WHEN (r_score = 4 AND fm_score = 3) OR (r_score = 3 AND fm_score = 4) THEN 'Loyal Customers'
WHEN (r_score = 4 AND fm_score = 2) OR (r_score = 3 AND fm_score = 3) THEN 'Potential Loyalists'
WHEN r_score = 4 AND fm_score = 1 THEN 'Recent Customers'
WHEN (r_score = 3 AND fm_score = 1) OR (r_score = 3 AND fm_score = 2) THEN 'Promising'
WHEN r_score = 2 AND fm_score = 4 THEN 'At Risk'
WHEN r_score = 2 AND fm_score = 1 THEN 'About to Sleep'
WHEN (r_score = 2 AND fm_score = 3) OR (r_score = 2 AND fm_score = 2) THEN 'Customers Needing Attention'
WHEN (r_score = 1 AND fm_score = 4) OR (r_score = 1 AND fm_score = 3) THEN 'Cant Lose Them'
WHEN r_score = 1 AND fm_score = 2 THEN 'Hibernating'
WHEN r_score = 1 AND fm_score = 1 THEN 'Lost Customers'
END rfm_segment
FROM rfm;
