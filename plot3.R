#The dataset("summarySCC_PM25.rds") in the current directory has 6497651 rows and 6 variables. 
#The overall goal of this assignment is to explore the National Emissions Inventory database
#and see what it say about fine particulate matter pollution in the United states over
#the 10-year period 1999–2008.
#Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
#Name each of the plot files as plot1.png, plot2.png, etc.
#Baltimore City, Maryland (fips == "24510")
#This plot is to show Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
#variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make 
#a plot answer this question.

  library(ggplot2)
  library(plyr)

  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")

  png(filename="plot3.png",width=480,height=480,bg="white")

  subNEI <- subset(NEI, fips == "24510")	#Baltimore City, Maryland
  total <- ddply(subNEI, .(year,type), function (x) sum(x$Emissions,na.rm=T))
  colnames(total)[3] <- "Emissions"

  p <- qplot(year,Emissions,data=total,color=type,geom="line")
  p <- p + xlab("Year") + ylab("Total Emissions (tons)")
  p <- p + ggtitle(expression('PM'[2.5]*' in Baltimore City, Maryland'))

  print(p)

  dev.off()
