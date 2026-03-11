# Análisis de Rotación de Personal (HR Analytics)

## 📌 Descripción del Proyecto
Este proyecto analiza los factores que influyen en la rotación de personal (Attrition) dentro de una organización. El objetivo es identificar causas raíz —como la brecha salarial, la carga laboral y la satisfacción del empleado— para apoyar la toma de decisiones estratégicas del departamento de Talento Humano.

## 🛠 Tecnologías Utilizadas
* **Lenguaje:** Python, SQL.
* **Bibliotecas:** Pandas (manipulación de datos), Seaborn/Matplotlib (visualización), Scipy (análisis estadístico).
* **Entorno:** Google Colab.

## 📂 Contenido del Repositorio
* `analisis_hr.ipynb`: Notebook principal con el flujo completo de limpieza, exploración, visualización y análisis de datos.
* `queries_hr.sql`: Script con las consultas fundamentales para replicar los cálculos en un entorno de base de datos relacional.

## 🚀 Metodología y Análisis
El análisis se estructuró bajo estándares de calidad profesional:
1. **Validación de Datos:** Auditoría inicial de tipos de datos, valores nulos y distribución de la variable objetivo.
2. **KPIs de Negocio:** Cálculo de tasa de rotación global y segmentada por departamentos.
3. **Análisis Comparativo:** Evaluación del perfil de empleados que permanecen vs. los que abandonan la compañía utilizando `.agg()`.
4. **Comparativa Técnica:** Justificación estratégica del uso de **Pandas** (agilidad exploratoria) frente a **SQL** (eficiencia y escalabilidad).

## 📊 Hallazgos Principales (Resumen Ejecutivo)
* Se identificó una **tasa global de rotación del 16.12%**.
* **El factor salarial:** Existe una brecha significativa en departamentos como Recursos Humanos, donde la compensación es un predictor clave de deserción.
* **Carga operativa:** Los empleados que abandonan la empresa registran una mayor incidencia de horas extra, sugiriendo la necesidad de un mejor balanceo de cargas.
* **🖥️ Visualización Ejecutiva (Power BI)**
Además del análisis estadístico, el proyecto se trasladó a un entorno de Business Intelligence para monitoreo continuo:

* **Dashboard Senior:** Diseño de 2 páginas con enfoque en KPIs de alerta temprana.

* **Lógica DAX:** Implementación de medidas condicionales para resaltar riesgos de rotación superiores al 20%.

* **Consistencia:** Diseño de interfaz basado en una paleta de 3 colores para asegurar una lectura rápida de insights.

![Hr_Analytics_proyect](assets/Dashboard Image.JPEG)







---
*Desarrollado como parte del plan de formación profesional en Ciencia de Datos.*
