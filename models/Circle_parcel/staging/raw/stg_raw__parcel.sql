with 

source as (

    select * from {{ source('raw', 'parcel') }}

),

renamed as (

    select
        parcel_id,
        parcel_tracking,
        transporter,
        CASE WHEN priority = 'High' THEN '1-High'
             WHEN priority = 'Medium' THEN '2-Medium'
             WHEN priority = 'Low' THEN '3-Low' ELSE '0' END AS priority,
        PARSE_DATE('%B %e, %Y', date_purchase) AS date_purchase,
        PARSE_DATE('%B %e, %Y', date_shipping) AS date_shipping,
        PARSE_DATE('%B %e, %Y', date_delivery) AS date_delivery,
        PARSE_DATE('%B %e, %Y', datecancelled) AS date_cancelled, 
        EXTRACT (MONTH FROM PARSE_DATE('%B %e, %Y', date_purchase)) AS month_purchase,
        CASE WHEN PARSE_DATE('%B %e, %Y', datecancelled) is not NULL THEN 'Cancelled'
             WHEN PARSE_DATE('%B %e, %Y', date_delivery) is not NULL THEN 'Delivered'
             WHEN PARSE_DATE('%B %e, %Y', date_shipping) is not NULL THEN 'Shipped'
             WHEN PARSE_DATE('%B %e, %Y', date_purchase) is not NULL THEN 'Purchased'
             ELSE '0' END AS status,
        DATE_DIFF (PARSE_DATE('%B %e, %Y', date_shipping),PARSE_DATE('%B %e, %Y', date_purchase),DAY) AS expedition_time,
        DATE_DIFF (PARSE_DATE('%B %e, %Y', date_delivery),PARSE_DATE('%B %e, %Y', date_shipping),DAY) AS transport_time,
        DATE_DIFF (PARSE_DATE('%B %e, %Y', date_delivery),PARSE_DATE('%B %e, %Y', date_purchase),DAY) AS delivery_time,
        IF(date_delivery IS NULL,NULL,IF(DATE_DIFF(PARSE_DATE("%B %e, %Y", date_delivery),PARSE_DATE("%B %e, %Y", date_purchase),DAY)>5,1,0)) AS delay
    from source

)

select * from renamed