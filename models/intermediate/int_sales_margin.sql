select s.*,
round (s.quantity*p.purchase_price, 2) as purchase_cost,
round (s.revenue-p.purchase_price, 2) as margin
from {{ ref("stg_raw__sales")}} as s
LEFT JOIN {{ ref("stg_raw__product")}} as p
ON s.products_id = p.products_id