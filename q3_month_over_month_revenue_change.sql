-- 3. month over month change in revenue
with monthly_revenue as (
    select
        date_format(o.order_purchase_timestamp, '%Y-%m') as order_month,
        sum(op.payment_value) as revenue
    from orders o
    join order_payments op
        on o.order_id = op.order_id
    group by date_format(o.order_purchase_timestamp, '%Y-%m')
)
select
    order_month,
    format(revenue, 2, 'en_US') as monthly_revenue,
    format(
        lag(revenue) over (order by order_month),
        2,
        'en_US'
    ) as previous_month_revenue,
    format(
        revenue - lag(revenue) over (order by order_month),
        2,
        'en_US'
    ) as month_over_month_change
from monthly_revenue
order by order_month;
