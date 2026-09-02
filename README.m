# 🛡️ Customer Fraud Risk Scoring

A Machine Learning-based **Customer Fraud Risk Prediction application** built with **Python, Scikit-learn, FastAPI, and Streamlit**.

The application analyzes customer transaction behavior such as transaction frequency, order value, bulk orders, weekend orders, and invoice timing to estimate the customer's overall **fraud risk level**.

The model generates a fraud probability and converts it into a meaningful risk category along with an automated business decision.

> **Note:** This project is for educational and demonstration purposes only. It is not a production-grade fraud detection system.

---

## 🚀 Features

* Predicts customer fraud risk using a Machine Learning model
* Interactive web interface built with Streamlit
* REST API backend developed using FastAPI
* Takes multiple customer transaction and behavioral inputs
* Performs feature engineering from transaction behavior
* Uses a trained Logistic Regression model
* Generates probability-based fraud risk scores
* Categorizes customers into Low, Medium, and High risk levels
* Provides automated business decisions
* Displays an interactive fraud risk visualization using Plotly
* Saved trained model and scaler are loaded for real-time predictions

---

## 🧠 Machine Learning

### Algorithm Used

**Logistic Regression**

The model analyzes customer transaction behavior and estimates the probability of potential fraudulent activity.

The input features are scaled using **StandardScaler** before being passed to the Logistic Regression model.

The model output is a probability value representing the estimated fraud risk.

This probability is later converted into a human-readable risk level.

### Risk Classification

| Fraud Probability | Risk Level | Business Decision |
| ----------------- | ---------- | ----------------- |
| `< 30%` | 🟢 Low | Allow |
| `30% - <70%` | 🟡 Medium | Manual Review |
| `≥ 70%` | 🔴 High | Flag / Block |

> The model's performance should be evaluated using appropriate metrics such as Accuracy, Precision, Recall, F1-score, and ROC-AUC before considering it suitable for real-world deployment.

---

## 📊 Input Features

The application accepts the following customer transaction information:

| Feature | Description |
| ---------------------- | ------------------------------------------- |
| Total Transactions | Total number of customer transactions |
| Total Days Active | Number of days the customer has been active |
| Total Bulk Orders | Number of bulk orders placed by the customer |
| Weekend Orders | Number of transactions occurring on weekends |
| Average Order Value | Average monetary value of customer orders |
| Average Invoice Hour | Average time at which customer transactions occur |

The application processes these inputs and derives behavioral indicators for fraud risk prediction.

---

## ⚙️ Feature Engineering

Raw customer transaction information is transformed into meaningful behavioral features before being passed to the Machine Learning model.

The model uses behavioral indicators such as:

| Feature | Description |
| ------------------------ | ---------------------------------------------- |
| Average Invoice Frequency | Average frequency of customer transactions |
| Average Order Value | Average monetary value of customer orders |
| Bulk Order Ratio | Ratio of bulk orders to total transactions |
| Weekend Order Ratio | Ratio of weekend transactions |
| Average Invoice Hour | Average transaction time |

The engineered features are processed using **StandardScaler** to ensure that the input values are appropriately scaled before prediction.

---

## 🔄 Project Workflow

