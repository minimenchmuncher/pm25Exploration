# plot3.R #

library(dplyr)
library(ggplot2)
# Universal Inputs #######
data_dir <- '~/Downloads/exdata_data_NEI_data/'

# Read data #####
if (!(exists('NEI'))) {
  NEI <- readRDS(file.path(data_dir, 'summarySCC_PM25.rds'))
}
if (!(exists('SCC'))) {
  SCC <- readRDS(file.path(data_dir, 'Source_Classification_Code.rds'))
}

# Question 3 ######
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

NEI_summary <- NEI %>%
  filter(fips == 24510) %>%
  group_by(year, type) %>%
  summarise(Emissions = sum(Emissions)) %>%
  mutate(type = factor(type))

ggplot(NEI_summary, aes(x = year, y = Emissions, colour = type)) + geom_line() +
  ylab('PM 2.5 Emissions (tons)') +
  xlab('Year') +
  ggtitle('Baltimore Emissions Over Time, by Type')
dev.copy(png, 'plot3.png')
dev.off()

# It looks like Nonpoint, On-Road and Non-Road emissions have all declined, but Point emissions have increased slightly since 1999.