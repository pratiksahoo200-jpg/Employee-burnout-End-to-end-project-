# HR Burnout Risk Analytics Dashboard (End-to-End Project)

An end-to-end HR Analytics project focused on analyzing employee wellness and identifying burnout risk drivers using **Python, SQL, and Power BI**.  
The project delivers actionable insights for HR teams through KPI reporting, risk segmentation, and an interactive multi-page Power BI dashboard.

---

## 📌 Project Objective
- Identify employees at **high burnout risk**
- Analyze key burnout drivers such as **stress level, sleep hours, work hours, job satisfaction, and manager support**
- Rank high-risk departments and job roles
- Build an interactive dashboard to support HR decision-making and interventions

---

## 📂 Dataset
- Source: Public / found dataset (HR wellness / burnout dataset)
- Records: **5,000 employees**
- Key columns:
  - `burnout_risk`, `stress_level`, `sleep_hours`, `work_hours`
  - `job_satisfaction`, `manager_support`, `productivity_score`
  - `department`, `job_title`, `remote_work`, `location`

---

## 🛠️ Tools & Technologies
### Programming / Analysis
- **Python**: Pandas, NumPy
- **Visualization**: Matplotlib, Seaborn
- **Machine Learning**: Scikit-learn (classification model for burnout risk prediction)

### Querying / Reporting
- **SQL**: CTEs, CASE statements, Aggregations, Window Functions (`DENSE_RANK`)

### BI & Dashboarding
- **Power BI**
- **DAX Measures**
- **Power Query (M)**
- Data Modeling (relationships, slicers, drilldowns)

---

## 🔎 Workflow (End-to-End)
1. **Data Collection**
   - Identified and downloaded the HR wellness dataset

2. **Python Data Cleaning & EDA**
   - Cleaned and prepared data using Pandas/NumPy
   - Performed EDA to understand distributions, missing values, and trends
   - Generated visuals using Matplotlib and Seaborn

3. **Machine Learning (Scikit-learn)**
   - Built a classification model to support burnout risk prediction
   - Evaluated model performance using metrics

4. **SQL Analysis**
   - KPI Summary: total employees, burnout %, avg stress/sleep/productivity
   - Burnout risk % by department and ranking using `DENSE_RANK()`
   - Productivity difference (low vs high burnout)
   - Remote work impact analysis
   - Manager support impact on burnout probability
   - Risk scoring model to flag high-risk employees

5. **Power BI Dashboard**
   - Built a **5-page interactive Power BI dashboard**
   - Implemented calculated metrics using DAX
   - Added slicers (department, job title, etc.) for drilldowns

---

## 📊 Dashboard Pages (Power BI)
### 1) Executive Summary
- Total Employees, High Burnout %, Avg Stress, Avg Sleep, Avg Productivity
- Burnout distribution and department ranking

### 2) Burnout Analysis
- Stress vs Burnout
- Sleep vs Burnout
- Job Satisfaction and Manager Support by Burnout Risk

### 3) Department Analysis
- Burnout hotspots by department and job title
- Productivity comparison

### 4) Remote & Location Insights
- Remote work vs burnout and productivity
- State-wise burnout map insights

### 5) HR Action Dashboard
- High-risk employees list with risk flag
- KPIs: High Burnout Employees, Critical Risk Employees, Productivity Drop %

---

## 📌 Key DAX Measures
- Total Employees
- High Burnout Employees
- High Burnout %
- Avg Stress / Avg Sleep / Avg Work Hours
- Avg Productivity
- Productivity Drop %
- Critical Risk Employees

---

## ✅ Key Insights
- High burnout employees show **higher stress levels** and **lower sleep hours**
- Burnout is strongly linked with **job satisfaction** and **manager support**
- Certain departments and job roles show consistently higher burnout risk
- Remote work and location trends help identify burnout hotspots geographically
