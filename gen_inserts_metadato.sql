declare

cursor MTDT_TABLA
  is
SELECT
      DISTINCT TRIM(MTDT_EXT_SCENARIO.TABLE_NAME) "TABLE_NAME" /*(20150907) Angel Ruiz NF. Nuevas tablas.*/
    FROM
      --MTDT_TC_SCENARIO, mtdt_modelo_logico (20150907) Angel Ruiz NF. Nuevas tablas.
      MTDT_EXT_SCENARIO
    --WHERE MTDT_EXT_SCFORMA_PAGOENARIO.TABLE_TYPE = 'F' and
    WHERE
      (trim(MTDT_EXT_SCENARIO.STATUS) = 'P' or trim(MTDT_EXT_SCENARIO.STATUS) = 'D')
      and trim(MTDT_EXT_SCENARIO.TABLE_NAME) in ('PARQUE_ABO_PRE', 'PARQUE_ABO_POST', 'DISTRIBUIDOR',
    'CLIENTE', 'GRUPO_ABONADO', 'REL_GRUPO_ABONADO', 'CICLO', 
    'CICLO_FACTURACION', 'CUENTA', 'ESTATUS_OPERACION', 
    'FORMA_PAGO', 'SEGMENTO_CLIENTE', 'TIPO_DISTRIBUIDOR',
    'ESTADO_CANAL_CAP', 'TIPO_DOCUMENTO', 'CONCEPTO_PAGO', 'ESTADO_CANAL', 'CAUSA_BLOQUEO',
    'NIR', 'CATEGORIA_CANAL_CAP', 'CIUDAD', 'CODIGO_POSTAL', 'COLONIA', 'ESTADO', 
    'MUNICIPIO', 'TERRITORIO', 'TIPO_BLOQUEO', 'PAIS', 'VENTAS_REGISTRADAS', 
    'PLAN_TARIFARIO', 'REL_PLAN_TARIFARIO_CANAL', 'CARACT_PLAN_TARIFARIO', 'SVA', 'REL_SVA_CANAL', 
    'CARACT_SVA', 'TIPO_PROPIETARIO_OFERTA', 'ESTATUS_OFERTA', 'MEDIO_FACTURA', 
    'CANAL_DISTRIBUCION', 'TARJETA_PAGO', 'OFICINA', 'POSICION_VENDEDOR_CAP', 
    'CANAL', 'VENDEDOR', 'PUNTO_VENTA', 'BANCO', 'CATEGORIA_CLIENTE', 'PROMOCION', 'USUARIO_SCL', 
    'PARQUE_SVA', 'CART_VENCIDA', 'CAUSA_PAGO', 'CONCEPTO_FACTURA', 'DOC_CANCELADO', 
    'FACT_DETALLE', 'FACT_RESUMEN', 'PAGO', 'NODO', 'TIPO_NODO', 
    'MOVIMIENTO_ABO', 'ESTADO_CONTACTO', 'FORMA_CONTACTO', 'PRIORIDAD', 'TIPO_TRANSACCION', 
    'MOTIVO_OPERACION_TT', 'TIPO_CARACT_OFERTA', 'VENTA_EQUIPO', 'ICC', 'FACTURACION_IMEI', 'MOVIMIENTO_SVA');
      --and trim(MTDT_EXT_SCENARIO.TABLE_NAME) in ('PARQUE_ABO_PRE', 'PARQUE_ABO_POST', 'CLIENTE', 'CUENTA', 
    --'MOVIMIENTO_ABO', 'PLAN_TARIFARIO',
    --'CATEGORIA_CLIENTE', 'CICLO', 'ESTATUS_OPERACION', 'FORMA_PAGO', 'PROMOCION', 'SEGMENTO_CLIENTE', 
    --'GRUPO_ABONADO', 'REL_GRUPO_ABONADO');
    --and trim(MTDT_EXT_SCENARIO.TABLE_NAME) in ('CUENTA');
  cursor MTDT_SCENARIO (table_name_in IN VARCHAR2)
  is
    SELECT 
      TRIM(MTDT_EXT_SCENARIO.TABLE_NAME) "TABLE_NAME",
      TRIM(MTDT_EXT_SCENARIO.TABLE_TYPE) "TABLE_TYPE",
      TRIM(MTDT_EXT_SCENARIO.TABLE_COLUMNS) "TABLE_COLUMNS",
      TRIM(MTDT_EXT_SCENARIO.TABLE_BASE_NAME) "TABLE_BASE_NAME",
      TRIM(MTDT_EXT_SCENARIO.HINT) "HINT",
      TRIM(MTDT_EXT_SCENARIO.OVER_PARTION) "OVER_PARTION",
      TRIM(MTDT_EXT_SCENARIO."SELECT") "SELECT",
      TRIM (MTDT_EXT_SCENARIO."GROUP") "GROUP",
      TRIM(MTDT_EXT_SCENARIO.FILTER) "FILTER",
      TRIM(MTDT_EXT_SCENARIO.INTERFACE_COLUMNS) "INTERFACE_COLUMNS",
      TRIM(MTDT_EXT_SCENARIO.SCENARIO) "SCENARIO",
      TRIM(MTDT_INTERFACE_SUMMARY.TYPE) "TYPE",
      TRIM(MTDT_INTERFACE_SUMMARY.SEPARATOR) "SEPARATOR"
    FROM 
      MTDT_EXT_SCENARIO, MTDT_INTERFACE_SUMMARY
    WHERE
      trim(MTDT_EXT_SCENARIO.TABLE_NAME) = table_name_in and
      trim(MTDT_EXT_SCENARIO.TABLE_NAME) = trim(MTDT_INTERFACE_SUMMARY.CONCEPT_NAME) and
      (trim(MTDT_EXT_SCENARIO.STATUS) = 'P' or trim(MTDT_EXT_SCENARIO.STATUS) = 'D') and
      (MTDT_INTERFACE_SUMMARY.STATUS = 'P' or MTDT_INTERFACE_SUMMARY.STATUS = 'D')
    ORDER BY MTDT_EXT_SCENARIO.ROWID;
  
  CURSOR MTDT_TC_DETAIL (table_name_in IN VARCHAR2, scenario_in IN VARCHAR2)
  IS
    SELECT 
      TRIM(MTDT_EXT_DETAIL.TABLE_NAME) "TABLE_NAME",
      TRIM(MTDT_EXT_DETAIL.TABLE_COLUMN) "TABLE_COLUMN",
      TRIM(MTDT_EXT_DETAIL.TABLE_BASE_NAME) "TABLE_BASE_NAME",
      TRIM(MTDT_EXT_DETAIL.SCENARIO) "SCENARIO",
      UPPER(TRIM(MTDT_EXT_DETAIL.OUTER)) "OUTER",
      MTDT_EXT_DETAIL.SEVERIDAD,
      TRIM(MTDT_EXT_DETAIL.TABLE_LKUP) "TABLE_LKUP",
      TRIM(MTDT_EXT_DETAIL.TABLE_COLUMN_LKUP) "TABLE_COLUMN_LKUP",
      TRIM(MTDT_EXT_DETAIL.TABLE_LKUP_COND) "TABLE_LKUP_COND",
      TRIM(MTDT_EXT_DETAIL.IE_COLUMN_LKUP) "IE_COLUMN_LKUP",
      TRIM(MTDT_EXT_DETAIL.LKUP_COM_RULE) "LKUP_COM_RULE",
      TRIM(MTDT_EXT_DETAIL.VALUE) "VALUE",
      TRIM(MTDT_EXT_DETAIL.RUL) "RUL",
      TRIM(MTDT_INTERFACE_DETAIL.TYPE) "TYPE",
      MTDT_INTERFACE_DETAIL.LENGTH "LONGITUD",
      MTDT_INTERFACE_DETAIL.POSITION "POSITION"
  FROM
      MTDT_EXT_DETAIL, MTDT_INTERFACE_DETAIL
  WHERE
      TRIM(MTDT_EXT_DETAIL.TABLE_NAME) = table_name_in and
      TRIM(MTDT_EXT_DETAIL.SCENARIO) = scenario_in and
      (trim(MTDT_EXT_DETAIL.STATUS) = 'P' or trim(MTDT_EXT_DETAIL.STATUS) = 'D') and
      trim(MTDT_EXT_DETAIL.TABLE_NAME) = trim(MTDT_INTERFACE_DETAIL.CONCEPT_NAME) and
      trim(MTDT_EXT_DETAIL.TABLE_COLUMN) = trim (MTDT_INTERFACE_DETAIL.COLUMNA) and
      (trim(MTDT_INTERFACE_DETAIL.STATUS) = 'P' or trim(MTDT_INTERFACE_DETAIL.STATUS) = 'D')
  ORDER BY
      MTDT_INTERFACE_DETAIL.POSITION;
      
  CURSOR MTDT_TC_LOOKUP (table_name_in IN VARCHAR2)
  IS
    SELECT
      DISTINCT
      TRIM(TABLE_LKUP) "TABLE_LKUP",
      TABLE_COLUMN_LKUP "TABLE_COLUMN_LKUP",
      TABLE_LKUP_COND "TABLE_LKUP_COND",
      --IE_COLUMN_LKUP "IE_COLUMN_LKUP",
      TRIM("VALUE") "VALUE"
    FROM
      MTDT_EXT_DETAIL
  WHERE
      (trim(RUL) = 'LKUP' or trim(RUL) = 'LKUPC') and
      TRIM(TABLE_NAME) = table_name_in;

  CURSOR MTDT_TC_FUNCTION (table_name_in IN VARCHAR2)
  IS
    SELECT
      DISTINCT
      TRIM(TABLE_LKUP) "TABLE_LKUP",
      TABLE_COLUMN_LKUP "TABLE_COLUMN_LKUP",
      TABLE_LKUP_COND "TABLE_LKUP_COND",
      IE_COLUMN_LKUP "IE_COLUMN_LKUP",
      TRIM("VALUE") "VALUE"
    FROM
      MTDT_EXT_DETAIL
  WHERE
      RUL = 'FUNCTION' and
      TRIM(TABLE_NAME) = table_name_in;
      

  reg_tabla MTDT_TABLA%rowtype;     
  reg_scenario MTDT_SCENARIO%rowtype;
  reg_detail MTDT_TC_DETAIL%rowtype;
  reg_lookup MTDT_TC_LOOKUP%rowtype;
  reg_function MTDT_TC_FUNCTION%rowtype;
  
  type list_columns_primary  is table of varchar(30);
  type list_strings  IS TABLE OF VARCHAR(400);
  type lista_tablas_from is table of varchar(2000);
  type lista_condi_where is table of varchar(1000);

  
  lista_pk                                      list_columns_primary := list_columns_primary (); 
  tipo_col                                     varchar2(50);
  primera_col                               PLS_INTEGER;
  columna                                    VARCHAR2(2000);
  prototipo_fun                             VARCHAR2(2000);
  fich_salida_load                        UTL_FILE.file_type;
  fich_salida_exchange              UTL_FILE.file_type;
  fich_salida_pkg                         UTL_FILE.file_type;
  nombre_fich_carga                   VARCHAR2(60);
  nombre_fich_exchange            VARCHAR2(60);
  nombre_fich_pkg                      VARCHAR2(60);
  lista_scenarios_presentes                                    list_strings := list_strings();
  v_lista_elementos_scenario        list_strings := list_strings();     

  campo_filter                                VARCHAR2(2000);
  nombre_proceso                        VARCHAR2(30);
  nombre_tabla_reducido           VARCHAR2(30);
  nombre_tabla_T                        VARCHAR2(30);
  v_nombre_particion                  VARCHAR2(30);
  --nombre_tabla_base_reducido           VARCHAR2(30);
  OWNER_SA                             VARCHAR2(60);
  OWNER_T                                VARCHAR2(60);
  OWNER_DM                            VARCHAR2(60);
  OWNER_MTDT                       VARCHAR2(60);
  NAME_DM                                VARCHAR2(60);
  OWNER_TC                              VARCHAR2(60);
  PREFIJO_DM                            VARCHAR2(60);
  REQ_NUMBER                            VARCHAR2(60);
  OWNER_1                               VARCHAR2(60);
  OWNER_2                               VARCHAR2(60);
  OWNER_3                               VARCHAR2(60);
  OWNER_4                               VARCHAR2(60);
  BD_SID                                VARCHAR2(60);
  BD_USR                                VARCHAR2(60);
  
  l_FROM                                      lista_tablas_from := lista_tablas_from();
  l_WHERE                                   lista_condi_where := lista_condi_where();
  v_hay_look_up                           VARCHAR2(1):='N';
  v_nombre_seqg                          VARCHAR(120):='N';
  v_bandera                                   VARCHAR2(1):='S';
  v_nombre_tabla_agr                VARCHAR2(30):='No Existe';
  v_nombre_tabla_agr_redu           VARCHAR2(30):='No Existe';
  v_nombre_proceso_agr              VARCHAR2(30);
  nombre_tabla_T_agr                VARCHAR2(30);
  v_existen_retrasados              VARCHAR2(1) := 'N';
  v_type                            VARCHAR2(1);
  v_line_size                       INTEGER;
  v_tabla_dinamica                  BOOLEAN;
  v_num_scenarios                   PLS_integer:=0;
  v_hay_sce_COMPUESTO               BOOLEAN := false;
  v_fecha_ini_param                 BOOLEAN:=false;
  v_fecha_fin_param                 BOOLEAN:=false;
  v_long_total                      PLS_INTEGER;
  v_long_parte_decimal              PLS_INTEGER;
  v_mascara                         VARCHAR2(100);


