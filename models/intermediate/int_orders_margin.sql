select orders_id, date_date,
round (SUM (revenue), 2) as revenue,
round (SUM (quantity), 2) as quantity,
round (SUM (purchase_cost), 2) as purchase_cost,
round (SUM (margin), 2) as margin
from {{ ref("int_sales_margin")}} 
group BY orders_id, date_date
order BY orders_id
