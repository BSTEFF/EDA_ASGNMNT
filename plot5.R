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


######plot5######
#need to split/ aggregate by onroad thing. and not the way I did it.
Baltimore_City = subset(NEI,subset = (fips == "24510"))
SCC_sub = SCC[grep("Onroad",SCC$Data.Category),]
Balti_mvs = merge(Baltimore_City,SCC_sub, by.x = c("SCC"),by.y = c("SCC"))
Balti_mvs_sum = aggregate(Balti_mvs$Emissions, by = list(Balti_mvs$year),sum)
plot5 = ggplot(Balti_mvs_sum, aes(x = as.character(Group.1), y = x)) + geom_bar(stat = "identity") +ggtitle(label = "Motor vehicle related emissions - Baltimore") + labs(x ="year", y = "PM2.5 in tonnes")
plot5
#save plot as png file
ggsave("plot5.png")
