CREATE OR REPLACE FUNCTION reduce_price(days_limit INT, reduction_percent REAL)
RETURNS VOID AS $$
BEGIN
    UPDATE shipment_content
    SET price = price * (1 - reduction_percent / 100)
    FROM shipment
    WHERE shipment.shipment_id = shipment_content.shipment_id AND
    current_date - shipment.invoice_creation_date > days_limit;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION total_sales_last_day()
RETURNS DECIMAL AS $$
DECLARE
    total DECIMAL;
BEGIN
    SELECT SUM(purchase_content.price * purchase_content.amount_of_goods) INTO total
    FROM purchase_content
    JOIN purchase ON purchase.purchase_id = purchase_content.purchase_id
    WHERE purchase.invoice_creation_date = current_date - interval '1 day';
    RETURN total;
END;
$$ LANGUAGE plpgsql;

SELECT reduce_price(7, 10);

SELECT total_sales_last_day();

--Вторая часть задания 

CREATE TABLE log_table (
    log_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    table_name VARCHAR(100),
    operation VARCHAR(10),
    old_data TEXT,
    new_data TEXT,
    log_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION product_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_table (table_name, operation, new_data)
    VALUES ('product', 'INSERT', row_to_json(NEW)::text);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER product_insert_log
AFTER INSERT ON product
FOR EACH ROW EXECUTE FUNCTION product_insert_trigger();

CREATE OR REPLACE FUNCTION product_update_trigger()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_table (table_name, operation, old_data, new_data)
    VALUES ('product', 'UPDATE', row_to_json(OLD)::text, row_to_json(NEW)::text);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER product_update_log
AFTER UPDATE ON product
FOR EACH ROW EXECUTE FUNCTION product_update_trigger();

CREATE OR REPLACE FUNCTION product_delete_trigger()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_table (table_name, operation, old_data)
    VALUES ('product', 'DELETE', row_to_json(OLD)::text);
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER product_delete_log
AFTER DELETE ON product
FOR EACH ROW EXECUTE FUNCTION product_delete_trigger();

--Тест 
INSERT INTO product (product_type, product_name, unit_of_measurement_id)
VALUES ('Test', 'Test product', 1);

UPDATE product
SET product_name = 'Updated product'
WHERE product_name = 'Test product';

DELETE FROM product
WHERE product_name = 'Updated product';

SELECT * FROM log_table;