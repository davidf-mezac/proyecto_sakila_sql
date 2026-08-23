# Proyecto de Análisis SQL - Base de Datos Sakila

## Descripción del Proyecto
Este repositorio contiene la resolución documentada de **64 consultas SQL** aplicadas sobre la base de datos relacional **Sakila**. El objetivo del proyecto es demostrar el dominio práctico de SQL, abarcando desde consultas básicas de selección hasta análisis de datos utilizando cruces de tablas, subconsultas y funciones de agrupación.

---

## Tecnologías y Herramientas
* **Motor de Base de Datos:** PostgreSQL
* **Cliente (IDE):** DBeaver Community
* **Lenguaje:** SQL
* **Control de Versiones:** Git & GitHub

---

## Modelo de Datos (Diagrama ER)
Para este análisis, se exploró el esquema relacional de Sakila (simulación de un videoclub). A continuación se presenta el diagrama de las tablas principales:

![Diagrama ER Sakila](01%20Diagrama%20ER.png)

---

## Resumen de Habilidades Demostradas
Las 64 consultas resueltas están diseñadas para aplicar los siguientes conceptos:

1. **Filtrado y ordenamiento básico:** Uso de `WHERE`, operadores lógicos (`AND`, `OR`), `LIKE` y `ORDER BY`.
2. **Cruces de tablas (Joins):** Uso intensivo de `INNER JOIN` y `LEFT JOIN` para conectar múltiples entidades (ej. clientes, alquileres, inventario y películas).
3. **Agregación de datos:** Funciones como `COUNT`, `SUM`, `AVG`, `MAX` y `MIN` agrupadas por categorías usando `GROUP BY` y filtradas con `HAVING`.
4. **Subconsultas y Tablas Temporales:** Uso de subconsultas en el `WHERE`, patrones de *Anti-Join* (`IS NULL`) y Expresiones de Tabla Común (CTEs) para dividir problemas complejos.
5. **Manejo de Fechas:** Extracción de días y meses con `EXTRACT` y formato temporal.

---

## Cómo explorar este proyecto
1. El archivo principal es `02 Consultas_01.sql` (puedes hacer clic en él arriba para ver el código).
2. Cada consulta está comentada con el enunciado original para entender el contexto comercial de lo que se está calculando.

---

## 👤 Autor
* **David F. Meza** - [@davidf-mezac](https://github.com/davidf-mezac)
