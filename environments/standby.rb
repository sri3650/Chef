name "standby"
description "Standby Environment of IVIN"


default_attributes "ivin_application" => {
  "branch" => "r3_standby",
  "server_name" => "ivinstandby.ivinchronus.com",
  "sellers_server_name" => "sellersstandby.ivinchronus.com",
  "idf_server_name" => "idfstandby.ivinchronus.com",
  # "smtp_sasl_mailgun_user_name" => "file_standby"
  "mailgun_domain_name" => "ivinchronus.com"
}