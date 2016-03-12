# plot1.R #

library(dplyr)
# Universal Inputs #######
data_dir <- '~/Downloads/exdata_data_NEI_data/'

# Read data #####
if (!(exists('NEI'))) {
  NEI <- readRDS(file.path(data_dir, 'summarySCC_PM25.rds'))
}
if (!(exists('SCC'))) {
  SCC <- readRDS(file.path(data_dir, 'Source_Classification_Code.rds'))
}

# Question 1 ######
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

NEI_summary <- NEI %>%
  group_by(year) %>%
  summarise(Emissions = sum(Emissions))

plot(Emissions ~ year, data = NEI_summary, type = 'l', ylab = 'Total Emissions (tons)', xlab = 'Year', main = 'Total Emissions Over Time')
dev.copy(png,'plot1.png')
dev.off()
# it looks like emissions have declined from 7.3 Million tons in 1999 to 3.5 Million tons in 2008