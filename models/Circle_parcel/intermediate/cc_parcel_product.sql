SELECT
p.parcel_id,
pp.model_name
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
p.nb_models
FROM {{ref("cc_parcel")}} AS p
LEFT JOIN {{ref("stg_raw__parcel_product")}} AS pp
	USING (parcel_id)