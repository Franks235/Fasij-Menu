------------------------------------
---USUARIO
------------------------------------
-- Trigger que impide insertar un nuevo usuario con un id_usuario existente
DELIMITER //
CREATE TRIGGER before_insert_usuario
BEFORE INSERT ON usuario
FOR EACH ROW
BEGIN
    -- Verificar si el id_usuario ya existe en la tabla
    DECLARE existing_id INT;
    SELECT COUNT(*) INTO existing_id FROM usuario WHERE id_usuario = NEW.id_usuario;
    
    -- Si el id_usuario ya existe, lanzar un error y cancelar la inserción
    IF existing_id > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El id_usuario ya existe. No se puede insertar el nuevo usuario.';
    END IF;
END//
DELIMITER ;
--------------------------------
-- Trigger que impide insertar un nuevo usuario si el nombre comienza con una letra minúscula
DELIMITER //
CREATE TRIGGER insertar_usuario_no_minuscula
BEFORE INSERT ON usuario
FOR EACH ROW
BEGIN
    -- Verificar si el nombre del usuario comienza con una letra minúscula
    DECLARE first_letter CHAR(1);
    SET first_letter = LOWER(SUBSTRING(NEW.nombre_usuario, 1, 1));
    
    -- Si el nombre comienza con una letra minúscula, lanzar un error y cancelar la inserción
    IF first_letter = SUBSTRING(NEW.nombre_usuario, 1, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre del usuario debe comenzar con una letra mayúscula.';
    END IF;
END//
DELIMITER ;
----------------------------------
-- Trigger que impide insertar un nuevo usuario si el campo "cedula" está vacío
DELIMITER //
CREATE TRIGGER before_insert_usuario_check_cedula
BEFORE INSERT ON usuario
FOR EACH ROW
BEGIN
    -- Verificar si el campo "cedula" está vacío
    IF NEW.cedula IS NULL OR NEW.cedula = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede insertar un nuevo usuario sin especificar la cédula.';
    END IF;
END//
DELIMITER ;
------------------------------------
---PEDIDO
------------------------------------
DELIMITER //

CREATE TRIGGER check_fecha_pedido
BEFORE INSERT ON pedido
FOR EACH ROW
BEGIN
    IF NEW.fecha < '2023-01-01' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede insertar un pedido con fecha anterior al 1 de enero de 2023';
    END IF;
END //

DELIMITER ;
------------------------------------
DELIMITER //

CREATE TRIGGER check_pedido_description
BEFORE UPDATE ON pedido
FOR EACH ROW
BEGIN
    IF NEW.descripcion = '' OR NEW.descripcion IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El campo descripción no puede quedar vacío';
    END IF;
END //

DELIMITER ;
------------------------------------
DELIMITER //
CREATE TRIGGER validate_pedido_id
BEFORE UPDATE ON pedido
FOR EACH ROW
BEGIN
    IF NEW.id_pedido < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El ID de pedido no puede ser menor a 0.';
    END IF;
END //
DELIMITER ;
------------------------------------
---PAGO
------------------------------------
DELIMITER //

CREATE TRIGGER validar_metodo_pago
BEFORE UPDATE ON pago
FOR EACH ROW
BEGIN
    IF NEW.metodo_pago NOT IN ('nequi', 'efectivo', 'davidplata') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El método de pago no es válido. Los métodos permitidos son: nequi, efectivo, davidplata';
    END IF;
END //

DELIMITER ;
------------------------------------
DELIMITER //

CREATE TRIGGER validar_campos_pago_update
BEFORE UPDATE ON pago
FOR EACH ROW
BEGIN
    IF NEW.valor IS NULL OR NEW.valor = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El campo valor no puede estar vacío';
    END IF;

    IF NEW.metodo_pago IS NULL OR NEW.metodo_pago = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El campo metodo_pago no puede estar vacío';
    END IF;
END //

DELIMITER ;

------------------------------------
DELIMITER //

CREATE TRIGGER validar_valor_pago
BEFORE UPDATE ON pago
FOR EACH ROW
BEGIN
    IF NEW.valor < 10000 OR NEW.valor > 1000000 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El valor de pago debe estar entre 10000 y 1000000';
    END IF;
END //

DELIMITER ;
------------------------------------
---PRODUCTO
------------------------------------
DELIMITER //

CREATE TRIGGER validar_nombre_producto
BEFORE INSERT ON producto
FOR EACH ROW
BEGIN
    IF NEW.nombre IS NULL OR NEW.nombre = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El campo nombre no puede estar vacío';
    END IF;
END //

DELIMITER ;
------------------------------------
DELIMITER //

CREATE TRIGGER validar_cantidad_disponible_producto
BEFORE UPDATE ON producto
FOR EACH ROW
BEGIN
    IF NEW.cantidad_disponible < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El campo cantidad disponible no puede ser menor a cero';
    END IF;
END //

DELIMITER ;
------------------------------------
DELIMITER //

CREATE TRIGGER validar_limite_cantidad_producto
BEFORE UPDATE ON producto
FOR EACH ROW
BEGIN
    IF NEW.cantidad_disponible > 100 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La cantidad disponible está sobrepasando el límite admitido';
    END IF;
END //

DELIMITER ;
------------------------------------
---FACTURA
------------------------------------
DELIMITER //

CREATE TRIGGER validar_subtotal
BEFORE INSERT ON factura
FOR EACH ROW
BEGIN
    IF NEW.subtotal < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El campo subtotal no puede ser menor a cero';
    END IF;
END //

DELIMITER ;
------------------------------------
DELIMITER //

CREATE TRIGGER validar_fecha_factura
BEFORE UPDATE ON factura
FOR EACH ROW
BEGIN
    IF NEW.fecha < '2023-01-01' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se permite una fecha anterior a 2023-01-01 para la tabla factura';
    END IF;
END //

DELIMITER ;
------------------------------------
DELIMITER //

CREATE TRIGGER validar_propina_factura
BEFORE UPDATE ON factura
FOR EACH ROW
BEGIN
    IF NEW.propina <> OLD.propina THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se permite cambiar el valor de la propina en la tabla factura';
    END IF;
END //

DELIMITER ;
------------------------------------
---TIPO_PRODUCTO
------------------------------------
DELIMITER $$
CREATE TRIGGER before_delete_tipo_producto
BEFORE DELETE ON tipo_producto
FOR EACH ROW
BEGIN
    DECLARE product_count INT;
    SET product_count = (SELECT COUNT(*) FROM producto WHERE id_tipo_producto = OLD.id_tipo_producto);
    IF product_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede eliminar el tipo de producto porque existen productos asociados.';
    END IF;
END$$
DELIMITER ;
------------------------------------
DELIMITER //
CREATE TRIGGER before_update_tipo_producto
BEFORE UPDATE ON tipo_producto
FOR EACH ROW
BEGIN
    IF NEW.categoria <> OLD.categoria THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede actualizar el nombre de la categoría.';
    END IF;
END //
DELIMITER ;
------------------------------------
DELIMITER //
CREATE TRIGGER before_insert_tipo_producto
BEFORE INSERT ON tipo_producto
FOR EACH ROW
BEGIN
    DECLARE first_char CHAR(1);
    SET first_char = SUBSTRING(NEW.categoria, 1, 1);
    IF first_char NOT REGEXP '[a-z]' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La categoría debe comenzar con una letra minúscula.';
    END IF;
END //
DELIMITER ;
------------------------------------
---menu_personalizado
------------------------------------
DELIMITER //
CREATE TRIGGER before_insert_menu_personalizado
BEFORE INSERT ON menu_personalizado
FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT 1 FROM almuerzo_dia WHERE id_almuerzo_dia = NEW.id_almuerzo_dia) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El almuerzo del día no existe.';
    END IF;
