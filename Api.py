from fastapi import FastAPI
from fastapi.responses import JSONResponse
from pydantic import BaseModel, Field, computed_field
from typing import Literal, Annotated
import numpy as np
import pandas as pd
import joblib

#importing ml and scaler model

model = joblib.load("customer_fraud_model.pkl")
scaler = joblib.load("scaler.pkl")

app = FastAPI()

# creating pydantic model to validate user input

class UserInput(BaseModel):

    total_transactions: Annotated[int,Field(...,gt= 0, description = 'Total Transactions Of The Customer')]
    total_days_active: Annotated[int,Field(...,gt = 0,  description = 'Number Of Active Days Of The Customer')]
    total_bulk_orders: Annotated[int,Field(..., ge = 0, description = 'Number Of Bulk Orders Placed By The Customer')]
    weekend_orders: Annotated[int,Field(...,ge = 0,  description = 'Number Of Orders Placed On Weekends')]
    avg_order_value: Annotated[float,Field(...,gt = 0, description = 'Average Value Of Customer Orders')]
    avg_invoice_hour: Annotated[float,Field(...,ge =0, le=23, description = 'Average Hour Of Purchase(0-23)')]


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
    

@app.post('/predict')
def predict_behaviour(data: UserInput):
    
    input_df = pd.DataFrame([{
        'total_transactions': data.total_transactions,
        'total_days_active': data.total_days_active,
        'total_bulk_orders': data.total_bulk_orders,
        'weekend_orders': data.weekend_orders,
        'avg_order_value': data.avg_order_value,
        'avg_invoice_hour': data.avg_invoice_hour,
        'avg_invoice_frequency': data.avg_invoice_frequency,
        'bulk_ratio': data.bulk_ratio,
        'weekend_ratio': data.weekend_ratio
    }])
    
    model_features = input_df[[
        'avg_invoice_frequency',
        'total_transactions',
        'avg_order_value',
        'bulk_ratio',
        'weekend_ratio',
        'avg_invoice_hour'
    ]]

    # Applying scaler 
    scaled_input = scaler.transform(model_features)

    # DEBUG: check scaled input
    print("SCALED INPUT:", scaled_input)

    # Safety: replace NaN / inf in scaled_input
    scaled_input = np.nan_to_num(scaled_input, nan=0.0, posinf=0.0, neginf=0.0)

    # Predict probability
    fraud_probability = model.predict_proba(scaled_input)[0][1]
    if np.isnan(fraud_probability) or np.isinf(fraud_probability):
        fraud_probability = 0.0

    # Risk score rounding off
    risk_score = round(fraud_probability * 100, 2)

    # Risk level decision
    if risk_score < 30:
        risk_level = "Low"
        decision = "Allow"
    elif risk_score < 70:
        risk_level = "Medium"
        decision = "Manual Review"
    else:
        risk_level = "High"
        decision = "Flag / Block"

    # Final response

    return {
    "fraud_probability": float(round(fraud_probability, 4)),
    "risk_score": float(risk_score),
    "risk_level": risk_level,
    "decision": decision
    }

    



