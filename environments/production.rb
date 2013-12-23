name "production"
description "Production Environment of IVIN"

default_attributes "ivin_application" => {
  "branch" => "r3_production",
  "server_name" => "ivin.intven.com",
  "sellers_server_name" => "sellers.intven.com",
  "idf_server_name" => "idf.intven.com",
  "smtp_sasl_mailgun_user_name" => "postmaster@intven.com",
  "smtp_sasl_mailgun_passwd" => "62v32xayva-4"
}