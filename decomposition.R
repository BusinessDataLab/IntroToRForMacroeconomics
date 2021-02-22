# Load data
load("decomposition_data/Climate_module2.rda")

# Dates in Decimal Format for each year-month value
time(co2M)

# the first 8 decimal dates of co2M is:
time(co2M)[1:8]

# Fitting a Linear Trend To co2M
# create the time series t, 
# which is done using the time command which creates a time series with the same dates. 
# t is a time series that starts on March 1958 like co2M.
# offset values: 0 (the default) indicates the start of the unit, 0.5 the middle and 1 the end of the interval.
t <- time(co2M, offset=0.5)[1:8]
t

# Remember the Linear Trend equation i.e. T_t = a + bt
# * value of "a" is meaningless, so we focus the model on the last part of the equation 
# Just like the formula below shows the linear relationship between co2M and the time series object created
# Formula = co2M~t 
fit <- lm(co2M~t) # pass the formula to the  linear model command
fit # returns the values of a and b which are named (Intercept) and t respectively

# Note:
# t in the linear trend equation is the date series we previously created
# t returned from the model is the value for b which is the variation or annual change

# So, the linear trend equation is now  T_t = -2749.17 + 1.56t 
# T <- -2749.17+1.56*t

# Coefficients of the fit model
coefT <- coef(fit)
coefT

coefT[1]
coefT[2]

# Calculate the trend
trend <- coefT[1] + coefT[2]*t


# Summarily,
# 1. Create time series object
t <- time(co2M, offset=0.5)
# Get the coefficients of a linear model based on the data and the time series object
coefT <- coef(lm(co2M~t))
# Calculate the trend based on the returned coefficients
trend <- coefT[1] + coefT[2]*t
trend

# Adding a Trend to a Time Series Chart
plot(co2M, lwd=2, main="Co2 Emissions With a Linear Trend",
     ylab="Co2 (ppm)")
lines(trend, col=2, lty=2, lwd=2)
legend("topleft", c("Co2", "Trend"), col=1:2, lty=1:2,
       lwd=2, bty='n')

# Fitting a Quadratic Trend To co2M
# T_t = a + bt+ct^2 

# First, we create  t2 :

t2 <- t^2

fit2 <- lm(co2M~t+t2)
coefT2 <- coef(fit2)
trend2 <- coefT2[1] + coefT2[2]*t + coefT2[3]*t2
trend2
 
# 
lcoefT <- coef(lm(lco2M~t)) ## linear coefficients
lcoefT2 <- coef(lm(lco2M~t+t2)) ## quadratic coefficients

ltrend <- lcoefT[1] + lcoefT[2]*t ## linear trend

ltrend2 <- lcoefT2[1] + lcoefT2[2]*t + lcoefT2[3]*t2 ## quadratic trend

# Plot
plot(lco2M, lwd=2, main="Co2 Emissions With a Linear and Quadratic Trends (Log-Scale)",
     ylab="log(Co2)")
lines(ltrend, col=2, lty=2, lwd=4)
lines(ltrend2, col=4, lty=3, lwd=4)
legend("topleft", c("log(Co2)", "Linear","Quadratic"), col=c(1,2,4), lty=1:3,
       lwd=c(2,4,4), bty='n')



# Detrending a Series
# The cycle can be extracted from the detrended series (Xt−Tt)
# Linear Trend
plot(co2M-trend, lwd=2,
     main="Detrended Co2 Emissions Series Using a Linear Trend",
     ylab="Co2 (ppm)")

# Quadratic Trend
plot(co2M-trend2, lwd=2,
     main="Detrended Co2 Emissions Series Using a Quadratic Trend",
     ylab="Co2 (ppm)") 

# Cyclical Component of the  CO2  Emissions Series
# First, we create the detrended series and name it CSI (for  Ct+St+It ):
# i.e. X_t-T_t = Ct+St+It
CSI <- co2M-trend2

# To extract  Ct , we use the function filter. 
# The first argument is the series and the second is the filter, which is a list of weights. 
# Example
x <- c(1,2,3,4,5,6)
filter(x, filter=c(1/3,1/3,1/3)) # the filter here is what we defined as an MA(3) 

# Filters for monthly and quarterly series
# cyclical component is extracted using an MA(5) for quarterly series 
# and an MA(13) for monthly series.

# So, the filter for quarterly series is a list of 5 elements equal to 1/5, 
# and it is a list of 13 elements equal to 1/13 for monthly series. As shown below:

rep(1/5,5)


rep(1/13,13)

# the cyclical component  Ct  of the  CO2  emissions series can be extracted as follows:

C <- filter(CSI, filter=rep(1/13,13)) # monthly series


# Plot
plot(CSI, lwd=2,
     main="Detrended Co2 Emissions and Its Cyclical Component",
     ylab="Co2 (ppm)")
lines(C, col=2, lwd=3, lty=2)
legend("topleft", c("Detrended Co2", "Cycle"), col=1:2, lty=1:2,
       lwd=2:3, bty='n') 


CT <- trend2+C

plot(CT, lwd=2,
     main="The Low Frequency Component of  Co2",
     ylab="Co2 (ppm)") 









































