view: user_order_facts {
   derived_table: {
    sql: SELECT
         user_id as user_id,
         COUNT(*) as lifetime_orders,
         MAX(orders.created_at) as latest_order_date,
         MIN(orders.created_at) as first_order_date,
         DATEDIFF(MIN(orders.created_at,now()) as days_since_first_purchase,
         CASE WHEN (COUNT(orders.created_at) > 1) THEN "Yes" ELSE "No" END as repeat_customer,
       FROM orders
       GROUP BY user_id
       ;;
   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
 }
