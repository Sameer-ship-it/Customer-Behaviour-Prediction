<div align="center">

# 🛡️ Customer Fraud Risk Scoring

### ML-powered fraud risk prediction with a live API and interactive dashboard

<p>
  <img src="https://img.shields.io/badge/Python-3.9+-3776AB?style=for-the-badge&logo=python&logoColor=white" />
  <img src="https://img.shields.io/badge/FastAPI-Backend-009688?style=for-the-badge&logo=fastapi&logoColor=white" />
  <img src="https://img.shields.io/badge/Streamlit-Dashboard-FF4B4B?style=for-the-badge&logo=streamlit&logoColor=white" />
  <img src="https://img.shields.io/badge/Scikit--Learn-ML-F7931E?style=for-the-badge&logo=scikitlearn&logoColor=white" />
</p>

<p>
  <img src="https://img.shields.io/badge/status-active-success?style=flat-square" />
  <img src="https://img.shields.io/badge/license-MIT-blue?style=flat-square" />
  <img src="https://img.shields.io/badge/model-Logistic%20Regression-purple?style=flat-square" />
</p>

A machine learning application that analyzes customer transaction behavior and predicts **fraud risk level** in real time — complete with a REST API, a probability-scoring engine, and a live Plotly risk gauge.

</div>

<br>

