--Insertar periodo a varios registros
CREATE OR REPLACE FUNCTION acc.asignar_periodo(INTEGER[],INTEGER,INTEGER) RETURNS text VOLATILE AS
$$
DECLARE
qty integer:= array_length($1,1);
respuesta varchar := null;
BEGIN
	FOR i IN 1..qty LOOP
		EXECUTE'UPDATE _'||$3||' SET periodo_tributario = '||$2||' WHERE id = '||$1[i];
	END LOOP;
	respuesta := 'Periodo '||$2||' asignado a '||qty||' comprobantes del subdiario '||$3;
RETURN respuesta;
END;
$$ LANGUAGE plpgsql;

--Trigger/Insertar CUI en subdiarios 2, 5 y 8
CREATE OR REPLACE FUNCTION fill_cui() RETURNS TRIGGER AS
$$
BEGIN
IF new.subdiario = 5 THEN
	NEW.cui = CONCAT(NEW.subdiario,ltrim(to_char(NEW.entity_id,'000')),ltrim(to_char(NEW.tipo_comprobante,'00')),NEW.numero_serie,NEW.numero_correlativo);

ELSIF new.subdiario = 8 THEN
	NEW.CUI = CONCAT(NEW.subdiario,NEW.numero_documento,ltrim(to_char(NEW.tipo_comprobante,'00')),NEW.numero_serie,NEW.numero_correlativo);
ELSIF new.subdiario = 2 THEN
	NEW.cui = CONCAT(NEW.subdiario,ltrim(to_char(NEW.entity_id,'000')),ltrim(to_char(entidad_financiera,'00')),numero_operacion);

END IF;
RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

--Trigger/Insertar cobro o pago según normativa de utilización de medios de pago (3500  antes del 01/04/2021, 2000 despues de esa fecha), descontando detraccion. 
CREATE OR REPLACE FUNCTION cash_payment() RETURNS TRIGGER AS $$
DECLARE
	movimiento INTEGER:= CASE WHEN NEW.subdiario = 5 THEN '1' ELSE '2' END;
	total DEC(10,2):= (CASE WHEN (NEW.subdiario = 5 AND NEW.destino <> 2) OR (NEW.subdiario = 8 AND NEW.destino <> 4) THEN 1.18*NEW.valor ELSE NEW.valor END) + NEW.isc + NEW.icbp + NEW.otros_cargos;
	total_mn DEC(10,2):= CASE WHEN NEW.tipo_moneda = 'USD' THEN (select usd_s from tc WHERE fecha_sunat = NEW.fecha_emision) * total ELSE total END ;
	importe DEC(10,2):= CASE WHEN NEW.tasa_detraccion IS NOT NULL THEN (total_mn - CEIL(total_mn * (SELECT tasa FROM spot WHERE codigo = NEW.tasa_detraccion))) ELSE total_mn END;
BEGIN
	
	IF total_mn<3000 AND NEW.medio_pago ISNULL AND NEW.fecha_emision < '2021-04-01'::date THEN
		INSERT INTO _1(entity_id,tipo_movimiento,cui_relacionado,fecha_operacion,importe, tipo_moneda) VALUES (NEW.entity_id, movimiento,NEW.cui, NEW.fecha_emision, importe, 'PEN');
	ELSIF total_mn<2000 AND NEW.medio_pago ISNULL AND NEW.fecha_emision >= '2021-04-01'::date THEN
		INSERT INTO _1(entity_id,tipo_movimiento,cui_relacionado,fecha_operacion,importe, tipo_moneda) VALUES (NEW.entity_id, movimiento, NEW.cui, NEW.fecha_emision, importe, 'PEN');
	END IF;
RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

--Trigger/Llenar tabla related con RUCs relaccionados no registrados
CREATE OR REPLACE FUNCTION fill_related() RETURNS TRIGGER AS
$$
BEGIN
	IF NEW.tipo_documento <> '0' AND NEW.numero_documento NOT IN (SELECT numero_documento FROM acc.related WHERE related.tipo_documento = NEW.tipo_documento) THEN INSERT INTO related(tipo_documento,numero_documento) VALUES(NEW.tipo_documento,NEW.numero_documento);
	END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Trigger/Registrar cambios realizados
CREATE OR REPLACE FUNCTION changes() RETURNS TRIGGER AS $$
   BEGIN
      INSERT INTO changeslog(usuario,subdiario,id,instante) VALUES (current_user, new.subdiario,new.id,now());
      RETURN NEW;
   END;
$$ LANGUAGE plpgsql;

