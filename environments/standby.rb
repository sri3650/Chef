name "standby"
description "Standby Environment of IVIN"

default_attributes "ivin_application" => {
  "branch" => "r3_standby",
  "server_name" => "ivinstandby.chronus.com",
  "sellers_server_name" => "sellersstandby.chronus.com",
  "idf_server_name" => "idfstandby.chronus.com",
  "smtp_sasl_mailgun_user_name" => "postmaster@chronus.com",
  "smtp_sasl_mailgun_passwd" => "7ebn-8t4iqa0",
  "mailgun_domain_name" => "chronus.com"
}