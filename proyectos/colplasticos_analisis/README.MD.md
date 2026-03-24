# 🏭 Análisis Operacional y Eficiencia (OEE) - ColPlásticos S.A.

## 📖 Contexto del Proyecto

ColPlásticos S.A. requiere una auditoría profunda de su salud operativa. Este proyecto procesa el registro histórico de producción para identificar fugas de capital y el estado real de la **Eficiencia General de los Equipos (OEE)**. El análisis se centra en la variabilidad del proceso y el impacto económico de la "No Calidad".

## 🛠️ Transformación de Datos (Power Query)

Para garantizar la integridad del modelo en Power BI, se aplicaron dos procesos críticos de limpieza:

- **Normalización de Decimales:** Se reemplazó el punto `.` por la coma `,` en todas las columnas numéricas. Esto corrigió la inconsistencia donde Power Query detectaba valores como texto, permitiendo cálculos matemáticos precisos.
    
- **Creación de Identidad:** Se generó una columna de índice denominada `id_turno`. Dado que el dataset original carecía de una clave única, esta columna permite desglosar y visualizar cada turno individualmente en el diagrama de dispersión y el análisis de Pareto.
    

## 📊 Resumen Ejecutivo (Dashboard)

El dashboard implementado permite una navegación desde la métrica macro hasta el detalle financiero por turno.

_(Sube tu captura a GitHub y reemplaza este link)_

### Hallazgos Clave:

1. **OEE y Calidad:** El **80,13%** de OEE promedio es aceptable, pero el dato alarmante es que el **84,04%** de los turnos operan fuera de especificación.
    
2. **Independencia del Downtime:** El gráfico de dispersión confirma que **no existe correlación** entre las paradas de máquina y la tasa de defectos. Los defectos son producto de la variabilidad intrínseca del proceso activo.
    
3. **Impacto Financiero:** El **Costo de No Calidad (COQN)** se concentra en turnos específicos, con el ID 1279 liderando las pérdidas con **$925,70**.
    

## 🔢 Documentación de Medidas DAX

Las métricas core se alojan en una tabla dedicada de medidas para optimizar el rendimiento:

Fragmento de código

```
// 1. Rendimiento promedio de calidad
OEE Score Avg = DIVIDE(AVERAGE(manufacturing[QualityScore]), 100)

// 2. Tiempo operativo real
Disponibilidad Avg = 100 - AVERAGE(manufacturing[DowntimePercentage])

// 3. Porcentaje de turnos no conformes
Pct Fuera Spec = 
VAR TurnosFuera = CALCULATE(COUNTROWS(manufacturing), manufacturing[DefectStatus] = "Fuera de Spec")
RETURN DIVIDE(TurnosFuera, COUNTROWS(manufacturing), 0)

// 4. Impacto financiero acumulado
COQN Total = SUM(manufacturing[Costo_NQ])

// 5. Formato condicional para alertas
Color Fuera Spec = IF([Pct Fuera Spec] > 0.80, "#E74C3C", "#27AE60")
```

## 🎨 Decisiones de Diseño (UI/UX)

Se aplicó una paleta de colores basada en **estándares de seguridad industrial** para facilitar la respuesta cognitiva del usuario:

|**Elemento**|**Hex Code**|**Concepto**|
|---|---|---|
|**Fondo Principal**|`#1A1F2E`|Azul Noche (Profundidad analítica)|
|**Header**|`#E84B1F`|Naranja Industrial (Seguridad y Alerta)|
|**Zonas de Visual**|`#222840`|Contenedores con borde `#2E3558`|
|**Acento Positivo**|`#27AE60`|Verde (Dentro de Especificación)|
|**Acento Negativo**|`#E74C3C`|Rojo (Fuera de Especificación)|
|**Texto Principal**|`#F0F4FF`|Blanco azulado (Lectura descansada)|

## 🚀 Hallazgos Accionables para la Dirección

- **Control Estadístico de Procesos (SPC):** Es imperativo implementar gráficos de control en tiempo real para el **Top 10 de turnos** con mayor impacto económico.
    
- **Ajuste de Parámetros:** Dado que el downtime no causa los defectos, la inversión debe ir dirigida a la calibración de maquinaria y estandarización de materias primas, no solo a reducir paradas.
    
- **Auditoría DMAIC:** Ejecutar una revisión de causa raíz en los turnos identificados en el Cuartil Crítico para recuperar flujo de caja inmediato.
    

## ⚡ Arquitectura de Datos Evaluada

|**Motor**|**Caso de Uso Industrial**|
|---|---|
|**DuckDB**|Análisis ultrarrápido local de GBs de datos sin infraestructura cloud (Ideal para Startups).|
|**PostgreSQL**|Estándar para manejo de registros de clientes y transacciones recurrentes en aplicaciones.|
|**BigQuery**|Escalabilidad masiva para Terabytes y entrenamiento de modelos de ML integrados.|