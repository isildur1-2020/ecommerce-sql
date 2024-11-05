-- Generado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   en:        2024-11-04 21:30:00 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE categoria (
    categoria_id NUMBER(6) NOT NULL,
    nombre       VARCHAR2(100) NOT NULL,
    descripcion  CLOB
);

ALTER TABLE categoria ADD CONSTRAINT categoria_pk PRIMARY KEY ( categoria_id );

CREATE TABLE ciudad (
    ciudad_id    NUMBER(3) NOT NULL,
    nombre       VARCHAR2(40) NOT NULL,
    pais_pais_id NUMBER(3) NOT NULL
);

ALTER TABLE ciudad ADD CONSTRAINT ciudad_pk PRIMARY KEY ( ciudad_id );

CREATE TABLE envio (
    envio_id       NUMBER(6) NOT NULL,
    direccion      VARCHAR2(100) NOT NULL,
    fecha_envio    TIMESTAMP,
    fecha_entrega  TIMESTAMP,
    orden_orden_id NUMBER(6) NOT NULL
);

ALTER TABLE envio ADD CONSTRAINT envio_pk PRIMARY KEY ( envio_id );

CREATE TABLE genero (
    genero_id   NUMBER(1) NOT NULL,
    descripcion VARCHAR2(40) NOT NULL
);

ALTER TABLE genero ADD CONSTRAINT genero_pk PRIMARY KEY ( genero_id );

CREATE TABLE interes (
    interes_id  NUMBER(2) NOT NULL,
    descripcion VARCHAR2(40) NOT NULL
);

ALTER TABLE interes ADD CONSTRAINT interes_pk PRIMARY KEY ( interes_id );

CREATE TABLE interesusuario (
    interes_usuario_id NUMBER(4) NOT NULL,
    interes_interes_id NUMBER(2) NOT NULL,
    usuario_usuario_id NUMBER(3) NOT NULL
);

ALTER TABLE interesusuario ADD CONSTRAINT interesusuario_pk PRIMARY KEY ( interes_usuario_id );

CREATE TABLE inventario (
    codigo_barras                         VARCHAR2(16) NOT NULL,
    producto_producto_id                  NUMBER(6) NOT NULL, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
    inventarioestado_inventario_estado_id NUMBER(1) NOT NULL
);

ALTER TABLE inventario ADD CONSTRAINT inventario_pk PRIMARY KEY ( codigo_barras );

CREATE TABLE inventarioestado (
    inventario_estado_id NUMBER(1) NOT NULL,
    descripcion          VARCHAR2(16) NOT NULL
);

ALTER TABLE inventarioestado ADD CONSTRAINT inventarioestado_pk PRIMARY KEY ( inventario_estado_id );

CREATE TABLE niveleducativo (
    nivel_educativo_id NUMBER(1) NOT NULL,
    descripcion        VARCHAR2(40) NOT NULL
);

ALTER TABLE niveleducativo ADD CONSTRAINT niveleducativo_pk PRIMARY KEY ( nivel_educativo_id );

CREATE TABLE ocupacion (
    ocupacion_id NUMBER(1) NOT NULL,
    descripcion  VARCHAR2(40) NOT NULL
);

ALTER TABLE ocupacion ADD CONSTRAINT ocupacion_pk PRIMARY KEY ( ocupacion_id );

CREATE TABLE orden (
    orden_id                    NUMBER(6) NOT NULL,
    fecha_creacion              TIMESTAMP,
    usuario_usuario_id          NUMBER(3) NOT NULL,
    ordenestado_orden_estado_id NUMBER(1) NOT NULL
);

ALTER TABLE orden ADD CONSTRAINT orden_pk PRIMARY KEY ( orden_id );

CREATE TABLE ordendetalle (
    orden_detalle_id         NUMBER(6) NOT NULL,
    orden_orden_id           NUMBER(6) NOT NULL,
    inventario_codigo_barras VARCHAR2(16) NOT NULL
);

CREATE UNIQUE INDEX ordendetalle__idx ON
    ordendetalle (
        inventario_codigo_barras
    ASC );

ALTER TABLE ordendetalle ADD CONSTRAINT ordendetalle_pk PRIMARY KEY ( orden_detalle_id );

CREATE TABLE ordenestado (
    orden_estado_id NUMBER(1) NOT NULL,
    descripcion     VARCHAR2(40) NOT NULL
);

ALTER TABLE ordenestado ADD CONSTRAINT ordenestado_pk PRIMARY KEY ( orden_estado_id );

CREATE TABLE pago (
    pago_id                   NUMBER(6) NOT NULL,
    fecha_pago                TIMESTAMP,
    orden_orden_id            NUMBER(6) NOT NULL,
    pagometodo_pago_metodo_id NUMBER(1) NOT NULL,
    pagoestado_pago_estado_id NUMBER(1) NOT NULL
);

ALTER TABLE pago ADD CONSTRAINT pago_pk PRIMARY KEY ( pago_id );

CREATE TABLE pagoestado (
    pago_estado_id NUMBER(1) NOT NULL,
    nombre         VARCHAR2(40) NOT NULL
);

ALTER TABLE pagoestado ADD CONSTRAINT pagoestado_pk PRIMARY KEY ( pago_estado_id );

CREATE TABLE pagometodo (
    pago_metodo_id NUMBER(1) NOT NULL,
    nombre         VARCHAR2(40) NOT NULL
);

ALTER TABLE pagometodo ADD CONSTRAINT pagometodo_pk PRIMARY KEY ( pago_metodo_id );

CREATE TABLE pais (
    pais_id NUMBER(3) NOT NULL,
    nombre  VARCHAR2(40) NOT NULL
);

