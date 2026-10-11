# Credit Card Fraud & Risk Analytics

**AICTE | IBM SkillsBuild Data Analytics with AI Internship 2026 | BharatCares**

## Project overview
This project analyzes historical credit-card transactions to understand fraud frequency, transaction amount patterns, time-based patterns, and candidate fraud-alert thresholds. It is a data analytics project using Python and descriptive statistics; it does **not** train a machine-learning classifier or claim real-time fraud prevention.

**Business question:** Which historical transaction patterns are associated with fraud, and what candidate triggers should a risk team investigate?

## Dataset
Download the dataset from Kaggle:
https://www.kaggle.com/datasets/mlg-ulb/creditcardfraud

Download `creditcard.csv` and place it in the same directory as the notebook before running it.

The source dataset typically contains `Time`, `V1`–`V28`, `Amount`, and `Class`. `Class=0` means legitimate and `Class=1` means fraud. The `V1`–`V28` fields are anonymized PCA components and should not be assigned business meanings.

## Technologies used
- Python
- pandas and NumPy
- Matplotlib and Seaborn
- Jupyter Notebook
- Power BI for the dashboard (built separately from the exported CSV)
- PostgreSQL can be used for additional SQL-based analysis

## Project files
- `YashBhosale_CreditCardFraudRiskAnalytics.ipynb` — complete analysis workflow
- `requirements.txt` — Python dependencies
- `YashBhosale_ProjectReport.docx` — project documentation
- `README.md` — this file

## Setup and run
1. Install Python 3.10 or later.
2. Download `creditcard.csv` from the Kaggle link above.
3. Put `creditcard.csv` beside the notebook.
4. Create and activate a virtual environment (optional but recommended).
5. Install dependencies:

   ```bash
   pip install -r requirements.txt
   ```

6. Start Jupyter:

   ```bash
   jupyter notebook
   ```

7. Open `YashBhosale_CreditCardFraudRiskAnalytics.ipynb` and run cells from top to bottom.
8. The notebook creates an `outputs/` folder containing a cleaned CSV and summary tables. Import `outputs/creditcard_clean.csv` into Power BI if you want to reproduce the dashboard.

## Analysis included
- Data quality checks and preparation
- KPI summary: total, fraud and legitimate transactions, fraud rate and fraud amounts
- Fraud rate by hour
- Fraud rate by transaction amount bucket
- Fraud rate by time period
- Average and total transaction amount comparisons
- Exploratory candidate alert-trigger analysis

## Single AI-assisted step
AI is used **once** to help interpret verified descriptive-analysis outputs. The notebook provides one prompt to summarize actual KPI and candidate-trigger results into cautious, evidence-based observations. All numeric calculations are produced by Python and checked against the analysis tables. AI is not used to fabricate data, train a model, or automatically classify transactions.

## Limitations
- Historical dataset; no live transactions or real-time alerts.
- No merchant, geographic, customer-demographic, or payment-channel details.
- PCA variables `V1`–`V28` are anonymized.
- Candidate thresholds are exploratory and must be validated for false positives, fraud capture, cost, and performance on later-period data before real-world use.

## Expected outputs
After running the notebook, check the `outputs/` folder for:
- `creditcard_clean.csv`
- `kpi_summary.csv`
- `fraud_by_hour.csv`
- `fraud_by_amount_bucket.csv`
- `fraud_by_time_period.csv`
- `amount_summary.csv`
- `candidate_alert_trigger_analysis.csv`
