--Задание 2.1
SELECT p.name_of_company
FROM provider p
JOIN shipment s ON p.provider_id = s.provider_id
JOIN shipment_content sc ON s.shipment_id = sc.shipment_id
JOIN product pr ON sc.product_id = pr.product_id
GROUP BY p.provider_id, p.name_of_company
HAVING COUNT(DISTINCT pr.product_id) = (SELECT COUNT(DISTINCT pr1.product_id) FROM product pr1);

--Задание 2.2
SELECT 
  p.name_of_company,
  pr.product_name,
  MIN(sc.price) AS lowest_price
FROM 
  provider p
  JOIN shipment s ON p.provider_id = s.provider_id
  JOIN shipment_content sc ON s.shipment_id = sc.shipment_id
  JOIN product pr ON sc.product_id = pr.product_id
WHERE 
  sc.price = (
    SELECT 
      MIN(sc2.price) 
    FROM 
      shipment_content sc2 
      JOIN shipment s2 ON sc2.shipment_id = s2.shipment_id
    WHERE 
      s2.provider_id = p.provider_id 
      AND sc2.product_id = sc.product_id
  )
GROUP BY 
  p.name_of_company, pr.product_name;

--Задание 2.3
SELECT 
  pr.product_name, 
  sc.price
FROM 
  product pr
  JOIN shipment_content sc ON pr.product_id = sc.product_id
  JOIN shipment s ON sc.shipment_id = s.shipment_id
  JOIN provider p ON s.provider_id = p.provider_id
WHERE 
  sc.price = (
    SELECT 
      MIN(sc2.price) 
    FROM 
      shipment_content sc2
      JOIN shipment s2 ON sc2.shipment_id = s2.shipment_id
    WHERE 
      sc2.product_id = sc.product_id
  )
GROUP BY 
  pr.product_name, sc.price
HAVING 
  COUNT(DISTINCT p.name_of_company) = (
    SELECT 
      COUNT(*) 
    FROM 
      provider
  );

--Задание 2.4
SELECT 
  SUM(pc.amount_of_goods * sc.price) AS daily_income
FROM 
  purchase_content pc
  JOIN purchase_invoice pi ON pc.purchase_id = pi.purchase_id
  JOIN purchase p ON pc.purchase_id = p.purchase_id
  JOIN shipment_content sc ON pc.product_id = sc.product_id
WHERE 
  pi.invoice_date = CURRENT_DATE
  AND p.status = 'completed';

--Задание 2.5
SELECT 
  p.product_name, 
  SUM(sc.remains * sc.price) AS total_cost
FROM 
  product p
  JOIN shipment_content sc ON p.product_id = sc.product_id
WHERE 
  sc.remains > 0
GROUP BY 
  p.product_name;

--Задание 2.6
SELECT 
  sc.expiration_date, 
  SUM(sc.amount_of_goods) AS total_goods 
FROM 
  shipment_content sc 
  JOIN shipment s ON sc.shipment_id = s.shipment_id
WHERE 
  s.invoice_fulfillment_date = (
    SELECT MIN(invoice_fulfillment_date) 
    FROM shipment
  )
GROUP BY 
  sc.expiration_date
ORDER BY 
  total_goods ASC 
LIMIT 1;

--Задание 2.7
SELECT 
  COUNT(*) AS num_products
FROM 
  product;

--Задание 3.1
CREATE VIEW num_orders_last_year AS
SELECT 
  c.organization_name, 
  COUNT(*) AS num_orders
FROM 
  purchase p
  JOIN client c ON p.client_id = c.client_id
WHERE 
  p.invoice_fulfillment_date >= DATE_TRUNC('year', CURRENT_DATE - INTERVAL '1 year')
  AND p.invoice_fulfillment_date < DATE_TRUNC('year', CURRENT_DATE)
GROUP BY 
  c.organization_name;

--Задание 3.2
CREATE VIEW base_income AS
SELECT 
  SUM(sc.remains * sc.price) AS income
FROM 
  shipment_content sc
  JOIN shipment s ON sc.shipment_id = s.shipment_id
WHERE 
  s.invoice_fulfillment_date >= '2023-01-01'
  AND s.invoice_fulfillment_date <= '2023-04-30';

--Задания INSERT, UPDATE, DELETE
INSERT INTO purchase_invoice (purchase_id, invoice_number, invoice_date, payment_date)
SELECT 
  p.purchase_id, 
  100, 
  '2023-05-01', 
  '2023-05-10'
FROM 
  purchase p
  JOIN client c ON p.client_id = c.client_id
WHERE 
  c.organization_name IN (
    SELECT organization_name
    FROM purchase p
    JOIN client c ON p.client_id = c.client_id
    WHERE 
      p.invoice_fulfillment_date >= DATE_TRUNC('year', CURRENT_DATE - INTERVAL '1 year')
      AND p.invoice_fulfillment_date < DATE_TRUNC('year', CURRENT_DATE)
  );


UPDATE shipment_content
SET 
  remains = 10
WHERE 
  product_id = (
    SELECT product_id
    FROM product
    WHERE product_name = 'Kettle'
  );


DELETE FROM shipment
WHERE 
  manager_id = (
    SELECT manager_id
    FROM manager
    WHERE contact_information IS NULL
  );

--простой индекс 
SELECT p.name_of_company
FROM provider p
JOIN shipment s ON p.provider_id = s.provider_id
JOIN shipment_content sc ON s.shipment_id = sc.shipment_id
JOIN product pr ON sc.product_id = pr.product_id
GROUP BY p.provider_id, p.name_of_company
HAVING COUNT(DISTINCT pr.product_id) = (SELECT COUNT(DISTINCT pr1.product_id) FROM product pr1);
CREATE INDEX idx_provider_name_of_company
ON provider (name_of_company);

--составной индекс
SELECT 
  p.name_of_company,
  pr.product_name,
  MIN(sc.price) AS lowest_price
FROM 
  provider p
  JOIN shipment s ON p.provider_id = s.provider_id
  JOIN shipment_content sc ON s.shipment_id = sc.shipment_id
  JOIN product pr ON sc.product_id = pr.product_id
WHERE 
  sc.price = (
    SELECT 
      MIN(sc2.price) 
    FROM 
      shipment_content sc2 
      JOIN shipment s2 ON sc2.shipment_id = s2.shipment_id
    WHERE 
      s2.provider_id = p.provider_id 
      AND sc2.product_id = sc.product_id
  )
GROUP BY 
  p.name_of_company, pr.product_name;
CREATE INDEX idx_shipment_content_shipment_id_product_id
ON shipment_content (shipment_id, product_id);


