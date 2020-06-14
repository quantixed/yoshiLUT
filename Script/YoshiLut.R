# Working with a look-up table derived from RGB pixels
# In data we have 3 csv files with pixel number and values for R, G, or B
rVal <- read.csv(file = "Data/RValues.csv", header = T)
gVal <- read.csv(file = "Data/GValues.csv", header = T)
bVal <- read.csv(file = "Data/BValues.csv", header = T)
df <- merge(rVal, gVal, by = "X")
df <- merge(df, bVal, by = "X")
names(df) <- c("X","R","G","B")
df$hex <- rgb(df$R, df$G, df$B, maxColorValue=255)
hexVal <- unique(df$hex)

# use the color palette
barplot(1:16, col = hexVal)

# delete the first value and reverse
yoshi <- rev(hexVal[2:16])
# use the discrete palette
image(volcano, col = yoshi)
# use an interpolated palette
filled.contour(volcano, color.palette = colorRampPalette(yoshi))

# make a look-up table for use in ImageJ
rgb.palette <- colorRampPalette(yoshi,space = "rgb")
hexpal <- rgb.palette(256)
rgbpal <- t(col2rgb(hexpal))
yoshiLUT <- data.frame(cbind(0:255,rgbpal))
names(yoshiLUT) <- c("Index","Red","Green","Blue")
write.table(yoshiLUT, file = "Output/Data/yoshiLUT.lut", sep = "\t", row.names = F)

