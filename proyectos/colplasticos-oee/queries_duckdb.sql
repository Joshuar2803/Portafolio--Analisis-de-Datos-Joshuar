
-- PROYECTO: Análisis Operacional ColPlásticos S.A.
-- MOTOR: DuckDB

-- Pregunta 1: Estado del OEE de Calidad y Especificaciones
SELECT 
    COUNT(*) as total_turnos,
    ROUND(AVG(QualityScore), 2) as oee_calidad_promedio_pct,
    ROUND(AVG(100 - DowntimePercentage), 2) as disponibilidad_promedio_pct,
    ROUND((AVG(QualityScore) * AVG(100 - DowntimePercentage) / 100.0), 2) as oee_combinado_est_pct,
    SUM(DefectStatus) as turnos_fuera_spec,
    ROUND((SUM(DefectStatus)::numeric / COUNT(*) * 100.0), 2) as pct_turnos_fuera_spec
FROM manufacturing;

-- Pregunta 2: Identificación del Cuello de Botella Operacional
WITH TurnosCuartiles AS (
    SELECT 
        id_proceso,
        DowntimePercentage,
        DefectRate,
        MaintenanceHours,
        QualityScore,
        NTILE(4) OVER (ORDER BY DowntimePercentage) as cuartil_parada
    FROM manufacturing
)
SELECT
    cuartil_parada,
    MIN(DowntimePercentage) as min_downtime_pct,
    MAX(DowntimePercentage) as max_downtime_pct,
    ROUND(AVG(DowntimePercentage), 2) as avg_downtime_pct,
    ROUND(AVG(DefectRate), 2) as avg_defect_rate,
    ROUND(AVG(MaintenanceHours), 2) as avg_maint_hours_corr,
    ROUND(AVG(QualityScore), 2) as avg_quality_oee
FROM TurnosCuartiles
GROUP BY cuartil_parada
ORDER BY cuartil_parada;

-- Pregunta 3: Estimación del Costo de No Calidad (COQN)
SELECT 
    id_proceso,
    ROUND(ProductionCost, 2) as ProductionCost,
    ROUND(DefectRate, 2) as DefectRate,
    ROUND(DowntimePercentage, 2) as DowntimePercentage,
    ROUND(
        ProductionCost * (DefectRate / 5.0) * (DowntimePercentage / 100.0)
    , 2) as costo_no_calidad_est
FROM manufacturing
ORDER BY costo_no_calidad_est DESC
LIMIT 10;
