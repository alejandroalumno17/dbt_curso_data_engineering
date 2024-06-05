{% snapshot check_users_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='user_id',
      strategy='check',
      check_cols=['phone_number'],
        )
}}

select * from {{ source('SQL_SERVER_DBO', 'USERS') }}

{% endsnapshot %}