#The dataset("summarySCC_PM25.rds") in the current directory has 6497651 rows and 6 variables. 
#The overall goal of this assignment is to explore the National Emissions Inventory database
#and see what it say about fine particulate matter pollution in the United states over
#the 10-year period 1999–2008.
#Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
#Name each of the plot files as plot1.png, plot2.png, etc.
#This plot is to show if total emissions from PM2.5 decreased in the United States 
#from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission 
#from all sources for each of the years 1999, 2002, 2005, and 2008.


  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")

  png(filename="plot1.png",width=480,height=480,bg="white")

  total <- with(NEI, tapply(Emissions, year, sum, na.rm=T))
  plot(names(total),total,xlab="Year",ylab="Total Emissions (tons)",type="h",lwd=9,col="blue")
  title(main=expression('PM'[2.5]*' in the United States'))

  dev.off()
