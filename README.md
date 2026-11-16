# Customer Shopping Behavior Analysis

## Overview
An end-to-end data analytics project examining retail shopping patterns across 3,900 customer transactions. The objective is to identify key revenue drivers, evaluate discount and subscription performance, and segment customers to support data-driven marketing and product decisions.

## Tech Stack
- **Python (Pandas, SQLAlchemy, pyodbc):** Data cleaning, exploratory analysis, feature engineering, and database loading.
- **Microsoft SQL Server:** Structured querying to answer core business questions.
- **Power BI:** Interactive dashboarding and visual reporting.

## Repository Structure
```text
├── data/
│   └── customer_shopping_behavior.csv   # Raw transactional dataset (3,900 rows, 18 columns)
├── data_cleaning.ipynb                  # Python preprocessing and SQL Server ingestion pipeline
├── SQLQuery1.sql                        # SQL queries answering 10 business questions
├── customer_analysis.pbix               # Interactive Power BI dashboard
└── README.md                            # Project documentation
```

## Workflow Summary

### 1. Data Preparation (Python)
- Standardized all column headers to lowercase `snake_case` and renamed `purchase_amount_(usd)` to `purchase_amount`.
- Imputed 37 missing values in `review_rating` using each product category's median rating.
- Verified that `promo_code_used` was identical to `discount_applied` across all rows and removed the redundant column.
- Engineered quartile-based `age_group` segments (`Young Adult`, `Adult`, `Middle Age`, `Senior`) and mapped purchase frequency labels into numeric day intervals (`frequency_days`).
- Loaded the cleaned dataset into SQL Server (`customer_behaviour.dbo.customer`).

### 2. Business Analysis (SQL Server)
Executed 10 SQL queries covering revenue distribution by gender and age group, discount usage behavior, top-rated and best-selling items per category, shipping type spend comparison, customer loyalty segmentation, and subscription conversion gaps.

### 3. Visualization (Power BI)
Built an interactive executive dashboard featuring KPI cards (`3.9K` customers, `$59.76` average order value, `3.75` average review rating), category and age-group revenue/sales charts, subscription split visuals, and dynamic slicers for Subscription Status, Gender, Age Group, and Shipping Type.

## Key Insights & Recommendations
- **Subscription Conversion:** Only 27% of customers are subscribers, while 2,518 repeat buyers (>5 purchases) remain unsubscribed. Introducing targeted membership perks can grow recurring revenue.
- **Customer Retention:** 79.9% (3,116) of buyers fall into the Loyal segment (>10 purchases). Tiered loyalty rewards should be prioritized to retain this core base.
- **Discount Management:** 839 shoppers used discounts while still spending above the `$59.76` average, whereas items like Hats (50.0%) and Sneakers (49.7%) rely heavily on markdowns. Auditing high-discount items will help protect profit margins.
- **Growth Segments:** Clothing is the top-performing category (`$104.3K` revenue), and Young Adults generate the highest revenue (`$62,143`), making them primary targets for seasonal campaigns.
