name "patent_db_db"

description "Database of IVIN Patent DB"

run_list [
  "recipe[mysql]",
  "recipe[patentdb_mysql_config]"
]