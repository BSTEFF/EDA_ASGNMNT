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


######plot6######
Baltimore_City = subset(NEI,subset = (fips == "24510"))
SCC_sub = SCC[grep("Onroad",SCC$Data.Category),]
Balti_mvs = merge(Baltimore_City,SCC_sub, by.x = c("SCC"),by.y = c("SCC"))
Balti_mvs_sum = aggregate(Balti_mvs$Emissions, by = list(Balti_mvs$year),sum)
plot5 = ggplot(Balti_mvs_sum, aes(x = as.character(Group.1), y = x)) + geom_bar(stat = "identity") +ggtitle(label = "Motor vehicle related emissions - Baltimore") + labs(x ="year", y = "PM2.5 in tonnes")

LA = subset(NEI,subset = (fips == "06037"))
SCC_sub = SCC[grep("Onroad",SCC$Data.Category),]
LA_mvs = merge(LA,SCC_sub, by.x = c("SCC"),by.y = c("SCC"))
LA_mvs_sum = aggregate(LA_mvs$Emissions, by = list(LA_mvs$year),sum)
plot6 = ggplot(LA_mvs_sum, aes(x = as.character(Group.1), y = x)) + geom_bar(stat = "identity") +ggtitle(label = "Motor vehicle related emissions - LA") + labs(x ="year", y = "PM2.5 in tonnes")
grid.arrange(plot6, plot5, ncol = 1)

P6 = plot_grid(plot6,plot5, ncol = 1)
save_plot("plot6.png",P6)
