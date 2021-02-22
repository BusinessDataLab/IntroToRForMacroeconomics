load("module 4/Climate_module2.rda")
# For this exercise, use the quarterly co2Q dataset from the Climate_module2 file 
# For each chart, add a meaningful title, a Y-axis title with measurement unit and a legend when needed.

# Compute the trend component of the series and 
# create a line chart with the series and its trend. Use the linear trend.

t <- time(co2Q, offset=0.5)
# Get the coefficients of a linear model based on the data and the time series object
coefT <- coef(lm(co2Q~t))
# Calculate the trend based on the returned coefficients
trend <- coefT[1] + coefT[2]*t
trend

# Adding a Trend to a Time Series Chart
plot(co2Q, lwd=2, main="Co2 Emissions With a Linear Trend",
     ylab="Co2 (ppm)")
lines(trend, col=2, lty=2, lwd=2)
legend("topleft", c("co2Q", "Trend"), col=1:2, lty=1:2,
       lwd=2, bty='n')

# Quadratic trend
t2 <- t^2

fit2 <- lm(co2M~t+t2)
coefT2 <- coef(fit2)
trend2 <- coefT2[1] + coefT2[2]*t + coefT2[3]*t2
trend2

# Plot
plot(co2M, lwd=2, main="Co2 Emissions With a Quadratic Trend",
     ylab="Co2 (ppm)")
lines(trend2, col=2, lty=2, lwd=2)
legend("topleft", c("Co2", "Trend"), col=1:2, lty=1:2,
       lwd=2, bty='n')


































