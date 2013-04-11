name "app_server"

description "Application server essentials of IVIN"

run_list [
  "recipe[ivin_apts]",
  "recipe[sphinx]",
  "recipe[prince]",
  "recipe[openoffice3.1.1]",
  "recipe[ivin_appserver_dirs]",
  "recipe[ivin_appserver_monit]"
]