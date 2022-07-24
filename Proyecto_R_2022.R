#TODO PARA GIT
#install.packages("gitcreds")
library(gitcreds)
gitcreds_set()

#CONEXIONES A LA BASE DE DATOS
#install.packages("DBI")
#install.packages("RMySQL")

library(DBI)
library(RMySQL)

MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "u752080463_Gastos",
  host = "sql741.main-hosting.eu",
  username = "u752080463_D",
  password = "Laika888")


dbListTables(MyDataBase)
