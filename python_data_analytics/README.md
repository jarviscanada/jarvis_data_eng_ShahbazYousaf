# Introduction
London Gift Shop (LGS) is a well-established UK-based online store specializing in gift-ware. With a primary customer base comprising wholesalers, LGS aims to enhance its revenue growth by leveraging the latest data technologies. The LGS marketing team seeks to gain deeper insights into customer behavior through a proof of concept (PoC) project. The goal is to analyze customer shopping patterns. The insights generated will be utilized by the marketing team to develop targeted campaigns such as email promotions and events to attract both new and existing customers. Technologies utilized include Python, Numpy, Pandas, Matplotlib, Docker, PSQL, and Jupyter Notebook.

# Implementation
## Project Architecture
The London Gift Shop (LGS) project architecture centers around understanding customer behavior and improving marketing strategies for the online store. The core components include the LGS online store, a dataset (retail.sql) spanning from 01/12/2009 to 09/12/2011, and an Extract, Transform, Load (ETL) process that removes personal information for privacy. Deployment involves running Jupyter Notebook via Docker on a virtual machine (VM), with results delivered to LGS through Jupyter Notebook and GitHub. The goal is to use insights from the analysis to guide LGS in improving targeted marketing campaigns, such as email, events, and promotions.

<p align="center">
  <img src="../assets/python_analytics_arch.drawio.png" alt="Python Analytics Architecture Diagram">
</p>

```
![Python Analytics Architecture Diagram](../assets/python_analytics_arch.drawio.png)
```
## Data Analytics and Wrangling
Jupyter Notebook: [retail_data_analytics_wrangling.ipynb](python_data_analytics/retail_data_analytics_wrangling.ipynb)

The data analysis involves examining attributes such as invoice number, product code, product name, quantity, invoice date, unit price, customer ID, and country. The goal is to uncover patterns and trends in customer behavior, allowing the LGS marketing team to make informed decisions. The derived analytics will serve as a foundation for the development of targeted marketing strategies, enabling LGS to augment revenue through personalized campaigns, promotions, and customer engagement initiatives. Beyond general insights, the analysis employs the RFM market research method to classify customers into three distinct segments: "Can't Lose," "Hibernating," and "Champions."

Can't Lose Segment;
Customers in this segment haven't made recent purchases, signaling a potential risk. To re-engage this segment, a discount and gift campaign is recommended. While these customers have a history of making substantial purchases, their recency values are currently lower than optimal. The proposed campaign should encompass both items previously purchased, and recommendations based on historical activities. Additionally, introducing new and popular products aligned with their past interests can enhance the effectiveness of the campaign. Investigating factors that may cause these customers to discontinue their purchases is crucial for long-term retention.

Hibernating Segment;
Customers in this segment have not made a purchase for an extended period. A targeted approach involving discounts may serve as a catalyst to reignite their interest and prompt another purchase.

Champions Segment;
Customers in the Champions segment significantly contribute to overall revenue. To maintain their loyalty, and sustain and enhance their shopping frequency, specialized campaigns should be implemented. These campaigns could include exclusive promotions, loyalty rewards, or personalized incentives to ensure the continued patronage of these valuable customers.


# Improvements
Implement a predictive modeling component to forecast customer preferences and optimize inventory management.

Explore additional data sources beyond the provided dataset to enrich customer profiles and improve the accuracy of marketing strategies.

Integrate real-time data processing capabilities for more dynamic and adaptive marketing campaigns.

