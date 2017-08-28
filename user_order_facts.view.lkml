view: user_order_facts {
   derived_table: {
    sql: SELECT
         user_id as user_id,
         COUNT(*) as lifetime_orders,
         MAX(orders.created_at) as latest_date,
         MIN(orders.created_at) as first_date,
         DATEDIFF(MIN(orders.created_at,now()) as days_since_first,
         CASE WHEN (COUNT(orders.created_at) > 1) THEN "Yes" ELSE "No" END as repeat,
       FROM orders
       GROUP BY user_id
       ;;
   }

   # Define your dimensions and measures here, like this:
   dimension: user_id {
     type: number
     sql: ${TABLE}.user_id ;;
   }

   dimension: lifetime_orders {
     type: number
     sql: ${TABLE}.lifetime_orders ;;
   }

   dimension_group: most_recent_purchase {
     type: time
     timeframes: [date, week, month, year]
     sql: ${TABLE}.latest_date ;;
   }

   dimension_group: first_purchase {
     type: time
     timeframes: [date, week, month, year]
     sql: ${TABLE}.first_date ;;
   }

  dimension: repeat_customer {
    type: yesno
    sql: ${TABLE}.repeat ;;
  }

   measure: total_lifetime_orders {
     type: sum
     sql: ${lifetime_orders} ;;
   }
 }
