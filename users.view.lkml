view: users {
  sql_table_name: demo_db.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [ 20, 30, 40, 50, 60, 70, 80 ]
    style: integer
    sql: ${age} ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: region {
    case: {
      when: {
        sql: ${state} in ('Washington','Oregon','Idaho','Montana',
        'Wyoming','Colorado','Utah','Nevada','California','Alaska','Hawaii') ;;
        label: "West"
      }
      when: {
        sql: ${state} in ('Arizona','New Mexico','Texas','Oklahoma') ;;
        label: "Southwest"
      }
      when: {
        sql: ${state} in ('North Dakota','South Dakota','Nebraska','Minnesota',
        'Iowa','Missouri','Illinois','Michigan','Indiana','Ohio','Kansas','Wisconsin') ;;
        label: "Midwest"
      }
      when: {
        sql: ${state} in ('Arkansas','Louisiana','Kentucky','Tennessee',
        'Mississippi','Alabama','Florida','Georgia','South Carolina',
        'North Carolina','Virginia','West Virginia') ;;
        label: "South"
      }
      when: {
        sql: ${state} in ('Maryland','Delaware','New Jersey','Pennsylvania',
        'New York','Connecticut','Rhode Island','Massachusetts',
        'Vermont','New Hampshire','Maine','District of Columbia') ;;
        label: "Northeast"
      } } }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      last_name,
      first_name,
      events.count,
      orders.count,
      user_data.count
    ]
  }
}
