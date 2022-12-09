--To disable this model, set the shopify__using_order_line_refund variable within your dbt_project.yml file to False.
{{ config(enabled=var('shopify__using_order_line_refund', True)) }}

with base as (

    select * 
    from {{ ref('stg_shopify__order_line_refund_tmp') }}

),

fields as (

    select
    
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__order_line_refund_tmp')),
                staging_columns=get_order_line_refund_columns()
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
        id as order_line_refund_id,
        location_id,
        order_line_id,
        subtotal,
        subtotal_set,
        total_tax,
        total_tax_set,
        quantity,
        refund_id,
        restock_type,
        _fivetran_synced,
        source_relation,

        {{ fivetran_utils.fill_pass_through_columns('order_line_refund_pass_through_columns') }}

    from fields
)

select *
from final

