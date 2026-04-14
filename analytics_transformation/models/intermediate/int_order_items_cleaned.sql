With raw_order_items As (
      SELECT * FROM {{ source('raw_bronze', 'STG_ORDER_ITEMS')}}
),
deduplicated As (
      SELECT *,
      ROW_NUMBER() OVER (PARTITION BY ITEM_ID ORDER BY _LOADED_AT DESC) AS Row_num
      FROM raw_order_items
)
SELECT 
      ITEM_ID,
      ORDER_ID,
      PRODUCT_ID,
      -- Ensure we don't have negative or zero quantities
      CASE 
        WHEN QUANTITY <= 0 THEN 1 
        ELSE QUANTITY 
      END AS QUANTITY,
      -- Ensure unit price is non-negative
      CASE 
        WHEN UNIT_PRICE < 0 THEN 0 
        ELSE UNIT_PRICE 
      END AS UNIT_PRICE,
      -- Business Logic: Calculate the actual line total
      ROUND(QUANTITY * UNIT_PRICE, 2) AS LINE_ITEM_TOTAL,
      _LOADED_AT
FROM deduplicated
WHERE Row_num = 1
