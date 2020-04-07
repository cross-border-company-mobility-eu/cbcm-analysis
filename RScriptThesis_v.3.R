#install.packages(c("ggplot2", "pscl", "MASS", "boot", "moments", "reshape2", "Hmisc","readxl"))
# Basics for NBIN Model

library("readxl", lib.loc="~/opt/anaconda3/lib/R/library")
library("ggplot2", lib.loc="~/opt/anaconda3/lib/R/library")
library(ggplot2)
library(pscl)
library(MASS)
library(boot)
#library(moments)
#library(reshape2)
#library(datasets)
#library(Hmisc)


zinb_frame <- read_xlsx("/Users/pedrohserrano/cbcm-analysis/Rdata1imputed.xlsx")
summary(zinb_frame)

#Cleaning Data
is.na(zinb_frame)
na.rm = TRUE

GDP <- zinb_frame$GDP
mean(GDP, na.rm = TRUE)

#GRAPHICS
#Plot Histogram
hist(zinb_frame$CBMAC, xlim = c(0,150), probability = TRUE)
lines(density(zinb_frame$CBMAC))

ggplot(zinb_frame, aes(x=CBMAC)) + geom_histogram(binwidth = 1, color = "black", fill = "white") + labs(x = "CBMAC", y= "Frequency", title = "Histogram of CBCM")
ggplot(zinb_frame, aes(x=CBMMC)) + geom_histogram(binwidth = 1, color = "black", fill = "white") + labs(x = "CBMMC", y= "Frequency", title = "Histogram of CBCM")
ggplot(zinb_frame, aes(x=CBCAC)) + geom_histogram(binwidth = 1, color = "black", fill = "white") + labs(x = "CBCAC", y= "Frequency", title = "Histogram of CBCM")
ggplot(zinb_frame, aes(x=CBCMC)) + geom_histogram(binwidth = 1, color = "black", fill = "white") + labs(x = "CBCMC", y= "Frequency", title = "Histogram of CBCM")
ggplot(zinb_frame, aes(x=CBSTAC)) + geom_histogram(binwidth = 1, color = "black", fill = "white") + labs(x = "CBSTAC", y= "Frequency", title = "Histogram of CBCM")

ggplot(zinb_frame, aes(x=CBMAC)) +
  geom_density() +

#Plot Piechart
pie(table(zinb_frame$CBMAC))

#Barplot
barplot(table(zinb_frame$CBMAC), xlab = "No. Transactions", ylab = "Frequency")
barplot(table(zinb_frame$CBMMC), xlab = "No. Transactions", ylab = "Frequency")
barplot(table(zinb_frame$CBCAC), xlab = "No. Transactions", ylab = "Frequency")
barplot(table(zinb_frame$CBCMC), xlab = "No. Transactions", ylab = "Frequency")

#Grouped Barplot?

#Dotchart
dotchart(zinb_frame$CBMAC, zinb_frame$Inflation)

#DESCRIPTIVE STATISTICS
nrow(zinb_frame)
sum(zinb_frame$CBMAC == 0)
sum(zinb_frame$CBMAC != 0)
sum(zinb_frame$CBMAC == 2 & zinb_frame$CBMAC == "Germany")
sum(zinb_frame$CBMMC == 0)
sum(zinb_frame$CBCAC == 0)
sum(zinb_frame$CBCMC == 0)
sum(zinb_frame$CBSTAC == 0)

range(zinb_frame$CBMAC)

skewness(zinb_frame$CBMAC)
#if skewness is positive, it is skewed to the right which is indeed the case in this thesis data

kurtosis(zinb_frame$CBMAC)
kurtosis(zinb_frame$CBMMC)

describe(zinb_frame)

datadensity(zinb_frame)

#MODEL
#NBIN
m1 <- glm.nb(CBMAC ~ GDP+ Inflation + Interest + Exc + Unem, data = zinb_frame)
summary(m1)

#Zero-NBIN Model (default)
m2 <- zeroinfl(CBMAC ~ Inflation + Interest + Exc + Unem, data = zinb_frame)
summary(m2)

#Zero-NBIN Model
m4 <- zeroinfl(CBMAC ~ Inflation + Interest + Exc + Unem, dist = 'negbin', data = zinb_frame)
summary(m4)



#OTHER
#Old
zinb <- read.csv(file = "/Users/Georgia1/Desktop/Rdata.xlsx", header=FALSE, sep = "", quote = "", dec = ".", col.names = "ID, Year, Country, CBMAC, CBMMC, CBCAC, CBCMC, CBSTAC, CBSTMC, CBDAC, CBDMC, GDP, Inflation, Interest, Exc, Unem")
summary(zinb)

ggplot(zinb_frame, aes(CBMAC, fill = X)) + 
  geom_histogram() +
  scale_x_discrete() +
  facet_grid(CBMAC ~ ., margins=TRUE, scales="free_y")

gghistogram(Rdata1, x="CBMAC", bins=100, add="mean")

#check error
rlang::last_error()

#Packages
update.packages(ask = FALSE)
