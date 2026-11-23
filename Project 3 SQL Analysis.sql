-- ============================================================================
-- DecodeLabs Data Analytics Training - Project 3: SQL Data Analysis
-- Dataset: CleanedEcommerce (1,200 E-Commerce Transactions)
-- ============================================================================

-- Verification: Confirm total record count and gross revenue
SELECT 
    COUNT(*) AS total_rows, 
    ROUND(SUM(TotalPrice), 2) AS total_revenue
FROM CleanedEcommerce;

-- Query 1: Revenue, Unit Volume & Average Order Value by Product
SELECT 
    Product,
    COUNT(OrderID) AS total_orders,
    SUM(Quantity) AS total_units_sold,
    ROUND(SUM(TotalPrice), 2) AS total_revenue,
    ROUND(AVG(TotalPrice), 2) AS avg_order_value
FROM CleanedEcommerce
GROUP BY Product
ORDER BY total_revenue DESC;

-- Query 2: Order Fulfillment & Revenue Attrition by Order Status
SELECT 
    OrderStatus,
    COUNT(OrderID) AS order_count,
    ROUND(SUM(TotalPrice), 2) AS status_revenue_impact,
    ROUND(AVG(TotalPrice), 2) AS avg_transaction_value
FROM CleanedEcommerce
GROUP BY OrderStatus
ORDER BY order_count DESC;

-- Query 3: High-Value VIP Outlier Extraction (IQR Upper Threshold > $3,330.41)
SELECT 
    OrderID,
    Date,
    Product,
    Quantity,
    TotalPrice,
    OrderStatus
FROM CleanedEcommerce
WHERE TotalPrice > 3330.41
ORDER BY TotalPrice DESC;

-- Query 4: Net Realized Revenue by Product (Excluding Cancelled & Returned Orders)
SELECT 
    Product,
    COUNT(OrderID) AS successful_orders,
    ROUND(SUM(TotalPrice), 2) AS realized_revenue
FROM CleanedEcommerce
WHERE OrderStatus NOT IN ('Cancelled', 'Returned')
GROUP BY Product
ORDER BY realized_revenue DESC;

-- Query 5: High-Performing Product Categories (> $180,000 Gross Revenue)
SELECT 
    Product,
    COUNT(OrderID) AS total_orders,
    ROUND(SUM(TotalPrice), 2) AS gross_revenue
FROM CleanedEcommerce
GROUP BY Product
HAVING SUM(TotalPrice) > 180000
ORDER BY gross_revenue DESC;