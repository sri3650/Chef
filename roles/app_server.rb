name "app_server"

description "Application server essentials of IVIN"

run_list [
  "recipe[ivin_apts]",
  "recipe[sphinx]",
  "recipe[ivin_appserver_monit]"
]