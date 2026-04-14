WITH products AS (
    SELECT * FROM {{ ref('int_products_cleaned') }}
)

SELECT
    PRODUCT_ID,
    PRODUCT_NAME,
    PRODUCT_CATEGORY,
    PRODUCT_COST,
    PRODUCT_PRICE,
    MARGIN_PERCENT
FROM products
