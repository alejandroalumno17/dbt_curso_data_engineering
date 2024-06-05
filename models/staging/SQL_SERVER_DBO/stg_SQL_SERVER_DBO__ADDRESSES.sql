with 

source as (
    select * from {{ source('SQL_SERVER_DBO', 'ADDRESSES') }}
),

renamed as (
    select
        CAST(address_id AS TEXT) AS address_id,
        CAST(zipcode AS TEXT) AS zipcode,
        country,
        address,
        state,
        _fivetran_deleted,
        CAST(_fivetran_synced AS TIMESTAMP_NTZ) AS _fivetran_synced
    from source
)

select * from renamed



