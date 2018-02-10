datanilai<-read.csv(file.choose(),header = TRUE)
datanilai<-as.data.frame(datanilai)
(datanilaiready<-data.frame(datanilai$Matematika,datanilai$IPA,datanilai$IPS))
summary(datanilaiready)

#Percobaan seluruh algoritma di K-Means
(hasilkmeans<-kmeans(datanilaiready,2,algorithm = "Hartigan-Wong"))
(hasilkmeans<-kmeans(datanilaiready,2,algorithm = "Lloyd"))
(hasilkmeans<-kmeans(datanilaiready,2,algorithm = "Forgy"))
(hasilkmeans<-kmeans(datanilaiready,2,algorithm = "MacQueen"))

#melihat hasil pemetaan data nilai siswa per cluster
table(datanilai$Siswa, hasilkmeans$cluster)
