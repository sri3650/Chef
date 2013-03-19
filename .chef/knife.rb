current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "ivin_chef"
client_key               "#{current_dir}/ivin_chef.pem"
validation_client_name   "chro-validator"
validation_key           "#{current_dir}/chro-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/chro"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]
knife[:aws_access_key_id]     = "AKIAICKFZHGS3GMK4WYA"
knife[:aws_secret_access_key] = "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"
chef_client_path '/usr/local/bin/chef-client'
