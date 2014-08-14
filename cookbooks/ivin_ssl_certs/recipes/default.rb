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

secret = Chef::EncryptedDataBagItem.load_secret("/etc/chef/encrypted_data_bag_secret")
temp = Chef::EncryptedDataBagItem.load("ssl_certs", "#{node.chef_environment}", secret)


template "#{ssl_cert_path}/cert/#{node[:ivin_application][:server_name]}.crt" do
  variables(:ivin_com_crt => temp["ivin_com_crt"])
  source "ssl_credentials/#{node.chef_environment}/#{node[:ivin_application][:server_name]}.crt.erb"
  mode "644"
end

template "#{ssl_cert_path}/private/ivin_#{node.chef_environment}.key" do
  variables(:ivin_key => temp["ivin_key"])
  source "ssl_credentials/#{node.chef_environment}/ivin_#{node.chef_environment}.key.erb"
  mode "644"
end

template "#{ssl_cert_path}/cert/#{node[:ivin_application][:sellers_server_name]}.crt" do
 variables(:sellers_com_crt => temp["sellers_com_crt"])
  source "ssl_credentials/#{node.chef_environment}/#{node[:ivin_application][:sellers_server_name]}.crt.erb"
  mode "644"
end

template "#{ssl_cert_path}/private/sellers_#{node.chef_environment}.key" do
  variables(:sellers_key => temp["sellers_key"])
  source "ssl_credentials/#{node.chef_environment}/sellers_#{node.chef_environment}.key.erb"
  mode "644"
end

template "#{ssl_cert_path}/cert/#{node[:ivin_application][:idf_server_name]}.crt" do
  variables(:idf_com_crt => temp["idf_com_crt"])
  source "ssl_credentials/#{node.chef_environment}/#{node[:ivin_application][:idf_server_name]}.crt.erb"
  mode "644"
end

template "#{ssl_cert_path}/private/idf_#{node.chef_environment}.key" do
  variables(:idf_key => temp["idf_key"])
  source "ssl_credentials/#{node.chef_environment}/idf_#{node.chef_environment}.key.erb"
  mode "644"
end