# plot1.R #

# Universal Inputs #######
data_dir <- '~/Downloads/exdata_data_NEI_data/'

# Read data #####

NEI <- readRDS(file.path(data_dir, 'summarySCC_PM25.rds'))
SCC <- readRDS(file.path(data_dir, 'Source_Classification_Code.rds'))