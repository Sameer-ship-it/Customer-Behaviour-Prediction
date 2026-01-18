import streamlit as st
import numpy as np
import pandas as pd
import joblib
import plotly.graph_objects as go
import os


st.set_page_config(
    page_title="Customer Risk Scoring",
    page_icon="⚠️",
    layout="wide"
)


st.markdown("""
<style>
body {
    background-color: #0e1117;
    color: white;
}
.stApp {
    background-color: #0e1117;
}
div[data-testid="stMetric"] {
    background-color: #161b22;
    border-radius: 12px;
    padding: 15px;
}
</style>
""", unsafe_allow_html=True)


BASE_DIR = os.path.dirname(os.path.abspath(__file__))

model = joblib.load(os.path.join(BASE_DIR, "customer_fraud_model_lr.pkl"))
scaler = joblib.load(os.path.join(BASE_DIR, "scaler.pkl"))


st.title("⚠️ Customer Fraud Risk Scoring")
st.subheader("Behavior-based ML Risk Assessment")

st.divider()


col1, col2, col3 = st.columns(3)

with col1:
    total_transactions = st.number_input("Total Transactions", 1, 500, 20)
    total_days_active = st.number_input("Active Days", 1, 365, 60)

with col2:
    total_bulk_orders = st.number_input("Bulk Orders", 0, 200, 5)
    weekend_orders = st.number_input("Weekend Orders", 0, 200, 6)

with col3:
    avg_order_value = st.number_input("Avg Order Value", 100.0, 10000.0, 2500.0)
    avg_invoice_hour = st.slider("Avg Invoice Hour", 0, 23, 20)

st.divider()


if st.button("🔍 Analyze Risk", use_container_width=True):

    avg_invoice_frequency = total_transactions / max(total_days_active, 1)
    bulk_ratio = total_bulk_orders / max(total_transactions, 1)
    weekend_ratio = weekend_orders / max(total_transactions, 1)

    input_df = pd.DataFrame([{
        "avg_invoice_frequency": avg_invoice_frequency,
        "avg_order_value": avg_order_value,
        "bulk_ratio": bulk_ratio,
        "weekend_ratio": weekend_ratio,
        "avg_invoice_hour": avg_invoice_hour
    }])

    scaled_input = scaler.transform(input_df)
    risk_prob = model.predict_proba(scaled_input)[0][1]
    risk_score = round(risk_prob * 100, 2)

    if risk_score < 30:
        risk_level = "Low"
        decision = "Allow"
        color = "#2ecc71"
    elif risk_score < 70:
        risk_level = "Medium"
        decision = "Manual Review"
        color = "#f39c12"
    else:
        risk_level = "High"
        decision = "Flag / Block"
        color = "#e74c3c"

    col1, col2, col3 = st.columns(3)
    col1.metric("Fraud Probability", f"{risk_prob:.4f}")
    col2.metric("Risk Score", f"{risk_score}%")
    col3.metric("Risk Level", risk_level)

    fig = go.Figure(go.Indicator(
        mode="gauge+number",
        value=risk_score,
        title={"text": "Risk Score"},
        gauge={
            "axis": {"range": [0, 100]},
            "bar": {"color": color},
            "steps": [
                {"range": [0, 30], "color": "#2ecc71"},
                {"range": [30, 70], "color": "#f39c12"},
                {"range": [70, 100], "color": "#e74c3c"}
            ]
        }
    ))

    fig.update_layout(paper_bgcolor="#0e1117", font_color="white")
    st.plotly_chart(fig, use_container_width=True)

    if risk_level == "Low":
        st.success(f"Decision: {decision}")
    elif risk_level == "Medium":
        st.warning(f"Decision: {decision}")
    else:
        st.error(f"Decision: {decision}")
