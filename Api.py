print("NEW LOGISTIC REGRESSION API LOADED")

from fastapi import FastAPI
from pydantic import BaseModel, Field, computed_field
import numpy as np
from typing import Annotated
import pandas as pd
import joblib


# Loading Logistic Regression model

model = joblib.load("customer_fraud_model_lr.pkl")   
scaler = joblib.load("scaler.pkl")

app = FastAPI(title="Customer Risk Scoring API")


# Input Schema


class UserInput(BaseModel):

    total_transactions: Annotated[int, Field(..., gt=0, Description ="Enter Customer's Transaction" )]
    total_days_active: Annotated[int, Field(..., gt=0, Description = "Active Day's Of Customer Till Yet")]
    total_bulk_orders: Annotated[int, Field(..., ge=0, Description = "How Many Bulk Orders Occured")]
    weekend_orders: Annotated[int, Field(..., ge=0, Description = "Number Of Weekend Orders By The Customer")]
    avg_order_value: Annotated[float, Field(..., gt=0, Description = "Average Purchase Value ")]
    avg_invoice_hour: Annotated[float, Field(..., ge=0, le=23, Description = "Average Hours Spend On The Site")]

    @computed_field
    @property
    def avg_invoice_frequency(self) -> float:
        return self.total_transactions / max(self.total_days_active, 1)

    @computed_field
    @property
    def bulk_ratio(self) -> float:
        return self.total_bulk_orders / max(self.total_transactions, 1)

    @computed_field
    @property
    def weekend_ratio(self) -> float:
        return self.weekend_orders / max(self.total_transactions, 1)


# API Endpoint

@app.post("/predict")
def predict_risk(data: UserInput):

    # BEHAVIORAL FEATURES 
    input_df = pd.DataFrame([{
        "avg_invoice_frequency": data.avg_invoice_frequency,
        "avg_order_value": data.avg_order_value,
        "bulk_ratio": data.bulk_ratio,
        "weekend_ratio": data.weekend_ratio,
        "avg_invoice_hour": data.avg_invoice_hour
    }])

    # Scaling
    scaled_input = scaler.transform(input_df)
    scaled_input = np.nan_to_num(scaled_input)

    # Logistic Regression probability
    risk_probability = model.predict_proba(scaled_input)[0][1]

    # Final Decision (probability-based)

    if risk_probability < 0.30:
        risk_level = "Low"
        decision = "Allow"
    elif risk_probability < 0.70:
        risk_level = "Medium"
        decision = "Manual Review"
    else:
        risk_level = "High"
        decision = "Flag / Block"

    return {
        "risk_probability": round(risk_probability, 4),
        "risk_level": risk_level,
        "decision": decision
    }
