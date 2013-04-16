name "ivin_cron"

description "crons for IVIN application"

run_list [
  "recipe[ivin_crons]"
]