--Trigger/Tratamiento de no domiciliados sin documento
CREATE OR REPLACE FUNCTION foreing_document() RETURNS TRIGGER AS
$$
DECLARE
document_number VARCHAR:= ltrim(to_char((SELECT count(numero_documento) +1 FROM related WHERE tipo_documento = '0'),'00000000000'));
BEGIN
IF NEW.tipo_documento = '0' THEN
	IF NEW.numero_documento ~'^[A-Z]{2}.*$' AND (SELECT numero_documento FROM related WHERE nombre_razon = NEW.numero_documento) IS NULL THEN
	INSERT INTO related(tipo_documento,numero_documento,nombre_razon) VALUES(NEW.tipo_documento,document_number,NEW.numero_documento);
	NEW.numero_documento = document_number;
	ELSIF NEW.numero_documento ~'^[A-Z]{2}.*$' AND (SELECT numero_documento FROM related WHERE nombre_razon = NEW.numero_documento) IS NOT NULL THEN
	NEW.numero_documento = (SELECT numero_documento FROM related WHERE nombre_razon = NEW.numero_documento);
	END IF;
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Trigger/Insertar registros de comercio exterior importacion/exportacion
CREATE OR REPLACE FUNCTION fill_itrade() RETURNS TRIGGER AS
$$
BEGIN
IF NEW.tipo_operacion = 17 OR NEW.tipo_operacion = 18 THEN
	INSERT INTO itrade(tipo_operacion,cui_relacionado,periodo_tributario) VALUES (NEW.tipo_operacion,NEW.cui,NEW.periodo_tributario);
END IF;
RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

--

--Trigger/Borrar pre registro de documentos de comercio exterior y prepagos de caja,detraccion cuando se emite nota de crédito por el importe total.

-- Trigger de funcion fill_cui
CREATE TRIGGER b_fill_cui5 BEFORE INSERT OR UPDATE ON acc._5 FOR EACH ROW EXECUTE PROCEDURE fill_cui();
CREATE TRIGGER b_fill_cui8 BEFORE INSERT OR UPDATE ON acc._8 FOR EACH ROW EXECUTE PROCEDURE fill_cui();
CREATE TRIGGER b_fill_cui8 BEFORE INSERT OR UPDATE ON acc._2 FOR EACH ROW EXECUTE PROCEDURE fill_cui();
--Trigger de funcion cash_payment
CREATE TRIGGER pago_caja AFTER INSERT ON acc._8 FOR EACH ROW EXECUTE PROCEDURE cash_payment();
CREATE TRIGGER cobro_caja AFTER INSERT ON acc._5 FOR EACH ROW EXECUTE PROCEDURE cash_payment();
--Trigger de funcion fill_related
CREATE TRIGGER fill_related05 AFTER INSERT ON acc._5 FOR EACH ROW EXECUTE PROCEDURE fill_related();
CREATE TRIGGER fill_related08 AFTER INSERT ON acc._8 FOR EACH ROW EXECUTE PROCEDURE fill_related();
--Trigger de funcion foreing_document
CREATE TRIGGER no_documento  BEFORE INSERT ON acc._5 FOR EACH ROW EXECUTE PROCEDURE foreing_document();
CREATE TRIGGER no_documento  BEFORE INSERT ON acc._8 FOR EACH ROW EXECUTE PROCEDURE foreing_document();
--Trigger de funcion fill_itrade
CREATE TRIGGER rellenar_itrade AFTER INSERT ON acc._5 FOR EACH ROW EXECUTE PROCEDURE fill_itrade();
CREATE TRIGGER rellenar_itrade AFTER INSERT ON acc._8 FOR EACH ROW EXECUTE PROCEDURE fill_itrade();
--Trigger de funcion changes
CREATE TRIGGER registrar_cambios AFTER UPDATE ON acc._1 FOR EACH ROW EXECUTE PROCEDURE changes();
CREATE TRIGGER registrar_cambios AFTER UPDATE ON acc._2 FOR EACH ROW EXECUTE PROCEDURE changes();
CREATE TRIGGER registrar_cambios AFTER UPDATE ON acc._5 FOR EACH ROW EXECUTE PROCEDURE changes();
CREATE TRIGGER registrar_cambios AFTER UPDATE ON acc._8 FOR EACH ROW EXECUTE PROCEDURE changes();
CREATE TRIGGER registrar_cambios AFTER UPDATE ON acc._9 FOR EACH ROW EXECUTE PROCEDURE changes();
CREATE TRIGGER registrar_cambios AFTER UPDATE ON acc._11 FOR EACH ROW EXECUTE PROCEDURE changes();
