### Customer Lifetime Value (CLV) Project

### Project Summary: 
- In this project, I performed a detailed cohort analysis to estimate Customer Lifetime Value (CLV) by analyzing weekly revenue and registration cohorts, as per the instructions. The goal was to address the limitations of Shopify’s simplistic CLV formula by considering all user registrations (not just purchasers) and analyzing customer retention over a 12-week period.

#### Steps Taken:
Data Extraction and Preparation:

- I queried the turing_data_analytics.raw_events table to extract the necessary data for calculating weekly revenue and registrations.
The registration cohort was determined by the user's first visit to the site, tracked using user_pseudo_id.
Weekly Revenue by Cohorts:

For each weekly cohort, I calculated the weekly revenue per registration (i.e., dividing total revenue by the number of users who visited during a particular week).
- I adjusted the dataset to include all users, not just those who made a purchase, ensuring that the full scope of user activity was considered.
Cumulative Revenue Calculation:

- Using the weekly average revenue per cohort, I calculated cumulative revenue over time (up to week 12) to understand the revenue growth by cohort.
I calculated averages for each week since registration and derived percentage growth based on those averages.
#### Predictive Analysis:

- To estimate future revenue, I applied the cumulative growth percentages to predict the expected revenue for cohorts acquired after the final available week (2021-01-24).
- This allowed me to forecast revenue for up to 12 weeks for newly acquired cohorts, providing an actionable view of CLV growth.
Visualization:

#### The results were visualized in three charts:
Weekly Average Revenue by Cohorts (USD)
Cumulative Revenue by Cohorts (USD)
Revenue Prediction by Cohorts (USD)
Conditional formatting was applied to highlight trends and make the data easier to interpret.

### Project Overview: RFM Graded Task Suggested Solution
The project focuses on calculating and segmenting customers based on the RFM (Recency, Frequency, Monetary) model. This model is used in marketing analytics to classify customers based on their purchasing behavior, helping businesses target specific segments effectively.

## RFM Score Calculation:
The RFM model is built by calculating three main scores: Recency (R), Frequency (F), and Monetary (M).

- Recency: This measures how recently a customer made a purchase. It is calculated by finding the difference in days between the current date and the customer’s last purchase date. The recency score is divided into four quartiles, with lower scores indicating that the customer has purchased more recently.

- Frequency: This measures how often a customer makes a purchase. The frequency score is also divided into quartiles, with higher scores indicating frequent purchases.

- Monetary: This measures how much money a customer has spent. The monetary score is divided into quartiles, with higher values indicating customers who have spent more.

Each of these scores is assigned a value between 1 and 4, based on the distribution of the data. For instance:

- For Recency (R): A recency score of 4 means a customer has recently made a purchase, while a score of 1 indicates that the customer’s last purchase was far in the past.
- For Frequency (F): A frequency score of 4 indicates high purchase frequency, while 1 shows low frequency.
- For Monetary (M): A monetary score of 4 indicates high spending, while 1 indicates low spending.
  
## Data Segmentation
After calculating the individual scores for each customer, the project segments the customers into various categories based on the combination of their RFM scores. These segments are critical for targeting marketing efforts. The following customer segments are defined based on the RFM scores:

- Best Customers: High recency, high frequency, and high monetary score.
- Loyal Customers: High recency and frequency, moderate monetary score.
- Potential Loyalists: High recency, moderate frequency and monetary score.
- Recent Customers: High recency, low frequency, and low monetary score.
- Promising: Moderate recency, frequency, and monetary scores.
- At Risk: Low recency, high monetary score.
- Hibernating: Low recency, low frequency, and low monetary score.
- Lost Customers: Low recency, low frequency, and low monetary score.
  
These segments help businesses understand which customers need more attention and which groups are most likely to respond to specific marketing campaigns.

### Visualization and Dashboard
To present the RFM results, an RFM Bubble Chart is used. This visualization displays all three RFM scores in a single chart, with customers' segments marked for easy identification. Additionally, the Segment Descriptions page is included to provide further insights into each segment, offering users detailed information about the segment’s characteristics, score ranges, and targeted marketing strategies.

## Conclusion

The RFM project provides a comprehensive analysis of customer behavior, segmenting users into actionable categories for targeted marketing. The process includes thorough data exploration, cleaning, and validation, followed by calculating and segmenting customers based on their purchasing behavior. The use of dashboards and visualizations ensures that stakeholders can easily interpret the results and implement data-driven marketing strategies.





