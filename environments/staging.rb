name "staging"
description "Staging Environment of IVIN"

default_attributes "ivin_application" => {
  "branch" => "r3_staging",
  "server_name" => "ivin.ivinchronus.com",
  "sellers_server_name" => "sellers.ivinchronus.com",
  "idf_server_name" => "idf.ivinchronus.com",
  "smtp_sasl_mailgun_user_name" => "postmaster@ivinchronus.com",
  "mailgun_domain_name" => "ivinchronus.com",
  "credentials_bucket" => { :bucket_name => "ivin-stag-credentials",
                            :credentials => "stag_credentials.yml", 
                            :paperclip   => "stag_paperclip_s3.yml",
                            :s3          => "stag_s3.yml",
                            :amazon_s3   => "staging_amazon_s3.yml"]}
}