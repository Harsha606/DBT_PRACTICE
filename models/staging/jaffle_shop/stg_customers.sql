/* with customers as (
    
    select 
        id as customer_id,
        first_name,
        last_name

    from raw.jaffle_shop.customers
)

select * from customers
*/
with source as (
    slect * fro raw.jaffle_shop.customers
),
staged as (
    select
    id as customer_id,
    first_name,
    last_name
    from source
)

select * from satged