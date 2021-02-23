dat1 <- read.csv("assignment_data/dat1.csv")
dat1_ts <- ts(dat1, frequency=4, start=1950) # convert to time series object

dat1_ts12 <- ts(dat1, frequency=12, start=1950)
# convert the dates of our time series into decimals. 
dat1_t <- time(dat1_ts)


fit <- lm(dat1_ts~dat1_t)

dat1_coef <- coef(fit)
trend <- coefT[1] + coefT[2]*t
trend

CSI <- co2M-trend2
C <- filter(CSI, filter=rep(1/5,5)) # cyclical component  Ct for monthly series

