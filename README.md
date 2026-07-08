# 🛒 Retail Sales Intelligence & Customer Analytics System

&gt; Complete Data Analytics & Business Intelligence Platform for Retail Organizations

---

## 📊 Project Overview

A comprehensive **Retail Analytics Platform** that transforms raw transactional data into meaningful business intelligence reports and predictive insights.

**Internship Project** | Data Analytics / Business Intelligence

---

## 🎯 Key Features

| Module | Description |
|--------|-------------|
| 📁 **30-Table Database** | MySQL relational database with full schema |
| 🔍 **100+ SQL Queries** | Advanced analytics with window functions, CTEs |
| 🐍 **Python Models** | Sales forecasting & customer segmentation |
| 📈 **Power BI Dashboards** | 5 interactive executive dashboards |
| 🏭 **Data Warehouse** | Star schema for business intelligence |

---

## 🛠️ Technologies Used

| Category | Tools |
|----------|-------|
| **Database** | MySQL 8.0 |
| **Analytics** | SQL, Advanced SQL, Data Warehousing |
| **Visualization** | Power BI |
| **Data Science** | Python, Pandas, Scikit-Learn |

---

## 📂 Project Structure
retail-sales-analytics/
├── 📁 database/          # SQL scripts
│   ├── 01_create_database.sql
│   ├── 02_schema.sql
│   ├── 03_sample_data.sql
│   ├── 04_queries.sql
│   ├── 05_advanced_sql.sql
│   └── 06_data_warehouse.sql
│
├── 📁 python/            # Python analytics
│   ├── sales_forecast.py
│   └── customer_segmentation.py
│
├── 📁 powerbi/           # Dashboards
│   └── retail_dashboard.pbix
│
├── 📁 docs/              # Documentation
│   ├── er_diagram.png
│   ├── project_report.pdf
│   └── screenshots/
│
└── 📁 presentation/      # Project review
└── project_review.pptx


---

## 📊 Dashboards

| # | Dashboard | Insights |
|---|-----------|----------|
| 1 | **Executive Overview** | Revenue, Profit, Customers, Orders KPIs |
| 2 | **Sales Analytics** | Monthly sales, product performance, regional sales |
| 3 | **Customer Analytics** | Segmentation, top customers, retention |
| 4 | **Inventory Analytics** | Stock levels, reorder alerts |
| 5 | **Profitability Dashboard** | Product profit, category analysis |

---

## 🚀 How to Run

### 1. Database Setup
```bash
# Import SQL files to MySQL
mysql -u root -p retail_db < database/01_create_database.sql
mysql -u root -p retail_db < database/02_schema.sql
mysql -u root -p retail_db < database/03_sample_data.sql

## python
cd python
python sales_forecast.py
python customer_segmentation.py

## 3. Power BI Dashboard
Open powerbi/retail_dashboard.pbix
Refresh data connection
📈 Business Questions Solved
✅ Monthly revenue trends?
✅ Top customers & their lifetime value?
✅ Best & worst performing products?
✅ Inventory optimization & reorder alerts?
✅ Regional sales performance?
✅ Sales forecasting for next quarter?
📸 Screenshots
Executive Overview Dashboard
docs/screenshots/dashboard_pages/page1_executive_overview.png
Sales Analytics
docs/screenshots/dashboard_pages/page2_sales_analytics.png
👨‍💻 Author
Pradeesh Napoluri
B.Tech / BCA / MCA Student
Data Analytics & Business Intelligence
📄 License
This project is for educational purposes. MIT License.
🙏 Acknowledgments
Internship Project
MySQL Community
Power BI Community
Python Open Source Community
plain

---

## 🎯 How to Update README

### Option 1: GitHub Web (Easy)
Repo open → README.md
Edit (pencil icon)
Paste content
Commit changes
plain

### Option 2: Local Edit
```bash
# Edit README.md in VS Code
# Save
git add README.md
git commit -m "Updated README with project details"
git push origin main
