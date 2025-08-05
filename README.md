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

### 1. Overall Sales Trends

<img width="1063" height="596" alt="Overall Sales Performance" src="https://github.com/user-attachments/assets/efd44a1c-90f7-4516-91d1-caa861c71912" />

- Nov 2019: Massive spike in total sales and orders → Likely Black Friday/Cyber Monday.
- Mar 2020: Unexpected jump, possibly COVID-related stockpiling.
- Sales patterns mirrored order volume across months.
### 2. Product & Brand Performance
- Top-selling category: construction.tools.light
- The "Unknown Category" had the 3rd highest sales, data quality issue masking opportunity.
- Apple generated highest revenue; Samsung had highest order volume.
- computers.notebook generated high revenue but ranked lower in order count, high-ticket item.
### 3. Customer Behavior Deep Dive
<img width="1066" height="597" alt="Customer Buying Pattern" src="https://github.com/user-attachments/assets/111bbe6e-8217-4c10-9ac0-546a5955c1cd" />

- Sunday was the peak shopping day, a strong signal for promotional timing.
- electronics.smartphone drove ~$32M in Nov 2019 alone, validating the Black Friday impact.
- construction.tools.light showed steady growth with a major Feb 2020 spike.
### 4. Average Order Value (AOV) Analysis
- AOV peaked in early Feb 2020, potentially Valentine's Day influenced.
- AOV for computers.notebook and electronics.smartphone trended down → may be heavily promotion-sensitive.
- AOV for construction.tools.light rose post-Dec 2019 → potential value growth or price hike.
### 5. Average Sales per Customer
- Mirrors AOV trends → peaks in Feb 2020, dips after March.
- Sharp drop post-Feb suggests churn or reduced purchasing due to early pandemic.
- electronics.audio.headphones rose steadily from Dec onward, resilient category during disruption.
### 6. Average Orders per Customer
- Declined in Nov 2019 despite high sales → confirms promotional one-time buyer pattern.
- electronic.clocks showed flat, low repeat behavior → stable, low-engagement product.
### 7. Cross-Metric Patterns & Category Behavior
<img width="1063" height="595" alt="Cross-Metrics Comparison" src="https://github.com/user-attachments/assets/b810476e-337d-4c19-99c8-46599b370229" />

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
### 2. Promotions & Pricing
- Categories like smartphones and notebooks are highly sensitive to promotions. test adjusted pricing in off-peak seasons.
- Consider strategic bundles or extended warranties to increase order value without reducing margin.
### 3. Inventory Strategy
- Ensure adequate stock during key events (Black Friday, Valentine’s, early March).
- Use AOV and Avg Orders metrics to predict volume per category.
### 4. Category Development
- construction.tools.light shows momentum, double down with ad spend and product expansion.
- Reposition "Unknown Category" by resolving metadata issues to unlock hidden patterns.
### 5. Cross-Sell & Loyalty Opportunities
- Audio and headphone categories show repeat engagement, explore cross-sells with smartphones.
- Low-performing but loyal categories (bottom 5) may benefit from increased visibility.
### 6. Marketing Timing
- Sunday spikes suggest ideal times for email pushes and promotions.
- Oct–Feb is a key high-engagement window.

---

## What Could Be Improved
- The category_code field is hierarchical and includes both category and subcategory/product name (e.g., electronics.smartphone). Splitting this into two separate columns, category and product_type would have allowed for more granular analysis (e.g., comparing smartphone vs. headphones across all electronics).
- In future iterations, enriching the dataset with cost information could enable profit margin analysis, not just revenue.
- A customer-level segmentation (e.g., new vs. returning) could further strengthen retention insights.

---
## Final Reflection
This project demonstrates how a BI Analyst bridges technical execution and business strategy. Beyond charts, this work translates data into business actions, improving pricing, marketing, inventory, and customer engagement. The depth of insights and repeat behavior detection reflect how real-world BI teams approach product optimization.

Hiring managers and collaborators: I’m excited to bring this level of problem-solving to your data team.


