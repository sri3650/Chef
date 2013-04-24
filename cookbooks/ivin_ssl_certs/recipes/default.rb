#
# Cookbook Name:: ivin_ssl_certs
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

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
  # not_if { ::File.exists?("#{ssl_cert_path}/cert/#{node[:ivin_application][:server_name]}.crt") } ask arun
end

cookbook_file "#{ssl_cert_path}/private/ivin_#{node.chef_environment}.key" do
  source "ssl_credentials/#{node.chef_environment}/ivin_#{node.chef_environment}.key"
  mode "644"
  # not_if { ::File.exists?("#{ssl_cert_path}/private/ivin_#{node.chef_environment}.key") } ask arun
end