```text
                ┌─────────────────────┐
                │ Customer Transaction │
                │      Input Data      │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │ Feature Engineering │
                │ Behavioral Features │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │ Data Preprocessing  │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │ StandardScaler      │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │ Logistic Regression │
                │      Model          │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │ Fraud Probability   │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │ Risk Classification │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │ Business Decision   │
                └─────────────────────┘

                # 🛡️ Customer Fraud Risk Scoring

A Machine Learning-based **Customer Fraud Risk Prediction application** built with **Python, Scikit-learn, FastAPI, and Streamlit**.

The application analyzes customer transaction behavior such as transaction frequency, order value, bulk orders, weekend orders, and invoice timing to estimate the customer's overall **fraud risk level**.

The model generates a fraud probability and converts it into a meaningful risk category along with an automated business decision.

> **Note:** This project is for educational and demonstration purposes only. It is not a production-grade fraud detection system.

---

## 🚀 Features

* Predicts customer fraud risk using a Machine Learning model
* Interactive web interface built with Streamlit
* REST API backend developed using FastAPI
* Takes multiple customer transaction and behavioral inputs
* Performs feature engineering from transaction behavior
* Uses a trained Logistic Regression model
* Generates probability-based fraud risk scores
* Categorizes customers into Low, Medium, and High risk levels
* Provides automated business decisions
* Displays an interactive fraud risk visualization using Plotly
* Saved trained model and scaler are loaded for real-time predictions

---

## 🧠 Machine Learning

### Algorithm Used

**Logistic Regression**

The model analyzes customer transaction behavior and estimates the probability of potential fraudulent activity.

The input features are scaled using **StandardScaler** before being passed to the Logistic Regression model.

The model output is a probability value representing the estimated fraud risk.

This probability is later converted into a human-readable risk level.

### Risk Classification

| Fraud Probability | Risk Level | Business Decision |
| ----------------- | ---------- | ----------------- |
| `< 30%` | 🟢 Low | Allow |
| `30% - <70%` | 🟡 Medium | Manual Review |
| `≥ 70%` | 🔴 High | Flag / Block |

> The model's performance should be evaluated using appropriate metrics such as Accuracy, Precision, Recall, F1-score, and ROC-AUC before considering it suitable for real-world deployment.

---

## 📊 Input Features

The application accepts the following customer transaction information:

| Feature | Description |
| ---------------------- | ------------------------------------------- |
| Total Transactions | Total number of customer transactions |
| Total Days Active | Number of days the customer has been active |
| Total Bulk Orders | Number of bulk orders placed by the customer |
| Weekend Orders | Number of transactions occurring on weekends |
| Average Order Value | Average monetary value of customer orders |
| Average Invoice Hour | Average time at which customer transactions occur |

The application processes these inputs and derives behavioral indicators for fraud risk prediction.

---

## ⚙️ Feature Engineering

Raw customer transaction information is transformed into meaningful behavioral features before being passed to the Machine Learning model.

The model uses behavioral indicators such as:

| Feature | Description |
| ------------------------ | ---------------------------------------------- |
| Average Invoice Frequency | Average frequency of customer transactions |
| Average Order Value | Average monetary value of customer orders |
| Bulk Order Ratio | Ratio of bulk orders to total transactions |
| Weekend Order Ratio | Ratio of weekend transactions |
| Average Invoice Hour | Average transaction time |

The engineered features are processed using **StandardScaler** to ensure that the input values are appropriately scaled before prediction.

---

## 🔄 Project Workflow

```text
                ┌─────────────────────┐
                │ Customer Transaction │
                │      Input Data      │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │ Feature Engineering │
                │ Behavioral Features │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │ Data Preprocessing  │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │ StandardScaler      │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │ Logistic Regression │
                │      Model          │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │ Fraud Probability   │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │ Risk Classification │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │ Business Decision   │
                └─────────────────────┘


---
## 🛠️ Technologies Used
* Python
* Pandas
* NumPy
* Scikit-learn
* Logistic Regression
* StandardScaler
* FastAPI
* Pydantic
* Streamlit
* Plotly
* Joblib
---
## 📁 Project Structure
Customer-Fraud-Risk-Scoring/
│
├── app.py
├── main.py
├── customer_fraud_model_lr.pkl
├── scaler.pkl
├── requirements.txt
└── README.md
---
## 📁 File Description

| File                          | Purpose                            |
| ----------------------------- | ---------------------------------- |
| `app.py`                      | Streamlit frontend application     |
| `main.py`                     | FastAPI backend and prediction API |
| `customer_fraud_model_lr.pkl` | Trained Logistic Regression model  |
| `scaler.pkl`                  | Saved StandardScaler object        |
| `requirements.txt`            | Required Python packages           |
| `README.md`                   | Project documentation              |

