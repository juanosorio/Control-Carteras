dbGetQuery(con,paste(
  "
  ---------------------------------------------------------------------------------------------------------
  ---------------------------------------------------------------------------------------------------------
  -- Importar maestro de polizas de DESEMPLEO, para generar la columna de linea de producto.

  DROP TABLE IF EXISTS MESTRO_POLIZA_DESEMPLEO;
  CREATE TABLE MESTRO_POLIZA_DESEMPLEO(
  ram integer,
  num_pol bigint,
  producto text
  );

  COPY MESTRO_POLIZA_DESEMPLEO
  FROM 'C:/Users/Public/Documents/Siniestros/MESTRO_POLIZA_DESEMPLEO.CSV';
  ---------------------------------------------------------------------------------------------------------
  ---------------------------------------------------------------------------------------------------------

  DROP TABLE IF EXISTS SINIESTROS_mes;
  
  CREATE TABLE SINIESTROS_mes
  (
  COD_LOC	INT,
  LOCALIDAD TEXT,	
  COD_PROD INT,	
  COD_SECC INT,	
  PRODUCTO TEXT,	
  POLIZA BIGINT,	
  RAMO_CONTABLE INT,	
  No_IDENTIFICACION BIGINT,	
  NOMBRE_ASEGURADO TEXT,	
  No_SINIESTRO BIGINT,	
  OCUPACION TEXT,	
  FECHA_INGRESO DATE,	
  FECHA_SINIESTRO	DATE,
  TIEMPO_PERMANENCIA NUMERIC,	
  CAUSA_SINIESTRO	TEXT,
  EDAD_INGRESO TEXT,	
  EDAD_SIN_temp TEXT,
  VAS_INICIAL_TEMP TEXT, 
  VR_RESERVA NUMERIC,
  VR_LIQUIDADO NUMERIC, 	 
  VR_RESERVA_REASEG NUMERIC,	 
  VR_LIQUIDACION_REASEG NUMERIC,	 
  VLR_RETENCION NUMERIC,	
  ESTADO_SINIES TEXT,	
  LOCALIDAD_OCURRENCIA TEXT,	
  NOMBRE_TOMADOR	TEXT,
  FECHA_FORMALIZAC DATE,	
  TIPO_EXPED TEXT	,
  COD_OBJECION TEXT,	
  NOMBRE_OBJECION TEXT,	
  USUARIO_SINIESTRO TEXT,	
  CODIGO_AGENTE NUMERIC,	 
  CAUSA_ESPECIFICA INT,	
  DESCRIPCION_CAUSA TEXT
  );
  
  COPY  SINIESTROS_mes
  FROM 'C:/Users/Public/Documents/SINIESTROS/",siniestros.mes,".CSV'
  (format 'csv', delimiter ',', header, encoding 'LATIN1');
  
  -- Agregar ano y mes de movimiento
  drop table if exists siniestros_mes1;
  select  ",ano," as ano_mov, ",mes," as mes_mov, *
  into siniestros_mes1
  from siniestros_mes;
  
  drop table if exists siniestros_mes;
  --
  
  -- transformacion siniestros Gerencia Vida
  update siniestros_mes1
  set edad_sin_temp = NULL where edad_sin_temp = 'N/D';
  
  update siniestros_mes1
  set VAS_INICIAL_TEMP  = NULL where VAS_INICIAL_TEMP = 'N/D';
  
  -- Agregar el mes a los siniestros acumulados
  insert into siniestros_acum
  select*
  from siniestros_mes1;
  --
  
  DROP TABLE IF EXISTS SINIESTROS;
  
  with a as(
  SELECT *, 
  row_number() over(
  partition by cod_prod, no_siniestro
  order by ano_mov, mes_mov, vr_reserva desc) as num_mov,
  case	
  when cod_objecion <> 'N/D' and vr_reserva <0 			then 	vr_reserva
  else 0 
  end	as siniestros_objetados,
  floor((poliza-floor(poliza/10000000)*10000000)/100) as clave_pol
  from siniestros_acum
  ),
  b as(
  select cod_prod, no_siniestro, ano_mov, mes_mov
  from a
  where num_mov=1
  group by cod_prod, no_siniestro, ano_mov, mes_mov
  ),
  c as (
  select a.*, b.ano_mov as ano_aviso, b.mes_mov as mes_aviso, cast(edad_sin_temp as integer) as edad_siniestro, cast(VAS_INICIAL_TEMP as numeric) as VR_ASEG_INICIAL
  from a left join b on 
  a.cod_prod = b.cod_prod and a.no_siniestro = b.no_siniestro  
  ),
  d as(
  select c.*, ciudadesvi.ciudad as ciudad
  from c left join ciudadesvi on
  c.cod_loc = ciudadesvi.localidad
  )
  
  select ano_mov*100+mes_mov as fecha_estadistica,*, split_part(descripcion_causa,'-->',2) as causa_general,
  case	when siniestros_objetados < 0	then 	1
  else 0
  end as conteo_objetados,
  case 	when num_mov=1 then 1
  else 0
  end	as conteo_aviso,
  case 	when vr_reserva>0 then vr_reserva 
  else 0
  end	as Rva_positiva,
  vr_reserva-vr_reserva_reaseg as vr_rva_retencion, vr_liquidado - vr_liquidacion_reaseg as vr_liquidado_retencion, 
  case 	when tiempo_permanencia >= 0 and tiempo_permanencia < 2 	then	' 0 a 2 anos '
  when tiempo_permanencia >= 2 and tiempo_permanencia < 5 	then	' 2 a 5 anos '
  when tiempo_permanencia >= 5 and tiempo_permanencia < 10 	then	' 5 a 10 anos '
  when tiempo_permanencia >= 10  					then	' 10+ anos '
  end as rango_permanencia,
  date_part('year',fecha_siniestro) as ano_ocurrencia, date_part('month',fecha_siniestro) as mes_ocurrencia,
  case 	when edad_siniestro >=0 and edad_siniestro <20 then ' 0 - 19'
  when edad_siniestro >=20 and edad_siniestro <30  then ' 20 - 29'
  when edad_siniestro >=30 and edad_siniestro <40  then ' 30 - 39'
  when edad_siniestro >=40 and edad_siniestro <50  then ' 40 - 49'
  when edad_siniestro >=50 and edad_siniestro <60  then ' 50 - 59'
  when edad_siniestro >=60 and edad_siniestro <70  then ' 60 - 69'
  when edad_siniestro >=70 then ' 70+ '
  else 'otro'
  end as rango_edad,
  CASE
  WHEN 	COD_PROD = 500 OR COD_PROD = 501 THEN 'DESEMPLEO'
  WHEN 	COD_PROD = 735 THEN 'DEUDORES'
  WHEN 	COD_PROD = 759 THEN 'VP'
  WHEN 	COD_PROD = 737 THEN 'ULTIMOS GASTOS'
  WHEN 	COD_PROD = 734 OR COD_PROD = 754 OR COD_PROD = 798 THEN 'AP' 
  
  WHEN 	COD_PROD = 710 OR COD_PROD = 712 OR COD_PROD = 714 OR 
  COD_PROD = 717 OR COD_PROD = 719 OR COD_PROD = 756 OR
  COD_PROD = 721 OR COD_PROD = 724 OR COD_PROD = 725 OR
  COD_PROD = 726 OR COD_PROD = 727 OR COD_PROD = 728 OR
  COD_PROD = 731 OR COD_PROD = 742 OR COD_PROD = 743 OR
  COD_PROD = 749 OR COD_PROD = 761 OR COD_PROD = 791 OR
  COD_PROD = 792 OR COD_PROD = 793 OR COD_PROD = 797 OR
  COD_PROD = 799 THEN 'VGR'  
  
  WHEN 	COD_PROD = 700 OR COD_PROD = 701 OR COD_PROD = 702 OR
  COD_PROD = 703 OR COD_PROD = 706 OR COD_PROD = 711 OR
  COD_PROD = 713 OR COD_PROD = 745 OR COD_PROD = 746 OR
  COD_PROD = 747 OR COD_PROD = 802 OR COD_PROD = 803 OR
  COD_PROD = 811 OR COD_PROD = 812 OR COD_PROD = 840 OR 
  COD_PROD = 842 OR COD_PROD = 844 OR COD_PROD = 846 OR 
  COD_PROD = 940 OR COD_PROD = 942 OR COD_PROD = 944 OR 
  COD_PROD = 946
  THEN 'VI'
  
  WHEN COD_PROD = 740 THEN 'HOTELERO'
  
  END AS RAMO1,
  
  CASE
  WHEN COD_PROD = 500 OR COD_PROD = 501 THEN 'DESEMPLEO'
  WHEN COD_PROD = 735 THEN 'DEUDORES'
  WHEN COD_PROD = 759 THEN 'VP' 
  WHEN COD_PROD = 737 THEN 'ULTIMOS GASTOS'
  WHEN COD_PROD = 734 OR COD_PROD = 754 OR COD_PROD = 798 THEN 'AP' 
  
  WHEN COD_PROD = 710 OR COD_PROD = 724 OR COD_PROD = 799 THEN 'EDUCADORES'
  WHEN COD_PROD = 712 OR COD_PROD = 714 OR COD_PROD = 721 OR COD_PROD = 731 OR COD_PROD = 791 THEN 'DAVIDAS'
  WHEN COD_PROD = 725 OR COD_PROD = 726 OR COD_PROD = 727 OR COD_PROD = 728 OR COD_PROD = 742 OR COD_PROD = 743 THEN 'COLECTIVOS'
  WHEN COD_PROD = 717 OR COD_PROD = 719 OR COD_PROD = 749 OR COD_PROD = 792 THEN 'GRUPOS AFINES'
  WHEN COD_PROD = 761 OR COD_PROD = 756 OR COD_PROD = 793 OR COD_PROD = 797 THEN 'OTROS BANCA'
  
  WHEN 	COD_PROD = 700 OR COD_PROD = 701 OR COD_PROD = 702 OR COD_PROD = 703 OR COD_PROD = 706 OR
  COD_PROD = 711 OR COD_PROD = 713 OR COD_PROD = 745 OR COD_PROD = 746 OR COD_PROD = 747 OR
  COD_PROD = 802 OR COD_PROD = 803 OR COD_PROD = 811 OR COD_PROD = 812 OR
  COD_PROD = 840 OR COD_PROD = 842 OR COD_PROD = 844 OR
  COD_PROD = 846 OR COD_PROD = 940 OR
  COD_PROD = 942 OR COD_PROD = 944 OR COD_PROD = 946
  THEN 'VI'
  WHEN COD_PROD = 740 THEN 'HOTELERO'
  
  END AS RAMO1_CALIDAD,
  case
  when tipo_exped = 'ADP' then 'Adopcion'
  when tipo_exped = 'DES' then 'Desempleo'
  when tipo_exped = 'DHH' then 'Renta_D por Hosp'
  when tipo_exped = 'DHP' then 'Renta_D Post Hosp'
  when tipo_exped = 'DIH' then 'Renta_D por Hosp'
  when tipo_exped = 'DIR' then 'Renta_D por Incapacidad'
  when tipo_exped = 'DIV' then 'Divorcio'
  when tipo_exped = 'EGR' then 'EG'
  when tipo_exped = 'EPP' then 'Exoneracion de Pago de Primas'
  when tipo_exped = 'FLL' then 'Fallecimiento'
  when tipo_exped = 'GME' then 'Gastos Medicos'
  when tipo_exped = 'GRD' then 'Graduacion'
  when tipo_exped = 'GSJ' then 'Gastos_Jur'
  when tipo_exped = 'GSO' then 'Gastos_Stro'
  when tipo_exped = 'HOS' then 'Hospitalizacion'
  when tipo_exped = 'IMR' then 'Renta Mensual'
  when tipo_exped = 'IS1' then 'Invalidez'
  when tipo_exped = 'ITM' then 'ITM'
  when tipo_exped = 'ITP' then 'ITP'
  when tipo_exped = 'MTM' then 'Matrimonio'
  when tipo_exped = 'NAC' then 'Nacimiento'
  when tipo_exped = 'PID' then 'Desmembracion'
  when tipo_exped = 'PJS' then 'Proceso_Jur'
  when tipo_exped = 'VGR' then 'Vida'
  when tipo_exped = 'VID' then 'Vida'
  when tipo_exped = 'VMA' then 'MA'
  when tipo_exped = 'VUG' then 'UG'
  when tipo_exped = 'WRS' then 'Reintegro de Siniestros'
  when tipo_exped = 'MTD' then 'Maternidad'
  when tipo_exped = 'DHR' then 'Renta_D por Hosp'
  when tipo_exped = 'MAT' then 'MA_vida'
  when tipo_exped = 'PDE' then 'Perdida_equipaje'
  else 'otros'
  end as cobertura,
  
  case
  when cod_prod=735 AND clave_pol in (45334,45385) then 'AUTOS'
  when cod_prod=735 AND clave_pol in (45155,45312,4500,45400) then 'CREDIEXPRESS'
  when cod_prod=735 AND clave_pol in (206,207,208,209,219,45387) then 'HIPOTECARIO'
  when cod_prod=735 AND clave_pol in (45389,45388) then 'AGR+CAF'
  when cod_prod=735 AND clave_pol in (45377,45378,45379,45386,45393,45394)then 'TARJETAS'
  when cod_prod=735 AND clave_pol in (45407,45347,45402,45419,45422)then 'OTRA'
  end as linea_deudores
  
  into siniestros_temp
  from d;

  alter table siniestros_temp
  drop edad_sin_temp, 
  drop vas_inicial_temp;

  --------------------------------------------------------------------------------------------------------
  --------------------------------------------------------------------------------------------------------
  with a as(
  select siniestros_temp.*, MESTRO_POLIZA_DESEMPLEO.PRODUCTO AS LINEA_DES
  from siniestros_temp left join MESTRO_POLIZA_DESEMPLEO on
  siniestros_temp.cod_prod=MESTRO_POLIZA_DESEMPLEO.ram AND
  siniestros_temp.poliza=MESTRO_POLIZA_DESEMPLEO.num_pol
  )
  select*,
    case
     when linea_deudores is null AND linea_des is null then ramo1_calidad
     when ramo1_calidad = 'DEUDORES' then linea_deudores
     when ramo1_calidad = 'DESEMPLEO' then linea_des
     else 'REVISAR PORQUE PASO ALGO'
    end as Linea
  into siniestros_temp1
  from a;

  --------------------------------------------------------------------------------------------------------
  --------------------------------------------------------------------------------------------------------
  select*
  into siniestros
  from siniestros_temp1;
  
  update  siniestros
  set 	nombre_objecion = 'Incapacidad_Parcial'
  where cod_objecion='92' and conteo_objetados=1 and ramo1 <> 'DESEMPLEO';
  
  drop table siniestros_temp, siniestros_temp1;
  
  -- Hacer un back up de seguidad de la ultima tabla de siniestros_acumulados.
  copy siniestros_acum
  to 'C:/Users/Public/Documents/SINIESTROS/backup/Siniestros_acum_virgen.csv'
  (format 'csv', encoding 'latin1', delimiter ',');
  
  copy siniestros_acum
  to 'C:/Users/Public/Documents/SINIESTROS/backup/Siniestros_acum_virgen",fec_cartera,".csv'
  (format 'csv', encoding 'latin1', delimiter ',');
  ",sep=""))