## 📑 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [How the Model Works](#-how-the-model-works)
- [Risk Classification](#-risk-classification)
- [Architecture](#️-architecture)
- [Tech Stack](#️-tech-stack)
- [Project Structure](#-project-structure)
- [Getting Started](#️-getting-started)
- [API Reference](#-api-reference)
- [Screenshots](#-screenshots)
- [Roadmap](#-roadmap)
- [Disclaimer](#️-disclaimer)
- [Author](#-author)

<br>

## 🔍 Overview

**Customer Fraud Risk Scoring** takes raw customer behavior data — order frequency, order value, timing patterns — and turns it into an actionable fraud decision in three steps:

1. **Engineer** behavioral features from raw transaction data
2. **Score** the customer using a trained Logistic Regression model
3. **Decide** — Allow, Review, or Block — based on the resulting probability

The backend is served through **FastAPI**, and a **Streamlit** dashboard provides a live, interactive view of the scoring engine — including a real-time Plotly risk gauge.

<br>

## 🚀 Features

| | |
|---|---|
| 🎯 | Customer fraud risk prediction |
| 📊 | Probability-based risk scoring (not just a binary flag) |
| 🧮 | Feature engineering from raw customer behavior |
| ⚡ | FastAPI REST API for programmatic access |
| 🖥️ | Streamlit dashboard for interactive exploration |
| 🌡️ | Live Plotly risk gauge visualization |
| 🤖 | Automated Allow / Review / Block decisions |

<br>

## 🧠 How the Model Works

The model is trained on five behavioral features extracted from customer transaction history:

| Feature | What it Captures |
|---|---|
| `avg_invoice_frequency` | How often the customer transacts |
| `avg_order_value` | Typical spend per order |
| `bulk_order_ratio` | Share of unusually large orders |
| `weekend_order_ratio` | Tendency to order on weekends |
| `avg_invoice_hour` | Typical time of day for orders |

All features are standardized using `StandardScaler` before being passed into the **Logistic Regression** classifier, which outputs a fraud probability between 0 and 1.

<br>

## 🚦 Risk Classification

The predicted probability is mapped to a decision automatically:

| Fraud Probability | Risk Level | Decision |
|:---:|:---:|:---:|
| `< 30%` | 🟢 **Low** | ✅ Allow |
| `30% – 70%` | 🟡 **Medium** | 🔎 Manual Review |
| `≥ 70%` | 🔴 **High** | 🚫 Flag / Block |

<br>

## 🏗️ Architecture

```mermaid
flowchart TD
    A[Customer Input] --> B[Feature Engineering]
    B --> C[StandardScaler]
    C --> D[Logistic Regression]
    D --> E[Fraud Probability]
    E --> F[Risk Score]
    F --> G[Risk Level + Decision]
    G --> H{Decision}
    H -->|Low| I[✅ Allow]
    H -->|Medium| J[🔎 Manual Review]
    H -->|High| K[🚫 Flag / Block]
```

<br>

## 🛠️ Tech Stack

<p>
  <img src="https://img.shields.io/badge/-Python-3776AB?style=flat-square&logo=python&logoColor=white" />
  <img src="https://img.shields.io/badge/-Scikit--learn-F7931E?style=flat-square&logo=scikitlearn&logoColor=white" />
  <img src="https://img.shields.io/badge/-FastAPI-009688?style=flat-square&logo=fastapi&logoColor=white" />
  <img src="https://img.shields.io/badge/-Pydantic-E92063?style=flat-square&logo=pydantic&logoColor=white" />
  <img src="https://img.shields.io/badge/-Streamlit-FF4B4B?style=flat-square&logo=streamlit&logoColor=white" />
  <img src="https://img.shields.io/badge/-Pandas-150458?style=flat-square&logo=pandas&logoColor=white" />
  <img src="https://img.shields.io/badge/-NumPy-013243?style=flat-square&logo=numpy&logoColor=white" />
  <img src="https://img.shields.io/badge/-Joblib-yellow?style=flat-square" />
  <img src="https://img.shields.io/badge/-Plotly-3F4F75?style=flat-square&logo=plotly&logoColor=white" />
</p>

<br>

## 📁 Project Structure

```text
Customer-Fraud-Risk-Scoring/
│
├── app.py                       # Streamlit dashboard
├── main.py                      # FastAPI application
├── customer_fraud_model_lr.pkl  # Trained Logistic Regression model
├── scaler.pkl                   # Fitted StandardScaler
├── requirements.txt             # Project dependencies
├── README.md
│
└── screenshots/
    ├── dashboard.png
    └── prediction.png
```

<br>

## ▶️ Getting Started

<details open>
<summary><b>1. Install dependencies</b></summary>

```bash
pip install -r requirements.txt
```
</details>

<details open>
<summary><b>2. Run the FastAPI backend</b></summary>

```bash
uvicorn main:app --reload
```

Interactive API docs will be available at:
📄 **http://127.0.0.1:8000/docs**
</details>

<details open>
<summary><b>3. Run the Streamlit dashboard</b></summary>

```bash
streamlit run app.py
```
</details>

<br>

## 🔌 API Reference

### `POST /predict`

Scores a customer and returns their fraud risk.

**Request body**

```json
{
  "total_transactions": 20,
  "total_days_active": 60,
  "total_bulk_orders": 5,
  "weekend_orders": 6,
  "avg_order_value": 2500,
  "avg_invoice_hour": 20
}
```

**Response**

```json
{
  "risk_probability": 0.1842,
  "risk_level": "Low",
  "decision": "Allow"
}
```

<br>

## 🖼️ Screenshots

<div align="center">

| Dashboard | Prediction |
|:---:|:---:|
| <img src="screenshots/dashboard.png" width="380"/> | <img src="screenshots/prediction.png" width="380"/> |

</div>

<br>

## 🔮 Roadmap

- [ ] Add more behavioral features
- [ ] Expand model evaluation (ROC-AUC, Precision, Recall, F1-score)
- [ ] Add model monitoring
- [ ] Add database integration
- [ ] Containerize with Docker and deploy to the cloud

<br>

## ⚠️ Disclaimer

This project was built for **educational and demonstration purposes only**. Its predictions should **not** be treated as definitive proof of fraudulent activity. Production-grade fraud detection systems require validated data, continuous monitoring, and human oversight.

<br>

## 👨‍💻 Author

<div align="center">

**Sameer Raza**

<a href="https://github.com/Sameer-ship-it"><img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white" /></a>
<a href="https://www.linkedin.com/in/sameer-raza-7bb5b8325"><img src="https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white" /></a>

</div>
