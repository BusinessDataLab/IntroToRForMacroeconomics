# 1.0 Load .rda data ----
load("plot_data/Climate_module2.rda")

# 2.0 Basics of Subsetting data ----
# Format
# data[row, column]
str(tempY)

# 2.1 Subsetting observations i.e. rows ----
tempY[,c("Jan","May","Oct")]


# 2.2 Subsetting variables i.e. column names ----



# 2.3 Subsetting rows and columns ----



# 2.4 Subsetting based on Logical tests ----

subset(tempY,tempY[,"Jan"]>0.1)
