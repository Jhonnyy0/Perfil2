

DROP DATABASE IF EXISTS libro_express;

CREATE DATABASE libro_express;

USE libro_express;

CREATE TABLE clientes(
id_cliente BINARY(36) PRIMARY KEY DEFAULT UUID(),
nombre_cliente VARCHAR (50),
email_cliente VARCHAR (100),
telefono VARCHAR(10)
);

CREATE TABLE prestamos(
id_prestamo BINARY(36) PRIMARY KEY DEFAULT UUID(),
id_cliente BINARY,
fecha_inicio DATE,
fecha_devolucion DATE,
estado ENUM("activo", "inactivo")
);

ALTER TABLE prestamos
ADD CONSTRAINT fk_prestamo_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente);

 CREATE TABLE generos_libros(
 id_genero_libro BINARY(36) PRIMARY KEY DEFAULT UUID(),
 nombre_genero_libro VARCHAR (50)
 );

 CREATE TABLE libros(
 id_libro BINARY(36) PRIMARY KEY DEFAULT UUID(),
 titulo_libro VARCHAR (50),
 anio_publicacion INT,
 id_genero_libro BINARY,
 estado ENUM("disponible","prestado")
 );
 
 ALTER TABLE libros
ADD CONSTRAINT fk_genero_libro FOREIGN KEY (id_genero_libro) REFERENCES generos_libros(id_genero_libro);
 
 CREATE TABLE detalles_pretamos(
 id_detalle_prestamo BINARY(36) PRIMARY KEY DEFAULT UUID(),
 id_prestamo BINARY,
 id_libro BINARY
 );
 
 ALTER TABLE  detalles_pretamos
 ADD CONSTRAINT fk_prestamo_detalle FOREIGN KEY (id_prestamo) REFERENCES prestamos(id_prestamo);
 
 ALTER TABLE detalles_pretamos
ADD CONSTRAINT fk_detalle_libro FOREIGN KEY (id_libro) REFERENCES libros(id_libro);

delimiter //
 
CREATE PROCEDURE insertar_datos_prestamos(
	IN nombre_cliente VARCHAR(50),
	IN fecha_inicio DATE,
	IN fecha_devolucion DATE,
	IN estado ENUM ('activo','inactivo')
BEGIN 
	INSERT INTO clientes
	VALUES
END
//



