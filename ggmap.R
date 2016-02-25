require("ggmap")
require(data.table)


data <- fread("input/Gowalla_totalCheckins.txt")
new.names <- c("user","check-in time", "latitude", "longitude",	"location id")
names(data) <- new.names

str(data)

df <- data[, .(x=as.numeric(longitude), y= as.numeric(latitude))]

map <- get_map("Bilbao", zoom=14, maptype="toner",source="stamen")

g <- ggmap(map)
g <- g+stat_density2d(aes(x = x, y = y, fill=..level..), data=df,geom="polygon", alpha=0.2)
g + scale_fill_gradient(low = "yellow", high = "red")

dev.copy(g,'Gowalla_Bilbao.png')
dev.off()