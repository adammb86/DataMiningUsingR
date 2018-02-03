iris
View(iris)
install.packages("ggvis")
install.packages("class")
library("ggvis")
library("class")

#melihat korelasi antar atribut
iris %>% ggvis(~Sepal.Length, ~Sepal.Width, fill = ~Species) %>% layer_points()
iris %>% ggvis(~Petal.Length, ~Petal.Width, fill = ~Species) %>% layer_points()

#Korelasi antara Petal.Length and Petal.Width
cor(iris$Petal.Length, iris$Petal.Width)

#level dari data iris pada species 
x=levels(iris$Species)
x

#Matriks korelasi untuk setosa
print(x[1])
cor(iris[iris$Species==x[1],1:4])

#Matriks korelasi untuk versicolor
print(x[2])
cor(iris[iris$Species==x[2],1:4])

#Matriks korelasi untuk virginica
print(x[3])
cor(iris[iris$Species==x[3],1:4])

#Melihat jumlah data per kelas
table(iris$Species) 

#Melihat persentase data per kelas
round(prop.table(table(iris$Species)) * 100, digits = 1)

#Summary data
summary(iris) 

#Memilih summary
summary(iris[c("Petal.Width", "Sepal.Width")])

########Normalisasi hanya diperlukan kalau lebar data tidak seimbang antar atribut
#membuat fungsi normalisasi sendiri
normalize <- function(x) {
  num <- x - min(x)
  denom <- max(x) - min(x)
  return (num/denom)
}

#Menormalisasi data iris
iris_norm <- as.data.frame(lapply(iris[1:4], normalize))
iris_norm
summary(iris_norm)

#Langkah berikutnya membagi data menjadi training dan test data
set.seed(1234) #fungsi random di R
ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.67, 0.33))

#Membuat training data
iris.training <- iris[ind==1, 1:4]
head(iris.training)

#Membuat test data
iris.test <- iris[ind==2, 1:4]
head(iris.test)

#Ingat kita tadi hanya mengolah 4 atribut sementara atribut kelas ada di atribut ke 5
#Jadi kita labelkan dulu
iris.trainLabels <- iris[ind==1,5]
print(iris.trainLabels)

# Compose `iris` test labels
iris.testLabels <- iris[ind==2, 5]
print(iris.testLabels)

####Barulah kita membentuk model dan memprediksi
iris_prediksi<-c(1.1,2.4,1.2,3.4)
names(iris_prediksi)<-c("Sepal.Length","Sepal.Width","Petal.Length","Petal.Width")
iris_prediksi<-as.data.frame(iris_prediksi)
iris_prediksi<-t(iris_prediksi)
iris_pred <- knn(train = iris.training, test = iris.pred, cl = iris.trainLabels, k=3)
iris_pred
iris_pred <- knn(train = iris.training, test = iris_prediksi, cl = iris.trainLabels, k=3)
iris_pred

####Evaluasi Model
irisTestLabels <- data.frame(iris.testLabels)

#Menggabungkan data hasil prediksi dan data fakta
merge <- data.frame(iris_pred, iris.testLabels)
names(merge) <- c("Predicted Species", "Observed Species")
merge
