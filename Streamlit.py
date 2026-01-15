import streamlit as st
import requests
import plotly.graph_objects as go
import plotly.express as px
import pandas as pd

st.set_page_config(page_title="Fraud Risk Analyzer", page_icon="🚨", layout="centered")

API_URL = "http://127.0.0.1:8000/predict"

st.markdown(
    "<h1 style='text-align:center;color:#ff4b4b;'>🚨 Fraud Risk Analyzer</h1>",
    unsafe_allow_html=True
)

st.sidebar.header("Customer Details")

total_transactions = st.sidebar.number_input("Total Transactions", min_value=1, step=1)
total_days_active = st.sidebar.number_input("Total Active Days", min_value=1, step=1)
total_bulk_orders = st.sidebar.number_input("Bulk Orders", min_value=0, step=1)
weekend_orders = st.sidebar.number_input("Weekend Orders", min_value=0, step=1)
avg_order_value = st.sidebar.number_input("Average Order Value", min_value=1.0, step=10.0)
avg_invoice_hour = st.sidebar.slider("Average Purchase Hour", 0, 23, 12)

if st.button("Analyze Risk"):

    payload = {
        "total_transactions": total_transactions,
        "total_days_active": total_days_active,
        "total_bulk_orders": total_bulk_orders,
        "weekend_orders": weekend_orders,
        "avg_order_value": avg_order_value,
        "avg_invoice_hour": avg_invoice_hour
    }

    try:
        response = requests.post(API_URL, json=payload, timeout=5)
        result = response.json()

        fraud_probability = result["fraud_probability"]
        risk_score = result["risk_score"]
        risk_level = result["risk_level"]
        decision = result["decision"]

        col1, col2, col3 = st.columns(3)
        col1.metric("Fraud Probability", fraud_probability)
        col2.metric("Risk Score", f"{risk_score}%")
        col3.metric("Risk Level", risk_level)

        fig = go.Figure(go.Indicator(
            mode="gauge+number",
            value=risk_score,
            gauge={
                "axis": {"range": [0, 100]},
                "bar": {"color": "red"},
                "steps": [
                    {"range": [0, 30], "color": "green"},
                    {"range": [30, 70], "color": "orange"},
                    {"range": [70, 100], "color": "red"}
                ]
            }
        ))

        st.plotly_chart(fig, use_container_width=True)

        data = {
            "Metric": [
                "Transactions",
                "Active Days",
                "Bulk Orders",
                "Weekend Orders",
                "Avg Order Value",
                "Avg Hour"
            ],
            "Value": [
                total_transactions,
                total_days_active,
                total_bulk_orders,
                weekend_orders,
                avg_order_value,
                avg_invoice_hour
            ]
        }

        df = pd.DataFrame(data)

        bar_fig = px.bar(
            df,
            x="Metric",
            y="Value",
            color="Metric",
            template="plotly_dark"
        )

        st.plotly_chart(bar_fig, use_container_width=True)

        if risk_level == "Low":
            st.success(f"Decision: {decision}")
        elif risk_level == "Medium":
            st.warning(f"Decision: {decision}")
        else:
            st.error(f"Decision: {decision}")

    except Exception as e:
        st.error("API connection failed")

