# Customer Behaviour Risk Scoring

A learning project that derives behavioral features from customer activity and estimates a low, medium, or high risk score with a Logistic Regression model. It includes a FastAPI endpoint and a Streamlit interface.

> This is a demonstration, not a validated fraud-detection or automated decision system. Do not use its output to block customers or make consequential decisions without independent validation and human review.

## Features

- Derives transaction-frequency, bulk-order, and weekend-order ratios
- Scales the feature vector and obtains a probability from the model
- Exposes a `POST /predict` endpoint
- Provides a Streamlit form for interactive exploration

## Repository files

| File | Purpose |
| --- | --- |
| `Api.py` | FastAPI prediction endpoint |
| `Streamlit.py` | Interactive dashboard |
| `Customer Purchase Behaviour & Return Fraud Prediction.ipynb` | Data preparation and model experiments |
| `scaler.pkl` | Serialized feature scaler |
| `customer_fraud_model.pkl` | Serialized Random Forest experiment |

The API and dashboard currently expect `customer_fraud_model_lr.pkl`, which the notebook exports during training but is not included in this repository. Run the notebook with an authorized dataset to generate the expected Logistic Regression artifact before starting either app. The checked-in `customer_fraud_model.pkl` is a separate Random Forest artifact.

## Data

The training notebook expects a local CSV dataset that is not included. Update its input path for your environment. Do not commit private customer data or credentials.

## Run locally

```bash
git clone https://github.com/Sameer-ship-it/Customer-Behaviour-Prediction.git
cd Customer-Behaviour-Prediction
python -m venv .venv
```

Activate the environment, then install the app and notebook dependencies:

```bash
# Windows PowerShell
.venv\Scripts\Activate.ps1
# macOS / Linux
source .venv/bin/activate
```

```bash
python -m pip install fastapi "uvicorn[standard]" streamlit pandas numpy scikit-learn joblib plotly jupyter
```

After generating the expected model artifact, run either interface:

```bash
uvicorn Api:app --reload
```

The API docs are at `http://127.0.0.1:8000/docs`. In another terminal, run the dashboard:

```bash
streamlit run Streamlit.py
```

## Example request

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

## Limitations

- The notebook's dataset and trained Logistic Regression artifact are not checked in.
- Risk thresholds are demonstration settings, not business policy.
- Validate data quality, calibration, fairness, and operating impact before considering real use.
- Pickle artifacts should only be loaded from trusted sources.

## Author

[Sameer Raza](https://github.com/Sameer-ship-it)
