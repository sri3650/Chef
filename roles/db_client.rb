name "db_client"

description "Cloud Database of IVIN"

run_list [
  "recipe[mysql][client]",
  "recipe[mysql_full_backup]"
]