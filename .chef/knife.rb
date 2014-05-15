current_dir = File.dirname(__FILE__)

# Setting appropriate organisation based on environment
org_name = case ENV['CHEF_ENV']
           when 'production'
             'chro'
           when 'standby'
             'ivin-standby'
           else
             'ivin-staging'
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
knife[:aws_access_key_id]     = "AKIAJE2B5LGECCP4EGEA"
knife[:aws_secret_access_key] = "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"
knife[:distro] = "ubuntu12.04-ruby20"
chef_client_path '/usr/local/bin/chef-client'
