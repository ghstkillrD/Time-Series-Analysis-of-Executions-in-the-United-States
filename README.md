# Time Series Analysis of Executions in the United States

This repository contains an analysis of execution data in the United States from 1976 to 2018. The analysis includes data exploration, visualization, and time series forecasting using ARIMA models.

## Repository Contents

- **Executions-in-the-United-States.csv**: The dataset containing information on executions in the United States.
- **executions_analysis.R**: The R script that performs the data analysis, including data cleaning, visualization, time series decomposition, and ARIMA modeling.
- **Analysis of Executions in the United States.pdf**: The report regarding the time series analysis of executions in the United States.
- **README.md**: This file, provides an overview of the repository and its contents.

## Analysis Overview

The analysis consists of several key steps:

1. **Data Loading and Exploration**: Initial loading of the dataset and exploration of its structure and summary statistics.
2. **Data Cleaning and Preparation**: Extraction of the year from the date column and aggregation of executions by year.
3. **Visualization**: Creation of plots to visualize the number of executions over time.
4. **Time Series Decomposition**: Decomposition of the time series into seasonal, trend, and remainder components.
5. **ARIMA Modeling**: Fitting an ARIMA model to the data for forecasting future values.
6. **Forecasting and Evaluation**: Forecasting future executions and calculating accuracy metrics to evaluate the model's performance.

## How to Use

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/ghstkillrD/US-Executions-Analysis.git
    ```

2. **Install Necessary Libraries**:
    Ensure you have the required R libraries installed:
    ```R
    install.packages(c("magrittr", "ggplot2"))
    ```

3. **Run the Analysis**:
    Open the `executions_analysis.R` script in your R environment and run it to perform the analysis.

## Results

The results of the analysis include visualizations of the number of executions over time, a decomposition of the time series, and forecasts for future executions. Accuracy metrics such as MAE, MAPE, MSE, and RMSE are also calculated to evaluate the ARIMA model's performance.
