name "patent_db_app_server"

description "Application server essentials of IVIN Patent DB"

run_list [
  "recipe[sphinx]"
]