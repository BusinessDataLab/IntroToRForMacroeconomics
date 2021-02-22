# Line Chart
# For this exercise, use the data file ClimateEX_module2, 
# or the one you created in the previous module.
# 
# a.Plot the annual maximum temperature and add a title.
load("plot_data/ClimateEX_module2.rda")
plot(climateY[,"Max"],
     main = "Annual Maximum Temperature",
     ylab="Temperature (degree Celsius)")


# b.Plot the annual precipitation for January, June and October on the same chart and add a title. Each line must have a different color and shape, and you must label the y-axis. 
# Finally, add a horizontal line equal to the average monthly precipitation of your sample with a different shape and color. Add a legend for all 4 lines.
plot(precY[,"Jan"],
     main="Total Precipitation For Some Months",
     ylab="Precipitation (mm)",lwd=2)
lines(precY[,"Jun"], col=2,lty=2,lwd=2)
lines(precY[,"Oct"], col=3,lty=3,lwd=2)
abline(h=mean(precM), col="darkblue", lwd=2,lty=4)
legend("topleft", c("January","June","October","Average"),
       col=c(1:3,"darkblue"),
       lty=1:4, lwd=2)


# c.Plot the monthly precipitation and add the annual precipitation to the graph. 
# The first must be black and the second must be a red dashed line with three times the thickness of the first. 
# Add a legend, a title and label the y-axis.
plot(precM, ylab="Precipitation (mm)")
title("Monthly and Annual Precipitation")
lines(precY[,"Total"]/12, lwd=3, col=2, lty=2)
legend("topleft", c("Monthly", "Annual Avg."), col=c(1,2),
       lty=1:2, lwd=c(1,3))





# Scatter Plot
# a.Create a scatter plot (with points) of maximum temperature per year as a function of annual total precipitation. 
# Add a title and labels for the axes.
plot(window(precY[,"Total"], start=start(precY), end=end(climateY)),
     window(climateY[,"Max"], start=start(precY), end=end(climateY)),
     xy.labels=FALSE, xy.lines=FALSE,
     xlab="Precipitation (mm)",
     ylab="Temperature (degree Celsius)",
     main="Maximum Temperature Versus Total Precipitation")

# b.Repeat the exercise for minimum temperature per year. 
# Connect the points and add the year over each point.
plot(window(precY[,"Total"], start=start(precY), end=end(climateY)),
     window(climateY[,"Min"], start=start(precY), end=end(climateY)),
     xy.labels=TRUE, xy.lines=TRUE,
     xlab="Precipitation (mm)",
     ylab="Temperature (degree Celsius)",
     main="Maximum Temperature Versus Total Precipitation")

# c.Create a total precipitation variable for each season. 
# Then, produce a scatter plot of precipitation as a function of the average temperature. 
# Use a different color and shape for each season and add a legend to your graph.
S <- precY[,"Jun"] + precY[,"Jul"] + precY[,"Aug"]
F <- precY[,"Sep"] + precY[,"Oct"] + precY[,"Nov"]
W <- precY[,"Dec"] + precY[,"Jan"] + precY[,"Feb"]
Sp <- precY[,"Mar"] + precY[,"Apr"] + precY[,"May"]


plot(window(climateY[,"Mean"], start=start(S), end=end(climateY)),
     window(S, start=start(S), end=end(climateY)),
     xlab="Temperature (degree Celsius)",
     ylab="Precipitation (mm)",ylim=c(0,60),
     main="Precipitation Versus Average Temperature",
     xy.labels=FALSE, xy.lines=FALSE, pch=21, bg=1)
points(window(climateY[,"Mean"], start=start(S), end=end(climateY)),
       window(F, start=start(S), end=end(climateY)),
       col=2, pch=22, bg=2)
points(window(climateY[,"Mean"], start=start(S), end=end(climateY)),
       window(W,  start=start(S), end=end(climateY)),
       col=3, pch=23, bg=3)
points(window(climateY[,"Mean"], start=start(S), end=end(climateY)),
       window(Sp,  start=start(S), end=end(climateY)),
       col=4, pch=24, bg=4)
legend("topleft", c("Summer","Fall","Winter","Spring"),
       col=1:4, pt.bg=1:4, pch=21:24)
# Histogram
# Create a histogram of precipitation using the monthly series. 
# Add a title, fill the rectangle with a color, and set the number of rectangles to 14.
# 
hist(precM, main="Distribution of Precipitation",
     xlab="Precipitation (mm)", breaks=15, col="lightgreen")

# Bar Plot
# a.Create a bar plot for precipitation per month in 1950. Add a title. 
# Sort the months from January to December and use the dark blue color.
dat <- window(precY, 1950, 1950)[1,c(5:13, 2:4)]
barplot(dat, col="darkblue",
        main="Precipitation in 1950",
        xlab="Month", ylab="Precipitation (mm)")

# b.Create a scatter bar plot for precipitation per month in 1950, 1960, 1980 and 2000. 
# Use different colors, add a legend in the top right corner, and add a main title. Position the bars beside each other.
dat50 <- window(precY, 1950, 1950)[1,c(5:13, 2:4)]
dat60 <- window(precY, 1960, 1960)[1,c(5:13, 2:4)]
dat80 <- window(precY, 1980, 1980)[1,c(5:13, 2:4)]
dat00 <- window(precY, 2000, 2000)[1,c(5:13, 2:4)]
dat <- rbind(dat50, dat60, dat80, dat00)

barplot(dat, col=rainbow(4),
        beside=TRUE,density=30, angle=c(0,30,60,100),
        legend.text=c(1950,1960, 1980, 2000),
        args.legend=list(x="topright"),
        main="Precipitation in Four Different Years",
        ylab="Precipitation (mm)", xlab="Month")
