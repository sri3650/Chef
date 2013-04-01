#
# Cookbook Name:: ivin_webserver_dirs
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute "Create the nginx log directory" do
  command "mkdir -p /mnt/log/nginx && chown app:app /mnt/log/nginx"  
  not_if { ::File.exists?("/mnt/log/nginx") }
end

cookbook_file "/etc/init.d/nginx" do
  source "nginx-init"
  owner "root"
  group "root"
  mode "755"
end

template "/etc/logrotate.d/nginx" do
  source "nginx.erb" 
  owner "root"
  group "root"
  mode "644"
end

template "/etc/cron.daily/logrotate_post" do
  source "logrotate_post.erb"
  owner "root"
  group "root"
  mode "755"
end

ssl_cert_path = node.default[:ivin_application][:ssl_certificate_path]
execute "Create the ssl private directory" do
  command "mkdir -p #{ssl_cert_path}/private/ && chown root:root #{ssl_cert_path}/private/"  
  not_if { ::File.exists?("#{ssl_cert_path}/private/") }
end

execute "Create the ssl cert directory" do
  command "mkdir -p #{ssl_cert_path}/cert/ && chown root:root #{ssl_cert_path}/cert/"  
  not_if { ::File.exists?("#{ssl_cert_path}/cert/") }
end

cookbook_file "#{ssl_cert_path}/cert/#{node[:ivin_application][:server_name]}.crt" do
  source "ssl_credentials/#{node.chef_environment}/#{node[:ivin_application][:server_name]}.crt"
  mode "644"  
end

cookbook_file "#{ssl_cert_path}/private/ivin_#{node.chef_environment}.key" do
  source "ssl_credentials/#{node.chef_environment}/ivin_#{node.chef_environment}.key"
  mode "644"
end

# template "/usr/local/chronus/bin/passenger_monitor.sh" do
#   source 'passenger_monitor.sh.erb'
#   owner "root"
#   group "root"
#   mode 0755  
# end

#ask arun abt the last one here