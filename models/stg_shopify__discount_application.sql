with base as (

    select * 
    from {{ ref('stg_shopify__discount_application_tmp') }}

),

fields as (

    select
    
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__discount_application_tmp')),
                staging_columns=get_discount_application_columns()
            )
        }}

        {{ fivetran_utils.source_relation(
            union_schema_variable='shopify_union_schemas', 
            union_database_variable='shopify_union_databases') 
        }}

    from base

),

final as (
    
    select 
        order_id,
        source_relation,
        value,
        value_type,
        target_type
    from fields

)

select * 
from final
