#The dataset("summarySCC_PM25.rds") in the current directory has 6497651 rows and 6 variables. 
#The overall goal of this assignment is to explore the National Emissions Inventory database
#and see what it say about fine particulate matter pollution in the United states over
#the 10-year period 1999–2008.
#Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
#Name each of the plot files as plot1.png, plot2.png, etc.
#Baltimore City, Maryland (fips == "24510")
#This plot is to show how emissions from motor vehicle sources changed from 1999–2008 in Baltimore City? 

  library(ggplot2)
  library(plyr)

  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")

  png(filename="plot5.png",width=480,height=480,bg="white")

  subNEI <- subset(NEI, fips == "24510")	#Baltimore City, Maryland
  subSCC <- subset(SCC, EI.Sector %in% c("Mobile - On-Road Diesel Heavy Duty Vehicles",
	"Mobile - On-Road Gasoline Heavy Duty Vehicles", "Mobile - On-Road Diesel Light Duty Vehicles",
	"Mobile - On-Road Gasoline Light Duty Vehicles"))
  subNEI <- subset(subNEI, SCC %in% subSCC$SCC)

  total <- ddply(subNEI, .(year,type), function (x) sum(x$Emissions,na.rm=T))
  colnames(total)[3] <- "Emissions"

  p <- qplot(year,Emissions,data=total,color=type,geom="line")
  p <- p + xlab("Year") + ylab("Total Emissions (tons)")
  p <- p + ggtitle(expression('PM'[2.5]*' in Baltimore City, Maryland by motor vehicles'))

  print(p)

  dev.off()
