
-- 1) KPI Summary
WITH base AS (
  SELECT *
  FROM employee_wellness
)
SELECT
  COUNT(*) AS total_employees,
  SUM(burnout_risk = 'High')   AS high_burnout_employees,
  ROUND(100 * SUM(burnout_risk = 'High') / COUNT(*), 2) AS high_burnout_pct,
  ROUND(AVG(stress_level), 2) AS avg_stress,
  ROUND(AVG(sleep_hours), 2)  AS avg_sleep,
  ROUND(AVG(productivity_score), 2) AS avg_productivity
FROM base;

-- 2) Burnout Risk % by Department + Ranking
WITH dept AS (
  SELECT
    department,
    COUNT(*) AS total_emp,
    SUM(burnout_risk = 'High') AS high_burnout
  FROM employee_wellness
  GROUP BY department
)
SELECT
  department,
  total_emp,
  high_burnout,
  ROUND(100 * high_burnout / total_emp, 2) AS high_burnout_pct,
  DENSE_RANK() OVER (ORDER BY (high_burnout / total_emp) DESC) AS risk_rank
FROM dept
ORDER BY high_burnout_pct DESC, total_emp DESC;

-- 3) Productivity Drop from Low -> High Burnout
WITH burn_prod AS (
  SELECT
    burnout_risk,
    ROUND(AVG(productivity_score), 2) AS avg_productivity
  FROM employee_wellness
  GROUP BY burnout_risk
)
SELECT
  MAX(CASE WHEN burnout_risk='Low' THEN avg_productivity END) AS low_burnout_prod,
  MAX(CASE WHEN burnout_risk='High' THEN avg_productivity END) AS high_burnout_prod,
  ROUND(
    MAX(CASE WHEN burnout_risk='Low' THEN avg_productivity END) -
    MAX(CASE WHEN burnout_risk='High' THEN avg_productivity END),
    2
  ) AS productivity_drop
FROM burn_prod;


-- 4) Sleep vs Burnout + Productivity
WITH banded AS (
  SELECT
    CASE
      WHEN sleep_hours < 5 THEN '01) <5 hours'
      WHEN sleep_hours < 6 THEN '02) 5–6 hours'
      WHEN sleep_hours < 7 THEN '03) 6–7 hours'
      WHEN sleep_hours < 8 THEN '04) 7–8 hours'
      ELSE '05) >8 hours'
    END AS sleep_band,
    burnout_risk,
    productivity_score,
    stress_level
  FROM employee_wellness
)
SELECT
  sleep_band,
  burnout_risk,
  COUNT(*) AS employees,
  ROUND(AVG(productivity_score), 2) AS avg_productivity,
  ROUND(AVG(stress_level), 2) AS avg_stress
FROM banded
GROUP BY sleep_band, burnout_risk
ORDER BY sleep_band, burnout_risk;


-- 5) Remote Work Impact
WITH rw AS (
  SELECT
    remote_work,
    COUNT(*) AS total_emp,
    SUM(burnout_risk='High') AS high_burnout
  FROM employee_wellness
  GROUP BY remote_work
)
SELECT
  remote_work,
  total_emp,
  high_burnout,
  ROUND(100 * high_burnout / total_emp, 2) AS high_burnout_pct,
  ROUND(AVG(stress_level), 2) AS avg_stress,
  ROUND(AVG(job_satisfaction), 2) AS avg_satisfaction,
  ROUND(AVG(productivity_score), 2) AS avg_productivity
FROM employee_wellness e
JOIN rw USING(remote_work)
GROUP BY remote_work, total_emp, high_burnout
ORDER BY high_burnout_pct DESC;


-- 6) Remote Work Impact
WITH rw AS (
  SELECT
    remote_work,
    COUNT(*) AS total_emp,
    SUM(burnout_risk='High') AS high_burnout
  FROM employee_wellness
  GROUP BY remote_work
)
SELECT
  remote_work,
  total_emp,
  high_burnout,
  ROUND(100 * high_burnout / total_emp, 2) AS high_burnout_pct,
  ROUND(AVG(stress_level), 2) AS avg_stress,
  ROUND(AVG(job_satisfaction), 2) AS avg_satisfaction,
  ROUND(AVG(productivity_score), 2) AS avg_productivity
FROM employee_wellness e
JOIN rw USING(remote_work)
GROUP BY remote_work, total_emp, high_burnout
ORDER BY high_burnout_pct DESC;


-- 7) Manager Support Band -> Burnout Probability
WITH ms AS (
  SELECT
    CASE
      WHEN manager_support BETWEEN 1 AND 3 THEN 'Low (1–3)'
      WHEN manager_support BETWEEN 4 AND 7 THEN 'Medium (4–7)'
      ELSE 'High (8–10)'
    END AS manager_support_band,
    COUNT(*) AS total_emp,
    SUM(burnout_risk='High') AS high_burnout
  FROM employee_wellness
  GROUP BY manager_support_band
)
SELECT
  manager_support_band,
  total_emp,
  high_burnout,
  ROUND(100 * high_burnout / total_emp, 2) AS high_burnout_pct
FROM ms
ORDER BY high_burnout_pct DESC;


-- 8) Tenure Band + Burnout
WITH scored AS (
  SELECT
    id, first_name, last_name, department, jobtitle, remote_work,
    work_hours, sleep_hours, stress_level, job_satisfaction, manager_support,
    burnout_risk, productivity_score,

    (
      (stress_level * 10) +
      ((10 - job_satisfaction) * 6) +
      ((10 - manager_support) * 5) +
      CASE WHEN sleep_hours < 6 THEN 12 ELSE 0 END +
      CASE WHEN work_hours > 9 THEN 8 ELSE 0 END
    ) AS risk_score
  FROM employee_wellness
)
SELECT
  *,
  DENSE_RANK() OVER (ORDER BY risk_score DESC) AS risk_rank
FROM scored
ORDER BY risk_score DESC
LIMIT 50;



