library(tidyverse)
library(tidytext)
library(tidyr)
library(stringi)
library(tm)
library(SnowballC)
library(wordcloud)
library(caret)
true_news <- read_csv("~/R/datasets/Fake and True News/True.csv") %>% 
  mutate(type = factor("fake"))
fake_news <- read_csv("~/R/datasets/Fake and True News/Fake.csv") %>% 
  mutate(type = factor("true"))
news <- sample_n(left_join(fake_news,true_news), 44898) %>% 
  select(-title, -subject, -date)
news
table(news$type)
news_corpus <- VCorpus(VectorSource(news$text))
as.character(news_corpus[[10]])
replacepunt <- function(p){
  gsub("([[:punct:]]+)", " ", p)
}
news_corpus_clean <- DocumentTermMatrix(news_corpus, 
                                        control = list(
                                          tolower = TRUE,
                                          removeNumbers = TRUE,
                                          stopwords = TRUE,
                                          replacepunt = TRUE,
                                          stemming = TRUE
                                        ))
news_corpus_clean


# ***************      Build Train and test set 80-20%   ******************


train_set <- news_corpus_clean[1:35911, ]
train_label <- news[1:35911, ]$type
test_set <- news_corpus_clean[35912:44898, ]
test_label <- news[35912:44898, ]$type

prop.table(table(train_label))
