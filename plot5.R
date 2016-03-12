# plot5.R #

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

# Question 5 ######
#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

NEI_summary <- NEI %>%
  filter(fips == "24510") %>%
  inner_join(SCC, by = 'SCC') %>%
  filter(grepl('vehicle|vessel|craft', SCC.Level.Two, ignore.case = TRUE)) %>%
  group_by(year, SCC.Level.Two) %>%
  summarise(Emissions = sum(Emissions)) %>%
  rename('Source' = SCC.Level.Two)

ggplot(NEI_summary, aes(x = year, y = Emissions, colour = Source)) + geom_line() +
  ylab('PM 2.5 Emissions (tons)') +
  xlab('Year') +
  ggtitle('Vehicle Emissions Over Time')
dev.copy(png, 'plot5.png')
dev.off()

# it looks like overall pm2.5 emissions have declined since 1999, but hit a low point sometime before 2008, and then increased again. This was mostly driven by commercial Marine Vessels