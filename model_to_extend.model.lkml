connection: "the_look"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

explore: order_base {
  from: orders
  view_name: orders
  # fields: [ALL_FIELDS*, -users.order_created_day_of_week, -users.order_created_date]
  join: users {
    relationship: many_to_one
    sql_on: ${users.id} = ${orders.user_id} ;;
  }
}
