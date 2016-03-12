# plot2.R #

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

# Question 2 ######
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

NEI_summary <- NEI %>%
  filter(fips == 24510) %>%
  group_by(year) %>%
  summarise(Emissions = sum(Emissions))

plot(Emissions ~ year, data = NEI_summary, type = 'l', ylab = 'PM 2.5 Emissions (tons)', xlab = 'Year', main = 'Baltimore Emissions Over Time')
dev.copy(png,'plot2.png')
dev.off()
# it looks like emissions have declined from about 3,300 tons in 1999 to 1,900 tons in 2008.