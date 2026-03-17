-- 1 VERIFICACION CONEXION
SELECT version();;

-- 2 CUARTIL CRITICO CONTEO
SELECT cuartil_calidad, COUNT(id_proceso) as total_procesos
        FROM (
            SELECT id_proceso, NTILE(4) OVER (ORDER BY "QualityScore" DESC) as cuartil_calidad
            FROM manufacturing
        ) as subconsulta
        WHERE cuartil_calidad = 4
        GROUP BY cuartil_calidad;;

-- 3 ANALISIS EJECUTIVO CAUSA RAIZ
WITH ClasificacionCalidad AS (
            SELECT id_proceso, "QualityScore", "WorkerProductivity", "MaintenanceHours",
                   NTILE(4) OVER (ORDER BY "QualityScore" DESC) as cuartil_calidad
            FROM manufacturing
        )
        SELECT COUNT(id_proceso) as total, ROUND(AVG("WorkerProductivity")::numeric, 2) as avg_prod,
               ROUND(AVG("MaintenanceHours")::numeric, 2) as avg_maint
        FROM ClasificacionCalidad WHERE cuartil_calidad = 4;;

-- 4 CORRELACION MANTENIMIENTO DEFECTOS
WITH Segmentacion AS (
            SELECT "DefectRate", "MaintenanceHours",
            CASE WHEN "MaintenanceHours" < 20 THEN '1. Bajo' 
                 WHEN "MaintenanceHours" BETWEEN 20 AND 50 THEN '2. Medio' 
                 ELSE '3. Alto' END AS nivel_mantenimiento
            FROM manufacturing
        )
        SELECT nivel_mantenimiento, ROUND(AVG("DefectRate")::numeric, 4) as avg_defect_rate
        FROM Segmentacion GROUP BY nivel_mantenimiento ORDER BY nivel_mantenimiento;;

