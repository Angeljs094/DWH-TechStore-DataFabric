IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES 
               WHERE TABLE_SCHEMA = 'Gold' 
               AND TABLE_NAME = 'dim_tiendas')
BEGIN
CREATE TABLE Gold.dim_tiendas (
    sk_tienda VARCHAR(32),
    id_tienda INT,
    nombre VARCHAR(100),
    ciudad VARCHAR(100),
    pais VARCHAR(100),
    tipo VARCHAR(50)
);
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES 
               WHERE TABLE_SCHEMA = 'Gold' 
               AND TABLE_NAME = 'dim_clientes')
BEGIN
CREATE TABLE Gold.dim_clientes (
    sk_cliente   VARCHAR(32),
    id_cliente   INT,
    nombre_completo VARCHAR(200),
    email        VARCHAR(200),
    ciudad       VARCHAR(100),
    pais         VARCHAR(100)
);
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES 
               WHERE TABLE_SCHEMA = 'Gold' 
               AND TABLE_NAME = 'dim_productos')
BEGIN
CREATE TABLE Gold.dim_productos (
    sk_producto  VARCHAR(32),
    id_producto  INT,
    nombre       VARCHAR(200),
    marca        VARCHAR(100),
    precio       DECIMAL(18,2)
);
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES 
               WHERE TABLE_SCHEMA = 'Gold' 
               AND TABLE_NAME = 'dim_tiempo')
BEGIN
CREATE TABLE Gold.dim_tiempo (
    sk_tiempo    VARCHAR(32),
    fecha        DATE,
    anio         INT,
    mes          INT,
    dia          INT,
    anio_mes     VARCHAR(10),
    anio_trimestre VARCHAR(10)
);
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES 
               WHERE TABLE_SCHEMA = 'Gold' 
               AND TABLE_NAME = 'fact_ventas')
BEGIN
CREATE TABLE Gold.fact_ventas (
    id_venta     INT,
    sk_cliente   VARCHAR(32),
    sk_tienda    VARCHAR(32),
    sk_producto  VARCHAR(32),
    sk_tiempo    VARCHAR(10),
    cantidad     INT,
    monto        DECIMAL(18,2)
);
END;