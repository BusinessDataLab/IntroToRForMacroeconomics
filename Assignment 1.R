# Import data from csv file
imported_data <- read.csv("assignment_data/dat138.csv")

# Subset data to include only the expenditure column
dat138 <- imported_data[,3]

# convert to time series object
dat138_ts <- ts(dat138, frequency=4, start=1950) 

# Create Decimal dates from time series object
dat138_t <- time(dat138_ts) 

## Part A: Visualization
### 1. Plot the series using a line chart. Briefly describe what you see: 

# Plot the series using a line chart
plot(dat138_ts,
     ylab="Expenditure(thousands of dollars)", # y axis title
     xlab = "Time", # x axis title
     main="Expenditure vs Time" # main chart title
)

### 2. Answer the previous question using the log-scale. 
# Plot the series using a line chart
plot(log(dat138_ts),
     ylab="Expenditure(thousands of dollars)", # y axis title
     xlab = "Time", # x axis title
     main="Log of Expenditure vs Time" # main chart title
)


### 3. To better see how the growth rate evolves through time, plot the annualized growth rate of consumption expenditure. 

# create annualized data
dat138Y <- aggregate(dat138_ts, nfrequency = 1, FUN = sum)

# Plot the series using a line chart
plot(dat138Y,
     ylab="Annual Expenditure(thousands of dollars)", # y axis title
     xlab = "Time", # x axis title
     main="Annualized growth rate of consumption expenditure" # main chart title
)


## Part B: Time Series Decomposition

### 1. Fit a linear and quadratic trends to your series. 
# Then, create a line chart with your original series and the two trends. 
dat138coefT <- coef(lm(dat138_ts~dat138_t))
trend <- dat138coefT[1] + dat138coefT[2]*dat138_t

dat138_t2 <- dat138_t^2
dat138coefT2 <- coef(lm(dat138_ts~dat138_t+dat138_t2))
trend2 <- dat138coefT2[1] + dat138coefT2[2]*dat138_t + dat138coefT2[3]*dat138_t2

plot(dat138_ts,
     ylab="Expenditure (thousand dollars)",
     main="Linear Trend for Quarterly Expenditure",
     lwd=2)
lines(trend, col=2, lty=2, lwd=2)
lines(trend2, col=3, lty=2, lwd=3)
legend("topleft", c("Expenditure","Linear Trend","Quadratic Trend"), col=1:3,
       lty=1:3, lwd=1:3, bty='n')


### 2. Fit a linear and quadratic trends to the log of your series. 
# Then, create a line chart with the log of your series and the two trends. 
ldat183 <- log(dat138_ts)

lcoefT <- coef(lm(ldat183~dat138_t)) ## linear coefficients
lcoefT2 <- coef(lm(ldat183~dat138_t+dat138_t2)) ## quadratic coefficients
ltrend <- lcoefT[1] + lcoefT[2]*dat138_t ## linear trend
ltrend2 <- lcoefT2[1] + lcoefT2[2]*dat138_t + lcoefT2[3]*dat138_t2 ## quadratic trend


plot(ldat183, lwd=2, main="Expenditure With a Linear and Quadratic Trends (Log-Scale)",
     ylab="log(dat138_ts)")
lines(ltrend, col=2, lty=2, lwd=4)
lines(ltrend2, col=4, lty=3, lwd=4)
legend("topleft", c("log(dat138_ts)", "Linear","Quadratic"), col=c(1,2,4), lty=1:3,
       lwd=c(2,4,4), bty='n')


## Answer the following questions using the log of your series and the trends computed in question 2.

### 3. Plot the detrended series using the trend that best fit the series. 

# Linear trend
#plot(dat138_ts-trend, lwd=2,main="Detrended Expenditure Series Using a Linear Trend", 
#ylab="Expenditure (thousand dollars)")

# Quadratic Trend
plot(dat138_ts-trend2, lwd=2,
     main="Detrended Expenditure Series Using a Quadratic Trend",
     ylab="Expenditure (thousand dollars)")



### 4. Using a moving average of order 5, compute the cyclical component of your series. 
# Then, plot the cycle and briefly describe what you see: interpret the values of some peaks and troughs.
CSI <- dat138_ts-trend2
C <- filter(CSI, filter=rep(1/5,5))

plot(CSI, lwd=2,
     main="Detrended Expenditure Series and Its Cyclical Component",
     ylab="Expenditure (thousand dollars)")
lines(C, col=2, lwd=3, lty=2)
legend("topleft", c("Detrended Expenditure", "Cycle"), col=1:2, lty=1:2,
       lwd=2:3, bty='n') 


# 5. Plot the low frequency of your series and briefly describe what you see.
CT <- trend2+C
plot(CT, lwd=2,
     main="The Low Freq. Component of  Expenditure Series",
     ylab="Expenditure (thousand dollars)") 


# 6. Compute the seasonal component and represent it on a bar chart (only the 4 quarters). Interpret the four seasonal values.

Dec <- decompose(CSI, filter=rep(1/5,5))

S <- Dec$figure 
barplot(S, main="Expenditure Series Seasonal Component",
        names.arg=c("Q1","Q2","Q3","Q4"))

# Part C: Comovement
# Create a scatter plot of your series expressed in logs against the selected series also expressed in logs.
impoted_dat1 <- read.csv("assignment_data/dat1.csv")
dat1 <- impoted_dat1[,3]

dat1_ts <- ts(dat1, frequency=4, start=1950)
dat1_t <- time(dat1_ts)

ldat1 <- log(dat1_ts)


plot(ldat1,ldat183,
     ylab="Log of Dat138",xlab="Log of Dat1",
     main="Log of Dat138 vs Log Dat1")



# Using the log of the selected series, compute its cyclical component. 
# Then create a scatter plot of this cycle with the cycle of your series computed in Part B.
dat1coefT <- coef(lm(ldat1~dat1_t))
dat1trend <- dat1coefT[1] + dat1coefT[2]*dat1_t

dat1_t2 <- dat1_t^2
dat1coefT2 <- coef(lm(ldat1~dat1_t+dat1_t2))
dat1trend2 <- dat1coefT2[1] + dat1coefT2[2]*dat1_t + dat1coefT2[3]*dat1_t2

# Extracting the Cyclical Component of Temperature Anomalies
CSI_dat1  <- ldat1-dat1trend2
Dec_dat1  <- decompose(CSI_dat1, filter=rep(1/5,5))
Des_dat1  <- dat1_ts - Dec_dat1$seasonal


CSI_ldat138 <- ldat183-ltrend2
Dec_ldat138 <- decompose(CSI_ldat138, filter=rep(1/5,5))
Des_ldat138 <- dat138_ts - Dec_dat1$seasonal

C_dat138 <- Dec_ldat138$trend
C_dat1  <- Dec_dat1$trend
plot(C_dat138, C_dat1, pch=21, col=1, bg=1,
     main="Comovement Between the Cyclical Components of
 Dat138 and Dat1",
     xlab="Dat138 Expenditure (thousand dollars)", ylab="Dat1 Expenditure (thousand dollars)")


# Looking at the two scatter plots, what can you say about the type of comovement between the two series?

cyclical_component_dat <- cbind(C_dat138, C_dat1)
plot(exp_dat,
     main="Cyclical Components of Expenditures in thousand dollars for Dat138 and Dat1")





















