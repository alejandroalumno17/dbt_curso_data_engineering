{{
  config(
    materialized='view'
  )
}}

with 

source as (
    select * from {{ source('SQL_SERVER_DBO', 'PROMOS') }}
),

renamed_casted as (
    select
        promo_id as promo_name,
        discount as discount_euros,
        _fivetran_deleted,
        _fivetran_synced,
        md5(promo_id) as promo_id,
        status
    from source
)

select * from renamed_casted