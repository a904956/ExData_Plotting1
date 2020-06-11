url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename = "dataset.zip"
download.file(url,filename,method="curl")
unzip(filename)
df = read.table("household_power_consumption.txt", sep=";", header = TRUE)

df$DateTime = paste(df$Date,df$Time)
df$DateTime = strptime(df$DateTime, "%d/%m/%Y %H:%M:%S")
head(df$DateTime)

df$Date = strptime(df$Date,"%d/%m/%Y")
df$Date = as.Date(df$Date)

df1 = subset(df,df$Date == "2007-02-01" | df$Date == "2007-02-02")

head(df1)
tail(df1)
rm(df)

df1$Global_active_power = as.numeric(df1$Global_active_power)


png("plot4.png")
par(mfrow=c(2,2))
with(df1,plot(DateTime,Global_active_power, type = "line", xlab = "" , ylab = "Global Active Power (kilowatts)"))
with(df1,plot(DateTime,Voltage,type='line',xlab='datetime'))
with(df1,plot(DateTime,Sub_metering_1, type="line", xlab = "", ylab = "Energy sub metering"))
with(df1,lines(DateTime,Sub_metering_2, type="line", col = "red"))
with(df1,lines(DateTime,Sub_metering_3, type="line", col = "blue"))
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red", "blue"), lty = 1:2, cex=0.5)
with(df1,plot(DateTime,Global_reactive_power, type="line",xlab = "datetime"))
dev.off()
