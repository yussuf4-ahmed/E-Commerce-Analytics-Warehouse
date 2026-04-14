WITH orders AS (
    SELECT * FROM {{ ref('int_orders_cleaned') }}
),

order_items AS (
    SELECT * FROM {{ ref('int_order_items_cleaned') }}
),

final_joined AS (
    SELECT
        o.ORDER_ID,
        o.CUSTOMER_ID,
        o.ORDERED_AT,
        o.STATUS,
        -- Aggregating item data into the order level
        COUNT(i.ITEM_ID) AS TOTAL_ITEMS,
        SUM(i.LINE_ITEM_TOTAL) AS TOTAL_REVENUE
    FROM orders o
    LEFT JOIN order_items i ON o.ORDER_ID = i.ORDER_ID
    GROUP BY 1, 2, 3, 4
)

SELECT * FROM final_joined
