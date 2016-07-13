## creating a time series
a <- ts(1:30, frequency=12, start=c(2011,3)) 
a
str(a)
attributes(a)

## create time series of AirPassenger data
par(mfrow=c(1,1))
head(AirPassengers)
plot(AirPassengers)
apts <- ts(AirPassengers, frequency=12) 

## decomposing the time series into trend, seasonal, and random trend
f <- decompose(apts)
names(f)
f$x
plot(f$figure, type="b", xaxt="n", xlab="") 
monthNames <- months(ISOdate(2011,1:12,1)) 
axis(1, at=1:12, labels=monthNames, las=2)
plot(f)

## Fit the data to arima model
fit <- arima(AirPassengers, order=c(1,0,0), 
             list(order=c(2,1,0), period=12))

## Make the forecast
fore <- predict(fit, n.ahead=24) 
U <- fore$pred + 2*fore$se
L <- fore$pred - 2*fore$se 
ts.plot(AirPassengers, fore$pred, U, L, col=c(1,2,4,4), lty = c(1,1,2,2))
legend("topleft", c("Actual", "Forecast", "Error Bounds (95% Confidence)"), 
       col=c(1,2,4), lty=c(1,1,2))
