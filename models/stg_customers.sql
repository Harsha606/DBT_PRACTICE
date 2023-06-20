with customers as (
    select
    id ad customer_id,
    first_name,
    last_name
    from raw.jaffle_shop.customers
)
select * from customers;