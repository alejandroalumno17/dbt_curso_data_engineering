with scr_orders_items_products as (
    select
        o.order_id,
        o.shipping_service_id,
        o.address_id,
        o.created_at_utc::date as created_at_utc,
        o.promo_id,
        o.order_cost_dollar,
        o.user_id,
        o.order_total_dollar,
        o.tracking_id,
        o.order_status_id,
        oi.product_id,
        oi.quantity_of_products,
        p.PRICE_EURO,
        p.NAME as product_name,
        p.INVENTORY,
        p.PRICE_EURO * oi.QUANTITY AS TOTAL_PRECIO_CANTIDAD
    from 
        {{ ref('stg_SQL_SERVER_DBO__orders') }} as o
    left join 
        {{ ref('stg_SQL_SERVER_DBO__order_items') }} as oi
        on o.order_id = oi.order_id
    left join 
        {{ ref('stg_SQL_SERVER_DBO__products') }} as p
        on oi.product_id = p.product_id
)

select * from scr_orders_items_products