with payments as(
    select * from {{ ref("stg_payments")}}
),
pivoted as (
    select 
        order_id,
        
        {% set payment_methods = ['bank_transfer','coupon','credit_card','gift_card'] %}
        {% for method in payment_methods %}
            sum(case when payment_method= '{{ method }}'  then amount else 0 end) as {{ method }}_TRANSFER_AMOUNT
            {% if not loop.last %}
                ,
            {% endif %}
        {% endfor %}
        
        /*
        sum(case when payment_method = 'bank_transfer' then amount else 0 end) as bank_transfer_amount,
        sum(case when payment_method = 'coupon' then amount else 0 end) as coupon_transfer_amount,
        sum(case when payment_method = 'credit_card' then amount else 0 end) as credit_card__transfer_amount,
        sum(case when payment_method = 'gift_card' then amount else 0 end) as gift_card_transfer_amount
        */
    from payments
    where status= limit_data_in_dev('success')
    group by 1
)

select * from pivoted