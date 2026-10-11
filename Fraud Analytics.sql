SELECT current_database();

DROP TABLE IF EXISTS "Transactions";

CREATE TABLE "Transactions" (
    transaction_id INT,
    time DOUBLE PRECISION,
    v1 DOUBLE PRECISION,
    v2 DOUBLE PRECISION,
    v3 DOUBLE PRECISION,
    v4 DOUBLE PRECISION,
    v5 DOUBLE PRECISION,
    v6 DOUBLE PRECISION,
    v7 DOUBLE PRECISION,
    v8 DOUBLE PRECISION,
    v9 DOUBLE PRECISION,
    v10 DOUBLE PRECISION,
    v11 DOUBLE PRECISION,
    v12 DOUBLE PRECISION,
    v13 DOUBLE PRECISION,
    v14 DOUBLE PRECISION,
    v15 DOUBLE PRECISION,
    v16 DOUBLE PRECISION,
    v17 DOUBLE PRECISION,
    v18 DOUBLE PRECISION,
    v19 DOUBLE PRECISION,
    v20 DOUBLE PRECISION,
    v21 DOUBLE PRECISION,
    v22 DOUBLE PRECISION,
    v23 DOUBLE PRECISION,
    v24 DOUBLE PRECISION,
    v25 DOUBLE PRECISION,
    v26 DOUBLE PRECISION,
    v27 DOUBLE PRECISION,
    v28 DOUBLE PRECISION,
    amount DOUBLE PRECISION,
    class INT,
    hour INT,
    time_period VARCHAR(50),
    amount_bucket VARCHAR(20),
    transaction_type VARCHAR(20),
    elapsed_hours DOUBLE PRECISION
);


SELECT *
FROM "Transactions"
LIMIT 5;


-- 1.Overall Fraud KPIs
SELECT
    COUNT(*) AS total_transactions,

    SUM(CASE WHEN class = 1 THEN 1 ELSE 0 END) AS fraud_transactions,

    SUM(CASE WHEN class = 0 THEN 1 ELSE 0 END) AS legitimate_transactions,

    ROUND(
        (100.0 * SUM(CASE WHEN class = 1 THEN 1 ELSE 0 END) / COUNT(*))::numeric,
        2
    ) AS fraud_rate,

    ROUND(
        SUM(CASE WHEN class = 1 THEN amount ELSE 0 END)::numeric,
        2
    ) AS fraud_amount

FROM "Transactions";


--2. Fraud by Hour
SELECT
    hour,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN class = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    ROUND(
        (
            100.0 * SUM(CASE WHEN class = 1 THEN 1 ELSE 0 END)
            / COUNT(*)
        )::numeric,
        3
    ) AS fraud_rate
FROM "Transactions"
GROUP BY hour
ORDER BY hour;


--3.Fraud by Time Period
SELECT
    time_period,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN class = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    ROUND(
        (
            100.0 * SUM(CASE WHEN class = 1 THEN 1 ELSE 0 END)
            / COUNT(*)
        )::numeric,
        3
    ) AS fraud_rate
FROM "Transactions"
GROUP BY time_period
ORDER BY fraud_rate DESC;


--4. Fraud by Amount Bucket
SELECT
    amount_bucket,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN class = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    ROUND(
        (
            100.0 * SUM(CASE WHEN class = 1 THEN 1 ELSE 0 END)
            / COUNT(*)
        )::numeric,
        3
    ) AS fraud_rate
FROM "Transactions"
GROUP BY amount_bucket
ORDER BY fraud_rate DESC;


--5. Fraud vs Legitimate Amount Analysis
SELECT
    transaction_type,
    COUNT(*) AS transactions,
    ROUND(AVG(amount)::numeric, 2) AS average_amount,
    ROUND(
        PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY amount)::numeric,
        2
    ) AS median_amount,
    ROUND(SUM(amount)::numeric, 2) AS total_amount,
    ROUND(MAX(amount)::numeric, 2) AS maximum_amount
FROM "Transactions"
GROUP BY transaction_type;


--6. Top 5 Highest-Fraud Hours
SELECT
    hour,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN class = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    ROUND(
        (
            100.0 * SUM(CASE WHEN class = 1 THEN 1 ELSE 0 END)
            / COUNT(*)
        )::numeric,
        3
    ) AS fraud_rate
FROM "Transactions"
GROUP BY hour
HAVING COUNT(*) >= 100
ORDER BY fraud_rate DESC
LIMIT 5;


--7. High-Amount Candidate Trigger
SELECT
    COUNT(*) AS flagged_transactions,
    SUM(CASE WHEN class = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    ROUND(
        (
            100.0 * SUM(CASE WHEN class = 1 THEN 1 ELSE 0 END)
            / COUNT(*)
        )::numeric,
        3
    ) AS historical_fraud_rate,
    ROUND(SUM(amount)::numeric, 2) AS flagged_transaction_value
FROM "Transactions"
WHERE amount > 500;


--8. Combined Candidate Alert Trigger
SELECT
    COUNT(*) AS flagged_transactions,
    SUM(CASE WHEN class = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    ROUND(
        (
            100.0 * SUM(CASE WHEN class = 1 THEN 1 ELSE 0 END)
            / COUNT(*)
        )::numeric,
        3
    ) AS historical_fraud_rate,
    ROUND(SUM(amount)::numeric, 2) AS flagged_transaction_value
FROM "Transactions"
WHERE amount > 500
  AND time_period = '00-04 Late Night';

  