-- Creacion de base de datos

CREATE DATABASE restaurantes;
use restaurantes;


-- Creacion de tablas 

CREATE TABLE usuario(
    id_usuario int(100) PRIMARY KEY,
    nombre_usuario varchar(30),
    cedula int(10)
);

CREATE TABLE pedido(
    id_pedido int(100) PRIMARY KEY,
    id_usuario int(100),
    fecha date,
    descripcion varchar(20),

    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE factura(
    id_factura int(100) PRIMARY KEY,
    id_pedido int(100),
    fecha date,
    subtotal int(6),
    propina int(6),
    total int(6),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);

CREATE TABLE pago(
    id_pago INT(100) PRIMARY KEY,
    id_factura INT(10),
    metodo_pago VARCHAR(20),
    valor int (6),
    FOREIGN KEY (id_factura) REFERENCES factura(id_factura)
);


CREATE TABLE tipo_producto(
    id_tipo_producto INT(100) PRIMARY KEY,
    categoria VARCHAR(20)
);

CREATE TABLE producto(
    id_producto INT(100) PRIMARY KEY,
    id_tipo_producto INT(100),
    nombre VARCHAR(20),
    cantidad_disponible INT (20),
    
    FOREIGN KEY (id_tipo_producto) REFERENCES tipo_producto(id_tipo_producto)
);


CREATE TABLE almuerzo_dia(
    id_almuerzo_dia INT(100) PRIMARY KEY,
    descripcion VARCHAR(200)
);


CREATE TABLE producto_almuerzo_dia(
    id_producto_almuerzo_dia INT(100) PRIMARY KEY,
    id_almuerzo_dia INT(10),
    id_producto INT(10),
    cantidad_disponible INT(3),	

    FOREIGN KEY (id_almuerzo_dia) REFERENCES almuerzo_dia(id_almuerzo_dia),
    FOREIGN KEY (id_producto) REFERENCES producto (id_producto)
);

CREATE TABLE menu_personalizado(
    id_menu_personalizado INT(100) PRIMARY KEY,
    id_almuerzo_dia INT(100),
    id_pedido INT(100),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_almuerzo_dia) REFERENCES almuerzo_dia(id_almuerzo_dia)
);



-- incercion de datos: 


-- datos usuario

INSERT INTO `usuario`(`id_usuario`, `nombre_usuario`, `cedula`) 
VALUES
      (0,'Laura Ortiz',25299233 ),
      (1,'Alonso Navarroo',68732109 ),
      (2,'Alejo Guerrero',1002514867 ),
      (3,'María Yolanda',1002312345 ),
      (4,'María Ofelia',74125896 ),
      (5,'Gerardo Genaro',1001312874 ),
      (6,'Víctor Hugo',87653210 ),
      (7,'Javier Leonardo',1002113654 ),
      (8,'Miguel Ángel',64589127 ),
      (9,'Mario Andrés',1002913874 ),
      (10,'Luis Alberto',97845623 ),
      (11,'Sandra Verónica',1003114567 ),
      (12,' María de Lourdes',76543219 ),
      (13,'Mayra del Carmen',1002713654 ),
      (14,'Manuel Augusto',95876321 );


-- pedido

INSERT INTO `pedido`(`id_pedido`, `id_usuario`, `fecha`, `descripcion`) VALUES 
    (0,1,'2023-04-23','arroz bajo en sal'),
    (1,2,'2023-04-25','caldo sin sal'),
    (2,0,'2023-04-25','normal'),
    (3,5,'2023-04-25','sin jugo'),
    (4,4,'2023-04-27','normal'),
    (5,6,'2023-04-27','sin jugo'),.
    (6,8,'2023-04-26','normal'),
    (7,9,'2023-04-28','sin jugo'),
    (8,7,'2023-05-01','normal'),
    (9,10,'2023-05-01','sin sopa'),
    (10,12,'2023-05-01','arros bajo en sal'),
    (11,14,'2023-05-03','sin arroz'),
    (12,13,'2023-05-04','normal'),
    (13,11,'2023-05-05','normal'),
    (14,3,'2023-06-07','sin sopa');

-- datos tipo producto

INSERT INTO `tipo_producto`(`id_tipo_Producto`, `categoria`) 
VALUES 
       (0,'principios'),
       (1,'sopas'),
       (2,'jugos'),
       (3,'proteinas'),
       (4,'arroces');

-- datos producto