/************/
/*************/
/* (20150918) Angel Ruiz. NUEVA FUNCION */
  function sustituye_comillas_dinam (cadena_in in varchar2) return varchar2
  is
    lon_cadena integer;
    cabeza                varchar2 (1000);
    sustituto              varchar2(100);
    cola                      varchar2(1000);    
    pos                   PLS_integer;
    pos_ant           PLS_integer;
    posicion_ant           PLS_integer;
    cadena_resul varchar(1000);
    begin
      lon_cadena := length (cadena_in);
      pos := 0;
      posicion_ant := 0;
      cadena_resul:= cadena_in;
      if lon_cadena > 0 then
        /* Busco LA COMILLA */
        pos := 0;
        posicion_ant := 0;
        sustituto := '''''';
        loop
          dbms_output.put_line ('Entro en el LOOP de procesa_condicion_lookup. La cadena es: ' || cadena_resul);
          pos := instr(cadena_resul, '''', pos+1);
          exit when pos = 0;
          dbms_output.put_line ('Pos es mayor que 0');
          dbms_output.put_line ('Primer valor de Pos: ' || pos);
          cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
          dbms_output.put_line ('La cabeza es: ' || cabeza);
          dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
          cola := substr(cadena_resul, pos + length (''''));
          dbms_output.put_line ('La cola es: ' || cola);
          cadena_resul := cabeza || sustituto || cola;
          pos_ant := pos + length ('''''');
          pos := pos_ant;
        end loop;
      end if;
      return cadena_resul;
    end;

/************/
  /* (20160425) Angel Ruiz. Funcion que en caso de que la cadena que se le pase */
  /* posee la forma BETWEEN CAMPO1 AND CAMPO2 */
  /* retorna BETWEEN ALIAS_IN.CAMPO1 AND ALIAS_IN.CAMPO2 */
  function transformo_between (alias_in varchar2, cadena_in in varchar2, outer_in boolean) return varchar2
  is
    v_campo1 varchar2(50);
    v_campo2 varchar2(50);
    v_cadena varchar2(500);
    v_cadena_out varchar2(600);
  begin
    v_cadena := trim(cadena_in);
    if (REGEXP_LIKE(trim(cadena_in), '^BETWEEN +[A-Z_0-9]+ +AND +[A-Z_0-9]+$') = true) then
      /* El METADATO se ha escrito correctamente por lo que que podemos seguir */
      v_campo1 := trim(REGEXP_SUBSTR(v_cadena, ' +[A-Z_0-9]+',1,1));
      v_campo2 := trim(REGEXP_SUBSTR(v_cadena, ' +[A-Z_0-9]+',1,3));
      if (outer_in = false) then
        v_cadena_out := 'BETWEEN ' || alias_in || '.' || v_campo1 || ' AND ' || alias_in || '.' || v_campo2;
      else
        v_cadena_out := 'BETWEEN ' || alias_in || '.' || v_campo1 || ' (+) AND ' || alias_in || '.' || v_campo2 || ' (+)';
      end if;
    else
      v_cadena_out := cadena_in;
    end if;
    return v_cadena_out;
  end transformo_between;
  function cambio_puntoYcoma_por_coma (cadena_in in varchar2) return varchar2
  is
    lon_cadena integer;
    cabeza                varchar2 (1000);
    sustituto              varchar2(1000);
    cola                      varchar2(1000);    
    pos                   PLS_integer;
    pos_ant           PLS_integer;
    posicion_ant           PLS_integer;
    cadena_resul varchar(1000);
  begin
    lon_cadena := length (cadena_in);
    pos := 0;
    posicion_ant := 0;
    cadena_resul:= cadena_in;
    if (lon_cadena > 0) then
      /* Busco VAR_FUN_NAME_LOOKUP */
      sustituto := ',';
      loop
        dbms_output.put_line ('Entro en el LOOP de cambio_puntoYcoma_por_coma. La cadena es: ' || cadena_resul);
        pos := instr(cadena_resul, ';', pos+1);
        exit when pos = 0;
        dbms_output.put_line ('Pos es mayor que 0');
        dbms_output.put_line ('Primer valor de Pos: ' || pos);
        cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
        dbms_output.put_line ('La cabeza es: ' || cabeza);
        dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
        cola := substr(cadena_resul, pos + length (';'));
        dbms_output.put_line ('La cola es: ' || cola);
        cadena_resul := cabeza || sustituto || cola;
        --pos_ant := pos + length (' to_date ( fch_datos_in, ''yyyymmdd'') ');
        --pos := pos_ant;
      end loop;
    end if;  
    return cadena_resul;
  end cambio_puntoYcoma_por_coma;

  function split_string_punto_coma ( cadena_in in varchar2) return list_strings
  is
  lon_cadena integer;
  elemento varchar2 (400);
  pos integer;
  pos_ant integer;
  lista_elementos                                      list_strings := list_strings (); 
  begin
    lon_cadena := length (cadena_in);
    pos := 0;
    pos_ant := 0;
    if lon_cadena > 0 then
      loop
              dbms_output.put_line ('Entro en el LOOP. La cedena es: ' || cadena_in);
              if pos < lon_cadena then
                pos := instr(cadena_in, ';', pos+1);
              else
                pos := 0;
              end if;
              dbms_output.put_line ('Primer valor de Pos: ' || pos);
              if pos > 0 then
                dbms_output.put_line ('Pos es mayor que 0');
                dbms_output.put_line ('Pos es:' || pos);
                dbms_output.put_line ('Pos_ant es:' || pos_ant);
                elemento := substr(cadena_in, pos_ant+1, (pos - pos_ant) -1);
                dbms_output.put_line ('El elemento es: ' || elemento);
                lista_elementos.EXTEND;
                lista_elementos(lista_elementos.LAST) := UPPER(LTRIM(RTRIM (elemento)));
                pos_ant := pos;
              end if;
       exit when pos = 0;
      end loop;
      lista_elementos.EXTEND;
      lista_elementos(lista_elementos.LAST) := UPPER(LTRIM(RTRIM (substr(cadena_in, pos_ant+1, lon_cadena))));
      dbms_output.put_line ('El ultimo elemento es: ' || UPPER(LTRIM(RTRIM (substr(cadena_in, pos_ant+1, lon_cadena)))));
    end if;
    return lista_elementos;
  end split_string_punto_coma;  
  
  function split_string_coma ( cadena_in in varchar2) return list_strings
  is
  lon_cadena integer;
  elemento varchar2 (50);
  pos integer;
  pos_ant integer;
  lista_elementos                                      list_strings := list_strings (); 
  begin
    lon_cadena := length (cadena_in);
    pos := 0;
    pos_ant := 0;
    if lon_cadena > 0 then
      loop
              dbms_output.put_line ('Entro en el LOOP. La cedena es: ' || cadena_in);
              if pos < lon_cadena then
                pos := instr(cadena_in, ',', pos+1);
              else
                pos := 0;
              end if;
              dbms_output.put_line ('Primer valor de Pos: ' || pos);
              if pos > 0 then
                dbms_output.put_line ('Pos es mayor que 0');
                elemento := substr(cadena_in, pos_ant+1, (pos - pos_ant)-1);
                dbms_output.put_line ('El elemento es: ' || elemento);
                lista_elementos.EXTEND;
                lista_elementos(lista_elementos.LAST) := UPPER(LTRIM(RTRIM (elemento)));
                pos_ant := pos;
              end if;
       exit when pos = 0;
      end loop;
      lista_elementos.EXTEND;
      lista_elementos(lista_elementos.LAST) := UPPER(LTRIM(RTRIM (substr(cadena_in, pos_ant+1, lon_cadena))));
      dbms_output.put_line ('El ultimo elemento es: ' || UPPER(LTRIM(RTRIM (substr(cadena_in, pos_ant+1, lon_cadena)))));
    end if;
    return lista_elementos;
  end split_string_coma;

  function split_string_blanco ( cadena_in in varchar2) return list_strings
  is
  lon_cadena integer;
  elemento varchar2 (50);
  pos integer;
  pos_ant integer;
  lista_elementos                                      list_strings := list_strings (); 
  begin
    lon_cadena := length (cadena_in);
    pos := 0;
    pos_ant := 0;
    if lon_cadena > 0 then
      loop
              dbms_output.put_line ('Entro en el LOOP. La cedena es: ' || cadena_in);
              if pos < lon_cadena then
                pos := instr(cadena_in, ' ', pos+1);
              else
                pos := 0;
              end if;
              dbms_output.put_line ('Primer valor de Pos: ' || pos);
              if pos > 0 then
                dbms_output.put_line ('Pos es mayor que 0');
                elemento := substr(cadena_in, pos_ant+1, (pos - pos_ant)-1);
                dbms_output.put_line ('El elemento es: ' || elemento);
                lista_elementos.EXTEND;
                lista_elementos(lista_elementos.LAST) := UPPER(LTRIM(RTRIM (elemento)));
                pos_ant := pos;
              end if;
       exit when pos = 0;
      end loop;
      lista_elementos.EXTEND;
      lista_elementos(lista_elementos.LAST) := UPPER(LTRIM(RTRIM (substr(cadena_in, pos_ant+1, lon_cadena))));
      dbms_output.put_line ('El ultimo elemento es: ' || UPPER(LTRIM(RTRIM (substr(cadena_in, pos_ant+1, lon_cadena)))));
    end if;
    return lista_elementos;
  end split_string_blanco;

  function extrae_campo_decode (cadena_in in varchar2) return varchar2
  is
    lista_elementos list_strings := list_strings (); 

  begin
    lista_elementos := split_string_coma(cadena_in);
    return lista_elementos(lista_elementos.count - 1);
  
  end extrae_campo_decode;

  function extrae_campo_decode_sin_tabla (cadena_in in varchar2) return varchar2
  is
    lista_elementos list_strings := list_strings (); 

  begin
    lista_elementos := split_string_coma(cadena_in);
    if instr(lista_elementos((lista_elementos.count) - 1), '.') > 0 then
      return substr(lista_elementos(lista_elementos.count - 1), instr(lista_elementos((lista_elementos.count) - 1), '.') + 1);
    else
      return lista_elementos(lista_elementos.count - 1);
    end if;
  end extrae_campo_decode_sin_tabla;

  function transformo_decode(cadena_in in varchar2, alias_in in varchar2, outer_in in integer) return varchar2
  is
    parte_1 varchar2(100);
    parte_2 varchar2(100);
    parte_3 varchar2(100);
    parte_4 varchar2(100);
    decode_out varchar2(500);
    lista_elementos list_strings := list_strings ();
  
  begin
    /* Ejemplo de Decode que analizo DECODE (ID_FUENTE,'SER', ID_CANAL,'1') */
    lista_elementos := split_string_coma(cadena_in);
    parte_1 := trim(substr(lista_elementos(1), instr(lista_elementos(1), '(') + 1)); /* Me quedo con ID_FUENTE*/
    parte_2 := lista_elementos(2);  /* Me quedo con 'SER' */
    parte_3 := trim(lista_elementos(3));  /* Me quedo con ID_CANAL */
    parte_4 := trim(substr(lista_elementos(4), 1, instr(lista_elementos(4), ')') - 1));  /* Me quedo con '1' */
    if (instr(parte_1, '''') = 0) then
      /* Esta parte del DECODE no es un literal */
      /* Lo que quiere decir que podemos calificarlo con el nombre de la tabla */
      if (outer_in = 1) then
        parte_1 := alias_in || '.' || parte_1 || '(+)';
      else
        parte_1 := alias_in || '.' || parte_1;
      end if;
    end if;
    if (instr(parte_2, '''') = 0) then
      /* Esta parte del DECODE no es un literal */
      /* Lo que quiere decir que podemos calificarlo con el nombre de la tabla */
      if (outer_in = 1) then
        parte_2 := alias_in || '.' || parte_2 || '(+)';
      else
        parte_2 := alias_in || '.' || parte_2;
      end if;
    end if;
    if (instr(parte_3, '''') = 0) then
      /* Esta parte del DECODE no es un literal */
      /* Lo que quiere decir que podemos calificarlo con el nombre de la tabla */
      if (outer_in = 1) then
        parte_3 := alias_in || '.' || parte_3 || '(+)';
      else
        parte_3 := alias_in || '.' || parte_3;
      end if;
    end if;
    if (instr(parte_4, '''') = 0) then
      /* Esta parte del DECODE no es un literal */
      /* Lo que quiere decir que podemos calificarlo con el nombre de la tabla */
      if (outer_in = 1) then
        parte_4 := alias_in || '.' || parte_4 || '(+)';
      else
        parte_4 := alias_in || '.' || parte_4;
      end if;
    end if;
    /* Puede ocurrir que alguna parte del decode tanga el signo ' como seria el caso de los campos literales */
    /* como estamos generando querys dinamicas, tenemos que escapar las comillas */
    if (instr(parte_1, '''') > 0) then
      parte_1 := sustituye_comillas_dinam(parte_1);
    end if;
    if (instr(parte_2, '''') > 0) then
      parte_2 := sustituye_comillas_dinam(parte_2);
    end if;
    if (instr(parte_3, '''') > 0) then
      parte_3 := sustituye_comillas_dinam(parte_3);
    end if;
    if (instr(parte_4, '''') > 0) then
      parte_4 := sustituye_comillas_dinam(parte_4);
    end if;
    decode_out := 'DECODE(' || parte_1 || ', ' || parte_2 || ', ' || parte_3 || ', ' || parte_4 || ')';
    return decode_out;
  end transformo_decode;
  
  function proceso_campo_value (cadena_in in varchar2, alias_in in varchar) return varchar2
  is
  lon_cadena integer;
  cabeza                varchar2 (1000);
  sustituto              varchar2(100);
  cola                      varchar2(1000);    
  pos                   PLS_integer;
  pos_ant           PLS_integer;
  posicion_ant           PLS_integer;
  v_pos_ini_corchete_ab PLS_integer;
  v_pos_fin_corchete_ce PLS_integer;
  v_cadena_a_buscar varchar2(100);
  cadena_resul varchar(1000);
  begin
    lon_cadena := length (cadena_in);
    pos := 0;
    pos_ant := 0;
    cadena_resul:= cadena_in;
    if (lon_cadena > 0) then
      v_pos_ini_corchete_ab := instr(cadena_in, '[');
      v_pos_fin_corchete_ce := instr(cadena_in, ']');
      v_cadena_a_buscar := substr(cadena_in, v_pos_ini_corchete_ab, (v_pos_fin_corchete_ce - v_pos_ini_corchete_ab) + 1);
      sustituto := alias_in || '.' || substr (cadena_in, v_pos_ini_corchete_ab + 1, (v_pos_fin_corchete_ce - v_pos_ini_corchete_ab) - 1);
      loop
        pos := instr(cadena_resul, v_cadena_a_buscar, pos+1);
        exit when pos = 0;
        dbms_output.put_line ('Pos es mayor que 0');
        dbms_output.put_line ('Primer valor de Pos: ' || pos);
        cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
        dbms_output.put_line ('La cabeza es: ' || cabeza);
        dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
        cola := substr(cadena_resul, pos + length (v_cadena_a_buscar));
        dbms_output.put_line ('La cola es: ' || cola);
        cadena_resul := cabeza || sustituto || cola;
      end loop;
    end if;
    return cadena_resul;
  end;


  function proc_campo_value_condicion (cadena_in in varchar2, nombre_funcion_lookup in varchar2) return varchar2
  is
    lon_cadena integer;
    cabeza                varchar2 (1000);
    sustituto              varchar2(100);
    cola                      varchar2(1000);    
    pos                   PLS_integer;
    pos_ant           PLS_integer;
    posicion_ant           PLS_integer;
    cadena_resul varchar(1000);
  begin
    lon_cadena := length (cadena_in);
    pos := 0;
    posicion_ant := 0;
    cadena_resul:= cadena_in;
    if (lon_cadena > 0) then
      /* Busco VAR_FUN_NAME_LOOKUP */
      sustituto := nombre_funcion_lookup;
      loop
        dbms_output.put_line ('Entro en el LOOP de proc_campo_value_condicion. La cadena es: ' || cadena_resul);
        pos := instr(cadena_resul, 'VAR_FUN_NAME_LOOKUP', pos+1);
        exit when pos = 0;
        dbms_output.put_line ('Pos es mayor que 0');
        dbms_output.put_line ('Primer valor de Pos: ' || pos);
        cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
        dbms_output.put_line ('La cabeza es: ' || cabeza);
        dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
        cola := substr(cadena_resul, pos + length ('VAR_FUN_NAME_LOOKUP'));
        dbms_output.put_line ('La cola es: ' || cola);
        cadena_resul := cabeza || sustituto || cola;
        --pos_ant := pos + length (' to_date ( fch_datos_in, ''yyyymmdd'') ');
        --pos := pos_ant;
      end loop;
    end if;  
    return cadena_resul;
  end;

  function procesa_COM_RULE_lookup (cadena_in in varchar2, v_alias_in varchar2 := NULL) return varchar2
  is
  lon_cadena integer;
  cabeza                varchar2 (1000);
  sustituto              varchar2(100);
  cola                      varchar2(1000);    
  pos                   PLS_integer;
  pos_ant           PLS_integer;
  posicion_ant           PLS_integer;
  cadena_resul varchar(1000);
  begin
    dbms_output.put_line ('Entro en procesa_COM_RULE_lookup');
    lon_cadena := length (cadena_in);
    pos := 0;
    posicion_ant := 0;
    cadena_resul:= cadena_in;
    if lon_cadena > 0 then
      /* Busco LA COMILLA */
      pos := 0;
      posicion_ant := 0;
      sustituto := '''''';
      loop
        dbms_output.put_line ('Entro en el LOOP de procesa_condicion_lookup. La cadena es: ' || cadena_resul);
        pos := instr(cadena_resul, '''', pos+1);
        exit when pos = 0;
        dbms_output.put_line ('Pos es mayor que 0');
        dbms_output.put_line ('Primer valor de Pos: ' || pos);
        cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
        dbms_output.put_line ('La cabeza es: ' || cabeza);
        dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
        cola := substr(cadena_resul, pos + length (''''));
        dbms_output.put_line ('La cola es: ' || cola);
        cadena_resul := cabeza || sustituto || cola;
        pos_ant := pos + length ('''''');
        pos := pos_ant;
      end loop;
      /* Sustituyo el nombre de Tabla generico por el nombre que le paso como parametro */
      if (v_alias_in is not null) then
        /* Existe un alias que sustituir */
        pos := 0;
        posicion_ant := 0;
        sustituto := v_alias_in;
        loop
          dbms_output.put_line ('Entro en el LOOP de procesa_condicion_lookup para sustituir el ALIAS. La cadena es: ' || cadena_resul);
          pos := instr(cadena_resul, '#TABLE_OWNER#', pos+1);
          exit when pos = 0;
          dbms_output.put_line ('Pos es mayor que 0');
          dbms_output.put_line ('Primer valor de Pos: ' || pos);
          cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
          dbms_output.put_line ('La cabeza es: ' || cabeza);
          dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
          cola := substr(cadena_resul, pos + length ('#TABLE_OWNER#'));
          dbms_output.put_line ('La cola es: ' || cola);
          cadena_resul := cabeza || sustituto || cola;
          --pos_ant := pos + length ('''''');
          --pos := pos_ant;
        end loop;

      end if;
    end if;
    
    return cadena_resul;
  end;


  function procesa_condicion_lookup (cadena_in in varchar2, v_alias_in varchar2 := NULL, v_indicador BOOLEAN) return varchar2
  is
  lon_cadena integer;
  cabeza                varchar2 (1000);
  sustituto              varchar2(100);
  cola                      varchar2(1000);    
  pos                   PLS_integer;
  pos_ant           PLS_integer;
  posicion_ant           PLS_integer;
  cadena_resul varchar(1000);
  begin
    dbms_output.put_line ('Entro en procesa_condicion_lookup');
    lon_cadena := length (cadena_in);
    pos := 0;
    posicion_ant := 0;
    cadena_resul:= cadena_in;
    if lon_cadena > 0 then
      if (v_indicador = TRUE) then
        /* Busco el signo = */
        sustituto := ' (+)= ';
        loop
          dbms_output.put_line ('Entro en el LOOP de procesa_condicion_lookup. La cadena es: ' || cadena_resul);
          pos := instr(cadena_resul, '=', pos+1);
          exit when pos = 0;
          dbms_output.put_line ('Pos es mayor que 0');
          dbms_output.put_line ('Primer valor de Pos: ' || pos);
          cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
          dbms_output.put_line ('La cabeza es: ' || cabeza);
          dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
          cola := substr(cadena_resul, pos + length ('='));
          dbms_output.put_line ('La cola es: ' || cola);
          cadena_resul := cabeza || sustituto || cola;
          pos_ant := pos + (length (' (+)= '));
          dbms_output.put_line ('La posicion anterior es: ' || pos_ant);
          pos := pos_ant;
        end loop;
      end if;
      /* Sustituyo el nombre de Tabla generico por el nombre que le paso como parametro */
      if (v_alias_in is not null) then
        /* Existe un alias que sustituir */
        pos := 0;
        posicion_ant := 0;
        sustituto := v_alias_in;
        loop
          dbms_output.put_line ('Entro en el LOOP de procesa_condicion_lookup para sustituir el ALIAS. La cadena es: ' || cadena_resul);
          pos := instr(cadena_resul, '#TABLE_OWNER#', pos+1);
          exit when pos = 0;
          dbms_output.put_line ('Pos es mayor que 0');
          dbms_output.put_line ('Primer valor de Pos: ' || pos);
          cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
          dbms_output.put_line ('La cabeza es: ' || cabeza);
          dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
          cola := substr(cadena_resul, pos + length ('#TABLE_OWNER#'));
          dbms_output.put_line ('La cola es: ' || cola);
          cadena_resul := cabeza || sustituto || cola;
          --pos_ant := pos + length ('''''');
          --pos := pos_ant;
        end loop;
        pos := 0;
        posicion_ant := 0;
        sustituto := v_alias_in;
        loop
          dbms_output.put_line ('Entro en el LOOP de procesa_condicion_lookup para sustituir el ALIAS. La cadena es: ' || cadena_resul);
          pos := instr(cadena_resul, '#OWNER_1#', pos+1);
          exit when pos = 0;
          dbms_output.put_line ('Pos es mayor que 0');
          dbms_output.put_line ('Primer valor de Pos: ' || pos);
          cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
          dbms_output.put_line ('La cabeza es: ' || cabeza);
          dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
          cola := substr(cadena_resul, pos + length ('#OWNER_1#'));
          dbms_output.put_line ('La cola es: ' || cola);
          cadena_resul := cabeza || sustituto || cola;
          --pos_ant := pos + length ('''''');
          --pos := pos_ant;
        end loop;

      end if;
    end if;
    
    return cadena_resul;
  end;

  function procesa_campo_filter (cadena_in in varchar2) return varchar2
  is
    lon_cadena integer;
    cabeza                varchar2 (2000);
    sustituto              varchar2(100);
    cola                      varchar2(2000);    
    pos                   PLS_integer;
    pos_ant           PLS_integer;
    posicion_ant           PLS_integer;
    cadena_resul varchar(2000);
    begin
      lon_cadena := length (cadena_in);
      pos := 0;
      posicion_ant := 0;
      cadena_resul:= cadena_in;
      if lon_cadena > 0 then
        /* Busco VAR_FCH_CARGA */
        sustituto := ' to_date ( fch_datos_in, ''yyyymmdd'') ';
        loop
          dbms_output.put_line ('Entro en el LOOP. La cedena es: ' || cadena_resul);
          pos := instr(cadena_resul, 'VAR_FCH_CARGA', pos+1);
          exit when pos = 0;
          dbms_output.put_line ('Pos es mayor que 0');
          dbms_output.put_line ('Primer valor de Pos: ' || pos);
          cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
          dbms_output.put_line ('La cabeza es: ' || cabeza);
          dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
          cola := substr(cadena_resul, pos + length ('VAR_FCH_CARGA'));
          dbms_output.put_line ('La cola es: ' || cola);
          cadena_resul := cabeza || sustituto || cola;
          --pos_ant := pos + length (' to_date ( fch_datos_in, ''yyyymmdd'') ');
          --pos := pos_ant;
        end loop;
        /* Busco VAR_PROFUNDIDAD_BAJAS */
        sustituto := ' 90 ';  /* Temporalmente pongo 90 dias */
        pos := 0;
        loop
          dbms_output.put_line ('Entro en el LOOP de VAR_PROFUNDIDAD_BAJAS. La cadena es: ' || cadena_resul);
          pos := instr(cadena_resul, 'VAR_PROFUNDIDAD_BAJAS', pos+1);
          exit when pos = 0;
          dbms_output.put_line ('Pos es mayor que 0');
          dbms_output.put_line ('Primer valor de Pos: ' || pos);
          cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
          dbms_output.put_line ('La cabeza es: ' || cabeza);
          dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
          cola := substr(cadena_resul, pos + length ('VAR_PROFUNDIDAD_BAJAS'));
          dbms_output.put_line ('La cola es: ' || cola);
          cadena_resul := cabeza || sustituto || cola;
        end loop;
        /* Busco OWNER_DM */
        sustituto := OWNER_DM;
        pos := 0;
        loop
          dbms_output.put_line ('Entro en el LOOP de OWNER_DM. La cadena es: ' || cadena_resul);
          pos := instr(cadena_resul, '#OWNER_DM#', pos+1);
          exit when pos = 0;
          dbms_output.put_line ('Pos es mayor que 0');
          dbms_output.put_line ('Primer valor de Pos: ' || pos);
          cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
          dbms_output.put_line ('La cabeza es: ' || cabeza);
          dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
          cola := substr(cadena_resul, pos + length ('#OWNER_DM#'));
          dbms_output.put_line ('La cola es: ' || cola);
          cadena_resul := cabeza || sustituto || cola;
        end loop;
        /* Busco OWNER_SA */
        sustituto := OWNER_SA; 
        pos := 0;
        loop
          dbms_output.put_line ('Entro en el LOOP de OWNER_DM. La cadena es: ' || cadena_resul);
          pos := instr(cadena_resul, '#OWNER_SA#', pos+1);
          exit when pos = 0;
          dbms_output.put_line ('Pos es mayor que 0');
          dbms_output.put_line ('Primer valor de Pos: ' || pos);
          cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
          dbms_output.put_line ('La cabeza es: ' || cabeza);
          dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
          cola := substr(cadena_resul, pos + length ('#OWNER_SA#'));
          dbms_output.put_line ('La cola es: ' || cola);
          cadena_resul := cabeza || sustituto || cola;
        end loop;
        /* Busco OWNER_T */
        sustituto := OWNER_T; 
        pos := 0;
        loop
          dbms_output.put_line ('Entro en el LOOP de OWNER_DM. La cadena es: ' || cadena_resul);
          pos := instr(cadena_resul, '#OWNER_T#', pos+1);
          exit when pos = 0;
          dbms_output.put_line ('Pos es mayor que 0');
          dbms_output.put_line ('Primer valor de Pos: ' || pos);
          cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
          dbms_output.put_line ('La cabeza es: ' || cabeza);
          dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
          cola := substr(cadena_resul, pos + length ('#OWNER_T#'));
          dbms_output.put_line ('La cola es: ' || cola);
          cadena_resul := cabeza || sustituto || cola;
        end loop;
        /* Busco OWNER_MTDT */
        sustituto := OWNER_MTDT; 
        pos := 0;
        loop
          dbms_output.put_line ('Entro en el LOOP de OWNER_DM. La cadena es: ' || cadena_resul);
          pos := instr(cadena_resul, '#OWNER_MTDT#', pos+1);
          exit when pos = 0;
          dbms_output.put_line ('Pos es mayor que 0');
          dbms_output.put_line ('Primer valor de Pos: ' || pos);
          cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
          dbms_output.put_line ('La cabeza es: ' || cabeza);
          dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
          cola := substr(cadena_resul, pos + length ('#OWNER_MTDT#'));
          dbms_output.put_line ('La cola es: ' || cola);
          cadena_resul := cabeza || sustituto || cola;
        end loop;
        /* Busco OWNER_1 */
        sustituto := OWNER_1; 
        pos := 0;
        loop
          dbms_output.put_line ('Entro en el LOOP de OWNER_DM. La cadena es: ' || cadena_resul);
          pos := instr(cadena_resul, '#OWNER_1#', pos+1);
          exit when pos = 0;
          dbms_output.put_line ('Pos es mayor que 0');
          dbms_output.put_line ('Primer valor de Pos: ' || pos);
          cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
          dbms_output.put_line ('La cabeza es: ' || cabeza);
          dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
          cola := substr(cadena_resul, pos + length ('#OWNER_1#'));
          dbms_output.put_line ('La cola es: ' || cola);
          cadena_resul := cabeza || sustituto || cola;
        end loop;        
        /* Busco OWNER_2 */
        sustituto := OWNER_2; 
        pos := 0;
        loop
          dbms_output.put_line ('Entro en el LOOP de OWNER_DM. La cadena es: ' || cadena_resul);
          pos := instr(cadena_resul, '#OWNER_2#', pos+1);
          exit when pos = 0;
          dbms_output.put_line ('Pos es mayor que 0');
          dbms_output.put_line ('Primer valor de Pos: ' || pos);
          cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
          dbms_output.put_line ('La cabeza es: ' || cabeza);
          dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
          cola := substr(cadena_resul, pos + length ('#OWNER_2#'));
          dbms_output.put_line ('La cola es: ' || cola);
          cadena_resul := cabeza || sustituto || cola;
        end loop;        
        /* Busco OWNER_3 */
        sustituto := OWNER_3; 
        pos := 0;
        loop
          dbms_output.put_line ('Entro en el LOOP de OWNER_DM. La cadena es: ' || cadena_resul);
          pos := instr(cadena_resul, '#OWNER_3#', pos+1);
          exit when pos = 0;
          dbms_output.put_line ('Pos es mayor que 0');
          dbms_output.put_line ('Primer valor de Pos: ' || pos);
          cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
          dbms_output.put_line ('La cabeza es: ' || cabeza);
          dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
          cola := substr(cadena_resul, pos + length ('#OWNER_3#'));
          dbms_output.put_line ('La cola es: ' || cola);
          cadena_resul := cabeza || sustituto || cola;
        end loop;        
        /* Busco OWNER_4 */
        sustituto := OWNER_4; 
        pos := 0;
        loop
          dbms_output.put_line ('Entro en el LOOP de OWNER_DM. La cadena es: ' || cadena_resul);
          pos := instr(cadena_resul, '#OWNER_4#', pos+1);
          exit when pos = 0;
          dbms_output.put_line ('Pos es mayor que 0');
          dbms_output.put_line ('Primer valor de Pos: ' || pos);
          cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
          dbms_output.put_line ('La cabeza es: ' || cabeza);
          dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
          cola := substr(cadena_resul, pos + length ('#OWNER_4#'));
          dbms_output.put_line ('La cola es: ' || cola);
          cadena_resul := cabeza || sustituto || cola;
        end loop;
        /* Busco [YYYYMM] */
        sustituto := '&' || '2'; 
        pos := 0;
        loop
          dbms_output.put_line ('Entro en el LOOP de OWNER_DM. La cadena es: ' || cadena_resul);
          pos := instr(cadena_resul, '[YYYYMM]', pos+1);
          exit when pos = 0;
          dbms_output.put_line ('Pos es mayor que 0');
          dbms_output.put_line ('Primer valor de Pos: ' || pos);
          cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
          dbms_output.put_line ('La cabeza es: ' || cabeza);
          dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
          cola := substr(cadena_resul, pos + length ('[YYYYMM]'));
          dbms_output.put_line ('La cola es: ' || cola);
          cadena_resul := cabeza || sustituto || cola;
        end loop;                
        /* Busco #FCH_INI# */
        pos := 0;
        if (instr(cadena_resul, '#FCH_INI#', pos+1) > 0) then
          /* Ocurre que el fichero sql que estamos generando tiene parametros de fecha */
          /* inicial y final de extraccion */
          v_fecha_ini_param := true;
          if (v_tabla_dinamica = true) then
            /* Si tb existen tablas dinamicas entonces el parametro sera el 3 */
            sustituto := '&' || '3';
          else
            /* si no el 2 */
            sustituto := '&' || '2';
          end if;
          loop
            dbms_output.put_line ('Entro en el LOOP de OWNER_DM. La cadena es: ' || cadena_resul);
            pos := instr(cadena_resul, '#FCH_INI#', pos+1);
            exit when pos = 0;
            dbms_output.put_line ('Pos es mayor que 0');
            dbms_output.put_line ('Primer valor de Pos: ' || pos);
            cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
            dbms_output.put_line ('La cabeza es: ' || cabeza);
            dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
            cola := substr(cadena_resul, pos + length ('#FCH_INI#'));
            dbms_output.put_line ('La cola es: ' || cola);
            cadena_resul := cabeza || sustituto || cola;
          end loop;
        end if;
        /* Busco #FCH_FIN# */
        pos := 0;
        if (instr(cadena_resul, '#FCH_FIN#', pos+1) > 0) then
          /* Ocurre que el fichero sql que estamos generando tiene parametros de fecha */
          /* inicial y final de extraccion */
          v_fecha_fin_param := true;
          if (v_tabla_dinamica = true) then
            /* Si tb existen tablas dinamicas entonces el parametro sera el 3 */
            sustituto := '&' || '4';
          else
            /* si no el 2 */
            sustituto := '&' || '3';
          end if;
          loop
            dbms_output.put_line ('Entro en el LOOP de OWNER_DM. La cadena es: ' || cadena_resul);
            pos := instr(cadena_resul, '#FCH_FIN#', pos+1);
            exit when pos = 0;
            dbms_output.put_line ('Pos es mayor que 0');
            dbms_output.put_line ('Primer valor de Pos: ' || pos);
            cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
            dbms_output.put_line ('La cabeza es: ' || cabeza);
            dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
            cola := substr(cadena_resul, pos + length ('#FCH_FIN#'));
            dbms_output.put_line ('La cola es: ' || cola);
            cadena_resul := cabeza || sustituto || cola;
          end loop;
        end if;
        
      end if;
      return cadena_resul;
    end;
/************/
/*************/
  function procesa_campo_filter_dinam (cadena_in in varchar2) return varchar2
  is
    lon_cadena integer;
    cabeza                varchar2 (1000);
    sustituto              varchar2(100);
    cola                      varchar2(1000);    
    pos                   PLS_integer;
    pos_ant           PLS_integer;
    posicion_ant           PLS_integer;
    cadena_resul varchar(1000);
    begin
      lon_cadena := length (cadena_in);
      pos := 0;
      posicion_ant := 0;
      cadena_resul:= cadena_in;
      if lon_cadena > 0 then
        /* Busco VAR_FCH_CARGA */
        sustituto := ' to_date ('''' ||  fch_datos_in || '''', ''yyyymmdd'') ';
        loop
          dbms_output.put_line ('Entro en el LOOP. La cedena es: ' || cadena_resul);
          pos := instr(cadena_resul, 'VAR_FCH_CARGA', pos+1);
          exit when pos = 0;
          dbms_output.put_line ('Pos es mayor que 0');
          dbms_output.put_line ('Primer valor de Pos: ' || pos);
          cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
          dbms_output.put_line ('La cabeza es: ' || cabeza);
          dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
          cola := substr(cadena_resul, pos + length ('VAR_FCH_CARGA'));
          dbms_output.put_line ('La cola es: ' || cola);
          cadena_resul := cabeza || sustituto || cola;
          --pos_ant := pos + length (' to_date ( fch_datos_in, ''yyyymmdd'') ');
          --pos := pos_ant;
        end loop;
        /* Busco VAR_PROFUNDIDAD_BAJAS */
        sustituto := ' 90 ';  /* Temporalmente pongo 90 dias */
        pos := 0;
        loop
          dbms_output.put_line ('Entro en el LOOP de VAR_PROFUNDIDAD_BAJAS. La cadena es: ' || cadena_resul);
          pos := instr(cadena_resul, 'VAR_PROFUNDIDAD_BAJAS', pos+1);
          exit when pos = 0;
          dbms_output.put_line ('Pos es mayor que 0');
          dbms_output.put_line ('Primer valor de Pos: ' || pos);
          cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
          dbms_output.put_line ('La cabeza es: ' || cabeza);
          dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
          cola := substr(cadena_resul, pos + length ('VAR_PROFUNDIDAD_BAJAS'));
          dbms_output.put_line ('La cola es: ' || cola);
          cadena_resul := cabeza || sustituto || cola;
        end loop;
        /* Busco OWNER_DM */
        sustituto := OWNER_DM;
        pos := 0;
        loop
          dbms_output.put_line ('Entro en el LOOP de OWNER_DM. La cadena es: ' || cadena_resul);
          pos := instr(cadena_resul, '#OWNER_DM#', pos+1);
          exit when pos = 0;
          dbms_output.put_line ('Pos es mayor que 0');
          dbms_output.put_line ('Primer valor de Pos: ' || pos);
          cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
          dbms_output.put_line ('La cabeza es: ' || cabeza);
          dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
          cola := substr(cadena_resul, pos + length ('#OWNER_DM#'));
          dbms_output.put_line ('La cola es: ' || cola);
          cadena_resul := cabeza || sustituto || cola;
        end loop;
        /* Busco OWNER_SA */
        sustituto := OWNER_SA; 
        pos := 0;
        loop
          dbms_output.put_line ('Entro en el LOOP de OWNER_DM. La cadena es: ' || cadena_resul);
          pos := instr(cadena_resul, '#OWNER_SA#', pos+1);
          exit when pos = 0;
          dbms_output.put_line ('Pos es mayor que 0');
          dbms_output.put_line ('Primer valor de Pos: ' || pos);
          cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
          dbms_output.put_line ('La cabeza es: ' || cabeza);
          dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
          cola := substr(cadena_resul, pos + length ('#OWNER_SA#'));
          dbms_output.put_line ('La cola es: ' || cola);
          cadena_resul := cabeza || sustituto || cola;
        end loop;
        /* Busco OWNER_T */
        sustituto := OWNER_T; 
        pos := 0;
        loop
          dbms_output.put_line ('Entro en el LOOP de OWNER_DM. La cadena es: ' || cadena_resul);
          pos := instr(cadena_resul, '#OWNER_T#', pos+1);
          exit when pos = 0;
          dbms_output.put_line ('Pos es mayor que 0');
          dbms_output.put_line ('Primer valor de Pos: ' || pos);
          cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
          dbms_output.put_line ('La cabeza es: ' || cabeza);
          dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
          cola := substr(cadena_resul, pos + length ('#OWNER_T#'));
          dbms_output.put_line ('La cola es: ' || cola);
          cadena_resul := cabeza || sustituto || cola;
        end loop;
        /* Busco OWNER_MTDT */
        sustituto := OWNER_MTDT; 
        pos := 0;
        loop
          dbms_output.put_line ('Entro en el LOOP de OWNER_DM. La cadena es: ' || cadena_resul);
          pos := instr(cadena_resul, '#OWNER_MTDT#', pos+1);
          exit when pos = 0;
          dbms_output.put_line ('Pos es mayor que 0');
          dbms_output.put_line ('Primer valor de Pos: ' || pos);
          cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
          dbms_output.put_line ('La cabeza es: ' || cabeza);
          dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
          cola := substr(cadena_resul, pos + length ('#OWNER_MTDT#'));
          dbms_output.put_line ('La cola es: ' || cola);
          cadena_resul := cabeza || sustituto || cola;
        end loop;
        /* (20150914) Angel Ruiz. BUG. Cuando se incluye un FILTER en la tabla con una condicion */
        /* que tenia comillas, las comillas aparecian como simple y no funcionaba */
        /* Busco LA COMILLA */
        pos := 0;
        posicion_ant := 0;
        sustituto := '''''';
        loop
          dbms_output.put_line ('Entro en el LOOP de procesa_condicion_lookup. La cadena es: ' || cadena_resul);
          pos := instr(cadena_resul, '''', pos+1);
          exit when pos = 0;
          dbms_output.put_line ('Pos es mayor que 0');
          dbms_output.put_line ('Primer valor de Pos: ' || pos);
          cabeza := substr(cadena_resul, (posicion_ant + 1), (pos - posicion_ant - 1));
          dbms_output.put_line ('La cabeza es: ' || cabeza);
          dbms_output.put_line ('La  sustitutoria es: ' || sustituto);
          cola := substr(cadena_resul, pos + length (''''));
          dbms_output.put_line ('La cola es: ' || cola);
          cadena_resul := cabeza || sustituto || cola;
          pos_ant := pos + length ('''''');
          pos := pos_ant;
        end loop;
        /* (20150914) Angel Ruiz. FIN BUG. Cuando se incluye un FILTER en la tabla con una condicion */
        /* que tenia comillas, las comillas aparecian como simple y no funcionaba */
      end if;
      return cadena_resul;
    end;

/************/

  function genera_campo_select ( reg_detalle_in in MTDT_TC_DETAIL%rowtype) return VARCHAR2 is
    valor_retorno VARCHAR (1000);
    posicion          PLS_INTEGER;
    cad_pri           VARCHAR(500);
    cad_seg         VARCHAR(500);
    cadena            VARCHAR(200);
    pos_del_si      NUMBER(3);
    pos_del_then  NUMBER(3);
    pos_del_else  NUMBER(3);
    pos_del_end   NUMBER(3);
    condicion         VARCHAR2(200);
    condicion_pro         VARCHAR2(200);
    constante         VARCHAR2(100);
    posicion_ant    PLS_integer;
    pos                    PLS_integer;
    cadena_resul  VARCHAR(500);
    sustituto           VARCHAR(30);
    lon_cadena     PLS_integer;
    cabeza             VARCHAR2(500);
    cola                   VARCHAR2(500);
    pos_ant            PLS_integer;
    v_encontrado  VARCHAR2(1);
    v_alias             VARCHAR2(1000);
    table_columns_lkup  list_strings := list_strings();
    ie_column_lkup    list_strings := list_strings();
    tipo_columna  VARCHAR2(30);
    mitabla_look_up VARCHAR2(2000);
    l_registro          ALL_TAB_COLUMNS%rowtype;
    v_value VARCHAR(200);
    nombre_campo  VARCHAR2(30);
    v_table_base_name varchar2(100);
    v_alias_table_base_name varchar2(100);
    v_table_look_up varchar2(1000);
    v_alias_table_look_up varchar2(1000);
    v_temporal varchar2(500);
  begin
    /* Seleccionamos el escenario primero */
      dbms_output.put_line('ESTOY EN EL genera_campo_select. Columna: ' || reg_detalle_in.TABLE_NAME || '.' || reg_detalle_in.TABLE_COLUMN);
      dbms_output.put_line('ESTOY EN EL genera_campo_select. Regla: ' || reg_detalle_in.RUL);
      dbms_output.put_line('ESTOY EN EL genera_campo_select. Tabla LookUp: ' || reg_detalle_in.TABLE_LKUP);
      case reg_detalle_in.RUL
      when 'KEEP' then
        /* Se mantienen el valor del campo de la tabla que estamos cargando */
        valor_retorno :=  reg_detalle_in.TABLE_NAME || '.' || reg_detalle_in.TABLE_COLUMN;
      when 'LKUPC' then
        /* (20160329) Angel Ruiz. Detectamos si TBLA_BASE_NAME posee ALIAS */
        if (REGEXP_LIKE(trim(reg_detalle_in.TABLE_BASE_NAME), '^[a-zA-Z_0-9]+ +[a-zA-Z_0-9]+$') = true) then
          v_alias_table_base_name := trim(REGEXP_SUBSTR(TRIM(reg_detalle_in.TABLE_BASE_NAME), ' +[a-zA-Z_0-9]+$'));
          v_table_base_name := trim(REGEXP_SUBSTR(TRIM(reg_detalle_in.TABLE_BASE_NAME), '^+[a-zA-Z_0-9]+ '));
        else
          v_alias_table_base_name := reg_detalle_in.TABLE_BASE_NAME;
          v_table_base_name := reg_detalle_in.TABLE_BASE_NAME;
        end if;
        /* (20150626) Angel Ruiz.  Se trata de hacer el LOOK UP con la tabla dimension de manera condicional */
        l_FROM.extend;
        if (instr (reg_detalle_in.TABLE_LKUP,'SELECT ') > 0 or instr (reg_detalle_in.TABLE_LKUP,'select ') > 0) then
          /* Aparecen queries en lugar de tablas en la columna de nombre de tabla para LookUp */
          /* Me quedo con el Alias que aparece en la SELECT*/
          --if (REGEXP_LIKE(reg_detalle_in.TABLE_LKUP, '^ *\( *SELECT[a-z A-Z\*=.,_\'']*\) *[a-zA-Z_]+$') = true) then
            /* La subquery efectivamente encaja con el patron esperado para una subquery */
            v_alias_table_look_up := trim(substr(REGEXP_SUBSTR (reg_detalle_in.TABLE_LKUP, '\) *[a-zA-Z_0-9]+$'), 2));
            v_alias := v_alias_table_look_up;
            mitabla_look_up := reg_detalle_in.TABLE_LKUP;
          --else
            --v_alias := 'LKUP_' || l_FROM.count;
            --mitabla_look_up := '(' || reg_detalle_in.TABLE_LKUP || ') "LKUP_' || l_FROM.count || '"';
          --end if;
          l_FROM (l_FROM.last) := ', ' || mitabla_look_up;
        else
          if (REGEXP_LIKE(trim(reg_detalle_in.TABLE_LKUP), '^[a-zA-Z_0-9\.]+ +[a-zA-Z_0-9]+$') = true) then
            v_alias_table_look_up := trim(REGEXP_SUBSTR(TRIM(reg_detalle_in.TABLE_LKUP), ' +[a-zA-Z_0-9]+$'));
            v_table_look_up := trim(REGEXP_SUBSTR(TRIM(reg_detalle_in.TABLE_LKUP), '^+[a-zA-Z_0-9\.]+ '));
          else
            v_alias_table_look_up := reg_detalle_in.TABLE_LKUP;
            v_table_look_up := reg_detalle_in.TABLE_LKUP;
          end if;
          mitabla_look_up := reg_detalle_in.TABLE_LKUP;
          /* (20150112) Angel Ruiz */
          /* Puede ocurrir que se se tenga varias veces la misma LookUp pero para campo diferentes */
          /* lo que se traduce en que hay que crear ALIAS */
          /* BUSCAMOS SI YA ESTABA LA TABLA INCLUIDA EN EL FROM*/
          v_encontrado:='N';
          FOR indx IN l_FROM.FIRST .. l_FROM.LAST
          LOOP
            --if (instr(l_FROM(indx),  reg_detalle_in.TABLE_LKUP, 0)) then
            --regexp_count(reg_per_val.AGREGATION,'^BAN_',1,'i') >0
            if (regexp_count(l_FROM(indx), reg_detalle_in.TABLE_LKUP) >0) then
            --if (l_FROM(indx) = ', ' || OWNER_DM || '.' || reg_detalle_in.TABLE_LKUP) then
              /* La misma tabla ya estaba en otro lookup */
              v_encontrado:='Y';
            end if;
          END LOOP;
          if (v_encontrado='Y') then
            v_alias := reg_detalle_in.TABLE_LKUP || '_' || l_FROM.count;
            l_FROM (l_FROM.last) := ', ' || OWNER_DM || '.' || reg_detalle_in.TABLE_LKUP || ' "' || v_alias || '"' ;
          else
            --v_alias := reg_detalle_in.TABLE_LKUP;
            v_alias := v_alias_table_look_up;
            l_FROM (l_FROM.last) := ', ' || OWNER_DM || '.' || reg_detalle_in.TABLE_LKUP;
          end if;
        end if;
        /* Miramos la parte de las condiciones */
        /* Puede haber varios campos por los que hacer LookUp y por lo tanto JOIN */
        table_columns_lkup := split_string_coma (reg_detalle_in.TABLE_COLUMN_LKUP);
        ie_column_lkup := split_string_coma (reg_detalle_in.IE_COLUMN_LKUP);

        /****************************************************************************/
        /* CONTRUIMOS EL CAMPO PARA LA PARTE DEL SELECT */
        /****************************************************************************/
        
        valor_retorno :=  proc_campo_value_condicion (reg_detalle_in.LKUP_COM_RULE, 'NVL(' || reg_detalle_in.VALUE || ', '' '')');
        /****************************************************************************/
        /* CONTRUIMOS EL CAMPO PARA LA PARTE DEL WHERE */
        /****************************************************************************/
        
        if (table_columns_lkup.COUNT > 1) then      /* Hay varios campos de condicion */
          FOR indx IN table_columns_lkup.FIRST .. table_columns_lkup.LAST
          LOOP
            l_WHERE.extend;
            /* (20150126) Angel Ruiz. Incidencia referente a que siempre se coloca el valor -2 */
            /* Recojo el tipo de dato del campo con el que se va a hacer LookUp */
            dbms_output.put_line('ESTOY EN EL LOOKUP. Este LoopUp es de varias columnas. La Tabla es: ' || reg_detalle_in.TABLE_BASE_NAME);
            dbms_output.put_line('ESTOY EN EL LOOKUP. Este LoopUp es de varias columnas. La Columna es: ' || ie_column_lkup(indx));
            
            if (l_WHERE.count = 1) then
              --l_WHERE(l_WHERE.last) :=  'NVL(' || reg_detalle_in.TABLE_BASE_NAME || '.' || ie_column_lkup(indx) ||', -3)' ||' = ' || v_alias || '.' || table_columns_lkup(indx) || ' (+)';
              if (reg_detalle_in."OUTER" = 'Y') then
                l_WHERE(l_WHERE.last) :=  v_alias_table_base_name || '.' || ie_column_lkup(indx) || ' = ' || v_alias || '.' || table_columns_lkup(indx) || ' (+)';
              else
                l_WHERE(l_WHERE.last) :=  v_alias_table_base_name || '.' || ie_column_lkup(indx) || ' = ' || v_alias || '.' || table_columns_lkup(indx);
              end if;
            else
              --l_WHERE(l_WHERE.last) :=  ' AND NVL(' || reg_detalle_in.TABLE_BASE_NAME || '.' || ie_column_lkup(indx) || ', -3)' || ' = ' || v_alias || '.' || table_columns_lkup(indx) || ' (+)';
              if (reg_detalle_in."OUTER" = 'Y') then
                l_WHERE(l_WHERE.last) :=  ' AND ' || v_alias_table_base_name || '.' || ie_column_lkup(indx) || ' = ' || v_alias || '.' || table_columns_lkup(indx) || ' (+)';
              else
                l_WHERE(l_WHERE.last) :=  ' AND ' || v_alias_table_base_name || '.' || ie_column_lkup(indx) || ' = ' || v_alias || '.' || table_columns_lkup(indx) || ' (+)';
              end if;
            end if;
          END LOOP;
        else    /* Solo hay un campo condicion */
          
          /* Miramos si la tabla con la que hay que hacer LookUp es una tabla de rangos */
          l_WHERE.extend;
          if (instr (reg_detalle_in.TABLE_LKUP,'RANGO') > 0) then
            if (l_WHERE.count = 1) then
              l_WHERE(l_WHERE.last) := v_alias_table_base_name || '.' || reg_detalle_in.IE_COLUMN_LKUP || ' >= ' || v_alias || '.' || reg_detalle_in.TABLE_COLUMN_LKUP || ' (+)';
              l_WHERE.extend;
              l_WHERE(l_WHERE.last) := ' AND ' || v_alias_table_base_name || '.' || reg_detalle_in.IE_COLUMN_LKUP || ' <= ' || v_alias || '.' || 'MAX' || substr(reg_detalle_in.TABLE_COLUMN_LKUP, 4) || ' (+)';
            else
              l_WHERE(l_WHERE.last) := ' AND ' || v_alias_table_base_name || '.' || reg_detalle_in.IE_COLUMN_LKUP || ' >= ' || v_alias || '.'  || reg_detalle_in.TABLE_COLUMN_LKUP || ' (+)';
              l_WHERE.extend;
              l_WHERE(l_WHERE.last) := ' AND ' || v_alias_table_base_name || '.' || reg_detalle_in.IE_COLUMN_LKUP || ' <= ' || v_alias || '.' || 'MAX' || substr(reg_detalle_in.TABLE_COLUMN_LKUP, 4) || ' (+)';
            end if;
          else
            /* (20150126) Angel Ruiz. Incidencia referente a que siempre se coloca el valor -2 */
            /* Recojo el tipo de dato del campo con el que se va a hacer LookUp */
            dbms_output.put_line('ESTOY EN EL LOOKUP. La Tabla es: ' || reg_detalle_in.TABLE_BASE_NAME);
            dbms_output.put_line('ESTOY EN EL LOOKUP. La Columna es: ' || reg_detalle_in.IE_COLUMN_LKUP);
            if (l_WHERE.count = 1) then /* si es el primer campo del WHERE */
                --l_WHERE(l_WHERE.last) := 'NVL(' || reg_detalle_in.TABLE_BASE_NAME || '.' || reg_detalle_in.IE_COLUMN_LKUP || ', -3)' ||  ' = ' || v_alias || '.' || reg_detalle_in.TABLE_COLUMN_LKUP || ' (+)';
                l_WHERE(l_WHERE.last) := v_alias_table_base_name || '.' || reg_detalle_in.IE_COLUMN_LKUP ||  ' = ' || v_alias || '.' || reg_detalle_in.TABLE_COLUMN_LKUP || ' (+)';
            else  /* sino es el primer campo del Where  */
              --l_WHERE(l_WHERE.last) :=  ' AND NVL(' || reg_detalle_in.TABLE_BASE_NAME || '.' || reg_detalle_in.IE_COLUMN_LKUP || ', -3)' || ' = ' || v_alias || '.' || reg_detalle_in.TABLE_COLUMN_LKUP || ' (+)';
              if (reg_detalle_in."OUTER" = 'Y') then
                l_WHERE(l_WHERE.last) :=  ' AND ' || v_alias_table_base_name || '.' || reg_detalle_in.IE_COLUMN_LKUP || ' = ' || v_alias || '.' || reg_detalle_in.TABLE_COLUMN_LKUP || ' (+)';
              else
                l_WHERE(l_WHERE.last) :=  ' AND ' || v_alias_table_base_name || '.' || reg_detalle_in.IE_COLUMN_LKUP || ' = ' || v_alias || '.' || reg_detalle_in.TABLE_COLUMN_LKUP;
              end if;
            end if;
          end if;
        end if;
        if (reg_detalle_in.TABLE_LKUP_COND is not null) then
          /* Existen condiciones en la tabla de Look Up que hay que introducir*/
          l_WHERE.extend;
          /* (20160412) Angel Ruiz. BUG: Si la tabla de LookUP es con OUTER entonces */
          /* debemos procesar la condicion para ponerle el signo outer por dentro */
          if (reg_detalle_in.OUTER IS NOT NULL and reg_detalle_in.OUTER='Y') then
            l_WHERE(l_WHERE.last) :=  ' AND ' || procesa_condicion_lookup(reg_detalle_in.TABLE_LKUP_COND, v_alias, TRUE);
          else
            l_WHERE(l_WHERE.last) :=  ' AND ' || procesa_condicion_lookup(reg_detalle_in.TABLE_LKUP_COND, v_alias, FALSE);
          end if;
        end if;
      when 'LKUP' then
        /* Se trata de hacer el LOOK UP con la tabla dimension */
        if (REGEXP_LIKE(trim(reg_detalle_in.TABLE_BASE_NAME), '^[a-zA-Z_0-9#]+\.[a-zA-Z_0-9]+') = true) then
          /* (20160413) Primero detectamos si esta calificada la tabla*/
          /* Si esta calificada hay que sustituir el propietario por un usuario, en caso de ser necesario */
          v_temporal := procesa_campo_filter(trim(reg_detalle_in.TABLE_BASE_NAME));
          if (REGEXP_LIKE(trim(v_temporal), '^[a-zA-Z_0-9#]+\.[a-zA-Z_0-9]+ +[a-zA-Z0-9_]+$') = true) then
            /* (20160329) Angel Ruiz. Detectamos si TABLE_BASE_NAME posee ALIAS */
            v_alias_table_base_name := trim(REGEXP_SUBSTR(TRIM(v_temporal), ' +[a-zA-Z_0-9]+$'));
            v_table_base_name := substr(trim(REGEXP_SUBSTR(TRIM(v_temporal), '\.[a-zA-Z_0-9]+ ')),2);
          else
            v_alias_table_base_name := substr(trim(REGEXP_SUBSTR(TRIM(v_temporal), '\.[a-zA-Z_0-9]+')),2);
            v_table_base_name := substr(trim(REGEXP_SUBSTR(TRIM(v_temporal), '\.[a-zA-Z_0-9]+')),2);
          end if;
        else
          /* La tabla no esta calificada */
          if (REGEXP_LIKE(trim(reg_detalle_in.TABLE_BASE_NAME), '^[a-zA-Z_0-9]+ +[a-zA-Z_0-9]+$') = true) then
            /* (20160329) Angel Ruiz. Detectamos si TABLE_BASE_NAME posee ALIAS */
            v_alias_table_base_name := trim(REGEXP_SUBSTR(TRIM(reg_detalle_in.TABLE_BASE_NAME), ' +[a-zA-Z_0-9]+$'));
            v_table_base_name := trim(REGEXP_SUBSTR(TRIM(reg_detalle_in.TABLE_BASE_NAME), '^+[a-zA-Z_0-9]+ '));
          else
            v_alias_table_base_name := reg_detalle_in.TABLE_BASE_NAME;
            v_table_base_name := reg_detalle_in.TABLE_BASE_NAME;
          end if;
        end if;
        /* (20150126) Angel Ruiz. Primero recojo la tabla del modelo con la que se hace LookUp. NO puede ser tablas T_* sino su equivalesnte del modelo */
        dbms_output.put_line('ESTOY EN EL LOOKUP. Al principio');
        l_FROM.extend;
        /* (20150130) Angel Ruiz */
        /* Nueva incidencia. */
        if (instr (reg_detalle_in.TABLE_LKUP,'SELECT ') > 0 or instr (reg_detalle_in.TABLE_LKUP,'select ') > 0) then
          /* Aparecen queries en lugar de tablas en la columna de nombre de tabla para LookUp */
          /* Me quedo con el Alias que aparece en la SELECT*/
          --if (REGEXP_LIKE(reg_detalle_in.TABLE_LKUP, '^ *\( *SELECT[a-z A-Z\*=.,_\'']*\) *[a-zA-Z_]+$') = true) then
            /* La subquery efectivamente encaja con el patron esperado para una subquery */
            v_alias_table_look_up := trim(substr(REGEXP_SUBSTR (reg_detalle_in.TABLE_LKUP, '\) *[a-zA-Z_0-9]+$'), 2));
            v_alias := v_alias_table_look_up;
            mitabla_look_up := procesa_campo_filter(reg_detalle_in.TABLE_LKUP);
          --else
            --v_alias := 'LKUP_' || l_FROM.count;
            --mitabla_look_up := '(' || reg_detalle_in.TABLE_LKUP || ') "LKUP_' || l_FROM.count || '"';
          --end if;
          l_FROM (l_FROM.last) := ', ' || mitabla_look_up;
        else
          /* (20160401) Detectamos si la tabla de LookUp posee Alias */
          if (REGEXP_LIKE(trim(reg_detalle_in.TABLE_LKUP), '^[a-zA-Z_0-9#\.]+ +[a-zA-Z_0-9]+$') = true) then
            /* La tabla de LKUP posee Alias */
            v_alias_table_look_up := trim(REGEXP_SUBSTR(TRIM(reg_detalle_in.TABLE_LKUP), ' +[a-zA-Z_0-9]+$'));
            v_table_look_up := trim(REGEXP_SUBSTR(TRIM(reg_detalle_in.TABLE_LKUP), '^+[a-zA-Z_0-9\.#]+ '));
            if (REGEXP_LIKE(v_table_look_up, '^[a-zA-Z_0-9#]+\.[a-zA-Z_0-9]+') = true) then
              /* La tabla de LKUP esta calificada */
              v_table_look_up := procesa_campo_filter(v_table_look_up);
            else
              /* La tabla de LKUP no esta calificada, entonces la califico */
              v_table_look_up := OWNER_DM || '.' || v_table_look_up;
            end if;
            mitabla_look_up := v_table_look_up || ' ' || v_alias_table_look_up;
            /* Busco si estaba ya en el FROM. Como es una tabla con ALIAS */
            /* si ya estaba en el FROM entonces no la vuelo a meter ya que tiene un ALIAS */
            v_encontrado:='N';
            FOR indx IN l_FROM.FIRST .. l_FROM.LAST
            LOOP
              --if (regexp_count(l_FROM(indx), reg_detalle_in.TABLE_LKUP) >0) then
              if (regexp_count(l_FROM(indx), mitabla_look_up) >0) then
              --if (l_FROM(indx) = ', ' || OWNER_DM || '.' || reg_detalle_in.TABLE_LKUP) then
                /* La misma tabla ya estaba en otro lookup */
                v_encontrado:='Y';
              end if;
            END LOOP;
            if (v_encontrado='N') then
              /* Solo la introduzco si la tabla no estaba ya */
              --l_FROM (l_FROM.last) := ', ' || procesa_campo_filter(reg_detalle_in.TABLE_LKUP);
              l_FROM (l_FROM.last) := ', ' || mitabla_look_up;
            end if;
            v_alias := v_alias_table_look_up;
          else    /* La tabla de LKUP no posee Alias */
            v_table_look_up := reg_detalle_in.TABLE_LKUP;
            if (REGEXP_LIKE(v_table_look_up, '^[a-zA-Z_]+\.[a-zA-Z[0-9]_]+') = true) then
              /* La tabla de LKUP esta calificada */
              v_alias_table_look_up := SUBSTR(REGEXP_SUBSTR(v_table_look_up, '.[a-zA-Z[0-9]_]+'), 2);
              v_table_look_up := procesa_campo_filter(v_table_look_up);
            else
              /* La tabla de LKUP no esta calificada, entonces la califico */
              v_alias_table_look_up := v_table_look_up;
              v_table_look_up := OWNER_DM || '.' || v_table_look_up;
            end if;
            mitabla_look_up := v_table_look_up;
            v_encontrado:='N';
            FOR indx IN l_FROM.FIRST .. l_FROM.LAST
            LOOP
              --if (instr(l_FROM(indx),  reg_detalle_in.TABLE_LKUP, 0)) then
              --regexp_count(reg_per_val.AGREGATION,'^BAN_',1,'i') >0
              --if (regexp_count(l_FROM(indx), reg_detalle_in.TABLE_LKUP) >0) then
              if (regexp_count(l_FROM(indx), mitabla_look_up) >0) then
              --if (l_FROM(indx) = ', ' || OWNER_DM || '.' || reg_detalle_in.TABLE_LKUP) then
                /* La misma tabla ya estaba en otro lookup */
                v_encontrado:='Y';
              end if;
            END LOOP;
            if (v_encontrado='Y') then
              v_alias := reg_detalle_in.TABLE_LKUP || '_' || l_FROM.count;
              --l_FROM (l_FROM.last) := ', ' || procesa_campo_filter(reg_detalle_in.TABLE_LKUP) || ' "' || v_alias || '"' ;
              l_FROM (l_FROM.last) := ', ' || mitabla_look_up || ' "' || v_alias || '"' ;
            else
              --v_alias := reg_detalle_in.TABLE_LKUP;
              v_alias := v_alias_table_look_up;
              --l_FROM (l_FROM.last) := ', ' || procesa_campo_filter(reg_detalle_in.TABLE_LKUP);
              l_FROM (l_FROM.last) := ', ' || mitabla_look_up;
            end if;
          end if;
          
        end if;

        /* Miramos la parte de las condiciones */
        /* Puede haber varios campos por los que hacer LookUp y por lo tanto JOIN */
        /* (20160302) Angel Ruiz. NF: Campos separados por ; */
        --table_columns_lkup := split_string_coma (reg_detalle_in.TABLE_COLUMN_LKUP);
        --ie_column_lkup := split_string_coma (reg_detalle_in.IE_COLUMN_LKUP);
        table_columns_lkup := split_string_punto_coma (reg_detalle_in.TABLE_COLUMN_LKUP);
        ie_column_lkup := split_string_punto_coma (reg_detalle_in.IE_COLUMN_LKUP);
        
        /****************************************************************************/
        /* CONTRUIMOS EL CAMPO PARA LA PARTE DEL SELECT */
        /****************************************************************************/

        if (reg_detalle_in.LKUP_COM_RULE is not null) then
          /* Ocurre que tenemos una regla compuesta, un LKUP con una condicion */
          cadena := trim(reg_detalle_in.LKUP_COM_RULE);
          pos_del_si := instr(cadena, 'SI');
          pos_del_then := instr(cadena, 'THEN');
          pos_del_else := instr(cadena, 'ELSE');
          pos_del_end := instr(cadena, 'END');  
          condicion := substr(cadena,pos_del_si+length('SI'), pos_del_then-(pos_del_si+length('SI')));
          condicion_pro := procesa_COM_RULE_lookup(condicion);
          constante := substr(cadena, pos_del_else+length('ELSE'),pos_del_end-(pos_del_else+length('ELSE')));
          valor_retorno := 'CASE WHEN ' || trim(condicion_pro) || ' THEN NVL(' || reg_detalle_in.VALUE || ', '' '') ELSE ' || trim(constante) || ' END';
        else
          /* Construyo el campo de SELECT */
          --valor_retorno :=  'NVL(' || reg_detalle_in.VALUE || ', '' '')';
          valor_retorno :=  reg_detalle_in.VALUE;
        end if;
        
        /****************************************************************************/
        /* CONTRUIMOS EL CAMPO PARA LA PARTE DEL WHERE */
        /****************************************************************************/
        
        if (table_columns_lkup.COUNT > 1) then      /* Hay varios campos de condicion */
          FOR indx IN table_columns_lkup.FIRST .. table_columns_lkup.LAST
          LOOP
            l_WHERE.extend;
            /* (20150126) Angel Ruiz. Incidencia referente a que siempre se coloca el valor -2 */
            /* Recojo el tipo de dato del campo con el que se va a hacer LookUp */
            dbms_output.put_line('ESTOY EN EL LOOKUP. Este LoopUp es de varias columnas. La Tabla es: ' || reg_detalle_in.TABLE_BASE_NAME);
            dbms_output.put_line('ESTOY EN EL LOOKUP. Este LoopUp es de varias columnas. La Columna es: ' || ie_column_lkup(indx));
            
            if (l_WHERE.count = 1) then
              /* (20160302) Angel Ruiz. NF: DECODE en las columnas de LookUp */
              if (instr(ie_column_lkup(indx), 'DECODE') > 0 or instr(ie_column_lkup(indx), 'decode') > 0) then
                if (reg_detalle_in."OUTER" = 'Y') then
                  l_WHERE(l_WHERE.last) := transformo_decode(ie_column_lkup(indx), v_alias_table_base_name, 0) || ' = ' || transformo_decode(table_columns_lkup(indx), v_alias, 1);
                else
                  l_WHERE(l_WHERE.last) := transformo_decode(ie_column_lkup(indx), v_alias_table_base_name, 0) || ' = ' || transformo_decode(table_columns_lkup(indx), v_alias, 0);
                end if;
              elsif (instr(upper(table_columns_lkup(indx)), 'BETWEEN') > 0) then
                if (reg_detalle_in."OUTER" = 'Y') then
                  l_WHERE(l_WHERE.last) :=  v_alias_table_base_name || '.' || ie_column_lkup(indx) || ' ' || transformo_between(v_alias, table_columns_lkup(indx), true);
                else
                  l_WHERE(l_WHERE.last) :=  v_alias_table_base_name || '.' || ie_column_lkup(indx) || ' ' || transformo_between(v_alias, table_columns_lkup(indx), false);
                end if;
              else
                if (reg_detalle_in."OUTER" = 'Y') then
                  l_WHERE(l_WHERE.last) :=  v_alias_table_base_name || '.' || ie_column_lkup(indx) || ' = ' || v_alias || '.' || table_columns_lkup(indx) || ' (+)';
                else
                  l_WHERE(l_WHERE.last) :=  v_alias_table_base_name || '.' || ie_column_lkup(indx) || ' = ' || v_alias || '.' || table_columns_lkup(indx);
                end if;
              end if;
            else  /* siguientes elementos del where */
              if (instr(ie_column_lkup(indx), 'DECODE') > 0 or instr(ie_column_lkup(indx), 'decode') > 0) then
                if (reg_detalle_in."OUTER" = 'Y') then
                  l_WHERE(l_WHERE.last) :=  ' AND ' || transformo_decode(ie_column_lkup(indx), v_alias_table_base_name, 0) || ' = ' || transformo_decode(table_columns_lkup(indx), v_alias, 1);
                else
                  l_WHERE(l_WHERE.last) :=  ' AND ' || transformo_decode(ie_column_lkup(indx), v_alias_table_base_name, 0) || ' = ' || transformo_decode(table_columns_lkup(indx), v_alias, 0);
                end if;
              elsif (instr(upper(table_columns_lkup(indx)), 'BETWEEN') > 0) then
                if (reg_detalle_in."OUTER" = 'Y') then
                  l_WHERE(l_WHERE.last) :=  ' AND ' || v_alias_table_base_name || '.' || ie_column_lkup(indx) || ' ' || transformo_between(v_alias, table_columns_lkup(indx), true);
                else
                  l_WHERE(l_WHERE.last) :=  ' AND ' || v_alias_table_base_name || '.' || ie_column_lkup(indx) || ' ' || transformo_between(v_alias, table_columns_lkup(indx), false);
                end if;
              else
                if (reg_detalle_in."OUTER" = 'Y') then
                  l_WHERE(l_WHERE.last) :=  ' AND ' || v_alias_table_base_name || '.' || ie_column_lkup(indx) || ' = ' || v_alias || '.' || table_columns_lkup(indx) || ' (+)';
                else
                  l_WHERE(l_WHERE.last) :=  ' AND ' || v_alias_table_base_name || '.' || ie_column_lkup(indx) || ' = ' || v_alias || '.' || table_columns_lkup(indx);
                end if;
              end if;
            end if;
          END LOOP;
        else    /* Solo hay un campo condicion */
          /* Miramos si la tabla con la que hay que hacer LookUp es una tabla de rangos */
          l_WHERE.extend;
          if (instr (reg_detalle_in.TABLE_LKUP,'RANGO') > 0) then
            if (l_WHERE.count = 1) then
              l_WHERE(l_WHERE.last) := v_alias_table_base_name || '.' || reg_detalle_in.IE_COLUMN_LKUP || ' >= ' || v_alias || '.' || reg_detalle_in.TABLE_COLUMN_LKUP || ' (+)';
              l_WHERE.extend;
              l_WHERE(l_WHERE.last) := ' AND ' || v_alias_table_base_name || '.' || reg_detalle_in.IE_COLUMN_LKUP || ' <= ' || v_alias || '.' || 'MAX' || substr(reg_detalle_in.TABLE_COLUMN_LKUP, 4) || ' (+)';
            else
              l_WHERE(l_WHERE.last) := ' AND ' || v_alias_table_base_name || '.' || reg_detalle_in.IE_COLUMN_LKUP || ' >= ' || v_alias || '.'  || reg_detalle_in.TABLE_COLUMN_LKUP || ' (+)';
              l_WHERE.extend;
              l_WHERE(l_WHERE.last) := ' AND ' || v_alias_table_base_name || '.' || reg_detalle_in.IE_COLUMN_LKUP || ' <= ' || v_alias || '.' || 'MAX' || substr(reg_detalle_in.TABLE_COLUMN_LKUP, 4) || ' (+)';
            end if;
          else
            /* (20150126) Angel Ruiz. Incidencia referente a que siempre se coloca el valor -2 */
            /* Recojo el tipo de dato del campo con el que se va a hacer LookUp */
            dbms_output.put_line('ESTOY EN EL LOOKUP. La Tabla es: ' || reg_detalle_in.TABLE_BASE_NAME);
            dbms_output.put_line('ESTOY EN EL LOOKUP. La Columna es: ' || reg_detalle_in.IE_COLUMN_LKUP);
            if (l_WHERE.count = 1) then /* si es el primer campo del WHERE */
              --l_WHERE(l_WHERE.last) := 'NVL(' || reg_detalle_in.TABLE_BASE_NAME || '.' || reg_detalle_in.IE_COLUMN_LKUP || ', -3)' ||  ' = ' || v_alias || '.' || reg_detalle_in.TABLE_COLUMN_LKUP || ' (+)';
              if (instr(reg_detalle_in.IE_COLUMN_LKUP, 'DECODE') > 0 or instr(reg_detalle_in.IE_COLUMN_LKUP, 'decode') > 0) then
                if (reg_detalle_in."OUTER" = 'Y') then
                  l_WHERE(l_WHERE.last) :=  transformo_decode(reg_detalle_in.IE_COLUMN_LKUP, v_alias_table_base_name, 0) ||  ' = ' || transformo_decode(reg_detalle_in.TABLE_COLUMN_LKUP, v_alias, 1);
                else
                  l_WHERE(l_WHERE.last) :=  transformo_decode(reg_detalle_in.IE_COLUMN_LKUP, v_alias_table_base_name, 0) ||  ' = ' || transformo_decode(reg_detalle_in.TABLE_COLUMN_LKUP, v_alias, 0);
                end if;
              elsif (instr(upper(reg_detalle_in.TABLE_COLUMN_LKUP), 'BETWEEN') > 0) then
                if (reg_detalle_in."OUTER" = 'Y') then
                  l_WHERE(l_WHERE.last) :=  v_alias_table_base_name || '.' || reg_detalle_in.IE_COLUMN_LKUP || ' ' || transformo_between(v_alias, reg_detalle_in.TABLE_COLUMN_LKUP, true);
                else
                  l_WHERE(l_WHERE.last) :=  v_alias_table_base_name || '.' || reg_detalle_in.IE_COLUMN_LKUP || ' ' || transformo_between(v_alias, reg_detalle_in.TABLE_COLUMN_LKUP, false);
                end if;
              else
                if (reg_detalle_in."OUTER" = 'Y') then
                  l_WHERE(l_WHERE.last) := v_alias_table_base_name || '.' || reg_detalle_in.IE_COLUMN_LKUP ||  ' = ' || v_alias || '.' || reg_detalle_in.TABLE_COLUMN_LKUP || ' (+)';
                else
                  l_WHERE(l_WHERE.last) := v_alias_table_base_name || '.' || reg_detalle_in.IE_COLUMN_LKUP ||  ' = ' || v_alias || '.' || reg_detalle_in.TABLE_COLUMN_LKUP;
                end if;
              end if;
            else  /* sino es el primer campo del Where  */
              --l_WHERE(l_WHERE.last) :=  ' AND NVL(' || reg_detalle_in.TABLE_BASE_NAME || '.' || reg_detalle_in.IE_COLUMN_LKUP || ', -3)' || ' = ' || v_alias || '.' || reg_detalle_in.TABLE_COLUMN_LKUP || ' (+)';
              if (instr(reg_detalle_in.IE_COLUMN_LKUP, 'DECODE') > 0 or instr(reg_detalle_in.IE_COLUMN_LKUP, 'decode') > 0) then
                if (reg_detalle_in."OUTER" = 'Y') then
                  l_WHERE(l_WHERE.last) :=  ' AND ' || transformo_decode(reg_detalle_in.IE_COLUMN_LKUP, v_alias_table_base_name, 0) || ' = ' || transformo_decode(reg_detalle_in.TABLE_COLUMN_LKUP, v_alias, 1);
                else
                  l_WHERE(l_WHERE.last) :=  ' AND ' || transformo_decode(reg_detalle_in.IE_COLUMN_LKUP, v_alias_table_base_name, 0) || ' = ' || transformo_decode(reg_detalle_in.TABLE_COLUMN_LKUP, v_alias, 0);
                end if;
              elsif (instr(upper(reg_detalle_in.TABLE_COLUMN_LKUP), 'BETWEEN') > 0 ) then
                if (reg_detalle_in."OUTER" = 'Y') then
                  l_WHERE(l_WHERE.last) :=  ' AND ' || v_alias_table_base_name || '.' || reg_detalle_in.IE_COLUMN_LKUP || ' ' || transformo_between(v_alias, reg_detalle_in.TABLE_COLUMN_LKUP, true);
                else
                  l_WHERE(l_WHERE.last) :=  ' AND ' || v_alias_table_base_name || '.' || reg_detalle_in.IE_COLUMN_LKUP || ' ' || transformo_between(v_alias, reg_detalle_in.TABLE_COLUMN_LKUP, false);
                end if;
              else
                if (reg_detalle_in."OUTER" = 'Y') then
                  l_WHERE(l_WHERE.last) :=  ' AND ' || v_alias_table_base_name || '.' || reg_detalle_in.IE_COLUMN_LKUP || ' = ' || v_alias || '.' || reg_detalle_in.TABLE_COLUMN_LKUP || ' (+)';
                else
                  l_WHERE(l_WHERE.last) :=  ' AND ' || v_alias_table_base_name || '.' || reg_detalle_in.IE_COLUMN_LKUP || ' = ' || v_alias || '.' || reg_detalle_in.TABLE_COLUMN_LKUP;
                end if;
              end if;
            end if;
          end if;
        end if;
        if (reg_detalle_in.TABLE_LKUP_COND is not null) then
          /* Existen condiciones en la tabla de Look Up que hay que introducir*/
          l_WHERE.extend;
          --l_WHERE(l_WHERE.last) :=  ' AND ' || procesa_condicion_lookup(reg_detalle_in.TABLE_LKUP_COND, v_alias);
          /* (20160412) Angel Ruiz. BUG: Si la tabla de LookUP es con OUTER entonces */
          /* debemos procesar la condicion para ponerle el signo outer por dentro */
          if (reg_detalle_in."OUTER" IS NOT NULL and reg_detalle_in."OUTER" = 'Y') then
            l_WHERE(l_WHERE.last) :=  ' AND ' || procesa_condicion_lookup (reg_detalle_in.TABLE_LKUP_COND, v_alias, TRUE);
          else
            l_WHERE(l_WHERE.last) :=  ' AND ' || procesa_condicion_lookup (reg_detalle_in.TABLE_LKUP_COND, v_alias, FALSE);
          end if;
          
        end if;
      when 'LKUPD' then
        if (reg_detalle_in.LKUP_COM_RULE is not null) then
          /* Ocurre que tenemos una regla compuesta, un LKUP con una condicion */
          cadena := trim(reg_detalle_in.LKUP_COM_RULE);
          pos_del_si := instr(cadena, 'SI');
          pos_del_then := instr(cadena, 'THEN');
          pos_del_else := instr(cadena, 'ELSE');
          pos_del_end := instr(cadena, 'END');  
          condicion := substr(cadena,pos_del_si+length('SI'), pos_del_then-(pos_del_si+length('SI')));
          condicion_pro := procesa_COM_RULE_lookup(condicion);
          constante := substr(cadena, pos_del_else+length('ELSE'),pos_del_end-(pos_del_else+length('ELSE')));
          valor_retorno := 'CASE WHEN ' || trim(condicion_pro) || ' THEN NVL(' || reg_detalle_in.VALUE || ', '' '') ELSE ' || trim(constante) || ' END';
        else
          valor_retorno := reg_detalle_in.VALUE;
        end if;
        
      when 'FUNCTION' then
        /* se trata de la regla FUNCTION */
        if (reg_detalle_in.LKUP_COM_RULE is not null) then
          /* Ocurre que tenemos una regla compuesta, un LKUP con una condicion */
          cadena := trim(reg_detalle_in.LKUP_COM_RULE);
          pos_del_si := instr(cadena, 'SI');
          pos_del_then := instr(cadena, 'THEN');
          pos_del_else := instr(cadena, 'ELSE');
          pos_del_end := instr(cadena, 'END');  
          condicion := substr(cadena,pos_del_si+length('SI'), pos_del_then-(pos_del_si+length('SI')));
          condicion_pro := procesa_COM_RULE_lookup(condicion);
          constante := substr(cadena, pos_del_else+length('ELSE'),pos_del_end-(pos_del_else+length('ELSE')));
          valor_retorno := 'CASE WHEN ' || trim(condicion_pro) || ' THEN NVL(' || v_alias || '.' || reg_detalle_in.VALUE || ', -2) ELSE ' || trim(constante) || ' END';
        else
          valor_retorno := 'PKG_' || reg_detalle_in.TABLE_NAME || '.' || 'LK_' || reg_detalle_in.TABLE_LKUP || ' (' || reg_detalle_in.IE_COLUMN_LKUP || ')';
        end if;
      when 'DLOAD' then
        valor_retorno :=  'TO_DATE (''&' || '2'', ''YYYYMMDD'')';
      when 'DSYS' then
        valor_retorno :=  'SYSDATE';
      when 'CODE' then
        posicion := instr(reg_detalle_in.VALUE, 'VAR_IVA');
        if (posicion >0) then
          cad_pri := substr(reg_detalle_in.VALUE, 1, posicion-1);
          cad_seg := substr(reg_detalle_in.VALUE, posicion + length('VAR_IVA'));
          valor_retorno :=  cad_pri || '21' || cad_seg;
        else
          valor_retorno :=  reg_detalle_in.VALUE;
        end if;
        posicion := instr(valor_retorno, 'VAR_FCH_CARGA');
        if (posicion >0) then
          cad_pri := substr(valor_retorno, 1, posicion-1);
          cad_seg := substr(valor_retorno, posicion + length('VAR_FCH_CARGA'));
          valor_retorno := cad_pri || ' to_date(''&' || '2'', ''yyyymmdd'') ' || cad_seg;
        end if;
      when 'HARDC' then
        /* (20160406) Angel Ruiz. Los campos HARDC no traeran comillas */
        /* Heos de detactar si son caracter para ponerlas */
        if (reg_detalle_in.TYPE <> 'NU') then
          if instr(reg_detalle_in.VALUE, '''') > 0 then
            /* realmente trae comillas con lo que no hay que ponerlas */
            valor_retorno := reg_detalle_in.VALUE;
          else
            valor_retorno := '''' || reg_detalle_in.VALUE || '''';
          end if;
        else
          valor_retorno := reg_detalle_in.VALUE;
        end if;
      when 'SEQ' then
        valor_retorno := OWNER_DM || '.SEQ_' || nombre_tabla_reducido || '.NEXTVAL';
        --if (instr(reg_detalle_in.VALUE, '.NEXTVAL') > 0) then
        --  valor_retorno := '    ' || reg_detalle_in.VALUE;
        --else
        --  valor_retorno := '    ' || reg_detalle_in.VALUE || '.NEXTVAL';
        --end if;
      when 'SEQG' then
        valor_retorno := ''' || var_seqg || ''';
      when 'BASE' then
        /* Se toma el valor del campo de la tabla de staging */
        valor_retorno := reg_detalle_in.VALUE;
      when 'VAR_FCH_INICIO' then
        --valor_retorno :=  '    ' || ''' || var_fch_inicio || ''';
        valor_retorno :=  'SYSDATE';
        --valor_retorno :=  '    TO_DATE('''''' || fch_registro_in || '''''', ''''YYYYMMDDHH24MISS'''')'; /*(20151221) Angel Ruiz BUG. Debe insertarse la fecha de inicio del proceso de insercion */
      when 'VAR' then
        /* Se toma el valor de una variable de entorno */
        if reg_detalle_in.VALUE =  'VAR_FCH_CARGA' then /* Si se trata de la fecha de carga, la podemos coger del parametro de la funcion */
          valor_retorno :=  '     ' ||  'TO_DATE (''&' || '2'', ''YYYYMMDD'')';
          --valor_retorno := '    ' || ''' || fch_datos_in || ''';        
        end if;
        if reg_detalle_in.VALUE =  'VAR_PAIS_TM' then /* Si se trata de la fecha de carga, la podemos coger del parametro de la funcion */
          valor_retorno := '1';
        end if;
      when 'LKUPN' then
        /* (20150824) ANGEL RUIZ. Nueva Regla. Permite rescatar un campo numerico de la tabla de look up y hacer operaciones con el */
        l_FROM.extend;
        if (instr (reg_detalle_in.TABLE_LKUP,'SELECT ') > 0) then
          /* Aparecen queries en lugar de tablas en la columna de nombre de tabla para LookUp */
          v_alias := 'LKUP_' || l_FROM.count;
          mitabla_look_up := '(' || reg_detalle_in.TABLE_LKUP || ') "LKUP_' || l_FROM.count || '"';
          l_FROM (l_FROM.last) := ', ' || mitabla_look_up;
        else
          /* (20150112) Angel Ruiz */
          /* Puede ocurrir que se se tenga varias veces la misma LookUp pero para campo diferentes */
          /* lo que se traduce en que hay que crear ALIAS */
          /* BUSCAMOS SI YA ESTABA LA TABLA INCLUIDA EN EL FROM*/
          v_encontrado:='N';
          FOR indx IN l_FROM.FIRST .. l_FROM.LAST
          LOOP
            --if (instr(l_FROM(indx),  reg_detalle_in.TABLE_LKUP, 0)) then
            --regexp_count(reg_per_val.AGREGATION,'^BAN_',1,'i') >0
            if (regexp_count(l_FROM(indx), reg_detalle_in.TABLE_LKUP) >0) then
            --if (l_FROM(indx) = ', ' || OWNER_DM || '.' || reg_detalle_in.TABLE_LKUP) then
              /* La misma tabla ya estaba en otro lookup */
              v_encontrado:='Y';
            end if;
          END LOOP;
          if (v_encontrado='Y') then
            v_alias := reg_detalle_in.TABLE_LKUP || '_' || l_FROM.count;
            l_FROM (l_FROM.last) := ', ' || OWNER_DM || '.' || reg_detalle_in.TABLE_LKUP || ' "' || v_alias || '"' ;
          else
            v_alias := reg_detalle_in.TABLE_LKUP;
            l_FROM (l_FROM.last) := ', ' || OWNER_DM || '.' || reg_detalle_in.TABLE_LKUP;
          end if;
        end if;
        /* Miramos la parte de las condiciones */
        /* Puede haber varios campos por los que hacer LookUp y por lo tanto JOIN */
        table_columns_lkup := split_string_coma (reg_detalle_in.TABLE_COLUMN_LKUP);
        ie_column_lkup := split_string_coma (reg_detalle_in.IE_COLUMN_LKUP);
        /* Le añadimos al nombre del campo de la tabla de LookUp su Alias */
        v_value := proceso_campo_value (reg_detalle_in.VALUE, v_alias);
        /****************************************************************************/
        /* CONTRUIMOS EL CAMPO PARA LA PARTE DEL SELECT */
        /****************************************************************************/
        if (reg_detalle_in.LKUP_COM_RULE is not null) then
          /* Ocurre que tenemos una regla compuesta, un LKUP con una condicion */
          cadena := trim(reg_detalle_in.LKUP_COM_RULE);
          pos_del_si := instr(cadena, 'SI');
          pos_del_then := instr(cadena, 'THEN');
          pos_del_else := instr(cadena, 'ELSE');
          pos_del_end := instr(cadena, 'END');  
          condicion := substr(cadena,pos_del_si+length('SI'), pos_del_then-(pos_del_si+length('SI')));
          condicion_pro := procesa_COM_RULE_lookup(condicion);
          constante := substr(cadena, pos_del_else+length('ELSE'),pos_del_end-(pos_del_else+length('ELSE')));
          valor_retorno := 'CASE WHEN ' || trim(condicion_pro) || ' THEN NVL(' || v_value || ', -2) ELSE ' || trim(constante) || ' END';
        else
          /* Construyo el campo de SELECT */
          if (table_columns_lkup.COUNT > 1) then      /* Hay varios campos de condicion */
            valor_retorno := 'CASE WHEN (';
            FOR indx IN table_columns_lkup.FIRST .. table_columns_lkup.LAST
            LOOP
              SELECT * INTO l_registro
              FROM ALL_TAB_COLUMNS
              WHERE TABLE_NAME =  reg_detalle_in.TABLE_BASE_NAME and
              COLUMN_NAME = TRIM(ie_column_lkup(indx));
            
              if (instr(l_registro.DATA_TYPE, 'VARCHAR') > 0) then  /* se trata de un campo VARCHAR */
                if (indx = 1) then
                  valor_retorno := valor_retorno || reg_detalle_in.TABLE_BASE_NAME || '.' || l_registro.COLUMN_NAME || ' IS NULL OR ' || reg_detalle_in.TABLE_BASE_NAME || '.' || l_registro.COLUMN_NAME || ' IN (''''NI#'''', ''''NO INFORMADO'''') ';
                else
                  valor_retorno := valor_retorno || 'OR ' || reg_detalle_in.TABLE_BASE_NAME || '.' || l_registro.COLUMN_NAME || ' IS NULL OR ' || reg_detalle_in.TABLE_BASE_NAME || '.' || l_registro.COLUMN_NAME || ' IN (''''NI#'''', ''''NO INFORMADO'''') ';
                end if;
              else 
                if (indx = 1) then
                  valor_retorno := valor_retorno || reg_detalle_in.TABLE_BASE_NAME || '.' || l_registro.COLUMN_NAME || ' IS NULL OR ' || reg_detalle_in.TABLE_BASE_NAME || '.' || l_registro.COLUMN_NAME || ' = -3 ';
                else
                  valor_retorno := valor_retorno || 'OR ' || reg_detalle_in.TABLE_BASE_NAME || '.' || l_registro.COLUMN_NAME || ' IS NULL OR ' || reg_detalle_in.TABLE_BASE_NAME || '.' || l_registro.COLUMN_NAME || ' = -3 ';
                end if;
              end if;
            END LOOP;
            valor_retorno := valor_retorno || ') THEN -3 ELSE ' || 'NVL(' || v_value || ', -2) END';
          else
            valor_retorno :=  'NVL(' || v_value || ', -2)';
          end if;

        end if;

        /****************************************************************************/
        /* CONTRUIMOS EL CAMPO PARA LA PARTE DEL WHERE */
        /****************************************************************************/

        if (table_columns_lkup.COUNT > 1) then      /* Hay varios campos de condicion */
          FOR indx IN table_columns_lkup.FIRST .. table_columns_lkup.LAST
          LOOP
            l_WHERE.extend;
            /* (20150126) Angel Ruiz. Incidencia referente a que siempre se coloca el valor -2 */
            /* Recojo el tipo de dato del campo con el que se va a hacer LookUp */
            dbms_output.put_line('ESTOY EN EL LOOKUP. Este LoopUp es de varias columnas. La Tabla es: ' || reg_detalle_in.TABLE_BASE_NAME);
            dbms_output.put_line('ESTOY EN EL LOOKUP. Este LoopUp es de varias columnas. La Columna es: ' || ie_column_lkup(indx));
            
            /* Recojo de que tipo son los campos con los que vamos a hacer LookUp */
            SELECT * INTO l_registro
            FROM ALL_TAB_COLUMNS
            WHERE TABLE_NAME =  reg_detalle_in.TABLE_BASE_NAME and
            COLUMN_NAME = TRIM(ie_column_lkup(indx));
            if (l_WHERE.count = 1) then
              if (instr(l_registro.DATA_TYPE, 'VARCHAR') > 0) then    /* Estamos haciendo JOIN con la tabla de LookUp COD_* por un campo CARACTER */
                if (l_registro.DATA_LENGTH <3 and l_registro.NULLABLE = 'Y') then
                  l_WHERE(l_WHERE.last) :=  'NVL(' || reg_detalle_in.TABLE_BASE_NAME || '.' || ie_column_lkup(indx) || ', ''''NI#'''')' || ' = ' || v_alias || '.' || table_columns_lkup(indx) || ' (+)';
                else
                  l_WHERE(l_WHERE.last) :=  reg_detalle_in.TABLE_BASE_NAME || '.' || ie_column_lkup(indx) ||  ' = ' || v_alias || '.' || table_columns_lkup(indx) || ' (+)';
                end if;
              else    /* Estamos haciendo JOIN con la tabla de LookUp COD_* por un campo NUMBER */
                --l_WHERE(l_WHERE.last) :=  'NVL(' || reg_detalle_in.TABLE_BASE_NAME || '.' || ie_column_lkup(indx) ||', -3)' ||' = ' || v_alias || '.' || table_columns_lkup(indx) || ' (+)';
                l_WHERE(l_WHERE.last) :=  reg_detalle_in.TABLE_BASE_NAME || '.' || ie_column_lkup(indx) || ' = ' || v_alias || '.' || table_columns_lkup(indx) || ' (+)';
              end if;
            else
              if (instr(l_registro.DATA_TYPE, 'VARCHAR') > 0) then    /* Estamos haciendo JOIN con la tabla de LookUp COD_* por un campo CARACTER */
                if (l_registro.DATA_LENGTH <3 and l_registro.NULLABLE = 'Y') then
                  l_WHERE(l_WHERE.last) :=  ' AND NVL(' || reg_detalle_in.TABLE_BASE_NAME || '.' || ie_column_lkup(indx) || ', ''''NI#'''')' || ' = ' || v_alias || '.' || table_columns_lkup(indx) || ' (+)';
                else
                  l_WHERE(l_WHERE.last) :=  ' AND ' || reg_detalle_in.TABLE_BASE_NAME || '.' || ie_column_lkup(indx) || ' = ' || v_alias || '.' || table_columns_lkup(indx) || ' (+)';
                end if;
              else /* Estamos haciendo JOIN con la tabla de LookUp COD_* por un campo NUMBER */
                --l_WHERE(l_WHERE.last) :=  ' AND NVL(' || reg_detalle_in.TABLE_BASE_NAME || '.' || ie_column_lkup(indx) || ', -3)' || ' = ' || v_alias || '.' || table_columns_lkup(indx) || ' (+)';
                l_WHERE(l_WHERE.last) :=  ' AND ' || reg_detalle_in.TABLE_BASE_NAME || '.' || ie_column_lkup(indx) || ' = ' || v_alias || '.' || table_columns_lkup(indx) || ' (+)';
              end if;
            end if;
          END LOOP;
        else    /* Solo hay un campo condicion */
          
          /* Miramos si la tabla con la que hay que hacer LookUp es una tabla de rangos */
          l_WHERE.extend;
          if (instr (reg_detalle_in.TABLE_LKUP,'RANGO') > 0) then
            if (l_WHERE.count = 1) then
              l_WHERE(l_WHERE.last) := reg_detalle_in.TABLE_BASE_NAME || '.' || reg_detalle_in.IE_COLUMN_LKUP || ' >= ' || v_alias || '.' || reg_detalle_in.TABLE_COLUMN_LKUP || ' (+)';
              l_WHERE.extend;
              l_WHERE(l_WHERE.last) := ' AND ' || reg_detalle_in.TABLE_BASE_NAME || '.' || reg_detalle_in.IE_COLUMN_LKUP || ' <= ' || v_alias || '.' || 'MAX' || substr(reg_detalle_in.TABLE_COLUMN_LKUP, 4) || ' (+)';
            else
              l_WHERE(l_WHERE.last) := ' AND ' || reg_detalle_in.TABLE_BASE_NAME || '.' || reg_detalle_in.IE_COLUMN_LKUP || ' >= ' || v_alias || '.'  || reg_detalle_in.TABLE_COLUMN_LKUP || ' (+)';
              l_WHERE.extend;
              l_WHERE(l_WHERE.last) := ' AND ' || reg_detalle_in.TABLE_BASE_NAME || '.' || reg_detalle_in.IE_COLUMN_LKUP || ' <= ' || v_alias || '.' || 'MAX' || substr(reg_detalle_in.TABLE_COLUMN_LKUP, 4) || ' (+)';
            end if;
          else
            /* (20150126) Angel Ruiz. Incidencia referente a que siempre se coloca el valor -2 */
            /* Recojo el tipo de dato del campo con el que se va a hacer LookUp */
            dbms_output.put_line('ESTOY EN EL LOOKUP. La Tabla es: ' || reg_detalle_in.TABLE_BASE_NAME);
            dbms_output.put_line('ESTOY EN EL LOOKUP. La Columna es: ' || reg_detalle_in.IE_COLUMN_LKUP);
            SELECT * INTO l_registro
            FROM ALL_TAB_COLUMNS
            WHERE TABLE_NAME =  reg_detalle_in.TABLE_BASE_NAME and
            COLUMN_NAME = reg_detalle_in.IE_COLUMN_LKUP;
            if (l_WHERE.count = 1) then /* si es el primer campo del WHERE */
              if (instr(l_registro.DATA_TYPE, 'VARCHAR') > 0) then    /* Estamos haciendo JOIN con la tabla de LookUp COD_* por un campo CARACTER */
                if (l_registro.DATA_LENGTH <3 and l_registro.NULLABLE = 'Y') then
                  l_WHERE(l_WHERE.last) := 'NVL(' || reg_detalle_in.TABLE_BASE_NAME || '.' || reg_detalle_in.IE_COLUMN_LKUP || ', ''''NI#'''')' ||  ' = ' || v_alias || '.' || reg_detalle_in.TABLE_COLUMN_LKUP || ' (+)';
                else
                  l_WHERE(l_WHERE.last) := reg_detalle_in.TABLE_BASE_NAME || '.' || reg_detalle_in.IE_COLUMN_LKUP ||  ' = ' || v_alias || '.' || reg_detalle_in.TABLE_COLUMN_LKUP || ' (+)';
                end if;
              else    /* Estamos haciendo JOIN con la tabla de LookUp COD_* por un campo NUMBER */
                --l_WHERE(l_WHERE.last) := 'NVL(' || reg_detalle_in.TABLE_BASE_NAME || '.' || reg_detalle_in.IE_COLUMN_LKUP || ', -3)' ||  ' = ' || v_alias || '.' || reg_detalle_in.TABLE_COLUMN_LKUP || ' (+)';
                l_WHERE(l_WHERE.last) := reg_detalle_in.TABLE_BASE_NAME || '.' || reg_detalle_in.IE_COLUMN_LKUP ||  ' = ' || v_alias || '.' || reg_detalle_in.TABLE_COLUMN_LKUP || ' (+)';
              end if;
            else  /* sino es el primer campo del Where  */
              if (instr(l_registro.DATA_TYPE, 'VARCHAR') > 0) then     /* Estamos haciendo JOIN con la tabla de LookUp COD_* por un campo CARACTER */
                if (l_registro.DATA_LENGTH <3 and l_registro.NULLABLE = 'Y') then
                  l_WHERE(l_WHERE.last) :=  ' AND NVL(' || reg_detalle_in.TABLE_BASE_NAME || '.' || reg_detalle_in.IE_COLUMN_LKUP || ', ''''NI#'''')' || ' = ' || v_alias || '.' || reg_detalle_in.TABLE_COLUMN_LKUP || ' (+)';
                else
                  l_WHERE(l_WHERE.last) :=  ' AND ' || reg_detalle_in.TABLE_BASE_NAME || '.' || reg_detalle_in.IE_COLUMN_LKUP || ' = ' || v_alias || '.' || reg_detalle_in.TABLE_COLUMN_LKUP || ' (+)';
                end if;
              else     /* Estamos haciendo JOIN con la tabla de LookUp COD_* por un campo NUMBER */
                --l_WHERE(l_WHERE.last) :=  ' AND NVL(' || reg_detalle_in.TABLE_BASE_NAME || '.' || reg_detalle_in.IE_COLUMN_LKUP || ', -3)' || ' = ' || v_alias || '.' || reg_detalle_in.TABLE_COLUMN_LKUP || ' (+)';
                l_WHERE(l_WHERE.last) :=  ' AND ' || reg_detalle_in.TABLE_BASE_NAME || '.' || reg_detalle_in.IE_COLUMN_LKUP || ' = ' || v_alias || '.' || reg_detalle_in.TABLE_COLUMN_LKUP || ' (+)';
              end if;
            end if;
          end if;
        end if;
        if (reg_detalle_in.TABLE_LKUP_COND is not null) then
          /* Existen condiciones en la tabla de Look Up que hay que introducir*/
          l_WHERE.extend;
          --l_WHERE(l_WHERE.last) :=  ' AND ' || procesa_condicion_lookup(reg_detalle_in.TABLE_LKUP_COND, v_alias);
          /* (20160412) Angel Ruiz. BUG: Si la tabla de LookUP es con OUTER entonces */
          /* debemos procesar la condicion para ponerle el signo outer por dentro */
          if (reg_detalle_in."OUTER" IS NOT NULL and reg_detalle_in."OUTER"='Y') then
            l_WHERE(l_WHERE.last) :=  ' AND ' || procesa_condicion_lookup(reg_detalle_in.TABLE_LKUP_COND, v_alias, TRUE);
          else
            l_WHERE(l_WHERE.last) :=  ' AND ' || procesa_condicion_lookup(reg_detalle_in.TABLE_LKUP_COND, v_alias, FALSE);
          end if;
          
        end if;
      end case;
    return valor_retorno;
  end;

/*************/
  function genera_encabezado_funcion_pkg (reg_lookup_in in MTDT_TC_LOOKUP%rowtype) return VARCHAR2 is
    valor_retorno VARCHAR (500);
    lkup_columns                list_strings := list_strings();
  begin
    /* Se trata de hacer el LOOK UP con la tabla dimension */
    /* Miramos si hay varios campos por los que hay que hay que hacer JOIN */
    dbms_output.put_line('Estoy en genera_encabezado_funcion_pkg. Antes de llamar a string coma');
    lkup_columns := split_string_coma (reg_lookup_in.TABLE_COLUMN_LKUP);
    dbms_output.put_line('Estoy en genera_encabezado_funcion_pkg. Despues de llamar a string coma');
    if (lkup_columns.COUNT > 1)
    then
      valor_retorno := '  FUNCTION ' || 'LK_' || reg_lookup_in.TABLE_LKUP || ' (';
      FOR indx IN lkup_columns.FIRST .. lkup_columns.LAST
      LOOP
        if indx = 1 then
          valor_retorno := valor_retorno || lkup_columns(indx) || '_IN ' || reg_lookup_in.TABLE_LKUP || '.' || lkup_columns(indx) || '%TYPE';
        else
          valor_retorno := valor_retorno || ', ' || lkup_columns(indx) || '_IN ' || reg_lookup_in.TABLE_LKUP || '.' || lkup_columns(indx) || '%TYPE';
        end if;
      END LOOP;
      valor_retorno := valor_retorno || ') return ' || reg_lookup_in.TABLE_LKUP || '.' || reg_lookup_in.VALUE || '%TYPE RESULT_CACHE;';
    else        
      valor_retorno := '  FUNCTION ' || 'LK_' || reg_lookup_in.TABLE_LKUP || ' (cod_in IN ' || reg_lookup_in.TABLE_LKUP || '.' || reg_lookup_in.TABLE_COLUMN_LKUP || '%TYPE) return ' || reg_lookup_in.TABLE_LKUP || '.' || reg_lookup_in.value || '%TYPE RESULT_CACHE;';
    end if;
    dbms_output.put_line('Justo antes de retornar');
    dbms_output.put_line('Retorno es: ' || valor_retorno);
    return valor_retorno;
  end;

/************/

  function gen_encabe_regla_function (reg_function_in in MTDT_TC_FUNCTION%rowtype) return VARCHAR2 is
    valor_retorno VARCHAR (250);
    lkup_columns                list_strings := list_strings();
  begin
    valor_retorno := '  FUNCTION ' || 'LK_' || reg_function_in.VALUE || ';';
    return valor_retorno;
  end gen_encabe_regla_function;

  procedure genera_cuerpo_regla_function (reg_function_in in MTDT_TC_FUNCTION%rowtype) is
  begin
    UTL_FILE.put_line (fich_salida_pkg, '  FUNCTION ' || 'LK_' || reg_function_in.VALUE);
    --UTL_FILE.put_line (fich_salida_pkg, '  RESULT_CACHE');
    UTL_FILE.put_line (fich_salida_pkg, '  IS');
    UTL_FILE.put_line (fich_salida_pkg, '  BEGIN');
    UTL_FILE.put_line (fich_salida_pkg, '');
    UTL_FILE.put_line (fich_salida_pkg, '    dbms_output.put_line (''Aqui iria el cuerpo de la funcion'');');
    UTL_FILE.put_line (fich_salida_pkg, '    /* AQUI IRIA EL CUERPO DE LA FUNCION */');
    UTL_FILE.put_line (fich_salida_pkg, '');
    UTL_FILE.put_line (fich_salida_pkg, '  END ' || 'LK_' || reg_function_in.TABLE_LKUP || ';');
  end genera_cuerpo_regla_function;

/************/
  procedure genera_cuerpo_funcion_pkg (reg_lookup_in in MTDT_TC_LOOKUP%rowtype) is
    valor_retorno VARCHAR (500);
    lkup_columns                list_strings := list_strings();

  begin
    /* Se trata de hacer el LOOK UP con la tabla dimension */
    
    /* Miramos si hay varios campos por los que hay que hay que hacer JOIN */
    lkup_columns := split_string_coma (reg_lookup_in.TABLE_COLUMN_LKUP);
    if (lkup_columns.COUNT > 1)
    then
      valor_retorno := '  FUNCTION ' || 'LK_' || reg_lookup_in.TABLE_LKUP || ' (';
      FOR indx IN lkup_columns.FIRST .. lkup_columns.LAST
      LOOP
        if indx = 1 then
          valor_retorno := valor_retorno || lkup_columns(indx) || '_IN ' || reg_lookup_in.TABLE_LKUP || '.' || lkup_columns(indx) || '%TYPE';
        else
          valor_retorno := valor_retorno || ', ' || lkup_columns(indx) || '_IN ' || reg_lookup_in.TABLE_LKUP || '.' || lkup_columns(indx) || '%TYPE';
        end if;
      END LOOP;
      valor_retorno := valor_retorno || ') ';
      UTL_FILE.put_line (fich_salida_pkg, valor_retorno);
    else        
      UTL_FILE.put_line (fich_salida_pkg, '  FUNCTION ' || 'LK_' || reg_lookup_in.TABLE_LKUP || ' (cod_in IN ' || reg_lookup_in.TABLE_LKUP || '.' || reg_lookup_in.TABLE_COLUMN_LKUP || '%TYPE)'); 
    end if;
    UTL_FILE.put_line (fich_salida_pkg, '    return ' || reg_lookup_in.TABLE_LKUP || '.' || reg_lookup_in.value || '%TYPE');
    UTL_FILE.put_line (fich_salida_pkg, '    RESULT_CACHE RELIES_ON (' || reg_lookup_in.TABLE_LKUP || ')');
    UTL_FILE.put_line (fich_salida_pkg, '  IS');
    UTL_FILE.put_line (fich_salida_pkg, '    l_row     ' || reg_lookup_in.TABLE_LKUP || '.' || reg_lookup_in.VALUE || '%TYPE;');
    UTL_FILE.put_line (fich_salida_pkg, '  BEGIN');
    UTL_FILE.put_line (fich_salida_pkg, '    SELECT nvl(' || reg_lookup_in.VALUE || ', -2) INTO l_row'); 
    UTL_FILE.put_line (fich_salida_pkg, '    FROM ' || reg_lookup_in.TABLE_LKUP);
    if (lkup_columns.COUNT > 1) then
      valor_retorno := '    WHERE ' ;
      FOR indx IN lkup_columns.FIRST .. lkup_columns.LAST
      LOOP
        if indx = 1 then
          valor_retorno := valor_retorno || reg_lookup_in.TABLE_LKUP || '.' || lkup_columns(indx) || ' = ' || lkup_columns(indx) || '_in';
        else
          valor_retorno := valor_retorno || ' and ' || reg_lookup_in.TABLE_LKUP || '.' || lkup_columns(indx) || ' = ' || lkup_columns(indx) || '_in';
        end if;
      END LOOP;
      if (reg_lookup_in.TABLE_LKUP_COND IS NULL) THEN
        valor_retorno := valor_retorno || ';';
      else
        valor_retorno := valor_retorno || reg_lookup_in.TABLE_LKUP_COND || ';';
      end if;
      UTL_FILE.put_line (fich_salida_pkg, valor_retorno);
    else
      /* 20141204 Angel Ruiz - Añadido para las tablas de LOOK UP que son un rango */
      if (instr (reg_lookup_in.TABLE_LKUP,'RANGO') > 0) then
        /* Se trata de una tabla de Rango y la trato diferente */
        if (reg_lookup_in.TABLE_LKUP_COND IS NULL) THEN
          UTL_FILE.put_line (fich_salida_pkg, '    WHERE cod_in >= ' || reg_lookup_in.TABLE_LKUP || '.' || reg_lookup_in.TABLE_COLUMN_LKUP || ' and  cod_in <= ' || reg_lookup_in.TABLE_LKUP || '.' || 'MAX' || substr(reg_lookup_in.TABLE_COLUMN_LKUP,4) || ';' );
        else
          UTL_FILE.put_line (fich_salida_pkg, '    WHERE cod_in >= ' || reg_lookup_in.TABLE_LKUP || '.' || reg_lookup_in.TABLE_COLUMN_LKUP || ' and  cod_in <= ' || reg_lookup_in.TABLE_LKUP || '.' || 'MAX' || substr(reg_lookup_in.TABLE_COLUMN_LKUP,4) || ' and ' || reg_lookup_in.TABLE_LKUP_COND || ';');
        end if;
      else 
        if (reg_lookup_in.TABLE_LKUP_COND IS NULL) THEN
        UTL_FILE.put_line (fich_salida_pkg, '    WHERE ' || reg_lookup_in.TABLE_LKUP || '.' || reg_lookup_in.TABLE_COLUMN_LKUP || ' = ' || 'cod_in;' );
        else
        UTL_FILE.put_line (fich_salida_pkg, '    WHERE ' || reg_lookup_in.TABLE_LKUP || '.' || reg_lookup_in.TABLE_COLUMN_LKUP || ' = ' || 'cod_in and ' || reg_lookup_in.TABLE_LKUP_COND || ';' );
        end if;
      end if;
    end if;
    UTL_FILE.put_line (fich_salida_pkg, '');
    UTL_FILE.put_line (fich_salida_pkg, '    RETURN l_row;');
    UTL_FILE.put_line (fich_salida_pkg, '');
    UTL_FILE.put_line (fich_salida_pkg, '  exception');
    UTL_FILE.put_line (fich_salida_pkg, '  when NO_DATA_FOUND then');
    UTL_FILE.put_line (fich_salida_pkg, '    RETURN -2;');
    UTL_FILE.put_line (fich_salida_pkg, '  when others then');
    UTL_FILE.put_line (fich_salida_pkg, '    RETURN -2;');
    UTL_FILE.put_line (fich_salida_pkg, '');
    UTL_FILE.put_line (fich_salida_pkg, '  END ' || 'LK_' || reg_lookup_in.TABLE_LKUP || ';');
    UTL_FILE.put_line (fich_salida_pkg, '');
    UTL_FILE.put_line (fich_salida_pkg, '');
 
  end genera_cuerpo_funcion_pkg;

begin
  /* (20141223) ANGEL RUIZ*/
  /* ANTES DE NADA LEEMOS LAS VAR. DE ENTORNO PARA TIEMPO DE GENERACION*/
  SELECT VALOR INTO OWNER_SA FROM MTDT_VAR_ENTORNO WHERE NOMBRE_VAR = 'OWNER_SA';
  SELECT VALOR INTO OWNER_T FROM MTDT_VAR_ENTORNO WHERE NOMBRE_VAR = 'OWNER_T';
  SELECT VALOR INTO OWNER_DM FROM MTDT_VAR_ENTORNO WHERE NOMBRE_VAR = 'OWNER_DM';
  SELECT VALOR INTO OWNER_MTDT FROM MTDT_VAR_ENTORNO WHERE NOMBRE_VAR = 'OWNER_MTDT';
  SELECT VALOR INTO NAME_DM FROM MTDT_VAR_ENTORNO WHERE NOMBRE_VAR = 'NAME_DM';
  SELECT VALOR INTO OWNER_TC FROM MTDT_VAR_ENTORNO WHERE NOMBRE_VAR = 'OWNER_TC';  
  SELECT VALOR INTO PREFIJO_DM FROM MTDT_VAR_ENTORNO WHERE NOMBRE_VAR = 'PREFIJO_DM';  
  SELECT VALOR INTO REQ_NUMBER FROM MTDT_VAR_ENTORNO WHERE NOMBRE_VAR = 'REQ_NUMBER';  
  SELECT VALOR INTO OWNER_1 FROM MTDT_VAR_ENTORNO WHERE NOMBRE_VAR = 'OWNER_1';
  SELECT VALOR INTO OWNER_2 FROM MTDT_VAR_ENTORNO WHERE NOMBRE_VAR = 'OWNER_2';
  SELECT VALOR INTO OWNER_3 FROM MTDT_VAR_ENTORNO WHERE NOMBRE_VAR = 'OWNER_3';
  SELECT VALOR INTO OWNER_4 FROM MTDT_VAR_ENTORNO WHERE NOMBRE_VAR = 'OWNER_4';
  SELECT VALOR INTO BD_SID FROM MTDT_VAR_ENTORNO WHERE NOMBRE_VAR = 'BD_SID';
  SELECT VALOR INTO BD_USR FROM MTDT_VAR_ENTORNO WHERE NOMBRE_VAR = 'BD_USR';
  /* (20141223) FIN*/

  open MTDT_TABLA;
  loop
    fetch MTDT_TABLA
    into reg_tabla;
    exit when MTDT_TABLA%NOTFOUND;
    v_tabla_dinamica := false;  /* Por defecto cada interfaz no tiene tabla dinamica */
    v_fecha_ini_param := false; /* Por defecto cada interfaz no tiene fecha inicial */
    v_fecha_fin_param := false; /* Por defecto cada interfaz no tiene fecha final */
    dbms_output.put_line ('Estoy en el primero LOOP. La tabla que tengo es: ' || reg_tabla.TABLE_NAME);
    nombre_fich_carga := REQ_NUMBER || '_' || reg_tabla.TABLE_NAME || '.sh';
    --nombre_fich_exchange := 'load_ex_' || reg_tabla.TABLE_NAME || '.sh';
    nombre_fich_pkg := REQ_NUMBER || '_' || reg_tabla.TABLE_NAME || '.sql';
    fich_salida_load := UTL_FILE.FOPEN ('SALIDA',nombre_fich_carga,'W');
    --fich_salida_exchange := UTL_FILE.FOPEN ('SALIDA',nombre_fich_exchange,'W');
    fich_salida_pkg := UTL_FILE.FOPEN ('SALIDA',nombre_fich_pkg,'W');
    insert into
  end loop;
  close MTDT_TABLA;
end;

