-- ==========================================
-- SCRIPT DE ANÁLISIS DE MANUFACTURA Y CALIDAD
-- Autor: Joshuar Enrique Rodriguez Moreno
-- ==========================================

-- NIVEL 1: KPIs Globales

SELECT 
    COUNT(*) as total_registros,
    ROUND(AVG(DefectRate) * 100, 2) as tasa_defectos_pct,
    ROUND(AVG(QualityScore), 2) as calidad_promedio,
    SUM(CASE WHEN DefectStatus = 1 THEN 1 ELSE 0 END) as total_defectuosos
FROM manufacturing;


-- NIVEL 2A: Ranking de Calidad

SELECT 
    rowid,
    QualityScore,
    ProductionVolume,
    RANK() OVER (ORDER BY QualityScore DESC) as rank_calidad,
    DENSE_RANK() OVER (ORDER BY QualityScore DESC) as dense_rank_calidad
FROM manufacturing
LIMIT 20;
 


-- NIVEL 2B: Análisis de Flujo y Acumulados (Variación LAG)

SELECT
    id_proceso,
    ProductionVolume,
    COALESCE(LAG(ProductionVolume, 1) OVER (ORDER BY id_proceso), 0) as vol_anterior,
    ProductionVolume - COALESCE(LAG(ProductionVolume, 1) OVER (ORDER BY id_proceso), 0) as variacion,
    SUM(ProductionVolume) OVER (ORDER BY id_proceso ROWS UNBOUNDED PRECEDING) as prod_acumulada
FROM manufacturing
LIMIT 20
;


-- NIVEL 2C: Producción Acumulada

SELECT
    rowid,
    ProductionVolume,
    SUM(ProductionVolume) OVER (
        ORDER BY rowid 
        ROWS UNBOUNDED PRECEDING
    ) as produccion_acumulada
FROM manufacturing;


-- NIVEL 3: Casos Críticos (CTE y Subconsultas)

WITH defectos_rankeados AS (
    SELECT
        rowid,
        DefectRate,
        QualityScore,
        ProductionVolume,
        ROW_NUMBER() OVER (ORDER BY DefectRate DESC) as rn
    FROM manufacturing
),
sobre_promedio AS (
    SELECT *
    FROM manufacturing
    WHERE DefectRate > (SELECT AVG(DefectRate) FROM manufacturing)
)
SELECT * FROM defectos_rankeados WHERE rn = 1;


-- NIVEL 3B: Análisis de Desviación de Calidad

WITH promedio_global AS (
    SELECT AVG(DefectRate) as avg_rate FROM manufacturing
)
SELECT 
    m.id_proceso,
    m.DefectRate,
    m.QualityScore
FROM manufacturing m, promedio_global p
WHERE m.DefectRate > p.avg_rate
ORDER BY m.DefectRate DESC;

