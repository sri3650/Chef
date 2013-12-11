name "db_client"

description "Cloud Database of IVIN"

run_list [
  "recipe[mysql::client]",
  "recipe[database_backup::mysql_full_backup]"
]