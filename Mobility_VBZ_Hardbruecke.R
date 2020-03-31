# Mobility__VBZ_Hardbruecke.R
# Import libraries
require(tidyquant)
require(xts)
require(anytime)
library (readr)
library (lattice)
library(chron)
library(reshape)

################################
# Download data
urlfile="https://data.stadt-zuerich.ch/dataset/55c68924-bb53-40a4-8f62-69e063cb2afe/resource/0132f2f4-3d62-4765-bcd8-05994add7127/download/frequenzen_hardbruecke_2020.csv"
zhoev<-data.frame(read_csv(url(urlfile)))
################################
# 
zhoev$date<-date(as.POSIXct(zhoev$Timestamp))
# ohne aktuellen Tag
zhoev<-subset(zhoev, date!=Sys.Date())
#Aggregate der Zähllinien pro tag (date) In und Out Zusammengezählt
oevtot<-with(zhoev, tapply(In+Out, list(date, Name), sum))

hardoev<-data.frame(date=as.POSIXct(paste(rownames(oevtot), "00:00:00", sep=" ")),
                    value=round(apply(oevtot[,c("Ost-Nord total",
                                                "Ost-SBB total", 
                                                "Ost-Süd total",
                                                "West-Nord total", 
                                                "West-SBB total", 
                                                "Ost-Süd total")], 1, sum)/1000, 2),
                    topic="Mobilität",
                    variable_short="oev_freq_hardbruecke",
                    variable_long="ÖV-Besucherfrequenzen, Zählstelle Hardbrücke",
                    location="Stadt Zürich",
                    unit="Anzahl in 1000",
                    source="VBZ",
                    update="täglich",
                    public="ja",
                    description="https://github.com/statistikZH/covid19monitoring_mobility_SlowTraffic")

#write the final file for publication
write.table(hardoev, "Mobility_VBZHardbruecke.csv", sep=",", fileEncoding="UTF-8", row.names = F)



