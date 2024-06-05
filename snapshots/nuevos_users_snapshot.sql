{% snapshot nuevos_users_snapshot %}

{{
  config(
    target_schema='snapshots',
    unique_key='user_id',
    strategy='check',
    check_cols=[
        'UPDATED_AT', 'ADDRESS_ID', 'LAST_NAME', 'CREATED_AT',
        'PHONE_NUMBER', 'TOTAL_ORDERS', 'FIRST_NAME', 'EMAIL', '_FIVETRAN_DELETED'
    ]
  )
}}

select
    USER_ID,
    UPDATED_AT,
    ADDRESS_ID,
    LAST_NAME,
    CREATED_AT,
    PHONE_NUMBER,
    TOTAL_ORDERS,
    FIRST_NAME,
    EMAIL,
    _FIVETRAN_DELETED,
    current_timestamp() as _FIVETRAN_SYNCED 
from {{ source('SQL_SERVER_DBO', 'USERS') }} 

{% endsnapshot %}