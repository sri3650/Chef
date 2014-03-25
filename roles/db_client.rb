name "db_client"

description "Cloud Database of IVIN"

run_list [
  "recipe[mysql::client]",
  "recipe[ivin_mysql_config]",
  "recipe[database_backup::mysql_full_backup]"
]

override_attributes(
  'ivin_mysql' => {
    'reload_action' => "none"
  }
)