with 

source as (

    select * from {{ source('SQL_SERVER_DBO', 'ORDERS') }}

),

renamed as (

    select
        order_id,
        shipping_service,
        shipping_cost,
        address_id,
        created_at,
        md5(promo_id) as promo_id,
        case when TRIM(promo_id) = '' then 'Desconocido' else promo_id end as promo_name,
        estimated_delivery_at,
        order_cost,
        user_id,
        order_total,
        delivered_at,
        tracking_id,
        status,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed


