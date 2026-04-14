With raw_products As (
      SELECT * FROM {{ source('raw_bronze', 'STG_PRODUCTS')}}
)
SELECT 
      ID AS PRODUCT_ID,
      INITCAP(NAME) AS PRODUCT_NAME,
      INITCAP(CATEGORY) AS PRODUCT_CATEGORY,
      COST AS PRODUCT_COST,
      PRICE AS PRODUCT_PRICE,
      -- Business Logic: Calculating Profit and Margin %
     (PRICE - COST) AS PROFIT_PER_UNIT,
     ROUND(((PRICE - COST) / NULLIF(PRICE, 0)) * 100, 2) AS MARGIN_PERCENT
FROM raw_products
