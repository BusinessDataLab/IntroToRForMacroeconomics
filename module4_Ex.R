load("module 4/Climate_module2.rda")


t <- time(co2Q)
# Get the coefficients of a linear model based on the data and the time series object
coefT <- coef(lm(co2Q~t))
# Calculate the trend based on the returned coefficients
trend <- coefT[1] + coefT[2]*t
trend

plot(co2Q,
     main="Quarterly Co2 Emissions", ylab="Co2 (ppm)",
     lwd=2)
lines(trend, col=2, lty=2, lwd=2)
legend("topleft", c("Co2","Linear Trend"), col=1:2,
       lty=1:2, lwd=2, bty='n')

t2 <- t^2
coefT2 <- coef(lm(co2Q~t+t2))
trend2 <- coefT2[1] + coefT2[2]*t + coefT2[3]*t2

plot(co2Q,
     main="Quarterly Co2 Emissions", ylab="Co2 (ppm)",
     lwd=2)
lines(trend2, col=2, lty=2, lwd=2)
legend("topleft", c("Co2","Quadratic Trend"), col=1:2,
       lty=1:2, lwd=2, bty='n')

CSI <- co2Q-trend2

dec <- decompose(CSI, filter=rep(1/5,5))
C <- dec$trend

plot(CSI,
     main="Detrended Quarterly Co2 Emissions and Its Cycle",
     ylab="Co2 (ppm)",
     lwd=2)
lines(C, col=2, lty=2, lwd=2)
legend("topleft", c("Detrended Co2","Cycle"), col=1:2,
       lty=1:2, lwd=2, bty='n')

plot(trend+C,
     main="Low Frequency Component of the Quarterly Co2 Emissions Series",
     ylab="Co2 (ppm)",
     lwd=2)

barplot(dec$figure,names.arg=c("Qtr1","Qtr2", "Qtr3", "Qtr4"), 
        main="Seasonal Component of Quarterly Co2 Emissions", ylab="Co2 (ppm)")


# First, we deseasonalize the series:

adj_co2Q <- co2Q-dec$seasonal
# Then, we create the chart.

plot(co2Q,
     main="Quarterly Co2 Emissions",
     ylab="Co2 (ppm)",
     lwd=2)
lines(adj_co2Q, col=2, lty=2, lwd=2)
legend("topleft", c("Not adjusted","Adjusted"), col=1:2,
       lty=1:2, lwd=2, bty='n')



