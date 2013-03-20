name "ivin_common"

description "Common features shared across IVIN servers"

run_list [
  "recipe[common_apts]",
  "recipe[ivin_users]"
]