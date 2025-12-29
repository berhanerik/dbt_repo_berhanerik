WITH nb_products_parcel AS (
select
ParCEL_id AS parcel_id,
COUNT(DISTINCT Model_mAME) AS nb_models,
SUM(QUANTITY) AS qty
from {{ref("stg_raw__parcel_product")}}
GROUP BY ParCEL_id)

SELECT
p.parcel_id,
p.parcel_tracking,
p.transporter,
p.priority,
p.date_purchase,
p.date_shipping,
p.date_delivery,
p.date_cancelled,
p.month_purchase,
p.expedition_time,
p.transport_time,
p.delivery_time,
p.delay,
pp.qty,
pp.nb_models
FROM {{ref("stg_raw__parcel")}} AS p
LEFT JOIN nb_products_parcel AS pp
	USING (parcel_id)