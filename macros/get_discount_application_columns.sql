{% macro get_discount_application_columns() %}

{% set columns = [
    {"name": "index", "datatype": dbt.type_string()},
    {"name": "order_id", "datatype": dbt.type_string},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "allocation_method", "datatype": dbt.type_string},
    {"name": "code", "datatype": dbt.type_string},
    {"name": "description", "datatype": dbt.type_string},
    {"name": "target_selection", "datatype": dbt.type_string},
    {"name": "target_type", "datatype": dbt.type_string},
    {"name": "title", "datatype": dbt.type_string},
    {"name": "type", "datatype": dbt.type_string},
    {"name": "value", "datatype": dbt.type_numeric},
    {"name": "value_type", "datatype": dbt.type_string}
] %}

{{ fivetran_utils.add_pass_through_columns(columns, var('customer_pass_through_columns')) }}

{{ return(columns) }}

{% endmacro %}
