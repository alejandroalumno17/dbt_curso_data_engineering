{{ 
    config(
        materialized='table', 
        sort='date_day',
        dist='date_day',
        pre_hook="alter session set timezone = 'Europe/Madrid'; alter session set week_start = 7;" 
    ) 
}}

with date_spine as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2000-01-01' as date)",
        end_date="cast(current_date() + interval '1 day' as date)"
    )
    }}
)

select
    date_day as fecha,
    year(date_day) as anio,
    month(date_day) as mes,
    day(date_day) as dia,
    dayofweek(date_day) as dia_semana,
    case when dayofweek(date_day) in (1, 7) then 'Fin de semana' else 'Día laborable' end as tipo_dia,
    monthname(date_day) as mes_nombre,
    week(date_day) as semana_anio,
    date_trunc('week', date_day) as semana_inicio,
    date_trunc('month', date_day) as mes_inicio,
    date_trunc('quarter', date_day) as trimestre_inicio,
    date_trunc('year', date_day) as anio_inicio,
    dateadd('day', -1, date_day) as dia_previo,
    dateadd('day', 1, date_day) as dia_siguiente,
    current_timestamp() as _fivetran_synced
from date_spine
order by
    date_day desc