INSERT INTO `producto`(`id_producto`, `id_tipo_producto`, `nombre`, `cantidad_disponible`)
VALUES  (0,0,'lentejas',50),
        (1,0,'frijoles',40),
        (2,4,'arroz Mixto',40),
        (3,4,'arroz',50),
        (4,4,'arroz Integral',50),
        (5,0,'papas fritas',50),
        (6,2,'limonada',50),
        (7,2,'limococo',30),
        (8,2,'limomango',30),
        (9,2,'jugomora',50),
        (10,2,'jugofresa',20),
        (11,3,'carne Res',50),
        (12,3,'carne de Cerdo',50),
        (13,3,'tofu',50),
        (14,3,'pollo',40),
        (15,1,'consome',40),
        (16,1,'sancocho',30),
        (17,1,'caldo de pescado',30),
        (18,1,'caldo de costilla',30),
        (19,1,'ajiaco',40);

-- almuerzo dia 

INSERT INTO `almuerzo_dia`(`id_almuerzo_dia`, `descripcion`) 
VALUES  
    (0,'arroz, pollo, limonada, caldo de pescado,lentejas'),
    (1,'arroz mixto, carne de cerdo, limococo, caldo de costilla,lenteja'),
    (2,'arroz integral , pollo, limococo, consome,frijol'),
    (3,'arroz, pollo, limonada ,papas'),
    (4,'arroz integral, carne  res, limo mango, caldo de pescado, lentejas'),
    (5,'arroz, pollo, limonada, ajiaco, frijoles'),
    (6,'arroz, tofu, limomango, papas'),
    (7,'arroz, pollo, limonada, caldo de pescado,frijoles'),
    (8,'arroz, carne de res, jugo de mora,papas'),
    (9,'arroz integral, tofu, limonada, consome, frijoles'),
    (10,'arroz, pollo, jugo mora, caldo de costilla'),
    (11,'arroz mixto, res, jugo fresa, caldo de consome'),
    (12,'arroz mixto, tofu, limonada, consome, lentejas'),
    (13,'arroz integral, carne de res, limonada, caldo de pescado, frijoles'),
    (14,'arroz, carne de cerdo, limonada, sancocho, papas a la francesa');

-- producto almuerzo dia 

INSERT INTO `producto_almuerzo_dia`(`id_producto_almuerzo_dia`, `id_almuerzo_dia`, `id_producto`, `cantidad_disponible`)
VALUES 	
        (0, 0, 3, 49),
        (1, 0, 14, 39),
        (2, 0, 6, 49),
        (3, 0, 17, 29),
        (4, 0, 0, 49),
        (5, 1, 2, 39),
        (6, 1, 12, 49),
        (7, 1, 7, 29),
        (8, 1, 18, 29),
        (9, 1, 0, 48),
        (10, 2, 4, 49),
        (11, 2, 14, 38),
        (12, 2, 7, 28),
        (13, 2, 15, 39),
        (14, 2, 1, 39),
        (15, 3, 3, 48),
        (16, 3, 14, 37),
        (17, 3, 6, 48),
        (18, 3, 5, 49),
        (19, 6, 3, 47),
        (20, 6, 13, 19),
        (21, 6, 8, 29),
        (22, 6, 5, 48),
        (23, 8, 3, 46),
        (24, 8, 11, 49),
        (25, 8, 9, 49),
        (26, 8, 5, 47);


-- menu personalizado 

INSERT INTO `menu_personalizado`(`id_menu_personalizado`, `id_almuerzo_dia`, `id_pedido`) 
VALUES  (0,0,1),
        (1,1,8),
        (2,2,0),
        (3,3,6),
        (4,4,1),
        (5,5,3),
        (6,6,2),
        (7,7,3),
        (8,8,8),
        (9,9,3),
        (10,10,0),
        (11,11,1),
        (12,12,1),
        (13,13,0),
        (14,14,6);

-- datos factura

INSERT INTO `factura`(`id_factura`, `id_pedido`, `fecha`, `subtotal`, `propina`, `total`) 
VALUES  (0,2,'2023-04-25',20000,2000,22000),
        (1,3,'2023-04-25',15000,2000,17000),
        (2,4,'2023-04-27',20000,2000,22000),
        (3,6,'2023-04-28',20000,2000,22000),
        (4,8,'2023-05-01',20000,2000,22000),
        (5,9,'2023-05-01',15000,2000,17000),
        (6,10,'2023-05-01',20000,2000,22000),
        (7,11,'2023-05-03',15000,2000,17000),
        (8,7,'2023-04-28',15000,2000,17000),
        (9,12,'2023-05-03',20000,2000,22000),
        (10,1,'2023-04-25',20000,2000,22000),
        (11,0,'2023-04-23',20000,2000,22000),
        (12,14,'2023-06-07',15000,2000,17000),
        (13,5,'2023-04-27',15000,2000,17000),
        (14,13,'2023-05-05',20000,2000,22000);


