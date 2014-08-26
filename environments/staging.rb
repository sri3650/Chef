name "staging"
description "Staging Environment of IVIN"

default_attributes "ivin_application" => {
  "branch" => "r3_staging",
  "server_name" => "ivin.ivinchronus.com",
  "sellers_server_name" => "sellers.ivinchronus.com",
  "idf_server_name" => "idf.ivinchronus.com",
  "smtp_sasl_mailgun_user_name" => "postmaster@ivinchronus.com",
   "mailgun_domain_name" => "ivinchronus.com"
}