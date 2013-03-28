name "staging"
description "Staging Environment of IVIN"

default_attributes "ivin_application" => {
  "branch" => "r3_staging",
  "server_name" => "ivin.chronus.com"
}