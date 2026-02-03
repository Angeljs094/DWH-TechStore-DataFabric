# 🏬 TechStore Data Fabric

Proyecto de inteligencia de negocios para la gestión y análisis de datos comerciales de **TechStore**, implementado con una arquitectura **Data Fabric** en Microsoft Fabric y OneLake.  
El objetivo es consolidar fuentes dispersas, automatizar procesos ETL y habilitar dashboards interactivos para la toma de decisiones estratégicas.

---

## 📌 Problemática
TechStore enfrenta dificultades para integrar y analizar datos provenientes de múltiples fuentes (SQL Server, CSV, sistemas de facturación).  
Esto limita la capacidad de:
- Identificar tendencias de ventas y comportamiento de clientes.
- Optimizar inventarios y cadena de suministro.
- Evaluar rendimiento de productos y proveedores.
- Generar reportes confiables y oportunos.

---

## 🛠️ Arquitectura de Datos

El proyecto se estructura en cuatro capas principales:

1. **Fuente**
   - SQL Server: Base transaccional de ventas, inventario y clientes.
   - Archivos CSV: Reportes de proveedores y listas de precios.

2. **Ingesta**
   - Lakehouse Landing: Zona de aterrizaje para datos crudos.
   - Lakehouse Bronze (CDC2): Ingesta incremental con control de cambios.

3. **Transformación**
   - Lakehouse Silver: Normalización, limpieza y enriquecimiento con Spark SQL.

4. **Servicio**
   - Lakehouse Gold_Tech: Modelo semántico optimizado para análisis.
   - Datawarehouse DW_Tech1: Modelo estrella para consultas analíticas.
   - Reporte_DwTech: Dashboard en Power BI con KPIs clave (ventas, rotación de inventario, márgenes, comportamiento de clientes).

📌 **Diagramas de Arquitectura**  
- [Arquitectura Delta Lake](Images/Arquitectura_DeltaLake.png)  
- [Modelo Estrella del Datawarehouse](Images/Datawarehouse_Tech.png)  
- [Pipeline DW](Images/Pipeline_DW.png)  
- [Reporte en Power BI](Images/Reporte.png)  

---

## 🎯 Objetivos Específicos
- Consolidar todas las fuentes de datos en una arquitectura unificada.
- Automatizar procesos de ingesta y transformación con pipelines en Fabric.
- Diseñar dashboards reutilizables y adaptables para distintos perfiles de usuario.
- Garantizar trazabilidad y gobernanza de los datos mediante control de versiones.

---

## 📊 Resultados Esperados
- Reducción del tiempo de generación de reportes en un 70%.
- Mejora en la precisión de decisiones comerciales.
- Incremento en eficiencia operativa y reducción de sobrestock.
- Transparencia en el rendimiento de productos y proveedores.

---

## 👨‍💻 Autor
Angel Teodoro Jaramillo Sulca  
Data Engineer | Azure | AWS