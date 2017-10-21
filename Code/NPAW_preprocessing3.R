library(readr) # load a subset of "U.S._Chronic_Disease_Indicators__CDI" data
dat <- read_csv("C:/Users/moloneb/Google Drive/TableauProject/U.S._Chronic_Disease_Indicators__CDI_NPAW.csv")

dat$idQuestion <- paste(dat$QuestionID, dat$Question)

library(dplyr) # filter out data with NA values and Age Adjusted Prevalence (use Crude Prevalence only)
dat1 <- filter(dat, !is.na(DataValue)  & DataValueTypeID != "AgeAdjPrev")

library(reshape2) # prepare data for widening (spreading)
dat_melt <- melt(dat1, id = c("YearEnd", "LocationDesc","GeoLocation", "StratificationCategory1","Stratification1","idQuestion"), measure.vars = "DataValue")

library(tidyr) # each question has it's own column
dat_spread2 <- spread(subset(dat_melt,!is.na(GeoLocation)), idQuestion, value)
write.csv(dat_spread2, "C:/Users/moloneb/Google Drive/TableauProject/dat_spread2.csv", row.names = FALSE)