ALTER TABLE pais ADD CONSTRAINT pais_pk PRIMARY KEY ( pais_id );

CREATE TABLE producto (
    producto_id NUMBER(6) NOT NULL,
    nombre      VARCHAR2(100) NOT NULL,
    descripcion CLOB,
    precio      NUMBER(10, 2) NOT NULL
);

ALTER TABLE producto ADD CONSTRAINT producto_pk PRIMARY KEY ( producto_id );

CREATE TABLE productocategoria (
    producto_categoria_id  NUMBER(6) NOT NULL,
    categoria_categoria_id NUMBER(6) NOT NULL,
    producto_producto_id   NUMBER(6) NOT NULL
);

ALTER TABLE productocategoria ADD CONSTRAINT productocategoria_pk PRIMARY KEY ( producto_categoria_id );

CREATE TABLE usuario (
    usuario_id                        NUMBER(3) NOT NULL,
    documento                         VARCHAR2(40) NOT NULL,
    nombre                            VARCHAR2(100) NOT NULL,
    apellido                          VARCHAR2(100),
    correo_electronico                VARCHAR2(100 CHAR) NOT NULL,
    contrasena                        VARCHAR2(100 CHAR) NOT NULL,
    direccion                         VARCHAR2(255),
    celular                           VARCHAR2(20),
    fecha_nacimiento                  DATE,
    salario                           NUMBER(15, 2),
    genero_genero_id                  NUMBER(1) NOT NULL,
    ocupacion_ocupacion_id            NUMBER(1) NOT NULL,
    ciudad_ciudad_id                  NUMBER(3) NOT NULL, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
    niveleducativo_nivel_educativo_id NUMBER(1) NOT NULL,
    estado_usuario                    CHAR(1) NOT NULL
);

ALTER TABLE usuario ADD CONSTRAINT usuario_pk PRIMARY KEY ( usuario_id );

ALTER TABLE ciudad
    ADD CONSTRAINT ciudad_pais_fk FOREIGN KEY ( pais_pais_id )
        REFERENCES pais ( pais_id );

ALTER TABLE envio
    ADD CONSTRAINT envio_orden_fk FOREIGN KEY ( orden_orden_id )
        REFERENCES orden ( orden_id );

ALTER TABLE interesusuario
    ADD CONSTRAINT interesusuario_interes_fk FOREIGN KEY ( interes_interes_id )
        REFERENCES interes ( interes_id );

ALTER TABLE interesusuario
    ADD CONSTRAINT interesusuario_usuario_fk FOREIGN KEY ( usuario_usuario_id )
        REFERENCES usuario ( usuario_id );

ALTER TABLE inventario
    ADD CONSTRAINT inventario_inventarioestado_fk FOREIGN KEY ( inventarioestado_inventario_estado_id )
        REFERENCES inventarioestado ( inventario_estado_id );

ALTER TABLE inventario
    ADD CONSTRAINT inventario_producto_fk FOREIGN KEY ( producto_producto_id )
        REFERENCES producto ( producto_id );

ALTER TABLE orden
    ADD CONSTRAINT orden_ordenestado_fk FOREIGN KEY ( ordenestado_orden_estado_id )
        REFERENCES ordenestado ( orden_estado_id );

ALTER TABLE orden
    ADD CONSTRAINT orden_usuario_fk FOREIGN KEY ( usuario_usuario_id )
        REFERENCES usuario ( usuario_id );

ALTER TABLE ordendetalle
    ADD CONSTRAINT ordendetalle_inventario_fk FOREIGN KEY ( inventario_codigo_barras )
        REFERENCES inventario ( codigo_barras );

ALTER TABLE ordendetalle
    ADD CONSTRAINT ordendetalle_orden_fk FOREIGN KEY ( orden_orden_id )
        REFERENCES orden ( orden_id );

ALTER TABLE pago
    ADD CONSTRAINT pago_orden_fk FOREIGN KEY ( orden_orden_id )
        REFERENCES orden ( orden_id );

ALTER TABLE pago
    ADD CONSTRAINT pago_pagoestado_fk FOREIGN KEY ( pagoestado_pago_estado_id )
        REFERENCES pagoestado ( pago_estado_id );

ALTER TABLE pago
    ADD CONSTRAINT pago_pagometodo_fk FOREIGN KEY ( pagometodo_pago_metodo_id )
        REFERENCES pagometodo ( pago_metodo_id );

ALTER TABLE productocategoria
    ADD CONSTRAINT productocategoria_categoria_fk FOREIGN KEY ( categoria_categoria_id )
        REFERENCES categoria ( categoria_id );

ALTER TABLE productocategoria
    ADD CONSTRAINT productocategoria_producto_fk FOREIGN KEY ( producto_producto_id )
        REFERENCES producto ( producto_id );

ALTER TABLE usuario
    ADD CONSTRAINT usuario_ciudad_fk FOREIGN KEY ( ciudad_ciudad_id )
        REFERENCES ciudad ( ciudad_id );

ALTER TABLE usuario
    ADD CONSTRAINT usuario_genero_fk FOREIGN KEY ( genero_genero_id )
        REFERENCES genero ( genero_id );

ALTER TABLE usuario
    ADD CONSTRAINT usuario_niveleducativo_fk FOREIGN KEY ( niveleducativo_nivel_educativo_id )
        REFERENCES niveleducativo ( nivel_educativo_id );

ALTER TABLE usuario
    ADD CONSTRAINT usuario_ocupacion_fk FOREIGN KEY ( ocupacion_ocupacion_id )
        REFERENCES ocupacion ( ocupacion_id );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            20
-- CREATE INDEX                             1
-- ALTER TABLE                             39
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   2
-- WARNINGS                                 0
