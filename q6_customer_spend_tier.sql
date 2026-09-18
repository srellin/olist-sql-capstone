-- 6. Segment customers into spend tiers (Low / Medium / High)
#Low: less than 100
#Medium: 100 to below 500
#High: 500 or more

with customer_spend as (select
        c.customer_unique_id,
        sum(op.payment_value) as total_spent
    from customers c
    join orders o
        on c.customer_id = o.customer_id
    join order_payments op
        on o.order_id = op.order_id
    group by c.customer_unique_id)
select
    customer_unique_id,
    format(total_spent, 2) as total_spent,
    case
        when total_spent < 100 then 'Low'
        when total_spent < 500 then 'Medium'
        else 'High'
    end as spend_tier
from customer_spend
order by total_spent desc;