The trained Machine Learning model and scaler are serialized and loaded during application execution to provide real-time fraud risk predictions.
---
## ⚙️ Installation
* 1. Clone the repository
git clone https://github.com/Sameer-ship-it/Customer-Fraud-Risk-Scoring.git
* 2. Navigate to the project directory
cd Customer-Fraud-Risk-Scoring
* 3. Create a virtual environment
python -m venv venv
* 4. Activate the virtual environment
venv\Scripts\activate
* 5. Install dependencies
pip install -r requirements.txt
*6. Run the FastAPI backend
uvicorn main:app --reload
The FastAPI server will run at:
http://127.0.0.1:8000
Interactive API documentation:
http://127.0.0.1:8000/docs
*7. Run the Streamlit application
Open another terminal and run:
streamlit run app.py

The application will open in your browser.

---
##💻 How It Works

The user enters customer transaction information through the Streamlit interface.

The application processes the raw input and performs feature engineering to generate behavioral indicators.

The resulting features are scaled using the previously trained StandardScaler.

The processed feature vector is passed to the trained Logistic Regression model:

**probability = model.predict_proba(features)[0][1]**

The predicted probability is then converted into a human-readable fraud risk level.

Based on the predicted probability, the application generates a recommended business decision:

Low Risk       → Allow

Medium Risk    → Manual Review

High Risk      → Flag / Block
---

## 📈 Visualization

The application displays the predicted fraud probability through an interactive visualization built using Plotly.

This allows users to quickly understand:

Fraud probability
Customer risk level
Recommended business decision

The visualization provides a more intuitive representation of the Machine Learning model's output.
---

## 🎯 Example
Input
Total Transactions: 20
Total Days Active: 60
Total Bulk Orders: 5
Weekend Orders: 6
Average Order Value: 2500
Average Invoice Hour: 20
Output
Fraud Probability: 18.42%

Predicted Risk Level: Low

Recommended Decision: Allow

The actual output depends on the trained model and customer transaction information.
---

## 🔬 Model Prediction

The application uses a trained Logistic Regression model to calculate the probability of potential fraud.

The overall prediction process is:

Customer Input
       ↓
Feature Engineering
       ↓
Feature Scaling
       ↓
Logistic Regression
       ↓
Fraud Probability
       ↓
Risk Classification
       ↓
Business Decision

The application uses probability-based scoring instead of only a binary fraud prediction.

This makes the output more useful for business decision-making because customers can be categorized into different levels of risk.
---

## ⚠️ Limitations
* The project is developed for educational and demonstration purposes.
* Model predictions depend heavily on the quality and representativeness of the training data.
* The application should not be considered definitive proof of fraudulent activity.
* The current model uses a limited number of behavioral features.
* Real-world fraud detection systems require continuous model monitoring.
* Production systems require additional security, compliance, and human oversight.
* Model performance should be evaluated using multiple classification metrics.
---

## 🔮 Future Improvements

* Add more customer behavioral features
* Improve model evaluation using Precision and Recall
* Add F1-score analysis
* Add ROC-AUC evaluation
* Compare multiple Machine Learning algorithms
* Implement model monitoring
* Add feature importance analysis
* Integrate a database for transaction storage
* Containerize the application using Docker
* Deploy the application using cloud services
* Add authentication and user management
* Improve the dashboard UI/UX

---

##👨‍💻 Author

Sameer Raza

Computer Science and Machine Learning Project

---

📜 Disclaimer

This project was developed for educational and demonstration purposes.

The predictions generated by this application should not be considered definitive proof of fraudulent activity.

Real-world fraud detection systems require validated datasets, continuous model monitoring, regular performance evaluation, security measures, regulatory compliance, and appropriate human oversight.

