name "standby"
description "Standby Environment of IVIN"

default_attributes "ivin_application" => {
  "branch" => "r3_standby",
  "server_name" => "ivinstandby.ivinchronus.com",
  "sellers_server_name" => "sellersstandby.ivinchronus.com",
  "idf_server_name" => "idfstandby.ivinchronus.com",
  "smtp_sasl_mailgun_user_name" => "postmaster@ivinchronus.com",
  "mailgun_domain_name" => "ivinchronus.com",
  "credentials_bucket" => { :bucket_name      => "ivin-standby-credentials",
                            :credentials      => "standby_credentials", 
                            :paperclip        => "standby_paperclip_s3",
                            :amazon_s3        => "standby_amazon_s3",
                            :bucket_base_name => "backup-ivin-standby"}
}