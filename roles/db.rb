name "db"

description "Database of IVIN"

run_list [
  "recipe[mysql]",
  "recipe[ivin_mysql_config]",
  "recipe[database_backup]"
]