# 📊 HR Analytics: Estrategia contra la Rotación de Personal

> Este proyecto traduce datos de 1,470 empleados en decisiones estratégicas. El objetivo es identificar causas raíz de la rotación (Attrition) para apoyar la toma de decisiones en Talento Humano.

---

## 🛠 Stack Tecnológico
* **Análisis y Manipulación:** `Python` con `Pandas` y `Scipy`.
* **Gestión de Datos:** `SQL` (SQLite) y `Power BI` (DAX).
* **Entorno:** Google Colab.

---

## 🚀 Metodología Profesional
1. **Auditoría de Datos:** Limpieza y validación de nulos.
2. **Consultoría Técnica:** Comparativa estratégica entre la agilidad de Pandas y la escalabilidad de SQL.
3. **Ingeniería de Métricas (DAX):** Implementación de indicadores clave de rotación.
4. **Visualización Ejecutiva:** Desarrollo de dashboard interactivo en Power BI.

---

## 🎨 Decisiones de Diseño (Dashboard)
Se eligió un lienzo con tono gris suave, reservando el lateral izquierdo para los segmentadores (*slicers*) de departamento y horas extras. El diseño prioriza la claridad: los *insights* se presentan como títulos estratégicos para facilitar la toma de decisiones informadas.

---

## ⚙️ Medidas DAX Implementadas
Para la construcción del Dashboard, se utilizaron las siguientes medidas clave:
* **Total Empleados:** `COUNTROWS('HR_Data')`
* **Bajas:** `CALCULATE(COUNTROWS('HR_Data'), 'HR_Data'[Attrition] = "Yes")`
* **Tasa Rotación (%):** `DIVIDE([Bajas], [Total Empleados], 0) * 100`
* **Salario Promedio:** `AVERAGE('HR_Data'[MonthlyIncome])`
* **Indicador Condicional:** `IF([Tasa Rotacion] > 20, "#C0392B", "#27AE60")` (Alerta visual automática).

---

## 📊 Hallazgos Principales
* **Tasa de Rotación Global:** 16.12%.
* **Alerta Crítica:** Ventas presenta un 21% de rotación.
* **Perfil de Riesgo:** Empleados más jóvenes, con salarios menores y mayor incidencia de *OverTime*.

---

## 🖥️ Dashboard Ejecutivo
El archivo fuente del dashboard se encuentra disponible en este repositorio como: `Dashboard_hr.pbix`.

![Dashboard Visión General](assets/dashboard_1.jpeg)
![Dashboard Perfil en Riesgo](assets/dashboard_2.jpeg)

---

## 📂 Contenido del Repositorio
* `analisis_hr.ipynb`: Notebook de exploración.
* `queries_hr.sql`: Script de consultas SQL.
* `Dashboard_hr.pbix`: Archivo fuente de Power BI.
* `assets/`: Recursos visuales.

---
*Desarrollado como parte del plan de formación profesional en Ciencia de Datos.*
