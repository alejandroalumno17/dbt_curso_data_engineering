{% snapshot borrar_usuario_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='user_id',

      strategy='timestamp',
      updated_at='_fivetran_synced',
      invalidate_hard_deletes=True,
    )
}}

select * from {{ source('SQL_SERVER_DBO', 'USERS') }}

{% endsnapshot %}