END //
DELIMITER ;
------------------------------------
DELIMITER //

CREATE TRIGGER validar_id_pedido
BEFORE INSERT ON menu_personalizado
FOR EACH ROW
BEGIN
    IF NEW.id_pedido IS NULL OR NEW.id_pedido = '' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El campo id_pedido no puede quedar vacío.';
    END IF;
END //

DELIMITER ;
------------------------------------
DELIMITER //

CREATE TRIGGER validar_id_almuerzo_dia
BEFORE INSERT ON menu_personalizado
FOR EACH ROW
BEGIN
    DECLARE count_rows INT;

    SELECT COUNT(*) INTO count_rows
    FROM menu_personalizado
    WHERE id_almuerzo_dia = NEW.id_almuerzo_dia;

    IF count_rows > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El campo id_almuerzo_dia ya existe en la tabla.';
    END IF;
END //

DELIMITER ;
------------------------------------
---almuerzo_dia
------------------------------------
DELIMITER //

CREATE TRIGGER validar_descripcion_almuerzo
BEFORE UPDATE ON almuerzo_dia
FOR EACH ROW
BEGIN
    IF NEW.descripcion = '' OR NEW.descripcion IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La descripción del almuerzo no puede quedar vacía.';
    END IF;
END //

DELIMITER ;
------------------------------------
DELIMITER //

CREATE TRIGGER validar_actualizacion_id_almuerzo_dia
BEFORE UPDATE ON almuerzo_dia
FOR EACH ROW
BEGIN
    IF NEW.id_almuerzo_dia < 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El valor del campo id_almuerzo_dia no puede ser menor a 0.';
    END IF;
END //

DELIMITER ;
------------------------------------
DELIMITER //

CREATE TRIGGER validar_actualizacion_almuerzo_dia
BEFORE UPDATE ON almuerzo_dia
FOR EACH ROW
BEGIN
    IF NEW.descripcion IS NULL OR NEW.descripcion = '' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se permite dejar la descripción vacía al actualizar en la tabla almuerzo_dia.';
    END IF;
END //

DELIMITER ;
------------------------------------
---producto_almuerzo_dia
------------------------------------


