# 🏭 Análisis Operacional y Eficiencia (OEE) - ColPlásticos S.A.

## 📖 Contexto del Problema
ColPlásticos S.A. es una empresa del sector manufacturero que busca auditar la salud general de su planta. Como Analista de Datos, el objetivo de este proyecto es procesar el registro histórico de producción (`manufacturing_defect_dataset.csv`) para identificar fugas de capital, cuellos de botella y el estado real de la Eficiencia General de los Equipos (OEE), utilizando **DuckDB** para un procesamiento analítico rápido en memoria y Python para la visualización de datos.

Se han planteado tres preguntas críticas de negocio por parte de la Dirección de Operaciones para tomar decisiones inmediatas de mejora continua.

---

## 📊 Respuestas Ejecutivas

**1. ¿Cuál es el estado real del OEE?**
* **Hallazgo:** La planta presenta un promedio aceptable de OEE de Calidad, pero padece de una estabilidad operativa crítica. El OEE combinado se ve arrastrado hacia abajo por paradas excesivas.
* **Dato:** El OEE de Calidad promedio se sitúa en 80.13%, mientras que la disponibilidad reduce el rendimiento combinado estimado a 78.13%. Es alarmante que el 84.04% de los turnos operen fuera de especificación de calidad general.
* **Recomendación:** Activar de inmediato contención de calidad en turnos fuera de *spec* y revisar los estándares y protocolos de Disponibilidad de la maquinaria.

**2. ¿Dónde está el cuello de botella?**
* **Hallazgo:** No existe una correlación lineal directa entre el tiempo de parada y la tasa de defectos, lo que evidencia que los defectos ocurren por una variabilidad en el proceso activo (máquina en marcha), no solo durante los arranques tras una parada.
* **Dato:** Al clasificar los turnos en cuartiles de rendimiento, el Cuartil 4 (peor disponibilidad, avg 4.39%) mantiene una tasa de defectos casi idéntica y horas de correctivo similares al Cuartil 1 (mejor disponibilidad). El proceso está fuera de control estadístico.
* **Recomendación:** Se requiere una intervención de Ingeniería de Procesos directa en planta. Hay que estabilizar la máquina mediante un Plan de Mantenimiento Preventivo urgente.

**3. ¿Cuánto está costando la no calidad?**
* **Hallazgo:** Las paradas y defectos combinados están generando un "desecho" de los costos de producción, concentrando fuertes pérdidas en unos pocos turnos específicos.
* **Dato:** El turno con peor desempeño operativo (ID Proceso 1279) representa un costo de no calidad estimado de $925.70 en un solo periodo, marcando el límite superior de pérdida financiera por turno.
* **Recomendación:** Ejecutar una auditoría de causa raíz bajo metodología DMAIC enfocada exclusivamente en el *Top 10* de peores turnos. Esto representa un *Quick Win* para recuperar flujo de caja.

---

## 📈 Métrica: Costo de No Calidad (COQN) Estimado
Para evaluar el impacto financiero, se diseñó una métrica sintética que castiga el costo operativo base por las ineficiencias del turno.

**Fórmula Aplicada en SQL:**
> `Costo_NQ = ProductionCost * (DefectRate / 5.0) * (DowntimePercentage / 100.0)`

* **Lógica:** El `ProductionCost` representa el dinero invertido en el turno. Este valor se multiplica por la severidad de los defectos (normalizado en una escala sobre 5) y se pondera por el porcentaje de tiempo que la máquina no produjo por fallos. El resultado estima el capital "quemado" por mala calidad y paradas.

---

## 🛠️ Arquitectura de Datos: DuckDB vs PostgreSQL vs BigQuery

*Esta sección detalla las características técnicas de los motores SQL evaluados en el stack del proyecto.*

| Característica | DuckDB (OLAP Local) | PostgreSQL (OLTP Servidor) | Google BigQuery (OLAP Cloud) |
| :--- | :--- | :--- | :--- |
| **Arquitectura** | Orientado a columnas, In-Process (corre dentro del script, sin servidor). | Orientado a filas, Cliente-Servidor. | Orientado a columnas, Distribuido, Serverless en la nube. |
| **Fortaleza Principal** | Análisis ultrarrápido de DataFrames masivos en local (Pandas/CSV) sin necesidad de infraestructura. | Integridad relacional (ACID), excelente para manejo de transacciones concurrentes (inserciones/actualizaciones). | Escalabilidad masiva. Puede procesar Petabytes de datos en segundos. |
| **Casos de Uso (Escribe aquí tu justificación de cuándo usar cada uno en un entorno industrial real)** | *(Se recomienda usarlo para StarUps, en donde es de vital de importancia considerando su rendimiento y su infraestructura optimizada teniendo la oportunidad de analizar GB de datos sin subirlo a la nube)* | *(Es recomendado para el manejo de clientes y usuarios recurrentes en donde es ideal debido a su información para manejar registros, es el estandar de aplicaciones)* | *(Ideal para empresas que manejen grandes Terabytes de información y que necesiten su escalabilidad a nivel empresarial masivo, en donde es posible entrenar los modelos de ML sin necesidad de transportar los datos a otro lado)* |