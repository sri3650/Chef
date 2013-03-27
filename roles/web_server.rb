name "web_server"

description "Web server essentials of IVIN"

run_list [
  "recipe[ivin_webserver_dirs]",
  "recipe[passenger::daemon]",
  "recipe[redis::server]",
  "recipe[ivin_webserver_monit]"
]