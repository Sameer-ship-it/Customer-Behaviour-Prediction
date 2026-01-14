from fastapi import FastAPI
from pydantic import BaseModel, Field, computed_field
from typing import Literal, Annotated
import pandas as pd
import joblib

#importing ml and scaler model

model = joblib.load("customer_fraud_model.pkl")
scaler = joblib.load("scaler.pkl")

app = FastAPI()

# creating pydantic model to validate user input

class UserInput(BaseModel):

    total_transactions: Annotated[int,Field(...,gt= 0, description = 'Total Transactions Of The Customer')]
    total_days_active: Annotated[int,Field(...,gt = 0,  description = 'Active Days Of The Customer')]
    total_bulk_orders: Annotated[int,Field(..., ge = 0, description = 'Number Of Bulk Orders Placed By The Customer')]
    weekend_orders: Annotated[int,Field(...,ge = 0,  description = 'Number Of Orders Placed On Weekends')]
    avg_order_value: Annotated[float,Field(...,gt = 0, description = 'Average Value Of Customer Orders')]
    avg_invoice_hour: Annotated[float,Field(...,ge =0, le=23, description = 'Average Hour Of Purchase(0-23)')]


