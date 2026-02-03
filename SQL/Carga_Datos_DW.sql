CREATE OR ALTER PROCEDURE Gold.sp_cargar_DW_Tech1
AS
BEGIN
    ---------------------------------------------------
    -- 1. Merge para Dimension: Clientes
    ---------------------------------------------------
    MERGE Gold.dim_clientes AS destino
    USING (
        SELECT 
            CONVERT(VARCHAR(32), HASHBYTES('MD5', CONCAT(id_cliente, '|', nombre_completo, '|', email, '|', ciudad, '|', pais)), 2) AS sk_cliente,
            id_cliente, nombre_completo, email, ciudad, pais
        FROM Silver.dbo.clientes
    ) AS origen
    ON destino.id_cliente = origen.id_cliente
    WHEN MATCHED THEN
        UPDATE SET
            destino.sk_cliente      = origen.sk_cliente,
            destino.nombre_completo = origen.nombre_completo,
            destino.email           = origen.email,
            destino.ciudad          = origen.ciudad,
            destino.pais            = origen.pais
    WHEN NOT MATCHED BY TARGET THEN
        INSERT (sk_cliente, id_cliente, nombre_completo, email, ciudad, pais)
        VALUES (origen.sk_cliente, origen.id_cliente, origen.nombre_completo, origen.email, origen.ciudad, origen.pais);
    
    ---------------------------------------------------
    -- 2. Merge para Dimension: Productos
    ---------------------------------------------------
    MERGE Gold.dim_productos AS destino
    USING (
        SELECT 
            CONVERT(VARCHAR(32), HASHBYTES('MD5', CONCAT(id_producto, '|', nombre, '|', marca, '|', precio)), 2) AS sk_producto,
            id_producto, nombre, marca, precio
        FROM Silver.dbo.productos
    ) AS origen
    ON destino.id_producto = origen.id_producto
    WHEN MATCHED THEN
        UPDATE SET
            destino.sk_producto = origen.sk_producto,
            destino.nombre      = origen.nombre,
            destino.marca       = origen.marca,
            destino.precio      = origen.precio
    WHEN NOT MATCHED BY TARGET THEN
        INSERT (sk_producto, id_producto, nombre, marca, precio)
        VALUES (origen.sk_producto, origen.id_producto, origen.nombre, origen.marca, origen.precio);
    
    ---------------------------------------------------
    -- 3. Merge para Dimension : Tiendas
    ---------------------------------------------------
    MERGE Gold.dim_tiendas AS destino
    USING (
        SELECT 
            CONVERT(VARCHAR(32), HASHBYTES('MD5', CONCAT(id_tienda, '|', nombre, '|', ciudad, '|', pais, '|', tipo)), 2) AS sk_tienda,
            id_tienda, nombre, ciudad, pais, tipo
        FROM Silver.dbo.tiendas
    ) AS origen
    ON destino.id_tienda = origen.id_tienda
    WHEN MATCHED THEN
        UPDATE SET
            destino.sk_tienda   = origen.sk_tienda,
            destino.nombre      = origen.nombre,
            destino.ciudad      = origen.ciudad,
            destino.pais        = origen.pais,
            destino.tipo        = origen.tipo
    WHEN NOT MATCHED BY TARGET THEN
        INSERT (sk_tienda, id_tienda, nombre, ciudad, pais, tipo)
        VALUES (origen.sk_tienda, origen.id_tienda, origen.nombre, origen.ciudad, origen.pais, origen.tipo);
    
    ---------------------------------------------------
    -- 4. Merge para Dimension : Tiempo
    ---------------------------------------------------
    MERGE Gold.dim_tiempo AS destino
    USING (
        SELECT 
            CAST(CONVERT(VARCHAR(8), fecha, 112) AS INT) AS sk_tiempo,
            fecha, anio, mes, dia, anio_mes, anio_trimestre
        FROM Silver.dbo.tiempo
    ) AS origen
    ON destino.sk_tiempo = origen.sk_tiempo
    WHEN MATCHED THEN
        UPDATE SET
            destino.fecha      = origen.fecha,
            destino.anio       = origen.anio,
            destino.mes        = origen.mes,
            destino.dia        = origen.dia,
            destino.anio_mes   = origen.anio_mes,
            destino.anio_trimestre   = origen.anio_trimestre
    WHEN NOT MATCHED BY TARGET THEN
        INSERT (sk_tiempo, fecha, anio, mes, dia, anio_mes, anio_trimestre)
        VALUES (origen.sk_tiempo, origen.fecha, origen.anio, origen.mes, origen.dia, origen.anio_mes, origen.anio_trimestre);
    
     ---------------------------------------------------
    -- 5. Merge para Tabla de Hechos : FactVentas
    ---------------------------------------------------
MERGE Gold.fact_ventas AS destino
USING (
    SELECT 
        v.id_venta,
        dc.sk_cliente,
        dt.sk_tienda,
        dp.sk_producto,
        dti.sk_tiempo,   -- usamos directamente la fecha de la dimensión tiempo
        v.cantidad,
        v.monto
    FROM Silver.dbo.ventas v
    INNER JOIN Gold.dim_clientes  dc ON v.id_cliente  = dc.id_cliente
    INNER JOIN Gold.dim_tiendas   dt ON v.id_tienda   = dt.id_tienda
    INNER JOIN Gold.dim_productos dp ON v.id_producto = dp.id_producto
    INNER JOIN Gold.dim_tiempo    dti ON v.fecha_venta = dti.fecha
) AS origen
ON destino.id_venta = origen.id_venta
WHEN MATCHED THEN
    UPDATE SET
        destino.sk_cliente   = origen.sk_cliente,
        destino.sk_tienda    = origen.sk_tienda,
        destino.sk_producto  = origen.sk_producto,
        destino.sk_tiempo     = origen.sk_tiempo,
        destino.cantidad     = origen.cantidad,
        destino.monto        = origen.monto
WHEN NOT MATCHED BY TARGET THEN
    INSERT (id_venta, sk_cliente, sk_tienda, sk_producto, sk_tiempo, cantidad, monto)
    VALUES (origen.id_venta, origen.sk_cliente, origen.sk_tienda, origen.sk_producto, origen.sk_tiempo, origen.cantidad, origen.monto);
