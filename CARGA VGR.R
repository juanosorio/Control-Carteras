# CARGA, TRANFORMACION Y UNION  VIDA GRUPO

dbGetQuery(con,paste(
  "           
 drop table if exists vgrb, VGR",fec_cartera,";
  CREATE TABLE VGRB(
  UC CHARACTER(622));
  
  COPY VGRB
  from 'C:/Users/Public/Documents/VGR/Cartera Vida Grupo/",vgr,".dat' 
  (format text);
  
  
  SELECT
  cast(substring(uc from 	1	for	4	) as 	TEXT	) AS 	 LOCALIDAD	,
  cast(substring(uc from 	5	for	3	) as 	TEXT	) AS 	 PRODUCTO	,
  cast(substring(uc from 	8	for	13	) as 	TEXT	) AS 	 POLIZA	,
  cast(substring(uc from 	21	for	13	) as 	TEXT	) AS 	 POLIZA_PP	,
  cast(substring(uc from 	34	for	5	) as 	TEXT	) AS 	 CODPROD	,
  cast(substring(uc from 	39	for	2	) as 	TEXT	) AS 	 CANAL	,
  cast(substring(uc from 	41	for	6	) as 	TEXT	) AS 	 COD_ENTID	,
  cast(substring(uc from 	47	for	16	) as 	TEXT	) AS 	 CUENTA	,
  cast(substring(uc from 	63	for	7	) as 	TEXT	) AS 	 RIESGO	,
  cast(substring(uc from 	70	for	1	) as 	INT	) AS 	 PARENT	,
  cast(substring(uc from 	71	for	16	) as 	TEXT	) AS 	 CEDULA	,
  cast(substring(uc from 	87	for	30	) as 	TEXT	) AS 	 NOMBRE	,
  cast(substring(uc from 	117	for	30	) as 	TEXT	) AS 	 DIRECCION	,
  cast(substring(uc from 	147	for	10	) as 	TEXT	) AS 	 TELCOM	,
  cast(substring(uc from 	157	for	10	) as 	TEXT	) AS 	 TELRES	,
  cast(substring(uc from 	167	for	15	) as 	TEXT	) AS 	 CIUDAD	,
  cast(substring(uc from 	182	for	15	) as 	TEXT	) AS 	 DEPTO	,
  cast(substring(uc from 	197	for	8	) as 	TEXT	) AS 	 FECNAC	,
  cast(substring(uc from 	205	for	1	) as 	TEXT	) AS 	 SEXO	,
  cast(substring(uc from 	206	for	3	) as 	TEXT	) AS 	 PROMOTOR	,
  cast(substring(uc from 	209	for	8	) as 	INT	) AS 	 OCUPACION	,
  cast(substring(uc from 	217	for	1	) as 	TEXT	) AS 	 ESTADO_R	,
  cast(substring(uc from 	218	for	1	) as 	TEXT	) AS 	 VIDA	,
  cast(substring(uc from 	219	for	1	) as 	TEXT	) AS 	 DOBLE	,
  cast(substring(uc from 	220	for	1	) as 	TEXT	) AS 	 INCAP	,
  cast(substring(uc from 	221	for	1	) as 	TEXT	) AS 	 RENTA_D	,
  cast(substring(uc from 	222	for	1	) as 	TEXT	) AS 	 GRATUITO	,
  cast(substring(uc from 	223	for	1	) as 	TEXT	) AS 	 ENFGRV	,
  cast(substring(uc from 	224	for	1	) as 	TEXT	) AS 	 ULTGAST	,
  cast(substring(uc from 	225	for	11	) as 	DOUBLE PRECISION	) AS 	 VASGP1	,
  cast(substring(uc from 	236	for	1	) as 	TEXT	) AS 	 B1A	,
  cast(substring(uc from 	237	for	10	) as 	DOUBLE PRECISION	) AS 	 VASGU1	,
  cast(substring(uc from 	247	for	6	) as 	TEXT	) AS 	 B1B	,
  cast(substring(uc from 	253	for	9	) as 	DOUBLE PRECISION	) AS 	 PRIM1	,
  cast(substring(uc from 	262	for	1	) as 	TEXT	) AS 	 B1C	,
  cast(substring(uc from 	263	for	11	) as 	DOUBLE PRECISION	) AS 	 VASGP2	,
  cast(substring(uc from 	274	for	1	) as 	TEXT	) AS 	 B2A	,
  cast(substring(uc from 	275	for	10	) as 	DOUBLE PRECISION	) AS 	 VASGU2	,
  cast(substring(uc from 	285	for	6	) as 	TEXT	) AS 	 B2B	,
  cast(substring(uc from 	291	for	9	) as 	DOUBLE PRECISION	) AS 	 PRIM2	,
  cast(substring(uc from 	300	for	1	) as 	TEXT	) AS 	 B2C	,
  cast(substring(uc from 	301	for	11	) as 	DOUBLE PRECISION	) AS 	 VASGP3	,
  cast(substring(uc from 	312	for	1	) as 	TEXT	) AS 	 B3A	,
  cast(substring(uc from 	313	for	10	) as 	DOUBLE PRECISION	) AS 	 VASGU3	,
  cast(substring(uc from 	323	for	6	) as 	TEXT	) AS 	 B3B	,
  cast(substring(uc from 	329	for	9	) as 	DOUBLE PRECISION	) AS 	 PRIM3	,
  cast(substring(uc from 	338	for	1	) as 	TEXT	) AS 	 B3C	,
  cast(substring(uc from 	339	for	11	) as 	DOUBLE PRECISION	) AS 	 VASGP4	,
  cast(substring(uc from 	350	for	1	) as 	TEXT	) AS 	 B4A	,
  cast(substring(uc from 	351	for	10	) as 	DOUBLE PRECISION	) AS 	 VASGU4	,
  cast(substring(uc from 	361	for	6	) as 	TEXT	) AS 	 B4B	,
  cast(substring(uc from 	367	for	9	) as 	DOUBLE PRECISION	) AS 	 PRIM4	,
  cast(substring(uc from 	376	for	1	) as 	TEXT	) AS 	 B4C	,
  cast(substring(uc from 	377	for	11	) as 	DOUBLE PRECISION	) AS 	 VASGP5	,
  cast(substring(uc from 	388	for	1	) as 	TEXT	) AS 	 B5A	,
  cast(substring(uc from 	389	for	10	) as 	DOUBLE PRECISION	) AS 	 VASGU5	,
  cast(substring(uc from 	399	for	6	) as 	TEXT	) AS 	 B5B	,
  cast(substring(uc from 	405	for	9	) as 	DOUBLE PRECISION	) AS 	 PRIM5	,
  cast(substring(uc from 	414	for	1	) as 	TEXT	) AS 	 B5C	,
  cast(substring(uc from 	415	for	11	) as 	DOUBLE PRECISION	) AS 	 VASGP6	,
  cast(substring(uc from 	426	for	1	) as 	TEXT	) AS 	 B6A	,
  cast(substring(uc from 	427	for	10	) as 	DOUBLE PRECISION	) AS 	 VASGU6	,
  cast(substring(uc from 	437	for	6	) as 	TEXT	) AS 	 B6B	,
  cast(substring(uc from 	443	for	9	) as 	DOUBLE PRECISION	) AS 	 PRIM6	,
  cast(substring(uc from 	452	for	1	) as 	TEXT	) AS 	 B6C	,
  cast(substring(uc from 	453	for	11	) as 	DOUBLE PRECISION	) AS 	 VASGP7	,
  cast(substring(uc from 	464	for	1	) as 	TEXT	) AS 	 B7A	,
  cast(substring(uc from 	465	for	10	) as 	DOUBLE PRECISION	) AS 	 VASGU7	,
  cast(substring(uc from 	475	for	6	) as 	TEXT	) AS 	 B7B	,
  cast(substring(uc from 	481	for	9	) as 	DOUBLE PRECISION	) AS 	 PRIM7	,
  cast(substring(uc from 	490	for	1	) as 	TEXT	) AS 	 B7C	,
  cast(substring(uc from 	491	for	5	) as 	DOUBLE PRECISION	) AS 	 FACTURA	,
  cast(substring(uc from 	496	for	10	) as 	TEXT	) AS 	 FORPAG	,
  cast(substring(uc from 	506	for	8	) as 	TEXT	) AS 	 FECEMI	,
  cast(substring(uc from 	514	for	8	) as 	TEXT	) AS 	 FECVIGDE	,
  cast(substring(uc from 	522	for	8	) as 	TEXT	) AS 	 FECVIGHA	,
  cast(substring(uc from 	530	for	8	) as 	TEXT	) AS 	 FECCANCE	,
  cast(substring(uc from 	538	for	3	) as 	INT	) AS 	 CODENDC	,
  cast(substring(uc from 	541	for	2	) as 	INT	) AS 	 SUBCODENDM	,
  cast(substring(uc from 	543	for	3	) as 	INT	) AS 	 CODENDM	,
  cast(substring(uc from 	546	for	2	) as 	INT	) AS 	 SUBCODEND	,
  cast(substring(uc from 	548	for	1	) as 	TEXT	) AS 	 ESTADOASEG	,
  cast(substring(uc from 	549	for	2	) as 	TEXT	) AS 	 ESTADOPAGO	,
  cast(substring(uc from 	551	for	8	) as 	TEXT	) AS 	 CODUSR	,
  cast(substring(uc from 	559	for	2	) as 	INT	) AS 	 CODCIA	,
  cast(substring(uc from 	561	for	3	) as 	INT	) AS 	 CODSECC	,
  cast(substring(uc from 	564	for	15	) as 	bigint	) AS 	 NUMSECUPOL	,
  cast(substring(uc from 	579	for	5	) as 	INT	) AS 	 NUMEND	,
  cast(substring(uc from 	584	for	1	) as 	INT	) AS 	 CODCOA	,
  cast(substring(uc from 	585	for	2	) as 	INT	) AS 	 CODMON	,
  cast(substring(uc from 	587	for	15	) as 	TEXT	) AS 	 TC	,
  cast(substring(uc from 	602	for	8	) as 	TEXT	) AS 	 FECEQUIPO	,
  cast(substring(uc from 	610	for	1	) as 	TEXT	) AS 	 MCAEMIS	,
  cast(substring(uc from 	611	for	1	) as 	TEXT	) AS 	 MCAEJACT	,
  cast(substring(uc from 	612	for	11	) as 	TEXT	) AS 	 PORCPART		
  
  INTO VGR",fec_cartera,"
  FROM VGRB;
  
  
  DROP TABLE IF EXISTS VGRB;
  
  
  
  -- //////////////////////////////////////
  
  
  alter table vgr",fec_cartera,"
  drop ciudad ; 
  
  with a as(
  select*, cast((substring(fecemi from 5 for 4)||'-'||substring(fecemi from 3 for 2)||'-'||substring(fecemi from 1 for 2)) as date) as fec_emi, cast((substring(fecnac from 5 for 4)||'-'||substring(fecnac from 3 for 2)||'-'||substring(fecnac from 1 for 2)) as date) as fec_nac, cast(substring(poliza from 12 for 2) as int) as altura, cast((substring(fecvigde from 5 for 4)||'-'||substring(fecvigde from 3 for 2)||'-'||substring(fecvigde from 1 for 2)) as date) as fecvig_ini, cast((substring(fecvigha from 5 for 4)||'-'||substring(fecvigha from 3 for 2)||'-'||substring(fecvigha from 1 for 2)) as date) as fecvig_fin,cast((substring(fecequipo from 5 for 4)||'-'||substring(fecequipo from 3 for 2)||'-'||substring(fecequipo from 1 for 2)) as date) as fec_equipo
  from vgr",fec_cartera,"
  -- limit 10
  ),
  b as(
  select*,round((('",fecha,"')-fec_nac)/365.25,2) as Edad, prim1+prim2+prim3+prim4+prim5+prim6+prim7 as prima,cast(fecvig_ini - (interval '1 year')*(altura-1) as date) as fecini_neg 
  from a
  ),
  c as(
  select b.*, ciudades.ciudad as ciudad, 
  case 	when edad<20 then ' 0 - 19'
  when edad>=20 and edad<30  then ' 20 - 29'
  when edad>=30 and edad<40  then ' 30 - 39'
  when edad>=40 and edad<50  then ' 40 - 49'
  when edad>=50 and edad<60  then ' 50 - 59'
  when edad>=60 and edad<70  then ' 60 - 69'
  when edad>=70 then ' 70+ '
  else 'other'
  end as rango
  from b left join ciudades on
  b.localidad = ciudades.localidad
  )
  select c.*, linea_negocio.linea as lineaNeg
  into temporal
  from c left join linea_negocio on
  c.producto = linea_negocio.producto; 
  
  drop table vgr",fec_cartera,";
  
  select*
  into vgr",fec_cartera,"
  from temporal;
  
  drop table temporal;
  
  
  --////////////////////////////////////////////////////////
  insert into vgr
  select '",fec_cartera,"'  as fec_cartera,*
  from vgr",fec_cartera,";

  ",sep=""))
