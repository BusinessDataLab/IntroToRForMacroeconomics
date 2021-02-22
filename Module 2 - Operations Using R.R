load("module2/Climate_module2.rda")

# List of temperature
x <- c(56,80,90,26)

# convert it into degrees Celsius
(x-32)
(x-32)*5/9

# convert tempM into degrees Celsius
tempM_C <- tempM/10

# Or
# tempM_C <- tempM*0.1

# Let's compare a subset of each series to make sure that it worked as expected:
window(tempM, c(1960,1), c(1960,8))

window(tempM_C, c(1960,1), c(1960,8))

# Operations on Multiple Series
c(1,2,3,4) * c(2,3,4,5) 
sum(c(1,2,3,4), c(2,3,4,5) )

# For time series, it is different, 
# We can only add observations from the same date. 
# Dates that cannot be matched are ignored. 
# That's an interesting feature, because we can add two time series that cover different periods. 
# Here is an example using the monthly  CO2  series:

window(co2M, c(1960,1), c(1961,1)) + window(co2M, c(1960,6), c(1961,11))

# Above, we only have a result for the period starting in June 1960 
# and ending in January 1961 because these are the only common dates.

# As another example, we can compute the average temperature anomalies for Summer 
# by adding June, July and August, and dividing by 3:

Summer <- (tempY[,"Jun"] + tempY[,"Jul"] + tempY[,"Aug"])/3
Summer


# We already have a series for Summer, and it is named JJA. 
# We can compare the values we computed with the ones in the dataset:

window(tempY[,"JJA"], 1940,1950)


window(Summer, 1940,1950)


round(window(Summer, 1940,1950),2)



# Growth Rates
co2_60 <- window(co2M, c(1960,1), c(1960,12))
co2_60

# We need two commands, diff and lag.
# The former computes the difference  Xt−Xt−1 , and the second computes  Xt+s  for any  s . 
# The value of  s  is the second argument of lag. If we want  Xt−1 , we set the second argument to -1. 
# The monthly growth rates of  CO2  for 1960 in percentage are therefore:

diff(co2_60)/lag(co2_60,-1)*100

# Notice that we don't have a growth rate for January, 
# because the observation for December 1959 is not available. 
# Let's verify for February:

(316.97-316.43)/316.43*100

# compute the annualized growth rates:

g <- diff(co2_60)/lag(co2_60,-1) ## no percentage yet
g <- ((1+g)^12)-1 ## exact formula
g <- g*100 ## back to percentage
g

# Let's verify for February using the first rate (remember that 0.17% = 0.0017):

((1+0.001706539)^12-1)*100 

# Logarithm Scale

# transform a series using log
lco2_60 <- log(co2_60)
lco2_60

# Then, we can verify that the differences are very close to the growth rates we computed in the previous section.
diff(lco2_60)*100 # in percentage. It is indeed not too different.


# Aggregation
# aggregate a time series. We use the command aggregate. 
# The important arguments are: 
# nfrequency, for new frequency, and 
# FUN, which is the function used for the aggregation. 
# Let's created a longer  CO2  series to illustrate how it works:

co260_65 <- window(co2M, c(1960,1),c(1965,12))

# aggregate using the sum, set FUN to sum.
# To create quarterly series, we set nfrequency to 4:
aggregate(co260_65, nfrequency=4, FUN=sum)

# To create annual series, we set nfrequency to 1:

aggregate(co260_65, nfrequency=1, FUN=sum)

# It is important to know that we need complete years to aggregate a series. 
# The years 1958 and 2019 of the co2M dataset are incomplete. 
# We therefore need to use window to restrict the period to 1959-2018. 
# Create the annual time series co2Y and add it to the climate.rda file by typing the following:

co2Y <- aggregate(window(co2M, c(1959,1), c(2018,12)), nfrequency=1, FUN=sum)
save(tempdata, co2data, tempM, tempY, co2M, co2Y, file="module2/climate.rda") 
# Now we have a monthly and annual series for temperature and  CO2  emission.

# Index Number
# Computing index numbers is simply an application of what we have already learned. 
# Create subset of our new annual  CO2  series:

co2Y60_70 <- window(co2Y, 1960, 1970)
co2Y60_70

# We can construct an index base 100 = 1962 manually:
  
co2Y60_70/3821.41*100


# 







































































