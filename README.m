# ⚠️ Customer Fraud Risk Scoring

A Machine Learning-based application that analyzes customer transaction behavior and predicts their **fraud risk level** using Logistic Regression.

The project uses **FastAPI** for the backend API and **Streamlit** for the interactive frontend dashboard.

## 🚀 Features

- Customer fraud risk prediction
- Logistic Regression model
- Probability-based risk scoring
- Feature engineering from customer behavior
- FastAPI REST API
- Streamlit dashboard
- Interactive Plotly risk gauge
- Automated business decisions

## 🧠 Machine Learning

The model uses the following behavioral features:

- Average Invoice Frequency
- Average Order Value
- Bulk Order Ratio
- Weekend Order Ratio
- Average Invoice Hour

The input features are scaled using `StandardScaler` before being passed to the Logistic Regression model.

### Risk Classification

| Fraud Probability | Risk Level | Decision |
|---|---|---|
| `< 30%` | 🟢 Low | Allow |
| `30% - <70%` | 🟡 Medium | Manual Review |
| `≥ 70%` | 🔴 High | Flag / Block |

## 🏗️ Project Architecture

```text
Customer Input
      ↓
Feature Engineering
      ↓
StandardScaler
      ↓
Logistic Regression
      ↓
Fraud Probability
      ↓
Risk Score
      ↓
Risk Level + Decision

🛠️Technologies
-Python
-Scikit-learn
-Logistic Regression
-FastAPI
-Pydantic
-Streamlit
-Pandas
-NumPy
-Joblib
-Plotly

📁 Project Structure
Customer-Fraud-Risk-Scoring/
│
├── app.py
├── main.py
├── customer_fraud_model_lr.pkl
├── scaler.pkl
├── requirements.txt
├── README.md
│
└── screenshots/
    ├── dashboard.png
    └── prediction.png

    
## ▶️ Run the Project
### Install Dependencies

```bash
pip install -r requirements.txt
Run FastAPI
uvicorn main:app --reload

API documentation:
http://127.0.0.1:8000/docs

Run Streamlit
streamlit run app.py
🔌 API Endpoint
POST /predict

Example request:

{
  "total_transactions": 20,
  "total_days_active": 60,
  "total_bulk_orders": 5,
  "weekend_orders": 6,
  "avg_order_value": 2500,
  "avg_invoice_hour": 20
}

Example response:

{
  "risk_probability": 0.1842,
  "risk_level": "Low",
  "decision": "Allow"
}

🔮 Future Improvements
Add more behavioral features
Improve model evaluation
Add ROC-AUC, Precision, Recall and F1-score
Add model monitoring
Add database integration
Deploy the application using Docker and cloud services

⚠️ Disclaimer
This project is developed for educational and demonstration purposes. 
The prediction should not be considered definitive proof of fraudulent activity.
Production fraud detection systems require validated data, continuous monitoring and human oversight.

👨‍💻 Author

Sameer Raza
