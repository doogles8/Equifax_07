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
dbListFields(MyDataBase, 'COMPRAS_FAMILIARES')
DataDB <- dbGetQuery(MyDataBase, "select * from COMPRAS_FAMILIARES")
class(DataDB)

#PRIMERAS 6 FILAS
head(DataDB)

#MEDIANA DEL PRECIO
Media.precio <- mean(DataDB$PRECIO)  
Media.precio 

#install.packages("dplyr")

library(dplyr)
Precio.Walmart <-  DataDB %>% filter(LUGAR == "WALMART" ,  PRECIO >= 300.00)

Precio.Walmart
#CATEGORIAS UNICAS
unique(DataDB$CATEGORIA)
#PRIMEROS 5 REGISTROS

rs <- dbSendQuery(MyDataBase, "SELECT * FROM COMPRAS_FAMILIARES LIMIT 5;")
dbFetch(rs)
?dbFetch

#install.packages("ggplot2")
library(ggplot2)
names(DataDB)

#grafico de dispersion






