# 📄 Análisis de Manufactura: Día 11 - Migración Cloud y Causa Raíz

### 📸 Conexión a Base de Datos Cloud
*Infraestructura escalada a la nube mediante SQLAlchemy y conexión segura a Neon.tech.*

![Screenshot de la conexión exitosa a Neon](tu_enlace_de_imagen_aqui)

---

### 📊 Resumen Ejecutivo (Continuación del Día 10)
Tras detectar en el análisis inicial que el **49.5% de los procesos (1,605 registros)** superaban el promedio histórico de defectos, hoy escalamos la arquitectura a **PostgreSQL (Neon.tech)** para profundizar en la causa raíz.

Al segmentar la producción en cuartiles de calidad y cruzarla con variables de mantenimiento, el hallazgo es contundente: el **Cuartil Crítico (Q4)** consume un promedio de **11.51 horas de mantenimiento**, pero no presenta una mejora proporcional en la tasa de defectos frente a procesos con menor intervención. **Conclusión:** La planta está atrapada en un ciclo de mantenimiento reactivo ineficiente. La abundancia operativa solo llegará mediante la transición a un modelo preventivo basado en datos.

---

### 🔍 Hallazgo sobre la Distribución de Defectos (Mediana vs. Promedio)
El análisis estadístico del *DefectRate* revela una estructura de datos que exige una intervención quirúrgica, no general:

* **Promedio Global (Día 10):** ~2.75
* **Mediana:** 2.70
* **Percentil 90:** 4.57 (Zona de Desastre)

**¿Qué revela esto para el negocio?**
La cercanía entre la mediana (2.70) y el promedio (2.75) indica una base operativa relativamente estable. Sin embargo, el salto drástico hacia el **Percentil 90 (4.57)** confirma que el problema de rentabilidad no es una falla de toda la línea, sino la presencia de **outliers críticos**. No necesitamos reestructurar toda la planta; necesitamos identificar qué sucede específicamente en ese 10% de procesos que están operando al borde del colapso técnico.

---

### ⚙️ SQLite vs. PostgreSQL: 3 Diferencias Concretas (Día 11)
Durante la migración técnica, estas fueron las diferencias clave que optimizaron nuestro flujo de trabajo:

1.  **Seguridad de Credenciales (Secrets):** A diferencia de SQLite (archivo local), PostgreSQL requiere una gestión de acceso segura. Implementamos el uso de `google.colab.userdata` para manejar la cadena de conexión, evitando la exposición de credenciales sensibles en el código fuente.
2.  **Sensibilidad y Citación de Columnas:** PostgreSQL exige el uso de comillas dobles para columnas con mayúsculas (ej. `"QualityScore"`), imponiendo un estándar de escritura más riguroso y profesional que la flexibilidad de SQLite.
3.  **Tipado y Casting Explicito:** Para funciones de agregación y redondeo, PostgreSQL requiere declarar tipos de datos numéricos explícitamente (ej. `::numeric`), lo que elimina ambigüedades en los reportes financieros y asegura la integridad de los cálculos de promedios.