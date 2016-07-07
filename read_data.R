library("jsonlite")
library("R2HTML")

path <- paste(Sys.getenv("BASE"),"/daily_16.json",sep="")

json <- stream_in(file(path))
outputdir=getwd()
HTMLoutput=file.path(outputdir,"test.html")
for (i in 1:10){
val <- json[i,3][[1]]$dt
dates <- as.Date(as.POSIXct(val, origin="1970-01-01"))
tempavg <- json[i,3][[1]]$temp$day

temp_max <- max(tempavg)
temp_min <- min(tempavg)
city=json[i,1]$name
outputfile=paste(city,".png",sep="")
png(filename=file.path(outputdir,outputfile), height=300, width=600, bg="white", type=c("cairo"))

plot(tempavg,type="o",col="red",ylim=c(temp_min,temp_max),axes=FALSE,ann=FALSE)

axis(1,at=1:length(dates),lab=c(dates))

axis(2,las=1)

box()

title(main=city, col.main="red", font.main=4)

title(xlab="Day", col.lab=rgb(0,0.5,0))
title(ylab="Average Temperature",col.lab=rgb(0,0.5,0))

dev.off()
HTMLInsertGraph(outputfile,file=HTMLoutput)
}
