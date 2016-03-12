# plot4.R #

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

# Question 4 ######
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

NEI_summary <- NEI %>%
  inner_join(SCC, by = 'SCC') %>%
  filter(grepl('coal', SCC.Level.Three, ignore.case = TRUE)) %>%
  group_by(year) %>%
  summarise(Emissions = sum(Emissions))

ggplot(NEI_summary, aes(x = year, y = Emissions)) + geom_line() +
  ylab('PM 2.5 Emissions (tons)') +
  xlab('Year') +
  ggtitle('Total Coal-Related Emissions Over Time')
dev.copy(png, 'plot4.png')
dev.off()

# Coal-related emissions have gone down, especially after 2005
