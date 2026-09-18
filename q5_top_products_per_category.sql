-- 5. top 3 products within each category by revenue
with product_revenue as (select
        p.product_category_name,
        oi.product_id,
        sum(oi.price) as revenue
    from order_items oi
    join products p
        on oi.product_id = p.product_id
    group by
        p.product_category_name,
        oi.product_id),
ranked_products as (select
        product_category_name,
        product_id,
        revenue,
        row_number() over (
            partition by product_category_name
            order by revenue desc) as product_rank
    from product_revenue)
select
    product_category_name,
    product_id,
    format(revenue, 2) as product_revenue,
    product_rank
from ranked_products
where product_rank <= 3
order by product_category_name, product_rank;
