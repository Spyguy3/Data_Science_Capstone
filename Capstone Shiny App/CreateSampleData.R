#######################################################################################
# This R script will create a sample data file from reading twitter, logs and news input
# files. It will sample these files and create final combined file and will save it 
# in Data_Sample.txt
#######################################################################################




Packages <- c("qdap", "tm" ,"wordcloud", "ggplot2", "ggthemes", "RWeka")
lapply(Packages, library, character.only = TRUE)
rm(Packages)
# Set The Seed
set.seed(1111)



# ###################################################################################
#Create Sample Files, We will use these sample files for our project instaed of all data
# fileSize("en_US.blogs.txt", units = "MB")
# con_tmp <- file("en_US.blogs.txt", "r")
# length(readLines(con_tmp))
# max(nchar(readLines(con_tmp)))
# 
# 
# 
# ##################################
#Twitter Sample file creation
con <- file("en_US.twitter.txt", "r")
data_All <- readLines(con, skipNul = TRUE)
data_sample <- sample(data_All, length(data_All) * 0.001)
fileConn<-file("Twitter_Sample.txt")
writeLines(data_sample, fileConn)
close(fileConn)
close(con)
rm(fileConn, con, data_sample,data_All )
#
# ################################
# #News Sample file creation
con <- file("en_US.news.txt", "r")
data_All <- readLines(con, skipNul = TRUE)
data_sample <- sample(data_All, length(data_All) * 0.001)
fileConn<-file("News_Sample.txt")
writeLines(data_sample, fileConn)
close(fileConn)
close(con)
rm(fileConn, con, data_sample,data_All )
#
# #################################
# #Blogs Sample file creation
con <- file("en_US.blogs.txt", "r")
data_All <- readLines(con, skipNul = TRUE)
data_sample <- sample(data_All, length(data_All) * 0.001)
fileConn<-file("Blogs_Sample.txt")
writeLines(data_sample, fileConn)
close(fileConn)
close(con)
rm(fileConn, con, data_sample,data_All )
# #
# # ###############################
# # #Create combined sample file
con_twitter <- file("Twitter_Sample.txt", "r")
con_news <- file("News_Sample.txt", "r")
con_blogs <- file("Blogs_Sample.txt", "r")
twitter_vector <- readLines(con_twitter)
news_vector <- readLines(con_news)
blogs_vector <- readLines(con_blogs)
data_sample <- c(twitter_vector, news_vector, blogs_vector)
fileConn<-file("Data_Sample.txt")
writeLines(data_sample, fileConn)
close(con_twitter)
close(con_news)
close(con_blogs)
rm(twitter_vector, news_vector, blogs_vector, data_sample)
rm(con_blogs, con_news, con_twitter, fileConn)
# 
# ###################################################################################
