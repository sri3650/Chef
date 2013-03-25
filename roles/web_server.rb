name "web_server"

description "Web server essentials of IVIN"

run_list [
  "recipe[ivin_webserver_dirs]",
  "recipe[passenger::daemon]"
]