name "patent_db_web_server"

description "Web server essentials of IVIN Patent DB"

run_list [
  "recipe[ivin_webserver_dirs]",
  "recipe[passenger::daemon]",
  "recipe[ivin_webserver_monit]",
  "recipe[patent_db_webserver_config]"
]