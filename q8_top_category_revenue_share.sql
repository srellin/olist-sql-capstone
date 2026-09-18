-- 8. what percent of total revenue comes from the top category?
with category_revenue as (
    select
        p.product_category_name,
        sum(oi.price) as revenue
    from order_items oi
    join products p
        on oi.product_id = p.product_id
    group by p.product_category_name
)
select
    product_category_name,
    format(revenue, 2) as category_revenue,
    concat(
        format(revenue / sum(revenue) over () * 100, 2),
        '%'
    ) as percent_of_total_revenue
from category_revenue
order by revenue desc
limit 1;
