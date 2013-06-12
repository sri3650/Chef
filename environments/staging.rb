name "staging"
description "Staging Environment of IVIN"

default_attributes "ivin_application" => {
  "branch" => "r3_staging",
  "server_name" => "ivin.chronus.com",
  "smtp_sasl_mailgun_user_name" => "postmaster@chronus.com",
  "smtp_sasl_mailgun_passwd" => "7ebn-8t4iqa0"
}