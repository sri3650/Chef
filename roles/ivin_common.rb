name "ivin_common"

description "Common features shared across IVIN servers"

run_list [
  "recipe[common_apts]",
  "recipe[ivin_users]",
  "recipe[ivin_common_dirs]",
  "recipe[ivin_gems]",
  "recipe[ossec]",
  "recipe[postfix]",
  "recipe[ivin_monit]"
]