-- datos pago

INSERT INTO `pago`(`id_pago`, `id_factura`, `metodo_pago`, `valor`)
VALUES  (0,14,'nequi',22000),
        (1,12,'efectivo',17000),
        (2,10,'davidplata',22000),
        (3,8,'nequi',17000),
        (4,6,'efectivo',22000),
        (5,4,'efectivo',22000),
        (6,3,'davidplata',22000),
        (7,1,'efectivo',17000),
        (8,0,'nequi',22000),
        (9,5,'nequi',17000),
        (10,7,'nequi',17000),
        (11,9,'davidplata',22000),
        (12,2,'davidplata',22000),
        (13,11,'davidplata',22000),
        (14,13,'efectivo',17000);


-- consultas:

-- Necesito obtener los valores totales más altos de las facturas correspondientes a la venta de 
-- almuerzos en mi restaurante. Quiero tener una idea clara de cuáles son las ventas más importantes 
-- y así poder tomar decisiones basadas en esta información

SELECT * FROM factura WHERE total=(SELECT MAX(total)FROM factura);

-- Necesito obtener los valores totales más altos de las facturas correspondientes a la venta de 
-- almuerzos en mi restaurante. Quiero tener una idea clara de cuáles son las ventas más importantes 
-- y así poder tomar decisiones basadas en esta información

SELECT * FROM factura WHERE total=(SELECT MIN(total)FROM factura);

-- necesito comprar prodcutos y necesito tener encuenta que productos no debo comprar porque ya estan
-- los suficientes

SELECT * FROM producto WHERE cantidad_disponible = (SELECT MAX(cantidad_disponible) FROM producto);

-- necesito comprar prodcutos y necesito tener encuenta que productos que esten por una cantidad 
-- inferior a 35 

SELECT * FROM producto WHERE cantidad_disponible < 35;

-- queremos regalar una promocion a nuestros usuarios registrados pero antes necesitamos saber 
-- la cantidad para asi tener una idea de cuanto se va a gastar 
SELECT COUNT(*) AS total_usuarios FROM usuario;


"esta tiene el objetivo de mostrar la suma total con cada metodo de pago "
SELECT metodo_pago, SUM(valor) AS total_pago FROM pago GROUP BY metodo_pago;



-- cuento con pago erroneo de una factura y necesito filtara las facturas que se hicieron en una fecha
-- determinada para poder resolver el problema 

SELECT COUNT(*) AS total_facturas FROM factura  WHERE fecha = '2023-05-01';

-- necesito buscar un usuario no recuerdo su nombre muy bien necesito hacer un filtro de nombres con 
-- letra m

SELECT * FROM usuario WHERE nombre_usuario LIKE 'M%';

-- necesito encontrar solo las facturas que esten por un rango superior a los 18000
SELECT * FROM factura WHERE total > 18000;

-- necesito descartar algunos productos para ello necesito saber que productos seleccionaron los 
-- clientes en el mes numero 5
SELECT fecha FROM pedido WHERE MONTH(fecha) = 5;



-- consultas join: 

/*1) aqui se busca conocer cual es el numero de productos que dispoonen de la mayor,menor y 
media de las cantidades de unidades disponibles por los productos que estan registrasdos*/
SELECT 
  (SELECT COUNT(*) FROM producto WHERE cantidad_disponible = (SELECT MAX(cantidad_disponible) FROM producto)) AS cantidad_mayor,
  (SELECT COUNT(*) FROM producto WHERE cantidad_disponible = (SELECT MIN(cantidad_disponible) FROM producto)) AS cantidad_menor,
  COUNT(*) AS cantidad_entre
FROM producto
WHERE cantidad_disponible > (SELECT MIN(cantidad_disponible) FROM producto)
  AND cantidad_disponible < (SELECT MAX(cantidad_disponible) FROM producto);


/*2) en esta consulta se busca entre la tabla producto y la tabla tipo producto se buscan los productos que corresponden a la categoria de jugos
(porque quiero saber cual o cuales son los jugos mas pedidos y cuales no tanto para saber a que jugos se debe aumentar las unidades para los clientes*/
SELECT * FROM producto JOIN tipo_producto ON producto.id_tipo_producto = tipo_producto.id_tipo_producto
WHERE tipo_producto.categoria = 'jugos';

