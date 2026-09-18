-- 7. how many customers are repeat buyers vs one-time buyers?
with customer_orders as (select
        c.customer_unique_id,
        count(o.order_id) as order_count
    from customers c
    left join orders o
        on c.customer_id = o.customer_id
    group by c.customer_unique_id
    having count(o.order_id) >= 1)
select
    case
        when order_count = 1 then 'One-time buyer'
        else 'Repeat buyer'
    end as buyer_type,
    format(count(*), 0) as number_of_customers
from customer_orders
group by
    case
        when order_count = 1 then 'One-time buyer'
        else 'Repeat buyer'
    end
order by count(*) desc;
