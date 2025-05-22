select order_id, customer_id,total_amount
from(
select *, 
ROW_NUMBER() over(partition by customer_id order by total_amount desc) as rn
from orders
) sub where rn<=2;