# 📦 Análisis E-Commerce Olist — Python, Pandas & SQL
**Portafolio de Análisis de Datos | Joshuar Rodriguez**

---

## 🎯 Objetivo del Proyecto

Análisis exploratorio y operacional del dataset público de **Olist** (E-Commerce brasileño), respondiendo preguntas clave de negocio desde dos perspectivas técnicas: **Pandas (Python)** para exploración ágil y **SQL (SQLite)** para consultas analíticas estructuradas.

> El proyecto simula el trabajo real de un Analista de Datos contratado por Olist para responder preguntas del Director Comercial sobre la salud operativa del negocio.

---

## 🗂️ Estructura del Repositorio

```
📁 olist-ecommerce-analysis/
│
├── 📓 analisis_olist.ipynb       # Análisis exploratorio con Pandas (Día 4)
├── 📓 sql_olist.ipynb             # Análisis con SQL sobre SQLite (Día 5)
├── 📄 queries_olist.sql           # Queries SQL limpias y comentadas
└── 📄 README.md
```

---

## 🔎 Dataset

**Brazilian E-Commerce Public Dataset by Olist**
- Fuente: [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
- Tablas utilizadas: `orders`, `order_payments`, `customers`
- Período: 2016–2018 | ~99,000 órdenes

---

## ❓ Preguntas de Negocio Respondidas

### 🔴 Nivel 1 — Diagnóstico General
| Pregunta | Resultado |
|---|---|
| Total de órdenes | 99,441 |
| Órdenes entregadas exitosamente | 96,478 (97%) |
| Ticket promedio por orden | R$ 161 |
| Top estado por volumen | São Paulo (SP) — 40,501 órdenes |

### 🟡 Nivel 2 — Eficiencia Operativa
| Pregunta | Resultado |
|---|---|
| Días promedio de entrega | ~12 días |
| % de órdenes tardías | 8.11% |
| Estado con mayor riesgo logístico | Alagoas (AL) — 24.5 días promedio, 23% tardanza |

### 🟢 Nivel 3 — Comportamiento de Pago
| Pregunta | Resultado |
|---|---|
| Método de pago dominante | Tarjeta de crédito (76,505 órdenes) |
| Promedio de cuotas (crédito) | ~4 cuotas |

---

## 💡 Hallazgos Principales

1. **SP concentra el 42% del volumen total.** Optimizar la logística de última milla en São Paulo tiene el mayor impacto potencial en costos.

2. **8.11% de tardanza global** representa un riesgo directo en la satisfacción del cliente y el flujo de caja.

3. **Alagoas (AL) es una zona crítica** con el mayor tiempo de entrega y tasa de tardanza del país. Se recomienda auditoría de proveedores logísticos en esa región.

4. **76% de los pagos son con tarjeta de crédito** en promedio 4 cuotas — activo valioso para campañas de financiación.

---

## 🛠️ Stack Técnico

| Herramienta | Uso |
|---|---|
| Python 3 | Lenguaje base |
| Pandas | Carga, limpieza y exploración de datos |
| SQLite3 | Motor de base de datos en memoria |
| SQL | Consultas analíticas y agregaciones |
| Matplotlib | Visualizaciones exploratorias |
| Google Colab | Entorno de desarrollo |

---

## 🧠 Concepto Clave Demostrado

Este proyecto demuestra la **equivalencia mental entre Pandas y SQL**, aplicada a un caso de negocio real:

| Pandas | SQL |
|---|---|
| `.groupby().nunique()` | `GROUP BY` + `COUNT(DISTINCT)` |
| `.merge(on='key')` | `JOIN ... ON` |
| `df[df['col'] == x]` | `WHERE col = x` |
| `nueva_col = condición` | `CASE WHEN ... THEN ... END` |
| `.mean()` | `AVG()` |

---

## 👤 Autor

**Joshua**
Analista de Datos en formación | Enfoque en E-Commerce, Logística y Finanzas
[LinkedIn](www.linkedin.com/in/joshuar-rodriguez-141981344) · [GitHub](https://github.com/Joshuar2803)
