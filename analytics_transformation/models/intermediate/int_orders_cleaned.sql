With raw_orders As (
      SELECT * FROM {{ source('raw_bronze', 'STG_ORDERS')}}
),
deduplicated AS (
      SELECT *,
      ROW_NUMBER() OVER (PARTITION BY ORDER_ID ORDER BY _LOADED_AT DESC) AS Row_num
      FROM raw_orders
)
SELECT 
      ORDER_ID,
      CUSTOMER_ID,
      CAST(ORDER_DATE AS TIMESTAMP) AS ORDERED_AT,
      COALESCE(TOTAL_AMOUNT, 0) AS TOTAL_AMOUNT,
      UPPER(COALESCE(STATUS, 'UNKNOWN')) AS STATUS
FROM deduplicated
WHERE Row_num = 1
