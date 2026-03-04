# COVID-19 Data Exploration: Global Impact Analysis
**Project Goal:** To explore global COVID-19 data to identify patterns in infection rates, mortality, and vaccination progress using advanced SQL techniques.

##  1. Ask
* **Business Task:** Analyze the relationship between total cases, deaths, and population to determine the impact of COVID-19 across different continents and income levels.
* **Key Questions:** * What is the likelihood of dying if you contract COVID-19 in a specific country?
    * What percentage of the population has been infected?
    * How does the vaccination rate correlate with infection numbers?

##  2. Prepare & Process
* **Data Source:** Our World in Data COVID-19 dataset (Up to date as of your project completion).
* **Tools Used:** * **SQL Server (SSMS):** Used for data cleaning, joining tables, and advanced querying.
    * **Tableau:** Used for creating the final visual dashboard.
* **SQL Skills Demonstrated:** * **Joins:** Combining Deaths and Vaccinations tables.
    * **CTEs & Temp Tables:** To perform calculations on newly created columns.
    * **Window Functions:** Using `SUM(PARTITION BY)` for rolling vaccination counts.
    * **Aggregate Functions:** `MAX`, `SUM`, and `AVG` for global summaries.

##  3. Analyze & Share
* **Key Insights:**
    * **Mortality Rate:** Identified countries with the highest death-to-case ratios.
    * **Infection Density:** Tracked the spread of the virus relative to population size over time.
    * **Vaccination Progress:** Calculated the percentage of the population that received at least one vaccine dose using rolling totals.

##  4. Findings Summary
1. **Global Variance:** Significant differences in mortality rates were observed between high-income and low-income nations.
2. **Vaccination Velocity:** The data highlights a distinct lag in vaccination rates in specific geographic regions compared to global averages.

---
### Files in this Repository
* `CovidPortfolioProject.sql`: The full SQL script containing all exploration queries.
* `Covid 19 Dashboard SH.pdf`: Screenshots of the Tableau dashboard.
