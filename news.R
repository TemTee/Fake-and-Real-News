library(tidyverse)
library(tidytext)
library(tidyr)
library(stringi)
library(tm)
library(SnowballC)
true_news <- read_csv("~/R/datasets/Fake and True News/True.csv") %>% 
  mutate(type = factor("fake"))
fake_news <- read_csv("~/R/datasets/Fake and True News/Fake.csv") %>% 
  mutate(type = factor("true"))
news <- sample_n(full_join(fake_news,true_news), 44898) %>% 
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
                                          r
                                        ))