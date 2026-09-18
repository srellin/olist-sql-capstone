-- 4. product categories generating the most revenue

select
    p.product_category_name,
    format(sum(oi.price), 2) as category_revenue
from order_items oi
join products p
    on oi.product_id = p.product_id
group by p.product_category_name
order by sum(oi.price) desc;
