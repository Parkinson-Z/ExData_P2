#The dataset("summarySCC_PM25.rds") in the current directory has 6497651 rows and 6 variables. 
#The overall goal of this assignment is to explore the National Emissions Inventory database
#and see what it say about fine particulate matter pollution in the United states over
#the 10-year period 1999–2008.
#Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
#Name each of the plot files as plot1.png, plot2.png, etc.
#Baltimore City, Maryland (fips == "24510")
#This plot is to compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
#vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater 
#changes over time in motor vehicle emissions?

  library(ggplot2)
  library(plyr)

  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")

  png(filename="plot6.png",width=480,height=480,bg="white")

  motor_subset <- function(code="24510",city="Baltimore")
  {
    subNEI <- subset(NEI, fips == code)	#City
    subSCC <- subset(SCC, EI.Sector %in% c("Mobile - On-Road Diesel Heavy Duty Vehicles",
	"Mobile - On-Road Gasoline Heavy Duty Vehicles", "Mobile - On-Road Diesel Light Duty Vehicles",
	"Mobile - On-Road Gasoline Light Duty Vehicles"))
    subNEI <- subset(subNEI, SCC %in% subSCC$SCC)
    total <- ddply(subNEI, .(year), function (x) sum(x$Emissions,na.rm=T))
    colnames(total)[2] <- "Emissions"
    total$city <- city
    total
  }

  total <- rbind(motor_subset("24510","Baltimore"),motor_subset("06037","Los Angeles"))	#Baltimore,Los Angeles

  p <- qplot(year,Emissions,data=total,color=city,geom="line")
  p <- p + xlab("Year") + ylab("Total Emissions (tons)")
  p <- p + ggtitle(expression('PM'[2.5]*' in Baltimore and Los Angeles by motor vehicles'))

  print(p)

  dev.off()
