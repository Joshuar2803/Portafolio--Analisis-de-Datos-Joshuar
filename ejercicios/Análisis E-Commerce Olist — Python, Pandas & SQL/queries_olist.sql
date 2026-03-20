
-- NIVEL 1: Diagnóstico General
-- 1.1 Total órdenes y órdenes entregadas
SELECT COUNT(order_id) as total_ordenes, 
       SUM(CASE WHEN order_status = 'delivered' THEN 1 ELSE 0 END) as entregadas
FROM orders;

-- 1.2 Ticket promedio por orden
SELECT AVG(total_pago) as ticket_promedio
FROM (SELECT order_id, SUM(payment_value) as total_pago FROM payments GROUP BY order_id);

-- 1.3 Top 5 estados con más órdenes entregadas
SELECT c.customer_state, COUNT(DISTINCT o.order_id) as total_ordenes
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY total_ordenes DESC
LIMIT 5;

-- NIVEL 2: Eficiencia Operativa
-- 2.1 Días promedio de entrega
SELECT AVG(julianday(order_delivered_customer_date) - julianday(order_purchase_timestamp)) as promedio_dias
FROM orders WHERE order_status = 'delivered';

-- 2.2 Porcentaje de órdenes tarde
SELECT SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1 ELSE 0 END) * 100.0 / COUNT(*) as pct_tardanza
FROM orders WHERE order_status = 'delivered';

-- NIVEL 3: Comportamiento de Pago
-- 3.1 Órdenes por método de pago
SELECT payment_type, COUNT(DISTINCT order_id) as total_ordenes
FROM payments GROUP BY payment_type;

-- 3.2 Promedio de cuotas en tarjeta de crédito
SELECT AVG(payment_installments) as promedio_cuotas
FROM payments WHERE payment_type = 'credit_card';
