name "db"

description "Database of IVIN"

run_list [
  "recipe[mysql]"
]