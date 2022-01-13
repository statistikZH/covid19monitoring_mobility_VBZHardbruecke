# Mobility__VBZ_Hardbruecke.R
# Import libraries
require(xts)
require(anytime)
library (readr)
library (lattice)
library(chron)
library(reshape)
################################
# Download data
urlfile2020<-"https://data.stadt-zuerich.ch/dataset/55c68924-bb53-40a4-8f62-69e063cb2afe/resource/5baeaf58-9af2-4a39-a357-9063ca450893/download/frequenzen_hardbruecke_2020.csv"
urlfile2021<-"https://data.stadt-zuerich.ch/dataset/55c68924-bb53-40a4-8f62-69e063cb2afe/resource/2f27e464-4910-46bf-817b-a9bac19f86f3/download/frequenzen_hardbruecke_2021.csv"
urlfile2022<-"https://data.stadt-zuerich.ch/dataset/vbz_frequenzen_hardbruecke/download/frequenzen_hardbruecke_2022.csv"


zhoev2020<-data.frame(read.csv(url(urlfile2020), encoding = "UTF-8"))
zhoev2021<-data.frame(read.csv(url(urlfile2021), encoding = "UTF-8"))
zhoev2022<-data.frame(read.csv(url(urlfile2022), encoding = "UTF-8"))

zhoev<-rbind(zhoev2020, zhoev2021, zhoev2022)


################################
# 
zhoev$date<-as.Date((substring(zhoev$Timestamp, 1, 10)))
# ohne aktuellen Tag
zhoev<-subset(zhoev, date!=Sys.Date())
#Aggregate der Zähllinien pro tag (date) In und Out Zusammengezählt
oevtot<-with(zhoev, tapply(In+Out, list(date, Name), sum))

#Imputation der Missings im Ost-SBB-Total im August
oevtot2<-data.frame(oevtot)

model<-lm(Ost.SBB.total~oevtot2$Ost.VBZ.Total, data=oevtot2)

pred<-predict(model, oevtot2)
oevtot[as.character(seq(as.Date("2020-08-02"), as.Date("2020-08-13"), by=1)),2]<-round(pred[as.character(seq(as.Date("2020-08-02"), as.Date("2020-08-13"), by=1))])


hardoev<-data.frame(date=as.Date(rownames(oevtot)),
                    value=round(apply(oevtot[,c("Ost-Nord total",
                                                "Ost-SBB total", 
                                                "Ost-Süd total",
                                                "West-Nord total", 
                                                "West-SBB total")], 1, sum)/1000, 2),
                    topic="Mobilität",
                    variable_short="oev_freq_hardbruecke",
                    variable_long="ÖV-Besucherfrequenzen, Zählstelle Hardbrücke",
                    location="Stadt Zürich",
                    unit="Anzahl in 1000",
                    source="VBZ",
                    update="täglich",
                    public="ja",
                    description="https://github.com/statistikZH/covid19monitoring_mobility_VBZHardbruecke")

#write the final file for publication
write.table(hardoev, "Mobility_VBZHardbruecke.csv", sep=",", fileEncoding="UTF-8", row.names = F)

View(oevtot)

range(hardoev$date)
range(zhoev$date)
