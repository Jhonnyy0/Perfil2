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
ADD CONSTRAINT fk_cliente_prestamo FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente);

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

DELIMITER //

CREATE PROCEDURE insert_libro_genero(
    IN p_titulo_libro VARCHAR(50),
    IN p_anio_publicacion INT,
    IN p_nombre_genero_libro VARCHAR(50),
    IN p_estado ENUM('disponible', 'prestado')
)
BEGIN
    DECLARE genero_id BINARY(16);
    DECLARE libro_id BINARY(16);

    INSERT INTO generos_libros (id_genero_libro, nombre_genero_libro)
    VALUES (UUID(), p_nombre_genero_libro);
    
    SET genero_id = LAST_INSERT_ID();
    
    INSERT INTO libros (id_libro, titulo_libro, anio_publicacion, id_genero_libro, estado)
    VALUES (UUID(), p_titulo_libro, p_anio_publicacion, genero_id, p_estado);
    
    SET libro_id = LAST_INSERT_ID();
    
    SELECT genero_id, libro_id;
END //

DELIMITER ;

CALL insert_libro_genero('Cien años de soledad', 1967, 'Realismo mágico', 'disponible');
CALL insert_libro_genero('El amor en los tiempos del cólera', 1985, 'Realismo mágico', 'disponible');
CALL insert_libro_genero('Crónica de una muerte anunciada', 1981, 'Realismo mágico', 'disponible');
CALL insert_libro_genero('La casa de los espíritus', 1982, 'Realismo mágico', 'disponible');
CALL insert_libro_genero('Rayuela', 1963, 'Realismo mágico', 'disponible');
CALL insert_libro_genero('Pedro Páramo', 1955, 'Realismo mágico', 'disponible');
CALL insert_libro_genero('Aura', 1962, 'Realismo mágico', 'disponible');
CALL insert_libro_genero('La ciudad y los perros', 1963, 'Realismo mágico', 'disponible');
CALL insert_libro_genero('Los detectives salvajes', 1998, 'Realismo mágico', 'disponible');
CALL insert_libro_genero('La fiesta del chivo', 2000, 'Realismo mágico', 'disponible');
CALL insert_libro_genero('El túnel', 1948, 'Realismo mágico', 'disponible');
CALL insert_libro_genero('La sombra del viento', 2001, 'Realismo mágico', 'disponible');
CALL insert_libro_genero('El laberinto de los espíritus', 2016, 'Realismo mágico', 'disponible');
CALL insert_libro_genero('Los renglones torcidos de Dios', 2008, 'Realismo mágico', 'disponible');


DELIMITER //

CREATE PROCEDURE insert_cliente_prestamo(
    IN p_nombre_cliente VARCHAR(50),
    IN p_email_cliente VARCHAR(100),
    IN p_telefono VARCHAR(10),
    IN p_fecha_inicio DATE,
    IN p_fecha_devolucion DATE,
    IN p_estado ENUM('activo', 'inactivo')
)
BEGIN
    DECLARE cliente_id BINARY(16);
    DECLARE prestamo_id BINARY(16);

    INSERT INTO clientes (id_cliente, nombre_cliente, email_cliente, telefono)
    VALUES (UUID(), p_nombre_cliente, p_email_cliente, p_telefono);
    
    SET cliente_id = LAST_INSERT_ID();
    
    INSERT INTO prestamos (id_prestamo, id_cliente, fecha_inicio, fecha_devolucion, estado)
    VALUES (UUID(), cliente_id, p_fecha_inicio, p_fecha_devolucion, p_estado);
    
    SET prestamo_id = LAST_INSERT_ID();
    
    SELECT cliente_id, prestamo_id;
END //

DELIMITER ;

CALL insert_cliente_prestamo('María García', 'mariagarcia@email.com', '1234567890', '2024-03-01', '2024-03-15', 'activo');
CALL insert_cliente_prestamo('José Martínez', 'josemartinez@email.com', '9876543210', '2024-03-05', '2024-03-20', 'activo');
CALL insert_cliente_prestamo('Ana López', 'analopez@email.com', '555444333', '2024-03-10', '2024-03-25', 'inactivo');
CALL insert_cliente_prestamo('Carlos Rodríguez', 'carlosrodriguez@email.com', '333222111', '2024-03-15', '2024-03-30', 'activo');
CALL insert_cliente_prestamo('Laura Sánchez', 'laurasanchez@email.com', '999888777', '2024-03-20', '2024-04-05', 'inactivo');
CALL insert_cliente_prestamo('Luis Martínez', 'luismartinez@email.com', '777666555', '2024-03-25', '2024-04-10', 'activo');
CALL insert_cliente_prestamo('Elena Gómez', 'elenagomez@email.com', '222333444', '2024-03-30', '2024-04-15', 'activo');
CALL insert_cliente_prestamo('Javier Pérez', 'javierperez@email.com', '111222333', '2024-04-01', '2024-04-16', 'inactivo');
CALL insert_cliente_prestamo('Laura Martínez', 'lauramartinez@email.com', '555666777', '2024-04-05', '2024-04-20', 'activo');
CALL insert_cliente_prestamo('Sofía Sánchez', 'sofiasanchez@email.com', '999888777', '2024-04-10', '2024-04-25', 'activo');
CALL insert_cliente_prestamo('Diego Rodríguez', 'diegorodriguez@email.com', '777666555', '2024-04-15', '2024-04-30', 'activo');
CALL insert_cliente_prestamo('Marta Gómez', 'martagomez@email.com', '222333444', '2024-04-20', '2024-05-05', 'inactivo');
CALL insert_cliente_prestamo('Gabriel Pérez', 'gabrielperez@email.com', '111222333', '2024-04-25', '2024-05-10', 'activo');
CALL insert_cliente_prestamo('Carla Martínez', 'carlamartinez@email.com', '555666777', '2024-04-30', '2024-05-15', 'activo');