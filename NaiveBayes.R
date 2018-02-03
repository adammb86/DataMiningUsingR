library("e1071")
data<-read.csv(file.choose(),header = TRUE)
data<-as.data.frame(data)
nama<-nama<-c("TingkatPerekonomian","JenisKelamin","Pekerjaan","PunyaDeposito")
names(data)<-nama

#atau bisa juga dengan operasi
names(data)<- c("TingkatPerekonomian","JenisKelamin","Pekerjaan","PunyaDeposito")

View(data)

model<-naiveBayes(PunyaDeposito ~ ., data= data)
model

datauji<-read.csv(file.choose(),header = TRUE)
predict(model,as.data.frame(datauji))
