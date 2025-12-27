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
        PARSE_DATE('%B %e, %Y', date_purchase),
        PARSE_DATE('%B %e, %Y', date_shipping),
        PARSE_DATE('%B %e, %Y', date_delivery),
        PARSE_DATE('%B %e, %Y', datecancelled)

    from source

)

select * from renamed