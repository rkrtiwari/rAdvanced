## create time series of AirPassenger data
head(AirPassengers)
par(mfrow=c(1,1))
plot(AirPassengers)
apts <- ts(AirPassengers, frequency=12) 

## decomposing the time series into trend, seasonal, and random trend
f <- decompose(apts)
plot(f)

## Fit the data to arima model
fit <- arima(AirPassengers, order=c(1,0,0), 
             list(order=c(2,1,0), period=12))

## Make the forecast
fore <- predict(fit, n.ahead=24) 
U <- fore$pred + 2*fore$se        # upper limit 95% confidence interval 
L <- fore$pred - 2*fore$se        # lower limit 95% confidence interval

ts.plot(AirPassengers, fore$pred, U, L, col=c(1,2,4,4), lty = c(1,1,2,2))
legend("topleft", c("Actual", "Forecast", "Error Bounds (95% Confidence)"), 
       col=c(1,2,4), lty=c(1,1,2))



