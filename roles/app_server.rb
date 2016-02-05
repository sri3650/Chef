name "app_server"

description "Application server essentials of IVIN"

run_list [
  "recipe[ivin_apts]",
  "recipe[ivin_appserver_dirs]",
  "recipe[prince]",
  "recipe[openoffice]",
  "recipe[ivin_appserver_monit]",
  "recipe[perl]",
  "recipe[phantomjs]"
]