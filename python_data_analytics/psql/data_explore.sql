-- Show table schema 
\d+ retail;

-- Show first 10 rows
SELECT * FROM retail limit 10;

-- Check # of records
SELECT COUNT(*) FROM retail;

-- number of clients (e.g. unique client ID)
SELECT COUNT(DISTINCT customer_id) FROM retail;

-- invoice date range (e.g. max/min dates)
SELECT MIN(invoice_date) AS min_date, MAX(invoice_date) AS max_date FROM retail;

-- number of SKU/merchants (e.g. unique stock code)
SELECT COUNT(DISTINCT stock_code) FROM retail;

-- Calculate average invoice amount excluding invoices with a negative amount (e.g. canceled orders have negative amount)
SELECT AVG(unit_price * quantity) AS avg_invoice_amount FROM retail WHERE unit_price * quantity >= 0;

-- Calculate total revenue (e.g. sum of unit_price * quantity)
SELECT SUM(unit_price * quantity) AS total_revenue FROM retail;

-- Calculate total revenue by YYYYMM 
SELECT DATE_FORMAT(invoice_date, '%Y%m') AS year_month, SUM(unit_price * quantity) AS total_revenue
FROM retail
GROUP BY year_month;

EOF
