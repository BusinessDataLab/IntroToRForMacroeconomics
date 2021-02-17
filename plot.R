
# 1.0 Creating a Line Chart With plot ----



# Get help for the time series function or command

# ?plot.default
# ?plot.ts

# 2.1 Using the plot command arguments ----


# Adding Elements to an existing plot ----



# Adding Lines and Legends ----



# Adding a Polygon


# Adding Series with Different Time periods

Jun <- window(tempY[,"Jun"],1970,2019)




# Set interval manually by adding the ylim and xlim arguements





# Adding Series With Different Frequency



# Using a Table of Time Series
season <- tempY[,c("DJF","MAM","JJA",
                   "SON"
)]

plot(season,
     lwd=2,
     main="Temperature Anomalies For the Four Seasons")

# If we want the series on the same chart, we can set the argument
# plot.type to "single"

plot(season,
     lwd=2,
     col=1:4,
     lty=1:4,
     main="Temperature Anomalies For the Four Seasons",
     plot.type="single",
     ylab ="Temperature (0.1 degree Celsius)")
legend("topleft",
       c("Winter","Spring","Summer","Fall"),
       col=1:4, lty=1:4, lwd=2)



# Combining Series Into a Table

climate <- cbind(tempM, co2M)

plot(climate,lwd=2,main="Monthly Climate Series")



# 2.2 Scatter Plots


# Matching the Periods
start(co2M)


end(co2M)


start(tempM)


end(tempM)


tempM2 <- window(tempM, start(co2M), end(co2M))


# Co2 Emissions Versus Temperature Anomalies
plot(co2M, tempM2,
     xlab="Co2 (ppm)",
     ylab="Temperature (0.1 degree Celsius)",
     main="Co2 Emissions Versus Temperature Anomalies")


# Controlling the Type of Points
plot(co2M, tempM2, 
     pch="*", # controls the type of points
     col="darkgreen",
     xlab="Co2 (ppm)",
     ylab="Temperature (0.1 degree Celsius)",
     main="Co2 Emissions Versus Temperature Anomalies")

# Help
help(points)
?points


# 
plot(co2M, tempM2, pch=21, col="darkgreen",
     bg="red", xlab="Co2 (ppm)",
     ylab="Temperature (0.1 degree Celsius)",
     main="Co2 Emissions Versus Temperature Anomalies")




























































