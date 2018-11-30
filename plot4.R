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

######plot4######

# first look at scc list and pick out all El.sector things that contain coal. thats list to work with.
# sorthis dataset with split in the years and show sum of coal bla per year. barplot showing trend.
SCC_sub =SCC[grep("Coal",SCC$EI.Sector),]
Coal_polution = merge(NEI,SCC_sub,by.x = c("SCC"),by.y = c("SCC"))
Coal_sum = aggregate(Coal_polution$Emissions, by = list(Coal_polution$year),sum)

plot4 = ggplot(Coal_sum, aes(x = as.character(Group.1), y = x)) + geom_bar(stat = "identity") +ggtitle(label = "Coal-related emissions") + labs(x ="year", y = "PM2.5 in tonnes")
plot4

#save plot as png file
ggsave("plot4.png")
