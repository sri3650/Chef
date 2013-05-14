name "patent_db_only"

description "Misc Features only pertinent to Patent DB servers"

run_list [
  "recipe[patent_db_only_common_dirs]"
]