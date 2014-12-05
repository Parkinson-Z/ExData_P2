#The dataset("summarySCC_PM25.rds") in the current directory has 6497651 rows and 6 variables. 
#The overall goal of this assignment is to explore the National Emissions Inventory database
#and see what it say about fine particulate matter pollution in the United states over
#the 10-year period 1999–2008.
#Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
#Name each of the plot files as plot1.png, plot2.png, etc.
#This plot is to show if total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#(fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")

  png(filename="plot2.png",width=480,height=480,bg="white")

  total <- with(subset(NEI,fips == "24510"), tapply(Emissions, year, sum, na.rm=T))	#Baltimore City, Maryland
  plot(names(total),total,xlab="Year",ylab="Total Emissions (tons)",type="h",lwd=9,col="blue")
  title(main=expression('PM'[2.5]*' in Baltimore City, Maryland'))

  dev.off()