/* 3) en esta consulta entre la tabla usuario y pedido buscamos datos especificos entre las dos
para conocer y saber que usuario pidio en cierta fecha(hay un problema con un pedido de un 
cliente por ende necesito a los usuarios que pidieron en una cierta fecha logrando haci identificar y resolver
el problema.)*/

SELECT u.id_usuario, u.nombre_usuario, p.fecha
FROM usuario u
JOIN pedido p ON u.id_usuario = p.id_usuario;

/* 4)aqui se busca hacer entre las dos tablas de factura y pago para buscar la factura y buscar 
cual fue el metodo de pago que se uso para realizar el pago de la factura y visualizar el total
que corresponde a esa factura*/
SELECT f.id_factura, p.metodo_pago, f.total
FROM factura f
JOIN pago p ON f.id_factura = p.id_factura;


/*5)Aquí lo que se busca hacer es juntar a los pedidos con las mismas descripcion y los demas pedidos que en su descripcion
son distintos y de esa forma saber como los clientes hacen sus pedidos de la manera mas comun o popular.*/
SELECT descripcion, COUNT(*) AS cantidad_pedidos
FROM pedido
GROUP BY descripcion;

/*6)lo que se busca es poder conocer cuales son las sopas que estan disponibles para que de esa forma se pueda
saber que sopas hay, para de esa manera poder cambiarlas y poder ofrecer nuevas sopas en un futuro */
SELECT producto.nombre, producto.cantidad_disponible
FROM producto 
JOIN tipo_producto ON producto.id_tipo_producto = tipo_producto.id_tipo_producto
WHERE tipo_producto.categoria = 'sopas';


/*7)esta nos da el nombre de la persona que pidieron la misma descripcion en su pedido por ejemplo por clientes que hicieron su pedido sin jugo*/
SELECT DISTINCT nombre_usuario FROM usuario JOIN pedido ON usuario.id_usuario = pedido.id_usuario WHERE descripcion = 'sin jugo';
--SELECT DISTINCT se utiliza en una consulta para seleccionar solamente los valores distintos o únicos de una columna en una tabla


-- 8) como aniversario de la empresa, queremos compensar a nuesteros clientes, debido a que 
-- cumplimos cada 27 queremos regalar un premio al azar pero solo sera con lso usuarios que 
-- han comprado aquel dia 27 de cualquier mes. el priero de los clientes que compre al dia 
-- despues de la notificacion sera acredor del permio.

SELECT usuario.nombre_usuario, pedido.fecha FROM usuario JOIN pedido ON usuario.id_usuario = pedido.id_usuario WHERE DAY(fecha) = 27

/*9) necesitamos analizar cuales son los pedidos en los cuales las personas no prefieren un 
tipo de alimento y por ende analizar si se les desconto correctamente un valor apropiado para
su pedio.*/
SELECT u.nombre_usuario, p.descripcion, f.total
FROM usuario u
JOIN pedido p ON u.id_usuario = p.id_usuario
JOIN factura f ON p.id_pedido = f.id_pedido;

/*10) aqui obtenes la tabla donde nos permite ver cuantas unidades quedan de cada producto registrado y cuantas de unidades de ese producto se usaron
para que de esa forma se pueda llevar la cuenta de como se van gastando los productos mediante los pedidos de los almuerzos de vayan dando(tabla producto y tabla producto_almuerzo_dia)*/
SELECT p.id_producto, p.nombre, MIN(pad.cantidad_disponible) AS cantidad_minima, (p.cantidad_disponible - MIN(pad.cantidad_disponible)) AS unidades_gastadas
FROM producto_almuerzo_dia pad
JOIN producto p ON pad.id_producto = p.id_producto
GROUP BY p.id_producto, p.nombre;

SELECT p.id_producto, p.nombre, MIN(pad.cantidad_disponible) AS cantidad_minima
FROM producto_almuerzo_dia pad
JOIN producto p ON pad.id_producto = p.id_producto
GROUP BY p.id_producto, p.nombre;


/*11)aqui lo que buscamos es conocer la descripcion de cada almuerzo y que nos brinde la cantidad o numero de prductos conforma a ese almuerzo
para haci llevar una cuenta de cuanto productos se estan sirviendo por almuerzo*/
SELECT ad.descripcion, COUNT(p.id_producto) AS cantidad_productos
FROM almuerzo_dia ad
JOIN producto_almuerzo_dia pad ON ad.id_almuerzo_dia = pad.id_almuerzo_dia
JOIN producto p ON pad.id_producto = p.id_producto
GROUP BY ad.descripcion;












