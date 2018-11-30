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

######plot2######

#Baltimore
Baltimore_City = subset(NEI,subset = (fips == "24510"))

Balti_99 = subset(Baltimore_City, subset = year ==1999)
Balti_02 = subset(Baltimore_City, subset = year ==2002)
Balti_05 = subset(Baltimore_City, subset = year ==2005)
Balti_08 = subset(Baltimore_City, subset = year ==2008)

Balti_Pol_99 = sum(Balti_99$Emissions)
Balti_Pol_02 = sum(Balti_02$Emissions)
Balti_Pol_05 = sum(Balti_05$Emissions)
Balti_Pol_08 = sum(Balti_08$Emissions)
Balti_Pollution = c(Balti_Pol_99,Balti_Pol_02,Balti_Pol_05,Balti_Pol_08)
year = c(1999,2002,2005,2008)

plot2 = barplot(Balti_Pollution,names.arg = year,ylab = "PM 2.5 in tonnes", ylim = c(0,3500))

ggsave("plot2.png")
