#Menggunakan dataset Titanic dan melihat strukturnya
Titanic
str(Titanic)

#MMengubah data titanic menjadi data frame
dfTitanic<-as.data.frame(Titanic)
head(dfTitanic)
View(dfTitanic)

#mengubah data titanic menjadi data mentah perorang
titanic.raw<-NULL
#cbind untuk memetakan atribut terhadap row pada data mentah titanic
for(i in 1:4) {titanic.raw <- cbind(titanic.raw, rep(as.character(dfTitanic[,i]), dfTitanic$Freq))}
titanic.raw <- as.data.frame(titanic.raw)
names(titanic.raw) <- names(dfTitanic)[1:4]
dim(titanic.raw)

#data understanding titanic.raw
titanic.raw
View(titanic.raw)
summary(titanic.raw)

#Menjalankan association rules
library("arules")
rules.all<-apriori(titanic.raw)
quality(rules.all) <- round(quality(rules.all), digits=3)
rules.all

#memeriksa rules yang terbentuk
inspect(rules.all)
quality(rules.all)<-round(quality(rules.all),digits=2)

#membentuk rule berdasarkan yang consequencesnya berdasarkan survived
rulesSurvived <- apriori(titanic.raw, control = list(verbose=F),
                 parameter = list(minlen=2, supp=0.005, conf=0.8),
                 appearance = list(rhs=c("Survived=No", "Survived=Yes"),
                default="lhs"))
quality(rulesSurvived) <- round(quality(rulesSurvived), digits=3)
inspect(rulesSurvived)

#mengurutkan rule berdasarkan confidence
rulesSurvivedSort<-sort(rulesSurvived,by="confidence")
inspect(rulesSurvived)

#visualizasi rules
library(arulesViz)
plot(rulesSurvived)
plot(rules.all, method="graph")
