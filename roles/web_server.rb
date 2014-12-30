name "web_server"

description "Web server essentials of IVIN"

run_list [
  "recipe[ivin_webserver_dirs]",
  "recipe[ivin_ssl_certs]",
  "recipe[redis]",
  "recipe[ivin_webserver_monit]",
  "recipe[ivin_webserver_config]",
  "recipe[passenger::daemon]"
]