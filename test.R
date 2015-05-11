rm(list=ls()) #clear workspace

#load libraries
library(raster)
library(ggplot2)

#open ASCII file using ‘raster’ command, which converts the ASCII to a raster object
Zea_Range = extent(-119.0072,-62.50219,-35.97103,32.2035)

# Get the precipitation stuff first - all 12 months and take the mean

prec12 = getData('worldclim', var = 'prec', res = 2.5)

# Crop
prec12.zea = crop(prec12, Zea_Range)
# Give new object name
predictors = prec12.zea
yy <- mean(predictors)

# Make it a data.frame for ggplot2
yy <- as.data.frame(yy, xy=TRUE)

# Make appropriate column headings
colnames(yy) <- c('Longitude', 'Latitude', 'MAP')

# Establish greater than or less than values of the MAP attribute you are interested in
yy$MAP[yy$MAP >= 250] <- 250

# Now make the map, can add in a sites file and a geom_point object below to plot more stuff
ggplot(data=yy, aes(y=Latitude, x=Longitude)) +
  geom_raster(interpolate=TRUE,aes(fill=MAP)) +
  theme_bw() + scale_fill_gradient('Mean Precipitation (mm/yr)', low="yellow", high="blue", space="Lab") +
  theme(axis.title.x = element_text(size=16),
        axis.title.y = element_text(size=16, angle=90),
        axis.text.x = element_text(size=14),
        axis.text.y = element_text(size=14),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = 'right',
        legend.key = element_blank()
  )


# Mean min temperature from 1950s-2000
tempmin <- getData('worldclim', var='tmin', res = 2.5)

temp.min <- crop(tempmin, Zea_Range)

temp.min <- mean(temp.min)

temp.min <- as.data.frame(temp.min, xy=TRUE)

colnames(temp.min) <- c('Longitude', 'Latitude', 'MAP')

temp.min$MAP[temp.min$MAP >= 200] <- 200
temp.min$MAP <- temp.min$MAP/10

# Now make the map, can add in a sites file and a geom_point object below to plot more stuff
# Use summary of data.frame to best determine the limits argument to the color palette below
# Note you can interpolate =TRUE, but the default is FALSE

ggplot(data=temp.min, aes(y=Latitude, x=Longitude)) +
  geom_raster(aes(fill=MAP)) +
  theme_bw() + scale_fill_gradient('Mean Min. temp (deg C)', low="blue", high="orange", space="Lab") +
  theme(axis.title.x = element_text(size=16),
        axis.title.y = element_text(size=16, angle=90),
        axis.text.x = element_text(size=14),
        axis.text.y = element_text(size=14),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = 'right',
        legend.key = element_blank()
  )


# Now max temp
tempmax <- getData('worldclim', var='tmax', res = 2.5)

temp.max <- crop(tempmax, Zea_Range)

temp.max <- mean(temp.max)

temp.max <- as.data.frame(temp.max, xy=TRUE)

colnames(temp.max) <- c('Longitude', 'Latitude', 'MAP')
temp.max$MAP[temp.max$MAP >= 200] <- 200
temp.max$MAP <- temp.max$MAP/10
# Now make the map, can add in a sites file and a geom_point object below to plot more stuff
# Use summary of data.frame to best determine the limits argument to the color palette below
# Note you can interpolate =TRUE, but the default is FALSE
ggplot(data=temp.max, aes(y=Latitude, x=Longitude)) +
  geom_raster(aes(fill=MAP)) +
  theme_bw() + scale_fill_gradient('Mean Max. temp (deg C)', low="blue", high="orange", space="Lab") +
  theme(axis.title.x = element_text(size=16),
        axis.title.y = element_text(size=16, angle=90),
        axis.text.x = element_text(size=14),
        axis.text.y = element_text(size=14),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = 'right',
        legend.key = element_blank()
  )

# Adding in altitude - note, you may want to add more countries here to stitch together 
# getData('iso3') to get the three letter codes
# Because this raster is from a DEM - you're probably going to want to run it on FARM or another cluster
# I think it is 50 million or so rows once you make the data.frame, i.e. large for local.

elev1 = getData('alt', country = 'BRA', mask = FALSE)
elev2 = getData('alt', country = 'PER', mask = FALSE)
elev3 = getData('alt', country = 'MEX', mask = FALSE)
elev4 = getData('alt', country = 'COL', mask = FALSE)
elev5 = getData('alt', country = 'HND', mask = FALSE)
elev6 = getData('alt', country = 'PAN', mask = FALSE)
elev7 = getData('alt', country = 'VEN', mask = FALSE)
elev8 = getData('alt', country = 'CRI', mask = FALSE)
elev9 = getData('alt', country = 'SLV', mask = FALSE)
elev10 = getData('alt', country = 'GTM', mask = FALSE)
elev11 = getData('alt', country = 'NIC', mask = FALSE)
elev12 = getData('alt', country = 'USA', mask = FALSE)

elev = merge(elev1,elev2, elev3, elev4, elev5, elev6, elev7, elev8,
             elev9, elev10, elev11, elev12)
elev <- crop(elev, Zea_Range)

elev <- as.data.frame(elev, xy=TRUE)

colnames(elev) <- c('Longitude', 'Latitude', 'MAP')


ggplot(data=elev, aes(y=Latitude, x=Longitude)) +
  geom_raster(aes(fill=MAP)) +
  theme_bw() + scale_fill_gradient('Elevation (m)', low="blue", high="orange", space="Lab") +
  theme(axis.title.x = element_text(size=16),
        axis.title.y = element_text(size=16, angle=90),
        axis.text.x = element_text(size=14),
        axis.text.y = element_text(size=14),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = 'right',
        legend.key = element_blank()
  )

