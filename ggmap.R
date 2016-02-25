require("ggmap")
require(data.table)

png("Gowalla_Bilbao.png",height=1280,width=1080)
data <- fread("input/Gowalla_totalCheckins.txt")
new.names <- c("user","check-in time", "latitude", "longitude",	"location id")
names(data) <- new.names

str(data)

df <- data[, .(x=longitude, y=latitude)]

map <- get_map("Bilbao", zoom=14, maptype="toner",source="stamen")

g <- ggmap(map)
g <- g+stat_density2d(aes(x = x, y = y, fill=..level..), data=df,geom="polygon", alpha=0.2)
g + scale_fill_gradient(low = "yellow", high = "red")

dev.off()