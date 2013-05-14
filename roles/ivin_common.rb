name "ivin_common"

description "Common features shared across IVIN Team servers (IVIN and Patent DB)"

run_list [
  "recipe[common_apts]",
  "recipe[ivin_users]",
  "recipe[ivin_common_dirs]",
  "recipe[ivin_gems]",
  "recipe[ossec]",
  "recipe[postfix]",
  "recipe[ivin_monit]"
]