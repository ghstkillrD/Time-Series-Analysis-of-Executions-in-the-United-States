# Load necessary libraries
library(magrittr)
library(ggplot2)

# Load the data
executions_data <- read.csv("Executions-in-the-United-States.csv", header = TRUE)

# Explore the structure of the data
str(executions_data)

# Summary statistics
summary(executions_data)

# Extract year from Date column
#executions_data$Year <- as.numeric(format(as.Date(executions_data$Date, "%Y-%m-%d"), "%Y"))

# Clean and extract year from Date column
executions_data$Year <- substr(executions_data$Date, 13, 16)

# Aggregate executions per year
executions_by_year <- aggregate(Date ~ Year, data = executions_data, FUN = length)

#head(executions_by_year)

# Convert Year to numeric
#executions_by_year$Year <- as.numeric(substr(executions_by_year$Date, 13, 16))

# Rename the aggregated column
colnames(executions_by_year)[2] <- "Executions"

# Plot the time series with points
ggplot(executions_by_year, aes(x = Year, y = Executions)) +
  geom_point() +
  labs(title = "Executions in the United States (1976-2018)",
       x = "Year",
       y = "Number of Executions") +
  theme_minimal()

# Convert 'Year' to numeric
executions_by_year$Year <- as.numeric(executions_by_year$Year)

# Plot the count of executions over the years
ggplot(executions_by_year, aes(x = Year, y = Executions)) +
  geom_line() +
  labs(title = "Executions in the United States (1976-2018)",
       x = "Year",
       y = "Number of Executions") +
  theme_minimal()

#length(executions_by_year$Executions)

# Decompose the time series using stl()
executions_stl <- stl(ts(executions_by_year$Executions, frequency = 12), s.window = "periodic")

# Create a dataframe with time series components
decomposition_df <- data.frame(
  Year = executions_by_year$Year,
  Seasonal = executions_stl$time.series[, "seasonal"],
  Trend = executions_stl$time.series[, "trend"],
  Remainder = executions_stl$time.series[, "remainder"]
)

# Plot the decomposition components
ggplot(decomposition_df, aes(x = Year)) +
  geom_line(aes(y = Seasonal, color = "Seasonal")) +
  geom_line(aes(y = Trend, color = "Trend")) +
  geom_line(aes(y = Remainder, color = "Remainder")) +
  labs(title = "Decomposition of Executions Time Series",
       y = "Component Value",
       x = "Year") +
  scale_color_manual(values = c("Seasonal" = "blue", "Trend" = "red", "Remainder" = "green")) +
  theme_minimal()

# ACF plot
acf(executions_by_year$Executions)

# PACF plot
pacf(executions_by_year$Executions)

# Fit ARIMA model
executions_arima_model <- arima(executions_by_year$Executions, order = c(1, 1, 6))

# Summary of the model
summary(executions_arima_model)

# Forecast future values
future_time <- length(executions_by_year$Executions) + 1  # Next time point after the last observation
executions_forecast <- predict(executions_arima_model, n.ahead = 12)  # Forecast next 12 values

# Print forecasted values
print(executions_forecast$pred)

# Create a data frame for the forecasted values
forecast_data <- data.frame(
  Year = seq(2019, length.out = length(executions_forecast$pred)),
  Executions = executions_forecast$pred
)

# Plot the forecasted values
ggplot() +
  geom_line(data = executions_by_year, aes(x = Year, y = Executions), color = "blue", linetype = "solid") +  # Actual data
  geom_line(data = forecast_data, aes(x = Year, y = Executions), color = "red", linetype = "dashed") +  # Forecasted values
  labs(title = "Forecasted Executions in the United States",
       x = "Year",
       y = "Number of Executions") +
  theme_minimal()



# Calculate accuracy metrics
actual_values <- executions_by_year$Executions
forecasted_values <- executions_forecast$pred

length(actual_values)
length(forecasted_values)

# Trim actual_values to match the length of forecasted_values
actual_values_trimmed <- tail(actual_values, length(forecasted_values))

length(actual_values_trimmed)

# Calculate errors
errors <- forecasted_values - actual_values_trimmed

# Calculate Mean Absolute Error (MAE)
mae <- mean(abs(errors))

# Calculate Mean Absolute Percentage Error (MAPE)
mape <- mean(abs(errors / actual_values_trimmed)) * 100

# Calculate Mean Squared Error (MSE)
mse <- mean(errors^2)

# Calculate Root Mean Squared Error (RMSE)
rmse <- sqrt(mse)

# Print the accuracy metrics
cat("Mean Absolute Error (MAE):", mae, "\n")
cat("Mean Absolute Percentage Error (MAPE):", mape, "%\n")
cat("Mean Squared Error (MSE):", mse, "\n")
cat("Root Mean Squared Error (RMSE):", rmse, "\n")


