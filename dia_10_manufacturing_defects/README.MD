# 🏭 Reporte de Inteligencia de Manufactura y Control de Calidad

Este proyecto implementa un sistema de análisis de datos estructurado en tres niveles (básico a avanzado) utilizando **Python (Pandas) y SQL (SQLite)**. El objetivo es proporcionar visibilidad inmediata sobre el rendimiento de la línea de producción, identificando cuellos de botella y desviaciones de calidad críticas.

---

## 📋 Resumen Ejecutivo (Para Jefe de Planta)

El análisis del último lote de producción (`3,240 registros totales`) revela un desafío significativo en la estabilidad de la línea:

1. **Alerta de Calidad:** Se ha detectado una tasa de defectos promedio global de **2.75** (en una escala absoluta de 0 a 5) y un total de **2,723 unidades defectuosas**. El promedio de calidad del lote es del **80.13%**, lo cual indica una alta variabilidad que requiere intervención.
2. **Inconsistencia de Volumen:** El análisis de flujo diario muestra alta volatilidad en los volúmenes de producción (ej. variaciones drásticas de -680 a +629 unidades entre procesos consecutivos).
3. **Foco Crítico de Acción:** El proceso con ID `424` representa el caso más grave de desviación, liderando la tasa de defectos (5.0) con un score de calidad por debajo del estándar (85.09%). 

**Recomendación Inmediata:** Se requiere un Control Estadístico de Procesos (CEP) urgente y un estudio de tiempos y movimientos para estabilizar la variabilidad y reducir el costo de la no calidad.

---

## 📊 Hallazgos por Nivel de Análisis

### Nivel 1: KPIs Base de Manufactura
Se extrajeron las métricas globales para entender el estado general de la planta.
* **Métrica:** 2,723 productos fueron marcados con estatus defectuoso.
* **Insight:** La proporción de defectos frente al total producido exige revisar de inmediato las calibraciones de maquinaria o la calidad de la materia prima (*Supplier Quality*) recibida para este lote.

### Nivel 2: Dinámica y Variabilidad de Producción (`Window Functions`)
Mediante funciones de ventana (`LAG`, `RANK`, `SUM OVER`) se evaluó el comportamiento temporal de la línea.
* **Ranking de Excelencia (`RANK`):** Existen procesos (ej. ID 1853, 1205) que logran un Quality Score del **99.9%**. Estos procesos deben ser aislados para estudiar sus parámetros y replicarlos como estándar.
* **Análisis de Flujo (`LAG`):** La variación entre lotes es errática. Esta inestabilidad interrumpe la planificación logística (S&OP) y encarece los costos de operación.
* **Volumen Acumulado (`SUM OVER`):** Se logró trazar el acumulado exacto, alcanzando 1,777,215 unidades de volumen de producción procesadas.

### Nivel 3: Identificación de Anomalías (`CTEs` y Subqueries)
Se utilizaron expresiones de tabla comunes para aislar los peores escenarios y compararlos contra la media histórica.
* **Top Defectos:** El proceso **`424`** fue aislado exitosamente mediante `ROW_NUMBER()`. Es el punto de inicio obligatorio para la auditoría técnica en piso.
* **Desviación Estándar:** Se identificaron **1,605 procesos** cuya tasa de defectos supera el promedio global de 2.75. Esto confirma que el problema de calidad no es un evento aislado, sino un fallo sistémico.

---

## 🔄 Window Functions vs GROUP BY

Como decisión de diseño en la arquitectura de las consultas, se priorizó el uso de Window Functions sobre agrupaciones tradicionales por las siguientes razones analíticas:

* **`GROUP BY`** colapsa las filas en un resumen — pierdes el detalle individual del proceso.
* **`Window Functions`** calculan sobre las filas conservando cada registro intacto.

**Ejemplo concreto en este proyecto:**
Con `GROUP BY` solo obtengo el promedio global de `DefectRate` (2.75).
Con `AVG() OVER()` obtengo ese promedio junto a cada fila individual — esto me permite comparar cada proceso de manufactura contra el promedio global de forma simultánea, sin perder el contexto operativo de la fila analizada.

---

## 🛠️ Stack Tecnológico y Arquitectura
* **Entorno:** Google Colab.
* **Lenguajes:** Python (`pandas`) y SQL (`sqlite3`).
* **Técnicas SQL Aplicadas:** * Agregaciones complejas (`CASE WHEN`).
  * Funciones de Ventana (`RANK`, `DENSE_RANK`, `LAG`, `SUM OVER`).
  * Common Table Expressions (`CTEs`) y Subconsultas.

> **Nota Técnica:** Las consultas utilizadas para generar este reporte se encuentran respaldadas y documentadas en el archivo `queries_avanzadas.sql` anexo a este repositorio.