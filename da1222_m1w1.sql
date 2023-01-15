-----------------------------------------------------------------------------
-- Mãos na massa
-- O que é SQL e como usá-lo
-- Professor: Rodolfo Amancio 
-----------------------------------------------------------------------------


SELECT DISTINCT product_category_name FROM products

SELECT COUNT (product_category_name) FROM products

SELECT COUNT (DISTINCT product_category_name) FROM products






































-----------------------------------------------------------------------------
-- Quantos categorias de produtos existem no e-commerce em análise ?
-----------------------------------------------------------------------------

SELECT 
	DISTINCT product_category_name  
FROM products

SELECT 
	COUNT(DISTINCT product_category_name)  
FROM products

-----------------------------------------------------------------------------
-- Quantos clientes existem por estado?
-----------------------------------------------------------------------------

SELECT * FROM customers LIMIT 10

SELECT 
	COUNT (DISTINCT customer_unique_id) AS numero_clientes
FROM customers
WHERE customer_state = "RJ"
	
SELECT
	customer_state,
	COUNT (DISTINCT customer_unique_id) AS numero_clientes
FROM customers
GROUP BY customer_state
ORDER BY numero_clientes DESC

-----------------------------------------------------------------------------
-- Os valores das compras são diferentes entre diferentes formas de 
-- pagamento?
-----------------------------------------------------------------------------

SELECT * FROM order_payments LIMIT 50

SELECT
	payment_type,
	MIN(payment_value) AS min_pagamento,
	AVG(payment_value) AS media_pagamento,
	MAX(payment_value) AS max_pagamento,
	SUM(payment_value)/1000000 AS total_pagamento_milhoes
FROM order_payments 
GROUP BY payment_type 

-----------------------------------------------------------------------------
-- Quantos clientes existem por região?
-----------------------------------------------------------------------------

SELECT * FROM customers LIMIT 10

SELECT 
	COUNT (DISTINCT customer_unique_id) 
FROM customers
WHERE 
	customer_state = "SP"
	OR customer_state = "MG"
	OR customer_state = "RJ"
	OR customer_state = "ES"
LIMIT 50

SELECT 
	*,
	CASE
		WHEN customer_state == "SP" 
			OR customer_state = "MG"
			OR customer_state = "RJ"
			OR customer_state = "ES"
		THEN "sudeste"
	END AS regiao
FROM customers

SELECT 
	*,
	CASE
		WHEN customer_state IN ("SP", "RJ", "ES", "MG")
		THEN "sudeste"
	END AS regiao
FROM customers



SELECT 
	CASE
		WHEN customer_state IN ("MT", "MS", "DF", "GO") THEN "centro-oeste"
		WHEN customer_state IN ("SP", "MG", "RJ", "ES") THEN "sudeste"
		WHEN customer_state IN ("AC", "AM", "AP", "PA", "RO", "RR", "TO") THEN "norte"
		WHEN customer_state IN ("AL", "BA", "CE", "MA", "PI", "PE", "PB", "RN", "SE") THEN "nordeste"
		WHEN customer_state IN ("PR", "RS", "SC") THEN "sul"
		ELSE "vazio"
	END AS regiao,
	*
FROM customers
LIMIT 50

SELECT 
	CASE
		WHEN customer_state IN ("MT", "MS", "DF", "GO") THEN "centro-oeste"
		WHEN customer_state IN ("SP", "MG", "RJ", "ES") THEN "sudeste"
		WHEN customer_state IN ("AC", "AM", "AP", "PA", "RO", "RR", "TO") THEN "norte"
		WHEN customer_state IN ("AL", "BA", "CE", "MA", "PI", "PE", "PB", "RN", "SE") THEN "nordeste"
		WHEN customer_state IN ("PR", "RS", "SC") THEN "sul"
		ELSE "vazio"
	END AS regiao,
	COUNT(DISTINCT customer_unique_id) AS numero_clientes
FROM customers
GROUP BY regiao
ORDER BY numero_clientes DESC

-----------------------------------------------------------------------------
-- Quanto é pago por cada forma diferente de pagamento?
-----------------------------------------------------------------------------

SELECT
	payment_type,
	SUM(payment_value)/1000000 as total_pagamento
FROM order_payments
GROUP BY payment_type 
ORDER BY total_pagamento DESC

-----------------------------------------------------------------------------
-- Qual o total de pedidos por ano?
-----------------------------------------------------------------------------

SELECT
	*,
	SUBSTRING(order_purchase_timestamp, 1, 4) AS ano
FROM orders 
LIMIT 50


SELECT
	SUBSTRING(order_purchase_timestamp, 1, 4) AS ano,
	COUNT(DISTINCT order_id) AS total_pedidos
FROM orders
GROUP BY ano
ORDER BY ano

-----------------------------------------------------------------------------
-- E por mês e ano?
-----------------------------------------------------------------------------

SELECT 
	*,
	SUBSTRING(order_purchase_timestamp, 1, 4) AS ano,
	SUBSTRING(order_purchase_timestamp, 6, 2) AS mes
FROM orders 
LIMIT 10

SELECT 
	SUBSTRING(order_purchase_timestamp, 1, 4) AS ano,
	SUBSTRING(order_purchase_timestamp, 6, 2) AS mes,
	COUNT(DISTINCT order_id) AS total_pedidos
FROM orders
GROUP BY ano, mes
ORDER BY ano, mes

SELECT 
	order_purchase_timestamp,
	STRFTIME("%H", order_purchase_timestamp) 
FROM orders
LIMIT 10

SELECT
	STRFTIME('%m', order_purchase_timestamp) AS mes,
	STRFTIME('%Y', order_purchase_timestamp) AS ano,
	COUNT(DISTINCT order_id) AS total_pedidos
FROM orders
GROUP BY ano, mes
ORDER BY ano, mes

