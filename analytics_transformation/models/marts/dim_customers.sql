WITH customers AS (
    SELECT * FROM {{ ref('int_customers_cleaned') }}
)

SELECT
    CUSTOMER_ID,
    CUSTOMER_NAME,
    CUSTOMER_EMAIL,
    COUNTRY,
    SIGNUP_DATE
FROM customers
