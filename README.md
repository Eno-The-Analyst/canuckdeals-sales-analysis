# Optimizing Product Strategy for a Canadian E-Commerce Retailer (CanuckDeals Inc.)

## Project Summary
This business intelligence project simulates a real-world scenario involving a mid-sized Canadian e-commerce company, CanuckDeals Inc., experiencing shifting sales patterns and evolving customer behavior. Using SQL and Power BI, the analysis explores product performance, customer engagement, and external impacts like promotions and the COVID-19 pandemic. The goal is to provide actionable insights and strategic recommendations to optimize product strategy, inventory, and marketing.

---

## Table of Contents

- [Project Summary](#project-summary)
- [Business Objective](#business-objective)
- [Tools & Skills Applied](#tools--skills-applied)
- [Data Source](#data-source)
- [Data Preparation & Modeling](#data-preparation--modeling)
- [Exploratory Data Analysis Codes](#exploratory-data-analysis-codes)
- [Key Insights](#key-insights)
- [Recommendations](#recommendations)
- [What Could Be Improved](#what-could-be-improved)
- [Final Reflection](#final-reflection)

---

## Business Objective
Help CanuckDeals Inc.:

- Identify top-performing and underperforming product categories
- Understand customer purchasing behavior and loyalty
- Quantify the effects of external events (e.g., promotions, pandemic)
- Support business decisions with clear, data-driven recommendations

---

## Tools & Skills Applied
- SQL (SQLite): CTEs, data type handling, filtering, transformation, deduplication
- Power BI: Star schema modeling, Power Query, Date Dimension creation, DAX measures
- EDA: Customer behavior analysis, trend spotting, seasonality analysis
- Storytelling with Data: Clear insights + business-aligned recommendations

---

## Data Source
- **Source**: [Kaggle E-commerce Behavior Dataset](https://www.kaggle.com/datasets/mkechinov/ecommerce-behavior-data-from-multi-category-store)
- **Time Range**: October 2019 – April 2020
- **Size**: ~1 million rows, 9 columns per file across 7 months

---

## Data Preparation & Modeling
- Combined monthly CSVs into a single SQLite table
- Cleaned nulls in key fields (brand/category_code → placeholders)
- Removed duplicates using CTE + ROW_NUMBER()
- Filtered only purchase events to build the purchases fact table
- Extracted time components (year, month, weekday) using STRFTIME
- Created star schema in Power BI with a custom DateTable
- Connected via ODBC and built calculated columns & measures

---

## Exploratory Data Analysis Codes

```sql
--Top Selling Product Categories--
SELECT category_code, COUNT(*) as number_of_purchases
FROM purchases
GROUP BY category_code
ORDER BY number_of_purchases DESC
LIMIT 10;
--Least Selling Product Categories--
SELECT category_code, COUNT(*) as number_of_purchases
FROM purchases
GROUP BY category_code
ORDER BY number_of_purchases ASC
LIMIT 10;
--Total Revenue Per Product Category--
SELECT category_code, SUM(price) as total_revenue
FROM purchases
GROUP BY category_code
ORDER BY total_revenue DESC
LIMIT 10;
```
---

## Key Insights

### 1. Sales Performance/Overview

<img width="928" height="521" alt="Overview" src="https://github.com/user-attachments/assets/fb2ffdba-b475-48d1-a946-45b48986bf7d" />

- Nov 2019 & Dec 2019: Massive spike in total sales and orders → Likely Black Friday/Cyber Monday and holiday shopping season.
- Mar 2020: Unexpected jump, possibly COVID-related stockpiling.
- Apr 2020: Lowest sales and order volumes → early pandemic impact and shift to lower-value purchases.
- Sales patterns mirrored order volume across months.
### 2. Product Performance
- Electronices dominates both revenue and volume; core growth driver.
- "Unknown Product and "Unknown Category" rank among top performers; data quality issue masking opportunity.
- TVs, Lights and Headphones are strong product performers; Appliances and Computers hold mid-tier positions.
- Bottom categories (country_yard, medicine and stationery) contribute negligible revenue.
### 3. Customer Purchasing Pattern

<img width="1064" height="596" alt="Customer Purchasing Pattern" src="https://github.com/user-attachments/assets/61a2b3b9-026d-4c04-99e8-9d1372d042d6" />

- Sunday and Monday are the peak shopping days, a strong signal for promotional timing.
- Although the Furniture category did not show up on the top 5categories sold or ordered, it shows up as the 5th category in AOV; signalling it as a higher price category.
### 4. Low Performing Product-Category
- For both bottom 5 products and bottom 5 categories, average Sales per Customer is greater than AOV which indicates high spending customers overall but low contribution from these items.
- The Sport category, although low perfroming, trended not too badly over the year but did not translate to significant sales and could benefit from targeted marketing strategy.
- Seasonal peaks overall failed to create sustained demand for these low performers.
  <img width="1063" height="595" alt="Low-Performing Product-Category" src="https://github.com/user-attachments/assets/71548710-067d-4540-811d-241d35ef9cde" />

### 5. Average Order Value (AOV) Analysis
- AOV trend peaks in Feb 2020 and it is driven by the Electronics, Sofas and TVs category and product.
- Among the top 5 AOV by category trend, the furniture and appliance remained low through the year.
- Lights, although among the top 5 products, trended low in Oct and Nov 2019, among other top products.
### 6. Average Sales per Customer Reporting
- Mirrors AOV trends → peaks in Feb 2020 (a strong high value purchase month), dips after March.
- Sharp drop post-Feb suggests churn or reduced purchasing due to early pandemic.
- Electronics and computers are stand out categories among the top categories over months and tv and sofa are top products among the top 5 products.
### 7. Average Orders per Customer Reporting
- Declined in Nov 2019 despite high sales, which confirms promotional one-time buyer pattern.
- An unusual line up of top repeat buying products (cpu, diapers, headphone and videocards) and the bottom 
products in this category reveals low repeat behavior → stable, low-engagement products.
### 8. Metrics Comparison Insights
<img width="931" height="520" alt="Metrics Comparison" src="https://github.com/user-attachments/assets/705782da-bc2a-4115-af17-a06d9561bab7" />

- Oct, Nov, Feb: Aligned peaks in AOV and Avg Orders → high engagement & revenue synergy.
- Jan: Higher AOV, lower order count → post-holiday selective buying.
- Apr: Fewer orders, higher AOV → pandemic bulk-buy behavior.
- Top 5 categories: Avg Sales per Customer > AOV → strong multi-order behavior.
- Bottom 5 categories showed same trend → undervalued areas with high loyalty potential.

---
## Recommendations
### Customer Retention Strategy
- Nov 2019’s spike came from one-time shoppers. use retargeting or loyalty rewards to convert them.
- Monitor post-promotion behavior to avoid drop-offs.
- Use personalized follow-ups for high spending customers in low performing product categories.
### 2. Promotions & Pricing
- Replicate the Feb 2020 high-value mix in other months to lift AOV and Average Sales per Customer.
- Categories like smartphones and notebooks are highly sensitive to promotions. test adjusted pricing in off-peak seasons.
- For low AOV categories, consider strategic bundles, extended warranties to increase order value without reducing margin and premium add ons instead of straight discounting.
### 3. Inventory Strategy
- Ensure adequate stock during key events (Black Friday, Valentine’s, early March).
- Stock high volume SKUs for Nov and high value SKUs for Feb.
- Use AOV and Avg Orders metrics to predict volume per category.
### 4. Category Development
- Fix "Unknown Product/Category" classification to reveal hidden opportunities.
- Increase visibility for mid-tier categories and products with targeted campaigns.
- Phase out or reposition chronically underperforming categories.
### 5. Cross-Sell & Loyalty Opportunities
- Target Electronics buyers with complementary offers e.g. accessories, etc.
- Use high spending customer segments to cross sell low performing products.
- Low-performing but loyal categories (bottom 5) may benefit from increased visibility.
### 6. Marketing Timing
- Concentrate campaigns on Sunday-Monday to match peak buying behavior.
- Oct–Feb is a key high-engagement window.
- Pre load promotions ahead of Nov and Feb spikes; fill demand gaps in Jan and Apr with limited time offers.

---

## What Could Be Improved
- The metadata for categories and products needs to be fixed. Probably creating some constraints on category, sub-category and products columns to avoid blanks in the table design will help ensure that data is captured for those columns to improve analysis and forecast.
- In future iterations, enriching the dataset with cost information could enable profit margin analysis, not just revenue.
- A customer-level segmentation (e.g., new vs. returning) could further strengthen retention insights.

---
## Final Reflection
This project demonstrates how a BI Analyst bridges technical execution and business strategy. Beyond charts, this work translates data into business actions, improving pricing, marketing, inventory, and customer engagement. The depth of insights and repeat behavior detection reflect how real-world BI teams approach product optimization.

Hiring managers and collaborators: I’m excited to bring this level of problem-solving to your data team.


