{% test no_hash_collisions(model,column_name,hashed_fields) %}
{{ config(severity='warn') }}
WITH all_tuples as(
    SELECT 
        distinct {{column_name}} as HASH,
        {{ hashed_fields}}
    FROM {{model}}
), validation_errors as (
    SELECT
        HASH
      , COUNT(*)
    FROM
        all_tuples
    GROUP BY HASH
    HAVING COUNT(*) > 1
)
SELECT * FROM validation_errors
{%- endtest %}