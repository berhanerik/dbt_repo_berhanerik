with 

source as (

    select * from {{ source('raw', 'parcel') }}

),

renamed as (

    select
        parcel_id,
        parcel_tracking,
        transporter,
        priority,
        PARSE_DATE('%b %e, %Y', date_purchase),
        PARSE_DATE('%b %e, %Y', date_shipping),
        PARSE_DATE('%b %e, %Y', date_delivery),
        PARSE_DATE('%b %e, %Y', datecancelled)

    from source

)

select * from renamed