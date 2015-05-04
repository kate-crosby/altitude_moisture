# This is a short script to load a raster layer of altitude & AET/PET annual raster data sets

require(maptools)
require(maps)
require(mapdata)
require(dismo)
require(raster)
require(graphics)


occ <- read.csv(file="zea_sa.csv", header=T)

occ <- data.frame(occ$longdec, occ$latdec)

# Specify the lat long ranges to crop 
# I chose a fairly general extent of where Zea occurs (I included the lowlands)
# This is based off records in GRIN


Zea_Range = extent(-122.5167, -70, -17.47, 35)

# Get the precipitation stuff first

prec12 = getData('worldclim', var = 'prec', res = 2.5)

# Crop
prec12.zea = crop(prec12, Zea_Range)

# Give new object name
predictors = prec12.zea

# Get the mean as opposed to by month, but if you're interested, we can par that down
y <- mean(predictors)

plot(y, col = terrain.colors(24), 
     main = "Mean annual precipitation and Zea occurrences", 
     xlab = "Longitude", ylab = "Latitude")
points(occ$occ.longdec, occ$occ.latdec, col="blue", pch=20, cex=0.5)

# Import altitude

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

elev = merge(elev1,elev2, elev3, elev4, elev5, elev6, elev7, elev8,
             elev9, elev10, elev11)
plot(elev, col=terrain.colors(24), main = "Altitude", 
     xlab = "Longitude", ylab = "Latitude")
points(occ$occ.longdec, occ$occ.latdec, col="blue", pch=20, cex=0.5)

# Temperature - min - because trichomes like cold , I still think waterloss
tempmin <- getData('worldclim', var='tmin', res = 2.5)

temp.min <- crop(tempmin, Zea_Range)

temp.min <- mean(temp.min)


plot(temp.max, col=terrain.colors(24), main = "Mean annual Maximum Temperature", 
     xlab = "Longitude", ylab = "Latitude")

# Temp. Max
tempmax <- getData('worldclim', var='tmax', res = 2.5)

temp.max <- crop(tempmax, Zea_Range)

temp.max <- mean(temp.max)

plot(temp.max, col=terrain.colors(24), main = "Mean annual Maximum Temperature", 
     xlab = "Longitude", ylab = "Latitude")

# Panel plot - if you want to add occurrences - see above
par(mfrow=c(2,2))
plot(temp.max, col=terrain.colors(12), main = "Mean annual Maximum Temperature", 
     xlab = "Longitude", ylab = "Latitude")
plot(temp.min, col=terrain.colors(12), main = "Mean annual Minimum Temperature", 
     xlab = "Longitude", ylab = "Latitude")
plot(elev, col=terrain.colors(12), main = "Altitude", 
     xlab = "Longitude", ylab = "Latitude")
plot(y, col = terrain.colors(12), 
     main = "Mean annual precipitation", 
     xlab = "Longitude", ylab = "Latitude")