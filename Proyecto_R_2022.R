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
Precio.Walmart <-  DataDB %>% filter(LUGAR == "WALMART" ,  PRECIO >= 700.00)
setwd("/cloud/project")
write.csv(Precio.Walmart,"/cloud/project/WALMART_PRECIO.csv", row.names = T)

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

ggplot(DataDB,aes(x=DESCUENTO,y=PRECIO, colour=LUGAR)) + geom_point()

ggplot(DataDB,aes(x=DESCUENTO,y=PRECIO, colour=LUGAR)) + 
  geom_point() +
  theme_dark() +
  facet_wrap("GENERO")

hist(DataDB$PRECIO,breaks =seq(0,600,100), 
     main="Histogramas de gastos familiares",
     xlab="PRECIO",
     ylab="Frecuencias")

#Eliminando filas o valores perdido
DataDB <- na.omit(DataDB)

#Con GGPLOT

DataDB %>%
  ggplot()+aes(PRECIO)+ 
  geom_histogram(binwidth = 100)

DataDB %>%
  ggplot()+
  aes(PRECIO)+ 
  geom_histogram(binwidth = 100, col="black", fill ="green")+
  ggtitle("Histogramas de gastos familiares") +
  xlab("PRECIO") +
  ylab("Frecuencias") +
  theme_light()

#Graficos de Dispersion guardando
(Guardando_respuesta <- ggplot(DataDB,aes(x=DESCUENTO,y=PRECIO)) + 
  geom_point())
#Linea de tendencia
(Guardando_respuesta <- ggplot(DataDB,aes(x=DESCUENTO,y=PRECIO, col=LUGAR)) + 
    geom_point())

(Guardando_respuesta <- ggplot(DataDB,aes(x=DESCUENTO,y=PRECIO, col=LUGAR)) + 
    geom_point()+
     geom_smooth(method = "lm", se=T))

Guardando_respuesta + labs(x='DESCUENTO(1%-100%)',
y='Precio en Dolares',
colour='Almacenes de compra')


Guardando_respuesta + facet_wrap("LUGAR")
 
Guardando_respuesta + facet_grid(GENERO ~ LUGAR)

#Falta agregar a la base de datos




