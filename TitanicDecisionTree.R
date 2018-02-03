install.packages("readr")
install.packages("dplyr")
install.packages("party")
install.packages("rpart")
install.packages("rpart.plot")
install.packages("ROCR")

library(readr)
library(dplyr)
library(party)
library(rpart)
library(rpart.plot)
library(ROCR)
set.seed(100)

#baca data online
titanic3 <- "https://goo.gl/At238b" %>% 
     read_csv %>% 
     select(survived, embarked, sex, sibsp, parch, fare) %>% 
     mutate(embarked = factor(embarked),sex = factor(sex))
View(titanic3)

#split data ke training dan test data
.data <- c("training", "test") %>%
  sample(nrow(titanic3), replace = T) %>%
  split(titanic3, .)

#conditional partitioning 
tree_fit <- ctree(survived ~ ., data = .data$training)
plot(tree_fit)

#Binary decision tree recursive partitioning
rtree_fit <- rpart(survived ~ ., .data$training) 
rpart.plot(rtree_fit)