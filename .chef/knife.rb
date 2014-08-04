current_dir = File.dirname(__FILE__)

# Setting appropriate organisation based on environment
org_name =  if ENV['CHEF_ENV'] == 'production'
              'chro'
            else
              raise Exception.new("Invalid CHEF_ENV value")
            end

log_level                :info
log_location             STDOUT
node_name                "ivin_chef"
client_key               "#{current_dir}/ivin_chef.pem"
validation_client_name   "#{org_name}-validator"
validation_key           "#{current_dir}/#{org_name}-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/#{org_name}"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]
knife[:aws_access_key_id]     = "AKIAIMHPKTVTY6BTWOHQ"
knife[:aws_secret_access_key] = "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"
knife[:distro] = "ubuntu12.04-ruby20"
chef_client_path '/usr/local/bin/chef-client'
