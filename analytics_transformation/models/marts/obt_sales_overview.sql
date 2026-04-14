WITH fct_orders AS (
    SELECT * FROM {{ ref('fct_orders') }}
),
dim_customers AS (
    SELECT * FROM {{ ref('dim_customers') }}
),
dim_products AS (
    SELECT * FROM {{ ref('dim_products') }}
),
-- We also need the line items to get product-level detail in our OBT
order_items AS (
    SELECT * FROM {{ ref('int_order_items_cleaned') }}
)

SELECT
    -- Order Info
    f.ORDER_ID,
    f.ORDERED_AT,
    f.STATUS,
    -- Customer Info
    c.CUSTOMER_NAME,
    c.COUNTRY,
    -- Product Info
    p.PRODUCT_NAME,
    P.PRODUCT_COST,
    P.PRODUCT_PRICE,
    p.PRODUCT_CATEGORY,
    -- Metrics
    i.QUANTITY,
    i.LINE_ITEM_TOTAL AS REVENUE,
    (i.QUANTITY * p.PRODUCT_PRICE) - (i.QUANTITY * 0.7 * p.PRODUCT_PRICE) AS ESTIMATED_PROFIT -- Example logic
FROM order_items i
JOIN fct_orders f ON i.ORDER_ID = f.ORDER_ID
JOIN dim_customers c ON f.CUSTOMER_ID = c.CUSTOMER_ID
JOIN dim_products p ON i.PRODUCT_ID = p.PRODUCT_ID
