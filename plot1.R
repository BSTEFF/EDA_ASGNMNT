library(reshape2)
library(ggplot2)
library(gridExtra)
library(ggpubr)
library(cowplot)

getwd()

rm(list = ls())

#load datasets
NEI = readRDS(file = "exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")
SCC = readRDS(file = "exdata%2Fdata%2FNEI_data/Source_Classification_Code.rds")


######plot1######
#subset different years
subset_99 = subset(NEI,subset = (year == 1999))
subset_02 = subset(NEI,subset = (year == 2002))
subset_05 = subset(NEI,subset = (year == 2005))
subset_08 = subset(NEI,subset = (year == 2008))

#Total Pollution per year / 1000
Pollution_99 = sum(subset_99$Emissions)/1000
Pollution_02 = sum(subset_02$Emissions)/1000
Pollution_05 = sum(subset_05$Emissions)/1000
Pollution_08 = sum(subset_08$Emissions)/1000
Pollution = c(Pollution_99,Pollution_02,Pollution_05,Pollution_08)
year = c(1999,2002,2005,2008)
par(mfrow = c(1,1))

plot1 = barplot(Pollution,names.arg = year,ylab = "PM 2.5 in kilotonnes", ylim = c(0,8000))


#save plot as png file
ggsave("plot1.png")
