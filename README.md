# 🚀 Data Warehouse and Analytics Project

Welcome to the **Data Warehouse and Analytics Project** repository! 🚀

This project demonstrates a comprehensive data warehousing and analytics solution, from building a data warehouse to generating actionable insights. Designed as a portfolio project, it highlights industry best practices in data engineering and analytics.

---

## 📋 Table of Contents

- [Project Overview](#project-overview)
- [Project Requirements](#project-requirements)
  - [Data Engineering – Building the Data Warehouse](#building-the-data-warehouse-data-engineering)
  - [Data Analytics – BI & Reporting](#bi-analytics--reporting-data-analytics)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [License](#license)
- [About Me](#about-me)

---

## 🗂️ Project Overview

This project covers the full lifecycle of a data solution:

- **Data Engineering**: Ingesting raw data from multiple source systems, cleansing it, and loading it into a structured SQL Server data warehouse.
- **Data Analytics**: Writing SQL-based analytical queries to surface insights on customer behavior, product performance, and sales trends.

---

## 🚀 Project Requirements

### Building the Data Warehouse (Data Engineering)

#### Objective
Develop a modern data warehouse using **SQL Server** to consolidate sales data, enabling analytical reporting and informed decision-making.

#### Specifications

- **Data Sources**: Import data from two source systems (ERP and CRM) provided as CSV files.
- **Data Quality**: Cleanse and resolve data quality issues prior to analysis.
- **Integration**: Combine both sources into a single, user-friendly data model designed for analytical queries.
- **Scope**: Focus on the latest dataset only; historization of data is not required.
- **Documentation**: Provide clear documentation of the data model to support both business stakeholders and analytics teams.

---

### BI: Analytics & Reporting (Data Analytics)

#### Objective
Develop SQL-based analytics to deliver detailed insights into:

- **Customer Behavior**
- **Product Performance**
- **Sales Trends**

These insights empower stakeholders with key business metrics, enabling strategic decision-making.

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Database | MYSQL |
| Data Sources | CSV Files (ERP & CRM) |
| Analytics | SQL |
| Documentation | Markdown |

---

## 📁 Project Structure

```
data-warehouse-analytics/
│
├── datasets/               # Raw CSV source files (ERP & CRM)
├── scripts/
│   ├── bronze/             # Raw data ingestion scripts
│   ├── silver/             # Data cleansing & transformation
│   └── gold/               # Analytical data model (final layer)
├── analytics/              # SQL analytics & reporting queries
├── docs/                   # Data model documentation & diagrams
└── README.md
```

---

## ⚡ Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/data-warehouse-analytics.git
   cd data-warehouse-analytics
   ```

2. **Set up SQL Server** – Ensure you have SQL Server (or SQL Server Express) installed and running.

3. **Load source data** – Place the ERP and CRM CSV files in the `datasets/` folder.

4. **Run scripts in order**
   - Execute scripts in `scripts/bronze/` to ingest raw data
   - Execute scripts in `scripts/silver/` to cleanse and transform
   - Execute scripts in `scripts/gold/` to build the final data model

5. **Run analytics** – Execute queries in the `analytics/` folder to generate reports and insights.

---

## 🛡️ License

This project is licensed under the [MIT License](LICENSE). You are free to use, modify, and share this project with proper attribution.

---

## 🌟 About Me

Hi there! I'm **Hare**, a passionate student exploring the world of data engineering and analytics. This project is part of my learning journey to build real-world data skills.

Feel free to connect, ask questions, or contribute to the project. Happy learning! 🎉
