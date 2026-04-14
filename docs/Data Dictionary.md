# DATA DICTIONARY

## Overview

This document provides the technical specifications and business descriptions for the finalized data tables within the Snowflake data warehouse. It outlines the schema mapping from the legacy source to the optimized cloud destination.

| Column | Data Type | Description |
|--------|-----------|-------------|
| ORDER_ID | INT | Unique identifier for the transaction header. |
| CUSTOMER_ID | INT | Foreign Key; used for Distinct Customer and CLV metrics. |
| PRODUCT_ID | INT | Foreign Key; used for Product Affinity and Inventory analysis. |
| ORDERED_AT | TIMESTAMP | The exact date/time the transaction was recorded. |
| STATUS | VARCHAR | Current state (e.g., 'SHIPPED', 'CANCELLED', 'RETURNED'). |
| COUNTRY | VARCHAR | Normalized geographic attribute (e.g., 'Kenya', 'USA'). |
| PRODUCT_NAME | VARCHAR | Descriptive name of the SKU sold. |
| PRODUCT_CATEGORY | VARCHAR | High-level grouping (e.g., 'Electronics', 'Apparel'). |
| REVENUE | DECIMAL | Quantity * Price. The gross income from this line item. |
| ACTUAL_PROFIT | DECIMAL | (Price - Cost) * Quantity. The net margin for this specific sale. |
