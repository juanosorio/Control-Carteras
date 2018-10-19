source('C:/Users/Public/Documents/R/CONEXIONES/CONEXION LocalHost.r')

FEC_INI<- c('2014-01-01','2014-02-01','2014-03-01','2014-04-01','2014-05-01','2014-06-01','2014-07-01',
            '2014-08-01','2014-09-01','2014-10-01','2014-11-01','2014-12-01',
            '2015-01-01','2015-02-01','2015-03-01','2015-04-01','2015-05-01','2015-06-01','2015-07-01',
            '2015-08-01','2015-09-01','2015-10-01','2015-11-01','2015-12-01',
            '2016-01-01','2016-02-01','2016-03-01','2016-04-01','2016-05-01','2016-06-01','2016-07-01',
            '2016-08-01','2016-09-01','2016-10-01','2016-11-01','2016-12-01',
            '2017-01-01','2017-02-01','2017-03-01','2017-04-01','2017-05-01','2017-06-01','2017-07-01',
            '2017-08-01','2017-09-01','2017-10-01','2017-11-01','2017-12-01',
            '2018-01-01','2018-02-01','2018-03-01','2018-04-01','2018-05-01','2018-06-01','2018-07-01',
            '2018-08-01','2018-09-01','2018-10-01','2018-11-01','2018-12-01')

vigentes<-data.frame(linea_cred=NA,num_neg=NA,vas_prom=NA,prima_prom=NA,vas_total=NA, prima_total=NA,fecha=NA)

for(i in 1:(length(FEC_INI)-15)){
#  i<-45
jcop<-dbGetQuery(
  
  con,paste(
    "
      WITH A AS(
        SELECT NUMERO_POLIZA AS NP, TIPO_END AS T_E, NIT_ASEGURADO
        FROM endosos_desempleo
        WHERE TIPO_END='      AT ' AND (FEC_VIG_POL >= '",FEC_INI[i],"') AND (FEC_VIG_POL < '",FEC_INI[i+12],"') AND FECHA_EQUIPO >= '",FEC_INI[i],"' AND FECHA_EQUIPO < '",FEC_INI[i+12],"'
        --AND LINEA_CRED='CREDIEXPRESS'
      )
      ,
      a1 as (
        SELECT DISTINCT*
          FROM A 
      )
      ,
      a2 as (
        SELECT
        endosos_desempleo.*, 
        A1.T_E as cancel
        FROM endosos_desempleo LEFT JOIN A1 ON 
        endosos_desempleo.NUMERO_POLIZA=A1.NP AND
        endosos_desempleo.NIT_ASEGURADO=A1.NIT_ASEGURADO
        WHERE 
        /*LINEA_CRED='CREDIEXPRESS' AND*/ (FEC_VIG_POL >= '",FEC_INI[i],"') AND (FEC_VIG_POL < '",FEC_INI[i+12],"') AND FECHA_EQUIPO >= '",FEC_INI[i],"' AND FECHA_EQUIPO < '",FEC_INI[i+12],"'
        AND A1.T_E is null
      )
      ,
      
      A3 AS (
        SELECT LINEA_CRED, floor(numero_poliza/1),FEC_VIG_POL, count(*), sum(valor_asegurado) as vas, sum(prima_seguro) as prima
        FROM a2
        GROUP BY LINEA_CRED, floor(NUMERO_POLIZA/1), FEC_VIG_POL--, FEC_VENC_PO
        order by LINEA_CRED, floor(NUMERO_POLIZA/1), FEC_VIG_POL--, FEC_VENC_PO
      )
      
      SELECT LINEA_CRED, COUNT(*) AS NUM_NEG, AVG(VAS) AS VAS_PROM, AVG(PRIMA)AS PRIMA_PROM,SUM(VAS) AS VAS_TOTAL,SUM(PRIMA) AS PRIMA_TOTAL
      FROM A3
      WHERE --CANCEL IS NULL AND
      (FEC_VIG_POL >= '",FEC_INI[i],"') AND (FEC_VIG_POL < '",FEC_INI[i+12],"') 
      AND VAS>0
      GROUP BY LINEA_CRED;
    "
  ,sep = ""))
jcop$fecha<-FEC_INI[i+12]
vigentes<-rbind(vigentes,jcop)
}

write.csv(vigentes,paste('C:/Users/Public/Documents/DESEMPLEO/SEGUIMIENTO/VALIDACION/vigentes',FEC_INI[i+12],'.csv'))
          
