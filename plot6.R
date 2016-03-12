# plot6.R #

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

# Question 6 ######
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

NEI_summary <- NEI %>%
  filter(fips == '24510' | fips == '06037') %>%
  inner_join(SCC, by = 'SCC') %>%
  filter(grepl('vehicle|vessel|craft', SCC.Level.Two, ignore.case = TRUE)) %>%
  group_by(year, fips) %>%
  mutate(fips = factor(fips)) %>%
  summarise(Emissions = sum(Emissions))

ggplot(NEI_summary, aes(x = year, y = Emissions, colour = fips)) +
  geom_line() +
  ylab('PM 2.5 Emissions (tons)') +
  xlab('Year') +
  ggtitle('Vehicle Emissions Over Time in Baltimore and LA')
dev.copy(png, 'plot6.png')
dev.off()

# Vehicle emissions grew since 1999 in LA but declined in Baltimore. Whereas in LA they began with an increase in 2002 before declining again, in Baltimore they declined first and then increased again in 2008.