name "production"
description "Production Environment of IVIN"

default_attributes "ivin_application" => {
  "branch" => "r3_production",
  "server_name" => "ivin.intven.com",
  "sellers_server_name" => "sellers.intven.com",
  "idf_server_name" => "idf.intven.com",
  "smtp_sasl_mailgun_user_name" => "postmaster@intven.com",
  "mailgun_domain_name" => "intven.com",
  "credentials_bucket" => { :bucket_name      => "ivin-prod-credentials",
                            :credentials      => "production_credentials", 
                            :paperclip        => "production_paperclip_s3",
                            :amazon_s3        => "production_amazon_s3",
                            :bucket_base_name => "backup-ivin-production"}
}