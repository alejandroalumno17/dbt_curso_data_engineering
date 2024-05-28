with 

source as (

    select status from {{ source('SQL_SERVER_DBO', 'PROMOS') }}

),

status_dimension as (
    select distinct
        status,
        case
            when status = 'active' then 1
            when status = 'inactive' then 0
        end as estado
    from stg_SQL_SERVER_DBO__PROMOS
)

select * from status_dimension
