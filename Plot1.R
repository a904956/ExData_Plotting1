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

png("plot1.png")
hist(df1$Global_active_power, col = "red", main ="Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
     