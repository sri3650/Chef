name "standby"
description "Standby Environment of IVIN"

# secret = Chef::EncryptedDataBagItem.load_secret("/etc/chef/encrypted_data_bag_secret")
# sasl_mailgun_passwd= Chef::EncryptedDataBagItem.load("env_staging", "smtp_sasl_mailgun_passwd", secret)

default_attributes "ivin_application" => {
  "branch" => "r3_standby",
  "server_name" => "ivinstandby.ivinchronus.com",
  "sellers_server_name" => "sellersstandby.ivinchronus.com",
  "idf_server_name" => "idfstandby.ivinchronus.com",
  "smtp_sasl_mailgun_user_name" => "postmaster@ivinchronus.com",
  "smtp_sasl_mailgun_passwd" => "659pmhlqj718",
  # "smtp_sasl_mailgun_passwd" => sasl_mailgun_passwd["password"],
  "mailgun_domain_name" => "ivinchronus.com"
}