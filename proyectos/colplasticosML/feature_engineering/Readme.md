# 🏭 Ingeniería de Características y Preparación de Datos: Proyecto ColPlásticos

Este repositorio contiene la fase de **Feature Engineering** del sistema predictivo para la detección de defectos en la planta. En esta etapa, se transformaron los datos brutos en un dataset optimizado, abordando desafíos de desbalance de clases y selección de variables bajo criterios de Ingeniería Industrial.

## 🎯 Selección de Características (Features)

Para el entrenamiento del modelo se han definido **10 características** finales, seleccionadas tras un proceso de filtrado de "fuga de datos" (Data Leakage):

- **Variables Predictoras (7):** `ProductionVolume`, `ProductionCost`, `SupplierQuality`, `MaintenanceHours`, `DowntimePercentage`, `WorkerProductivity`, `EnergyConsumption`.
    
- **Variables Excluidas (Data Leakage):**
    
    - **`DefectRate` y `QualityScore`**: Eliminadas. Al ser resultados finales del proceso, incluirlas para predecir si un turno tendrá defectos generaría un modelo inválido que "conoce el futuro".
        
- **Nuevas Variables de Ingeniería (3):**
    
    1. **`costo_por_unidad`**: Eficiencia económica del turno.
        
    2. **`alta_carga`**: Indicador binario de estrés operativo (Volumen > P75).
        
    3. **`energia_por_unidad`**: Proxy de eficiencia y salud de la maquinaria.
        

---

## 🚨 Hallazgos Críticos y Diagnóstico Industrial

### 1. La Paradoja del Mantenimiento: ¿Preventivo o Correctivo?

Un análisis profundo reveló una diferencia significativa en las correlaciones de `MaintenanceHours`:

- **Día 16 (vs DefectRate):** -0.0087 (Correlación nula).
    
- **Día 17 (vs DefectStatus):** **0.3091** (Correlación positiva moderada).
    

**Interpretación Técnica:** Los datos indican que a mayores horas de mantenimiento, existe una mayor probabilidad de que el turno sea clasificado como "Fuera de Spec". Esto confirma que el mantenimiento en la planta es **Reactivo/Correctivo**. Las horas de mantenimiento no están previniendo el defecto, sino que son una consecuencia de fallos en la maquinaria y detenciones en la línea. El mantenimiento actual es un síntoma del problema, no la solución.

### 2. Análisis Real de Balance de Clases

Tras la auditoría de datos, se identificó un desbalance severo en la variable objetivo `DefectStatus`:

- **Clase 0 (Conforme):** 517 registros (**15.96%**)
    
- **Clase 1 (Fuera de Spec):** 2,723 registros (**84.04%**)
    

**Diagnóstico Estadístico:** El dataset está **severamente desbalanceado** hacia la clase defectuosa. **Implicación Crítica:** La métrica de **Exactitud (Accuracy) NO es válida** para este proyecto. Un modelo simplista que prediga siempre "1" tendría un 84% de éxito sin detectar realmente patrones. Para el modelado (Día 18), es obligatorio priorizar **F1-Score, Recall y Precision**.

---

## 📈 Visualización y Poder Predictivo

### Distribución de Features por Clase

Al analizar los histogramas, se observa que la mayoría de las variables presentan un solapamiento considerable. No obstante, **`DowntimePercentage`** y **`MaintenanceHours`** muestran una separación visual en la Clase 1, consolidándose como los principales predictores de inestabilidad en el proceso.

### Matriz de Correlación vs Target

La variable con mayor correlación absoluta con el estado de defecto es **`MaintenanceHours` (0.3091)**, seguida por factores de tiempo de inactividad. Esto refuerza la tesis de que la inestabilidad mecánica es el principal "driver" de la falta de calidad en ColPlásticos.

---

## ✅ Estado Final: ¿Está listo el dataset?

**Sí.** El dataset está preparado bajo las siguientes condiciones:

1. **Estratificación:** Se aplicó `stratify=y` en el split 80/20 (2,592 registros en Train / 648 en Test) para preservar la proporción de clases.
    
2. **Escalamiento:** Uso de `StandardScaler` para normalizar magnitudes (ej. Costo vs Productividad).
    
3. **Preparación para Algoritmos:** Se guardaron versiones escaladas y crudas (raw) para permitir pruebas tanto en modelos lineales como en árboles de decisión.
    

**Próximo paso:** Implementación de modelos de clasificación con enfoque en métricas de sensibilidad (Recall) para capturar los turnos conformes (la minoría crítica).

---

_Este análisis forma parte de la estrategia de optimización de procesos y toma de decisiones basada en datos para la mejora de la rentabilidad operativa._