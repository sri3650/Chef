name "app_server"

description "Application server essentials of IVIN"

run_list [
  "recipe[ivin_apts]",
  "recipe[sphinx]"
]