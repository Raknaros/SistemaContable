CREATE TABLE TABLAS (
	codigo VARCHAR UNIQUE,
	descripcion VARCHAR
);
CREATE TABLE TS01 (
	medio_pago INTEGER UNIQUE,
	descripcion VARCHAR
);
CREATE TABLE TS02 (
	tipo_documento VARCHAR UNIQUE,
	descripcion VARCHAR
);
CREATE TABLE TS03 (
	entidad_financiera INTEGER UNIQUE,
	descripcion VARCHAR
);
CREATE TABLE TS04 (
	tipo_moneda VARCHAR UNIQUE,
	descripcion VARCHAR,
	zona_referencia VARCHAR
);
CREATE TABLE TS05 (
	tipo_existencia INTEGER UNIQUE,
	descripcion VARCHAR
);
CREATE TABLE TS06 (
	unidad_medida VARCHAR UNIQUE,
	descripcion VARCHAR
);
CREATE TABLE TS07 (
	tipo_intangible INTEGER UNIQUE,
	descripcion VARCHAR
);
CREATE TABLE TS10 (
	tipo_comprobante INTEGER UNIQUE,
	descripcion VARCHAR
);
CREATE TABLE TS11 (
	codigo_aduana INTEGER UNIQUE,
	descripcion VARCHAR
);
CREATE TABLE TS12 (
	tipo_operacion INTEGER UNIQUE,
	descripcion VARCHAR
);
CREATE TABLE TS14 (
	metodo_valuacion INTEGER UNIQUE,
	descripcion VARCHAR
);
CREATE TABLE TS15 (
	tipo_titulo INTEGER UNIQUE,
	descripcion VARCHAR
);
CREATE TABLE TS16 (
	tipo_acciones INTEGER UNIQUE,
	descripcion VARCHAR
);
CREATE TABLE TS17 (
	tipo_plan_cuentas INTEGER UNIQUE,
	descripcion VARCHAR
);
CREATE TABLE TS18 (
	tipo_activo_fijo INTEGER UNIQUE,
	descripcion VARCHAR
);
CREATE TABLE TS19 (
	estado_activo_fijo INTEGER UNIQUE,
	descripcion VARCHAR
);
CREATE TABLE TS20 (
	metodo_depreciacion INTEGER UNIQUE,
	descripcion VARCHAR
);
CREATE TABLE TS21 (
	agrupamiento_costo_produccion_anual INTEGER UNIQUE,
	descripcion VARCHAR
);
CREATE TABLE TS22 (
	catalogo_estados_financieros INTEGER UNIQUE,
	descripcion VARCHAR
);
CREATE TABLE TS25 (
	convenio_doble_tributacion INTEGER UNIQUE,
	descripcion VARCHAR
);
CREATE TABLE TS27 (
	vinculacion_economica INTEGER UNIQUE,
	descripcion VARCHAR,
	articulo_ley VARCHAR
);
CREATE TABLE TS30 (
	clasificacion_bienes_servicios INTEGER UNIQUE,
	descripcion VARCHAR
);
CREATE TABLE TS31 (
	tipo_renta INTEGER UNIQUE,
	descripcion VARCHAR,
	articulo_ley VARCHAR,
	codigo_ocde VARCHAR
);
CREATE TABLE TS32 (
	servicio_nodomiciliado INTEGER UNIQUE,
	descripcion VARCHAR
);
CREATE TABLE TS33 (
	exoneraciones_nodomiciliado INTEGER UNIQUE,
	descripcion VARCHAR
);
CREATE TABLE TS34 (
	rubro_estados_financieros VARCHAR UNIQUE,
	descripcion VARCHAR
);
CREATE TABLE TS35 (
	paises INTEGER UNIQUE,
	descripcion VARCHAR
);
CREATE TABLE entities (
	entity_id INTEGER UNIQUE,
	nombre_razon VARCHAR UNIQUE,
	numero_documento BIGINT UNIQUE,
	telefono INTEGER,
	email VARCHAR,
	domicilio_fiscal VARCHAR,
	distrito TEXT,
	ciudad TEXT,
	departamento TEXT,
	codigo_postal INTEGER,
	usuario_sol VARCHAR,
	clave_sol VARCHAR
);
CREATE TABLE related (
	numero_documento BIGINT UNIQUE,
	nombre_razon VARCHAR UNIQUE,
	cuenta_detracciones BIGINT UNIQUE
);
CREATE TABLE subdiary (
	codigo INTEGER UNIQUE,
	subdiario TEXT UNIQUE
);
CREATE TABLE tc (
	fecha_sbs DATE NOT NULL,
	fecha_sunat DATE NOT NULL,
	usd_b DEC(5,3),
	usd_s DEC(5,3)
);
CREATE TABLE changeslog (
	usuario VARCHAR,
	subdiario INT,
	cuc VARCHAR,
	instante TIMESTAMP
);
CREATE TABLE _01 (
);
CREATE TABLE _02 (
);
CREATE TABLE _03 (
);
CREATE TABLE _04 (
);
CREATE TABLE _05 (
	entity_id INTEGER REFERENCES entities(entity_id) ON DELETE SET NULL,
	subdiario INTEGER REFERENCES subdiary(codigo) ON DELETE SET NULL, 
	cuo VARCHAR,
	tipo_operacion INTEGER REFERENCES TS12(tipo_operacion) ON DELETE SET NULL,
	tipo_comprobante INTEGER REFERENCES TS10(tipo_comprobante) ON DELETE SET NULL,
	fecha_emision DATE,
	fecha_vencimiento DATE,
	numero_serie VARCHAR,
	numero_correlativo INTEGER,
	numero_final INTEGER,
	tipo_documento INTEGER REFERENCES TS02(tipo_documento) ON DELETE SET NULL,
	numero_documento BIGINT,
	destino INTEGER,
	valor_venta REAL,
	icbp REAL,
	isc REAL,
	otros_cargos REAL,
	tipo_moneda VARCHAR REFERENCES TS04(tipo_moneda) ON DELETE SET NULL,
	tasa_detraccion VARCHAR,
	tasa_percepcion VARCHAR,
	numero_serie_percepcion VARCHAR,
	numero_correlativo_percepcion INTEGER,
	medio_pago INTEGER REFERENCES TS01(medio_pago) ON DELETE SET NULL,
	tipo_documento_modificado INTEGER,
	numero_serie_modificado VARCHAR,
	numero_correlativo_modificado INTEGER,
	glosa VARCHAR,
	cuc VARCHAR UNIQUE,
	fecha_cuota1 DATE,
	importe_cuota1 REAL,
	fecha_cuota2 DATE,
	importe_cuota2 REAL,
	fecha_cuota3 DATE,
	importe_cuota3 REAL,
	fecha_cuota4 DATE,
	importe_cuota4 REAL,
	fecha_cuota5 DATE,
	importe_cuota5 REAL,
	fecha_cuota6 DATE,
	importe_cuota6 REAL,
	fecha_cuota7 DATE,
	importe_cuota7 REAL,
	fecha_cuota8 DATE,
	importe_cuota8 REAL,
	fecha_cuota9 DATE,
	importe_cuota9 REAL,
	fecha_cuota10 DATE,
	importe_cuota10 REAL,
	fecha_cuota11 DATE,
	importe_cuota11 REAL,
	fecha_cuota12 DATE,
	importe_cuota12 REAL,
	fecha_cuota13 DATE,
	importe_cuota13 REAL,
	fecha_cuota14 DATE,
	importe_cuota14 REAL,
	fecha_cuota15 DATE,
	importe_cuota15 REAL,
	fecha_cuota16 DATE,
	importe_cuota16 REAL,
	fecha_cuota17 DATE,
	importe_cuota17 REAL,
	fecha_cuota18 DATE,
	importe_cuota18 REAL,
	fecha_cuota19 DATE,
	importe_cuota19 REAL,
	fecha_cuota20 DATE,
	importe_cuota20 REAL,
	fecha_cuota21 DATE,
	importe_cuota21 REAL,
	fecha_cuota22 DATE,
	importe_cuota22 REAL,
	fecha_cuota23 DATE,
	importe_cuota23 REAL,
	fecha_cuota24 DATE,
	importe_cuota24 REAL,
	fecha_cuota25 DATE,
	importe_cuota25 REAL,
	fecha_cuota26 DATE,
	importe_cuota26 REAL,
	fecha_cuota27 DATE,
	importe_cuota27 REAL,
	fecha_cuota28 DATE,
	importe_cuota28 REAL,
	fecha_cuota29 DATE,
	importe_cuota29 REAL,
	fecha_cuota30 DATE,
	importe_cuota30 REAL,
	fecha_cuota31 DATE,
	importe_cuota31 REAL,
	fecha_cuota32 DATE,
	importe_cuota32 REAL,
	fecha_cuota33 DATE,
	importe_cuota33 REAL,
	fecha_cuota34 DATE,
	importe_cuota34 REAL,
	fecha_cuota35 DATE,
	importe_cuota35 REAL,
	fecha_cuota36 DATE,
	importe_cuota36 REAL,
	fecha_cuota37 DATE,
	importe_cuota37 REAL,
	fecha_cuota38 DATE,
	importe_cuota38 REAL,
	fecha_cuota39 DATE,
	importe_cuota39 REAL,
	fecha_cuota40 DATE,
	importe_cuota40 REAL,
	fecha_cuota41 DATE,
	importe_cuota41 REAL,
	fecha_cuota42 DATE,
	importe_cuota42 REAL,
	fecha_cuota43 DATE,
	importe_cuota43 REAL,
	fecha_cuota44 DATE,
	importe_cuota44 REAL,
	fecha_cuota45 DATE,
	importe_cuota45 REAL,
	fecha_cuota46 DATE,
	importe_cuota46 REAL,
	fecha_cuota47 DATE,
	importe_cuota47 REAL,
	fecha_cuota48 DATE,
	importe_cuota48 REAL,
	fecha_cuota49 DATE,
	importe_cuota49 REAL,
	fecha_cuota50 DATE,
	importe_cuota50 REAL,
	fecha_cuota51 DATE,
	importe_cuota51 REAL,
	fecha_cuota52 DATE,
	importe_cuota52 REAL,
	fecha_cuota53 DATE,
	importe_cuota53 REAL,
	fecha_cuota54 DATE,
	importe_cuota54 REAL,
	fecha_cuota55 DATE,
	importe_cuota55 REAL,
	fecha_cuota56 DATE,
	importe_cuota56 REAL,
	fecha_cuota57 DATE,
	importe_cuota57 REAL,
	fecha_cuota58 DATE,
	importe_cuota58 REAL,
	fecha_cuota59 DATE,
	importe_cuota59 REAL,
	fecha_cuota60 DATE,
	importe_cuota60 REAL
);
CREATE TABLE _06 (
);
CREATE TABLE _07 (
);
CREATE TABLE _08 (
	entity_id INTEGER REFERENCES entities(entity_id) ON DELETE SET NULL,
	subdiario INTEGER REFERENCES subdiary(codigo) ON DELETE SET NULL, 
	cuo VARCHAR,
	tipo_operacion INTEGER REFERENCES TS12(tipo_operacion) ON DELETE SET NULL,
	tipo_comprobante INTEGER REFERENCES TS10(tipo_comprobante) ON DELETE SET NULL,
	fecha_emision DATE,
	fecha_vencimiento DATE,
	numero_serie VARCHAR,
	numero_correlativo INTEGER,
	importe_final INTEGER,
	tipo_documento INTEGER REFERENCES TS02(tipo_documento) ON DELETE SET NULL,
	numero_documento BIGINT,
	clasificacion_bienes_servicios INTEGER REFERENCES TS30(clasificacion_bienes_servicios) ON DELETE SET NULL,
	destino INTEGER,
	valor_adquisicion REAL,
	icbp REAL,
	isc REAL,
	otros_cargos REAL,
	tipo_moneda VARCHAR REFERENCES TS04(tipo_moneda) ON DELETE SET NULL,
	tasa_detraccion VARCHAR,
	fecha_constancia_detraccion DATE,
	numero_constancia_detraccion VARCHAR,
	tasa_percepcion VARCHAR,
	medio_pago INTEGER REFERENCES TS01(medio_pago) ON DELETE SET NULL,
	tipo_documento_modificado INTEGER,
	numero_serie_modificado VARCHAR,
	numero_correlativo_modificado INTEGER,
	glosa VARCHAR,
	cuc VARCHAR UNIQUE,
	fecha_cuota1 DATE,
	importe_cuota1 REAL,
	fecha_cuota2 DATE,
	importe_cuota2 REAL,
	fecha_cuota3 DATE,
	importe_cuota3 REAL,
	fecha_cuota4 DATE,
	importe_cuota4 REAL,
	fecha_cuota5 DATE,
	importe_cuota5 REAL,
	fecha_cuota6 DATE,
	importe_cuota6 REAL,
	fecha_cuota7 DATE,
	importe_cuota7 REAL,
	fecha_cuota8 DATE,
	importe_cuota8 REAL,
	fecha_cuota9 DATE,
	importe_cuota9 REAL,
	fecha_cuota10 DATE,
	importe_cuota10 REAL,
	fecha_cuota11 DATE,
	importe_cuota11 REAL,
	fecha_cuota12 DATE,
	importe_cuota12 REAL,
	fecha_cuota13 DATE,
	importe_cuota13 REAL,
	fecha_cuota14 DATE,
	importe_cuota14 REAL,
	fecha_cuota15 DATE,
	importe_cuota15 REAL,
	fecha_cuota16 DATE,
	importe_cuota16 REAL,
	fecha_cuota17 DATE,
	importe_cuota17 REAL,
	fecha_cuota18 DATE,
	importe_cuota18 REAL,
	fecha_cuota19 DATE,
	importe_cuota19 REAL,
	fecha_cuota20 DATE,
	importe_cuota20 REAL,
	fecha_cuota21 DATE,
	importe_cuota21 REAL,
	fecha_cuota22 DATE,
	importe_cuota22 REAL,
	fecha_cuota23 DATE,
	importe_cuota23 REAL,
	fecha_cuota24 DATE,
	importe_cuota24 REAL,
	fecha_cuota25 DATE,
	importe_cuota25 REAL,
	fecha_cuota26 DATE,
	importe_cuota26 REAL,
	fecha_cuota27 DATE,
	importe_cuota27 REAL,
	fecha_cuota28 DATE,
	importe_cuota28 REAL,
	fecha_cuota29 DATE,
	importe_cuota29 REAL,
	fecha_cuota30 DATE,
	importe_cuota30 REAL,
	fecha_cuota31 DATE,
	importe_cuota31 REAL,
	fecha_cuota32 DATE,
	importe_cuota32 REAL,
	fecha_cuota33 DATE,
	importe_cuota33 REAL,
	fecha_cuota34 DATE,
	importe_cuota34 REAL,
	fecha_cuota35 DATE,
	importe_cuota35 REAL,
	fecha_cuota36 DATE,
	importe_cuota36 REAL,
	fecha_cuota37 DATE,
	importe_cuota37 REAL,
	fecha_cuota38 DATE,
	importe_cuota38 REAL,
	fecha_cuota39 DATE,
	importe_cuota39 REAL,
	fecha_cuota40 DATE,
	importe_cuota40 REAL,
	fecha_cuota41 DATE,
	importe_cuota41 REAL,
	fecha_cuota42 DATE,
	importe_cuota42 REAL,
	fecha_cuota43 DATE,
	importe_cuota43 REAL,
	fecha_cuota44 DATE,
	importe_cuota44 REAL,
	fecha_cuota45 DATE,
	importe_cuota45 REAL,
	fecha_cuota46 DATE,
	importe_cuota46 REAL,
	fecha_cuota47 DATE,
	importe_cuota47 REAL,
	fecha_cuota48 DATE,
	importe_cuota48 REAL,
	fecha_cuota49 DATE,
	importe_cuota49 REAL,
	fecha_cuota50 DATE,
	importe_cuota50 REAL,
	fecha_cuota51 DATE,
	importe_cuota51 REAL,
	fecha_cuota52 DATE,
	importe_cuota52 REAL,
	fecha_cuota53 DATE,
	importe_cuota53 REAL,
	fecha_cuota54 DATE,
	importe_cuota54 REAL,
	fecha_cuota55 DATE,
	importe_cuota55 REAL,
	fecha_cuota56 DATE,
	importe_cuota56 REAL,
	fecha_cuota57 DATE,
	importe_cuota57 REAL,
	fecha_cuota58 DATE,
	importe_cuota58 REAL,
	fecha_cuota59 DATE,
	importe_cuota59 REAL,
	fecha_cuota60 DATE,
	importe_cuota60 REAL
);
CREATE TABLE _09 (
	entity_id INTEGER REFERENCES entities(entity_id) ON DELETE SET NULL,
	subdiario INTEGER REFERENCES subdiary(codigo) ON DELETE SET NULL,
	periodo_tributario INTEGER,
	numero_orden BIGINT PRIMARY KEY,
	fecha_presentacion DATE,
	_100 INTEGER,
	_101 INTEGER,
	_102 INTEGER,
	_103 INTEGER,
	_160 INTEGER,
	_161 INTEGER,
	_162 INTEGER,
	_163 INTEGER,
	_106 INTEGER,
	_127 INTEGER,
	_105 INTEGER,
	_109 INTEGER,
	_112 INTEGER,
	_107 INTEGER,
	_108 INTEGER,
	_110 INTEGER,
	_111 INTEGER,
	_113 INTEGER,
	_114 INTEGER,
	_115 INTEGER,
	_116 INTEGER,
	_117 INTEGER,
	_119 INTEGER,
	_120 INTEGER,
	_122 INTEGER,
	_172 INTEGER,
	_169 INTEGER,
	_173 FLOAT,
	_340 INTEGER,
	_341 INTEGER,
	_182 INTEGER,
	_301 INTEGER,
	_312 INTEGER,
	_380 FLOAT,
	_315 FLOAT,
	_140 INTEGER,
	_145 INTEGER,
	_184 INTEGER,
	_171 INTEGER,
	_168 INTEGER,
	_164 INTEGER,
	_179 INTEGER,
	_176 INTEGER,
	_165 INTEGER,
	_681 INTEGER,
	_185 INTEGER,
	_187 INTEGER,
	_188 INTEGER,
	_353 INTEGER,
	_351 INTEGER,
	_352 INTEGER,
	_347 INTEGER,
	_683 INTEGER,
	_342 INTEGER,
	_343 INTEGER,
	_344 INTEGER,
	_302 INTEGER,
	_303 INTEGER,
	_304 INTEGER,
	_326 INTEGER,
	_327 INTEGER,
	_305 INTEGER,
	_328 INTEGER,
	_682 INTEGER,
	_317 INTEGER,
	_319 INTEGER,
	_324 INTEGER
);
CREATE TABLE _10 (
	entity_id INTEGER REFERENCES entities(entity_id) ON DELETE SET NULL,
	subdiario INTEGER REFERENCES subdiary(codigo) ON DELETE SET NULL,
	periodo_tributario INTEGER,
	numero_formulario VARCHAR,
	numero_orden BIGINT PRIMARY KEY,
	descripcion VARCHAR,
	entidad_financiera INTEGER REFERENCES TS03(entidad_financiera) ON DELETE SET NULL,
	fecha_presentacion DATE,
	codigo_tributo INTEGER,
	detalle VARCHAR,
	importe REAL
);