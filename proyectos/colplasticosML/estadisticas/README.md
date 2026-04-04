 ### **README: Análisis Estadístico de Manufactura**

**Resumen de Normalidad**

Los datos de ColPlásticos presentan una **distribución plana**. Con un Skewness de 0.02 para defectos, el proceso se comporta de manera simétrica. Aunque las pruebas de Shapiro-Wilk suelen rechazar la normalidad en datasets tan grandes ($n=3240$), para fines prácticos de ingeniería, los datos pueden tratarse como DefectRate presenta Skewness ≈ 0 (simétrica) pero 
Kurtosis = -1.22 (platikúrtica). La distribución es UNIFORME, no normal. Shapiro-Wilk confirma esto con p = 1.2e-17. Implicación: usar mediana + IQR para reporte, aunque en este caso específico media y mediana 
son casi idénticas (2.749 vs 2.709). debido a la coincidencia de sus medidas de tendencia central.

**Tabla de Correlaciones e Interpretación**

|**Par de Variables**|**Correlación**|**Interpretación Técnica**|
|---|---|---|
|`DefectRate` vs `QualityScore`|-0.0363|**Nula.** La tasa de defectos no explica la caída en el puntaje de calidad.|
|`Maintenance` vs `QualityScore`|-0.0134|**Nula.** El mantenimiento no está diseñado para elevar la calidad.|
|`Productivity` vs `QualityScore`|0.0046|**Inexistente.** La velocidad del trabajador no afecta la calidad.|

**Implicación para el diagnóstico de ColPlásticos**

Este hallazgo **cambia drásticamente el diagnóstico**. Si las horas de mantenimiento no reducen los defectos ni mejoran la calidad, la planta está incurriendo en un "Gasto de Mantenimiento" y no en una "Inversión de Calidad". Es probable que el mantenimiento sea correctivo o de limpieza, pero no predictivo sobre las variables que generan defectos.

---

### **Respuestas de Negocio**

#### **Nivel 1 — Distribuciones**

1. **¿DefectRate tiene distribución normal?** Estadísticamente es simétrica ($Skew=0.02$). Para el análisis, esto implica que la **media y la mediana son intercambiables**. Puedes usar la media para proyecciones financieras sin riesgo de error por sesgo.
    
2. **¿Outliers (IQR vs Z-Score)?** El método **IQR** detectará menos outliers en este caso porque se centra en la dispersión de los cuartiles. El **Z-Score** es más sensible a la desviación estándar. Difieren porque el Z-Score asume una campana de Gauss perfecta, mientras que el IQR es "agnóstico" a la distribución.
    

#### **Nivel 2 — Correlaciones**

1. **¿Existe correlación MaintenanceHours-DefectRate?** El valor es cercano a **-0.0134**. Esto significa que **no existe correlación**. En términos de negocio: si mañana duplicas el mantenimiento, la tasa de defectos se quedará igual.
    
2. **Variable más correlacionada con QualityScore:** Ninguna de las variables operacionales actuales. Todas están en el rango de +/- 0.03. Esto sugiere que el "driver" de la calidad está fuera de este dataset (ej: temperatura de máquinas o calidad de materia prima).
    
3. **Heatmap de 5 variables:**
    

#### **Nivel 3 — Conclusión Estadística**

1. **¿Se confirma o refuta el hallazgo?** **SE CONFIRMA.** El mantenimiento **no reduce los defectos** en la configuración actual de la planta. Los datos son contundentes: la correlación es nula.
    
2. **Variable a monitorear para predecir turnos defectuosos:** Dado que ninguna variable lineal domina, deberías monitorear primero el **`DowntimePercentage` (Porcentaje de tiempo de inactividad)**. Generalmente, las paradas de máquina (arranque y parada) son los momentos donde más se generan defectos por inestabilidad térmica o mecánica, aunque la correlación sea baja, es el predictor físico más lógico en procesos de plásticos.

**Nota sobre outliers:** DefectRate oscila entre 0-5 por diseño 
del dataset. Ambos métodos confirman que no hay valores fuera 
de rango — el proceso no genera defectos anómalos, sino 
variabilidad uniforme a lo largo de todo el rango posible 
(confirmado por Kurtosis = -1.22).