load("plot_data/Climate_module2.rda")

# 1.0 Creating a Line Chart With plot ----
?plot


# Get help for the time series function or command

?plot.default
?plot.ts

# 2.1 Using the plot command arguments ----
plot(tempY[,"Jan"])

# Adding Elements to an existing plot ----
plot(tempY[,"Jan"], # data
     col="blue", # line color
     lwd = 2, # line width
     lty=2, # line type
     ylab="Temperature (0.1 degree Celsius)", # y axis title
     xlab = "Our Time", # x axis title
     main="Temperature Anomalies for January" # main chart title
     )


# Adding Lines and Legends ----
plot(tempY[,"Jan"],col=1, lwd = 2,
     main="Annual Temperature Anomalies For Different Months",
     ylab="Temperature (0.1 degree Celsius)")
lines(tempY[,"Mar"], col="darkblue", lwd=2, lty=2)
lines(tempY[,"Oct"], col="darkred", lwd=3, lty=3)
lines(tempY[,"Dec"], col="yellow", lwd=4, lty=4)
abline(h=0,col=1,lwd = 2, lty=4)
legend("topleft", bty="o",
       c("January", "March", "October","December","1950-80 average"),
       col=c(1, "darkblue","darkred","yellow", 1),
       lty=c(1,2,3,4,4),lwd=2)
grid(nx=10,ny=10,col="darkgray")


# Adding a Polygon
plot(tempY[,"Jan"],col=1, lwd = 2,
     main="Annual Temperature Anomalies For Different Months",
     ylab="Temperature (0.1 degree Celsius)")
lines(tempY[,"Mar"], col="darkblue", lwd=2, lty=2)
lines(tempY[,"Oct"], col="darkred", lwd=3, lty=3)
abline(h=0,col=1,lwd = 2, lty=4)
legend("topleft", bty="n",
       c("January", "March", "October","1950-80 average"),
       col=c(1, "darkblue","darkred",1),
       lty=c(1,2,3,4),lwd=2)
polygon(c(1914,1914,1918,1918),c(-2,2,2,-2),
        col=gray(.8,.5),  border=NA)
polygon(c(1939,1939,1945,1945),c(-2,2,2,-2),
        col=gray(.4,.5), border=NA)
legend("bottomright", bty="n",
       c("World War I", "World War II"),
       col=c(gray(.8,.5),gray(.4,.5)),
       lty=1, lwd=6)
grid()

# Adding Series with Different Time periods

Jun <- window(tempY[,"Jun"], 1970, 2019)

plot(Jun,col=1, lwd = 2,
     main="Annual Temperature Anomalies For Different Months",
     ylab="Temperature (0.1 degree Celsius)")
lines(tempY[,"Jan"], col=2, lwd=3, lty=2)
legend("topleft", bty="n", c("January", "June"),
       col=c(1,2), lty=c(1,2),lwd=2)



# Set interval manually by adding the ylim and xlim arguements
plot(Jun,col=1, lwd = 2,ylim=c(-1.0,2.0),
     main="Annual Temperature Anomalies in June",
     ylab="Temperature (0.1 degree Celsius)",
     xlim=c(1880,2019))
lines(tempY[,"Mar"], col="darkblue", lwd=2, lty=2)
legend("topleft", bty="n", c("June", "March"),
       col=c(1,"darkblue"), lty=c(1,2),lwd=2)




# Adding Series With Different Frequency
plot(tempY[,"Jan"],col="blue", lwd = 3,
     ylab="Temperature (0.1 degree Celsius)",
     main="Temperature Anomalies: Monthly Versus Annual")
lines(tempM, col="black", lty=2)
legend("topleft", c("Annual", "Monthly"), col=c("blue","black"), lty=c(1,2),
       lwd=c(3,1))


# Using a Table of Time Series
season <- tempY[,c("DJF","MAM","JJA","SON")]

plot(season,lwd=2,
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
tempM2

# Co2 Emissions Versus Temperature Anomalies
plot(co2M, tempM2,
     xlab="Co2 (ppm)",
     ylab="Temperature (0.1 degree Celsius)",
     main="Co2 Emissions Versus Temperature Anomalies")


# Controlling the Type of Points
plot(co2M, tempM2, 
     pch="+", # controls the type of points
     col="darkgreen",
     xlab="Co2 (ppm)",
     ylab="Temperature (0.1 degree Celsius)",
     main="Co2 Emissions Versus Temperature Anomalies")

# Help
help(points)
?points


# 
plot(co2M, tempM2, pch=21, col="darkgreen",
     xlab="Co2 (ppm)",bg="yellow", 
     ylab="Temperature (0.1 degree Celsius)",
     main="Co2 Emissions Versus Temperature Anomalies")

plot(co2M, tempM2, pch=22, col="darkgreen",
     xlab="Co2 (ppm)", bg="blue",
     ylab="Temperature (0.1 degree Celsius)",
     main="Co2 Emissions Versus Temperature Anomalies")

plot(co2M, tempM2, pch=23, col="darkgreen",
     xlab="Co2 (ppm)",
     ylab="Temperature (0.1 degree Celsius)",
     main="Co2 Emissions Versus Temperature Anomalies")

# Scatter Plots With Connected Points
tempY2 <- aggregate(tempM, FUN=mean)
tempY2
tempY2 <- window(tempY2, start(co2Y), end(co2Y))
tempY2

plot(co2Y, tempY2,
     xlab="Co2 (ppm)", bg="green",
     ylab="Temperature (0.1 degree Celsius)",
     main="Co2 Emission Versus Temperature Anomalies")

plot(co2Y, tempY2,
     xlab="Co2 (ppm)",
     ylab="Temperature (0.1 degree Celsius)",
     main="Co2 Emissions Versus Temperature Anomalies",
     xy.labels=FALSE, xy.lines=FALSE)



















































