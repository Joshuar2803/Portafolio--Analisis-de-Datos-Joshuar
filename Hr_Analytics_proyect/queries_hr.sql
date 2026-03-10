
-- Proyecto: HR Analytics - Análisis de Rotación
-- Autor: [Joshuar Rodriguez]

-- 1. Tasa de rotación global
SELECT 
    (SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) as tasa_rotacion_global
FROM hr_data;

-- 2. Tasa de rotación por departamento
SELECT 
    Department, 
    (SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) as tasa_rotacion_depto
FROM hr_data
GROUP BY Department;

-- 3. Salario promedio por Departamento y Attrition
SELECT 
    Department, 
    Attrition, 
    AVG(MonthlyIncome) as promedio_salario
FROM hr_data
GROUP BY Department, Attrition;

-- 4. Perfil comparativo (Age, Income, YearsAtCompany, JobSatisfaction)
-- Nota: La lógica de 'OverTime' como porcentaje se maneja con un CASE
SELECT 
    Attrition,
    AVG(Age) as edad_promedio,
    AVG(MonthlyIncome) as salario_promedio,
    AVG(YearsAtCompany) as anios_empresa_promedio,
    AVG(JobSatisfaction) as satisfaccion_promedio,
    (SUM(CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) as porcentaje_horas_extra
FROM hr_data
GROUP BY Attrition;
