name "production"
description "Production Environment of IVIN"

default_attributes "ivin_application" => {
  "branch" => "r3_production",
  "server_name" => "ivin.intven.com"
}