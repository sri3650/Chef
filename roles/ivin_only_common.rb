name "ivin_only_common"

description "Common features shared across IVIN servers"

run_list [
  "recipe[ivin_only_common_dirs]"
]