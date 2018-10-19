# CARGA, TRANFORMACION Y UNION  DEUDORES

dbGetQuery(con,paste(
  "
  CREATE TABLE PR",fec_cartera,"
(
  compania text,
  numero_credito text,
  linea_credito text,
  codigo_franquicia text,
  codigo_libranza text,
  nombre_asegurado text,
  apellidos_asegurado text,
  tipo_identificacion text,
  numero_identificacion bigint,
  edad integer,
  asegurabilidad double precision,
  extraprima double precision,
  cupo_otorgado double precision,
  valor_disponible double precision,
  marca_credito text,
  periodicidad_pago text,
  clase_cartera text,
  valor_incial_desembolsado double precision,
  valor_base_asegurado_vida double precision,
  valor_base_asegurado_itp double precision,
  prima_vida_por_persona_asegurada double precision,
  prima_itp_por_persona_asegurada double precision,
  extraprima_vida double precision,
  extraprima_itp double precision,
  fecha_ingreso text,
  fecha_nacimiento text,
  genero text,
  direccion text,
  telefono character(1),
  ciudad text,
  ciudad_cod_dane text,
  dias_mora text,
  valor_intereses_mora double precision,
  indicador_novedad_fecha_ciclo_facturacion text,
  cobro_juridico text,
  indicador_factura_fin_semana_fin_mes text,
  valor_base_asegurado_vida_corregido double precision,
  valor_base_asegurado_itp_corregido double precision,
  prima_total double precision,
  prima_total_y_extraprima double precision,
  tasa_banco double precision,
  poliza text,
  subgrupo_poliza text,
  tasa_bolivar double precision,
  cumulo_vas_vida double precision,
  cumulo_vas_itp double precision,
  num_creditos bigint
);
  
  
  COPY PR",fec_cartera,"
  FROM 'C:/Users/Public/Documents/DEUDORES/",pr,".CSV'
  (format 'csv', encoding 'LATIN1', DELIMITER '|',  HEADER );
  
  insert into PR
  select '",fec_cartera,"'  as fec_cartera,*
  from pr",fec_cartera,";
  
  
  CREATE TABLE TC",fec_cartera,"(
  compania text,
  numero_credito text,
  linea_credito text,
  codigo_franquicia text,
  codigo_libranza text,
  nombre_asegurado text,
  apellidos_asegurado text,
  tipo_identificacion text,
  numero_identificacion bigint,
  edad integer,
  asegurabilidad double precision,
  extraprima double precision,
  cupo_otorgado double precision,
  valor_disponible double precision,
  marca_credito text,
  periodicidad_pago text,
  clase_cartera text,
  valor_incial_desembolsado double precision,
  valor_base_asegurado_vida double precision,
  valor_base_asegurado_itp double precision,
  prima_vida_por_persona_asegurada double precision,
  prima_itp_por_persona_asegurada double precision,
  extraprima_vida double precision,
  extraprima_itp double precision,
  fecha_ingreso text,
  fecha_nacimiento text,
  genero text,
  direccion text,
  telefono character(1),
  ciudad text,
  ciudad_cod_dane text,
  dias_mora text,
  valor_intereses_mora double precision,
  indicador_novedad_fecha_ciclo_facturacion text,
  cobro_juridico text,
  indicador_factura_fin_semana_fin_mes text,
  valor_base_asegurado_vida_corregido double precision,
  valor_base_asegurado_itp_corregido double precision,
  prima_total double precision,
  prima_total_y_extraprima double precision,
  tasa_banco double precision,
  bines text,
  nombre_franquicia text,
  segmento text,
  tarifa_bolivar text,
  tipo_tarifa text,
  cumulo_vas_vida double precision,
  cumulo_vas_itp double precision,
  num_creditos bigint
  );
  
  COPY TC",fec_cartera,"
  FROM 'C:/Users/Public/Documents/DEUDORES/",tc,".CSV'
  (format 'csv', encoding 'LATIN1', DELIMITER '|',  HEADER );

  insert into tc
  select '",fec_cartera,"'  as fec_cartera,*
  from tc",fec_cartera,";
  ",sep=""
))