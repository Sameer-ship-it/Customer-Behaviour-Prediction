# 🛡️ Customer Fraud Risk Scoring

A Machine Learning demo that estimates customer fraud risk (Low / Medium / High) using a trained Logistic Regression model. Built with Python, scikit-learn, FastAPI (REST API) and Streamlit (interactive UI).

---

## Quick Overview

- Input: customer transaction behavior (frequency, order value, bulk orders, weekend orders, invoice hour, etc.)
- Model: Logistic Regression with features scaled by StandardScaler
- Output: fraud probability, risk category, and a recommended business decision (Allow / Manual Review / Flag)

This repository is intended for learning and demonstrations — not for production fraud detection.

---

## Features

- Real-time prediction through a FastAPI endpoint
- Interactive Streamlit dashboard for manual exploration
- Probability-based risk scoring (not just binary)
- Visual gauge (Plotly) showing the risk score
- Saved model and scaler (joblib) for quick start

---

## Risk Classification

| Fraud Probability | Risk Level | Business Decision |
| ----------------- | ---------- | ----------------- |
| `< 30%`           | 🟢 Low     | Allow             |
| `30% - < 70%`     | 🟡 Medium  | Manual Review     |
| `≥ 70%`           | 🔴 High    | Flag / Block      |

---

## Input / Engineered Features

The application accepts raw transaction fields and derives behavioral indicators:

- total_transactions — Total customer transactions
- total_days_active — Days the customer has been active
- total_bulk_orders — Number of bulk orders
- weekend_orders — Number of orders on weekends
- avg_order_value — Average order monetary value
- avg_invoice_hour — Average invoice hour (0–23)

Derived/engineered features used by the model:

- avg_invoice_frequency = total_transactions / max(total_days_active, 1)
- bulk_ratio = total_bulk_orders / max(total_transactions, 1)
- weekend_ratio = weekend_orders / max(total_transactions, 1)

All features are transformed with StandardScaler before being passed to the model.

---

## Quickstart

1. Clone the repo

```bash
git clone https://github.com/Sameer-ship-it/Customer-Behaviour-Prediction.git
cd Customer-Behaviour-Prediction
```

2. Create & activate a virtual environment

On Linux / macOS:

```bash
python -m venv venv
source venv/bin/activate
```

On Windows (PowerShell):

```powershell
python -m venv venv
venv\Scripts\Activate.ps1
```

3. Install dependencies

```bash
pip install -r requirements.txt
```

4. Run the FastAPI backend

```bash
uvicorn Api:app --reload
```

- Open interactive API docs at: http://127.0.0.1:8000/docs

5. In a separate terminal, run the Streamlit UI

```bash
streamlit run Streamlit.py
```

The Streamlit app will open in your browser and can be used to enter sample data and inspect predictions.

---

## API

POST /predict

Request payload (JSON):

```json
{
  "total_transactions": 20,
  "total_days_active": 60,
  "total_bulk_orders": 5,
  "weekend_orders": 6,
  "avg_order_value": 2500.0,
  "avg_invoice_hour": 20
}
```

Response:

```json
{
  "risk_probability": 0.1842,
  "risk_level": "Low",
  "decision": "Allow"
}
```

---

## Project structure (important files)

- Api.py — FastAPI application (prediction endpoint)
- Streamlit.py — Streamlit frontend dashboard
- customer_fraud_model_lr.pkl — Trained Logistic Regression model (joblib)
- scaler.pkl — Trained StandardScaler (joblib)
- Customer Purchase Behaviour & Return Fraud Prediction.ipynb — analysis & model training notebook
- requirements.txt — Python dependencies

---

## Limitations & Notes

- Educational demo — do not use for automated production decisions without validation
- Model quality depends on training data — evaluate with accuracy, precision, recall, F1, ROC-AUC
- Add monitoring, logging, security, and human-in-the-loop for real deployments

---

## Roadmap / Improvements

- Add more behavioral features and feature importance analysis
- Compare alternative algorithms and tune hyperparameters
- Add unit & integration tests
- Containerize with Docker and add CI/CD
- Add authentication and role-based access in the API

---

## Author

Sameer Raza

Computer Science & Machine Learning Projects

---

