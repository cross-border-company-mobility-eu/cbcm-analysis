# Basics for NBIN Model
library(ggplot2)
library(pscl)
library(MASS)
library(boot)
library(moments)
library(reshape2)
library(datasets)
library(Hmisc)

zinb_frame <- read_xlsx("/Users/Georgia1/Desktop/Rdata1.xlsx")
summary(zinb_frame)

#Cleaning Data
is.na(zinb_frame)
na.rm = TRUE
mean(GDP, na.rm = TRUE)

#GRAPHICS
#Plot Histogram
hist(Rdata1$CBMAC, xlim = c(0,150), probability = TRUE)
lines(density(Rdata1$CBMAC))

ggplot(zinb_frame, aes(x=CBMAC)) + geom_histogram(binwidth = 1, color = "black", fill = "white") + labs(x = "CBMAC", y= "Frequency", title = "Histogram of CBCM")
ggplot(zinb_frame, aes(x=CBMMC)) + geom_histogram(binwidth = 1, color = "black", fill = "white") + labs(x = "CBMMC", y= "Frequency", title = "Histogram of CBCM")
ggplot(zinb_frame, aes(x=CBCAC)) + geom_histogram(binwidth = 1, color = "black", fill = "white") + labs(x = "CBCAC", y= "Frequency", title = "Histogram of CBCM")
ggplot(zinb_frame, aes(x=CBCMC)) + geom_histogram(binwidth = 1, color = "black", fill = "white") + labs(x = "CBCMC", y= "Frequency", title = "Histogram of CBCM")
ggplot(zinb_frame, aes(x=CBSTAC)) + geom_histogram(binwidth = 1, color = "black", fill = "white") + labs(x = "CBSTAC", y= "Frequency", title = "Histogram of CBCM")

ggplot(zinb_frame, aes(x=CBMAC)) +
  geom_density() +

#Plot Piechart
pie(table(Rdata1$CBMAC))

#Barplot
barplot(table(Rdata1$CBMAC), xlab = "No. Transactions", ylab = "Frequency")
barplot(table(Rdata1$CBMMC), xlab = "No. Transactions", ylab = "Frequency")
barplot(table(Rdata1$CBCAC), xlab = "No. Transactions", ylab = "Frequency")
barplot(table(Rdata1$CBCMC), xlab = "No. Transactions", ylab = "Frequency")

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
summary(m1 <- glm.nb(CBMAC ~ GDP+ Inflation + Interest + Exc + Unem, data = zinb_frame))

#Zero-NBIN Model
m2 <- zeroinfl(CBMCAC ~ GDP + Inflation + Interest + Exc + Unem,
               data = zinb_frame, dist = "negbin", EM = TRUE)
summary(m2)

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
