# CARGA, TRANFORMACION y UNION VIDA INDIVIDUAL
dbGetQuery(con,paste(
  "
 drop table if exists vib, VI",fec_cartera,"_temp, vi",fec_cartera,";
  CREATE TABLE VIB(
  UC CHARACTER(842));
  
  COPY VIB
  from 'C:/Users/Public/Documents/VI/CARTERA VIDA IND/",vi,".dat' 
  (format text);
  
  select
  
  cast(substring(uc from 1 for 3) as integer) as RAMO,
  cast(substring(uc from 4 for 4) as integer) as OFICINA,
  cast(substring(uc from 8 for 7) as bigint) as POLIZA,
  cast(substring(uc from 15 for 2) as integer) as NUMANU,
  cast(substring(uc from 17 for 1) as text) as PLANVI_temp,
  cast(substring(uc from 18 for 8) as text) as ININEG,
  cast(substring(uc from 26 for 8) as text) as FECINI,
  cast(substring(uc from 34 for 5) as text) as PORREG,
  cast(substring(uc from 39 for 1) as text) as PERPAG,
  cast(substring(uc from 40 for 8) as text) as FECNAC,
  cast(substring(uc from 48 for 2) as integer) as EDAINI,
  cast(substring(uc from 50 for 2) as text) as TIPENDO,
  cast(substring(uc from 52 for 15) as double precision) as VLRASEG,
  cast(substring(uc from 67 for 1) as text) as SEXO,
  cast(substring(uc from 68 for 15) as bigint) as CEDULA,
  cast(substring(uc from 83 for 15) as double precision) as PRIEFG,
  cast(substring(uc from 98 for 7) as double precision) as TASAEFG,
  cast(substring(uc from 105 for 15) as double precision) as VLREFG,
  cast(substring(uc from 120 for 8) as text) as FECINGEFG,
  cast(substring(uc from 128 for 8) as text) as FECRETEFG_temp,
  cast(substring(uc from 136 for 3) as text) as CAURETEFG,
  cast(substring(uc from 139 for 4) as integer) as LOCRAD,
  cast(substring(uc from 143 for 5) as integer) as CODAGTE,
  cast(substring(uc from 148 for 15) as double precision) as VASEGAP,
  cast(substring(uc from 163 for 15) as double precision) as VASEGDE,
  cast(substring(uc from 178 for 15) as double precision) as VASEGIN,
  cast(substring(uc from 193 for 15) as double precision) as VASEGGM,
  cast(substring(uc from 208 for 15) as double precision) as PRIBAS,
  cast(substring(uc from 223 for 15) as double precision) as PRIGME,
  cast(substring(uc from 238 for 15) as double precision) as PRIIND,
  cast(substring(uc from 253 for 15) as double precision) as PRIINC,
  cast(substring(uc from 268 for 15) as double precision) as PRIMAP,
  cast(substring(uc from 283 for 15) as text) as PRIT20_temp,
  cast(substring(uc from 298 for 1) as text) as S1,
  cast(substring(uc from 299 for 15) as double precision) as EXTBAS,
  cast(substring(uc from 314 for 1) as text) as S2,
  cast(substring(uc from 315 for 15) as double precision) as EXTGME,
  cast(substring(uc from 330 for 1) as text) as S3,
  cast(substring(uc from 331 for 15) as double precision) as EXTIND,
  cast(substring(uc from 346 for 1) as text) as S4,
  cast(substring(uc from 347 for 15) as double precision) as EXTINC,
  cast(substring(uc from 362 for 1) as text) as S5,
  cast(substring(uc from 363 for 15) as double precision) as EXTMAP,
  cast(substring(uc from 378 for 1) as text) as S6,
  cast(substring(uc from 379 for 15) as double precision) as EXTEFG,
  cast(substring(uc from 394 for 14) as bigint) as CAMBIO,
  cast(substring(uc from 408 for 7) as text) as CODRIES,
  cast(substring(uc from 415 for 8) as text) as FECFIN,
  cast(substring(uc from 423 for 2) as text) as CODCIA,
  cast(substring(uc from 425 for 3) as text) as CODSECC,
  cast(substring(uc from 428 for 15) as bigint) as NUMSECUPOL,
  cast(substring(uc from 443 for 5) as integer) as NUMEND,
  cast(substring(uc from 448 for 1) as text) as CODCOA,
  cast(substring(uc from 449 for 2) as text) as CODMON,
  cast(substring(uc from 451 for 8) as text) as FECHAEQUIP,
  cast(substring(uc from 459 for 1) as text) as MCAEMISION,
  cast(substring(uc from 460 for 1) as text) as MCAEJACT,
  cast(substring(uc from 461 for 10) as text) as PORPARTCOA,
  cast(substring(uc from 471 for 15) as double precision) as PRIMAHORRO,
  cast(substring(uc from 486 for 1) as text) as CATEGORIA,
  cast(substring(uc from 487 for 15) as double precision) as PRIITP,
  cast(substring(uc from 502 for 7) as double precision) as TASAITP,
  cast(substring(uc from 509 for 15) as double precision) as VASEGITP,
  cast(substring(uc from 524 for 1) as text) as S7,
  cast(substring(uc from 525 for 15) as double precision) as EXTITP,
  cast(substring(uc from 540 for 15) as double precision) as PRIEFG40EX,
  cast(substring(uc from 555 for 7) as double precision) as TASEFG40EX,
  cast(substring(uc from 562 for 15) as double precision) as VAGEFG40EX,
  cast(substring(uc from 577 for 1) as text) as S8,
  cast(substring(uc from 578 for 15) as double precision) as EXTEFG40EX,
  cast(substring(uc from 593 for 15) as double precision) as PRIEFG100,
  cast(substring(uc from 608 for 7) as double precision) as TASEFG100,
  cast(substring(uc from 615 for 15) as double precision) as VAGEFG100,
  cast(substring(uc from 630 for 1) as text) as S9,
  cast(substring(uc from 631 for 15) as double precision) as EXTEFG100,
  cast(substring(uc from 646 for 15) as double precision) as PRIEFG100E,
  cast(substring(uc from 661 for 7) as double precision) as TASEFG100E,
  cast(substring(uc from 668 for 15) as double precision) as VAGEFG100E,
  cast(substring(uc from 683 for 1) as text) as S10,
  cast(substring(uc from 684 for 15) as double precision) as EXTEFG100E,
  cast(substring(uc from 699 for 15) as double precision) as PRIAPCAM,
  cast(substring(uc from 714 for 7) as double precision) as TASAAPCAM,
  cast(substring(uc from 721 for 15) as double precision) as VASEGAPCAM,
  cast(substring(uc from 736 for 15) as double precision) as PRITRA,
  cast(substring(uc from 751 for 7) as double precision) as TASATRA,
  cast(substring(uc from 758 for 15) as double precision) as VASEGTRA,
  cast(substring(uc from 773 for 1) as text) as S11,
  cast(substring(uc from 774 for 15) as double precision) as EXTTRA,
  cast(substring(uc from 789 for 15) as double precision) as PRIITPADC,
  cast(substring(uc from 804 for 7) as double precision) as TASAITPADC,
  cast(substring(uc from 811 for 15) as double precision) as VASEGITPAD,
  cast(substring(uc from 826 for 1) as text) as S12,
  cast(substring(uc from 827 for 15) as double precision) as EXTITPADC
  
  INTO VI",fec_cartera,"_temp
  FROM VIB;
  
  DROP TABLE IF EXISTS VIB;
  
  update vi",fec_cartera,"_temp
  set planvi_temp = NULL where planvi_temp = ' ';
  
  update vi",fec_cartera,"_temp
  set prit20_temp = NULL where prit20_temp = '               ';
  
  update vi",fec_cartera,"_temp
  set FECRETEFG_temp = NULL where FECRETEFG_temp = '        ';
  
  select
  
  RAMO	,
  OFICINA	,
  POLIZA	,
  NUMANU	,
  cast(PLANVI_temp as int) as planvi	,
  ININEG	,
  FECINI	,
  PORREG	,
  PERPAG	,
  FECNAC	,
  EDAINI	,
  TIPENDO	,
  VLRASEG	,
  SEXO	,
  CEDULA	,
  PRIEFG	,
  TASAEFG	,
  VLREFG	,
  FECINGEFG 	,
  cast(FECRETEFG_temp as text) as FECRETEFG	,
  CAURETEFG	,
  LOCRAD	,
  CODAGTE	,
  VASEGAP	,
  VASEGDE	,
  VASEGIN	,
  VASEGGM	,
  PRIBAS	,
  PRIGME	,
  PRIIND	,
  PRIINC	,
  PRIMAP	,
  cast(PRIT20_temp as double precision) as prit20	,
  S1	,
  EXTBAS	,
  S2	,
  EXTGME	,
  S3	,
  EXTIND	,
  S4	,
  EXTINC	,
  S5	,
  EXTMAP	,
  S6	,
  EXTEFG	,
  CAMBIO	,
  CODRIES	,
  FECFIN	,
  CODCIA	,
  CODSECC	,
  NUMSECUPOL	,
  NUMEND	,
  CODCOA	,
  CODMON	,
  FECHAEQUIP	,
  MCAEMISION	,
  MCAEJACT	,
  PORPARTCOA	,
  PRIMAHORRO	,
  CATEGORIA	,
  PRIITP	,
  TASAITP	,
  VASEGITP	,
  S7	,
  EXTITP	,
  PRIEFG40EX	,
  TASEFG40EX	,
  VAGEFG40EX	,
  S8	,
  EXTEFG40EX	,
  PRIEFG100	,
  TASEFG100	,
  VAGEFG100	,
  S9	,
  EXTEFG100	,
  PRIEFG100E	,
  TASEFG100E	,
  VAGEFG100E	,
  S10	,
  EXTEFG100E	,
  PRIAPCAM	,
  TASAAPCAM	,
  VASEGAPCAM	,
  PRITRA	,
  TASATRA	,
  VASEGTRA	,
  S11	,
  EXTTRA	,
  PRIITPADC	,
  TASAITPADC	,
  VASEGITPAD	,
  S12	,
  EXTITPADC	
  
  
  into vi",fec_cartera,"
  from vi",fec_cartera,"_temp;
  
  -- //////////////////////////////////////
  
  with a as(
  select*, 
  cast(fecingefg as date) as fec_inefg,
  cast(fecretefg as date) as fec_retefg,
  cast(inineg as date) as fecini_neg,
  cast(fechaequip as date) as fec_equipo,
  cast(fecini as date) as fecvig_ini,
  cast(fecnac as date) as fec_nac,
  cast(fecfin as date) as fecvig_fin
  from vi",fec_cartera,"
  ),
  b as(
  select*,
  round((('",fecha,"')-fec_nac)/365.25,2) as Edad, 
  coalesce(priefg,0) + coalesce(pribas,0) + coalesce(prigme,0) + coalesce(priind,0) + coalesce(priinc,0) + coalesce(primap,0) + coalesce(prit20,0) + coalesce(priitp,0) + coalesce(priefg40ex,0) + 
  coalesce(priefg100,0) + coalesce(priefg100e,0) + coalesce(priapcam,0) + coalesce(pritra,0) + coalesce(priitpadc,0) as prima,
  coalesce(extbas,0) + coalesce(extgme,0) + coalesce(extind,0) + coalesce(extinc,0) + coalesce(extmap,0) + coalesce(extefg,0) + coalesce(extitp,0) + coalesce(extefg40ex,0) + coalesce(extefg100,0) + 
  coalesce(extefg100e,0) + coalesce(exttra,0) + coalesce(extitpadc,0) as extraprima
  from a
  ),
  c as(
  select b.*, 
  ciudadesvi.ciudad as ciudad, 
  case 
  when edad<20 then ' 0 - 19'
  when edad>=20 and edad<30  then ' 20 - 29'
  when edad>=30 and edad<40  then ' 30 - 39'
  when edad>=40 and edad<50  then ' 40 - 49'
  when edad>=50 and edad<60  then ' 50 - 59'
  when edad>=60 and edad<70  then ' 60 - 69'
  when edad>=70 then ' 70+ '
  else 'other'
  end as rango
  from b left join ciudadesvi on
  b.oficina = ciudadesvi.localidad
  )
  select c.*
  into temporal
  from c;
  
  drop table vi",fec_cartera,";
  
  select*
  into vi",fec_cartera,"
  from temporal;
  
  drop table temporal,vi",fec_cartera,"_temp;
  
  -- ///////////////////////////////////////////////
  
  insert into vi
  select '",fec_cartera,"'  as fec_cartera,*
  from vi",fec_cartera,"
  
  ",sep=""))
