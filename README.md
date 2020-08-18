# covid19monitoring_mobility_VBZHardbruecke

## Grundlage
Dieses Skript bringt die Daten der [VBZ-Zählstelle Hardbrücke](https://data.stadt-zuerich.ch/dataset/vbz_frequenzen_hardbruecke)) in das für die Integration in den [harmonisierten Datensatz "Gesellschaftsmonitoring COVID19"](https://raw.githubusercontent.com/statistikZH/covid19monitoring/master/covid19socialmonitoring.csv) benötigte Format. 

## Methodisches
Die Frequenzen (beide Richtungen IN und OUT) der Zähllinien "Ost-Nord total","Ost-SBB total", "Ost-Süd total", "West-Nord total", "West-SBB total",  "Ost-Süd total" werden zu einem Tagestotal aggregiert. Der aktuelle Tag wird, da noch unvollständig, weggelassen. Daten für die Zählstelle "Ost_SBB total", die vom   2.8.2020 bis am 13.8.2020 ausfiel, wurden aus den Angaben der übrigen Zählstellen imputiert. 

## Weitere Informationen
[Projektseite: "Gesellschafsmonitoring COVID19"](https://github.com/statistikZH/covid19monitoring) <br>
[Datenbezug](https://www.web.statistik.zh.ch/covid19_indikatoren_uebersicht/#/) <br>
[Visualisierung](https://www.web.statistik.zh.ch/cms_vis/covid19_indikatoren/) <br>






