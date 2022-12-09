--To disable this model, set the shopify__using_order_adjustment variable within your dbt_project.yml file to False.
{{ config(enabled=var('shopify__using_order_adjustment', True)) }}

with base as (

    select * 
    from {{ ref('stg_shopify__order_adjustment_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__order_adjustment_tmp')),
                staging_columns=get_order_adjustment_columns()
            )
        }}

        {{ fivetran_utils.source_relation(
            union_schema_variable='shopify_union_schemas', 
            union_database_variable='shopify_union_databases') 
        }}
        
    from source
),

final as (

    select
        id as order_adjustment_id,
        order_id,
        refund_id,
        amount,
        amount_set,
        tax_amount,
        tax_amount_set,
        kind,
        reason,
        source_relation,
        _fivetran_synced

    from fields
)

select * 
from final
