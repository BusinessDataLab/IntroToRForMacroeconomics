# Creating a Monthly Time Series
load("data/climate.rda")

co2M <- ts(co2data, frequency=12, start=c(1958,3))
co2M

tempdata[1:5,1:5]

tempY <- ts(tempdata, start=1880)
Jan <- tempY[,"Jan"]
Feb <- tempY[,"Feb"]

window(tempY[,"Jan"], start=1990, end=1994)

t(tempdata[1:5,2:13])
tempM <- c(t(tempdata[,2:13]))

tempM <- ts(tempM, frequency=12, start=c(1880,1))

load("module2/ClimateEX_module1.rda")
# a
precY <- ts(temp_prec,start = 1921)

precM <- c(t(temp_prec[c(5:13,2:4)]))
precM <- ts(precM, frequency=12, start=c(1921,1))

