source('C:/Users/Public/Documents/R/CONEXIONES/CONEXION LocalHost.r')
source('C:/Users/Public/Documents/R/CONEXIONES/CONEXION ORACLE.R')


##################################
######### PARAMETROS##############
                                 #
# SINIESTROS                     #
siniestros.mes<-'201809'         #
ano<-2018                        #
mes<-09                          #
##################################
#                                #
# CARTERAS                       #
fecha_ant<-'31-08-2018'          #
fecha<-'30-09-2018'              #
fec_cartera<-201809              #
vi<-'RMA092018'                  #
vgr<-'GEREN30092018'             #
pr<-'PR20181002 - Interfaz'      #
tc<-'TC20181002 - Interfaz'      #
##################################



source('C:/Users/Public/Documents/R/lector de siniestros oracle.r')
source('C:/Users/Public/Documents/R/Siniestros ORACLE.R')
source('C:/Users/Public/Documents/R/CARGA VI.R')
source('C:/Users/Public/Documents/R/CARGA VGR.R')
source('C:/Users/Public/Documents/R/CARGA DEUDORES.R')
