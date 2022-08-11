library(dplyr)
library(DBI)
library(RMySQL)
library(ggplot2)

MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

dbListTables(MyDataBase)

dbListFields(MyDataBase, 'CountryLanguage')
DataDB <- dbGetQuery(MyDataBase, "select * from CountryLanguage where Language = 'Spanish'")
head(DataDB)

ggplot(DataDB, aes(x=Percentage, y = CountryCode, colour = IsOfficial )) + 
  geom_point() +   
  xlab('Porcentaje') +
  ylab('País')

ggplot(data=DataDB, aes(x=IsOfficial, y=Percentage, fill=CountryCode)) + 
  geom_bar(stat="identity", position="dodge")
