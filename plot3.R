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


######plot3######
Baltimore_City = subset(NEI,subset = (fips == "24510"))

Pollution_source = split(Baltimore_City,Baltimore_City$type)
Nonroad = Pollution_source$`NON-ROAD`
Nonpoint = Pollution_source$NONPOINT
Onroad = Pollution_source$`ON-ROAD`
Point = Pollution_source$POINT
str(Nonroad)

par(mfrow =c(2,2))
Nonroad_sum = aggregate(Nonroad$Emissions,by= list(Nonroad$year),sum)
Nonpoint_sum = aggregate(Nonpoint$Emissions,by= list(Nonpoint$year),sum)
Onroad_sum = aggregate(Onroad$Emissions,by= list(Onroad$year),sum)
Point_sum = aggregate(Point$Emissions,by= list(Point$year),sum)

NR = ggplot(Nonroad_sum, aes(x = as.character(Group.1), y = x)) + geom_bar(stat = "identity") + ggtitle(label = "Nonroad") + labs(x = "year", y = "PM2.5 in tonnes")
NP = ggplot(Nonpoint_sum, aes(x = as.character(Group.1), y = x)) + geom_bar(stat = "identity") + ggtitle(label = "Nonpoint")+ labs(x = "year", y = "PM2.5 in tonnes")
OR = ggplot(Onroad_sum, aes(x = as.character(Group.1), y = x)) + geom_bar(stat = "identity") + ggtitle(label = "Onroad")+ labs(x = "year", y = "PM2.5 in tonnes")
P = ggplot(Point_sum, aes(x = as.character(Group.1), y = x)) + geom_bar(stat = "identity") + ggtitle(label = "Point")+ labs(x = "year", y = "PM2.5 in tonnes")

grid.arrange(NR, NP, OR, P, nrow = 2, ncol = 2)
P3 = plot_grid(NR,NP,OR,P, ncol = 2, nrow = 2)
save_plot("plot3.png", P3)

