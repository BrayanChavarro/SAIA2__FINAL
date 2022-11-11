-- ----------------------------------------------------
-- Schema SAIA
-- -----------------------------------------------------
CREATE SCHEMA SAIA DEFAULT CHARACTER SET utf8 ;
USE SAIA ;
-- -----------------------------------------------------
-- Table Clientes
-- -----------------------------------------------------
CREATE TABLE Clientes (
  documento VARCHAR(30) NOT NULL,
  apellidos VARCHAR(100) NOT NULL,
  nombres VARCHAR(100) NOT NULL,
  email VARCHAR(150) NULL,
  direccion VARCHAR(80) NULL,
  Telefono VARCHAR(50) NOT NULL,
  PRIMARY KEY (documento))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table pedidos
-- -----------------------------------------------------
CREATE TABLE pedidos (
  numero_pedido VARCHAR(10) NOT NULL,
  fecha_pedido DATE NOT NULL,
  total_si DECIMAL(10,2) NOT NULL,
  iva_pedido DECIMAL(10,2),
  total_ci DECIMAL(10,2) NOT NULL,
  documento_cliente VARCHAR(30) NOT NULL,
  PRIMARY KEY (numero_pedido),
  INDEX ind_clientes_pedidos (documento_cliente ASC),
  CONSTRAINT fk_clientes_pedidos
    FOREIGN KEY (documento_cliente)
    REFERENCES Clientes (documento)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Vehiculos
-- -----------------------------------------------------
CREATE TABLE  Vehiculos (
  placa VARCHAR(15) NOT NULL,
  marca VARCHAR(25) NULL,
  modelo VARCHAR(50) NULL,
  tipo VARCHAR(50) NULL,
  documento_cliente VARCHAR(30) NOT NULL,
  PRIMARY KEY (placa),
  INDEX ind_clientes_vehiculos (documento_cliente ASC),
  CONSTRAINT fk_clientes_vehiculos
    FOREIGN KEY (documento_cliente)
    REFERENCES Clientes (documento)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Roles
-- -----------------------------------------------------
CREATE TABLE  Roles (
  id INT(10) NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(25) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Usuarios
-- -----------------------------------------------------
CREATE TABLE  Usuarios (
  documento VARCHAR(30) NOT NULL,
  apellidos VARCHAR(100) NOT NULL,
  nombres VARCHAR(100) NOT NULL,
  email VARCHAR(80) NOT NULL,
  contraseña VARCHAR(50) NOT NULL,
  telefono VARCHAR(25) NULL,
  id_rol INT(10) NOT NULL,
  PRIMARY KEY (documento),
  INDEX ind_roles_usuarios (id_rol ASC),
  CONSTRAINT fk_roles_usuarios
    FOREIGN KEY (id_rol)
    REFERENCES Roles (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Servicios
-- -----------------------------------------------------
CREATE TABLE  servicios (
  id INT(15) NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(80) NOT NULL,
  PRIMARY KEY (id))

ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table ordenes_de_servicio
-- -----------------------------------------------------
CREATE TABLE  ordenes_de_servicio (
  id INT(10) NOT NULL AUTO_INCREMENT,
  fecha_entrada DATE NOT NULL,
  fecha_salida DATE NULL,
  diagnostico VARCHAR(250) NOT NULL,
  documento_usuario VARCHAR(30) NOT NULL,
  placa_vehiculo VARCHAR(10) NOT NULL,
  id_servicio INT(15) NOT NULL,
  PRIMARY KEY (id),
  INDEX ind_usuarios_orden_servicio (documento_usuario ASC),
  INDEX ind_vechiculos_orden_servicio (placa_vehiculo ASC),
  INDEX servicios_ind_ordenes_servicio (id_servicio ASC),
  CONSTRAINT fk_usuarios_ordenes_servicio
    FOREIGN KEY (documento_usuario)
    REFERENCES Usuarios (documento)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_vehiculos_ordenes_servicio
    FOREIGN KEY (placa_vehiculo)
    REFERENCES Vehiculos (placa)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_servicios_ordenes_servicio
    FOREIGN KEY (id_servicio)
    REFERENCES servicios (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Descripciones
-- -----------------------------------------------------
CREATE TABLE  Descripciones (
  id INT(15) NOT NULL AUTO_INCREMENT,
  fecha DATETIME NOT NULL,
  descripcion VARCHAR(750) NOT NULL,
  id_orden_servicio INT(10) NOT NULL,
  PRIMARY KEY (id),
  INDEX ind_orden_servicio_descripcion (id_orden_servicio ASC),
  CONSTRAINT fk_ordenes_servicio_descripciones
    FOREIGN KEY (id_orden_servicio)
    REFERENCES ordenes_de_servicio (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Documentos_contrato
-- -----------------------------------------------------
CREATE TABLE  Documentos_contrato (
  id INT(10) NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(100) NOT NULL,
  documento LONGBLOB NOT NULL,
  fecha DATE NULL,
  documento_usuario VARCHAR(30) NOT NULL,
  PRIMARY KEY (id),
  INDEX ind_usuarios_documentos_contrato (documento_usuario ASC),
  CONSTRAINT fk_usuarios_documentos_contraro
    FOREIGN KEY (documento_usuario)
    REFERENCES Usuarios (documento)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table proveedores
-- -----------------------------------------------------
CREATE TABLE  proveedores (
  nit VARCHAR(50) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  direccion VARCHAR(80) NULL,
  email VARCHAR(100) NOT NULL,
  telefono VARCHAR(50) NOT NULL,
  PRIMARY KEY (nit))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Facturas_de_compra
-- -----------------------------------------------------
CREATE TABLE  Facturas_de_compra (
  codigo_factura VARCHAR(15) NOT NULL,
  fecha DATE NOT NULL,
  factura LONGBLOB NOT NULL,
  Valor FLOAT(50) NOT NULL,
  nit_proveedor VARCHAR(50) NOT NULL,
  PRIMARY KEY (codigo_factura),
  INDEX ind_proveedores_facturas_compra (nit_proveedor ASC),
  CONSTRAINT fk_proveedores_facturas_compra
    FOREIGN KEY (nit_proveedor)
    REFERENCES proveedores (nit)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table estados_del_producto
-- -----------------------------------------------------
CREATE TABLE  estados_del_producto (
  id INT(10) NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(50) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table categorias
-- -----------------------------------------------------
CREATE TABLE  categorias (
  id INT(10) NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(50) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Productos
-- -----------------------------------------------------
CREATE TABLE  Productos (
  codigo VARCHAR(10) NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  marca VARCHAR(100) NULL,
  referencia VARCHAR(50) NOT NULL,
  tipo VARCHAR(80) NULL,
  numero_factura VARCHAR(15) NOT NULL,
  id_estado_producto INT(10) NOT NULL,
  id_categoria INT(10) NOT NULL,
  documento_usuario VARCHAR(30) NOT NULL,
  PRIMARY KEY (codigo),
  INDEX ind_facturas_compra_productos (numero_factura ASC),
  INDEX ind_estado_producto_productos (id_estado_producto ASC),
  INDEX ind_categorias_productos (id_categoria ASC),
  INDEX ind_usuarios_productos (documento_usuario ASC),
  CONSTRAINT fk_facturas_compra_productos
    FOREIGN KEY (numero_factura)
    REFERENCES Facturas_de_compra (codigo_factura)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_estados_producto_productos
    FOREIGN KEY (id_estado_producto)
    REFERENCES estados_del_producto (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_categorias_productos
    FOREIGN KEY (id_categoria)
    REFERENCES categorias (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_usuarios_productos
    FOREIGN KEY (documento_usuario)
    REFERENCES Usuarios (documento)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table lista_productos_pedidos
-- -----------------------------------------------------
CREATE TABLE  lista_productos_pedidos (
  codigo_pedido VARCHAR(10),
  codigo_producto VARCHAR(10),
  cantidad_productos INT(10),
  INDEX ind_lista_productos_pedidos_pedidos (codigo_pedido ASC),
  INDEX ind_lista_productos_pedidos_productos (codigo_producto ASC),
  CONSTRAINT fk_lista_productos_pedidos_pedidos
    FOREIGN KEY (codigo_pedido)
    REFERENCES pedidos (numero_pedido)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_lista_productos_pedidos_productos
    FOREIGN KEY (codigo_producto)
    REFERENCES productos (codigo)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;